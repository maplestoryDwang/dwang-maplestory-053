import { createRouter, createWebHashHistory, createWebHistory } from 'vue-router';
import NProgress from 'nprogress'; // progress bar
import 'nprogress/nprogress.css';

import { appRoutes } from './routes';
import { REDIRECT_MAIN, NOT_FOUND_ROUTE } from './routes/base';
import createRouteGuard from './guard';

NProgress.configure({ showSpinner: false }); // NProgress Configuration

const router = createRouter({
  // 打包进 jar 由后端提供时用 hash 路由：深链接/刷新不会打到后端，
  // 不需要后端为 SPA 做路由回退；开发环境保持原来的 history 路由。
  history: import.meta.env.PROD ? createWebHashHistory() : createWebHistory(),
  routes: [
    {
      path: '/login',
      redirect: '/',
    },
    {
      path: '/',
      name: 'login',
      component: () => import('@/views/login/index.vue'),
      meta: {
        requiresAuth: false,
      },
    },
    ...appRoutes,
    REDIRECT_MAIN,
    NOT_FOUND_ROUTE,
  ],
  scrollBehavior() {
    return { top: 0 };
  },
});

createRouteGuard(router);

export default router;
