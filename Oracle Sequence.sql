-----------------------------------------------------------------------------------------------------------------------
-- Oracle Sequence
-----------------------------------------------------------------------------------------------------------------------

-- Проверьте значения последовательностей в таблице словаря данных USER_SEQUENCES.

SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM USER_SEQUENCES;

-- CREATE SEQUENCE statement Here is the basic syntax of the CREATE SEQUENCE statement:

CREATE SEQUENCE schema_name.sequence_name
[INCREMENT BY interval]  --  The default value of interval is 1.
[START WITH first_number]
[MAXVALUE max_value | NOMAXVALUE]  --  maximum value of 10^27 for an ascending sequence or -1 for a descending sequence.
[MINVALUE min_value | NOMINVALUE]  --   a minimum value of 1 for an ascending sequence or -10^26 for a descending sequence
[CYCLE | NOCYCLE]  --  Use NOCYCLE if you want the sequence to stop generating the next value when it reaches its limit. This is the default.
[CACHE cache_size | NOCACHE]  --  количество значений последовательности, которые Oracle будет предварительно выделять и хранить в памяти для более быстрого доступа. Минимальный размер кэша равен 2.
[ORDER | NOORDER];  --  

-- ) Basic Oracle Sequence
DROP SEQUENCE id_seq;
CREATE SEQUENCE id_seq
    INCREMENT BY 10
    START WITH 10
    MINVALUE 10
    MAXVALUE 100
    CYCLE
    CACHE 2;
    
SELECT  id_seq.CURRVAL  FROM  dual;
SELECT  id_seq.NEXTVAL  FROM  dual;

-- This SELECT statement uses the id_seq.NEXTVAL value repeatedly:
SELECT  id_seq.NEXTVAL  FROM  dual
CONNECT BY level <= 9;

--  2) Using a sequence in a table column example
-- First, create a new table called tasks:
-- DROP   TABLE tasks;
CREATE TABLE tasks(
    id NUMBER PRIMARY KEY,
    title VARCHAR2(255) NOT NULL
);
-- Second, create a sequence for the id column of the tasks table:
CREATE SEQUENCE task_id_seq;
-- Third, insert data into the tasks table:
INSERT INTO tasks(id, title)
VALUES(task_id_seq.NEXTVAL, 'Create Sequence in Oracle');
INSERT INTO tasks(id, title)
VALUES(task_id_seq.NEXTVAL, 'Examine Sequence Values');
-- Finally, query data from the tasks table:

SELECT  
    id, title
FROM
    tasks;
--- 3) Using the sequence via the identity column example
-- From Oracle 12c, you can associate a sequence with a table column via the identity column.
-- First, drop the tasks table:
DROP TABLE tasks;
-- Second, recreate the tasks table using the identity column for the id column:
CREATE TABLE tasks(
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR2(255) NOT NULL
);

-- Third, insert some rows into the tasks table:

INSERT INTO tasks(title)
VALUES('Learn Oracle identity column in 12c');

INSERT INTO tasks(title)
VALUES('Verify contents of the tasks table');

-- Finally, query data from the tasks table:

SELECT
    id, title
FROM
    tasks;

-- as SYSDBA
SELECT 
    a.name AS table_name,
    b.name AS sequence_name
FROM   
    sys.idnseq$ c
    JOIN obj$ a ON c.obj# = a.obj#
    JOIN obj$ b ON c.seqobj# = b.obj#
WHERE 
    a.name = 'TASKS'; 

--  Oracle ALTER SEQUENCE example
CREATE SEQUENCE invoice_seq
    START WITH 20190001;

ALTER SEQUENCE invoice_seq
CACHE 10;

DROP SEQUENCE invoice_seq;

CREATE SEQUENCE invoice_seq
    START WITH 20200001
    CACHE 10;

--  ПРАВИЛА ДЛЯ ИСПОЛЬЗОВАНИЯ NEXTVAL И CURRVAL

-- Можно использовать NEXTVAL и CURRVAL в следующих контекстах:

-- Список SELECT оператора SELECT, который не является частью подзапроса
-- Список подзапроса SELECT в операторе INSERT
-- Предложение VALUES оператора INSERT
-- Предложение SET оператора UPDATE

-- Нельзя использовать NEXTVAL и CURRVAL в следующих контекстах:

-- Список представления SELECT
-- Оператор SELECT с ключевым словом DISTINCT
-- Оператор SELECT с предложениями GROUP BY, HAVING или ORDER BY
-- Подзапрос в операторе SELECT, DELETE или UPDATE
-- Выражение DEFAULT в операторе CREATE TABLE или ALTER TABLE


