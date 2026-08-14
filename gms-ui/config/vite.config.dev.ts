import { mergeConfig } from 'vite';
import eslint from 'vite-plugin-eslint';
import baseConfig from './vite.config.base';

export default mergeConfig(
  {
    mode: 'development',
    server: {
      open: true,
      fs: {
        strict: true,
      },
    },
    plugins: [
      eslint({
        cache: false,
        failOnError: false, // 出现 ESLint 报错时不卡住 Vite 编译
        emitError: false,
      }),
    ],
  },
  baseConfig
);
