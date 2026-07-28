package org.gms.util;

import java.util.Optional;

import java.lang.reflect.Method;

public class ThreadLocalUtil {

    // 使用 Object 保存任意泛型对象
    private static final ThreadLocal<Object> THREAD_LOCAL = new ThreadLocal<>();

    // 保留原方法名，支持传入任意类型的 Client 对象
    public static <T> void setCurrentClient(T c) {
        THREAD_LOCAL.set(c);
    }

    // 保留原方法名，获取时自动强转为调用方需要的类型
    @SuppressWarnings("unchecked")
    public static <T> T getCurrentClient() {
        return (T) THREAD_LOCAL.get();
    }

    // 保留原方法名
    public static void removeCurrentClient() {
        THREAD_LOCAL.remove();
    }

    // 保留原方法名：通过反射调用当前对象的 getLanguage 方法，实现与 Client 解耦
    public static int getClientLang() {
        return Optional.ofNullable(THREAD_LOCAL.get())
                .map(obj -> {
                    try {
                        Method method = obj.getClass().getMethod("getLanguage");
                        Object result = method.invoke(obj);
                        return result instanceof Integer ? (Integer) result : 0;
                    } catch (Exception e) {
                        return 0;
                    }
                })
                .orElse(0);
    }
}