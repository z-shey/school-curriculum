package service.impl;

import dao.RoleDao;
import dao.impl.RoleDaoImpl;
import entity.Role;
import service.RoleService;

import java.util.List;

public class RoleServiceImpl implements RoleService {
    RoleDao roleDao = new RoleDaoImpl();
    @Override
    public List<Role> selectAllRole() {
        return roleDao.selectAllRole();
    }

    @Override
    public Role selectById(Integer RoleID) {
        return roleDao.selectById(RoleID);
    }
}
