package util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBUtil {
    private static DataSource dataSource;

    // 初始化连接池
    static {
        dataSource = createDataSource();
    }

    // 获取数据库连接
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    // 关闭数据库连接
    public static void closeConnection(Connection connection) throws SQLException {
        if (connection != null) {
            connection.close();
        }
    }

    // 创建连接池
    private static DataSource createDataSource() {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:mysql://localhost:3306/e_cargo");
        config.setDriverClassName("com.mysql.cj.jdbc.Driver");
        config.setUsername("root");
        config.setPassword("Admin123");
        config.setMaximumPoolSize(10); // 设置最大连接数
        config.setMinimumIdle(5); // 设置最小空闲连接数
        config.setIdleTimeout(30000); // 设置连接的最大空闲时间
        config.setConnectionTimeout(5000); // 设置连接超时时间
        config.setMaxLifetime(1800000); // 设置连接的最大生命周期
        config.setConnectionTestQuery("SELECT 1"); // 设置用于测试连接是否可用的 SQL 查询

        return new HikariDataSource(config);
    }
}
