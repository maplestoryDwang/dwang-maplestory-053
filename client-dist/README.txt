client-dist\  —— 客户端插件 + 汉化数据的发布载荷
============================================================
这个目录里的东西会被 tools\sync-client.ps1 同步到【客户端目录】。
玩家不需要看这里；玩家只要跑 step2 的 start.cmd（拉代码 + 编译 + 更新客户端 + 启动），
或者双击 tools\更新客户端.bat。

目录说明
  plugin\   插件本体（同步到客户端根目录）
              Hook.dll            插件
              Launcher.exe        启动器
              stringpool053_zh.txt 中文文本表
              garbled053_zh.txt    服务端乱码替换表
              发布说明.txt          给玩家看的说明
              config.ini           运行时配置的默认值（只在客户端还没有时写入）
  data\     客户端数据，按【客户端里的相对路径】放
              wz\String.wz   ->  客户端\wz\String.wz
              Data\Quest\Say.img -> 客户端\Data\Quest\Say.img
              （如果客户端把 wz 放在根目录而不是 wz\ 子目录，脚本会自动写到根目录那份）
  tools\    同步脚本
              sync-client.ps1   真正的同步逻辑
              更新客户端.bat     双击入口（玩家/客户用这个）
              make-manifest.ps1  重新生成下面的清单（维护者用）
  client-dist.txt     版本 / 说明 / 客户端主程序校验 / keep_existing / backup_keep
  client-dist.sha256  每个文件的 sha256（make-manifest.ps1 生成，别手改）
  client-dir.txt      脚本自己记下的客户端目录（本地文件，不要提交到 git）

发布流程
  1. 把要更新的文件放进 plugin\ / data\（data 下按客户端相对路径摆）
  2. 跑  tools\make-manifest.ps1 -Version 1.1.3 -Tag client-v1.1.3   （会重算 sha256 + 统计）
  3. git add / commit / push，需要的话打 tag（client-vX.Y.Z）
  4. 玩家下次跑 start.cmd 就会自动同步过去（窗口里会打印更新了几个文件）

注意
  * 别往里放 Map.wz / Character.wz / Sound.wz / Mob.wz 这种几百 MB 的 —— 那是"安装包"的事，
    不是"每次更新"的事（否则仓库历史和玩家下载量都会爆）。
  * config.ini 默认"只补不覆盖"：客户端已有就不动，新默认值写到 config.ini.new，
    并在窗口里列出新版本多出来的配置项。
  * 客户端主程序校验（client_exe_sha256）：插件的补丁地址是针对特定客户端版本逆向的，
    对不上会警告；想让它对不上就拒绝更新，把 client-dist.txt 里 client_exe_strict 改成 1。
  * 客户端目录里的 _backup_client\ 是更新前的备份和日志，可以随时删，保留份数看 backup_keep。

以下文件【疑似】你们也改过，但我没法从干净包里 100% 确认，自己决定要不要放进 data\：
  Data\Etc\ScriptInfo.img        4820 -> 4799
  Data\Item\Etc\0416.img         137928 -> 137700
  Data\Npc\1061011.img           14720 -> 14667
  Data\Npc\9010000.img           9557 -> 9497
  Data\String\Npc.img            501866 -> 134434   （差得最多，确认下是不是有意的）