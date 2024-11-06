package edu.cn.kluniv.selection.system.dao;

import edu.cn.kluniv.selection.system.model.Student;
import edu.cn.kluniv.selection.system.model.User;
import edu.cn.kluniv.selection.system.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentDao implements BaseDao<Student> {
    private Connection connection;
    private ResultSet resultSet;
    private PreparedStatement preparedStatement;
    private DBUtil dbUtil;

    public StudentDao(DBUtil dbUtil) {
        this.dbUtil = dbUtil;
        connection = dbUtil.getConnection();
    }

    @Override
    public void insert(Student entity) {
        String sql = "INSERT INTO [SJZ].Student VALUES(?,?,?,?,?)";
        try {
            String account = entity.getSno();
            String password = entity.getSno();
            User user = new User(account, password, USER_ROLE_STUDENT);
            new UserDao(dbUtil).insert(user);
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, entity.getSno());
            preparedStatement.setObject(2, entity.getSname());
            preparedStatement.setObject(3, entity.getSsex());
            preparedStatement.setObject(4, entity.getSage());
            preparedStatement.setObject(5, entity.getSdept());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void delete(String id) {
        String sql = "DELETE FROM [SJZ].Student WHERE sno=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void update(Student stuEntity, String id) {
        String sql = "UPDATE [SJZ].Student SET sname=?,ssex=?,sage=?,sdept=? WHERE sno=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, stuEntity.getSname());
            preparedStatement.setObject(2, stuEntity.getSsex());
            preparedStatement.setObject(3, stuEntity.getSage());
            preparedStatement.setObject(4, stuEntity.getSdept());
            preparedStatement.setObject(5, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public ResultSet selectById(String id) {
        String sql = "SELECT * FROM [SJZ].Student WHERE sno=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setObject(1, id);
            resultSet = preparedStatement.executeQuery();
            resultSet.beforeFirst();
            return resultSet;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ResultSet selectByDept(String dept) {
        String sql = "SELECT * FROM [SJZ].Student WHERE sdept=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setObject(1, dept);
            resultSet = preparedStatement.executeQuery();
            return resultSet;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ResultSet selectBySex(String sex) {
        String sql = "SELECT * FROM [SJZ].Student WHERE ssex=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setObject(1, sex);
            resultSet = preparedStatement.executeQuery();
            return resultSet;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    @Override
    public ResultSet selectAll(int role) {
        String sql = "SELECT * FROM [SJZ].Student";
        try {
            if (role == BaseDao.USER_ROLE_ADMIN) {
                preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            } else if (role == BaseDao.USER_ROLE_STUDENT || role == BaseDao.USER_ROLE_TEACHER) {
                preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            }
            resultSet = preparedStatement.executeQuery();
            return resultSet;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
}
