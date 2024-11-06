package entity;

public class Warehouse {
    private Integer WarehouseID;
    private String WarehouseName;
    private Integer WarehouseType;
    private Integer DistrictID;
    private String WarehouseLocation;
    private Integer StaffNumber;
    private Integer CargoNumber;
    private String WarehouseRemark;

    public Warehouse() {
    }

    public Warehouse(Integer warehouseID, String warehouseName, Integer warehouseType, Integer districtID, String warehouseLocation, Integer staffNumber, Integer cargoNumber, String warehouseRemark) {
        WarehouseID = warehouseID;
        WarehouseName = warehouseName;
        WarehouseType = warehouseType;
        DistrictID = districtID;
        WarehouseLocation = warehouseLocation;
        StaffNumber = staffNumber;
        CargoNumber = cargoNumber;
        WarehouseRemark = warehouseRemark;
    }

    public Integer getWarehouseID() {
        return WarehouseID;
    }

    public void setWarehouseID(Integer warehouseID) {
        WarehouseID = warehouseID;
    }

    public String getWarehouseName() {
        return WarehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        WarehouseName = warehouseName;
    }

    public Integer getWarehouseType() {
        return WarehouseType;
    }

    public void setWarehouseType(Integer warehouseType) {
        WarehouseType = warehouseType;
    }

    public Integer getDistrictID() {
        return DistrictID;
    }

    public void setDistrictID(Integer districtID) {
        DistrictID = districtID;
    }

    public String getWarehouseLocation() {
        return WarehouseLocation;
    }

    public void setWarehouseLocation(String warehouseLocation) {
        WarehouseLocation = warehouseLocation;
    }

    public Integer getStaffNumber() {
        return StaffNumber;
    }

    public void setStaffNumber(Integer staffNumber) {
        StaffNumber = staffNumber;
    }

    public Integer getCargoNumber() {
        return CargoNumber;
    }

    public void setCargoNumber(Integer cargoNumber) {
        CargoNumber = cargoNumber;
    }

    public String getWarehouseRemark() {
        return WarehouseRemark;
    }

    public void setWarehouseRemark(String warehouseRemark) {
        WarehouseRemark = warehouseRemark;
    }
}
