package edu.cn.kluniv.selection.system.dao;

import edu.cn.kluniv.selection.system.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SCDao<SC> implements BaseDao<SC> {
    private Connection connection;
    private ResultSet resultSet;
    private PreparedStatement preparedStatement;
    private SC sc;

    public SCDao(DBUtil dbUtil) {
        connection = dbUtil.getConnection();
    }

    @Override
    public void insert(SC entity) {

    }

    @Override
    public void delete(String id) {

    }

    @Override
    public void update(SC entity, String id) {

    }

    @Override
    public ResultSet selectById(String id) {
        String sql = "SELECT [SJZ].SC.cno,[SJZ].Course.cname,[SJZ].SC.tname, [SJZ].SC.grade,[SJZ].SC.term " +
                "FROM [SJZ].SC,[SJZ].Student,[SJZ].Course " +
                "WHERE [SJZ].SC.sno = [SJZ].Student.sno AND [SJZ].SC.cno = [SJZ].Course.cno AND [SJZ].SC.sno=?";
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

    public ResultSet selectByTeaNo(String TeaNo) {
        String sql = "SELECT DISTINCT SC.cno,Course.cname,SC.sno,Student.sname,SC.grade,SC.term " +
                "FROM [SJZ].SC, [SJZ].Course, [SJZ].Student, [SJZ].Teacher " +
                "WHERE SC.cno = Course.cno AND SC.sno = Student.sno AND Teacher.tname = SC.tname AND Teacher.tno = ?";
        try {
            preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            preparedStatement.setObject(1, TeaNo);
            resultSet = preparedStatement.executeQuery();
            return resultSet;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    @Override
    public ResultSet selectAll(int role) {
        String sql = "SELECT * FROM [SJZ].SC";
        try {
            if (role == BaseDao.USER_ROLE_ADMIN) {
                preparedStatement = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
