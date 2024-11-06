-- 创建银行借贷系统的数据库
CREATE DATABASE LoanSystem;

-- 切换到银行借贷系统的数据库
USE LoanSystem;

-- 创建帐户表
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    Name VARCHAR(100),
    Balance DECIMAL(10, 2),
    CreationDate DATE,
    SavingsBankID INT,
    FOREIGN KEY (SavingsBankID) REFERENCES SavingsBanks(SavingsBankID)
);

-- 创建储蓄所表
CREATE TABLE SavingsBanks (
    SavingsBankID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    NumberOfCustomers INT,
    City VARCHAR(100)
);

-- 创建借贷表
CREATE TABLE Loans (
    AccountID INT,
    LoanType VARCHAR(100),
    Amount DECIMAL(10, 2),
    Date DATE,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
