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
rem     start.cmd check     只检查远端有没有新版本（不拉代码、不编译）
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

rem ---- 老版 config.cmd 没有这些项时，给个默认值 ----
if not defined CHECK_UPDATE set "CHECK_UPDATE=1"
if not defined UPDATE_WAIT set "UPDATE_WAIT=20"
if not defined VERSION_FILE set "VERSION_FILE=版本信息.txt"
if not defined CHANGELOG_FILE set "CHANGELOG_FILE=更新日志.md"
if not defined GIT_TRY_NO_PROXY set "GIT_TRY_NO_PROXY=1"
if not defined UPDATE_ANSWER set "UPDATE_ANSWER=ask"
set "LS_TMP=%TEMP%\gms-lsremote.txt"
set "LV_TMP=%TEMP%\gms-localver.txt"

rem ---- 解析要执行哪几步 ----
set "STEP=%~1"
if "%STEP%"=="" set "STEP=all"
set "DO_SYNC=0"
set "DO_CHECK=0"
set "DO_BUILD=0"
set "DO_CLIENT=0"
set "DO_RUN=0"
if /i "%STEP%"=="all" (
    set "DO_BUILD=1"
    set "DO_CLIENT=1"
    set "DO_RUN=1"
    rem 默认先查远端有没有新版本、再问要不要更新；关掉检查就退回"每次直接拉最新"
    if "%CHECK_UPDATE%"=="1" ( set "DO_CHECK=1" ) else ( set "DO_SYNC=1" )
)
if /i "%STEP%"=="check"  set "DO_CHECK=1"
if /i "%STEP%"=="update" set "DO_SYNC=1"
if /i "%STEP%"=="build"  set "DO_BUILD=1"
if /i "%STEP%"=="client" set "DO_CLIENT=1"
if /i "%STEP%"=="run"    set "DO_RUN=1"

echo ============================================================
echo   GMS053 服务端 一键编译启动
echo ------------------------------------------------------------
echo   脚本目录 : %ROOT%
echo   代码目录 : %SOURCE_DIR%
echo   本次动作 : %STEP%
echo ============================================================
echo.

if "%DO_SYNC%%DO_CHECK%%DO_BUILD%%DO_CLIENT%%DO_RUN%"=="00000" (
    echo [错误] 不认识的参数："%STEP%"
    echo        可用参数：check / update / build / client / run，不带参数则全部执行。
    goto :FAIL_PAUSE
)

call :FIND_GIT
if errorlevel 1 goto :FAIL_PAUSE

call :FIND_JAVA
if errorlevel 1 goto :FAIL_PAUSE

if "%DO_CHECK%"=="1" (
    call :CHECK_UPDATE
    if errorlevel 1 goto :FAIL_PAUSE
)

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
rem  0. 检查远端有没有新版本
rem     只用 git ls-remote：一次往返、几 KB，不下载代码
rem ============================================================
:CHECK_UPDATE
echo [1/4] 检查远端是否有更新...

if not exist "%SOURCE_DIR%\.git" (
    echo       本地还没有代码，跳过检查，直接拉取。
    set "DO_SYNC=1"
    exit /b 0
)

set "REMOTE_HASH="
set "REMOTE_TAG="
set "REMOTE_VER="
set "CHECK_SRC="

call :NET_PICK lsremote
if errorlevel 1 goto :CHECK_FAIL_NET
call :PARSE_LSREMOTE
if not defined REMOTE_HASH goto :CHECK_FAIL_PARSE

call :READ_LOCAL_VERSION
if not defined LOCAL_FULL goto :CHECK_FAIL_LOCAL

if /i "%REMOTE_HASH%"=="%LOCAL_FULL%" (
    rem 块内要用 !VAR!（延迟展开）：%VAR% 里的 ")" 会在解析阶段把 if 块截断
    echo       已经是最新版本：!LOCAL_VER!
    set "DO_SYNC=0"
    call :WRITE_VERSION current
    echo.
    exit /b 0
)

echo       远端有新版本！
echo         本地 : %LOCAL_VER%
echo         远端 : %REMOTE_VER%    来源：%CHECK_SRC%
call :WRITE_VERSION behind

echo.
echo ============================================================
echo   远端有新版本，要不要现在更新？
echo ------------------------------------------------------------
echo   本地版本 : %LOCAL_VER%
echo   远端版本 : %REMOTE_VER%
echo   版本来源 : %CHECK_SRC%
echo   更新内容 : 看同目录的 %CHANGELOG_FILE%（更新之后才会刷成最新）
echo ------------------------------------------------------------
echo   [Y] 更新      重新拉代码 + 编译，大概 1~5 分钟
echo   [N] 不更新    直接用本地这个版本启动（先玩，下次再说）
echo                 %UPDATE_WAIT% 秒内没有按键，自动按 N 处理
echo ============================================================
rem 无人值守想自动更新，就把 config.cmd 里的 UPDATE_ANSWER 改成 Y
if /i "%UPDATE_ANSWER%"=="Y" goto :CHECK_DO
if /i "%UPDATE_ANSWER%"=="N" goto :CHECK_SKIP

choice /c YN /t %UPDATE_WAIT% /d N /n >nul 2>&1
set "CHOICE_RC=%ERRORLEVEL%"
if "%CHOICE_RC%"=="1" goto :CHECK_DO

:CHECK_SKIP
echo.
echo [提示] 这次不更新，用本地版本 %LOCAL_VER% 启动。
echo        想更新的时候重新双击 start.cmd 就行。
set "DO_SYNC=0"
echo.
exit /b 0

:CHECK_DO
echo.
echo [提示] 开始更新到 %REMOTE_VER% ...
set "DO_SYNC=1"
echo.
exit /b 0

:CHECK_FAIL_NET
echo       [警告] 连不上远端（主地址和备用地址都不通），这次跳过检查更新。
echo              不影响启动，直接用本地现有版本。
set "DO_SYNC=0"
set "CHECK_SRC=连不上远端"
call :WRITE_VERSION unknown
echo.
exit /b 0

:CHECK_FAIL_PARSE
echo       [警告] 拿到了远端数据但没解析出版本号（ls-remote 格式变了？），跳过检查。
set "DO_SYNC=0"
set "CHECK_SRC=解析失败"
call :WRITE_VERSION unknown
echo.
exit /b 0

:CHECK_FAIL_LOCAL
echo       [警告] 读不出本地版本信息，跳过检查。
echo              [诊断] SOURCE_DIR=%SOURCE_DIR%
set "DO_SYNC=0"
set "CHECK_SRC=本地版本读取失败"
call :WRITE_VERSION unknown
echo.
exit /b 0


rem ============================================================
rem  git 网络操作统一重试
rem    顺序：主地址 -> 备用地址 -> 去掉全局代理后 主地址 -> 备用地址
rem    成功时 NET_URL / CHECK_SRC 有值
rem    （机器上留着一个已经不通的代理配置，是很常见的情况）
rem ============================================================
:NET_PICK
set "NET_URL="
call :NET_ONE %1 "%GIT_URL%" "主地址"
if not errorlevel 1 exit /b 0
if not "%GIT_URL_BACKUP%"=="" (
    call :NET_ONE %1 "%GIT_URL_BACKUP%" "备用地址"
    if not errorlevel 1 exit /b 0
)
if not "%GIT_TRY_NO_PROXY%"=="1" exit /b 1

set "SAVE_GCG=%GIT_CONFIG_GLOBAL%"
set "SAVE_GCN=%GIT_CONFIG_NOSYSTEM%"
set "GIT_CONFIG_GLOBAL=%TEMP%\gms-no-such-gitconfig"
set "GIT_CONFIG_NOSYSTEM=1"
call :NET_ONE %1 "%GIT_URL%" "主地址(不走代理)"
if not errorlevel 1 goto :NET_PICK_END
if not "%GIT_URL_BACKUP%"=="" call :NET_ONE %1 "%GIT_URL_BACKUP%" "备用地址(不走代理)"
:NET_PICK_END
set "GIT_CONFIG_GLOBAL=%SAVE_GCG%"
set "GIT_CONFIG_NOSYSTEM=%SAVE_GCN%"
if defined NET_URL exit /b 0
exit /b 1

:NET_ONE
set "NET_URL="
if /i "%~1"=="lsremote" goto :NET_ONE_LS
if /i "%~1"=="clone"    goto :NET_ONE_CLONE
goto :NET_ONE_FETCH
:NET_ONE_LS
"%GIT_EXE%" %GIT_COMMON% ls-remote "%~2" >"%LS_TMP%" 2>nul
goto :NET_ONE_RC
:NET_ONE_CLONE
if exist "%SOURCE_DIR%" rmdir /s /q "%SOURCE_DIR%" >nul 2>&1
mkdir "%SOURCE_DIR%" >nul 2>&1
"%GIT_EXE%" %GIT_COMMON% clone %CLONE_OPTS% --tags --branch "%GIT_BRANCH%" "%~2" "%SOURCE_DIR%" >nul 2>&1
goto :NET_ONE_RC
:NET_ONE_FETCH
"%GIT_EXE%" %GIT_COMMON% fetch %FETCH_OPTS% --tags "%~2" "%GIT_BRANCH%" >nul 2>&1
:NET_ONE_RC
if errorlevel 1 exit /b 1
set "NET_URL=%~2"
set "CHECK_SRC=%~3"
exit /b 0


rem ============================================================
rem  解析 ls-remote 的结果 -> REMOTE_HASH / REMOTE_TAG / REMOTE_VER
rem  注意：annotated tag 会有两行，只有 xxx^{} 那行才是它指向的 commit
rem ============================================================
:PARSE_LSREMOTE
set "REMOTE_HASH="
set "REMOTE_TAG="
rem 注意：git ls-remote 的输出是 LF 行尾，findstr 的 /e 在 LF 文件上不生效，
rem       所以这里用 for /f 直接读文件再精确比较（也不受 tag 名里怪字符影响）
for /f "usebackq tokens=1,2" %%A in ("%LS_TMP%") do (
    if /i "%%B"=="refs/heads/%GIT_BRANCH%" set "REMOTE_HASH=%%A"
)
if not defined REMOTE_HASH exit /b 1
set "REMOTE_VER=%REMOTE_HASH:~0,7%"
rem 找指向这个 commit 的 tag：annotated tag 只有 xxx^{} 那行的 hash 才是 commit
for /f "usebackq tokens=1,2" %%A in ("%LS_TMP%") do (
    if /i "%%A"=="%REMOTE_HASH%" (
        set "TG=%%B"
        if "!TG:~0,10!"=="refs/tags/" (
            set "TG=!TG:^{}=!"
            set "TG=!TG:refs/tags/=!"
            call :SANITIZE_TAG TG
            if defined TG set "REMOTE_TAG=!TG!"
        )
    )
)
if defined REMOTE_TAG set "REMOTE_VER=!REMOTE_TAG!"
exit /b 0


rem ============================================================
rem  读本地当前版本 -> LOCAL_FULL / LOCAL_VER
rem ============================================================
:READ_LOCAL_VERSION
set "LOCAL_HASH="
set "LOCAL_DATE="
set "LOCAL_FULL="
set "LOCAL_TAG="
set "LOCAL_VER="
if not exist "%SOURCE_DIR%\.git" exit /b 1
rem 注意：不能在 for /f 里直接跑 git —— cmd 处理命令串开头的引号会报
rem       "文件名、目录名或卷标语法不正确"，所以先落临时文件再读
"%GIT_EXE%" %GIT_COMMON% -C "%SOURCE_DIR%" rev-parse HEAD >"%LV_TMP%" 2>nul
for /f "usebackq delims=" %%H in ("%LV_TMP%") do set "LOCAL_FULL=%%H"
if not defined LOCAL_FULL exit /b 1

"%GIT_EXE%" %GIT_COMMON% -C "%SOURCE_DIR%" log -1 --date=short --format="%%h %%ad" >"%LV_TMP%" 2>nul
for /f "usebackq tokens=1,2" %%A in ("%LV_TMP%") do (
    set "LOCAL_HASH=%%A"
    set "LOCAL_DATE=%%B"
)

"%GIT_EXE%" %GIT_COMMON% -C "%SOURCE_DIR%" describe --tags --exact-match HEAD >"%LV_TMP%" 2>nul
for /f "usebackq delims=" %%T in ("%LV_TMP%") do set "LOCAL_TAG=%%T"
if defined LOCAL_TAG call :SANITIZE_TAG LOCAL_TAG
set "LOCAL_VER=%LOCAL_HASH%"
if defined LOCAL_TAG set "LOCAL_VER=%LOCAL_TAG%"
if defined LOCAL_DATE set "LOCAL_VER=%LOCAL_VER% (%LOCAL_DATE%)"
exit /b 0


rem ============================================================
rem  tag 名清洗：去掉批处理里有特殊含义的字符，免得 echo 时把脚本搞坏
rem ============================================================
:SANITIZE_TAG
set "_v=!%~1!"
if defined _v (
    set "_v=!_v:&=!"
    set "_v=!_v:|=!"
    set "_v=!_v:<=!"
    set "_v=!_v:>=!"
)
set "%~1=!_v!"
exit /b 0


rem ============================================================
rem  写 版本信息.txt（GBK，记事本直接打开正常） + 复制 更新日志
rem  入参 %1 = current / behind / updated / unknown
rem ============================================================
:WRITE_VERSION
set "VSTATUS=%~1"
call :READ_LOCAL_VERSION
set "VF=%ROOT%\%VERSION_FILE%"
set "VTEXT="
if "%VSTATUS%"=="current" set "VTEXT=已经是最新版本"
if "%VSTATUS%"=="behind"  set "VTEXT=远端有新版本，本次没有更新（还在用本地这个版本）"
if "%VSTATUS%"=="updated" set "VTEXT=刚刚更新到最新版本"
if "%VSTATUS%"=="unknown" set "VTEXT=没能连上远端，本次没有检查（用的还是本地这个版本）"
if not defined VTEXT set "VTEXT=%VSTATUS%"

>"%VF%" echo ============================================================
>>"%VF%" echo  GMS053 服务端 版本信息
>>"%VF%" echo ============================================================
>>"%VF%" echo  生成时间 : %DATE% %TIME%
>>"%VF%" echo  本地版本 : %LOCAL_VER%
>>"%VF%" echo  本地提交 : %LOCAL_FULL%
if defined REMOTE_VER  >>"%VF%" echo  远端版本 : %REMOTE_VER%
if defined REMOTE_HASH >>"%VF%" echo  远端提交 : %REMOTE_HASH%
if defined CHECK_SRC   >>"%VF%" echo  版本来源 : %CHECK_SRC%
>>"%VF%" echo  当前状态 : %VTEXT%
>>"%VF%" echo.
>>"%VF%" echo  更新内容请打开同目录的 %CHANGELOG_FILE%
>>"%VF%" echo  （它是仓库里 doc\update_log.md 的副本，更新代码后会自动刷新）
>>"%VF%" echo.
>>"%VF%" echo  想更新到最新版本 ：双击 start.cmd
>>"%VF%" echo  只想直接启动不更新：双击 不拉代码直接启动.bat
>>"%VF%" echo ============================================================

call :WRITE_CHANGELOG
exit /b 0


:WRITE_CHANGELOG
if not exist "%SOURCE_DIR%\doc\update_log.md" exit /b 0
copy /y "%SOURCE_DIR%\doc\update_log.md" "%ROOT%\%CHANGELOG_FILE%" >nul 2>&1
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

call :NET_PICK clone
if not errorlevel 1 goto :SYNC_DONE

echo [错误] 主地址和备用地址都拉取失败，请检查网络 / 代理 / 地址。
goto :SYNC_FAIL


:SYNC_UPDATE
echo [1/4] 更新代码...
pushd "%SOURCE_DIR%"
set "FETCH_OPTS="
if not "%GIT_DEPTH%"=="0" set "FETCH_OPTS=--depth=%GIT_DEPTH%"

call :NET_PICK fetch
if errorlevel 1 goto :SYNC_UPDATE_FAIL
echo       版本来源: %CHECK_SRC%

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





:SYNC_DONE
echo [OK] 代码已就绪：%SOURCE_DIR%
call :CHECK_SCRIPT_UPDATE
rem 更新完了：远端那两行清掉（现在本地就是远端），状态记成"刚刚更新"
set "REMOTE_HASH="
set "REMOTE_TAG="
set "REMOTE_VER="
call :WRITE_VERSION updated
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
rem 拉下来的脚本可能是 LF 结尾（git 归一化过），cmd 跑 LF 的 .cmd/.bat 会解析错乱，
rem 所以先字节级修成 CRLF 再比/再拷（fix-crlf.ps1 不动编码，只补 0D）。
if exist "%SOURCE_DIR%\client-dist\tools\fix-crlf.ps1" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%SOURCE_DIR%\client-dist\tools\fix-crlf.ps1" -Path "%SOURCE_DIR%\doc" -Quiet
)
rem 懒人说明.txt 是纯文本，直接覆盖（放在 CRLF 修正之后，免得拷到 LF 的版本）
call :SYNC_LAZY_GUIDE

if not exist "%SOURCE_DIR%\doc\start.cmd" exit /b 0
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
rem  把仓库里的 doc\懒人说明.txt 复制到用户那边
rem    目标优先【包根目录】（和 step1db / step3client 同级，也就是用户第一眼看到的那份），
rem    认不出包根目录就放到 step2（和 start.cmd 一起）。
rem    txt 不像 start.cmd 那样正在被占用，直接覆盖即可。
rem ============================================================
:SYNC_LAZY_GUIDE
if not exist "%SOURCE_DIR%\doc\懒人说明.txt" exit /b 0

set "LAZY_DST=%ROOT%"
for %%I in ("%ROOT%\..") do set "LAZY_PARENT=%%~fI"
if exist "%LAZY_PARENT%\step1db" set "LAZY_DST=%LAZY_PARENT%"
if exist "%LAZY_PARENT%\step3client" set "LAZY_DST=%LAZY_PARENT%"
if not exist "%LAZY_DST%\" set "LAZY_DST=%ROOT%"

fc /b "%SOURCE_DIR%\doc\懒人说明.txt" "%LAZY_DST%\懒人说明.txt" >nul 2>&1
if not errorlevel 1 exit /b 0

copy /y "%SOURCE_DIR%\doc\懒人说明.txt" "%LAZY_DST%\懒人说明.txt" >nul 2>&1
if errorlevel 1 (
    echo [警告] 懒人说明.txt 复制失败（目标：%LAZY_DST%），跳过。
    exit /b 0
)
echo [提示] 懒人说明.txt 已更新（%LAZY_DST%）
exit /b 0

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