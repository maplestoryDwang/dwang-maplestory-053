package org.gms.util;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/13 14:34
 */


import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class SpringContextUtil implements ApplicationContextAware {

    private static ApplicationContext context;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SpringContextUtil.context = applicationContext;
    }

    // 注意位置：public static  T getBean(Class clazz)
    //                       ^^^ 必须在这里声明
    public static  <T>T getBean(Class<T> clazz) {
        if (context == null) {
            throw new IllegalStateException("ApplicationContext 未初始化，请确认 SpringContextUtil 已被 Spring 扫描加载");
        }
        return context.getBean(clazz);
    }

    public static  <T>T getBean(String name, Class<T> clazz) {
        if (context == null) {
            throw new IllegalStateException("ApplicationContext 未初始化，请确认 SpringContextUtil 已被 Spring 扫描加载");
        }
        return context.getBean(name, clazz);
    }

    /**
     * 发布 Spring 事件（供未被 Spring 管理的类使用）
     * ApplicationContext 本身就继承并实现了 ApplicationEventPublisher 接口，因此有两种最直接的使用方式：
     * 直接利用 Context 发送（最推荐，零修改）
     * 在工具类中封装快捷方法（更优雅）
     *
     */
    public static void publishEvent(Object event) {
        if (context == null) {
            throw new IllegalStateException("ApplicationContext 未初始化");
        }
        context.publishEvent(event);
    }
}