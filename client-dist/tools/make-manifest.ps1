<#
  make-manifest.ps1 —— 重新生成 ../client-dist.sha256（维护者用）

  什么时候用：
    * 你往 client-dist\plugin\ 或 client-dist\data\ 里加/改/删了文件之后；
    * 用插件仓库的 tools\publish-client-dist.ps1 发布会自动调用它。

  它做三件事：
    1. 扫 plugin\ 和 data\ 下的所有文件，算 sha256，写成 client-dist.sha256；
    2. 顺手更新 client-dist.txt 里的 file_count / plugin_count / data_count / manifest_built；
    3. 打印一份清单（谁多大、多少个）。

  用法：
    powershell -NoProfile -ExecutionPolicy Bypass -File make-manifest.ps1
    powershell ... -File make-manifest.ps1 -Version 1.1.2 -Tag client-v1.1.2
#>
[CmdletBinding()]
param(
    [string]$Version = '',
    [string]$Tag = '',
    [string]$Notes = ''
)

$ErrorActionPreference = 'Stop'
$ToolsDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Dist     = Split-Path -Parent $ToolsDir
$Manifest = Join-Path $Dist 'client-dist.txt'
$Sums     = Join-Path $Dist 'client-dist.sha256'

function Join2($a, $b) { Join-Path $a $b }
function Rel($base, $full) { $full.Substring($base.Length).TrimStart('\') }

# ---------------------------------------------------------------- 扫文件
$rows = New-Object System.Collections.Generic.List[object]
foreach ($group in 'plugin', 'data') {
    $dir = Join2 $Dist $group
    if (-not (Test-Path -LiteralPath $dir)) { continue }
    $files = Get-ChildItem -LiteralPath $dir -Recurse -File | Sort-Object FullName
    foreach ($f in $files) {
        # 备份/临时/说明类文件不进清单
        if ($f.Name -like '*.bak*' -or $f.Name -like '*.new' -or $f.Name -like '*.orig') { continue }
        if ($f.Name -eq 'Thumbs.db' -or $f.Name -eq 'desktop.ini') { continue }
        $rel = Rel $Dist $f.FullName
        $rows.Add([pscustomobject]@{
            Rel  = ($rel -replace '\\', '/')
            Hash = (Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256).Hash.ToLower()
            Size = $f.Length
        })
    }
}

if ($rows.Count -eq 0) {
    Write-Host '[错误] client-dist\plugin 和 client-dist\data 里一个文件都没有，先放东西再生成清单。' -ForegroundColor Red
    exit 1
}

# ---------------------------------------------------------------- 写 sha256
$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('# client-dist.sha256 —— 由 tools\make-manifest.ps1 生成，不要手改')
[void]$sb.AppendLine('# 格式： <sha256>  <相对 client-dist 的路径>（正斜杠）')
foreach ($r in $rows) { [void]$sb.AppendLine(($r.Hash + '  ' + $r.Rel)) }
# UTF-8 with BOM：PowerShell 5.1 才认中文
[System.IO.File]::WriteAllText($Sums, $sb.ToString(), (New-Object System.Text.UTF8Encoding($true)))

# ---------------------------------------------------------------- 更新 client-dist.txt 的统计键
$pluginCount = ($rows | Where-Object { $_.Rel -like 'plugin/*' }).Count
$dataCount   = ($rows | Where-Object { $_.Rel -like 'data/*' }).Count
$dataSize    = ($rows | Where-Object { $_.Rel -like 'data/*' } | Measure-Object -Property Size -Sum).Sum
if (-not $dataSize) { $dataSize = 0 }

$lines = @(Get-Content -LiteralPath $Manifest -Encoding UTF8)

function SetKey {
    param([string[]]$src, [string]$key, [string]$value)
    $out = New-Object System.Collections.Generic.List[string]
    $done = $false
    foreach ($l in $src) {
        if ($l -match ('^\s*' + [regex]::Escape($key) + '\s*=')) {
            $out.Add("$key=$value"); $done = $true
        } else { $out.Add($l) }
    }
    if (-not $done) { $out.Add("$key=$value") }
    return , $out.ToArray()
}

if ($Version) { $lines = SetKey $lines 'version' $Version }
if ($Tag)     { $lines = SetKey $lines 'tag'     $Tag }
if ($Notes)   { $lines = SetKey $lines 'notes'   $Notes }
$lines = SetKey $lines 'manifest_built' ("{0:yyyy-MM-dd HH:mm:ss}" -f (Get-Date))
$lines = SetKey $lines 'file_count'     ([string]$rows.Count)
$lines = SetKey $lines 'plugin_count'   ([string]$pluginCount)
$lines = SetKey $lines 'data_count'     ([string]$dataCount)
$lines = SetKey $lines 'data_bytes'     ([string]$dataSize)
[System.IO.File]::WriteAllLines($Manifest, $lines, (New-Object System.Text.UTF8Encoding($true)))

# ---------------------------------------------------------------- 报告
Write-Host ''
Write-Host '============================================================' -ForegroundColor Cyan
Write-Host ('  清单已生成：{0}' -f $Sums) -ForegroundColor Cyan
Write-Host ('  共 {0} 个文件（plugin {1} / data {2}，data {3:N1} MB）' -f $rows.Count, $pluginCount, $dataCount, ($dataSize / 1MB))
Write-Host '============================================================' -ForegroundColor Cyan
foreach ($r in $rows) {
    Write-Host ('  {0,10:N0}  {1}' -f $r.Size, $r.Rel)
}
Write-Host ''