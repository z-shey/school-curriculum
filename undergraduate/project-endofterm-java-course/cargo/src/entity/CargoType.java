package entity;

public class CargoType {
    private Integer CargoTypeID;
    private String CargoTypeName;
    private Integer CargoQuantity;

    public CargoType() {
    }

    public CargoType(Integer cargoTypeID, String cargoTypeName, Integer cargoQuantity) {
        CargoTypeID = cargoTypeID;
        CargoTypeName = cargoTypeName;
        CargoQuantity = cargoQuantity;
    }

    public Integer getCargoTypeID() {
        return CargoTypeID;
    }

    public void setCargoTypeID(Integer cargoTypeID) {
        CargoTypeID = cargoTypeID;
    }

    public String getCargoTypeName() {
        return CargoTypeName;
    }

    public void setCargoTypeName(String cargoTypeName) {
        CargoTypeName = cargoTypeName;
    }

    public Integer getCargoQuantity() {
        return CargoQuantity;
    }

    public void setCargoQuantity(Integer cargoQuantity) {
        CargoQuantity = cargoQuantity;
    }
}
