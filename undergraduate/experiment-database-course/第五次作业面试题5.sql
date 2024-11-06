CREATE DATABASE ALSQL;

USE ALSQL;

-- 创建 Student 表
CREATE TABLE Student
(
    student_id   INT PRIMARY KEY,
    student_name NVARCHAR(50),
    role         NVARCHAR(10)
);

-- 插入 Student 表数据
INSERT INTO Student (student_id, student_name, role)
VALUES (1, N'韩信', 'client'),
       (2, N'典韦', 'client'),
       (3, N'马超', 'deliver'),
       (4, N'甄姬', 'deliver'),
       (10, N'张良', 'deliver');

-- 创建 Order 表
CREATE TABLE Orders
(
    id         INT PRIMARY KEY,
    client_id  INT,
    deliver_id INT,
    status     NVARCHAR(20),
    request_at DATE,
    delay      INT
);

-- 插入 Order 表数据
INSERT INTO Orders (id, client_id, deliver_id, status, request_at, delay)
VALUES (1, 1, 3, 'cancelled_by_client', '2020-10-01', NULL),
       (2, 2, 4, 'cancelled_by_deliver', '2020-10-01', NULL),
       (3, 1, 4, 'completed', '2020-10-01', 0),
       (4, 2, 4, 'cancelled_by_deliver', '2020-10-01', NULL),
       (5, 1, 10, 'completed', '2020-10-01', 0),
       (6, 2, 3, 'completed', '2020-10-01', 12),
       (7, 3, 3, 'completed', '2020-10-01', 0),
       (8, 2, 10, 'completed', '2020-10-01', 31),
       (9, 1, 10, 'completed', '2020-10-01', 30),
       (10, 2, 10, 'completed', '2020-10-01', 0),
       (11, 1, 10, 'completed', '2020-10-01', 0),
       (12, 2, 10, 'completed', '2020-10-01', 0),
       (13, 1, 10, 'completed', '2020-10-01', 0),
       (14, 2, 10, 'completed', '2020-10-01', 0),
       (15, 1, 10, 'completed', '2020-10-01', 0),
       (16, 2, 10, 'completed', '2020-10-01', 0),
       (17, 1, 10, 'completed', '2020-10-01', 0),
       (18, 2, 10, 'completed', '2020-10-01', 0),
       (19, 1, 10, 'completed', '2020-10-01', 0),
       (20, 2, 4, 'cancelled_by_deliver', '2020-10-01', NULL);

-- 创建 Deliver 表
CREATE TABLE Deliver
(
    deliver_id INT PRIMARY KEY,
    star       INT,
    banned     NVARCHAR(3)
);

-- 插入 Deliver 表数据
INSERT INTO Deliver (deliver_id, star, banned)
VALUES (3, 1, 'No'),
       (4, 1, 'No'),
       (10, 3, 'No');

-- 1.送餐员主动取消送餐订单次数达到3次，取消其送餐资格，永不录用。此外，连续送餐无延迟达20次则抵消1次主动取消送餐次数。
-- 2.送餐延迟时间达到30分钟以上的送餐员，降低服务星级，服务星级初值为10，每次延迟时间达到30分钟以上，
-- 降低1个星级，若降到0，取消送餐资格，永不录用。此外，连续送餐10次无延迟则增加1个星级。
-- 3.为防止送餐员之间相互刷单以提高星级或抵消主动取消送餐次数等情况，送餐员不得使用校点外卖点餐，
-- 如：A送餐员不能给B送餐员点餐。一经发现，取消送餐资格，永不录用。
-- DBA需要将服务态度考核不合格的人员在一张名为'deliver'的表中进行标记。

-- 对于主动取消订单3次以上的送餐员，更新Deliver表中的banned字段为'Yes'。
-- 对于送餐延迟30分钟以上的送餐员，减少其星级，并在降到0时更新banned字段为'Yes'。连续送餐10次无延迟则增加1个星级。
-- 确保送餐员之间没有相互点餐的情况。如果发现，更新banned字段为'Yes'。


-- 连续送餐10次无延迟则增加1个星级
UPDATE Deliver
SET star = star + 1
WHERE deliver_id IN (SELECT deliver_id
                     FROM Orders
                     WHERE delay = 0
                        OR delay IS NULL
                     GROUP BY deliver_id
                     HAVING COUNT(*) >= 10);

-- 连餐延迟则减少1个星级
UPDATE Deliver
SET star = star - 1
WHERE deliver_id IN (SELECT deliver_id
                     FROM Orders
                     WHERE delay >= 30
                     GROUP BY deliver_id);

-- 计算主动取消订单的次数
SELECT deliver_id, COUNT(*) cancel_order_count
FROM Orders
WHERE status = 'cancelled_by_deliver'
GROUP BY deliver_id;

-- 计算送餐延迟超过30分钟的次数
SELECT deliver_id, COUNT(*) AS delay_order_count
FROM Orders
WHERE delay >= 30
GROUP BY deliver_id;

-- 检查送餐员之间是否有相互点餐的情况
SELECT o.deliver_id
FROM Orders o
         JOIN Student s1 ON o.client_id = s1.student_id
         JOIN Student s2 ON o.deliver_id = s2.student_id
WHERE s1.role = 'deliver'
  AND s2.role = 'deliver';


-- 定义存储过程
CREATE PROCEDURE UpdateDeliverStatus
AS
BEGIN
    -- 初始化
    INSERT INTO Deliver (deliver_id, star, banned)
    SELECT DISTINCT deliver_id, 10, 'No'
    FROM Orders
    WHERE deliver_id NOT IN (SELECT deliver_id FROM Deliver);

    -- 标记为禁止：星级为0的送餐员
    UPDATE Deliver
    SET banned = 'Yes'
    WHERE star = 0;

    -- 减少星级：对于延迟超过30分钟的送餐员
    UPDATE Deliver
    SET star = IIF(star > 0, star - 1, 0)
    WHERE deliver_id IN (SELECT deliver_id
                         FROM Orders
                         WHERE delay >= 30
                         GROUP BY deliver_id);

    -- 增加星级：对于没有延迟或延迟为0且订单数量大于等于10的送餐员
    UPDATE Deliver
    SET star = star + 1
    WHERE deliver_id IN (SELECT deliver_id
                         FROM Orders
                         WHERE delay = 0
                            OR delay IS NULL
                         GROUP BY deliver_id
                         HAVING COUNT(*) >= 10);

    -- 标记为禁止：对于主动取消订单超过3次的送餐员
    UPDATE Deliver
    SET banned = 'Yes'
    WHERE deliver_id IN (SELECT deliver_id
                         FROM Orders
                         WHERE status = 'cancelled_by_deliver'
                         GROUP BY deliver_id
                         HAVING COUNT(*) >= 3);

    -- 标记为禁止：对于送餐员之间有相互点餐的情况
    UPDATE Deliver
    SET banned = 'Yes'
    WHERE deliver_id IN (SELECT DISTINCT o.deliver_id
                         FROM Orders o
                                  JOIN Student s1 ON o.client_id = s1.student_id
                                  JOIN Student s2 ON o.deliver_id = s2.student_id
                         WHERE s1.role = 'deliver'
                           AND s2.role = 'deliver');
END;
GO

DROP PROCEDURE UpdateDeliverStatus;

EXEC UpdateDeliverStatus;



-- CREATE TRIGGER UpdateStatusTrigger
--     ON Orders
--     AFTER UPDATE
--     AS
-- BEGIN
--     IF UPDATE(status)
--         BEGIN
--             EXEC UpdateDeliverStatus;
--         END
-- END;
