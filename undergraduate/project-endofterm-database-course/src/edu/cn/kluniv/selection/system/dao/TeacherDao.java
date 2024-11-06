package edu.cn.kluniv.selection.system.dao;

import edu.cn.kluniv.selection.system.model.Teacher;
import edu.cn.kluniv.selection.system.model.User;
import edu.cn.kluniv.selection.system.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TeacherDao implements BaseDao<Teacher> {
    private Connection connection;
    private ResultSet resultSet;
    private PreparedStatement preparedStatement;
    private DBUtil dbUtil;
    public TeacherDao(DBUtil dbUtil) {
        this.dbUtil = dbUtil;
        connection = dbUtil.getConnection();
    }


    @Override
    public void insert(Teacher entity) {
        String sql = "INSERT INTO [SJZ].Teacher VALUES(?,?,?,?,?)";
        try {
            String account = entity.getTno();
            String password = entity.getTno();
            User user = new User(account, password, USER_ROLE_TEACHER);
            new UserDao(dbUtil).insert(user);
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, entity.getTno());
            preparedStatement.setObject(2, entity.getTname());
            preparedStatement.setObject(3, entity.getTsex());
            preparedStatement.setObject(4, entity.getTage());
            preparedStatement.setObject(5, entity.getTdept());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void delete(String id) {
        String sql = "DELETE FROM [SJZ].Teacher WHERE tno=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void update(Teacher teaEntity, String id) {
        String sql = "UPDATE [SJZ].Teacher SET tname=?,tsex=?,tage=?,tdept=? WHERE tno=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, teaEntity.getTname());
            preparedStatement.setObject(2, teaEntity.getTsex());
            preparedStatement.setObject(3, teaEntity.getTage());
            preparedStatement.setObject(4, teaEntity.getTdept());
            preparedStatement.setObject(5, id);
            resultSet = preparedStatement.executeQuery();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public ResultSet selectById(String id) {
        String sql = "SELECT * FROM [SJZ].Teacher WHERE tno=?";
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
        String sql = "SELECT * FROM [SJZ].Teacher";
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
