package service.impl;

import dao.StaffDao;
import dao.impl.StaffDaoImpl;
import entity.Staff;
import service.StaffService;

import java.util.List;

public class StaffServiceImpl implements StaffService {
    StaffDao staffDao = new StaffDaoImpl();

    @Override
    public List<Staff> selectAllStaff() {
        return staffDao.selectAllStaff();
    }

    @Override
    public Staff selectById(Integer StaffID) {
        return staffDao.selectById(StaffID);
    }

    @Override
    public void update(Staff staff) {
        staffDao.update(staff);
    }

    @Override
    public void delete(Integer StaffID) {
        staffDao.delete(StaffID);
    }

    @Override
    public void insert(Staff staff) {
        staffDao.insert(staff);
    }

    @Override
    public Staff login(String Username, String Password) {
        return staffDao.selectByUsernameAndPassword(Username, Password);
    }

    @Override
    public void register(Staff staff) {
        insert(staff);
    }
}
