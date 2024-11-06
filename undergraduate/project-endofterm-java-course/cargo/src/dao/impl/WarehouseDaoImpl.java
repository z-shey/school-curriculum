package dao.impl;

import dao.WarehouseDao;
import entity.Warehouse;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class WarehouseDaoImpl implements WarehouseDao {
    private final QueryRunner queryRunner = new QueryRunner();

    @Override
    public List<Warehouse> selectAllWarehouse() {
        String sql = "SELECT * FROM warehouse";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanListHandler<>(Warehouse.class));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Warehouse selectById(Integer WarehouseID) {
        String sql = "SELECT * FROM warehouse WHERE WarehouseID=?";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanHandler<>(Warehouse.class), WarehouseID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void insert(Warehouse warehouse) {
        String sql = "INSERT INTO warehouse VALUES(DEFAULT,?,?,?,?,?,?,?)";
        try (Connection connection = DBUtil.getConnection()) {
            queryRunner.update(connection, sql,
                    warehouse.getWarehouseName(),
                    warehouse.getWarehouseType(),
                    warehouse.getDistrictID(),
                    warehouse.getWarehouseLocation(),
                    warehouse.getStaffNumber(),
                    warehouse.getCargoNumber(),
                    warehouse.getWarehouseRemark()
            );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void update(Warehouse warehouse) {
        String sql = "UPDATE warehouse SET WarehouseName=?, WarehouseType=?, DistrictID=?, WarehouseLocation=? , WarehouseRemark=? WHERE WarehouseID=?";
        try (Connection connection = DBUtil.getConnection()) {
            queryRunner.update(connection, sql,
                    warehouse.getWarehouseName(),
                    warehouse.getWarehouseType(),
                    warehouse.getDistrictID(),
                    warehouse.getWarehouseLocation(),
                    warehouse.getWarehouseRemark(),
                    warehouse.getWarehouseID()
            );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(Integer WarehouseID) {
        String sql = "DELETE FROM warehouse WHERE WarehouseID=?";
        try (Connection connection = DBUtil.getConnection()) {
            queryRunner.update(connection, sql, WarehouseID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Long countCargo(Integer WarehouseID) {
        String sql = "SELECT * FROM cargo WHERE WarehouseID = ?";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new ScalarHandler<Long>(), WarehouseID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
