package service;

import entity.CargoType;

import java.util.List;

public interface CargoTypeService {
    List<CargoType> selectAllCargoType();

    CargoType selectById(Integer CargoTypeID);
}
