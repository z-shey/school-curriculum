package entity;

public class Staff {
    private Integer StaffID;
    private String StaffName;
    private String Username;
    private Integer RoleID;
    private String Password;
    private Integer WarehouseID;
    private Integer DistrictID;
    private String StaffRemark;

    public Staff() {
    }

    public Staff(Integer staffID, String staffName, String username, Integer roleID, String password, Integer warehouseID, Integer districtID, String staffRemark) {
        StaffID = staffID;
        StaffName = staffName;
        Username = username;
        RoleID = roleID;
        Password = password;
        WarehouseID = warehouseID;
        DistrictID = districtID;
        StaffRemark = staffRemark;
    }

    public Integer getStaffID() {
        return StaffID;
    }

    public void setStaffID(Integer staffID) {
        StaffID = staffID;
    }

    public String getStaffName() {
        return StaffName;
    }

    public void setStaffName(String staffName) {
        StaffName = staffName;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }

    public Integer getRoleID() {
        return RoleID;
    }

    public void setRoleID(Integer roleID) {
        RoleID = roleID;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public Integer getWarehouseID() {
        return WarehouseID;
    }

    public void setWarehouseID(Integer warehouseID) {
        WarehouseID = warehouseID;
    }

    public Integer getDistrictID() {
        return DistrictID;
    }

    public void setDistrictID(Integer districtID) {
        DistrictID = districtID;
    }

    public String getStaffRemark() {
        return StaffRemark;
    }

    public void setStaffRemark(String staffRemark) {
        StaffRemark = staffRemark;
    }
}
