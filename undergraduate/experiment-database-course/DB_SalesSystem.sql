-- 创建商品销售数据库
CREATE DATABASE SalesSystem;

-- 选择数据库
USE SalesSystem;

-- 创建产品关系
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    PurchasePrice DECIMAL(10, 2),
    Stock INT,
    SalePrice DECIMAL(10, 2),
    ManufacturerID INT,
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
);

-- 创建顾客关系
CREATE TABLE Customers (
    CardNumber INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(20),
    Points INT
);

-- 创建厂商编号
CREATE TABLE Manufacturers (
    ManufacturerID INT PRIMARY KEY,
    Address VARCHAR(200),
    Name VARCHAR(100),
    Phone VARCHAR(20)
);

-- 创建销售
CREATE TABLE Sales (
    CustomerCardNumber INT,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (CustomerCardNumber) REFERENCES Customers(CardNumber),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
