package entity;

public class WarehouseType {
    private Integer WarehouseTypeID;
    private String WarehouseTypeName;
    private String WarehouseQuantity;

    public WarehouseType() {
    }

    public WarehouseType(Integer warehouseTypeID, String warehouseTypeName, String warehouseQuantity) {
        WarehouseTypeID = warehouseTypeID;
        WarehouseTypeName = warehouseTypeName;
        WarehouseQuantity = warehouseQuantity;
    }

    public Integer getWarehouseTypeID() {
        return WarehouseTypeID;
    }

    public void setWarehouseTypeID(Integer warehouseTypeID) {
        WarehouseTypeID = warehouseTypeID;
    }

    public String getWarehouseTypeName() {
        return WarehouseTypeName;
    }

    public void setWarehouseTypeName(String warehouseTypeName) {
        WarehouseTypeName = warehouseTypeName;
    }

    public String getWarehouseQuantity() {
        return WarehouseQuantity;
    }

    public void setWarehouseQuantity(String warehouseQuantity) {
        WarehouseQuantity = warehouseQuantity;
    }
}
