# GMS053 管理后台前端（gms-ui）

## 两种模式，互不影响

| | 前后端分离开发 | 打包进 jar 发布 |
|---|---|---|
| 前端 | `yarn dev` → http://localhost:8787 | `yarn build` → 产物进后端模块 |
| 后端 | 8686（IDE 或 mvnw 起都行） | 同一个 jar 的 8686 |
| 浏览器访问 | **8787** | **8686** |
| 接口地址 | `.env.development` 的 `VITE_API_BASE_URL` | 不设置 → 同源相对路径 |
| 跨域 | 靠后端 `app.vue` 放行 8787 | 同源，不需要 |

**平时开发就用左边这一列，和以前完全一样**：后端跑 8686，前端 `yarn dev` 跑 8787，
改前端代码热更新。打包进 jar 只是多了一个构建产物，不会影响 dev 服务器。

想打一个**不带前端**的纯后端 jar（纯后端开发时用）：

```bash
mvnw clean package -Dmaven.test.skip=true -Pno-frontend
```

## 开发

```bash
yarn install
yarn dev          # http://localhost:8787
```

接口地址在 `.env.development` 里（默认 `http://localhost:8686`）。
如果每台机器的后端地址不一样，**不要改这个文件**，在它旁边建一个 `.env.development.local`
（已被 `.gitignore` 的 `*.local` 忽略，不会被提交），写：

```
VITE_API_BASE_URL=http://192.168.1.5:8686
```

优先级：`.env.development.local` > `.env.development`。

> 注意后端 `application.yml` 里的 `app.vue` 是 CORS 放行名单，默认 `http://localhost:8787`。
> 如果你用 `http://127.0.0.1:8787` 打开，浏览器会因为 origin 不一致被拦，要么统一用 localhost，
> 要么把 `app.vue` 也加上 127.0.0.1 那一份。

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

所以发布流程是：

```bash
cd gms-ui
yarn build
cd ..
mvnw clean package -Dmaven.test.skip=true
```

## 几点说明

1. **构建产物的去向**：`build` 会先清空 `static/` 再写入，所以不要往那个目录里手写东西。
2. **路由模式**：生产构建用 hash 路由（`createWebHashHistory`），dev 用 history 路由。
   打包进 jar 后由后端同一个端口提供，hash 路由可以避免刷新页面时打到后端造成 404。
3. **构建产物要不要提交**：要。客户机器上没有 Node，是靠 `mvnw package` 打包的，
   所以 `gms-server/gms-handler/src/main/resources/static` 必须提交到仓库里。
4. **别忘了重新构建**：改了前端源码只 `mvnw package` 是不会生效的，
   要先 `yarn build`（把产物刷到 static 目录）再打包。
