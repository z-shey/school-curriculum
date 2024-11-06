CREATE DATABASE CourseSelection_assignment;
USE CourseSelection_assignment;

-- Example 3.1
CREATE SCHEMA "S-C-SC" AUTHORIZATION db_accessadmin;

-- Example 3.2
CREATE SCHEMA AUTHORIZATION db_accessadmin;

-- Example 3.3
CREATE SCHEMA Test AUTHORIZATION db_accessadmin;
CREATE TABLE Tab1
(
    Col1 SMALLINT,
    Col2 INT,
    Col3 CHAR(20),
    Col4 NUMERIC(10, 3),
    Col5 DECIMAL(5, 2)
);

-- Example 3.4
-- DROP SCHEMA Test CASCADE;
DROP TABLE Tab1
DROP SCHEMA Test;

-- Example 3.5
CREATE TABLE [S-T].Student
(
    Sno        CHAR(8) PRIMARY KEY,
    Sname      VARCHAR(20) UNIQUE,
    Ssex       CHAR(6),
    Sbirthdate DATE,
    Smajor     VARCHAR(40)
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

-- Example 3.8
ALTER TABLE [S-T].Student
    ADD Semail VARCHAR(30);

-- Example 3.9
ALTER TABLE [S-T].Student
    ALTER COLUMN Sbirthdate VARCHAR(20);

ALTER TABLE [S-T].Student
    ALTER COLUMN Sbirthdate DATE;

EXEC sp_columns 'Student';

-- Example 3.10
ALTER TABLE [S-T].Course
    ADD UNIQUE (Cname);

-- Example 3.11
DROP TABLE [S-T].Student;

-- Example 3.12
CREATE VIEW CS_Student
AS
SELECT Sno, Sname, Ssex, Sbirthdate, Smajor
FROM [S-T].Student
WHERE Smajor = '计算机科学与技术';

DROP TABLE [S-T].Student;

SELECT *
FROM CS_Student;

-- Example 3.13
CREATE UNIQUE INDEX Idx_StudentSname ON [S-T].Student (Sname);
CREATE UNIQUE INDEX Idx_CourseCname ON [S-T].Course (Cname);
CREATE UNIQUE INDEX Idx_SCCno ON [S-T].SC (Sno ASC, Cno DESC);

-- Example 3.14
-- ALTER INDEX Idx_SCCno RENAME TO Idx_SCSnoCno;
EXEC sp_rename 'S-T.SC.Idx_SCCno', 'Idx_SCSnoCno', 'INDEX';

-- Example 3.15
DROP INDEX [S-T].Idx_StudentSname;

-- Example 3.16
SELECT Sno, Sname
FROM [S-T].Student;

-- Example 3.17
SELECT Sname, Sno, Smajor
FROM [S-T].Student;

-- Example 3.18
SELECT *
FROM [S-T].Student;


-- Example 3.19
-- SELECT Sname, (EXTRACT(2023-10-22) - EXTRACT(2003-12-5))
-- FROM Student;
SELECT Sname, DATEDIFF(YEAR, Sbirthdate, GETDATE()) AS Age
FROM [S-T].Student;

-- Example 3.20
SELECT Sname, 'DATA OF BIRTH: ', Sbirthdate, Smajor
FROM [S-T].Student;

-- Example 3.21
SELECT Sno
FROM [S-T].SC;

SELECT DISTINCT Sno
FROM [S-T].SC;

SELECT ALL Sno
FROM [S-T].SC;

-- Example 3.22
SELECT Sname
FROM [S-T].Student
WHERE Smajor = '计算机科学与技术'

-- Example 3.23
SELECT Sname, Ssex
FROM [S-T].Student
WHERE YEAR(Sbirthdate) >= 2000;

-- Example 3.24
SELECT DISTINCT Sno
FROM [S-T].SC
WHERE Grade < 60;

-- Example 3.25
SELECT Sname, Sbirthdate, Smajor
FROM [S-T].Student
WHERE DATEDIFF(YEAR, Sbirthdate, GETDATE()) BETWEEN 20 AND 23;

-- Example 3.26
SELECT Sname, Sbirthdate, Smajor
FROM [S-T].Student
WHERE DATEDIFF(YEAR, Sbirthdate, GETDATE()) NOT BETWEEN 20 AND 23;

-- Example 3.27
SELECT Sname, Ssex
FROM [S-T].Student
WHERE Smajor IN ('计算机科学与技术', '信息安全');

-- Example 3.28
SELECT Sname, Ssex
FROM [S-T].Student
WHERE Smajor NOT IN ('计算机科学与技术', '信息安全');

-- Example 3.29
SELECT *
FROM [S-T].Student
WHERE Sno LIKE '20180003';

-- Example 3.30
SELECT Sname, Sno, Ssex
FROM [S-T].Student
WHERE Sname LIKE '刘%';

-- Example 3.31
SELECT Sno, Sname
FROM [S-T].Student
WHERE Sno LIKE '2018%'

-- Example 3.32
SELECT Cname, Cno
FROM [S-T].Course
WHERE Cno LIKE '81__6';

-- Example 3.33
SELECT Sname, Sno, Ssex
FROM [S-T].Student
WHERE Sname NOT LIKE '刘%';

-- Example 3.34
SELECT Cno, Ccredit
FROM [S-T].Course
WHERE Cname LIKE 'DB\_Design' ESCAPE '\';

-- Example 3.35
SELECT *
FROM [S-T].Course
WHERE Cname LIKE 'DB\_%i__' ESCAPE '\';

-- Example 3.36
SELECT Sno, Cno
FROM [S-T].SC
WHERE Grade IS NULL;

-- Example 3.37
SELECT Sno, Cno
FROM [S-T].SC
WHERE Grade IS NOT NULL;

-- Example 3.38
SELECT Sno, Sname, Ssex
FROM [S-T].Student
WHERE Smajor = '计算机科学与技术'
  AND YEAR(Sbirthdate) >= 2000;

-- Example 3.39
-- SELECT Sno, Grade
-- FROM SC
-- WHERE Cno = '8013'
-- GROUP BY Grade DESC;
SELECT Sno, Grade
FROM [S-T].SC
WHERE Cno = '81003'
ORDER BY Grade DESC;

-- Example 3.40
SELECT *
FROM [S-T].SC
ORDER BY Cno, Grade DESC;

-- Example 3.41
SELECT COUNT(*)
FROM [S-T].Student;

-- Example 3.42
SELECT COUNT(DISTINCT Sno)
FROM [S-T].SC;

-- Example 3.43
SELECT AVG(Grade)
FROM [S-T].SC
WHERE Cno = '81001';

-- Example 3.44
SELECT MAX(Grade)
FROM [S-T].SC
WHERE Cno = '81001';

-- Example 3.45
SELECT SUM(Grade)
FROM [S-T].SC,
     [S-T].Course
WHERE Sno = '20180003'
  AND SC.Cno = Course.Cno;

-- Example 3.46
SELECT Cno, COUNT(Sno)
FROM [S-T].SC
GROUP BY Cno;

-- Example 3.47
SELECT Sno
FROM [S-T].SC
WHERE Semester = '20192'
GROUP BY Sno
HAVING COUNT(*) >= 1;

-- Example 3.48
SELECT Sno, AVG(Grade)
FROM [S-T].SC
GROUP BY Sno
HAVING AVG(Grade) >= 80;

-- Example 3.49
-- SELECT Sno
-- FROM SC, Course
-- WHERE Course.Cname = 'DATABASE' AND SC.Cno = Course.Cno
-- ORDER BY Grade DESC
-- LIMIT 10;
SELECT TOP 10 Sno
FROM [S-T].SC,
     [S-T].Course
WHERE Course.Cname = '数据库理论'
  AND SC.Cno = Course.Cno
ORDER BY Grade DESC;

-- Example 3.50
-- SELECT Sno, AVG(Grade)
-- FROM SC
-- GROUP BY Sno
-- ORDER BY AVG(Grade) DESC
-- LIMIT 5 OFFSET 2;
SELECT Sno, AVG(Grade)
FROM [S-T].SC
GROUP BY Sno
ORDER BY AVG(Grade) DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;

-- Example 3.51
SELECT Student.*, SC.*
FROM [S-T].Student,
     [S-T].SC
WHERE Student.Sno = SC.Sno;

-- Example 3.52
SELECT Student.Sno, Sname, Ssex, Sbirthdate, Smajor, Cno, Grade
FROM [S-T].Student,
     [S-T].SC
WHERE Student.Sno = SC.Sno;

-- Example 3.53
SELECT Student.Sno, Sname
FROM [S-T].Student,
     [S-T].SC
WHERE Student.Sno = SC.Sno
  AND SC.Cno = '81002'
  AND SC.Grade > 90;

-- Example 3.54
SELECT FIRST.Cno, SECOND.Cpno
FROM [S-T].Course FIRST,
     [S-T].Course SECOND
WHERE FIRST.Cpno = SECOND.Cno
  AND SECOND.Cpno IS NOT NULL;

-- Example 3.55
SELECT Student.Sno, Sname, Ssex, Sbirthdate, Cno, Grade
FROM [S-T].Student
         LEFT OUTER JOIN [S-T].SC ON Student.Sno = SC.Sno;

-- Example 3.56
SELECT Student.Sno, Sname, Cname, Grade
FROM [S-T].Student,
     [S-T].SC,
     [S-T].Course
WHERE Student.Sno = SC.Sno
  AND SC.Cno = Course.Cno;

-- Example 3.57
SELECT Sno, Sname, Smajor
FROM [S-T].Student
WHERE Smajor IN (SELECT Smajor
                 FROM [S-T].Student
                 WHERE Sname = '刘晨');


-- Example 3.58
SELECT Sno, Sname
FROM [S-T].Student
WHERE Sno IN (SELECT Sno
              FROM [S-T].SC
              WHERE Cno IN (SELECT Cno
                            FROM [S-T].Course
                            WHERE Cname = '数据库理论'));

-- SELECT Student.Sno Sname
-- FROM Student,
--      SC,
--      Course
-- WHERE Student.Sno = SC.Sno
--   AND SC.Cno = Course.Cno
--   AND Course.Cname = 'Big Data';
--
-- SELECT Sno, Sname, Smajor
-- FROM Student
-- WHERE Smajor = (SELECT Smajor
--                 FROM Student
--                 WHERE Sname = 'Tim');

-- Example 3.59
SELECT Sno, Cno
FROM [S-T].SC x
WHERE Grade >= (SELECT AVG(Grade)
                FROM [S-T].SC y
                WHERE y.Sno = x.Sno);
--
-- SELECT AVG(Grade)
-- FROM SC y
-- WHERE y.Sno = '202210220';
--
-- SELECT Sno, Cno
-- FROM SC x
-- WHERE Grade >= 89.3;

-- Example 3.60
SELECT Sname, Sbirthdate, Smajor
FROM [S-T].Student
WHERE Sbirthdate > ANY (SELECT Sbirthdate
                        FROM [S-T].Student
                        WHERE Smajor = '计算机科学与技术')
  AND Smajor <> '计算机科学与技术';

-- SELECT Sname, Sbirthdate, Smajor
-- FROM Student
-- WHERE Sbirthdate > (SELECT MIN(Sbirthdate)
--                     FROM Student
--                     WHERE Smajor = 'CS')
--   AND Smajor <> 'CS';

-- Example 3.61
SELECT Sname, Sbirthdate
FROM [S-T].Student
WHERE Sbirthdate > ALL (SELECT Sbirthdate
                        FROM [S-T].Student
                        WHERE Smajor = '计算机科学与技术')
  AND Smajor <> '计算机科学与技术';

-- SELECT Sname, Sbirthdate
-- FROM Student
-- WHERE Sbirthdate > (SELECT MAX(Sbirthdate)
--                     FROM Student
--                     WHERE Smajor = 'CS')
--   AND Smajor = 'CS';

-- Example 3.62
SELECT Sname
FROM [S-T].Student
WHERE EXISTS(SELECT *
             FROM [S-T].SC
             WHERE Sno = Student.Sno
               AND Cno = '81001');

-- Example 3.63
SELECT Sname
FROM [S-T].Student
WHERE NOT EXISTS(SELECT *
                 FROM [S-T].SC
                 WHERE SC.Sno = Student.Sno
                   AND Cno = '81001');

-- SELECT Sno, Sname, Smajor
-- FROM Student S1
-- WHERE EXISTS(SELECT *
--              FROM Student S2
--              WHERE S2.Smajor = S1.Smajor
--                AND S2.Sname = '刘晨');

-- Example 3.64
SELECT Sname
FROM [S-T].Student
WHERE NOT EXISTS(SELECT *
                 FROM [S-T].Course
                 WHERE NOT EXISTS(SELECT *
                                  FROM [S-T].SC
                                  WHERE Sno = Student.Sno
                                    AND Cno = Course.Cno));


-- Example 3.65
SELECT Sno
FROM [S-T].Student
WHERE NOT EXISTS(SELECT *
                 FROM [S-T].SC SCX
                 WHERE SCX.Sno = '20180002'
                   AND NOT EXISTS(SELECT *
                                  FROM [S-T].SC SCY
                                  WHERE SCY.Sno = Student.Sno
                                    AND SCY.Cno = SCX.Cno));

-- Example 3.66
SELECT *
FROM [S-T].Student
WHERE Smajor = '计算机科学与技术'
UNION
SELECT *
FROM [S-T].Student
WHERE DATEDIFF(YEAR, Sbirthdate, GETDATE()) <= 19;

-- Example 3.67
SELECT Sno
FROM [S-T].SC
WHERE Semester = '20202'
  AND Cno = '81001'
UNION
SELECT Sno
FROM [S-T].SC
WHERE Semester = '20202'
  AND Cno = '81002';

-- Example 3.68
SELECT *
FROM [S-T].Student
WHERE Smajor = '计算机科学与技术'
INTERSECT
SELECT *
FROM [S-T].Student
WHERE DATEDIFF(YEAR, Sbirthdate, GETDATE()) <= 19;

-- Example 3.69
SELECT Sno
FROM [S-T].SC
WHERE Cno = '81001'
INTERSECT
SELECT Sno
FROM [S-T].SC
WHERE Cno = '81002';

-- Example 3.70
SELECT *
FROM [S-T].Student
WHERE Smajor = '计算机科学与技术'
EXCEPT
SELECT *
FROM [S-T].Student
WHERE DATEDIFF(YEAR, Sbirthdate, GETDATE()) <= 19;

-- Example 3.71
INSERT INTO [S-T].Student(Sno, Sname, Ssex, Smajor, Sbirthdate)
VALUES ('20180009', '陈冬', '男', '信息管理与信息系统', '2000-5-22');

-- Example 3.72
INSERT INTO [S-T].Student
VALUES ('20180008', '张成民', '男', '计算机科学与技术', '2000-4-15');

-- Example 3.73
INSERT INTO [S-T].SC (Sno, Cno, Semester, Teachingclass)
VALUES ('20180005', '81004', '20202', '81004-01');

-- Example 3.74
CREATE TABLE [S-T].Smajor_age
(
    Smajor  VARCHAR(40),
    Avg_age SMALLINT
);

INSERT INTO [S-T].Smajor_age(Smajor, Avg_age)
SELECT Smajor, AVG(DATEDIFF(YEAR, Sbirthdate, GETDATE()))
FROM [S-T].Student
GROUP BY Smajor;


BACKUP DATABASE [CourseSelection_assignment] TO DISK = 'D:\SPACES\Backup\MyDatabase.bak' WITH FORMAT


-- Example 3.75
UPDATE [S-T].Student
SET Sbirthdate = '2001-3-18'
WHERE Sno = '20180001'

-- Example 3.76
UPDATE [S-T].SC
SET Grade = Grade - 5
WHERE Semester = '20201'
  AND Cno = '81002';

-- Example 3.77
UPDATE [S-T].SC
SET Grade = 0
WHERE Sno IN (SELECT Sno
              FROM [S-T].Student
              WHERE Smajor = '计算机科学与技术');

-- Example 3.78
DELETE
FROM [S-T].Student
WHERE Sno = '20180007'

-- Example 3.79
DELETE
FROM [S-T].SC
WHERE 1 = 1;

-- Example 3.80
DELETE
FROM [S-T].SC
WHERE Sno IN (SELECT Sno
              FROM [S-T].Student
              WHERE Smajor = '计算机科学与技术');

-- Example 3.81
INSERT INTO [S-T].SC (Sno, Cno, Grade, Semester, Teachingclass)
VALUES ('20180006', '81004', NULL, '20211', NULL);

-- Example 3.82
UPDATE [S-T].Student
SET Smajor = NULL
WHERE Sno = '20180006';

-- Example 3.83
SELECT *
FROM [S-T].Student
WHERE Sname IS NULL
   OR Ssex IS NULL
   OR Sbirthdate IS NULL
   OR Smajor IS NULL;

-- Example 3.84
SELECT Sno
FROM [S-T].SC
WHERE Grade < 60
  AND Cno = '81001';

-- Example 3.85
SELECT Sno
FROM [S-T].SC
WHERE Grade < 60
  AND Cno = '81001'
UNION
SELECT sno
FROM [S-T].SC
WHERE Grade IS NULL
  AND Cno = '81001';

-- Example 3.86
CREATE VIEW [S-T].IS_Student
AS
SELECT Sno, Sname, Ssex, Sbirthdate, Smajor
FROM [S-T].Student
WHERE Smajor = '信息管理与信息系统';

-- Example 3.87
CREATE VIEW [S-T].IS_Student
AS
SELECT Sno, Sname, Ssex, Sbirthdate, Smajor
FROM [S-T].Student
WHERE Smajor = '信息管理与信息系统'
WITH CHECK OPTION;

-- Example 3.88
CREATE VIEW [S-T].IS_C1(Sno, Sname, Grade)
AS
SELECT Student.Sno, Sname, Grade
FROM [S-T].Student,
     [S-T].SC
WHERE Smajor = '信息管理与信息系统'
  AND Student.Sno = SC.Sno
  AND SC.Cno = '81001';

-- Example 3.89
CREATE VIEW [S-T].IS_C2
AS
SELECT Sno, Sname, Grade
FROM [S-T].IS_C1
WHERE Grade >= 90;

-- Example 3.90
CREATE VIEW [S-T].S_AGE(Sno, Sname, Sage)
AS
SELECT Sno, Sname, DATEDIFF(YEAR, Sbirthdate, GETDATE())
FROM [S-T].Student;

-- Example 3.91
CREATE VIEW [S-T].S_GradeAVG(Son, Gavg)
AS
SELECT Sno, AVG(Grade)
FROM [S-T].SC
GROUP BY Sno;

-- Example 3.92
CREATE VIEW [S-T].F_Student(Fsno, Fname, Fsex, Fbirthdate, Fmajor)
AS
SELECT *
FROM [S-T].Student
WHERE Ssex = '女';

-- Example 3.93
DROP VIEW [S-T].S_AGE;
DROP VIEW [S-T].IS_C1;

-- Example 3.94
SELECT Sno, Sbirthdate
FROM [S-T].IS_Student
WHERE DATEDIFF(YEAR, Sbirthdate, GETDATE()) <= 20;

-- Example 3.95
SELECT IS_Student.Sno, Sname
FROM [S-T].IS_Student,
     [S-T].SC
WHERE [S-T].IS_Student.Sno = SC.Sno
  AND SC.Cno = '81001';

-- Example 3.96
SELECT *
FROM [S-T].S_GradeAVG
WHERE Gavg >= 90;

-- Example 3.97
UPDATE [S-T].IS_Student
SET Sname = '刘新奇'
WHERE Sno = '20180005';

-- Example 3.98
INSERT INTO [S-T].IS_Student(Sno, Sname, Ssex, Sbirthdate, Smajor)
VALUES ('20180207', '赵新', '男', '2001-7-19', '信息管理与信息系统');

-- Example 3.99
DELETE
FROM [S-T].IS_Student
WHERE Sno = '20180207';



SELECT Sno, Grade
FROM (SELECT Sno,
             Grade,
             DENSE_RANK() OVER (ORDER BY Grade DESC) AS Rank
      FROM [S-T].SC) ranked
WHERE Rank = 3;

SELECT [S-T].Student.Sno, Sname, Grade
FROM [S-T].SC,
     [S-T].Student
WHERE Grade = (SELECT MAX(Grade) FROM [S-T].SC)
  AND SC.Sno = Student.Sno;

SELECT [S-T].Student.Sno, Sname, Grade
FROM [S-T].SC,
     [S-T].Student
WHERE Grade IN (SELECT MAX(Grade) FROM [S-T].SC)
  AND SC.Sno = Student.Sno;


SELECT [S-T].Student.Sno, Sname, Grade
FROM [S-T].SC,
     [S-T].Student
WHERE Grade IN (SELECT MAX(Grade)
                FROM [S-T].SC
                WHERE Grade NOT IN (SELECT MAX(Grade)
                                    FROM [S-T].SC));

SELECT [S-T].Student.Sno, Sname, Grade
FROM [S-T].SC
         JOIN [S-T].Student ON [S-T].SC.Sno = [S-T].Student.Sno
WHERE Grade = (SELECT MAX(Grade)
               FROM [S-T].SC
               WHERE Grade NOT IN (SELECT MAX(Grade)
                                   FROM [S-T].SC));



-- 面试题：求[S-T].SC.Grade中分数第N高的学生（N\=1,2,3）

-- 查询排名结果
SELECT [S-T].Student.Sno, Sname, Cname, Grade
FROM [S-T].SC
         JOIN [S-T].Student ON [S-T].SC.Sno = [S-T].Student.Sno
         JOIN [S-T].Course ON [S-T].Course.Cno = [S-T].SC.Cno
ORDER BY Grade DESC;

-- 获取第N高学生
SELECT [S-T].Student.Sno, Sname, Cname, Grade
FROM [S-T].SC
         JOIN [S-T].Student ON [S-T].SC.Sno = [S-T].Student.Sno
         JOIN [S-T].Course ON [S-T].Course.Cno = [S-T].SC.Cno
ORDER BY Grade DESC
OFFSET 2 - 1 ROWS FETCH NEXT 1 ROWS ONLY;





















