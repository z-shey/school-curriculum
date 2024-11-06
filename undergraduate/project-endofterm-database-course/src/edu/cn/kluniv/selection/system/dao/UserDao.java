package edu.cn.kluniv.selection.system.dao;

import edu.cn.kluniv.selection.system.model.User;
import edu.cn.kluniv.selection.system.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao implements BaseDao<User> {
    private Connection connection;
    private ResultSet resultSet;
    private PreparedStatement preparedStatement;
    private User user;


    public UserDao(DBUtil dbc) {
        connection = dbc.getConnection();
    }

    public User saveUser(ResultSet rs) {
        try {
            user = new User(rs.getString(1), rs.getString(2), rs.getInt(3));
            return user;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    @Override
    public void insert(User entity) {
        String sql = "INSERT INTO [SJZ].Users VALUES(?,?,?)";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, entity.getAccount());
            preparedStatement.setObject(2, entity.getPassword());
            preparedStatement.setObject(3, entity.getRole());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void delete(String id) {
        String sql = "DELETE FROM [SJZ].Users WHERE account=?";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setObject(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void update(User entity, String id) {
        String sql = "UPDATE [SJZ].Users SET account=?,passwrd=?,userRole=? WHERE account=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedStatement.setObject(1, entity.getAccount());
            preparedStatement.setObject(2, entity.getPassword());
            preparedStatement.setObject(3, entity.getRole());
            preparedStatement.setObject(4, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public ResultSet selectById(String id) {
        String sql = "SELECT * FROM [SJZ].Users WHERE account=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
        String sql = "SELECT * FROM [SJZ].Users";
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

    public ResultSet selectByAccountAndPassword(String account, String passwrd) {
        String sql = "SELECT * FROM [SJZ].Users WHERE account=? AND passwrd=?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setObject(1, account);
            preparedStatement.setObject(2, passwrd);
            resultSet = preparedStatement.executeQuery();
            return resultSet;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public void generateUserInfo() {
        String sql = "INSERT INTO [SJZ].Users (account, passwrd, userRole) " +
                "SELECT [SJZ].Student.sno AS account, RIGHT([SJZ].Student.sno, 6) AS passwrd, 1 AS userRole " +
                "FROM [SJZ].Student " +
                "UNION" +
                "SELECT [SJZ].[Teacher].tno, RIGHT([SJZ].Teacher.tno, 6), 2 " +
                "FROM [SJZ].[Teacher] " +
                "UNION" +
                "SELECT [SJZ].[Administrator].ano, RIGHT([SJZ].Administrator.ano, 6), 3 " +
                "FROM [SJZ].[Administrator]";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public String updatePassword(User userEntity, String account, String oldPasswrd) {
        String sql = "UPDATE [SJZ].Users SET passwrd=? WHERE account=?";
        try {
            resultSet = selectByAccountAndPassword(account, oldPasswrd);
            if (!resultSet.next()) {
                return "ERROR";
            }
        } catch (SQLException e1) {
            System.out.println(e1.getMessage());
        }

        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setObject(1, userEntity.getPassword());
            preparedStatement.setObject(2, account);
            preparedStatement.executeUpdate();
            return "SUCCESS";
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return "ERROR";
    }
}
