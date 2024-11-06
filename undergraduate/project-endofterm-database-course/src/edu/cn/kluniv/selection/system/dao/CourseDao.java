package edu.cn.kluniv.selection.system.dao;

import edu.cn.kluniv.selection.system.model.Course;
import edu.cn.kluniv.selection.system.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CourseDao implements BaseDao<Course> {
    private Connection connection;
    private ResultSet resultSet;
    private PreparedStatement preparedStatement;

    public CourseDao(DBUtil dbUtil) {
        connection = dbUtil.getConnection();
    }

    @Override
    public void insert(Course courseEntity) {
        String sql = "INSERT INTO [SJZ].Course VALUES(?,?,?,?,?)";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, courseEntity.getCno());
            preparedStatement.setObject(2, courseEntity.getCname());
            preparedStatement.setObject(3, courseEntity.getTno());
            preparedStatement.setObject(4, courseEntity.getCcredit());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void delete(String id) {
        String sql = "DELETE FROM [SJZ].Course WHERE cno=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void update(Course courseEntity, String id) {
        String sql = "UPDATE [SJZ].Course SET cno=?,cname=?,tno=?,cpno=?,ccredit=? WHERE cno=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, courseEntity.getCno());
            preparedStatement.setObject(2, courseEntity.getCname());
            preparedStatement.setObject(3, courseEntity.getTno());
            preparedStatement.setObject(4, courseEntity.getCpno());
            preparedStatement.setObject(5, courseEntity.getCcredit());
            preparedStatement.setObject(6, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public ResultSet selectById(String id) {
        String sql = "SELECT * FROM [SJZ].Course WHERE cno=?";
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

    @Override
    public ResultSet selectAll(int role) {
        String sql = "SELECT * FROM [SJZ].Course";
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
