package org.gms.util;


import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;


import org.springframework.stereotype.Component;

@Component
public class DatabaseConnection {

    // 静态变量，用于存放注入的 DataSource
    private static DataSource dataSource;

    // 使用构造器注入，Spring 在创建 DatabaseConnection 实例时会自动调用此构造函数
    public DatabaseConnection(DataSource dataSource) {
        DatabaseConnection.dataSource = dataSource;
    }

    public static Connection getConnection() throws SQLException {
        // 直接使用静态持有的 dataSource
        return dataSource.getConnection();
    }
}