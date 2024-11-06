USE CourseSelection;

-- 向Student表插入多行数据
INSERT INTO Student (Sno, Sname, Sage, Ssex, Sdept)
VALUES (201215121, '李勇', 20, N'男', 'CS'),
       (201215122, '刘晨', 19, N'女', 'CS'),
       (201215123, '王敏', 18, N'女', 'MA'),
       (201215125, '张立', 19, N'男', 'IS');

-- 向Course表插入多行数据
INSERT INTO Course (Cno, Cname, Ccredit, Cpno)
VALUES (1, '数据库', 4, 5),
       (2, '数学', 2, NULL),
       (3, '信息系统', 4, 1),
       (4, '操作系统', 3, 6),
       (5, '数据结构', 4, 7),
       (6, '数据处理', 2, NULL),
       (7, 'PASCAL语言', 4, 6);

-- 向SC表插入多行数据
INSERT INTO SC (Sno, Cno, Grade)
VALUES (201215121, 1, 92),
       (201215121, 2, 85),
       (201215121, 3, 88),
       (201215122, 2, 90),
       (201215122, 3, 80);
