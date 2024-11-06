//package edu.cn.kluniv.selection.system.test;
//
//import edu.cn.kluniv.selection.system.util.DBUtil;
//import org.junit.After;
//import org.junit.Test;
//
//import java.sql.Connection;
//
//import static org.junit.Assert.*;
//
//public class DBConnectionTest {
//
//    private DBUtil dbConnection = new DBUtil();
//
//    @After
//    public void tearDown() {
//        dbConnection.close();
//    }
//
//    @Test
//    public void testConnect() {
//        dbConnection.connect();
//        Connection connection = dbConnection.getConnection();
//        assertNotNull("连接失败", connection);
//    }
//
//    @Test
//    public void testClose() {
//        dbConnection.connect();
//        dbConnection.close();
//        Connection connection = dbConnection.getConnection();
//        assertNull("关闭连接失败", connection);
//    }
//}
