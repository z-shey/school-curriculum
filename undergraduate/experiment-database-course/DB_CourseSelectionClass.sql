-- 创建选课系统数据库
CREATE DATABASE CourseSelection_class2;

-- 使用选课系统数据库
USE CourseSelection_class2;

CREATE SCHEMA "S-T" AUTHORIZATION db_accessadmin;
-- 创建学生关系
CREATE TABLE [S-T].Student
(
    Sno   INT PRIMARY KEY,
    Sname VARCHAR(100),
    Sage  SMALLINT,
    Ssex  VARCHAR(10),
    Sdept VARCHAR(50)
);
GO

-- 创建课程关系
CREATE TABLE [S-T].Course
(
    Cno     INT PRIMARY KEY,
    Cname   VARCHAR(50),
    Ccredit FLOAT,
    Cpno    SMALLINT
);
GO
-- 创建学生选课关系
CREATE TABLE [S-T].SC
(
    Sno   INT,
    Cno   INT,
    Grade FLOAT,
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Sno) REFERENCES [S-T].Student (Sno),
    FOREIGN KEY (Cno) REFERENCES [S-T].Course (Cno)
);
GO


-- 向Student表插入多行数据
INSERT INTO [S-T].Student(Sno, Sname, Sage, Ssex, Sdept)
VALUES (201215121, '李勇', 20, N'男', 'CS'),
       (201215122, '刘晨', 19, N'女', 'CS'),
       (201215123, '王敏', 18, N'女', 'MA'),
       (201215125, '张立', 19, N'男', 'IS');

-- 向Course表插入多行数据
INSERT INTO [S-T].Course(Cno, Cname, Ccredit, Cpno)
VALUES (1, '数据库', 4, 5),
       (2, '数学', 2, NULL),
       (3, '信息系统', 4, 1),
       (4, '操作系统', 3, 6),
       (5, '数据结构', 4, 7),
       (6, '数据处理', 2, NULL),
       (7, 'PASCAL语言', 4, 6);

-- 向SC表插入多行数据
INSERT INTO [S-T].SC(Sno, Cno, Grade)
VALUES (201215121, 1, 92),
       (201215121, 2, 85),
       (201215121, 3, 88),
       (201215122, 2, 90),
       (201215122, 3, 80);