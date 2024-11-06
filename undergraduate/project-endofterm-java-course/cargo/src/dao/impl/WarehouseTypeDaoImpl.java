package dao.impl;

import dao.WarehouseTypeDao;
import entity.CargoType;
import entity.WarehouseType;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class WarehouseTypeDaoImpl implements WarehouseTypeDao {
    private final QueryRunner queryRunner = new QueryRunner();
    @Override
    public List<WarehouseType> selectAllWarehouseType() {
        String sql = "SELECT * FROM warehousetype";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanListHandler<>(WarehouseType.class));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public WarehouseType selectById(Integer WarehouseTypeID) {
        String sql = "SELECT * FROM warehousetype WHERE WarehouseTypeID=?";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanHandler<>(WarehouseType.class), WarehouseTypeID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
