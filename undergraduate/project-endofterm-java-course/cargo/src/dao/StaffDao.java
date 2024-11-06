package dao;

import entity.Staff;

import java.util.List;

public interface StaffDao {
    List<Staff> selectAllStaff();

    Staff selectById(Integer StaffID);

    Staff selectByUsernameAndPassword(String Username, String Password);

    void insert(Staff staff);

    void update(Staff staff);

    void delete(Integer StaffID);

    Integer selectStaffNumber(Integer role);

}
