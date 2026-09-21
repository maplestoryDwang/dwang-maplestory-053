<#
  merge-config.ps1 —— 把新版 config.cmd 合并进客户那份：结构/新增项用新版，客户改过的值保留

  为什么需要它：
    config.cmd 是客户唯一可能自己改过的脚本文件（GIT_PROXY 代理、CLIENT_DIR 客户端路径、
    JAVA_RUN_OPTS 内存、EXTRA_ARGS 之类）。直接覆盖会把他的设置悄悄冲掉；丢一个
    config.cmd.new 又等于没升级（客户不会去看）。所以这里自动合并：
      * 新版里的每一项、每段注释都照抄；
      * 客户那项的值和新版默认不一样 -> 保留客户的值，并在上面加一行说明；
      * 客户自己加的项（新版没有的）-> 原样追加到文件末尾；
      * 合并前把旧的备份成 config.cmd.bak-<时间戳>。
    客户什么都没改过时，合并结果 = 新模板本身（就是"直接用新的"）。

  用法（start.cmd / 升级脚本.bat 会自动调）：
    powershell -NoProfile -ExecutionPolicy Bypass -File merge-config.ps1 `
        -Old "<包>\step2\config.cmd" -New "<包>\step2\source\doc\config.cmd"

  退出码：0 = 本来就没变化；1 = 已升级（写了文件）；2 = 出错
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Old,
    [Parameter(Mandatory = $true)][string]$New,
    [switch]$DryRun,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'
$Ansi = [System.Text.Encoding]::GetEncoding(936)      # config.cmd 是 GBK

function Say {
    param([string]$m, [string]$c = 'Gray')
    if (-not $Quiet) { Write-Host $m -ForegroundColor $c }
}
function SetKeyOf {
    param([string]$Line)
    if ($Line -match '^\s*set\s+"?([^=]+?)=(.*?)"?\s*$') { return $Matches[1].Trim() }
    return $null
}
function SetValueOf {
    param([string]$Line)
    if ($Line -match '^\s*set\s+"?([^=]+?)=(.*?)"?\s*$') { return $Matches[2] }
    return $null
}
function Read-Sets {
    param([string[]]$Lines)
    $map = New-Object 'System.Collections.Hashtable' ([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($l in $Lines) {
        $k = SetKeyOf $l
        if ($k -ne $null) { $map[$k] = (SetValueOf $l) }
    }
    return $map
}

if (-not (Test-Path -LiteralPath $Old)) { Say ('[错误] 找不到客户配置：' + $Old) 'Red'; exit 2 }
if (-not (Test-Path -LiteralPath $New)) { Say ('[错误] 找不到新版配置：' + $New) 'Red'; exit 2 }

$oldLines = @([System.IO.File]::ReadAllLines($Old, $Ansi))
$newLines = @([System.IO.File]::ReadAllLines($New, $Ansi))
$oldSets  = Read-Sets $oldLines
$newSets  = Read-Sets $newLines

$kept = New-Object System.Collections.Generic.List[string]
$out  = New-Object System.Collections.Generic.List[string]

foreach ($line in $newLines) {
    $key = SetKeyOf $line
    if ($key -eq $null) { $out.Add($line); continue }

    if ($oldSets.ContainsKey($key)) {
        $oldVal = [string]$oldSets[$key]
        $newVal = [string](SetValueOf $line)
        if ($oldVal -ne $newVal) {
            # 用新版这一行的写法，值换成客户原来的
            $fixed = $line
            if ($line -match '^(?<pre>\s*set\s+"?[^=]+?=)(?<val>.*?)(?<post>"?\s*)$') {
                $fixed = $Matches['pre'] + $oldVal + $Matches['post']
            }
            $out.Add($fixed)
            $out.Add('rem   ^ 这项保留了你原来的值（新版默认是：' + $newVal + '）')
            $kept.Add($key)
            continue
        }
    }
    $out.Add($line)          # 值一样、或客户没这项：直接用新版的行（连注释一起更新）
}

# 客户自己加的项 / 自己写的命令：原样搬到末尾
$extra = New-Object System.Collections.Generic.List[string]
foreach ($l in $oldLines) {
    $t = $l.Trim()
    if ($t -eq '') { continue }
    if ($t.StartsWith('rem') -or $t.StartsWith('::') -or $t.StartsWith('@')) { continue }
    $k = SetKeyOf $l
    if ($k -ne $null) {
        if (-not $newSets.ContainsKey($k)) { $extra.Add($l) }
        continue
    }
    $extra.Add($l)           # 非 set 的自定义命令也保留
}
if ($extra.Count -gt 0) {
    $out.Add('')
    $out.Add('rem ------------------------------------------------------------')
    $out.Add('rem  下面是你自己加的内容（新版里没有），原样保留')
    $out.Add('rem ------------------------------------------------------------')
    foreach ($e in $extra) { $out.Add($e) }
}

$oldText = (($oldLines -join "`r`n").TrimEnd())
$newText = (($out.ToArray() -join "`r`n").TrimEnd())
if ($oldText -eq $newText) {
    Say '[Config] config.cmd 已是最新，不用动。' 'DarkGray'
    exit 0
}

if ($DryRun) {
    Say ('[Config] config.cmd 需要更新（会保留 ' + $kept.Count + ' 项你改过的设置）') 'Yellow'
    exit 1
}

$bak = $Old + '.bak-' + (Get-Date -Format 'yyyyMMdd_HHmmss')
Copy-Item -LiteralPath $Old -Destination $bak -Force
[System.IO.File]::WriteAllLines($Old, $out.ToArray(), $Ansi)

if ($kept.Count -gt 0) {
    Say ('[Config] config.cmd 已升级为新版，保留了你改过的：' + ($kept -join ', ')) 'Green'
} else {
    Say '[Config] config.cmd 已升级为新版（你原来的值和默认一致，没有需要保留的）。' 'Green'
}
Say ('         旧文件备份：' + (Split-Path $bak -Leaf)) 'Gray'
exit 1