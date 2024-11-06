-- 图书借阅数据库
CREATE DATABASE LibrarySystem;

-- 选择图书借阅数据库
USE LibrarySystem;

-- 创建图书关系
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Price DECIMAL(10, 2), -- 总长度为10位，其中包括两位小数
    Publisher VARCHAR(100)
);

-- 创建读者关系
CREATE TABLE Readers (
    CardNumber INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Affiliation VARCHAR(100)
);

-- 创建借阅关系
CREATE TABLE Borrowings (
    BookID INT,
    CardNumber INT,
    BorrowDate DATE,
    PRIMARY KEY (BookID, CardNumber),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (CardNumber) REFERENCES Readers(CardNumber)
);
