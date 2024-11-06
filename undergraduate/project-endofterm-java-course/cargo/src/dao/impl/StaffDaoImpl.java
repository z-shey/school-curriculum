package dao.impl;

import dao.StaffDao;
import entity.Staff;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class StaffDaoImpl implements StaffDao {
    private final QueryRunner queryRunner = new QueryRunner();

    @Override
    public List<Staff> selectAllStaff() {
        String sql = "SELECT * FROM staff";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanListHandler<>(Staff.class));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Staff selectById(Integer StaffID) {
        String sql = "SELECT * FROM staff WHERE StaffID=?";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanHandler<>(Staff.class), StaffID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Staff selectByUsernameAndPassword(String Username, String Password) {
        String sql = "SELECT * FROM staff WHERE Username=? AND Password=?";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanHandler<>(Staff.class), Username, Password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void insert(Staff staff) {
        String sql = "INSERT INTO staff VALUES(DEFAULT,?,?,?,?,?,?,?)";
        try (Connection connection = DBUtil.getConnection()) {
            queryRunner.update(connection, sql,
                    staff.getStaffName(),
                    staff.getUsername(),
                    staff.getRoleID(),
                    staff.getPassword(),
                    staff.getWarehouseID(),
                    staff.getDistrictID(),
                    staff.getStaffRemark());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void update(Staff staff) {
        String sql = "UPDATE staff SET StaffName=?, Username=?, RoleID=?, Password=? , WarehouseID=? , DistrictID=?, StaffRemark=? WHERE StaffID=?";
        try (Connection connection = DBUtil.getConnection()) {
            queryRunner.update(connection, sql,
                    staff.getStaffName(),
                    staff.getUsername(),
                    staff.getRoleID(),
                    staff.getPassword(),
                    staff.getWarehouseID(),
                    staff.getDistrictID(),
                    staff.getStaffRemark(),
                    staff.getStaffID());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(Integer StaffID) {
        String sql = "DELETE FROM staff WHERE StaffID=?";
        try (Connection connection = DBUtil.getConnection()) {
            queryRunner.update(connection, sql, StaffID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Integer selectStaffNumber(Integer role) {
        return 0;
    }
}
