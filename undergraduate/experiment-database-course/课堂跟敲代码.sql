USE CourseSelectionClass;

SELECT COUNT(sname) 学生人数
FROM [S-T].Student;

SELECT COUNT(sno) 选课人数
FROM [S-T].SC
SELECT COUNT(DISTINCT sno) 选课人数
FROM [S-T].SC;

SELECT cno, COUNT(sno)
FROM [S-T].SC
GROUP BY cno;



SELECT *
FROM [S-T].Student
WHERE sname LIKE '李%';

SELECT sno                             AS 学号,
       sname                           AS 姓名,
       ssex                            AS 性别,
       DATEADD(YEAR, -sage, GETDATE()) AS 出生年月,
       sage                            AS 年龄,
       LOWER(sdept)                    AS 系别
FROM [S-T].Student;

SELECT sname, sage AS '年龄'
FROM [S-t].Student
WHERE sdept = 'CS' AND sage < 20;

SELECT TOP 1 *
FROM [S-T].Course;

SELECT Course.cno, Course.cname, COUNT(SC.cno)
FROM [S-T].Course, [S-T].SC
GROUP BY SC.cno, Course.cno, Course.cname;


SELECT COUNT(DISTINCT SC.sno) AS 选修人数
FROM [S-T].SC


SELECT AVG(grade) AS Average
FROM [S-T].SC
WHERE cno = '1';
SELECT MAX(grade) AS Max
FROM [S-T].SC
WHERE cno = '2';


SELECT sno, grade
FROM [S-T].SC
WHERE cno = '3'
ORDER BY grade DESC;



SELECT Student.sname AS 学生姓名, Course.cname AS 课程名, SC.grade AS 成绩
FROM [S-T].SC
JOIN [S-T].Student ON SC.sno = Student.sno
JOIN [S-T].Course ON SC.cno = Course.cno
WHERE Course.cno = '3' AND Student.sdept = 'CS';



SELECT s.sno AS 学号, s.sname AS 姓名, s.sage AS 年龄, s.sdept AS 系别
FROM [S-T].Student s
WHERE s.sdept = 'CS'
UNION
SELECT s.sno, s.sname, s.sage, s.sdept
FROM [S-T].Student s
WHERE s.sage < 20;



SELECT c.cno AS 课程号, c.cname AS 课程, COUNT(*) AS 选修人数
FROM [S-T].SC sc
JOIN [S-T].Course c ON sc.cno = c.cno
GROUP BY c.cno, c.cname;


SELECT sno AS 学号, COUNT(*) AS 课程数
FROM [S-T].SC
GROUP BY sno;
