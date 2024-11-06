-- 创建学生教材订购系统的数据库
CREATE DATABASE TextbookOrder;

-- 切换到学生教材订购系统的数据库
USE TextbookOrder;

-- 创建学生表
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Age INT,
    Gender VARCHAR(10),
    DepartmentName VARCHAR(100)
);

-- 创建教材表
CREATE TABLE Textbooks (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    PublisherID INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

-- 创建订购表
CREATE TABLE Orders (
    StudentID INT,
    BookID INT,
    Quantity INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (BookID) REFERENCES Textbooks(BookID)
);

-- 创建出版社表
CREATE TABLE Publishers (
    PublisherID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200)
);
