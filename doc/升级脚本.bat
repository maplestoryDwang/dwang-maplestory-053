@echo off
chcp 936 >nul 2>&1
setlocal EnableExtensions
title 一次性升级 step2\start.cmd

rem 本文件在 <包根>\step2\source\doc\ 里。
rem
rem 什么情况需要跑它：
rem   你的包是很早的版本（step2\start.cmd 里还没有"更新客户端插件/汉化数据"这一步）。
rem   那种旧 start.cmd 自己不会检查更新（那段逻辑在新版里），所以要手动装一次。
rem
rem 跑完这一次之后，以后双击 step2\start.cmd 就会自动：
rem   拉代码 -> 编译 -> 更新客户端插件和汉化数据 -> 启动服务端
rem   并且每次都会自己检查 start.cmd / config.cmd 有没有新版。
rem
rem 已经升级过的包再跑一次也没关系（就是再覆盖一遍）。

for %%I in ("%~dp0..\..") do set "STEP2=%%~fI"

if not exist "%STEP2%\config.cmd" (
    echo [错误] 找不到 %STEP2%\config.cmd
    echo        请把本脚本放在 <包根>\step2\source\doc\ 里再运行。
    pause
    exit /b 1
)
if not exist "%~dp0start.cmd" (
    echo [错误] 找不到 %~dp0start.cmd（新版脚本），请先跑一次 start.cmd 把代码拉下来。
    pause
    exit /b 1
)

if exist "%STEP2%\start.cmd" (
    copy /y "%STEP2%\start.cmd" "%STEP2%\start.cmd.old" >nul 2>&1
    echo [备份] 旧脚本已备份为 step2\start.cmd.old
)

copy /y "%~dp0start.cmd" "%STEP2%\start.cmd" >nul
if errorlevel 1 (
    echo [错误] 复制失败：请先关掉正在运行的 start.cmd 窗口再试。
    pause
    exit /b 1
)
echo [完成] step2\start.cmd 已升级为新版。

if exist "%~dp0config.cmd" (
    copy /y "%~dp0config.cmd" "%STEP2%\config.cmd.new" >nul 2>&1
    echo [参考] 新版配置模板放在 step2\config.cmd.new
    echo        你自己的 config.cmd 没有被改；要加新选项就照着它抄。
)
if exist "%~dp0使用说明.txt" (
    copy /y "%~dp0使用说明.txt" "%STEP2%\使用说明.txt" >nul 2>&1
    echo [更新] step2\使用说明.txt 也换成新版说明。
)

echo.
echo 以后直接双击 step2\start.cmd 即可（第一次会同步客户端插件，之后就是增量的）。
pause
exit /b 0