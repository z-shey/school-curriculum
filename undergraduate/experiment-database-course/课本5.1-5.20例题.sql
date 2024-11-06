-- Example 5.1
CREATE TABLE [S-T].Student
(
    Sno        CHAR(8) PRIMARY KEY,
    Sname      CHAR(20) UNIQUE,
    Ssex       CHAR(6),
    Sbirthdate DATE,
    Smajor     VARCHAR(40)
);
GO

-- Example 5.2
CREATE TABLE [S-T].SC
(
    Sno        CHAR(8),
    Sname      CHAR(20) UNIQUE,
    Ssex       CHAR(6),
    Sbirthdate DATE,
    Smajor     VARCHAR(40),
    PRIMARY KEY (Sno)
);
GO

-- Example 5.3
CREATE TABLE [S-T].SC
(
    Sno      CHAR(8),
    Cno      CHAR(5),
    Grade    SMALLINT,
    Semester CHAR(5),
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Sno) REFERENCES [S-T].Student (Sno),
    FOREIGN KEY (Cno) REFERENCES [S-T].Course (Cno)
);
GO


-- Example 5.4
CREATE TABLE [S-T].SC
(
    Sno          CHAR(8),
    Cno          CHAR(5),
    Grade        SMALLINT,
    Semeter      CHAR(5),
    Techingclass CHAR(8),
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Sno) REFERENCES [S-T].Student (Sno)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Cno) REFERENCES [S-T].Course (Cno)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
GO

-- Example 5.5
CREATE TABLE [S-T].SC
(
    Sno          CHAR(9)  NOT NULL,
    Cno          CHAR(4)  NOT NULL,
    Grade        SMALLINT NOT NULL,
    Semeter      CHAR(5),
    Techingclass CHAR(8),
    PRIMARY KEY (Sno, Cno)
);
GO

-- Example 5.6
CREATE TABLE [S-T].School
(
    SHno        CHAR(8) PRIMARY KEY,
    SHname      VARCHAR(40) UNIQUE,
    SHfounddate DATE
);
GO

-- Example 5.7
CREATE TABLE [S-T].Student
(
    Sno        CHAR(8) PRIMARY KEY,
    sname      CHAR(20) NOT NULL,
    Ssex       CHAR(6) CHECK (Ssex IN ('男', '女')),
    Sbirthdate DATE,
    Smajor     VARCHAR(40)
);
GO

-- Example 5.8
CREATE TABLE [S-T].SC
(
    Sno          CHAR(8),
    Cno          CHAR(5),
    Grade        SMALLINT CHECK (Grade >= 0 AND Grade <= 100),
    Semester     CHAR(5),
    Techingclass CHAR(8),
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Sno) REFERENCES [S-T].Student (Sno),
    FOREIGN KEY (Cno) REFERENCES [S-T].Course (Cno)
);
GO

-- Example 5.9
CREATE TABLE [S-T].Student
(
    Sno        CHAR(8),
    Sname      CHAR(20) NOT NULL,
    Ssex       CHAR(6),
    Sbirthdate DATE,
    Smajor     CHAR(20),
    PRIMARY KEY (Sno),
    CHECK (Ssex = '女' OR Sname NOT LIKE 'Ms.%')
);
GO

-- Example 5.10
CREATE TABLE [S-T].Student
(
    Sno        CHAR(8)
        CONSTRAINT C1 CHECK (sno BETWEEN 10000000 AND 29999999),
    Sname      CHAR(20)
        CONSTRAINT C2 NOT NULL,
    Sbirthdate DATE
        CONSTRAINT C3 CHECK (Sbirthdate > '1980-1-1'),
    Ssex       CHAR(6)
        CONSTRAINT C4 CHECK (Ssex IN ('男', '女')),
    Smajor     VARCHAR(40)
        CONSTRAINT StudentyKey PRIMARY KEY (Sno)
);
GO

-- Example 5.11
CREATE TABLE [S-T].Teacher
(
    Eno     CHAR(8) PRIMARY KEY,
    Ename   VARCHAR(20),
    Job     CHAR(8),
    Sal     NUMERIC(7, 2),
    Deduct  NUMERIC(7, 2),
    Shoolno CHAR(8),
    CONSTRAINT TeacherKey FOREIGN KEY (Shoolno) REFERENCES [S-T].School (Shoolno),
    CONSTRAINT C1 CHECK (Sal + Deduct >= 3000)
);
GO

-- Example 5.12
ALTER TABLE [S-T].Student
    DROP CONSTRAINT C3;

-- Example 5.13
ALTER TABLE [S-T].Student
    DROP CONSTRAINT C1;
GO
ALTER TABLE [S-T].Student
    ADD CONSTRAINT C1 CHECK (Sno BETWEEN 900000 AND 999999);
GO
ALTER TABLE [S-T].Student
    DROP CONSTRAINT C3;
GO
ALTER TABLE [S-T].Student
    ADD CONSTRAINT C3 CHECK (Sbirthdate > '1985-1-1');
GO

-- 在T-SQL中，没有DOMAIN的概念
-- Example 5.14
-- CREATE DOMAIN GenderDomain CHAR(6)
--     CHECK(VALUE IN ('男', '女'));
-- GO

-- Example 5.15
-- CREATE DOMAIN GenderDomain CHAR(6)
--     CONSTRAINT GD CHECK(VALUE IN ('男', '女'));
-- GO

-- Example 5.16
-- ALTER DOMAIN GenderDomain DROP CONSTRAINT GD;
-- GO

-- Example 5.17
-- ALTER DOMAIN GenderDoamin
--     ADD CONSTRAINT GDD CHECK (VALUE IN ('1', '0'));
-- GO


-- Example 5.18
-- 非标准
-- CREATE TRIGGER SC_T
-- ALTER
-- UPDATE ON SC
--     REFRENGING
--     OLD AS OldTuple
--     NEW AS NewTuple
--     FOR EACH ROW
--     WHEN (NewTuple.Grade >= 1.1 * OldTuple.Grade)
-- BEGIN
--     INSERT INTO SC_U (Sno, Cno, OldGrede, NewGrade)
--     VALUES (OldTuple, Sno, OldTuple, Cno, OldTuple.Grade, NewTuple.Grade)
-- END;
CREATE TRIGGER SC_T
    ON [S-T].SC
    AFTER UPDATE
    AS
BEGIN
    IF UPDATE(Grade)
        BEGIN
            INSERT INTO [S-T].SC_U (Sno, Cno, OldGrade, NewGrade)
            SELECT i.Sno, i.Cno, d.Grade, i.Grade
            FROM inserted i
                     INNER JOIN deleted d ON i.Sno = d.Sno AND i.Cno = d.Cno
            WHERE i.Grade >= 1.1 * d.Grade;
        END;
END;
GO


-- Example 5.19
CREATE TRIGGER Student_Count
    ON [S-T].Student
    AFTER INSERT
    AS
BEGIN
    INSERT INTO [S-T].StudentInsertLog(Number)
    SELECT COUNT(*)
    FROM inserted;
END;
GO

-- Example 5.20
CREATE TRIGGER Update_Sal
    ON [S-T].Teacher
    BEFORE UPDATE
               AS
BEGIN
    IF (UPDATE(job) OR UPDATE(sal))
        BEGIN
            IF EXISTS (SELECT 1
                       FROM inserted
                       WHERE job = '教授'
                         AND sal < 4000)
                BEGIN
                    UPDATE t
                    SET sal = 4000
                    FROM [S-T].Teacher t
                             INNER JOIN inserted i ON t.TeacherID = i.TeacherID;
                END;
        END;
END;
GO



-- Example 8.4
DECLARE @CnoOfStudent CHAR(10);
DECLARE @GradeOfStudent INT;
DECLARE mycursor CURSOR FOR
    SELECT Cno, Grade
    FROM [S-T].SC
    WHERE Sno = '20180001';

OPEN mycursor;

FETCH NEXT FROM mycursor INTO @CnoOfStudent, @GradeOfStudent;
WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Sno:20180001, Cno:' + @CnoOfStudent + ', Grade:' + CAST(@GradeOfStudent AS VARCHAR);
        FETCH NEXT FROM mycursor INTO @CnoOfStudent, @GradeOfStudent;
    END

CLOSE mycursor;
DEALLOCATE mycursor;


-- Example 8.5
CREATE PROCEDURE compGPA @inSno CHAR(10),
                         @outGPA FLOAT OUTPUT
AS
BEGIN
    DECLARE @courseGPA INT;
    DECLARE @totalGPA INT;
    DECLARE @totalCredit INT;
    DECLARE @grade INT;
    DECLARE @credit INT;

    SET @totalGPA = 0;
    SET @totalCredit = 0;

    DECLARE mycursor CURSOR FOR
        SELECT Ccredit, Grade
        FROM [S-T].SC,
             [S-T].Course
        WHERE Sno = @inSno
          AND [S-T].SC.Cno = [S-T].Course.Cno;

    OPEN mycursor;

    FETCH NEXT FROM mycursor INTO @credit, @grade;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @grade BETWEEN 90 AND 100 THEN
                SET @courseGPA = 4.0; ELSEIF @grade BETWEEN 80 AND 89 THEN
            SET @courseGPA = 3.0;
            ELSEIF @grade BETWEEN 70 AND 72 THEN
            SET @courseGPA = 2.0;
            ELSEIF @grade BETWEEN 60 AND 69 THEN
            SET @courseGPA = 1.0;
ELSE
SET @courseGPA = 0;
END IF;

SET @totalGPA = @totalGPA + @courseGPA * @credit;
SET @totalCredit = @totalCredit + @credit;

FETCH NEXT FROM mycursor INTO @credit, @grade;
END

CLOSE mycursor;
DEALLOCATE mycursor;

SET @outGPA = 1.0 * @totalGPA / @totalCredit;
END;


-- Example 8.6
DECLARE @outGPA FLOAT;
EXEC compGPA '200180001', @outGPA OUTPUT;
PRINT 'GPA: ' + CONVERT(VARCHAR(10), @outGPA);

-- Example 11.3
BEGIN TRANSACTION;
DECLARE @BALANCE1 INT;
DECLARE @BALANCE2 INT;
DECLARE @AMOUNT INT;

-- 读取账户甲的余额BALANCE1
SELECT @BALANCE1 = BALANCE
FROM Accounts
WHERE AccountName = '甲';

SET @BALANCE1 = @BALANCE1 - @AMOUNT;

IF (@BALANCE1 < 0)
    BEGIN
        -- 金额不足，不能转账
        PRINT '金额不足，不能转账';
        ROLLBACK;
    END
ELSE
    BEGIN
        -- 读取账户甲的余额BALANCE2
        SELECT @BALANCE2 = BALANCE FROM Accounts WHERE AccountName = '甲';

        SET @BALANCE2 = @BALANCE2 + @AMOUNT;

        -- 写回BALANCE2
        UPDATE Accounts SET BALANCE = @BALANCE2 WHERE AccountName = '甲';
        COMMIT;
    END
GO
