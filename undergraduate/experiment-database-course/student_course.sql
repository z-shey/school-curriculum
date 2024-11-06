CREATE DATABASE StudentCourse;

USE StudentCourse;

-- 创建学生表
CREATE TABLE student
(
    id     INT PRIMARY KEY,
    name   VARCHAR(50),
    age    INT,
    gender VARCHAR(10)
);

-- 创建课程大全表
CREATE TABLE course
(
    id      INT PRIMARY KEY,
    name    VARCHAR(100),
    credit  INT,
    teacher VARCHAR(50)
);

-- 创建学生选课表
CREATE TABLE student_course
(
    id         INT PRIMARY KEY,
    student_id INT,
    course_id  INT,
    FOREIGN KEY (student_id) REFERENCES student (id),
    FOREIGN KEY (course_id) REFERENCES course (id)
);

-- 创建学生课程成绩表
CREATE TABLE student_score
(
    id                INT PRIMARY KEY,
    student_course_id INT,
    score             FLOAT,
    FOREIGN KEY (student_course_id) REFERENCES student_course (id)
);

-- 插入学生表测试数据
INSERT INTO student (id, name, age, gender)
VALUES (1, '张三', 20, '男'),
       (2, '李四', 21, '女'),
       (3, '王五', 19, '男'),
       (4, '赵六', 22, '女'),
       (5, '钱七', 20, '男');

-- 插入课程大全表测试数据
INSERT INTO course (id, name, credit, teacher)
VALUES (1, '数学', 4, '张立'),
       (2, '英语', 3, '李莱'),
       (3, '物理', 4, '王明明'),
       (4, '化学', 3, '赵天'),
       (5, '历史', 2, '钱朵朵');

-- 插入学生选课表测试数据
INSERT INTO student_course (id, student_id, course_id)
VALUES (1, 1, 1),
       (2, 1, 3),
       (3, 2, 2),
       (4, 3, 4),
       (5, 4, 5);

-- 插入学生课程成绩表测试数据
INSERT INTO student_score (id, student_course_id, score)
VALUES (1, 1, 85.5),
       (2, 2, 92.0),
       (3, 3, 78.5),
       (4, 4, 95.0),
       (5, 5, 88.5);


SELECT student.name   AS '学生姓名',
       course.name    AS '课程名',
       course.teacher AS '课程老师'
FROM student_course
         INNER JOIN student ON student_course.student_id = student.id
         INNER JOIN course ON student_course.course_id = course.id;

SELECT student.name                                  AS '学生姓名',
       course.name                                   AS '课程名',
       course.teacher                                AS '课程老师',
       student_score.score                           AS '学生成绩'
FROM student_score
         INNER JOIN student_course ON student_score.student_course_id = student_course.id
         INNER JOIN student ON student_course.student_id = student.id
         INNER JOIN course ON student_course.course_id = course.id;
