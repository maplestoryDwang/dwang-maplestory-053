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
}