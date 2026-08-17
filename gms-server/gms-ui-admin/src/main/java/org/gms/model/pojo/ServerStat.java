package org.gms.model.pojo;

/**
 * 单独一个字段表示服务是否在线, 还是应该放数据库好一点
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/11 18:02
 */
public class ServerStat {
    public static boolean online = false;

    public static boolean isOnline() {
        return online;
    }
}
