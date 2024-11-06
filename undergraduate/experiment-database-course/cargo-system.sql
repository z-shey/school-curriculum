CREATE DATABASE cargo_db;

USE cargo_db;

-- 片区表
CREATE TABLE IF NOT EXISTS district
(
    district_id          INT AUTO_INCREMENT PRIMARY KEY, -- 片区id
    district_name        VARCHAR(255) NOT NULL,          -- 片区名称
    district_description VARCHAR(255)                    -- 片区描述
);

-- 货物类型表
CREATE TABLE IF NOT EXISTS cargo_type
(
    cargo_type_id          INT AUTO_INCREMENT PRIMARY KEY, -- 类型id
    cargo_type_name        VARCHAR(255) NOT NULL,          -- 类型名称
    cargo_type_description VARCHAR(255),                   -- 货物类型描述
    cargo_stock            DOUBLE DEFAULT 0                -- 货物类型数量
);

-- 仓库类型表
CREATE TABLE IF NOT EXISTS warehouse_type
(
    warehouse_type_id          INT AUTO_INCREMENT PRIMARY KEY, -- 类型id
    warehouse_type_name        VARCHAR(255) NOT NULL,          -- 仓库类型名
    warehouse_type_description VARCHAR(255) DEFAULT '无描述'   -- 仓库类型描述
);

-- 仓库表
CREATE TABLE IF NOT EXISTS warehouse
(
    warehouse_id          INT AUTO_INCREMENT PRIMARY KEY, -- 仓库id
    warehouse_name        VARCHAR(255) NOT NULL,          -- 仓库名称
    warehouse_type        INT          NOT NULL,          -- 仓库类型
    district_id           INT          NOT NULL,          -- 所在片区id
    warehouse_location    VARCHAR(255) NOT NULL,          -- 仓库地址
    warehouse_description VARCHAR(255) DEFAULT '无描述',  -- 仓库描述
    FOREIGN KEY (district_id) REFERENCES district (district_id),
    FOREIGN KEY (warehouse_type) REFERENCES warehouse_type (warehouse_type_id)
);

-- 货物表
CREATE TABLE IF NOT EXISTS cargo
(
    cargo_id          INT AUTO_INCREMENT PRIMARY KEY, -- 货物id
    cargo_name        VARCHAR(255) NOT NULL,          -- 货物名称
    cargo_price       DOUBLE       NOT NULL,          -- 货物价格
    cargo_type_id     INT          NOT NULL,          -- 货物类型
    warehouse_id      INT          NOT NULL,          -- 所在仓库id
    cargo_description VARCHAR(255) DEFAULT '无描述',
    FOREIGN KEY (cargo_type_id) REFERENCES cargo_type (cargo_type_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id)
);

-- 角色表
CREATE TABLE IF NOT EXISTS role
(
    role_id          INT AUTO_INCREMENT PRIMARY KEY, -- 角色id
    role_name        VARCHAR(255) NOT NULL,          -- 权限角色
    role_description VARCHAR(255) DEFAULT '无描述'
);


-- 人员表
CREATE TABLE IF NOT EXISTS staff
(
    staff_id          INT AUTO_INCREMENT PRIMARY KEY,         -- 员工id
    staff_name        VARCHAR(255)        NOT NULL,           -- 员工名
    staff_username    VARCHAR(255) UNIQUE NOT NULL,           -- 员工用户名
    staff_password    VARCHAR(255)        NOT NULL,           -- 员工密码
    role_id           INT                 NOT NULL,           -- 员工身份
    warehouse_id      INT                 NOT NULL,           -- 员工所属仓库
    hire_date         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP, -- 员工入职日期
    login_time        TIMESTAMP,                              -- 员工登入时间
    logout_time       TIMESTAMP,                              -- 员工登出时间
    staff_description VARCHAR(255) DEFAULT '无描述',          -- 员工描述
    staff_years       INT          DEFAULT 0,                 -- 自动计算的工龄字段
    FOREIGN KEY (role_id) REFERENCES role (role_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id)
);

-- 供应商表
CREATE TABLE IF NOT EXISTS supplier
(
    supplier_id          INT AUTO_INCREMENT PRIMARY KEY, -- 供应商id
    supplier_name        VARCHAR(255) NOT NULL,          -- 供应商名称
    supplier_contact     VARCHAR(255) NOT NULL,          -- 供应商联系方式
    supplier_address     VARCHAR(255) NOT NULL,          -- 供应商地址
    supplier_description VARCHAR(255) DEFAULT '无描述'   -- 供应商描述
);

CREATE TABLE IF NOT EXISTS manage_status
(
    status_id          INT AUTO_INCREMENT PRIMARY KEY, -- 状态id
    status             VARCHAR(50) NOT NULL,           -- 状态
    status_description VARCHAR(255) DEFAULT '无描述'
);

-- 入库订单表
CREATE TABLE IF NOT EXISTS inbound_order
(
    order_id                  INT AUTO_INCREMENT PRIMARY KEY,         -- 入库订单id
    order_date                TIMESTAMP    DEFAULT CURRENT_TIMESTAMP, -- 下单日期
    cargo_id                  INT  NOT NULL,                          -- 货物id
    order_quantity            INT          DEFAULT 0,                 -- 订购数量
    order_total_price         DOUBLE       DEFAULT 0,                 -- 订单总价
    delivery_date             DATE NOT NULL,                          -- 交货日期
    order_status              INT          DEFAULT 0,                 -- 订单状态
    supplier_id               INT  NOT NULL,                          -- 供应商id
    warehouse_id              INT  NOT NULL,                          -- 入库仓库id
    inbound_order_description VARCHAR(255) DEFAULT '无描述',
    FOREIGN KEY (cargo_id) REFERENCES cargo (cargo_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id),
    FOREIGN KEY (order_status) REFERENCES manage_status (status_id)
);

-- 出库订单表
CREATE TABLE IF NOT EXISTS outbound_order
(
    order_id                   INT AUTO_INCREMENT PRIMARY KEY,         -- 出库订单id
    order_date                 TIMESTAMP    DEFAULT CURRENT_TIMESTAMP, -- 下单日期
    cargo_id                   INT          NOT NULL,                  -- 货物id
    order_quantity             INT          DEFAULT 0,                 -- 订购数量
    order_total_price          DOUBLE       DEFAULT 0,                 -- 订单总价
    delivery_date              DATE         NOT NULL,                  -- 交货日期
    order_status               INT          DEFAULT 0,                 -- 订单状态
    customer_name              VARCHAR(255) NOT NULL,                  -- 客户姓名
    customer_contact           VARCHAR(255),                           -- 客户联系方式
    warehouse_id               INT          NOT NULL,                  -- 出库仓库id
    outbound_order_description VARCHAR(255) DEFAULT '无描述',
    FOREIGN KEY (cargo_id) REFERENCES cargo (cargo_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id),
    FOREIGN KEY (order_status) REFERENCES manage_status (status_id)
);

-- 订单表
CREATE TABLE IF NOT EXISTS orders
(
    order_id           INT AUTO_INCREMENT PRIMARY KEY,         -- 订单id
    order_date         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP, -- 下单日期
    cargo_id           INT  NOT NULL,                          -- 货物id
    order_quantity     INT          DEFAULT 0,                 -- 订购数量
    order_total_price  DOUBLE       DEFAULT 0,                 -- 订单总价
    delivery_date      DATE NOT NULL,                          -- 交货日期
    order_status       INT          DEFAULT 0,                 -- 订单状态
    inbound_order_id   INT,                                    -- 入库订单id
    outbound_order_id  INT,                                    -- 出库订单id
    orders_description VARCHAR(255) DEFAULT '无描述',
    FOREIGN KEY (cargo_id) REFERENCES cargo (cargo_id),
    FOREIGN KEY (inbound_order_id) REFERENCES inbound_order (order_id),
    FOREIGN KEY (outbound_order_id) REFERENCES outbound_order (order_id),
    FOREIGN KEY (order_status) REFERENCES manage_status (status_id)
);
/*******************************************************/
-- 创建触发器：计算货物类型数量
DELIMITER //
CREATE TRIGGER calculate_cargo_stock_insert
    AFTER INSERT
    ON cargo
    FOR EACH ROW
BEGIN
    UPDATE cargo_type
    SET cargo_stock = cargo_stock + 1
    WHERE cargo_type_id = NEW.cargo_type_id;
END //
CREATE TRIGGER calculate_cargo_stock_delete
    AFTER DELETE
    ON cargo
    FOR EACH ROW
BEGIN
    UPDATE cargo_type
    SET cargo_stock = cargo_stock - 1
    WHERE cargo_type_id = OLD.cargo_type_id;
END //
DELIMITER ;

-- 创建触发器：计算orders订单货物价格
DELIMITER //
CREATE TRIGGER calculate_order_total_price
    BEFORE INSERT
    ON orders
    FOR EACH ROW
BEGIN
    DECLARE price DOUBLE;
    SELECT cargo_price INTO price FROM cargo WHERE cargo_id = NEW.cargo_id;
    SET NEW.order_total_price = price * NEW.order_quantity;
END //
DELIMITER ;
-- 创建触发器：计算inbound_order订单货物价格
DELIMITER //
CREATE TRIGGER calculate_order_total_price
    BEFORE INSERT
    ON inbound_order
    FOR EACH ROW
BEGIN
    DECLARE price DOUBLE;
    SELECT cargo_price INTO price FROM cargo WHERE cargo_id = NEW.cargo_id;
    SET NEW.order_total_price = price * NEW.order_quantity;
END //
DELIMITER ;
-- 创建触发器：计算outbound_order订单货物价格
DELIMITER //
CREATE TRIGGER calculate_order_total_price
    BEFORE INSERT
    ON outbound_order
    FOR EACH ROW
BEGIN
    DECLARE price DOUBLE;
    SELECT cargo_price INTO price FROM cargo WHERE cargo_id = NEW.cargo_id;
    SET NEW.order_total_price = price * NEW.order_quantity;
END //
DELIMITER ;
/*******************************************************/

-- 插入片区数据
INSERT INTO district (district_name, district_description)
VALUES ('片区1', '这是片区1的描述'),
       ('片区2', '这是片区2的描述'),
       ('片区3', '这是片区3的描述'),
       ('片区4', '这是片区4的描述'),
       ('片区5', '这是片区5的描述');

-- 插入货物类型数据
INSERT INTO cargo_type (cargo_type_name, cargo_type_description)
VALUES ('类型1', '这是类型1的描述'),
       ('类型2', '这是类型2的描述'),
       ('类型3', '这是类型3的描述'),
       ('类型4', '这是类型4的描述');

-- 插入仓库类型数据
INSERT INTO warehouse_type (warehouse_type_name, warehouse_type_description)
VALUES ('仓库类型1', '这是仓库类型1的描述'),
       ('仓库类型2', '这是仓库类型2的描述'),
       ('仓库类型3', '这是仓库类型3的描述'),
       ('仓库类型4', '这是仓库类型4的描述');

-- 插入仓库数据
INSERT INTO warehouse (warehouse_name, warehouse_type, district_id, warehouse_location,
                       warehouse_description)
VALUES ('仓库1', 1, 1, '地址1', '这是仓库1的描述'),
       ('仓库2', 2, 2, '地址2', '这是仓库2的描述');

-- 插入货物数据
INSERT INTO cargo (cargo_name, cargo_price, cargo_type_id, warehouse_id, cargo_description)
VALUES ('货物1', 10, 1, 1, '这是货物1的描述'),
       ('货物2', 20, 2, 2, '这是货物2的描述');

-- 插入角色数据
INSERT INTO role (role_name, role_description)
VALUES ('角色1', '这是角色1的描述'),
       ('角色2', '这是角色2的描述');

-- 插入人员数据
INSERT INTO staff (staff_name, staff_username, staff_password, role_id, warehouse_id, hire_date, login_time,
                   logout_time, staff_description)
VALUES ('员工1', 'username1', 'password1', 1, 1, '2023-01-01', '2023-01-01 08:00:00', '2023-01-01 17:00:00',
        '这是员工1的描述'),
       ('员工2', 'username2', 'password2', 2, 2, '2023-01-01', '2023-01-01 09:00:00', '2023-01-01 18:00:00',
        '这是员工2的描述');

-- 插入供应商数据
INSERT INTO supplier (supplier_name, supplier_contact, supplier_address, supplier_description)
VALUES ('供应商1', '联系方式1', '地址1', '这是供应商1的描述'),
       ('供应商2', '联系方式2', '地址2', '这是供应商2的描述');

-- 插入管理状态数据
INSERT INTO manage_status (status, status_description)
VALUES ('状态1', '这是状态1的描述'),
       ('状态2', '这是状态2的描述');

-- 插入入库订单数据
INSERT INTO inbound_order (order_date, cargo_id, order_quantity, order_total_price, delivery_date,
                           order_status,
                           supplier_id, warehouse_id, inbound_order_description)
VALUES ('2023-01-01', 1, 10, 50, '2023-02-01', 1, 1, 1, '这是入库订单1的描述'),
       ('2023-01-02', 2, 20, 50, '2023-02-02', 2, 2, 2, '这是入库订单2的描述');

-- 插入出库订单数据
INSERT INTO outbound_order (order_date, cargo_id, order_quantity, order_total_price, delivery_date,
                            order_status,
                            customer_name, customer_contact, warehouse_id, outbound_order_description)
VALUES ('2023-01-01', 1, 10, 50, '2023-02-01', 1, '客户1', '联系方式1', 1, '这是出库订单1的描述'),
       ('2023-01-02', 2, 20, 50, '2023-02-02', 2, '客户2', '联系方式2', 2, '这是出库订单2的描述');

-- 插入订单数据
INSERT INTO orders (order_date, cargo_id, order_quantity, order_total_price, delivery_date, order_status,
                    inbound_order_id, outbound_order_id, orders_description)
VALUES ('2023-01-01', 1, 10, 50, '2023-02-01', 1, 1, 1, '这是订单1的描述'),
       ('2023-01-02', 2, 20, 50, '2023-02-02', 2, 2, 1, '这是订单2的描述');