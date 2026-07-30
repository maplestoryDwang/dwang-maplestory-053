## 开发准备
### 数据库准备

如果数据库用户不是root用户，该用户需要拥有这些额外权限

performance_schema库user_variables_by_thread表的select权限

mysql库的show view权限

### idea 配置

如果是直接打开的gms-server目录运行，需要在server的编译配置里设置 Working directory 为 gms-handler


## 注意事项
1. 原生GMS083没有回退卷轴，需要删掉
   delete from shopitems where itemid = 2030100 
2. 冲标和子弹需要修改服务端wz


gms-common：基础类
gms-data: 加载DB和wz数据
gms-data-provider: 给gms-handler和gms-ui-admin提供数据支持