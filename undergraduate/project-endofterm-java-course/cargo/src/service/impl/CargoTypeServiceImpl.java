package service.impl;


import dao.CargoTypeDao;
import dao.impl.CargoTypeDaoImpl;
import entity.CargoType;
import service.CargoTypeService;

import java.util.List;

public class CargoTypeServiceImpl implements CargoTypeService {
    CargoTypeDao cargoTypeDao = new CargoTypeDaoImpl();

    @Override
    public List<CargoType> selectAllCargoType() {
        return cargoTypeDao.selectAllCargoType();
    }

    @Override
    public CargoType selectById(Integer CargoTypeID) {
        return cargoTypeDao.selectById(CargoTypeID);
    }
}
