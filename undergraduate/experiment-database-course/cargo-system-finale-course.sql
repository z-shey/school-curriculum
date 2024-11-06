CREATE DATABASE e_cargo;

USE e_cargo;


-- 片区表
CREATE TABLE IF NOT EXISTS District
(
    DistrictID      INT AUTO_INCREMENT PRIMARY KEY,
    DistrictName    VARCHAR(255) NOT NULL,
    WarehouseNumber INT DEFAULT 0,
    UserNumber      INT DEFAULT 0
);

-- 货物类型表
CREATE TABLE IF NOT EXISTS CargoType
(
    CargoTypeID   INT AUTO_INCREMENT PRIMARY KEY,
    CargoTypeName VARCHAR(255) NOT NULL,
    CargoQuantity INT DEFAULT 0
);

-- 仓库类型表
CREATE TABLE IF NOT EXISTS WarehouseType
(
    WarehouseTypeID   INT AUTO_INCREMENT PRIMARY KEY,
    WarehouseTypeName VARCHAR(255) NOT NULL,
    WarehouseQuantity INT DEFAULT 0
);

-- 仓库表
CREATE TABLE IF NOT EXISTS Warehouse
(
    WarehouseID       INT AUTO_INCREMENT PRIMARY KEY,
    WarehouseName     VARCHAR(255) NOT NULL,
    WarehouseType     INT          NOT NULL,
    DistrictID        INT,
    WarehouseLocation VARCHAR(255) NOT NULL,
    StaffNumber       INT          DEFAULT 0,
    CargoNumber       INT          DEFAULT 0,
    WarehouseRemark   VARCHAR(255) DEFAULT '无',
    FOREIGN KEY (DistrictID) REFERENCES District (DistrictID),
    FOREIGN KEY (WarehouseType) REFERENCES WarehouseType (WarehouseTypeID)
);

-- 货物表
CREATE TABLE IF NOT EXISTS Cargo
(
    CargoID     INT AUTO_INCREMENT PRIMARY KEY,
    CargoName   VARCHAR(255) NOT NULL,
    CargoPrice  DOUBLE       NOT NULL,
    CargoTypeID INT,
    WarehouseID INT,
    CargoRemark VARCHAR(255) DEFAULT '无',
    FOREIGN KEY (CargoTypeID) REFERENCES CargoType (CargoTypeID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse (WarehouseID)
);

-- 角色表
CREATE TABLE IF NOT EXISTS Role
(
    RoleID         INT AUTO_INCREMENT PRIMARY KEY,
    RoleIdentifier VARCHAR(255) NOT NULL,
    RoleName       VARCHAR(255) NOT NULL,
    RoleNumber     INT DEFAULT 0
);


-- 人员表
CREATE TABLE IF NOT EXISTS Staff
(
    StaffID     INT AUTO_INCREMENT PRIMARY KEY,
    StaffName   VARCHAR(255)        NOT NULL,
    Username    VARCHAR(255) UNIQUE NOT NULL,
    RoleID      INT,
    Password    VARCHAR(255)        NOT NULL,
    WarehouseID INT,
    DistrictID  INT,
    StaffRemark VARCHAR(255) DEFAULT '无',
    FOREIGN KEY (RoleID) REFERENCES Role (RoleID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse (WarehouseID),
    FOREIGN KEY (DistrictID) REFERENCES District (DistrictID)
);

-- 插入角色数据
INSERT INTO Role (RoleIdentifier, RoleName)
VALUES ('national_admin', '全国管理员'),
       ('district_admin', '片区管理员'),
       ('warehouse_admin', '仓库管理员'),
       ('staff_admin', '员工管理员'),
       ('regular_staff', '普通员工');

-- 插入片区数据
INSERT INTO District (DistrictName)
VALUES ('A区'),
       ('B区'),
       ('C区'),
       ('D区'),
       ('E区'),
       ('F区');

INSERT INTO WarehouseType (WarehouseTypeName)
VALUES ('综合大型'),
       ('综合中型'),
       ('综合小型'),
       ('其它');

-- 插入仓库数据
INSERT INTO Warehouse (WarehouseName, WarehouseType, DistrictID, WarehouseLocation)
VALUES ('北京仓库', 1, 1, '北京市朝阳区'),
       ('上海仓库', 1, 2, '上海市浦东新区'),
       ('四川仓库', 2, 2, '暂无信息'),
       ('广东仓库', 2, 2, '暂无信息'),
       ('青海仓库', 3, 2, '暂无信息'),
       ('贵州仓库', 3, 2, '暂无信息'),
       ('云南仓库', 4, 2, '暂无信息');

-- 插入货物类型数据
INSERT INTO CargoType (CargoTypeName)
VALUES ('食品'),
       ('饮料'),
       ('家居用品'),
       ('服装'),
       ('电子产品'),
       ('工业品'),
       ('原材料'),
       ('农产品'),
       ('医药品'),
       ('汽车及零配件'),
       ('能源产品'),
       ('家具'),
       ('化妆品'),
       ('书籍和印刷品'),
       ('珠宝首饰'),
       ('运动器材'),
       ('音乐及其相关用品'),
       ('文化艺术品'),
       ('办公用品'),
       ('游戏及其相关用品'),
       ('其他');


-- 插入人员数据
INSERT INTO Staff (StaffName, Username, RoleID, Password, WarehouseID, DistrictID)
VALUES ('Admin', 'admin', 1, '123456', 8, 1),
       ('Lisi', 'lisi', 4, '123456', 9, 2);

-- 插入货物数据
INSERT INTO Cargo (CargoName, CargoPrice, CargoTypeID, WarehouseID, CargoRemark)
VALUES ('手机', 50, 1, 8, '新款智能手机'),
       ('巧克力', 100, 2, 9, '进口食品');













-- 查询权限下的人员数量
SELECT COUNT(*)
FROM staff
WHERE RoleID >= 1;

-- 查询权限下的管理人员数量
SELECT COUNT(*)
FROM staff
WHERE RoleID >= 1
  AND RoleID != 5;

-- 查询权限下的仓库的货物数量
SELECT COUNT(*)
FROM staff s,
     warehouse w
WHERE s.RoleID >= 1
  AND s.WarehouseID = w.WarehouseID;
