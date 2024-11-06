use CourseSelection
go
CREATE TABLE Student_Check
(
    Sno      int      NOT NULL,
    Sname    nvarchar(10),
    Ssex     char(2) check (ssex in ('男', '女')),
    birthday datetime NULL,
    Sdept    nchar(10)
);

use CourseSelection
go
CREATE TABLE SC_Check
(
    Sno    int      NOT NULL,
    Cno    int  NOT NULL,
    Grade  FLOAT NULL,
    Credit FLOAT NULL,
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Cno) REFERENCES Course (Cno),
    FOREIGN KEY (Sno) REFERENCES Student (Sno)
);





use CourseSelection
go
Create default dept_student  as '女';

use CourseSelection
go
exec sp_bindefault dept_student,'Student.Ssex';


Exec sp_unbindefault 'Student.Ssex';





Use CourseSelection
Go
Create rule sage_Student as @Sage>=10 and @Sage<=100


Use CourseSelection
Go
Exec sp_bindrule sage_Student,'Student.Sage'


Exec sp_unbindrule 'Student.Sage'