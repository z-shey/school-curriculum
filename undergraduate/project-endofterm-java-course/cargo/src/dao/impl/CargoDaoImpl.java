package dao.impl;

import dao.CargoDao;
import entity.Cargo;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import util.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class CargoDaoImpl implements CargoDao {
    private final QueryRunner queryRunner = new QueryRunner();

    @Override
    public List<Cargo> selectAllCargo() {
        String sql = "SELECT * FROM cargo";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanListHandler<>(Cargo.class));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Cargo selectById(Integer CargoID) {
        String sql = "SELECT * FROM cargo WHERE CargoID=?";
        try (Connection connection = DBUtil.getConnection()) {
            return queryRunner.query(connection, sql, new BeanHandler<>(Cargo.class), CargoID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void insert(Cargo cargo) {
        String sql = "INSERT INTO cargo VALUES(DEFAULT,?,?,?,?,?)";
        try (Connection connection = DBUtil.getConnection()) {
            queryRunner.update(connection, sql,
                    cargo.getCargoName(),
                    cargo.getCargoPrice(),
                    cargo.getCargoTypeID(),
                    cargo.getWarehouseID(),
                    cargo.getCargoRemark()
            );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void update(Cargo cargo) {
        String sql = "UPDATE cargo SET CargoName=?, CargoPrice=?, CargoTypeID=?, WarehouseID=?, CargoRemark=? WHERE CargoID=?";
        try (Connection connection = DBUtil.getConnection()) {
            queryRunner.update(connection, sql,
                    cargo.getCargoName(),
                    cargo.getCargoPrice(),
                    cargo.getCargoTypeID(),
                    cargo.getWarehouseID(),
                    cargo.getCargoRemark(),
                    cargo.getCargoID()
            );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(Integer CargoID) {
        String sql = "DELETE FROM cargo WHERE CargoID=?";
        try (Connection connection = DBUtil.getConnection()) {
            queryRunner.update(connection, sql, CargoID);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
