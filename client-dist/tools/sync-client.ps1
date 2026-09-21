<#
  sync-client.ps1 —— 把 client-dist 里的插件 + 汉化数据同步到客户端目录

  玩家/客户一般不用直接跑它，而是：
    * 服务器脚本 start.cmd（拉代码 + 编译 + 更新客户端 + 启动）会自动调用；
    * 或者双击 tools\更新客户端.bat。

  用法：
    powershell -NoProfile -ExecutionPolicy Bypass -File sync-client.ps1
    powershell ... -File sync-client.ps1 -ClientDir "D:\game\origin-client"
    powershell ... -File sync-client.ps1 -DryRun      # 只看要改什么，不动文件
    powershell ... -File sync-client.ps1 -Verify      # 校验客户端现在是不是最新
    powershell ... -File sync-client.ps1 -NoData      # 只更新插件，不动 wz/img
    powershell ... -File sync-client.ps1 -Force       # 忽略客户端主程序校验

  客户端目录怎么定（按顺序找，第一个有效的就用）：
    1. -ClientDir 参数
    2. 环境变量 GMS053_CLIENT_DIR
    3. client-dist\client-dir.txt（本脚本上次找到后自己记下的）
    4. 自动找：<包根>\step3client\origin-client 等常见位置
    5. 挨个问用户，确认后记进 client-dir.txt

  退出码：0 = 成功（含"已经是最新"）；1 = 出错；2 = 没找到客户端目录
#>
[CmdletBinding()]
param(
    [string]$ClientDir = '',
    [switch]$DryRun,
    [switch]$Verify,
    [switch]$Force,
    [switch]$NoData,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

$ToolsDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$Dist       = Split-Path -Parent $ToolsDir
$Manifest   = Join-Path $Dist 'client-dist.txt'
$Sums       = Join-Path $Dist 'client-dist.sha256'
$PinnedFile = Join-Path $Dist 'client-dir.txt'

function Join2($a, $b) { Join-Path $a $b }

# 清单里的路径是 "plugin/Hook.dll" / "data/wz/String.wz"（相对 client-dist）；
# 同步到客户端时要先去掉分组前缀：Hook.dll / wz/String.wz
function Get-RelTarget {
    param([string]$Rel)
    $i = $Rel.IndexOf('/')
    if ($i -lt 0) { return $Rel }
    return $Rel.Substring($i + 1)
}

function Say {
    param([string]$msg = '', [string]$color = 'Gray')
    if (-not $Quiet) { Write-Host $msg -ForegroundColor $color }
}
function Warn([string]$msg) { Write-Host ('[警告] ' + $msg) -ForegroundColor Yellow }
function Fail([string]$msg) { Write-Host ('[错误] ' + $msg) -ForegroundColor Red }

$script:Log = New-Object System.Collections.Generic.List[string]
function Log([string]$msg) {
    $script:Log.Add(('{0}  {1}' -f (Get-Date -Format 'HH:mm:ss'), $msg))
}

# ---------------------------------------------------------------- 读清单
function Read-KeyValue {
    param([string]$Path)
    $map = @{}
    if (-not (Test-Path -LiteralPath $Path)) { return $map }
    foreach ($line in (Get-Content -LiteralPath $Path -Encoding UTF8)) {
        $t = $line.Trim()
        if ($t -eq '' -or $t.StartsWith('#') -or $t.StartsWith(';')) { continue }
        $i = $t.IndexOf('=')
        if ($i -lt 1) { continue }
        $map[$t.Substring(0, $i).Trim().ToLower()] = $t.Substring($i + 1).Trim()
    }
    return $map
}
function MetaValue {
    param($Map, [string]$Key, [string]$Default = '')
    if ($Map.ContainsKey($Key)) { return [string]$Map[$Key] }
    return $Default
}
function HashOf {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) { return '' }
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLower()
}

if (-not (Test-Path -LiteralPath $Manifest)) { Fail ('找不到清单：' + $Manifest); exit 1 }
if (-not (Test-Path -LiteralPath $Sums))     { Fail ('找不到文件清单：' + $Sums + '（维护者要跑 tools\make-manifest.ps1）'); exit 1 }

$meta    = Read-KeyValue $Manifest
$version = MetaValue $meta 'version' '?'
$tag     = MetaValue $meta 'tag' ''
$notes   = MetaValue $meta 'notes' ''
$keepList = @()
$kk = MetaValue $meta 'keep_existing' ''
if ($kk) { $keepList = @($kk -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }) }
$exeNames = @('GMSv053.exe', 'MapleStory.exe', 'GMS053.exe', 'MapleStoryV053.exe', 'GMSv53.exe', 'MapleStory-sorce.exe')
$en = MetaValue $meta 'client_exe' ''
if ($en) { $exeNames = @($en -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }) }
$exeHash  = (MetaValue $meta 'client_exe_sha256' '').ToLower()
$exeSize  = MetaValue $meta 'client_exe_size' ''
$exeStrict = MetaValue $meta 'client_exe_strict' '0'
$backupKeep = 5
$bk = MetaValue $meta 'backup_keep' '5'
if ($bk -match '^\d+$') { $backupKeep = [int]$bk }

# ---------------------------------------------------------------- 待同步的文件
$want = New-Object System.Collections.Generic.List[object]
foreach ($line in (Get-Content -LiteralPath $Sums -Encoding UTF8)) {
    $t = $line.Trim()
    if ($t -eq '' -or $t.StartsWith('#')) { continue }
    if ($t -match '^([0-9a-fA-F]{64})\s+(.+)$') {
        $rel = $Matches[2].Trim()
        if ($NoData -and $rel.StartsWith('data/')) { continue }
        $want.Add([pscustomobject]@{
            Rel  = $rel
            Hash = $Matches[1].ToLower()
            Src  = (Join-Path $Dist ($rel -replace '/', '\'))
            Group = $(if ($rel.StartsWith('plugin/')) { 'plugin' } else { 'data' })
        })
    }
}
if ($want.Count -eq 0) { Fail '文件清单是空的，先跑 tools\make-manifest.ps1。'; exit 1 }

$missingSrc = @($want | Where-Object { -not (Test-Path -LiteralPath $_.Src) })
if ($missingSrc.Count -gt 0) {
    Fail '这些文件在 client-dist 里找不到（清单过期了，跑一下 tools\make-manifest.ps1）：'
    foreach ($m in $missingSrc) { Say ('    ' + $m.Rel) }
    exit 1
}

# ---------------------------------------------------------------- 正在跑游戏就别动
$procs = @(Get-Process -Name 'MapleStory', 'GMSv53', 'GMS053', 'MapleStoryV053', 'Launcher' -ErrorAction SilentlyContinue)
if ($procs.Count -gt 0 -and -not $DryRun) {
    Fail ('客户端/启动器正在运行（' + (($procs | Select-Object -ExpandProperty ProcessName -Unique) -join ',') + '），文件被占用，请先关闭游戏。')
    exit 1
}

# ---------------------------------------------------------------- 找客户端目录
function Get-ExeIn {
    param([string]$Dir)
    if ([string]::IsNullOrWhiteSpace($Dir)) { return '' }
    if (-not (Test-Path -LiteralPath $Dir)) { return '' }
    foreach ($n in $exeNames) {
        if (Test-Path -LiteralPath (Join-Path $Dir $n)) { return $n }
    }
    return ''
}
function Resolve-ClientPath {
    param([string]$Dir)
    if (-not (Test-Path -LiteralPath $Dir)) { return '' }
    try { return (Resolve-Path -LiteralPath $Dir).Path } catch { return '' }
}

$clientRoot = ''
$clientExe  = ''
$fromWhere  = ''

function Try-Path {
    param([string]$Dir, [string]$Where)
    if ([string]::IsNullOrWhiteSpace($Dir)) { return $false }
    $exe = Get-ExeIn $Dir
    if ($exe -eq '') { return $false }
    $script:clientRoot = Resolve-ClientPath $Dir
    $script:clientExe  = $exe
    $script:fromWhere  = $Where
    return $true
}

if ($ClientDir -ne '') { [void](Try-Path $ClientDir '参数 -ClientDir') }
if ($clientRoot -eq '' -and $env:GMS053_CLIENT_DIR) { [void](Try-Path $env:GMS053_CLIENT_DIR '环境变量 GMS053_CLIENT_DIR') }
if ($clientRoot -eq '' -and (Test-Path -LiteralPath $PinnedFile)) {
    $pinned = (Get-Content -LiteralPath $PinnedFile -Encoding UTF8 | Select-Object -First 1)
    if ($pinned) { [void](Try-Path $pinned.Trim() 'client-dir.txt') }
    if ($clientRoot -eq '') { Warn ('client-dir.txt 里记的路径已经无效：' + $pinned) }
}

if ($clientRoot -eq '') {
    # 常见位置：<包根>\step3client\origin-client（包根 = client-dist\..\..\..）
    $pkgRoot = $Dist
    foreach ($up in 1..3) { $pkgRoot = Split-Path -Parent $pkgRoot }
    $cands = @(
        (Join2 $pkgRoot 'step3client\origin-client'),
        (Join2 $pkgRoot 'step3client\client'),
        (Join2 $pkgRoot 'origin-client'),
        (Join2 (Split-Path -Parent $Dist) 'origin-client'),
        (Join2 (Split-Path -Parent (Split-Path -Parent $Dist)) 'origin-client')
    )
    foreach ($c in $cands) {
        if (Try-Path $c '自动找到') { break }
    }
    # 还找不到：在包根下浅扫一层，找任何含客户端 exe 的目录（跳过巨大的 source / 数据库目录）
    if ($clientRoot -eq '' -and (Test-Path -LiteralPath $pkgRoot)) {
        $skip = @('source', 'step1db', 'Data', 'wz', '.git', 'PortableGit', 'jdk-21.0.2', 'client-dist')
        try {
            $dirs = @(Get-ChildItem -LiteralPath $pkgRoot -Directory -Recurse -Depth 2 -ErrorAction SilentlyContinue |
                      Where-Object { $skip -notcontains $_.Name })
            foreach ($dd in $dirs) {
                if (Try-Path $dd.FullName '自动找到') { break }
            }
        } catch { }
    }
}

if ($clientRoot -eq '') {
    Say ''
    Warn '没有找到客户端目录（要找一个里面有 MapleStory.exe / GMSv53.exe 的文件夹）。'
    Say  '  常见位置是：<包根>\step3client\origin-client'
    Say  '  你也可以在 config.cmd 里写死：CLIENT_DIR=D:\game\origin-client'
    Say  '  或者现在把客户端文件夹的路径粘进来（直接回车跳过）。'
    if (-not [Environment]::UserInteractive) { exit 2 }
    for ($try = 1; $try -le 3; $try++) {
        $ans = Read-Host '  客户端目录'
        if ([string]::IsNullOrWhiteSpace($ans)) { break }
        $ans = $ans.Trim('"').Trim()
        if (Try-Path $ans '手动指定') { break }
        Warn ('这个目录里没有客户端主程序（' + ($exeNames -join ' / ') + '）：' + $ans)
    }
    if ($clientRoot -eq '') { Fail '没有可用的客户端目录，已放弃。'; exit 2 }
}

# 记下来，下次不用再找
if ($fromWhere -ne 'client-dir.txt' -and -not $DryRun) {
    try { [System.IO.File]::WriteAllText($PinnedFile, ($clientRoot + "`r`n"), (New-Object System.Text.UTF8Encoding($false))) } catch { }
}

Say ''
Say '============================================================' 'Cyan'
Say ('  客户端插件/汉化数据 更新   v' + $version + $(if ($tag) { '  (' + $tag + ')' } else { '' })) 'Cyan'
Say '------------------------------------------------------------' 'Cyan'
Say ('  客户端目录 : ' + $clientRoot + '   [' + $fromWhere + ']')
Say ('  主程序     : ' + $clientExe)
Say ('  清单       : ' + ([System.IO.Path]::GetFileName($Sums)) + '（' + $want.Count + ' 个文件' + $(if ($NoData) { '，本次跳过 data/' } else { '' }) + '）')
if ($notes) { Say ('  说明       : ' + $notes) }
Say '============================================================' 'Cyan'

# ---------------------------------------------------------------- 客户端主程序校验
$exePath = Join-Path $clientRoot $clientExe
if ($exeHash -ne '') {
    $nowHash = HashOf $exePath
    if ($nowHash -ne $exeHash) {
        Warn ('客户端主程序和清单里登记的版本不一致：' + $clientExe)
        Say  ('      登记 : ' + $exeHash + '   ' + $exeSize + ' 字节')
        Say  ('      现在 : ' + $nowHash + '   ' + (Get-Item -LiteralPath $exePath).Length + ' 字节')
        Say  '      插件的补丁地址是针对特定客户端版本逆向的，版本不对可能会崩。'
        if ($exeStrict -eq '1' -and -not $Force) { Fail '要强行继续请加 -Force。'; exit 1 }
    }
}

# ---------------------------------------------------------------- 算目标 + 比对
function Get-Target {
    param([string]$Root, [string]$Rel)
    $mirror = Join-Path $Root ($Rel -replace '/', '\')
    # 已存在的文件优先：有的客户端把 wz 放在根目录而不是 wz\ 子目录
    if (Test-Path -LiteralPath $mirror) { return $mirror }
    $alt = Join-Path $Root (Split-Path -Leaf $mirror)
    if (Test-Path -LiteralPath $alt) { return $alt }
    # 两处都没有：按清单里的相对路径建（wz\ 这类目录会自动创建）
    return $mirror
}

$plan = New-Object System.Collections.Generic.List[object]
foreach ($w in $want) {
    $relTarget = Get-RelTarget $w.Rel
    $leaf = Split-Path -Leaf ($relTarget -replace '/', '\')
    $keep = $false
    foreach ($k in $keepList) { if ($leaf -ieq $k) { $keep = $true } }
    $target = Get-Target $clientRoot $relTarget
    $show = $target
    if ($show.StartsWith($clientRoot)) { $show = $show.Substring($clientRoot.Length).TrimStart('\') }
    $exists = Test-Path -LiteralPath $target
    $same = $false
    if ($exists) { $same = ((HashOf $target) -eq $w.Hash) }
    $state = 'add'
    if ($exists) {
        if ($same) { $state = 'same' }
        elseif ($keep) {
            # 上次已经把新默认值写成 <名字>.new 了就不重复提示
            $newSibling = $target + '.new'
            if ((Test-Path -LiteralPath $newSibling) -and ((HashOf $newSibling) -eq $w.Hash)) { $state = 'same' }
            else { $state = 'keep' }
        }
        else { $state = 'update' }
    }
    $plan.Add([pscustomobject]@{
        Rel = $w.Rel; RelTarget = $relTarget; Show = $show; Src = $w.Src; Target = $target; Hash = $w.Hash
        Exists = $exists; Same = $same; Keep = $keep; State = $state; Group = $w.Group
    })
}

$toAdd    = @($plan | Where-Object { $_.State -eq 'add' })
$toUpdate = @($plan | Where-Object { $_.State -eq 'update' })
$toKeep   = @($plan | Where-Object { $_.State -eq 'keep' })
$sameCnt  = @($plan | Where-Object { $_.State -eq 'same' }).Count

Say ''
if ($toAdd.Count -eq 0 -and $toUpdate.Count -eq 0) {
    Say ('  客户端已经是最新的（' + $sameCnt + ' 个文件全部一致' + $(if ($toKeep.Count -gt 0) { '，' + $toKeep.Count + ' 个你自己改过的已保留' } else { '' }) + '）。') 'Green'
} else {
    Say ('  需要新增 ' + $toAdd.Count + ' 个，更新 ' + $toUpdate.Count + ' 个，未变 ' + $sameCnt + ' 个。')
    $list = @($toUpdate + $toAdd)
    $maxShow = 20
    for ($i = 0; $i -lt $list.Count -and $i -lt $maxShow; $i++) {
        $p = $list[$i]
        $mark = $(if ($p.State -eq 'update') { '更新' } else { '新增' })
        Say ('    [' + $mark + '] ' + $p.Show)
    }
    if ($list.Count -gt $maxShow) { Say ('    ... 还有 ' + ($list.Count - $maxShow) + ' 个（太多就不一条条列了）') 'DarkGray' }
    if ($toKeep.Count -gt 0) {
        foreach ($p in $toKeep) { Say ('    [保留] ' + $p.Show + '（你自己改过的，不会被动）') 'DarkGray' }
    }
}

if ($Verify) { Say ''; Say '  -Verify：只校验，不改文件。' 'DarkGray'; exit 0 }
if ($DryRun) { Say ''; Say '  -DryRun：只报告，不改文件。' 'DarkGray'; exit 0 }

# ---------------------------------------------------------------- 备份目录 + 日志
$stamp     = Get-Date -Format 'yyyyMMdd_HHmmss'
$backupDir = Join-Path $clientRoot '_backup_client'
$backupNow = Join-Path $backupDir $stamp
$logPath   = Join-Path $backupDir ('update_' + $stamp + '.log')

$changed = 0
if ($toAdd.Count -gt 0 -or $toUpdate.Count -gt 0 -or $toKeep.Count -gt 0) {
    if (-not (Test-Path -LiteralPath $backupDir)) { New-Item -ItemType Directory -Path $backupDir -Force | Out-Null }
}

function Copy-One {
    param($Item)
    $targetDir = Split-Path -Parent $Item.Target
    if (-not (Test-Path -LiteralPath $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force | Out-Null }
    if ($Item.Exists) {
        $bak = Join-Path $backupNow ($Item.RelTarget -replace '/', '\')
        $bakDir = Split-Path -Parent $bak
        if (-not (Test-Path -LiteralPath $bakDir)) { New-Item -ItemType Directory -Path $bakDir -Force | Out-Null }
        Copy-Item -LiteralPath $Item.Target -Destination $bak -Force
    }
    $tmp = $Item.Target + '.new'
    Copy-Item -LiteralPath $Item.Src -Destination $tmp -Force
    Move-Item -LiteralPath $tmp -Destination $Item.Target -Force
}

Say ''
$done = 0
$maxLine = 20
foreach ($p in $toUpdate) {
    try {
        Copy-One $p; $changed++; $done++; Log ('update ' + $p.Show)
        if ($done -le $maxLine) { Say ('  [更新] ' + $p.Show) 'Green' }
    } catch { Fail ('替换失败：' + $p.Show + '  ' + $_.Exception.Message); Log ('FAIL ' + $p.Show + ' ' + $_.Exception.Message) }
}
foreach ($p in $toAdd) {
    try {
        Copy-One $p; $changed++; $done++; Log ('add    ' + $p.Show)
        if ($done -le $maxLine) { Say ('  [新增] ' + $p.Show) 'Green' }
    } catch { Fail ('复制失败：' + $p.Show + '  ' + $_.Exception.Message); Log ('FAIL ' + $p.Show + ' ' + $_.Exception.Message) }
}
if ($done -gt $maxLine) { Say ('  ... 一共 ' + $done + ' 个文件，都写进日志了') 'DarkGray' }
foreach ($p in $toKeep) {
    try {
        $newPath = $p.Target + '.new'
        Copy-Item -LiteralPath $p.Src -Destination $newPath -Force
        Log ('keep   ' + $p.Show + ' -> ' + (Split-Path -Leaf $newPath))
        Say ('  [保留] ' + $p.Show + ' 没动；新默认值放在 ' + (Split-Path -Leaf $newPath)) 'Yellow'
        # 顺便告诉用户新版本多了哪些配置项
        try {
            $old = @(Get-Content -LiteralPath $p.Target -Encoding UTF8)
            $new = @(Get-Content -LiteralPath $p.Src -Encoding UTF8)
            $oldKeys = @{}
            foreach ($l in $old) { if ($l -match '^\s*([A-Za-z_][\w]*)\s*=') { $oldKeys[$Matches[1]] = $true } }
            $added = @()
            foreach ($l in $new) { if ($l -match '^\s*([A-Za-z_][\w]*)\s*=') { if (-not $oldKeys.ContainsKey($Matches[1])) { $added += $Matches[1] } } }
            if ($added.Count -gt 0) { Say ('         新版本多了这些配置项（可以手动抄进你的 config.ini）：' + ($added -join ', ')) 'Yellow' }
        } catch { }
    } catch { Warn ('保留处理失败：' + $p.Rel + '  ' + $_.Exception.Message) }
}

# ---------------------------------------------------------------- 版本标记
$markerPath = Join-Path $clientRoot '.gms053-client.txt'
$commit = ''
try {
    $git = Get-Command git.exe -ErrorAction SilentlyContinue
    if (-not $git) { $git = Get-Command git -ErrorAction SilentlyContinue }
    if ($git) {
        $repo = Split-Path -Parent $Dist
        $commit = (& $git.Source -C $repo rev-parse --short HEAD 2>$null)
        if ($commit) { $commit = $commit.Trim() }
    }
} catch { }
$marker = @(
    '# 这个文件由 client-dist\tools\sync-client.ps1 写入：记录客户端当前装的是哪一版插件/数据'
    ('version=' + $version)
    ('tag=' + $tag)
    ('applied=' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
    ('files=' + $want.Count)
    ('changed=' + $changed)
    ('client_exe=' + $clientExe)
    ('source_commit=' + $commit)
)
try { [System.IO.File]::WriteAllLines($markerPath, $marker, (New-Object System.Text.UTF8Encoding($false))) } catch { }

# ---------------------------------------------------------------- 日志 + 清理旧备份
if (Test-Path -LiteralPath $backupDir) {
    Log ('version ' + $version + ' files=' + $want.Count + ' changed=' + $changed + ' client=' + $clientRoot)
    try { [System.IO.File]::WriteAllLines($logPath, $script:Log.ToArray(), (New-Object System.Text.UTF8Encoding($true))) } catch { }
}
if (Test-Path -LiteralPath $backupDir) {
    try {
        $dirs = @(Get-ChildItem -LiteralPath $backupDir -Directory | Sort-Object LastWriteTime -Descending)
        if ($backupKeep -gt 0 -and $dirs.Count -gt $backupKeep) {
            $dirs | Select-Object -Skip $backupKeep | ForEach-Object {
                Remove-Item -LiteralPath $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
                Log ('prune backup ' + $_.Name)
            }
        }
    } catch { }
}

Say ''
Say '------------------------------------------------------------' 'Cyan'
if ($changed -eq 0) {
    Say ('  完成：客户端本来就是最新的（v' + $version + '）。') 'Green'
} else {
    Say ('  完成：更新 ' + $changed + ' 个文件，客户端现在是 v' + $version + '。') 'Green'
    Say ('  旧文件备份在：' + $backupNow) 'Gray'
}
Say ('  记录文件：' + $markerPath) 'Gray'
Say '------------------------------------------------------------' 'Cyan'
Say ''
exit 0