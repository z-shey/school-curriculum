package edu.cn.kluniv.selection.system.dao;

import edu.cn.kluniv.selection.system.model.Administrator;
import edu.cn.kluniv.selection.system.model.User;
import edu.cn.kluniv.selection.system.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdministratorDao implements BaseDao<Administrator> {
    private Connection connection;
    private ResultSet resultSet;
    private PreparedStatement preparedStatement;
    private DBUtil dbUtil;

    public AdministratorDao(DBUtil dbUtil) {
        this.dbUtil = dbUtil;
        connection = dbUtil.getConnection();
    }

    @Override
    public void insert(Administrator entity) {
        String sql = "INSERT INTO [SJZ].Administrator VALUES(?,?,?,?,?)";
        try {
            String account = entity.getAno();
            String password = entity.getAno();
            User user = new User(account, password, USER_ROLE_STUDENT);
            UserDao userDao = new UserDao(dbUtil);
            userDao.insert(user);
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            preparedStatement.setObject(1, entity.getAno());
            preparedStatement.setObject(2, entity.getAname());
            preparedStatement.setObject(3, entity.getAsex());
            preparedStatement.setObject(4, entity.getAage());
            preparedStatement.setObject(5, entity.getAdept());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void delete(String id) {
        String sql = "DELETE FROM [SJZ].Administrator WHERE ano=?";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setObject(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void update(Administrator entity, String id) {
        String sql = "UPDATE [SJZ].Administrator SET aname=?,asex=?,aage=?,adept=? WHERE ano=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, entity.getAname());
            preparedStatement.setObject(2, entity.getAsex());
            preparedStatement.setObject(3, entity.getAage());
            preparedStatement.setObject(4, entity.getAdept());
            preparedStatement.setObject(5, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public ResultSet selectById(String id) {
        String sql = "SELECT * FROM [SJZ].Administrator WHERE ano=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setObject(1, id);
            resultSet = preparedStatement.executeQuery();
            return resultSet;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    @Override
    public ResultSet selectAll(int role) {
        String sql = "SELECT * FROM [SJZ].Administrator";
        try {
            if (role == BaseDao.USER_ROLE_ADMIN) {
                preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
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

    public ResultSet selectByDept(String dept) {
        String sql = "SELECT * FROM [SJZ].Administrator WHERE adept = ?";
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
        String sql = "SELECT * FROM [SJZ].Administrator WHERE asex=?";
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
}
