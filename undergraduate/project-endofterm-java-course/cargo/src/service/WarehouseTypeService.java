package service;

import entity.WarehouseType;

import java.util.List;

public interface WarehouseTypeService {
    List<WarehouseType> selectAllWarehouseType();

    WarehouseType selectById(Integer WarehouseTypeID);
}
