CREATE DATABASE CourseSelectionClass;

USE CourseSelectionClass;

CREATE SCHEMA [S-T];

CREATE TABLE [S-T].Student
(
    sno   CHAR(9) PRIMARY KEY,
    sname CHAR(20) UNIQUE,
    ssex  CHAR(2),
    sage  SMALLINT,
    sdept CHAR(20)
);

INSERT INTO [S-T].Student (sno, sname, sage, ssex, sdept)
VALUES (201215121, '李勇', 20, N'男', 'CS'),
       (201215122, '刘晨', 19, N'女', 'CS'),
       (201215123, '王敏', 18, N'女', 'MA'),
       (201215125, '张立', 19, N'男', 'IS');

CREATE TABLE [S-T].Course
(
    cno     CHAR(4) PRIMARY KEY,
    cname   CHAR(40) NOT NULL,
    cpno    CHAR(4),
    ccredit SMALLINT,
    FOREIGN KEY (cpno) REFERENCES [S-T].Course (cno),
);

INSERT INTO [S-T].Course (cno, cname, ccredit, cpno)
VALUES (1, '数据库', 4, 5),
       (2, '数学', 2, NULL),
       (3, '信息系统', 4, 1),
       (4, '操作系统', 3, 6),
       (5, '数据结构', 4, 7),
       (6, '数据处理', 2, NULL),
       (7, 'PASCAL语言', 4, 6);


CREATE TABLE [S-T].SC
(
    sno   CHAR(9),
    cno   CHAR(4),
    grade SMALLINT,
    PRIMARY KEY (sno, cno),
    FOREIGN KEY (sno) REFERENCES [S-T].Student (sno),
    FOREIGN KEY (cno) REFERENCES [S-T].Course (cno)
);

INSERT INTO [S-T].SC (sno, cno, grade)
VALUES (201215121, 1, 92),
       (201215121, 2, 85),
       (201215121, 3, 88),
       (201215122, 2, 90),
       (201215122, 3, 80);