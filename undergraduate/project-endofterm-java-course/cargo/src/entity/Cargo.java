package entity;

public class Cargo {
    private Integer CargoID;
    private String CargoName;
    private Double CargoPrice;
    private Integer CargoTypeID;
    private Integer WarehouseID;
    private String CargoRemark;

    public Cargo() {
    }

    public Cargo(Integer cargoID, String cargoName, Double cargoPrice, Integer cargoTypeID, Integer warehouseID, String cargoRemark) {
        CargoID = cargoID;
        CargoName = cargoName;
        CargoPrice = cargoPrice;
        CargoTypeID = cargoTypeID;
        WarehouseID = warehouseID;
        CargoRemark = cargoRemark;
    }

    public Integer getCargoID() {
        return CargoID;
    }

    public void setCargoID(Integer cargoID) {
        CargoID = cargoID;
    }

    public String getCargoName() {
        return CargoName;
    }

    public void setCargoName(String cargoName) {
        CargoName = cargoName;
    }

    public Double getCargoPrice() {
        return CargoPrice;
    }

    public void setCargoPrice(Double cargoPrice) {
        CargoPrice = cargoPrice;
    }

    public Integer getCargoTypeID() {
        return CargoTypeID;
    }

    public void setCargoTypeID(Integer cargoTypeID) {
        CargoTypeID = cargoTypeID;
    }

    public Integer getWarehouseID() {
        return WarehouseID;
    }

    public void setWarehouseID(Integer warehouseID) {
        WarehouseID = warehouseID;
    }

    public String getCargoRemark() {
        return CargoRemark;
    }

    public void setCargoRemark(String cargoRemark) {
        CargoRemark = cargoRemark;
    }
}
