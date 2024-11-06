package service;

import entity.Warehouse;

import java.util.List;

public interface WarehouseService {
    List<Warehouse> selectAllWarehouse();

    Warehouse selectById(Integer WarehouseID);

    void update(Warehouse warehouse);

    void delete(Integer WarehouseID);

    void insert(Warehouse warehouse);
}
