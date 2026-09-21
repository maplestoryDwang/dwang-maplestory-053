<#
  fix-crlf.ps1 —— 把 LF 结尾的文本文件改成 CRLF（cmd 解析纯 LF 的 .cmd/.bat 会报
  "'et' 不是内部或外部命令" 那种乱码；PowerShell 无所谓，但 cmd 很挑）。

  用法：
    powershell -NoProfile -ExecutionPolicy Bypass -File fix-crlf.ps1 -Path "<文件或目录>"
    powershell ... -File fix-crlf.ps1 -Path "doc\start.cmd","doc\升级脚本.bat" -Quiet

  实现是字节级的：只把"前面不是 0x0D 的 0x0A"换成 0x0D 0x0A，所以 GBK / UTF-8 / 带不带 BOM
  都不会被破坏。已经全是 CRLF 的文件不动。

  退出码：0 = 不需要处理；1 = 修好了若干文件；2 = 出错
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string[]]$Path,
    [string[]]$Filter = @('*.cmd', '*.bat', '*.ps1', '*.txt'),
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'
function Say { param([string]$m, [string]$c = 'Gray') if (-not $Quiet) { Write-Host $m -ForegroundColor $c } }

$files = New-Object System.Collections.Generic.List[string]
foreach ($p in $Path) {
    if (Test-Path -LiteralPath $p -PathType Container) {
        foreach ($f in (Get-ChildItem -LiteralPath $p -Recurse -File -Include $Filter -ErrorAction SilentlyContinue)) { $files.Add($f.FullName) }
    } elseif (Test-Path -LiteralPath $p -PathType Leaf) {
        $files.Add((Resolve-Path -LiteralPath $p).Path)
    } else {
        Say ('[fix-crlf] 跳过（不存在）：' + $p) 'DarkGray'
    }
}

$fixed = 0
foreach ($f in $files) {
    $b = [System.IO.File]::ReadAllBytes($f)
    $needs = $false
    for ($i = 0; $i -lt $b.Length; $i++) {
        if ($b[$i] -eq 0x0A -and ($i -eq 0 -or $b[$i - 1] -ne 0x0D)) { $needs = $true; break }
    }
    if (-not $needs) { continue }
    $out = New-Object System.Collections.Generic.List[byte]
    for ($i = 0; $i -lt $b.Length; $i++) {
        if ($b[$i] -eq 0x0A -and ($i -eq 0 -or $b[$i - 1] -ne 0x0D)) {
            $out.Add([byte]0x0D); $out.Add([byte]0x0A)
        } else {
            $out.Add($b[$i])
        }
    }
    [System.IO.File]::WriteAllBytes($f, $out.ToArray())
    $fixed++
    Say ('[fix-crlf] LF -> CRLF : ' + $f) 'Yellow'
}
if ($fixed -gt 0) { Say ('[fix-crlf] 修好了 ' + $fixed + ' 个文件（cmd 需要 CRLF 结尾）。') 'Green'; exit 1 }
exit 0