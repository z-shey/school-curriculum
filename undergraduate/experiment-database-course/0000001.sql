CREATE DATABASE CourseSelection_assignment;
USE CourseSelection_assignment;

CREATE SCHEMA "S-T" AUTHORIZATION db_accessadmin;

CREATE TABLE [S-T].Student
(
    Sno       CHAR(8) PRIMARY KEY,
    Sname     VARCHAR(20) UNIQUE,
    Ssex      CHAR(6),
    Sbirthdate DATE,
    Smajor    VARCHAR(40)
)

-- Example 3.6
CREATE TABLE [S-T].Course
(
    Cno     CHAR(5) PRIMARY KEY,
    Cname   VARCHAR(40) NOT NULL,
    Ccredit SMALLINT,
    Cpno    CHAR(5),
    FOREIGN KEY (Cpno) REFERENCES [S-T].Course (Cno)
)

-- Example 3.7
CREATE TABLE [S-T].SC
(
    Sno           CHAR(8),
    Cno           CHAR(5),
    Grade         SMALLINT,
    Semester      CHAR(5),
    Teachingclass CHAR(8),
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Sno) REFERENCES [S-T].Student (Sno),
    FOREIGN KEY (Cno) REFERENCES [S-T].Course (Cno)
)

-- Insert some data to Student
INSERT INTO [S-T].Student (Sno, Sname, Ssex, Sbirthdate, Smajor)
VALUES ('20180001', '李勇', '男', '2000-3-8', '信息安全'),
       ('20180002', '刘晨', '女', '1999-9-1', '计算机科学与技术'),
       ('20180003', '王敏', '女', '2001-8-1', '计算机科学与技术'),
       ('20180004', '张立', '男', '2000-1-8', '计算机科学与技术'),
       ('20180005', '陈新奇', '男', '2001-11-1', '信息管理与信息系统'),
       ('20180006', '赵明', '男', '2000-6-12', '数据科学与大数据技术'),
       ('20180007', '王佳佳', '女', '2001-12-7', '数据科学与大数据技术');

-- Insert some data to Course
INSERT INTO [S-T].Course (Cno, Cname, Ccredit, Cpno)
VALUES ('81001', '程序设计基础和C语言', 4, NULL),
       ('81002', '数据结构', 4, '81001'),
       ('81003', '数据库理论', 4, '81002'),
       ('81004', '信息系统概论', 4, '81003'),
       ('81005', '操作系统', 4, '81001'),
       ('81006', 'Python语言', 3, '81002'),
       ('81007', '离散数学', 4, NULL),
       ('81008', '大数据技术概论', 4, '81003');

-- Insert some data to SC
INSERT INTO [S-T].SC (Sno, Cno, Grade, Semester, Teachingclass)
VALUES ('20180001', '81001', 85, '20192', '81001-01'),
       ('20180001', '81002', 96, '20201', '81002-01'),
       ('20180001', '81003', 87, '20202', '81003-01'),
       ('20180002', '81001', 80, '20192', '81001-02'),
       ('20180002', '81002', 98, '20201', '81002-01'),
       ('20180002', '81003', 71, '20202', '81003-02'),
       ('20180003', '81001', 81, '20192', '81001-01'),
       ('20180003', '81002', 76, '20201', '81002-02'),
       ('20180004', '81001', 56, '20192', '81001-02'),
       ('20180004', '81002', 97, '20201', '81001-02'),
       ('20180005', '81003', 68, '20202', '81003-01');
