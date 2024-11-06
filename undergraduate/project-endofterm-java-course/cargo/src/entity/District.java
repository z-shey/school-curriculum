package entity;

public class District {
    private Integer DistrictID;
    private String DistrictName;
    private Integer WarehouseNumber;
    private Integer UserNumber;

    public District() {
    }

    public District(Integer districtID, String districtName, Integer warehouseNumber, Integer userNumber) {
        DistrictID = districtID;
        DistrictName = districtName;
        WarehouseNumber = warehouseNumber;
        UserNumber = userNumber;
    }

    public Integer getDistrictID() {
        return DistrictID;
    }

    public void setDistrictID(Integer districtID) {
        DistrictID = districtID;
    }

    public String getDistrictName() {
        return DistrictName;
    }

    public void setDistrictName(String districtName) {
        DistrictName = districtName;
    }

    public Integer getWarehouseNumber() {
        return WarehouseNumber;
    }

    public void setWarehouseNumber(Integer warehouseNumber) {
        WarehouseNumber = warehouseNumber;
    }

    public Integer getUserNumber() {
        return UserNumber;
    }

    public void setUserNumber(Integer userNumber) {
        UserNumber = userNumber;
    }
}
