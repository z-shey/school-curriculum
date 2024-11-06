package dao;

import entity.WarehouseType;

import java.util.List;

public interface WarehouseTypeDao {
    List<WarehouseType> selectAllWarehouseType();
    WarehouseType selectById(Integer WarehouseTypeID);
}
