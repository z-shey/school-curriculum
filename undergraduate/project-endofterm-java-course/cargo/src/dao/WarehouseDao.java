package dao;

import entity.Warehouse;

import java.util.List;

public interface WarehouseDao {
    List<Warehouse> selectAllWarehouse();

    Warehouse selectById(Integer WarehouseID);

    void insert(Warehouse warehouse);

    void update(Warehouse warehouse);

    void delete(Integer WarehouseID);

   Long countCargo(Integer WarehouseID);
}
