SELECT * FROM dbo.Student;
SELECT * FROM dbo.Course;
SELECT * FROM dbo.SC;

SELECT dbo.Student.Sno, dbo.Student.Sname, dbo.Course.Cname, dbo.SC.Grade
FROM dbo.SC
JOIN dbo.Student ON dbo.SC.Sno = dbo.Student.Sno
JOIN dbo.Course ON dbo.SC.Cno = dbo.Course.Cno;


SELECT dbo.Student.Sno, dbo.Student.Sname, dbo.Course.Cname, dbo.SC.Grade
FROM dbo.Student
LEFT JOIN dbo.SC ON dbo.Student.Sno = dbo.SC.Sno
LEFT JOIN dbo.Course ON dbo.SC.Cno = dbo.Course.Cno
WHERE dbo.SC.Sno IS NULL;

-------------------------------------------------------------------
ALTER TABLE dbo.Student
ADD CONSTRAINT key_student PRIMARY KEY (Sno);

INSERT INTO dbo.Student(Sno, Sname, Ssex, Sage, Sdept)
VALUES
    (201215121, N'李勇', N'男', 20, 'CS'),
    (201215122, N'刘晨', N'女', 19, 'CS'),
    (201215123, N'王敏', N'女', 18, 'MA'),
    (201215125, N'张立', N'男', 19, 'IS');

DELETE FROM dbo.Student
WHERE Sno IN (201215121, 201215122, 201215123, 201215125);

-----------------------------------------------------------------------------------------
DELETE FROM dbo.Course
WHERE Cno IN (1, 2, 3, 4, 5, 6, 7);

ALTER TABLE dbo.Course
ADD CONSTRAINT key_course PRIMARY KEY (Cno);

INSERT INTO dbo.Course(Cno, Cname, Cpno, Ccredit)
VALUES
    (1, N'数据库', 5, 4),
    (2, N'数学', NULL, 2),
    (3, N'信息系统', 1, 4),
    (4, N'操作系统', 6, 3),
    (5, N'数据结构', 7, 4),
    (6, N'数据处理', NULL, 2),
    (7, N'PASCAL语言', 6, 4);

----------------------------------------------------------------------------------------
ALTER TABLE dbo.SC
ADD CONSTRAINT key_from_student FOREIGN KEY (Sno)
REFERENCES dbo.Student (Sno);

ALTER TABLE dbo.SC
ADD CONSTRAINT key_from_course FOREIGN KEY (Cno)
REFERENCES dbo.Course (Cno);

INSERT INTO dbo.SC(Sno, Cno, Grade)
VALUES
    (201215121, 1, 92),
    (201215121, 2, 85),
    (201215121, 3, 88),
    (201215122, 2, 90),
    (201215122, 3, 80);
