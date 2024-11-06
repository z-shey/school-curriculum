IF NOT EXISTS(SELECT *
              FROM sys.databases
              WHERE name = 'Algorithm_SQL')
    BEGIN
        CREATE DATABASE Algorithm_SQL;
    END
GO

IF NOT EXISTS(SELECT *
              FROM sys.schemas
              WHERE name = 'ALG')
    BEGIN -- 语法好像有点问题，不能一次性执行
        USE Algorithm_SQL;
        CREATE SCHEMA [ALG];
    END
GO

USE Algorithm_SQL;
-- 创建表
IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'[ALG].[Alumni]'))
    BEGIN
        CREATE TABLE [ALG].Alumni
        (
            sno   SMALLINT,
            email VARCHAR(255)
        )

        INSERT INTO [ALG].Alumni (sno, email)
        VALUES (1, 'zlk@kailixy.com'),
               (2, 'whz@kailixy.com'),
               (3, 'ycj@kailixy.com'),
               (4, 'zlk@kailixy.com'),
               (5, 'whz@kailixy.com'),
               (6, 'ycj@kailixy.com')
    END
GO

SELECT *
FROM [ALG].Alumni;
GO







DECLARE @TempTable TABLE
                   (
                       sno   SMALLINT,
                       email VARCHAR(255)
                   )

DECLARE @sno SMALLINT, @email VARCHAR(255)

DECLARE EmailCursor CURSOR FOR
    SELECT sno, email
    FROM [ALG].Alumni

OPEN EmailCursor

FETCH NEXT FROM EmailCursor INTO @sno, @email;

WHILE @@FETCH_STATUS = 0
    BEGIN -- FETCH_STATUS -> 1
        IF NOT EXISTS (SELECT * FROM @TempTable WHERE email = @email)
            BEGIN
                INSERT INTO @TempTable (sno, email)
                VALUES (@sno, @email)
            END
        FETCH NEXT FROM EmailCursor INTO @sno, @email -- 移动
    END

CLOSE EmailCursor
DEALLOCATE EmailCursor

SELECT sno, email
FROM @TempTable
GO


