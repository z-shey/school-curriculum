package service;

import entity.District;

import java.util.List;

public interface DistrictService {
    List<District> selectAllDistrict();

    District selectById(Integer DistrictID);

    Integer selectWarehouseCount();

    Integer selectWarehouseCount(Integer DistrictID);

    Integer selectStaffCount();

    Integer selectStaffCount(Integer DistrictID);
}
