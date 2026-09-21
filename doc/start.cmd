@echo off
chcp 936 >nul 2>&1
setlocal EnableExtensions EnableDelayedExpansion
title GMS053 服务端 - 一键编译启动

rem ============================================================
rem  GMS053 服务端 一键脚本
rem
rem  用法（在本目录打开 cmd 后执行，或者直接双击 = 全部执行）：
rem     start.cmd           拉取代码 + 编译 + 更新客户端插件 + 启动   （最常用）
rem     start.cmd update    只拉取/更新代码
rem     start.cmd build     只编译（不动 git）
rem     start.cmd client    只用最新代码里的 client-dist 更新客户端插件 / 汉化数据
rem     start.cmd run       只启动（不编译、不更新客户端）
rem
rem  所有设置都在 config.cmd 里改，本文件不用动。
rem ============================================================

rem ---- 脚本自己所在目录（客户放在任何路径都能用） ----
for %%I in ("%~dp0.") do set "ROOT=%%~fI"
set "ROOT_FWD=%ROOT:\=/%"
set "JAVA_HOME_ENV=%JAVA_HOME%"

for /f "tokens=2 delims=:" %%C in ('chcp') do set "OLDCP=%%C"
set "OLDCP=%OLDCP: =%"

if not exist "%ROOT%\config.cmd" (
    echo [错误] 找不到 config.cmd，请确认它和 start.cmd 在同一个目录里。
    goto :FAIL_PAUSE
)

call "%ROOT%\config.cmd"

rem ---- 解析要执行哪几步 ----
set "STEP=%~1"
if "%STEP%"=="" set "STEP=all"
set "DO_SYNC=0"
set "DO_BUILD=0"
set "DO_CLIENT=0"
set "DO_RUN=0"
if /i "%STEP%"=="all" (
    set "DO_SYNC=1"
    set "DO_BUILD=1"
    set "DO_CLIENT=1"
    set "DO_RUN=1"
)
if /i "%STEP%"=="update" set "DO_SYNC=1"
if /i "%STEP%"=="build" set "DO_BUILD=1"
if /i "%STEP%"=="client" set "DO_CLIENT=1"
if /i "%STEP%"=="run" set "DO_RUN=1"

echo ============================================================
echo   GMS053 服务端 一键编译启动
echo ------------------------------------------------------------
echo   脚本目录 : %ROOT%
echo   代码目录 : %SOURCE_DIR%
echo   本次动作 : %STEP%
echo ============================================================
echo.

if "%DO_SYNC%%DO_BUILD%%DO_CLIENT%%DO_RUN%"=="0000" (
    echo [错误] 不认识的参数："%STEP%"
    echo        可用参数：update / build / client / run，不带参数则全部执行。
    goto :FAIL_PAUSE
)

call :FIND_GIT
if errorlevel 1 goto :FAIL_PAUSE

call :FIND_JAVA
if errorlevel 1 goto :FAIL_PAUSE

if "%DO_SYNC%"=="1" (
    call :SYNC_SOURCE
    if errorlevel 1 goto :FAIL_PAUSE
)

if "%DO_BUILD%"=="1" (
    call :BUILD
    if errorlevel 1 goto :FAIL_PAUSE
)

if "%DO_CLIENT%"=="1" (
    call :SYNC_CLIENT
    if errorlevel 1 (
        if not defined SYNC_CLIENT_STRICT set "SYNC_CLIENT_STRICT=0"
        if "%SYNC_CLIENT_STRICT%"=="1" goto :FAIL_PAUSE
        echo.
        echo [警告] 客户端插件没更新成功，服务端继续启动。下次运行会再试一次。
        echo        想先解决它：看上面的提示，或手动跑一次
        echo        %SOURCE_DIR%\client-dist\tools\更新客户端.bat
    )
)

if "%DO_RUN%"=="1" (
    call :RUN_SERVER
    if errorlevel 1 goto :FAIL_PAUSE
)

echo.
echo [完成] 全部步骤已执行结束。
goto :DONE_PAUSE


rem ============================================================
rem  找 git
rem ============================================================
:FIND_GIT
set "GIT_EXE="
if exist "%ROOT%\PortableGit\cmd\git.exe" set "GIT_EXE=%ROOT%\PortableGit\cmd\git.exe"
if not defined GIT_EXE if exist "%ROOT%\PortableGit\bin\git.exe" set "GIT_EXE=%ROOT%\PortableGit\bin\git.exe"
if not defined GIT_EXE (
    for %%G in (git.exe) do if not "%%~$PATH:G"=="" set "GIT_EXE=%%~$PATH:G"
)
if not defined GIT_EXE (
    echo [错误] 没有找到 git。
    echo        请把 PortableGit 整个文件夹放到：%ROOT%\PortableGit
    echo        或者自己装一个 Git 并加入系统 PATH。
    exit /b 1
)

rem sslBackend=openssl 很关键：部分 Windows 上 git 默认的 schannel
rem 会报 SEC_E_NO_CREDENTIALS，换成 openssl 就能正常拉 GitHub。
rem safe.directory=* 也是必须的：如果 source 放在 exFAT / FAT32 这类
rem 不记录文件所有者的分区上（比如移动硬盘），git 会报
rem "detected dubious ownership" 然后拒绝执行，加了这个就正常了。
set "GIT_COMMON=-c http.sslBackend=openssl -c core.longpaths=true -c core.autocrlf=false -c safe.directory=*"
if not "%GIT_PROXY%"=="" set "GIT_COMMON=%GIT_COMMON% -c http.proxy=%GIT_PROXY% -c https.proxy=%GIT_PROXY%"
echo [环境] git    : %GIT_EXE%
exit /b 0


rem ============================================================
rem  找 JDK（必须是 21）
rem ============================================================
:FIND_JAVA
set "JAVA_HOME="
if defined JDK_DIR if exist "%JDK_DIR%\bin\java.exe" set "JAVA_HOME=%JDK_DIR%"
if not defined JAVA_HOME (
    for /d %%D in ("%ROOT%\jdk-*") do if exist "%%~fD\bin\java.exe" set "JAVA_HOME=%%~fD"
)
if not defined JAVA_HOME if defined JAVA_HOME_ENV if exist "%JAVA_HOME_ENV%\bin\java.exe" set "JAVA_HOME=%JAVA_HOME_ENV%"
if not defined JAVA_HOME (
    for %%J in (java.exe) do if not "%%~$PATH:J"=="" (
        for %%K in ("%%~dp$PATH:J..") do set "JAVA_HOME=%%~fK"
    )
)
if not defined JAVA_HOME (
    echo [错误] 没有找到 JDK 21。
    echo        请把 JDK 解压到：%ROOT%\jdk-21.0.2
    echo        或者在 config.cmd 里把 JDK_DIR 指向你的 JDK 目录。
    exit /b 1
)

set "JAVA_EXE=%JAVA_HOME%\bin\java.exe"
set "JVER="
set "JMAJOR="
if exist "%JAVA_HOME%\release" (
    for /f "tokens=2 delims==" %%V in ('findstr /b /c:"JAVA_VERSION=" "%JAVA_HOME%\release"') do set "JVER=%%~V"
)
if defined JVER for /f "tokens=1 delims=." %%M in ("%JVER%") do set "JMAJOR=%%M"
echo [环境] JDK    : %JAVA_HOME%   (java %JVER%)
if defined JMAJOR if %JMAJOR% LSS 21 (
    echo [警告] 当前是 Java %JVER%，本项目需要 JDK 21，编译很可能失败。
)
exit /b 0


rem ============================================================
rem  1. 拉取 / 更新代码
rem ============================================================
:SYNC_SOURCE

if exist "%SOURCE_DIR%\.git" goto :SYNC_UPDATE

echo [1/4] 首次拉取代码（要下 400MB 以上，慢慢等）...
echo       仓库 : %GIT_URL%
echo       分支 : %GIT_BRANCH%
echo       深度 : %GIT_DEPTH%

if exist "%SOURCE_DIR%" (
    echo       代码目录不是 git 仓库，先清空再拉取：%SOURCE_DIR%
    rmdir /s /q "%SOURCE_DIR%" >nul 2>&1
)
mkdir "%SOURCE_DIR%" >nul 2>&1
if not exist "%SOURCE_DIR%" (
    echo [错误] 无法创建代码目录：%SOURCE_DIR%
    exit /b 1
)

set "CLONE_OPTS="
if not "%GIT_DEPTH%"=="0" set "CLONE_OPTS=--depth=%GIT_DEPTH% --single-branch"

call :TRY_CLONE "%GIT_URL%"
if not errorlevel 1 goto :SYNC_DONE

echo.
echo [警告] 主地址拉取失败。
if "%GIT_URL_BACKUP%"=="" goto :SYNC_FAIL
echo [提示] 改用备用地址：%GIT_URL_BACKUP%
if exist "%SOURCE_DIR%" rmdir /s /q "%SOURCE_DIR%" >nul 2>&1
mkdir "%SOURCE_DIR%" >nul 2>&1
call :TRY_CLONE "%GIT_URL_BACKUP%"
if not errorlevel 1 goto :SYNC_DONE

echo [错误] 备用地址也拉取失败，请检查网络 / 代理 / 地址。
goto :SYNC_FAIL


:SYNC_UPDATE
echo [1/4] 更新代码...
pushd "%SOURCE_DIR%"
set "FETCH_OPTS="
if not "%GIT_DEPTH%"=="0" set "FETCH_OPTS=--depth=%GIT_DEPTH%"

"%GIT_EXE%" %GIT_COMMON% fetch %FETCH_OPTS% "%GIT_URL%" "%GIT_BRANCH%"
if not errorlevel 1 goto :SYNC_MERGE

echo [警告] 主地址更新失败：%GIT_URL%
if "%GIT_URL_BACKUP%"=="" goto :SYNC_UPDATE_FAIL
echo [提示] 改用备用地址：%GIT_URL_BACKUP%
"%GIT_EXE%" %GIT_COMMON% fetch %FETCH_OPTS% "%GIT_URL_BACKUP%" "%GIT_BRANCH%"
if errorlevel 1 goto :SYNC_UPDATE_FAIL

:SYNC_MERGE
if /i "%UPDATE_MODE%"=="pull" (
    echo       合并方式: pull --ff-only
    "%GIT_EXE%" %GIT_COMMON% merge --ff-only FETCH_HEAD
) else (
    echo       合并方式: 强制与远程一致（本地改动会被丢弃）
    "%GIT_EXE%" %GIT_COMMON% reset --hard FETCH_HEAD
)
if errorlevel 1 goto :SYNC_UPDATE_FAIL

echo       当前版本:
"%GIT_EXE%" %GIT_COMMON% log -1 --oneline
popd
goto :SYNC_DONE

:SYNC_UPDATE_FAIL
popd
echo [错误] 代码更新失败，无法继续。
goto :SYNC_FAIL


:TRY_CLONE
"%GIT_EXE%" %GIT_COMMON% clone %CLONE_OPTS% --branch "%GIT_BRANCH%" "%~1" "%SOURCE_DIR%"
if errorlevel 1 exit /b 1
exit /b 0


:SYNC_DONE
echo [OK] 代码已就绪：%SOURCE_DIR%
call :CHECK_SCRIPT_UPDATE
echo.
exit /b 0


rem ============================================================
rem  脚本自更新检查（仓库里的 doc\*.cmd 是母版）
rem    start.cmd  有新版 -> 本次结束前换成新版（下次运行生效）
rem    config.cmd 有新版 -> 自动合并进你的 config.cmd（保留你改过的值，旧的留备份）
rem ============================================================
:CHECK_SCRIPT_UPDATE
if not defined SYNC_SELF_UPDATE set "SYNC_SELF_UPDATE=1"
if not "%SYNC_SELF_UPDATE%"=="1" exit /b 0
if not exist "%SOURCE_DIR%\doc\start.cmd" exit /b 0

rem 拉下来的脚本可能是 LF 结尾（git 归一化过），cmd 跑 LF 的 .cmd/.bat 会解析错乱，
rem 所以先字节级修成 CRLF 再比/再拷（fix-crlf.ps1 不动编码，只补 0D）。
if exist "%SOURCE_DIR%\client-dist\tools\fix-crlf.ps1" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%SOURCE_DIR%\client-dist\tools\fix-crlf.ps1" -Path "%SOURCE_DIR%\doc" -Quiet
)
fc /b "%SOURCE_DIR%\doc\start.cmd" "%ROOT%\start.cmd" >nul 2>&1
if not errorlevel 1 goto :CHECK_CONFIG_UPDATE
copy /y "%SOURCE_DIR%\doc\start.cmd" "%ROOT%\start.cmd.new" >nul 2>&1
if exist "%ROOT%\start.cmd.new" if exist "%SOURCE_DIR%\client-dist\tools\fix-crlf.ps1" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%SOURCE_DIR%\client-dist\tools\fix-crlf.ps1" -Path "%ROOT%\start.cmd.new" -Quiet
)
if exist "%ROOT%\start.cmd.new" (
    set "SCRIPT_UPDATED=1"
    echo [提示] start.cmd 有新版本（本次结束前自动替换，下次运行生效）。
)

:CHECK_CONFIG_UPDATE
if not exist "%SOURCE_DIR%\doc\config.cmd" exit /b 0
fc /b "%SOURCE_DIR%\doc\config.cmd" "%ROOT%\config.cmd" >nul 2>&1
if not errorlevel 1 exit /b 0

rem 有新版：自动合并进你的 config.cmd —— 新版的结构和新增项照抄，
rem 你自己改过的值原样保留，旧的备份成 config.cmd.bak-<时间戳>。
rem （什么都没改过的话，结果就等于直接用新模板）
if exist "%SOURCE_DIR%\client-dist\tools\merge-config.ps1" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%SOURCE_DIR%\client-dist\tools\merge-config.ps1" -Old "%ROOT%\config.cmd" -New "%SOURCE_DIR%\doc\config.cmd"
    if errorlevel 2 goto :CONFIG_UPDATE_FALLBACK
    if errorlevel 1 echo [提示] config.cmd 已升级为新版（你自己改过的值都保留了，旧文件有备份）。
    exit /b 0
)

:CONFIG_UPDATE_FALLBACK
copy /y "%SOURCE_DIR%\doc\config.cmd" "%ROOT%\config.cmd.new" >nul 2>&1
if exist "%ROOT%\config.cmd.new" (
    echo [提示] config.cmd 有新版本：你的配置没动，新版模板放在 %ROOT%\config.cmd.new 里。
)
exit /b 0


rem ============================================================
rem  3. 更新客户端插件 / 汉化数据
rem     载荷在 source\client-dist\（plugin\ 是插件，data\ 是汉化 wz/img）
rem     同步逻辑：client-dist\tools\sync-client.ps1（自动找客户端目录 / 只补不覆盖 config.ini）
rem ============================================================
:SYNC_CLIENT
echo [3/4] 更新客户端插件 / 汉化数据...

if not defined SYNC_CLIENT set "SYNC_CLIENT=1"
if "%SYNC_CLIENT%"=="0" (
    echo       已在 config.cmd 里关闭（SYNC_CLIENT=0），跳过。
    echo.
    exit /b 0
)
if not defined CLIENT_DIR set "CLIENT_DIR="
if not defined CLIENT_SYNC_DATA set "CLIENT_SYNC_DATA=1"

set "CLIENT_TOOLS=%SOURCE_DIR%\client-dist\tools"
if not exist "%CLIENT_TOOLS%\sync-client.ps1" (
    echo       [跳过] 代码里还没有 client-dist\tools\sync-client.ps1
    echo              说明拉到的代码还没带这个功能，等下一次更新就有了。
    echo.
    exit /b 0
)

set "CLIENT_ARGS="
if not "%CLIENT_DIR%"=="" set "CLIENT_ARGS=-ClientDir "%CLIENT_DIR%""
if "%CLIENT_SYNC_DATA%"=="0" set "CLIENT_ARGS=%CLIENT_ARGS% -NoData"

powershell -NoProfile -ExecutionPolicy Bypass -File "%CLIENT_TOOLS%\sync-client.ps1" %CLIENT_ARGS%
set "CLIENT_RC=%ERRORLEVEL%"
if "%CLIENT_RC%"=="0" goto :SYNC_CLIENT_OK
if "%CLIENT_RC%"=="2" (
    echo.
    echo [提示] 没找到客户端目录。两种办法：
    echo        1) 在 %ROOT%\config.cmd 里写死：
    echo           set "CLIENT_DIR=D:\你的\origin-client"
    echo        2) 手动跑一次（把客户端目录当参数）：
    echo           "%CLIENT_TOOLS%\更新客户端.bat" "D:\你的\origin-client"
    exit /b 1
)
echo [错误] 更新客户端失败，返回码 %CLIENT_RC%
exit /b 1

:SYNC_CLIENT_OK
echo [OK] 客户端插件 / 汉化数据已是最新。
echo.
exit /b 0

:SYNC_FAIL
echo.
exit /b 1


rem ============================================================
rem  2. 编译
rem ============================================================
:BUILD
echo [2/4] 开始编译（第一次会下载 Maven 和依赖，比较慢）...

if not exist "%SOURCE_DIR%\mvnw.cmd" (
    echo [错误] 在 %SOURCE_DIR% 下找不到 mvnw.cmd，代码可能没拉完整。
    exit /b 1
)

set "JAVA_HOME=%JAVA_HOME%"
set "PATH=%JAVA_HOME%\bin;%PATH%"
if not "%MAVEN_WRAPPER_REPOURL%"=="" set "MVNW_REPOURL=%MAVEN_WRAPPER_REPOURL%"

set "MVN_ARGS=-B -Dfile.encoding=UTF-8"
if "%MAVEN_TEST_SKIP%"=="1" set "MVN_ARGS=%MVN_ARGS% -Dmaven.test.skip=true"
if "%MAVEN_CLEAN%"=="1" set "MVN_ARGS=%MVN_ARGS% clean"

pushd "%SOURCE_DIR%"
call "%SOURCE_DIR%\mvnw.cmd" %MVN_ARGS% package
set "MVN_RC=%ERRORLEVEL%"
popd

if not "%MVN_RC%"=="0" (
    echo.
    echo [错误] 编译失败，Maven 返回码 %MVN_RC%
    echo        内存不够的话，可以在 config.cmd 里给 JAVA_RUN_OPTS 加 -Xmx，
    echo        或者设置环境变量 MAVEN_OPTS=-Xmx1024m 后再试。
    exit /b 1
)

if not exist "%SOURCE_DIR%\%JAR_REL%" (
    echo [错误] 编译结束，但没有找到 jar：
    echo        %SOURCE_DIR%\%JAR_REL%
    exit /b 1
)

for %%F in ("%SOURCE_DIR%\%JAR_REL%") do echo [OK] 编译完成: %%~nxF  (%%~zF 字节)
echo.
exit /b 0


rem ============================================================
rem  3. 启动
rem  注意：wz 和 scripts 都是按「当前工作目录」去找的，
rem        所以必须把工作目录切到 gms-handler 这一层，否则读不到资源。
rem ============================================================
:RUN_SERVER
echo [4/4] 启动服务端...

set "JAR=%SOURCE_DIR%\%JAR_REL%"
set "RUNDIR=%SOURCE_DIR%\%RUN_SUBDIR%"

if not exist "%JAR%" (
    echo [错误] 找不到 jar：%JAR%
    echo        请先执行：start.cmd build
    exit /b 1
)
if not exist "%RUNDIR%\wz" (
    echo [错误] 找不到 WZ 目录：%RUNDIR%\wz
    echo        代码目录不对，请检查 config.cmd 里的 SOURCE_DIR。
    exit /b 1
)

rem Spring 配置通过环境变量传入，路径里有空格也不会出问题
set "SPRING_PROFILES_ACTIVE=%SPRING_PROFILE%"
set "SPRING_CONFIG_ADDITIONAL_LOCATION="
if "%USE_EXTERNAL_YML%"=="1" if exist "%ROOT%\application.yml" (
    set "SPRING_CONFIG_ADDITIONAL_LOCATION=optional:file:%ROOT_FWD%/application.yml"
)
set "LOGGING_FILE_NAME="
if "%SAVE_LOG%"=="1" set "LOGGING_FILE_NAME=%SOURCE_DIR%\%LOG_REL%"
rem 日志/控制台编码：Spring Boot 3 的 ConsoleAppender 默认跟 file.encoding 走(UTF-8)，
rem 中文控制台是 936，不指定的话中文日志就是乱码。
set "LOGGING_CHARSET_CONSOLE="
if not "%CONSOLE_CHARSET%"=="" set "LOGGING_CHARSET_CONSOLE=%CONSOLE_CHARSET%"
set "LOGGING_CHARSET_FILE="
if not "%LOG_CHARSET%"=="" set "LOGGING_CHARSET_FILE=%LOG_CHARSET%"

echo       jar     : %JAR%
echo       工作目录: %RUNDIR%
echo       profile : %SPRING_PROFILE%
if defined SPRING_CONFIG_ADDITIONAL_LOCATION (
    echo       外部配置: %ROOT%\application.yml
) else (
    echo       外部配置: 无（使用 jar 内置配置）
)
echo       WZ 目录 : %RUNDIR%\wz
echo       日志目录: %RUNDIR%\logs
if defined LOGGING_FILE_NAME echo       日志文件: %LOGGING_FILE_NAME%
if defined LOGGING_CHARSET_CONSOLE echo       控制台编码: %LOGGING_CHARSET_CONSOLE%
echo ------------------------------------------------------------
echo   启动中... 关闭本窗口或按 Ctrl+C 可以停止服务端。
echo ------------------------------------------------------------
echo.

pushd "%RUNDIR%"
"%JAVA_EXE%" %JAVA_RUN_OPTS% -jar "%JAR%" %EXTRA_ARGS%
set "RUN_RC=%ERRORLEVEL%"
popd

echo.
echo ------------------------------------------------------------
echo [完成] 服务端已退出，返回码 %RUN_RC%
if not "%RUN_RC%"=="0" echo        如果不是你手动关的，去 %RUNDIR%\logs 看日志。
echo.
exit /b 0


rem ============================================================
rem  收尾
rem ============================================================
:FAIL_PAUSE
echo.
echo ============================================================
echo   执行失败，请看上面的红色/错误提示。
echo ============================================================
if defined OLDCP chcp %OLDCP% >nul 2>&1
pause
endlocal
exit /b 1

:DONE_PAUSE
call :APPLY_SCRIPT_UPDATE
if defined OLDCP chcp %OLDCP% >nul 2>&1
pause
endlocal
exit /b 0


rem ============================================================
rem  真正替换 start.cmd（cmd 还读着它，所以交给一个延迟的小窗去做）
rem ============================================================
:APPLY_SCRIPT_UPDATE
if not exist "%ROOT%\start.cmd.new" exit /b 0
pushd "%ROOT%"
start "" /min cmd /c "ping -n 2 127.0.0.1 >nul & move /y start.cmd.new start.cmd >nul"
popd
echo [提示] start.cmd 已更新为新版，下次运行就是新版脚本了。
exit /b 0