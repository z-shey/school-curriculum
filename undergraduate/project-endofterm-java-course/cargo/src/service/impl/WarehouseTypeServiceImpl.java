package service.impl;


import dao.WarehouseTypeDao;
import dao.impl.WarehouseTypeDaoImpl;
import entity.WarehouseType;
import service.WarehouseTypeService;

import java.util.List;

public class WarehouseTypeServiceImpl implements WarehouseTypeService {
    WarehouseTypeDao warehouseTypeDao = new WarehouseTypeDaoImpl();

    @Override
    public List<WarehouseType> selectAllWarehouseType() {
        return warehouseTypeDao.selectAllWarehouseType();
    }

    @Override
    public WarehouseType selectById(Integer WarehouseTypeID) {
        return warehouseTypeDao.selectById(WarehouseTypeID);
    }
}
