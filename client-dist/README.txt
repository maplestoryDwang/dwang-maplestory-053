client-dist\  —— 客户端插件 + 汉化数据的发布载荷
============================================================
这个目录会被 tools\sync-client.ps1 同步到【客户端目录】。
玩家不用看这里；玩家跑 step2\start.cmd（拉代码 + 编译 + 更新客户端 + 启动），
或者双击 tools\更新客户端.bat 也行。

目录说明
  plugin\   插件本体（同步到客户端根目录）
              Hook.dll            插件
              Launcher.exe        启动器
              stringpool053_zh.txt 中文文本表
              garbled053_zh.txt    服务端乱码替换表
              发布说明.txt          给玩家看的说明
              config.ini           运行时配置的默认值（缺失时才写入；已存在会【自动合并】）
  data\     客户端数据，按【客户端里的相对路径】放
              Data\Quest\Say.img  ->  客户端\Data\Quest\Say.img
              （玩家统一用 img 模式读 Data 文件夹，wz\ 那套不参与更新）
  tools\    同步脚本
              sync-client.ps1    真正的同步逻辑
              更新客户端.bat      双击入口（玩家/客户用这个）
              make-manifest.ps1  重新生成下面的清单（维护者用）
              merge-config.ps1   config.cmd 的自动合并（start.cmd 调它）
  client-dist.txt     版本 / 说明 / 客户端主程序校验 / keep_existing / backup_keep
  client-dist.sha256  每个文件的 sha256（make-manifest.ps1 生成，别手改）
  client-dir.txt      脚本自己记下的客户端目录（本地文件，不进 git）

发布流程
  1. 把要发布的文件放进 plugin\ / data\（data 下按客户端相对路径摆）
  2. 跑 client-dist\tools\make-manifest.ps1 -Version 1.1.4 -Tag client-v1.1.4
     或者用插件仓库的 tools\publish-client-dist.ps1（它会重编 Hook、刷 plugin\、再重算清单）
  3. git add / commit / push（要发版就打 tag client-vX.Y.Z）
  4. 玩家下次跑 start.cmd 就会自动同步过去

注意
  * 别往里放 Map.wz / Character.wz / Sound.wz / Mob.wz 那种几百 MB 的 —— 那是"安装包"的事，
    不是"每次更新"的事（否则仓库历史和玩家下载量都会爆）。
  * config.ini（插件配置，玩家在里面写服务器地址）是【自动合并】：新版的结构和新增项照抄，
    玩家改过的值原样保留，旧的备份成 config.ini.bak-<时间戳>。同理仓库 doc\config.cmd
    （服务器脚本配置）也会被 start.cmd 调 merge-config.ps1 自动合并。所以两边都放心改。
  * 客户端主程序校验（client_exe_sha256）：插件的补丁地址是针对特定客户端版本逆向的，
    对不上会警告；想让它对不上就拒绝更新，把 client-dist.txt 里 client_exe_strict 改成 1。
  * 客户端目录里的 _backup_client\ 是更新前的备份和日志，可以随时删，保留份数看 backup_keep。
  * 从载荷里删掉某个文件，玩家端不会跟着删（脚本只加/改，不删）。真要删得另做删除清单。