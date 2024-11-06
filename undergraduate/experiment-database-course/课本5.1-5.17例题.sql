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
)
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
        CONSTRAINT StudentKey PRIMARY KEY (Sno)
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
)
GO

-- Example 5.12
ALTER TABLE [S-T].Student
    DROP CONSTRAINT C3;

-- Example 5.13
ALTER TABLE [S-T].Student
    DROP CONSTRAINT C1;
ALTER TABLE [S-T].Student
    ADD CONSTRAINT C1 CHECK (Sno BETWEEN 900000 AND 999999);
ALTER TABLE [S-T].Student
    DROP CONSTRAINT C3;
ALTER TABLE [S-T].Student
    ADD CONSTRAINT C3 CHECK (Sbirthdate > '1985-1-1');

-- Example 5.14
CREATE DOMAIN GenderDomain CHAR(6)
    CHECK(VALUE IN ('男', '女'))

-- Example 5.15
CREATE DOMAIN GenderDomain CHAR(6)
    CONSTRAINT GD CHECK(VALUE IN ('男', '女'));

-- Example 5.16
ALTER DOMAIN GenderDomain DROP CONSTRAINT GD;

-- Example 5.17
ALTER DOMAIN GenderDoamin
    ADD CONSTRAINT GDD CHECK (VALUE IN ('1', '0'));

-- Example 5.18
CREATE TRIGGER [S-T].SC_T
ALTER
UPDATE ON [S-T].SC
    REFRENGING
    OLD AS OldTuple
    NEW AS NewTuple
    FOR EACH ROW
    WHEN (NewTuple.Grade >= 1.1 * OldTuple.Grade)
BEGIN
    INSERT INTO SC_U (Sno, Cno, OldGrede, NewGrade)
    VALUES (OldTuple, Sno, OldTuple, Cno, OldTuple.Grade, NewTuple.Grade)
END;
