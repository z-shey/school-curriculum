package service;

import entity.Cargo;

import java.util.List;

public interface CargoService {
    List<Cargo> selectAllCargo();

    Cargo selectById(Integer CargoID);

    void update(Cargo cargo);

    void delete(Integer CargoID);

    void insert(Cargo cargo);
}
