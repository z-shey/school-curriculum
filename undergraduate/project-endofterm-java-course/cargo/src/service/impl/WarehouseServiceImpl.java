package service.impl;


import dao.WarehouseDao;
import dao.impl.WarehouseDaoImpl;
import entity.Cargo;
import entity.Warehouse;
import service.WarehouseService;

import java.util.List;

public class WarehouseServiceImpl implements WarehouseService {
    WarehouseDao warehouseDao = new WarehouseDaoImpl();

    @Override
    public List<Warehouse> selectAllWarehouse() {
        return warehouseDao.selectAllWarehouse();
    }

    @Override
    public Warehouse selectById(Integer WarehouseID) {
        return warehouseDao.selectById(WarehouseID);
    }

    @Override
    public void update(Warehouse warehouse) {
        warehouseDao.update(warehouse);
    }

    @Override
    public void delete(Integer WarehouseID) {
        warehouseDao.delete(WarehouseID);
    }

    @Override
    public void insert(Warehouse warehouse) {
        warehouseDao.insert(warehouse);
    }

    public Integer getCargoCount(Integer WarehouseId) {
        int count = 0;
        for (Cargo cargo : new CargoServiceImpl().selectAllCargo()) {
            if (cargo.getWarehouseID() == WarehouseId) {
                count++;
            }
        }

        return count;
    }
}
