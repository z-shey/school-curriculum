USE CourseSelection_assignment;

-- Example 4.1
GRANT SELECT
    ON [S-T].Student
    TO U1;

-- Example 4.2
GRANT ALL PRIVILEGES
    ON [S-T].Student
    TO U2,U3

-- Example 4.3
GRANT SELECT
    ON [S-T].SC
    TO PUBLIC;

-- Example 4.4
GRANT UPDATE (sno), SELECT
    ON [S-T].Student
    TO U4;

-- Example 4.5
GRANT INSERT
    ON [S-T].SC
    TO U5
    WITH GRANT OPTION;

-- Example 4.6
GRANT INSERT
    ON [S-T].SC
    TO U6
    WITH GRANT OPTION;

-- Example 4.7
GRANT INSERT
    ON [S-T].SC
    TO U7;

-- Example 4.8
REVOKE UPDATE (sno)
    ON [S-T].Student
    FROM U4;

-- Example 4.9
REVOKE SELECT
    ON [S-T].SC
    FROM PUBLIC;

-- Example 4.10
REVOKE INSERT
    ON [S-T].SC
    FROM U5 CASCADE;

-- Example 4.11
CREATE LOGIN system2 WITH PASSWORD = '123456';

-- Example 4.12
-- 创建具有创建数据库权限的用户U1
CREATE LOGIN U1 WITH PASSWORD = '123456';
CREATE USER U1 FOR LOGIN U1;
ALTER SERVER ROLE sysadmin ADD MEMBER U1;

-- 创建普通用户U2
CREATE LOGIN U2 WITH PASSWORD = '123456';
CREATE USER U2 FOR LOGIN U2;

-- Example 4.13
CREATE DATABASE U1DB;

-- Example 4.14
CREATE ROLE R1;

GRANT SELECT, UPDATE, INSERT
    ON [S-T].Student
    TO R1;

ALTER ROLE R1 ADD MEMBER 王平;
ALTER ROLE R1 ADD MEMBER 张三;
ALTER ROLE R1 ADD MEMBER 李四;

ALTER ROLE R1 DROP MEMBER 王平;
ALTER ROLE R1 DROP MEMBER 张三;
ALTER ROLE R1 DROP MEMBER 李四;

-- Example 4.15
GRANT DELETE
    ON [S-T].Student
    TO R1;

-- Example 4.16
REVOKE SELECT
    ON [S-T].Student
    FROM R1;

-- Example 4.17
CREATE VIEW [S-T].CS_Student /*建立视图[S-T]架构下的视图CS_Student*/
AS
SELECT *
FROM [S-T].Student
WHERE Smajor = '计算机科学与技术'
WITH CHECK OPTION;

GRANT SELECT
    ON [S-T].CS_Student
    TO 王平;

GRANT ALL PRIVILEGES
    ON [S-T].CS_Student
    TO 张明;

-- Example 4.18
USE master;

CREATE SERVER AUDIT SCLogs
    TO FILE (FILEPATH = 'C:\logs\', MAXSIZE = 10 MB, MAX_FILES = 10, RESERVE_DISK_SPACE = ON)
    WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE);

SELECT name, is_state_enabled
FROM sys.server_audits;

ALTER SERVER AUDIT SCLogs WITH (STATE = ON);

USE CourseSelection_assignment;
CREATE DATABASE AUDIT SPECIFICATION SCLogs
    FOR SERVER AUDIT SCLogs
    ADD (DATABASE_OBJECT_CHANGE_GROUP) ,
ADD(SELECT, INSERT, DELETE, UPDATE ON [S-T].SC BY PUBLIC);

-- Example 4.19
DROP SERVER AUDIT SCLogs;

/*
 * 问题：小张刚来学校工作不久，平时工作内容主要是维护学生基本信息，领导不放心，怕他出错。对DBA提出了如下要求：
 * 1、先让小张熟悉一下学生基本信息包含哪些内容，在第一个学期仅给予小张登录系统以及查询学生基本信息的权限。
 * 2、在第二个学期才给他分配插入、修改、删除学生基本信息表的权限。
 * 3、小张平时做了哪些操作要有痕迹。
 */


-- 创建登录名
CREATE LOGIN loginzhang WITH PASSWORD = 'zhang123456';
-- 创建用户名
CREATE USER userzhang FOR LOGIN loginzhang;

-- 创建审计
USE master;

CREATE SERVER AUDIT UserLogs
    TO FILE (FILEPATH = 'C:\logs\', MAXSIZE = 10 MB, MAX_FILES = 10, RESERVE_DISK_SPACE = ON)
    WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE);

ALTER SERVER AUDIT UserLogs
    WITH (STATE = ON);

USE CourseSelection_assignment;

CREATE DATABASE AUDIT SPECIFICATION StudentLogs
    FOR SERVER AUDIT UserLogs
    ADD (DATABASE_OBJECT_CHANGE_GROUP) ,
ADD(SELECT, INSERT, DELETE, UPDATE ON [S-T].Student BY PUBLIC);

-- 查询审计
SELECT event_time,
       succeeded,
       server_principal_name,
       [object_name],
       [statement]
FROM sys.fn_get_audit_file('C:\logs\*', DEFAULT, DEFAULT);



-- 第一学期给予查询学生基本信息的权限
GRANT SELECT ON [S-T].Student TO userzhang;

-- 创建插入、修改、删除的角色，并授权
CREATE ROLE InfoEditor;
GRANT SELECT, INSERT, UPDATE, DELETE ON [S-T].Student TO InfoEditor;

-- 第二学期授权
ALTER ROLE InfoEditor ADD MEMBER userzhang;

