-- 创建选课系统数据库
CREATE DATABASE CourseSelection;

-- 使用选课系统数据库
USE CourseSelection;

-- 创建学生关系
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Age INT,
    Gender VARCHAR(10),
    Department VARCHAR(50)
);
-- 修改Student表，添加姓名字段
ALTER TABLE Student
ADD Name VARCHAR(100);

-- 创建课程关系
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Credit FLOAT,
    Hours INT
);

-- 创建学生选课关系
CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    Grade FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
