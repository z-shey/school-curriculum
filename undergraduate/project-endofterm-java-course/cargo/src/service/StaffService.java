package service;

import entity.Staff;

import java.util.List;

public interface StaffService {
    List<Staff> selectAllStaff();

    Staff selectById(Integer StaffID);

    void update(Staff staff);

    void delete(Integer StaffID);

    void insert(Staff staff);

    Staff login(String Username, String Password);

    void register(Staff staff);
}
