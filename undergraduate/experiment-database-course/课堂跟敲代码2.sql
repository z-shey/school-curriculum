SELECT *
FROM [S-T].SC
         CROSS JOIN
     [S-T].Student;

SELECT *
FROM [S-T].SC
        ,
     [S-T].Student;

SELECT *
FROM [S-T].SC
         INNER JOIN
     [S-T].Student
     ON [S-T].SC.sno = [S-T].Student.sno;

-- SELECT *
-- FROM [S-T].Student
--          INNER JOIN
--      [S-T].SC
--          INNER JOIN
--      [S-T].Course
--      ON
--          (
--           [S-T].Student.sno = [S-T].SC.sno,
--           [S-T].Course.cno = [S-T].SC.cno
--              );

SELECT MAX(grade)
FROM [S-T].SC