USE CourseSelectionClass
GO
CREATE TABLE Student_New
(
    Sno      int      NOT NULL,
    Sname    NVARCHAR(10),
    Ssex     CHAR(2) CHECK (Ssex IN ('男', '女')),
    Birthday DATETIME NULL,
    Sdept    NCHAR(10)
);

USE CourseSelectionClass
GO
CREATE TABLE SC_NEW
(
    Sno    int      NOT NULL,
    Cno    int      NOT NULL,
    Grade  SMALLINT NULL,
    Credit SMALLINT NULL,
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Cno) REFERENCES Course (Cno),
    FOREIGN KEY (Sno) REFERENCES Student (Sno)
);


USE CourseSelectionClass
GO
CREATE DEFAULT dept_student AS N'女';


USE CourseSelectionClass
GO
EXEC sp_bindefault dept_student, 'Student.Ssex';

EXEC sp_unbindefault 'Student.Ssex';



USE CourseSelectionClass
GO
CREATE RULE Sage_Student AS @Sage >= 10 AND @Sage <= 100;

USE CourseSelectionClass
GO
EXEC sp_bindrule Sage_Student, 'Student.Sage';

EXEC sp_unbindrule 'Student.Sage';



USE CourseSelectionClass;