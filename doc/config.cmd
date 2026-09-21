@echo off
rem ============================================================
rem  GMS053 服务端 - 配置文件
rem
rem  这个文件是用来改配置的，改完保存就行，不要去改 start.cmd。
rem  所有路径默认都相对于本文件所在目录，客户放在哪里都能用。
rem ============================================================


rem ------------------------------------------------------------
rem  1. Git 仓库
rem ------------------------------------------------------------

rem 主地址（GitHub）
set "GIT_URL=https://github.com/maplestoryDwang/dwang-maplestory-053.git"

rem 备用地址：主地址拉不动（网络不通）时自动改用它。
rem 例如你把仓库同步到 Gitee 后，填在这里：
rem   set "GIT_URL_BACKUP=https://gitee.com/你的用户名/dwang-maplestory-053.git"
rem 不用就留空。
set "GIT_URL_BACKUP=https://gitee.com/dwang2019/dwang-maplestory-053.git"

rem 分支
set "GIT_BRANCH=master"

rem 拉取深度：
rem   1 = 只拉最新一版，下载量最小（推荐，首次大约 400~500MB）
rem   0 = 拉完整历史，非常慢非常大（2GB 以上），一般不需要
set "GIT_DEPTH=1"

rem 代码存放目录，默认是脚本旁边的 source 目录
set "SOURCE_DIR=%ROOT%\source"

rem 每次更新代码的方式：
rem   reset = 强制和远程保持一致（本地改动会被丢弃，推荐，客户机就是这样）
rem   pull  = 只做快进合并，本地有改动时会失败
set "UPDATE_MODE=reset"

rem git 代理，例如 http://127.0.0.1:7890 ，没有就留空（用系统/全局 git 配置）
set "GIT_PROXY="


rem ------------------------------------------------------------
rem  2. JDK
rem ------------------------------------------------------------

rem 默认用包内自带的 JDK。留空则自动在脚本目录下找 jdk-* 文件夹。
set "JDK_DIR=%ROOT%\jdk-21.0.2"


rem ------------------------------------------------------------
rem  3. 编译
rem ------------------------------------------------------------

rem 1 = 跳过单元测试（客户机建议保持 1，快很多）
set "MAVEN_TEST_SKIP=1"

rem 1 = 每次先 clean 再编译（干净、不会残留旧 class，慢一些，推荐）
rem 0 = 增量编译（快，但上游删过文件时可能残留旧 class）
set "MAVEN_CLEAN=1"

rem Maven 下载加速（可选）。国内可以填阿里云：
rem   set "MAVEN_WRAPPER_REPOURL=https://maven.aliyun.com/repository/public"
rem 依赖本身已经走 pom.xml 里配置的阿里云仓库，这里只影响 Maven 自身的下载。
set "MAVEN_WRAPPER_REPOURL=https://maven.aliyun.com/repository/public"


rem ------------------------------------------------------------
rem  4. 启动
rem ------------------------------------------------------------

rem 代码里的子目录结构（一般不用改）
set "JAR_REL=gms-server\gms-handler\target\Maplestory053.jar"
set "RUN_SUBDIR=gms-server\gms-handler"

rem Spring 环境：prod 用 application-prod.yml（数据库 dwang053 / root / root）
set "SPRING_PROFILE=prod"

rem 1 = 启动时读取脚本目录下的 application.yml（客户改数据库就改这个文件）
rem 0 = 完全用 jar 内置的配置
set "USE_EXTERNAL_YML=1"

rem JVM 参数，比如内存上限可以写 -Xms512m -Xmx2g
rem 留空则用 JVM 默认值（一般是物理内存的 1/4），客户机兼容性最好
set "JAVA_RUN_OPTS="

rem 1 = 运行日志同时写一份到 source\gms-server\gms-handler\logs\server.log
rem 0 = 只在窗口里显示
set "SAVE_LOG=1"
set "LOG_REL=gms-server\gms-handler\logs\server.log"
rem 控制台输出的字符集。中文 Windows 控制台是 936(GBK)，所以这里保持 GBK 才不会乱码。
rem 如果你习惯把控制台切成 UTF-8(chcp 65001)，就把它改成 UTF-8。
set "CONSOLE_CHARSET=GBK"
rem 日志文件(source\...\logs\server.log)的字符集。UTF-8 通用性最好；
rem 如果你想让中文 Windows 的老记事本双击就能正常打开，改成 GBK。
set "LOG_CHARSET=UTF-8"

rem 额外的启动参数，比如 --server.port=8686
set "EXTRA_ARGS="

rem ------------------------------------------------------------
rem  5. 客户端插件 / 汉化数据（step3client\origin-client）
rem ------------------------------------------------------------

rem 1 = 拉完代码顺手把客户端插件和汉化数据也更新了（推荐）。
rem     载荷在 source\client-dist\，同步脚本是 source\client-dist\tools\sync-client.ps1
set "SYNC_CLIENT=1"

rem 客户端目录。留空 = 自动找（默认找 <包根>\step3client\origin-client）。
rem 客户端放在别处就写绝对路径，例如：
rem   set "CLIENT_DIR=D:\games\origin-client"
rem （脚本找到后会自己记在 source\client-dist\client-dir.txt，下次不用再找）
set "CLIENT_DIR="

rem 1 = 连汉化 wz / img 一起更新（推荐）
rem 0 = 只更新插件（Hook.dll / Launcher.exe / 文本表），不动 wz
set "CLIENT_SYNC_DATA=1"

rem 找不到客户端目录时：
rem   0 = 只警告，服务端照常启动（推荐，玩家不会卡住）
rem   1 = 直接停下来（你确定每个客户都必须有客户端目录时才用）
set "SYNC_CLIENT_STRICT=0"

rem 1 = 拉代码后如果仓库里的 doc\start.cmd / doc\config.cmd 更新了，就提示并自动换新版
rem     start.cmd 下次运行生效；config.cmd 只在旁边放 config.cmd.new，你的配置不会丢
set "SYNC_SELF_UPDATE=1"
