package dao.impl;

import dao.RoleDao;
import entity.Role;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class RoleDaoImpl implements RoleDao {
    private final QueryRunner queryRunner = new QueryRunner();
    @Override
    public List<Role> selectAllRole() {
        String sql = "SELECT * FROM role";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanListHandler<>(Role.class));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Role selectById(Integer RoleID) {
        String sql = "SELECT * FROM role WHERE RoleID=?";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanHandler<>(Role.class), RoleID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
