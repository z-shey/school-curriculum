package dao;

import entity.CargoType;

import java.util.List;

public interface CargoTypeDao {
    List<CargoType> selectAllCargoType();
    CargoType selectById(Integer CargoTypeID);
}
