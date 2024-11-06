package dao.impl;

import dao.CargoTypeDao;
import entity.CargoType;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class CargoTypeDaoImpl implements CargoTypeDao {
    private final QueryRunner queryRunner = new QueryRunner();
    @Override
    public List<CargoType> selectAllCargoType() {
        String sql = "SELECT * FROM cargotype";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanListHandler<>(CargoType.class));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public CargoType selectById(Integer CargoTypeID) {
        String sql = "SELECT * FROM cargotype WHERE CargoTypeID=?";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanHandler<>(CargoType.class), CargoTypeID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
