-- 医院药品管理数据库
CREATE DATABASE DrugManagement;

USE DrugManagement;

-- 药品
CREATE TABLE Drugs (
    DrugID INT PRIMARY KEY, -- 药品编号
    DrugName VARCHAR(100), -- 药品名称
    Price DECIMAL(10, 2), -- 价格
    Manufacturer VARCHAR(100) -- 厂商
);

-- 处方
CREATE TABLE Prescriptions (
    DrugID INT, -- 药品编号
    Quantity INT, -- 数量
    DoctorID INT, -- 医生编号
    FOREIGN KEY (DrugID) REFERENCES Drugs(DrugID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- 医生
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(100),
    Department VARCHAR(100), -- 科室
    Title VARCHAR(100) -- 职称
);
