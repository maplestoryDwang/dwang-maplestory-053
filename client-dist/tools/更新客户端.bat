@echo off
chcp 936 >nul 2>&1
setlocal EnableExtensions
title 更新客户端插件
set "HERE=%~dp0"

if /i "%~1"=="/?" goto :USAGE
if /i "%~1"=="-h" goto :USAGE

where powershell >nul 2>&1
if errorlevel 1 (
    echo [错误] 找不到 powershell.exe，没法更新。
    pause
    exit /b 1
)

set "ARGS="
if not "%~1"=="" set "ARGS=-ClientDir ""%~1"""
if not "%~2"=="" set "ARGS=%ARGS% %~2"
if not "%~3"=="" set "ARGS=%ARGS% %~3"
if not "%~4"=="" set "ARGS=%ARGS% %~4"

echo 正在更新客户端插件 / 汉化数据...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%HERE%sync-client.ps1" %ARGS%
set "RC=%ERRORLEVEL%"
echo.
if "%RC%"=="0" goto :OK
if "%RC%"=="2" goto :NEEDPATH
echo [失败] 返回码 %RC%，请看上面的提示。
echo.
pause
exit /b %RC%

:OK
echo [完成] 客户端已是最新。
echo.
pause
exit /b 0

:NEEDPATH
echo [注意] 没找到客户端目录。请把客户端文件夹路径当参数传进来，例如：
echo        更新客户端.bat "D:\game\origin-client"
echo        或者在 step2\config.cmd 里写 CLIENT_DIR=客户端路径
echo.
pause
exit /b 2

:USAGE
echo 更新客户端插件 / 汉化数据
echo.
echo 用法：更新客户端.bat [客户端目录] [-DryRun] [-Verify] [-NoData] [-Force]
echo   客户端目录   不填就自动找，找不到会问你
echo   -DryRun      只报告要改哪些文件，不动文件
echo   -Verify      只校验客户端现在是不是最新
echo   -NoData      只更新插件，不动 wz / img
echo   -Force       忽略客户端主程序版本校验
echo.
pause
exit /b 0