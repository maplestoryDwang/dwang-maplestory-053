# GMS053 管理后台前端（gms-ui）

## 开发

```bash
yarn install
yarn dev          # http://localhost:8787，接口指向 .env.development 里的 VITE_API_BASE_URL
```

## 构建

```bash
yarn build        # 生产构建，直接输出到后端模块，打完 jar 就自带管理后台
yarn build:dist   # 只输出到本目录的 dist/，用于单独部署（nginx 等）
yarn build:typed  # 构建前先跑一遍 vue-tsc 类型检查
yarn type:check   # 只做类型检查，不构建
yarn preview      # 本地预览 dist/ 的构建结果
```

`yarn build` 的输出目录是：

```
../gms-server/gms-handler/src/main/resources/static
```

它会跟着 Maven 的 resources 阶段进入 `target/classes/static`，
最终在 jar 里就是 `BOOT-INF/classes/static`，由 Spring Boot 默认的静态资源处理提供。

所以标准流程是：

```bash
cd gms-ui
yarn build
cd ..
mvnw clean package -Dmaven.test.skip=true
```

## 几点说明

1. **构建产物的去向**：`build` 会清空 `static/` 再写入，所以不要往那个目录里手写东西。
2. **路由模式**：生产构建用 hash 路由（`createWebHashHistory`），dev 用 history 路由。
   打包进 jar 后由后端同一个端口提供，hash 路由可以避免刷新页面时打到后端造成 404。
3. **接口地址**：生产构建不设置 `VITE_API_BASE_URL`（`.env.production` 是空的），
   也就是走同源相对路径，前端和后端同一个端口，不需要跨域。
4. **构建产物要不要提交**：要。客户机器上没有 Node，是靠 `mvnw package` 打包的，
   所以 `gms-server/gms-handler/src/main/resources/static` 必须提交到仓库里。
