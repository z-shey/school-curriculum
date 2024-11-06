package dao;

import entity.Cargo;

import java.util.List;

public interface CargoDao {
    List<Cargo> selectAllCargo();

    Cargo selectById(Integer CargoID);

    void insert(Cargo cargo);

    void update(Cargo cargo);

    void delete(Integer CargoID);
}
