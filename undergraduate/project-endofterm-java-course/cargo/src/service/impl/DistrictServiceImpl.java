package service.impl;


import dao.DistrictDao;
import dao.impl.DistrictDaoImpl;
import entity.District;
import service.DistrictService;

import java.util.List;

public class DistrictServiceImpl implements DistrictService {
    DistrictDao districtDao = new DistrictDaoImpl();

    @Override
    public List<District> selectAllDistrict() {
        return districtDao.selectAllDistrict();
    }

    @Override
    public District selectById(Integer DistrictID) {
        return districtDao.selectById(DistrictID);
    }

    @Override
    public Integer selectWarehouseCount() {
        return districtDao.selectWarehouseNumber();
    }

    @Override
    public Integer selectWarehouseCount(Integer DistrictID) {
        return districtDao.selectWarehouseNumber(DistrictID);
    }

    @Override
    public Integer selectStaffCount() {
        return districtDao.selectStaffNumber();
    }

    @Override
    public Integer selectStaffCount(Integer DistrictID) {
        return districtDao.selectStaffNumber(DistrictID);
    }
}
