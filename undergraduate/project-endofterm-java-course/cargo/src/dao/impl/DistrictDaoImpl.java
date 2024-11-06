package dao.impl;

import dao.DistrictDao;
import entity.District;
import entity.Staff;
import entity.Warehouse;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import service.impl.StaffServiceImpl;
import service.impl.WarehouseServiceImpl;
import util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class DistrictDaoImpl implements DistrictDao {
    private final QueryRunner queryRunner = new QueryRunner();

    @Override
    public List<District> selectAllDistrict() {
        String sql = "SELECT * FROM district";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanListHandler<>(District.class));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public District selectById(Integer DistrictID) {
        String sql = "SELECT * FROM district WHERE DistrictID=?";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanHandler<>(District.class), DistrictID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Integer selectWarehouseNumber() {
        List<Warehouse> warehouseList = new WarehouseServiceImpl().selectAllWarehouse();
        int count = 0;
        for (Warehouse warehouse : warehouseList) {
            count++;
        }
        return count;
    }

    @Override
    public Integer selectWarehouseNumber(Integer DistrictID) {
        List<Warehouse> warehouseList = new WarehouseServiceImpl().selectAllWarehouse();
        int count = 0;
        for (Warehouse warehouse : warehouseList) {
            if (warehouse.getDistrictID() == DistrictID) {
                count++;
            }
        }
        return count;
    }

    @Override
    public Integer selectStaffNumber() {
        List<Staff> staffList = new StaffServiceImpl().selectAllStaff();
        int count = 0;
        for (Staff staff : staffList) {
            count++;
        }
        return count;
    }

    @Override
    public Integer selectStaffNumber(Integer DistrictID) {
        List<Staff> staffList = new StaffServiceImpl().selectAllStaff();
        int count = 0;
        for (Staff staff : staffList) {
            if (staff.getDistrictID() == DistrictID) {
                count++;
            }
        }
        return count;
    }
}
