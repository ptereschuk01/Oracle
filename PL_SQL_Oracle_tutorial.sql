-- *****************************************************************************************************************************

-- Lesson 1: PL/SQL Introduction
-- Lesson 2: Cursors
-- Lesson 3: Procedures and functions
-- Lesson 4: Exception handling
-- Lesson 5: Packages
-- Lesson 6: Triggers
-- Lesson 7: Dynamic SQL, transactions
-- Lesson 8: Collections and Object Types

-- *****************************************************************************************************************************

set serveroutput on;

CREATE TABLE departments
(
    depid INT PRIMARY KEY,
    NAME VARCHAR(50)
); -- Table DEPARTMENTS created.

CREATE TABLE employees
(
    employeeid  INT PRIMARY KEY,
    depid       INT,
    surname     VARCHAR2(40),
    NAME        VARCHAR2(30),
    bossid      INT,
    salary      NUMBER,
    CONSTRAINT fk FOREIGN KEY(depid) REFERENCES departments(depid)
); -- Table EMPLOYEES created.

DROP TABLE employees;
DROP TABLE departments;

INSERT INTO departments (depid, NAME) VALUES (1, 'Management'); -- 1 row inserted.
INSERT INTO departments (depid, name) VALUES (2, 'Administration'); -- 1 row inserted.
INSERT INTO departments (depid, name) VALUES (3, 'Technological'); -- 1 row inserted.
INSERT INTO departments (depid, name) VALUES (4, 'Business'); -- 1 row inserted.
INSERT INTO departments (depid, name) VALUES (5, 'Support'); -- 1 row inserted.

INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (1, 1, 'Smith', 'Jacob', NULL, 23000);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (2, 2, 'Johnson', 'Ethan', 1, 5300);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (3, 3, 'Williams', 'Isabella', 1, 4500);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (4, 2, 'Jones', 'Alexander', 2, 6900);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (5, 3, 'Brown', 'Joshua', 3, 4300);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (6, 4, 'Davis', 'Jan', 3, 6590);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (7, 5, 'Smith', 'Madison', 4, 4560);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (8, 5, 'Williams', 'Joshua', 3, 3300);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (9, 1, 'Nowicki', 'William', 4, 13800);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (10, 2, 'Miller', 'Emma', 1, 16000);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (11, 4, 'Moore', 'Laurence', 4, 4500);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (12, 2, 'Brown', 'Madison', 2, 9800);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (13, 4, 'Davis', 'Alexander', 3, 7800);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (14, 5, 'Taylor', 'Olivia', 4, 4500);  -- 1 row inserted.
INSERT INTO employees (employeeid, surname, name, bossid)  VALUES (15, 'Moore', 'Madison', 5);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (16, 1, 'Baranowski', 'Jacob', 2, 7600);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (17, 1, 'Jakow', 'Isabella', 4, 5800);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (18, 1, 'Jackson', 'Robert', 2, 7100);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (19, 1, 'Taylor', 'Jurgen', 3, 8200);  -- 1 row inserted.
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (20, 1, 'Williams', 'Emma', 4, 7300);  -- 1 row inserted.

COMMIT;
-- SELECT * FROM departments;  SELECT * FROM employees;

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Basics (Lesson 1) PL/SQL Introduction
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
set serveroutput on;
-- Basic anonymous block
DECLARE
    var1 INTEGER;
    var2 VARCHAR2(6) := 'World';
BEGIN
    var1 := 5;
    DBMS_OUTPUT.PUT_LINE( 'Hello ' || var2);
END;

--------------------------------------------------------------------------------------------------------------------------------
--  Basic DATATYPES
--------------------------------------------------------------------------------------------------------------------------------
/*

- VARCHAR2(size) - variable-length character string having maximum length size bytes. Maximum size is 4000, and minimum is
	1. We must specify size for VARCHAR2.
- NVARCHAR2(size) - variable-length character string having maximum length size characters or bytes, depending on the
	choice of national character set. Maximum size is determined by the number of bytes required to store each character, with
	an upper limit of 4000 bytes. We must specify size for NVARCHAR2.
- NUMBER(p,s) - number having precision p and scale s. The precision p can range from 1 to 38. The scale s can range from -84 to 127.
- LONG - character data of variable length up to 2 gigabytes, or 231 -1 bytes.
- DATE - valid date range from January 1, 4712 BC to December 31, 9999 AD.
- RAW(size) - raw binary data of length size bytes. Maximum size is 2000 bytes. We must specify size for a RAW value.
- ROWID - hexadecimal string representing the unique address of a row in its table. This datatype is primarily for values
	returned by the ROWID pseudo column.
- CHAR(size) - fixed-length character data of length size bytes. Maximum size is 2000 bytes. Default and minimum size is 1 byte.
- NCHAR(size) - fixed-length character data of length size characters or bytes, depending on the choice of national character
	set. Maximum size is determined by the number of bytes required to store each character, with an upper limit of 2000 bytes.
	Default and minimum size is 1 character or 1 byte, depending on the character set.
- CLOB - a character large object containing single-byte characters. Both fixed-width and variable-width character sets are
	supported, both using the CHAR database character set. Maximum size is 4 gigabytes.
- BLOB - a binary large object. Maximum size is 4 gigabytes.
- BFILE - contains a locator to a large binary file stored outside the database. Enables byte stream l/O access to external
- LOBs residing on the database server. Maximum size is 4 gigabytes.
	There are many sub-types, which are derived from a type and usually add a constraint to a type. For example, an INTEGER is
	a sub-type of NUMBER and only whole numbers are allowed.

If we want to convert values to different data types, we should use conversion functions:
  - to_char( value, [format_mask ] ) - converts a number or date to a string. VALUE can either be a number or date that will be 
converted to a string, FORMAT_MASK is optional, this is the format that will be used to convert value to a string.
  - to_number( string 1, [ format_mask ]) - converts a string to a number, string1 is the string that will be converted 
to a number.format_mask is optional. This is the format that will be used to convert string1 to a number.
  - to_date( string 1, [format_mask ] ) - converts a string to a date. string1 is the string that will be converted to a date. 
format mask is optional. This is the format that will be used to convert string1 to a date.
*/

DECLARE
    num_var         NUMBER (4,2)    := 11.25;
    int_var         INTEGER         := 5;
    date_var        DATE            := TO_DATE ('02/04/2022', 'dd/mm/yyyy');
    string_var      VARCHAR2 (50)   := 'string 1';
    string_no_var   VARCHAR2 (50)   := '5.30';
    char_var        CHAR (50)       := 'string 2';
BEGIN
    DBMS_OUTPUT.PUT_LINE( 'num_var: ' || num_var);
    DBMS_OUTPUT.PUT_LINE( 'int_var: ' || int_var);
    DBMS_OUTPUT.PUT_LINE( 'date_var: ' || date_var);
    DBMS_OUTPUT.PUT_LINE( 'string_var: ' || string_var);
    DBMS_OUTPUT.PUT_LINE( 'char_var: ' || char_var);
    
    DBMS_OUTPUT.PUT_LINE( 'We can convert numeric value to a string (TO_CHAR(num_var)): ' || TO_CHAR(num_var));
    DBMS_OUTPUT.PUT_LINE( '   or string value to a number: ' || TO_NUMBER(string_no_var, '9.99'));
    
END;

DECLARE
    emp_name    employees.NAME%TYPE;
    emp_surname employees.surname%TYPE;
BEGIN
    SELECT NAME, surname
      INTO emp_name, emp_surname
      FROM employees
     WHERE employeeid = 5;
    
     DBMS_OUTPUT.PUT_LINE( emp_name || ', ' || emp_surname);
END;
/*
   %ROWTYPE
The %ROWTYPE attribute provides a record type that represents a row in a database table. The record can store an entire row of 
data selected from the table or fetched from a cursor or cursor variable. Variables declared using %ROWTYPE are treated like 
those declared using a datatype name. We can use the %ROWTYPE attribute in variable declarations as a datatype specifier.
*/
DECLARE
    employee_record employees%ROWTYPE;
BEGIN
    SELECT *
      INTO employee_record
      FROM employees
     WHERE employeeid = 5;
    
     DBMS_OUTPUT.PUT_LINE( 'name: ' || employee_record.NAME );
     DBMS_OUTPUT.PUT_LINE( 'surname: ' || employee_record.surname );
     DBMS_OUTPUT.PUT_LINE( 'boss id: ' || employee_record.bossid );
END;

--------------------------------------------------------------------------------------------------------------------------------
-- CONDITIONAL STRUCTURES
--------------------------------------------------------------------------------------------------------------------------------

DECLARE
    var1 INTEGER := 5; -- 3, 8
BEGIN
    IF var1 = 5
        THEN DBMS_OUTPUT.PUT_LINE( 'var1 valuue is equal to 5');
    ELSIF  var1 > 5
        THEN DBMS_OUTPUT.PUT_LINE( 'var1 valuue is > 5');
    ELSE
             DBMS_OUTPUT.PUT_LINE( 'var1 valuue is < 5');
    END IF;
END;

DECLARE
    var1 INTEGER := -12; -- 3, 8
BEGIN
    CASE
        WHEN var1 = 5 THEN DBMS_OUTPUT.PUT_LINE( 'var1 valuue is equal to 5');
        WHEN var1 > 5 THEN DBMS_OUTPUT.PUT_LINE( 'var1 valuue is > 5');
        WHEN var1 < 5 THEN DBMS_OUTPUT.PUT_LINE( 'var1 valuue is < 5');
        ELSE DBMS_OUTPUT.PUT_LINE( 'var1 valuue is UNKNOWN');
    END CASE;
END;   

--------------------------------------------------------------------------------------------------------------------------------
-- CITERATIVE STRUCTURES
--      SIMPLE LOOP (LOOP / EXIT WHEN / END LOOP)
--      WHILE LOOP (WHILE / LOOP / END LOOP)
--      FOR LOOP 
--              (FOR i IN 1..10     / LOOP / END LOOP)
--              (FOR i IN SELECT... / LOOP / END LOOP)
--------------------------------------------------------------------------------------------------------------------------------

-- SIMPLE LOOP

DECLARE
    i INTEGER := 0;
BEGIN
    LOOP
        i := i + 1;
        DBMS_OUTPUT.PUT_LINE( 'The indey value is: -> ' || i);
        EXIT WHEN i >= 10;
    END LOOP;
END;   

-- WHILE LOOP

DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 10
    LOOP
        DBMS_OUTPUT.PUT_LINE( 'The indey value is: -> ' || i);
        i := i + 1;
    END LOOP;
END;

-- FOR LOOP

BEGIN
    FOR i IN 1..10
    LOOP
        DBMS_OUTPUT.PUT_LINE( 'The indey value is: -> ' || i );
    END LOOP;
END;

BEGIN
    FOR i IN (SELECT surname FROM employees WHERE depid = 2)
    LOOP
        DBMS_OUTPUT.PUT_LINE( 'Department 2 -> ' || i.surname );
    END LOOP;
END;


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Lesson 2: Cursors
--      Implicit cursors
--      Explicit cursors
--          Static cursors
--          Dinamic cursors
--      Cursor For Update
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/*
A cursor is a named SQL SELECT statement that we can use in our PL/SQL program to access multiple rows from a table and
retrieve them one row at a time.
A cursor is a mechanism by which we can assign a name to a "select statement" and manipulate the information within that SQL statement.
There are two types of CURSORS: IMPLICIT and EXPLICIT.
Курсор - это именованная инструкция SQL SELECT, которую мы можем использовать в нашей программе PL/SQL для доступа 
к нескольким строкам из таблицы и извлечения их по одной строке за раз.
Курсор - это механизм, с помощью которого мы можем присвоить имя "оператору выбора" и манипулировать информацией внутри него Инструкция SQL.
Существует два типа КУРСОРОВ: НЕЯВНЫЕ и ЯВНЫЕ.
*/

--------------------------------------------------------------------------------------------------------------------------------
--      Implicit cursors
--------------------------------------------------------------------------------------------------------------------------------
-- Implicit cursors are simple SELECT statements and are written in the BEGIN block (executable section)
-- Неявные курсоры представляют собой простые операторы SELECT и записываются в блоке BEGIN (раздел executable)

-- Every SQL statement in a PL/SQL block is actual an implicit cursor.
-- Каждая инструкция SQL в блоке PL/SQL фактически является неявным курсором.

DECLARE
    employee_rec employees%ROWTYPE;
BEGIN
    SELECT  *
    INTO    employee_rec
    FROM    employees
    WHERE   employeeid = 5;
    
    IF SQL%FOUND
    THEN
        DBMS_OUTPUT.PUT_LINE( 'Selected -> ' || SQL%ROWCOUNT );
    END IF;
END;

/*
Implicit cursors are managed automatically by PL/SQL so we are not required to write any code to handle these cursors. 
However, we can track information about the execution of an implicit cursor through its cursor attributes.
Неявные курсоры автоматически управляются PL/SQL, поэтому нам не требуется писать какой-либо код для обработки этих курсоров. 
Однако, мы можем отслеживать информацию о выполнении неявного курсора через его атрибуты курсора.

We can see how many rows are selected or changed by any statement using the %ROWCOUNT attribute after a Data Manipulation 
Language (DML) statement. INSERT, UPDATE, and DELETE statements are DML statements.
The reserved word SQL before the %ROWCOUNT cursor attribute stands for any implicit cursor.
Мы можем видеть, сколько строк выбрано или изменено любым оператором, используя атрибут %ROWCOUNT после инструкции Языка 
обработки данных (DML). Инструкции INSERT, UPDATE и DELETE - это инструкции DML.
Зарезервированное слово SQL перед атрибутом курсора %ROWCOUNT обозначает любой неявный курсор.

%FOUND - this attribute yields TRUE if an INSERT, UPDATE, or DELETE statement affected one or more rows or a SELECT INTO 
statement returned one or more rows. Otherwise, it yields FALSE.
%FOUND - этот атрибут возвращает значение TRUE, если инструкция INSERT, UPDATE или DELETE затронула одну или несколько строк 
или инструкция SELECT INTO вернула одну или несколько строк. В противном случае он выдает значение FALSE.
*/


-------------------------------------------------------------------------------------------------------------
--      EXPLICIT CURSORS
-------------------------------------------------------------------------------------------------------------
/*
EXPLICIT CURSORS can be STATIC or DYNAMIC SELECT statements. 
ЯВНЫЕ КУРСОРЫ могут быть СТАТИЧЕСКИМИ или ДИНАМИЧЕСКИМИ операторами.
- STATIC SELECT statements return the same query each time with potentially different results. The results change as the data 
changes in the tables or views.
Операторы STATIC SELECT каждый раз возвращают один и тот же запрос с потенциально разными результатами. 
Результаты меняются по мере изменения данных в таблицах или представлениях.
- DYNAMIC SELECT statements act like parameterized subroutines. They run different queries each time, depending on the actual 
parameters provided when they are opened.
Операторы ДИНАМИЧЕСКОГО ВЫБОРА действуют как параметризованные подпрограммы. Каждый раз они выполняют разные запросы, 
в зависимости от фактических параметров, предоставляемых при их открытии.
*/

--------------------------------------------------------------------------------------
--          STATIC CURSORS
--------------------------------------------------------------------------------------
-- The script prints employees from department 1.
BEGIN
    FOR i IN ( SELECT name, surname 
                FROM employees 
                WHERE depid = 1)
    LOOP
        DBMS_OUTPUT.PUT_LINE( 'Department 1 -> ' || i.name || ' ' || i.surname );
    END LOOP;
END;

-- We can use EXPLICIT CURSOR and move the SELECT expression to the cursor declaration.
DECLARE
    v_name      employees.name%TYPE;
    v_surname   employees.surname%TYPE;
    
    CURSOR get_employees -- We declare explicit cursors in the declaration section of a PL/SQL block just as variables.
    IS
        SELECT name, surname 
        FROM employees 
        WHERE depid = 1;
BEGIN
    OPEN get_employees;
    
    LOOP
        FETCH get_employees INTO v_name, v_surname;
        EXIT WHEN get_employees%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE( 'Department 1 -> ' || v_name || ' ' || V_surname );
    END LOOP;
    
    CLOSE get_employees;
END;
-- Explicit cursors require you to open, fetch, and close them whether you're using simple or WHILE loops or cursor FOR loop statements. 
-- You use the OPEN statement to open cursors, the FETCH statement to fetch records from cursors, and the CLOSE statement to close 
-- and release resources of cursors.
-- Явные курсоры требуют, чтобы вы открывали, извлекали и закрывали их, независимо от того, используете ли вы
-- простые циклы или циклы WHILE или операторы cursor FOR loop. Вы используете инструкцию OPEN для открытия курсоров, инструкцию 
-- FETCH для извлечения записей из курсоров и инструкцию CLOSE для закрытия и освобождения ресурсов курсоров.

-- We can use WHILE loop to fetch records from a cursor.
DECLARE
    v_name      employees.name%TYPE;
    v_surname   employees.surname%TYPE;
    
    CURSOR get_employees -- We declare explicit cursors in the declaration section of a PL/SQL block just as variables.
    IS
        SELECT name, surname 
        FROM employees 
        WHERE depid = 4;
BEGIN
    OPEN get_employees;
    
    FETCH get_employees INTO v_name, v_surname;
    
    WHILE get_employees%FOUND
    LOOP
        DBMS_OUTPUT.PUT_LINE( 'Department 4 -> ' || v_name || ' ' || V_surname );
        FETCH get_employees INTO v_name, v_surname;   
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE( 'Selected: -> ' || get_employees%ROWCOUNT || ' get_employees.' );
    
    CLOSE get_employees;
END;
-- Cursor attributes:
-- %FOUND      - returns TRUE if the last FETCH found a row
-- %%NOTFOUND  - returns FALSE if the last FETCH found a row
-- %ISOPEN     - returns TRUE if the specified cursor is open
-- %ROWCOUNT   - returns the number of rows modified by the DML statement

-- To simplify expression we can use FOR loop. Cursor FOR loop statements implicitly open, fetch, and close cursors for you. 
-- There is no need to fetch records into additional variables.
-- The CURSOR FOR Loop will terminate when all of the records in the cursor have been fetched.
-- Чтобы упростить выражение, мы можем использовать ДЛЯ цикла. Операторы Cursor FOR loop неявно открывают, извлекают и 
-- закрывают курсоры для вас. Нет необходимости извлекать записи в дополнительные переменные.
-- Цикл CURSOR FOR завершится, когда будут извлечены все записи в курсоре.
DECLARE
    CURSOR get_employees
    IS
        SELECT name, surname 
        FROM employees 
        WHERE depid = 4;
BEGIN
    FOR i IN get_employees
    LOOP
        DBMS_OUTPUT.PUT_LINE( 'Department 4 -> ' || i.name || ' ' || i.surname );
    END LOOP;
END;

-- A cursor FOR loop statement does not support direct assignment of any type of variable, but we can assign values inside 
-- the FOR loop statement by using the cursor index. We can assign a record structure or an element of the record structure.
-- Оператор cursor FOR loop не поддерживает прямое присвоение переменных любого типа, но мы можем присваивать значения внутри 
-- оператора FOR loop с помощью индекса курсора. Мы можем назначить структуру записи или элемент структуры записи.
DECLARE
    employee_rec employees%ROWTYPE;

    CURSOR get_employees
    IS
        SELECT *
        FROM employees 
        WHERE depid = 4;
BEGIN
    FOR i IN get_employees
    LOOP
        employee_rec := i;
        DBMS_OUTPUT.PUT_LINE( 'Department 4 -> ' || employee_rec.name || ' ' || employee_rec.surname );
    END LOOP;
END;

--------------------------------------------------------------------------------------
--          DYNAMIC CURSORS
--------------------------------------------------------------------------------------
/*
Dynamic explicit cursors are very much like static explicit cursors. They use a SQL SELECT statement. Only the SELECT statement 
uses variables that change the query behavior. The variables take the place of what would otherwise be literal values.
Динамические явные курсоры очень похожи на статические явные курсоры. Они используют оператор SQL SELECT. Только оператор SELECT 
использует переменные, которые изменяют поведение запроса. Переменные заменяют то, что в противном случае было бы буквальными значениями.
Dynamic explicit cursors have the same four components as static cursors: you define, open, fetch from, and close a dynamic cursor.
Динамические явные курсоры имеют те же четыре компонента, что и статические курсоры: вы определяете, открываете, извлекаете и 
закрываете динамический курсор.
*/

-- The example program defines a cursor as a SELECT statement that queries the EMPLOYEES table for employees from department 4 
-- (defined as v_dep_no variable). This variable is declared as local variable and assigned numeric literal value. 
-- Пример программы определяет курсор как оператор SELECT, который запрашивает таблицу EMPLOYEES для сотрудников из отдела 4 
-- (определяется как переменная v_dep_no). Эта переменная объявляется как локальная переменная и присваивается числовое 
-- буквальное значение. 
DECLARE
    v_name      employees.name%TYPE;
    v_surname   employees.surname%TYPE;
    v_dep_no    INT := 4;

    CURSOR get_employees
    IS
        SELECT  NAME, surname
        FROM    employees
        WHERE   depid = v_dep_no;
BEGIN
    OPEN get_employees;
    
    LOOP
        FETCH get_employees INTO v_name, v_surname;
        EXIT WHEN get_employees%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Department 4 -> ' || v_name || ', ' || v_surname);
    END LOOP;
END;


-- The following program uses local variable inside the cursor's SELECT statement.
-- The value for department number are substituted when we open the cursor. This also works in cursor FOR and WHILE loops 
-- because the variables are substituted while opening the cursor.
-- Следующая программа использует локальную переменную внутри оператора ВЫБОРА курсора.
-- Значение для номера отдела подставляется, когда мы открываем курсор. Это также работает в циклах cursor FOR и WHILE, 
-- поскольку переменные заменяются при открытии курсора.

-- The variable which indicates department number in the SELECT statement is no longer local variable name. It is local variable 
-- to the cursor, defined by the formal parameter in the cursor definition. You should note that the variable have no physical size, 
-- because that is derived at run time. When we run the program, the value 4 is assigned to local variable v_dep_no. The local 
-- variables become actual parameter passed to open the cursor. The actual parameter is then assigned to the department number 
-- cursor-scoped variable.
-- Переменная, указывающая номер отдела в инструкции SELECT, больше не является именем локальной переменной. Это локальная переменная
-- курсора, определенная формальным параметром в определении курсора. Вы должны отметить, что переменная не имеет физического размера, 
-- поскольку она выводится во время выполнения. Когда мы запускаем программу, локальной переменной v_dep_no присваивается значение 4. 
-- Локальные переменные становятся фактическим параметром, передаваемым для открытия курсора. Затем фактический параметр присваивается 
-- переменной с областью действия курсора номера отдела.

DECLARE
    v_name      employees.name%TYPE;
    v_surname   employees.surname%TYPE;
    v_dep_no    INT := 4;

    CURSOR get_employees(dpartment_number INT)
    IS
        SELECT  NAME, surname
        FROM    employees
        WHERE   depid = dpartment_number;
BEGIN
    OPEN get_employees(v_dep_no);
    
    LOOP
        FETCH get_employees INTO v_name, v_surname;
        EXIT WHEN get_employees%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Department 4 -> ' || v_name || ', ' || v_surname);
    END LOOP;
END;

-- The same logic works when you substitute a cursor FOR loop statement.
-- The following loop structure is equivalent to the one in the simple loop statement.
-- Та же логика работает, когда вы заменяете оператор цикла курсором.
-- Следующая структура цикла эквивалентна структуре в инструкции simple loop.

DECLARE
    v_dep_no    INT := 4;

    CURSOR get_employees(dpartment_number INT)
    IS
        SELECT  NAME, surname
        FROM    employees
        WHERE   depid = dpartment_number;
BEGIN
    FOR i IN get_employees(v_dep_no)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Department 4 -> ' || i.name || ', ' || i.surname);
    END LOOP;
END;

-- We can open cursor many times for different values.
DECLARE
    v_dep_no    INT := 4;

    CURSOR get_employees(dpartment_number INT)
    IS
        SELECT  NAME, surname
        FROM    employees
        WHERE   depid = dpartment_number;
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------- Department -> ' || v_dep_no);
    FOR i IN get_employees(v_dep_no)
    LOOP
        DBMS_OUTPUT.PUT_LINE( i.name || ', ' || i.surname);
    END LOOP;
    
    v_dep_no := 2;
    DBMS_OUTPUT.PUT_LINE('-------- Department -> ' || v_dep_no);
    FOR i IN get_employees(v_dep_no)
    LOOP
        DBMS_OUTPUT.PUT_LINE( i.name || ', ' || i.surname);
    END LOOP;
    
END;


-- We can use the cursor to modify (UPDATE or DELETE) the current row.
-- Мы можем использовать курсор для изменения (обновления или удаления) текущей строки.
DECLARE
    v_dep_no INT := 4;
    
    CURSOR get_employees(department_number INT)
    IS
        SELECT  *
        FROM    employees
        WHERE   employees.depid = department_number;
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------- Department -> ' || v_dep_no);
    
    FOR i IN get_employees(v_dep_no)
    LOOP
        UPDATE  employees              --     UPDATE UPDATE UPDATE UPDATE UPDATE 
        SET     salary = salary * 1.2
        WHERE   employeeid = i.employeeid;
        
        DBMS_OUTPUT.PUT_LINE( i.name || ', ' || i.surname || ', ' || i.salary );
    END LOOP;
END;


--------------------------------------------------------------------------------------------------------------------------------
--      Cursor For Update
--------------------------------------------------------------------------------------------------------------------------------
/*
When you issue a SELECT statement against the database to query some records, no locks are placed on the selected rows. 
In general, this is a wonderful feature because the number of records locked at any given time is (by default) kept to the 
absolute minimum: only those records which have been changed but not yet committed are locked. Even then, others will be able 
to read those records as they appeared before the change.

Когда вы выполняете оператор SELECT для базы данных для запроса некоторых записей, на выбранные строки не накладываются 
блокировки . В целом, это замечательная функция, потому что количество записей, заблокированных в любой момент времени, 
(по умолчанию) сведено к абсолютному минимуму: блокируются только те записи, которые были изменены, но еще не зафиксированы. 
Даже в этом случае другие пользователи смогут прочитать эти записи в том виде, в каком они были до изменения.

There are times, however, when you will want to lock a set of records even before you change themin your program. 
Oracle offers the FOR UPDATE clause of the SELECT statement to perform this locking.

Однако бывают случаи, когда вам захочется заблокировать набор записей еще до того, как вы измените их в своей программе. 
Oracle предлагает предложение FOR UPDATE инструкции SELECT для выполнения этой блокировки.

When we issue a SELECT FOR UPDATE statement, the server automatically obtains exclusive row-level locks on all the rows 
identified by the SELECT statement, holding the records "for our changes only" as we move through the rows retrieved by the cursor. 
No one else will be able to change any of these records until we perform a ROLLBACK or a COMMIT.
The COMMIT statement makes permanent any changes made to the database during the currentransaction. A commit also makes the 
changes visible to other users. The ROLLBACK statement is the inverse of the COMMIT statement. It undoes some or all database 
changes made during the current transaction.

Когда мы выдаем инструкцию SELECT FOR UPDATE, сервер автоматически получает эксклюзивные блокировки на уровне строк для всех 
строк, определенных инструкцией SELECT, удерживая записи "только для наших изменений", когда мы перемещаемся по строкам , 
извлеченным курсором. Никто другой не сможет изменить ни одну из этих записей, пока мы не выполним ОТКАТ или совершить. 
Инструкция COMMIT делает постоянными любые изменения, внесенные в базу данных во время currenttransaction. Фиксация также 
делает изменения видимыми для других пользователей. Оператор ROLLBACK является обратным оператору COMMIT. Это отменяет 
некоторые или все изменения базы данных, внесенные во время текущей транзакции.

We can use the FOR UPDATE option to declare an update cursor. We can use the update cursor to modify (update or delete) 
the current row.

Мы можем использовать опцию ДЛЯ ОБНОВЛЕНИЯ, чтобы объявить курсор обновления. Мы можем использовать курсор обновления, 
чтобы изменить (обновить или удалить) текущую строку.

In an update cursor, we can update or delete rows in the active set. After we create an update cursor, we can update or delete 
the currently selected row by using an UPDATE or DELETE statement with the WHERE CURRENT OF clause. The words CURRENT OF refer 
to the row that was most recently fetched; they take the place of the usual test expressions in the WHERE clause.

В курсоре обновления мы можем обновлять или удалять строки в активном наборе. После того, как мы создадим курсор обновления, 
мы можем обновить или удалить выбранную в данный момент строку с помощью инструкции UPDATE или DELETE с предложением 
WHERE CURRENT OF. Слова CURRENT OF относятся к строке, которая была извлечена совсем недавно; они заменяют обычные тестовые 
выражения в предложении WHERE.
*/

DECLARE
    v_dep_no    INT :=4;
    
    CURSOR get_employees(department_number INT)
    IS
        SELECT  * 
        FROM    employees
        WHERE   depid = department_number
            FOR UPDATE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------- Department -> ' || v_dep_no);
    
    FOR i IN get_employees(v_dep_no)
    LOOP
        UPDATE  employees
        SET     salary = salary * 0.8
        WHERE   CURRENT OF get_employees;
        
        DBMS_OUTPUT.PUT_LINE( i.name || ', ' || i.surname || ', ' || i.salary );
    END LOOP;
END;

-- The most important advantage to using WHERE CURRENT OF where we need to change the row fetched last is that we do not have 
-- to code the criteria used to uniquely identify a row in a table.
-- Наиболее важным преимуществом использования WHERE CURRENT ВМЕСТО where нам нужно изменить строку, выбранную последней, 
-- является то, что нам не нужно кодировать критерии, используемые для однозначной идентификации строки в таблице.
/*
    The FOR UPDATE keywords notify the database server that updating is possible and cause it to use more stringent locking 
than with a select cursor. We declare an update cursor to let the database server know that the program might update 
(or delete) any row that it fetches as part of the SELECT statement. The update cursor employs promotable locks for rows 
that the program fetches. Other programs can read the locked row, but no other program can place a promotable lock 
(also called a write lock). Before the program modifies the row, the row lock is promoted to an exclusive lock.
    Ключевые слова FOR UPDATE уведомляют сервер базы данных о том, что обновление возможно, и заставляют его использовать 
более строгую блокировку, чем при использовании курсора выбора. Мы объявляем update курсор, чтобы сообщить серверу базы 
данных, что программа может обновить (или удалить) любую строку, которую она извлекает как часть инструкции SELECT. 
Update курсор использует продвигаемые блокировки для строк, которые извлекает программа. Другие программы могут считывать 
заблокированную строку, но никакая другая программа не может установить продвигаемую блокировку (также называемую блокировкой 
записи). Перед тем, как программа изменит строку, блокировка строки будет повышена до эксклюзивной блокировки.
*/


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Lesson 3: Procedures and functions
--       POSITIONAL, NAMED and MIXED NOTATION
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/*    There are two types of subroutines: FUNCTIONS and PROCEDURES. You use these to build database tier libraries to encapsulate 
application functionality, which is then co-located on the database tier for efficiency.
    Существует два типа подпрограмм: ФУНКЦИИ и ПРОЦЕДУРЫ. Вы используете их для создания библиотек уровня базы данных для 
инкапсуляции функциональности приложения, которая затем совместно размещается на уровне базы данных для повышения эффективности.

    They are named PL/SQL blocks. You can deploy them as standalone subroutines or as components in packages. Packages and 
object types can contain both functions and procedures. Anonymous blocks can also have local functions and procedures defined 
in their declaration blocks. You can also nest furctions and procedures inside other functions and procedures.
    Они называются блоками PL/SQL. Вы можете развернуть их как отдельные подпрограммы или как компоненты в пакетах. Пакеты и 
типы объектов могут содержать как функции, так и процедуры. Анонимные блоки также могут иметь локальные функции и процедуры, 
определенные в их блоках объявлений. Вы также можете вложить функции и процедуры в другие функции и процедуры.

    You publish functions and procedures as standalone units or within packages and object types. This means that they are 
defined in the package specification or object type, not the package body or object type body. They are local subroutines when 
you define functions or procedures inside package bodies or object type bodies. Local subroutines are not published subroutines. 
Likewise, subroutines defined in the declaration block of anonymous block programs are local subroutines.
    Вы публикуете функции и процедуры как отдельные модули или внутри пакетов и типов объектов. Это означает, что они определены 
в спецификации пакета или типе объекта, а не в теле пакета или теле типа объекта. Они являются локальными подпрограммами, когда 
вы определяете функции или процедуры внутри тел пакетов или тел типов объектов. Локальные подпрограммы не являются 
опубликованными подпрограммами. Аналогично, подпрограммы, определенные в блоке объявления анонимных блочных программ, 
являются локальными подпрограммами.

    Functions and procedures are named PL/SQL blocks. You can also call them subroutines or subprograms. They have headers 
in place of the DECLARE statement. The header defines the function or procedure name, a list of formal parameters, and a return
data type for functions. Formal parameters define variables that you can send to subroutines when you call them. 
You use both formal parameters and local variables inside functions and procedures.
    Функции и процедуры называются блоками PL/SQL. Вы также можете называть их подпрограммами или подпрограммами. У них есть 
заголовки вместо инструкции DECLARE. Заголовок определяет имя функции или процедуры, список формальных параметров и возвращаемый 
тип данных для функций. Формальные параметры определяют переменные, которые вы можете отправлять подпрограммам при их вызове. 
Вы используете как формальные параметры, так и локальные переменные внутри функций и процедур.

    While functions return a datatype, procedures do not. Functions return output as values represented as SQL or PL/SQL 
datatypes Procedures can return values through their formal parameter list variables when they are passed by reference.
    В то время как функции возвращают тип данных, процедуры этого не делают. 
	Функции возвращают выходные данные в виде значений, представленных в виде SQL или процедуры типов данных PL/SQL могут 
	возвращать значения через свои формальные переменные списка параметров, когда они передаются по ссылке.

    There are four types of generic subroutines in programming languages. The four types are defined by two behaviors, whether 
they return a formal value or not and whether their parameter lists are passed by value
(subroutines receive copies of values) or reference (subroutines receive references to variables).
    В языках программирования существует четыре типа универсальных подпрограмм. Четыре типа определяются двумя поведениями, 
независимо от того, возвращают ли они формальное значение или нет, и передаются ли их списки параметров по значению
(подпрограммы получают копии значений) или по ссылке (подпрограммы получают ссылки на переменные).

    You set formal parameters when you define subroutines. You call subroutines with actual parameters. Formal parameters define 
the list of possible variables, and their positions and datatypes. Formal
parameters do not assign values other than a default value, which makes a parameter optional. Actual
parameters are the values you provide to subroutines when calling
them. You can call subroutines without an actual parameter when the formal parameter has a default value.
    Вы устанавливаете формальные параметры при определении подпрограмм. Вы вызываете подпрограммы с фактическими параметрами. 
Формальные параметры определяют список возможных переменных, а также их позиции и типы данных. 
Формальным параметрам не присваиваются значения, отличные от значения по умолчанию, что делает параметр необязательным. 
Фактические параметры - это значения, которые вы предоставляете подпрограммам при их вызове. 
Вы можете вызывать подпрограммы без фактического параметра, если формальный параметр имеет значение по умолчанию.

    You can use functions as right operands in assignments because their result is a value of a datatype defined in the database 
catalog. Both pass-by-value and pass-by-reference functions fill this role equally
inside PL/SQL blocks. You can use pass-by-reference functions in SQL statements only when you manage
the actual parameters before and after the function call. You can also use the CALL statement with the
INTO clause to return SQL data types from functions.
    Вы можете использовать функции в качестве правильных операндов при присваивании, поскольку их результатом является значение 
типа данных, определенного в каталоге базы данных. Как функции передачи по значению, так и функции передачи по ссылке одинаково выполняют эту роль
внутри блоков PL/SQL. Вы можете использовать функции передачи по ссылке в операторах SQL только в том случае, если вы управляете
фактическими параметрами до и после вызова функции. Вы также можете использовать оператор CALL с
предложением INTO для возврата типов данных SQL из функций.

    PL/SQL qualifies functions and procedures as pass-by-value or pass-by-reference subroutines by the mode of their formal 
parameter lists. PL/SQL supports three modes: read-only, write-only, and read-write. The IN
mode is the default and designates a formal parameter as read-only. OUT mode designates a write-only
parameter, and IN OUT mode designates a read-write parameter mode.

    PL/SQL квалифицирует функции и процедуры как подпрограммы передачи по значению или передачи по ссылке с помощью режима 
из их формальных списков параметров. 
PL/SQL поддерживает три режима: 
-- только для чтения, 
-- только для записи,
-- для чтения и для записи.
Режим IN используется по умолчанию и определяет формальный параметр как доступный только для чтения. 
Режим OUT определяет параметр, доступный только для записи, а 
режим IN OUT определяет режим параметров для чтения и записи.

    The IN mode is the default mode. It means a formal parameter is read-only. When you set a formal parameter as read-only, 
you can not alter it during the execution of the subroutine. You can assign a
default value to a parameter, making the parameter optional. You use the IN mode for all formal
parameters when you want to define a pass-by-value subroutine. The IN parameter allows you to pass
values in to the module, but will not pass anything out of the module and back to the calling PL/SQL
block.
    Режим IN - это режим по умолчанию. Это означает, что формальный параметр доступен только для чтения. 
Когда вы устанавливаете формальный параметр как доступный только для чтения, вы не можете изменять его во время выполнения подпрограммы.
Вы можете присвоить параметру значение по умолчанию, сделав его необязательным. Вы используете режим IN для всех формальных
параметров, когда хотите определить подпрограмму передачи по значению. Параметр IN позволяет вам передавать
значения в модуль, но не будет передавать ничего из модуля и обратно в вызывающий блок PL/SQL

    The OUT mode means a formal parameter is write-only. When you set a formal parameter as write-only, there is no initial 
physical size allocated to the variable. You allocate the physical sizeand value inside
your subroutine. You can't assign a default value, which would make an OUT mode formal parameter
optional. You use an OUT mode with one or more formal parameters when you want a write-only pass-
by-reference subroutine. Use the OUT parameter to pass a value back from the program to the calling
PL/SQL block.
    Режим OUT означает, что формальный параметр доступен только для записи. Когда вы устанавливаете формальный параметр как 
доступный только для записи, для переменной не выделяется начальный физический размер. Вы выделяете физический размер и значение внутри
своей подпрограммы. Вы не можете присвоить значение по умолчанию, которое сделало бы формальный параметр OUT mode
необязательным. Вы используете режим OUT с одним или несколькими формальными параметрами, когда вам нужна подпрограмма передачи
по ссылке только для записи. Используйте параметр OUT для передачи значения обратно из программы вызывающему
Блок PL/SQL.

    The IN OUT mode means a formal parameter is read-write. When you set a formal parameter as read-write, the actual parameter 
provides the physical size of the actual parameter. While you can change the contents of the variable inside the subroutine, 
you can't change or exceed the actual parameters
allocated size. You can't assign a default value making an IN OUT mode parameter optional. You use an
IN OUT mode with one or more formal parameters when you want a read-write pass-by-reference
subroutine. With an IN OUT parameter, you can pass values into the program and return a value back to
the calling program (either the original, unchanged value or a new value set within the program).
    Режим IN OUT означает, что формальным параметром является чтение-запись. Когда вы устанавливаете формальный параметр 
как чтение-запись, фактический параметр предоставляет физический размер фактического параметра. В то время как вы можете изменять
содержимое переменной внутри подпрограммы, вы не можете изменять или превышать фактический размер выделенных параметров.
Вы не можете присвоить значение по умолчанию, сделав параметр IN OUT mode необязательным. Вы используете В режиме OUT с одним
или несколькими формальными параметрами, когда вам нужна подпрограмма передачи чтения-записи по ссылке. С помощью параметра 
IN OUT вы можете передавать значения в программу и возвращать значение обратно в вызывающая программа (либо исходное, 
неизмененное значение, либо новое значение, установленное в программе).
*/

CREATE OR REPLACE PROCEDURE print_strings (str1 IN VARCHAR, str2 IN VARCHAR)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(str1 || ' ' || str2);
END;  --  Procedure PRINT_STRINGS compiled

-- We can omit "IN" keyword - IN MODE IS DEFAULT.
CREATE OR REPLACE PROCEDURE print_strings (str1 VARCHAR, str2 VARCHAR)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(str1 || ' ' || str2);
END;  --  Procedure PRINT_STRINGS compiled

-- We are able to use POSITIONAL, NAMED and MIXED NOTATION when calling subroutines in PL/SQL program units.
-- Мы можем использовать ПОЗИЦИОННУЮ, ИМЕНОВАННУЮ и СМЕШАННУЮ НОТАЦИЮ при вызове подпрограмм в программных единицах PL/SQL.

-- POSITIONAL NOTATION means that you provide a value for each variable in the formal parameter list. 
-- The values must be in sequential order and must also match the datatype.
-- ПОЗИЦИОННАЯ НОТАЦИЯ означает, что вы указываете значение для каждой переменной в списке формальных параметров. 
-- Значения должны быть в последовательном порядке, а также должны соответствовать типу данных.
BEGIN
    print_strings ('first_str_1', 'second_str_2');
END;

-- NAMED NOTATION means that you pass actual parameters by using their formal parameter name, the association operator (=>), 
-- and the value. Named notation lets you only pass values to required parameters, which means you accept the default 
-- values for any optional parameters.
-- Именованная нотация означает, что вы передаете фактические параметры, используя их формальное имя параметра, оператор 
-- ассоциации (=>) и значение. Именованная нотация позволяет передавать значения только требуемым параметрам, что означает, 
-- что вы принимаете значения по умолчанию для любых необязательных параметров.
BEGIN
    print_strings (str2 => 'second_str_2', str1 => 'first_str_1');
END;

-- MIXED NOTATION 
BEGIN
    print_strings ( 'first_str_1', str2 => 'second_str_2');
END;

--
CREATE OR REPLACE PROCEDURE print_employees (dep_no NUMBER)
IS
    v_count INTEGER;
BEGIN
    SELECT  COUNT(*)
    INTO    v_count
    FROM    employees
    WHERE   DEPID = dep_no;
    
    DBMS_OUTPUT.PUT_LINE('There are -> ' || v_count || ' employees in department -> ' || dep_no);
END;

BEGIN
    print_employees (1);
END;  -- There are -> 7 employees in department -> 1

CREATE OR REPLACE PROCEDURE print_department (emp_surname employees.surname%TYPE )
IS
    v_dep VARCHAR2(50);
BEGIN
    SELECT  name
    INTO    v_dep
    FROM    departments
    WHERE   DEPID = ( SELECT    depid
                      FROM      employees
                      WHERE     surname = emp_surname);
    DBMS_OUTPUT.PUT_LINE( emp_surname || ' work in department -> ' || v_dep);
END;

BEGIN
    print_department ('Jackson');
END;

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Функция 
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/*
Функция  — это подпрограмма на языке ORACLE PL SQL, которая вычисляет значения и возвращает результат вычисления.
У функции есть уникальное в рамках схемы БД имя и набор параметров.
Функцию можно вызывать из другой процедуры или функции, а также из анонимного PL SQL блока.
Замечательным свойством функции является то, что функцию можно использовать в SQL запросе,
передавая функции PL SQL параметры из SQL запроса.
*/
-- Синтаксис

CREATE OR REPLACE FUNCTION -- имя_функции
-- [ (параметр [, параметр, …]) ] 
RETURN -- возвращаемый тип 
IS
-- [локальные объявления]
BEGIN
-- исполняемые предложения
RETURN -- возвращаемое значение;
[EXCEPTION
-- обработчики исключений]
END -- [имя_функции];


-- Удаление процедуры из БД осуществляется командой 
DROP FUNCTION "имя процедуры".

-- Параметры, передаваемые в функцию, могут быть in или/и out(по умолчанию in)
-- Параметры in можно использовать в функции, но им нельзя присваивать значение.
-- Параметры Out можно использовать в функции, им присваивается значение, которое передается во внешний программой блок.

-- 1
CREATE OR REPLACE FUNCTION x_3(x NUMBER) 
    RETURN NUMBER
IS
    c NUMBER;
BEGIN
   c := x*x*x;
   RETURN c;
EXCEPTION
   WHEN OTHERS THEN RAISE;
END x_3;

---------------------------------------------------------
-- Примеры вызова функции
---------------------------------------------------------

--      Анонимный блок
BEGIN
     DBMS_OUTPUT.PUT_LINE( add_number(2, 3) );
END;

--      Процедура
create or replace procedure test_proc(par1 number:=10, par2 out number, par3 in out number)
is
  t varchar2(50):= 'test1';
  r number;
begin
  t:= 'test';
  r := 11;
  par2 := par1 * r;
  -- ВЫЗОВ X_3
  par3 := x_3(par2 + par1);
exception 
  when others then raise;
end;

--      SQL
select object_type, count(1) as cnt, x_3(count(1)) as x3  from all_objects where rownum<300 group by object_type;

--      SQL DUAL
select  x_3(3) as x3  from dual;

-- 2
CREATE OR REPLACE FUNCTION add_number (num1 NUMBER, num2 NUMBER) 
    RETURN NUMBER
IS
BEGIN
    RETURN num1 + num2;
END add_number;

-- Any formal parameter may have a default initial value. 
-- Любой формальный параметр может иметь начальное значение по умолчанию.
CREATE OR REPLACE FUNCTION add_number (num1 NUMBER := 4, num2 NUMBER := 5) 
    RETURN NUMBER
IS
BEGIN
    RETURN num1 + num2;
END add_number;

-- If the function has declared default values we can omit parameters and parentheses when we call the function.
-- Если функция имеет объявленные значения по умолчанию, мы можем опустить параметры и круглые скобки при вызове функции.
DECLARE
    result  NUMBER;
BEGIN
    --result := add_number; -- Если функция имеет объявленные значения по умолчанию, мы можем опустить параметры и круглые скобки при вызове функции.
    result := add_number (5); -- можно опустить только один параметр (в данном случае num1 = 5, num2 = 5 по умолчанию)
    DBMS_OUTPUT.PUT_LINE(result);
END;

-- We use pass-by-reference functions when we want to perform an operation, return a value from the function, and alter one 
-- or more actual parameters.
-- Мы используем функции передачи по ссылке, когда хотим выполнить операцию, вернуть значение из функции и изменить один 
-- или несколько фактических параметров.

CREATE OR REPLACE FUNCTION add_numbers_out (
    num1 IN OUT NUMBER, 
    num2 IN OUT NUMBER
) 
    RETURN NUMBER
IS
    result  NUMBER;
BEGIN
    result := num1 + num2;
    num1 :=0;
    num2 :=0;
    RETURN result;
END add_numbers_out;

DECLARE
    param1  NUMBER := 1;
    param2  NUMBER := 2;
    result1 NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Param1 -> ' || param1);
    DBMS_OUTPUT.PUT_LINE('Param2 -> ' || param2);
    result1 := add_numbers_out (param1, param2);
    DBMS_OUTPUT.PUT_LINE('result1 -> ' || result1);
    DBMS_OUTPUT.PUT_LINE('Param1 -> ' || param1);
    DBMS_OUTPUT.PUT_LINE('Param2 -> ' || param2);
END;

-- Функция должна иметь по крайней мере один оператор RETURN в своем разделе инструкций execution. Он может иметь более одного 
-- ВОЗВРАТА, но при каждом вызове функции выполняется только один из этих операторов. Оператор RETURN, выполняемый функцией, 
-- определяет значение, возвращаемое этой функцией. Когда оператор RETURN обрабатывается, функция немедленно завершается и 
-- возвращает управление вызывающему блоку PL/SQL.
CREATE OR REPLACE FUNCTION max_number (num1 NUMBER, num2 NUMBER) 
    RETURN NUMBER
IS
BEGIN
    IF num1 > num2
    THEN
        RETURN num1;
    ELSE
        RETURN num2;
    END IF;
END max_number;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Param1 -> ' || max_number(3,5));
END;


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

-- Lesson 4: EXCEPTION HANDLING  (ОБРАБОТКА ИСКЛЮЧЕНИЙ)

--      NAMED SYSTEM EXCEPTION EXAMPLES
--      NAMED PROGRAMMER-DEFINED EXCEPTIONS
--      UNNAMED SYSTEM EXCEPTIONS
--      UNNAMED PROGRAMMER-DEFINED EXCEPTIONS
--      SCOPE OF AN EXCEPTION AND PROPAGATION (ОБЛАСТЬ ДЕЙСТВИЯ ИСКЛЮЧЕНИЯ И РАСПРОСТРАНЕНИЕ)
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/*
В Oracle сущетвуют исключительные ситуации, которые возникают при определнных обычно некорректных дествиях в программе
Исключение Oracle Error SQLCODE Value

CURSOR_ALREADY_OPEN ORA-06511 -6511
DUP_VAL_ON_INDEX ORA-00001 -1
INVALID_CURSOR ORA-01001 -1001
INVALID_NUMBER ORA-01722 -1722
LOGIN_DENIED ORA-01017 -1017
NO_DATA-FOUND ORA-01403 +100
NOT_LOGGED_ON ORA-01012 -1012
PROGRAM_ERROR ORA-06501 -6501
ROWTYPE_MISMATCH ORA-06504 -6504
STORAGE_ERROR ORA-06500 -6500
TIMEOUT_ON_RESOURCE ORA-00051 -51
TOO_MANY_ROWS ORA-01422 -1422
VALUE_ERROR ORA-06502 -6502
ZERO_DIVIDE ORA-01476 -1476
Чтобы ознакомится с более подробным списком исключений, смотрите Server Messages.

Описание исключений :
CURSOR_ALREADY_OPEN вызывается, если вы раннее уже открыли данный курсор. Вы должны закрыть курсор, перед тем как снова открыть его.
        Курсор для цикла FOR открывается автоматически , поэтому вы не можете выполнить куpсорный цикл по уже открытому курсору. 
DUP_VAL_ON_INDEX вызывается при попытке сохранить несколько одинаковых значений в колонку таблицы, когда на данную колонку 
                 установлен уникальный индекс.
INVALID_CURSOR вызывается ,если вы пытаетесь выполнить некорректную операцию с курсором. Например, INVALID_CURSOR вызывается, 
                если вы пытаетесь закрыть еще не открытый курсор.
INVALID_NUMBER вызывается в SQL выражениях, когда не получается корректно конвертировать строку в число , потому что строка 
                не преобразуется корректно в число. Например, следующее выражение INSERT вызывает INVALID_NUMBER когда Oracle 
                пытается преобразовать строку 'HALL' в число:


INSERT INTO emp (empno, ename, deptno) VALUES ('HALL', 7888, 20);
 Следует помнить, что процедурных выражениях вызывается исключение VALUE_ERROR .
LOGIN_DENIED вызывается если вы пытаетесь соединится с Oracle с неправильным именем пользователя или паролем.
NO_DATA_FOUND вызывается если в выражение SELECT INTO не возвращает ни одной строки или если вы обращаетесь к неустановленной строке в PL/SQL таблице. Выражение FETCH в случае когда не выбрано строк, выполняется успешно, не вызывая исключения.

Групповые выражения SQL ,такие как AVG и SUM всегда возвращают значение или null. Так, выражение SELECT INTO statement с групповой функцией никогда не вызовет исключение NO_DATA_FOUND.

NOT_LOGGED_ON вызывается если вы в PL/SQL приложении обращаетесь к базе данных без предварительного соединения с Oracle.
PROGRAM_ERROR вызывается если в PL/SQL при внутренниих структурных ошибках.
ROWTYPE_MISMATCH вызывается , когда курсор или выражение PL/SQL вы пытаетесь преобразовать к перемнной несовместимого типа. 
Например, когда вы открыли курсор в хранимой процедуре, если возвращаемый тип имеет несовметимый формат параметров, PL/SQL вызывает ROWTYPE_MISMATCH.
STORAGE_ERROR вызывается если PL/SQL не хватет оперативной памяти или в опративной памяти есть поврежденные блоки.
TIMEOUT_ON_RESOURCE вызвается когда превышен интервал ожидания Oracle необходимого ресурса.
TOO_MANY_ROWS вызывается если в выражение SELECT INTO возвращается более одной строки.
VALUE_ERROR возникает в операциях преобразования, математических операциях, или когда не совпадает размерность типов. Например, когда вы выбираете значение колонки строку, и если длина переменно меньше размерности данной строки, PL/SQL прерывает выполнение программы исключением VALUE_ERROR.
В процедурных выражениях, VALUE_ERROR вызывается если преобразование строки в число ошибочно. Например, следующее выражение вызывает VALUE_ERROR когда PL/SQL пытается преобразовать строку 'HALL' в число:
в выражениях SQL вызывается исключение INVALID_NUMBER 
ZERO_DIVIDE вызывается при попытке деления на ноль.

как это использовать исключения в прогрммном коде

Функция SQLERRM возвращает сообщение об ошибке связанное с последним возникшим исключением (ошибкой).
Функция SQLERRM — не имеет параметров.

Функция SQLCODE возвращает код ошибки связанный с последним возникшим исключением (ошибкой)

*/

-- Обычно обработка исключений EXCEPTION выглядит следующим образом:
EXCEPTION
   WHEN наименование_ошибки_1 THEN
      [statements]

   WHEN наименование_ошибки_2 THEN
      [statements]

   WHEN наименование_ошибки_N THEN
      [statements]

   WHEN OTHERS THEN
      [statements]

END [наименование_процедуры];

--------------------------------------------
-- примеры
--------------------------------------------
declare 
  -- Local variables here
  i integer;
  t varchar2(10);
begin
  -- Test statements here
  i := 100; t := 'qwe10';
 
  i:=i/to_number(t);
exception 
  WHEN ZERO_DIVIDE THEN dbms_output.put_line('деление на 0 '||SQLCODE ||' '||SQLERRM );
  WHEN VALUE_ERROR THEN dbms_output.put_line('ошибка преобразования  '||SQLCODE||' '||SQLERRM  );
  WHEN OTHERS  THEN  dbms_output.put_line('еще какая то ошибка '||SQLCODE ||' '||SQLERRM );
end;

set serveroutput on

-- Created on 04.05.2018 by M.CHALYSHEV 
declare 
  -- Local variables here
  i integer;
  t varchar2(10);
begin
  -- Test statements here
  i := 100; t := '0';
  i:=i/to_number(t);
exception 
  when ZERO_DIVIDE then dbms_output.put_line('деление на 0 '||SQLCODE ||' '||SQLERRM );
  when VALUE_ERROR then dbms_output.put_line('ошибка преобразования  '||SQLCODE||' '||SQLERRM  );
  when others  then  dbms_output.put_line('еще какая то ошибка '||SQLCODE ||' '||SQLERRM );
end;

--------------------------------------------------------------------------------------------------------------------------------
    Run-time errors arise from design faults, coding mistakes, hardware failures, and many other sources. Although you cannot 
anticipate all possible errors, you can plan to handle certain kinds of errors meaningful to your PL/SQL program.
    Ошибки во время выполнения возникают из-за ошибок проектирования, ошибок кодирования, аппаратных сбоев и многих других источников. 
Хотя вы не можете предвидеть все возможные ошибки, вы можете спланировать обработку определенных типов ошибок, значимых для вашей программы PL/SQL.

    In the PL/SQL language, errors of any kind are treated as exceptions - situations that should not occur.
An exception can be one of the following:
- an error generated by the system (such as "out of memory" or "duplicate value in index")
- an error caused by a user action
- a warning issued by the application to the user.
    В языке PL/SQL ошибки любого рода рассматриваются как исключения - ситуации, которые не должны возникать.
Исключением может быть одно из следующих:
- ошибка, сгенерированная системой (например, "не хватает памяти" или "повторяющееся значение в индексе")
- ошибка, вызванная действием пользователя
- предупреждение, выданное приложением пользователю

    PL/SQL traps and responds to errors using an architecture of exception handlers. The exception-handler mechanism allows you 
to cleanly separate your error processing code from your executable statements. It also provides an event-driven model, as 
opposed to a linear code model, for processing errors. In other words, no matter how a particular exception is raised, it is 
handled by the same exception handler in the exception section.
    PL/SQL улавливает ошибки и реагирует на них, используя архитектуру обработчиков исключений. Механизм обработки исключений 
позволяет вам четко отделять ваш код обработки ошибок от ваших исполняемых инструкций. Он также предоставляет управляемую 
событиями модель, в отличие от линейной модели кода, для обработки ошибок. Другими словами, независимо от того, как создается 
конкретное исключение, оно обрабатывается одним и тем же обработчиком исключений в разделе исключений.

    When an error occurs in PL/SQL, whether a system error or an application error, an exception is raised. The processing in 
the current PL/SQL blocks execution section halts and control is transferred to the separate exception section of your program, 
if one exists, to handle the exception. You cannot return to that block after you finish handling the exception. Instead, 
control is passed to the enclosing block, if any.
    При возникновении ошибки в PL/SQL, будь то системная ошибка или ошибка приложения, возникает исключение. Обработка в разделе 
выполнения текущего блока PL/SQL останавливается, и управление передается в отдельный раздел исключения вашей программы, если 
таковой существует, для обработки исключения. Вы не можете вернуться к этому блоку после завершения обработки исключения. 
Вместо этого управление передается включающему блоку, если таковой имеется.

There are four kinds of exceptions in PL/SQL:

- named system exceptions - exceptions that have been given names by PL/SQL and raised as a result of an error in PL/SQL or 
RDBMS processing.
- named programmer-defined exceptions - exceptions that are raised as a result of errors in your application code. You give 
these exceptions names by declaring them in the declaration section. You then raise the exceptions explicitly in the program.
- unnamed system exceptions - exceptions that are raised as a result of an error in PL/SQL or RDBMS processing but have not 
been given names by PL/SQL. Only the most common errors are so named;
the rest have numbers and can be assigned names with the special PRAGMA EXCEPTION_INIT syntax.
- unnamed programmer-defined exceptions - exceptions that are defined and raised in the server by the programmer. In this case, 
the programmer provides both an error number (between -20000 and - 20999) and an error message, and raises that exception with 
a call to  RAISE_APPLICATION_ERROR. That error, along with its message, is propagated back to the client-side application.

В PL/SQL существует четыре вида исключений:

- именованные системные исключения - исключения, которым PL/SQL присвоил имена и которые возникли в результате ошибки при 
обработке PL/SQL или СУБД.
- именованные исключения, определяемые программистом - исключения, которые возникают в результате ошибок в коде вашего приложения. 
Вы даете этим исключениям имена, объявляя их в разделе объявления. Затем вы вызываете исключения явно в программе.
- безымянные системные исключения - исключения, которые возникают в результате ошибки при обработке PL/SQL или СУБД, но 
которым PL/SQL не присвоил имен. Так называются только наиболее распространенные ошибки.;
остальные имеют номера, и им могут быть присвоены имена с помощью специального синтаксиса PRAGMA EXCEPTION_INIT.
- неназванные исключения, определенные программистом - исключения, которые определяются и вызываются на сервере программистом. 
В этом случае программист предоставляет как номер ошибки (от -20000 до - 20999), так и сообщение об ошибке и вызывает это 
исключение с помощью вызова RAISE_APPLICATION_ERROR. Эта ошибка вместе с ее сообщением передается обратно в клиентское приложение.

    The system exceptions (both named and unnamed) are raised by PL/SQL whenever a program violates a rule in the RDBMS or 
causes a resource limit to be exceeded. Each of these RDBMS errors has a number associated with it. In addition, PL/SQL 
predefines names for some of the most commonly encountered errors.
    Системные исключения (как именованные, так и неназванные) вызываются PL/SQL всякий раз, когда программа нарушает правило 
в СУБД или приводит к превышению лимита ресурсов. Каждая из этих ошибок СУБД имеет связанный с ней номер. Кроме того, PL/SQL 
предопределяет имена для некоторых наиболее часто встречающихся ошибок.

--------------------------------------------------------------------------------------------------------------------------------
--      NAMED SYSTEM EXCEPTION EXAMPLES
--------------------------------------------------------------------------------------------------------------------------------
DECLARE
    v_num       NUMBER;
    v_num_1     NUMBER := 5;
    v_num_2     NUMBER := 0;
    v_rezult    NUMBER;
    v_surname   VARCHAR2(50);
BEGIN
    --v_num := 'A';                   -- Wrong number. Exit program
    --v_rezult := v_num_1 / v_num_2;  -- Zerro div. Exit program.
    SELECT surname INTO v_surname FROM employees WHERE depid = 10;  -- 
EXCEPTION
    WHEN    VALUE_ERROR
    THEN    DEXCEPTION
    WHEN    ZERO_DIVIDE
    THEN    DBMS_OUTPUT.PUT_LINE('ZERO divide. Exit program.' );
    WHEN    NO_DATA_FOUND
    THEN    DBMS_OUTPUT.PUT_LINE('NO DATA found. Exit program.' );
    WHEN    OTHERS  -- The WHEN OTHERS clause is used to trap all remaining exceptions (перехвата всех оставшихся)
    THEN    DBMS_OUTPUT.PUT_LINE('An OTHER error. Exit program.' );
END;


--------------------------------------------------------------------------------------------------------------------------------
--      NAMED PROGRAMMER-DEFINED EXCEPTIONS
--------------------------------------------------------------------------------------------------------------------------------
    The exceptions that PL/SQL has declared in the STANDARD package cover internal
or system-generated errors. Many of the problems a user will encounter (or cause) in
an application, however, are specific to that application. Your program might need to
trap and handle errors such as "negative balance in account" or "call date cannot be
in the past." While different in nature from "division by zero," these errors are still
exceptions to normal processing and should be handled gracefully by your program.
    Исключения, объявленные PL/SQL в СТАНДАРТНОМ пакете, охватывают внутренние
или системные ошибки. Однако многие проблемы, с которыми пользователь столкнется (или вызовет) в
приложении, специфичны для этого приложения. Вашей программе может потребоваться
перехватывать и обрабатывать такие ошибки, как "отрицательный баланс на счете" или "дата вызова не может быть
в прошлом". Несмотря на то, что эти ошибки отличаются по своей природе от "деления на ноль", они по-прежнему
являются исключениями из обычной обработки и должны корректно обрабатываться вашей программой.
    
    Of course, to handle an exception, you must have a name for that exception.
Because PL/SQL cannot name these exceptions for you (they are specific to your
application), you must do so yourself by declaring an exception in the declaration
section of your PL/SQL block.
    Конечно, чтобы обработать исключение, у вас должно быть имя для этого исключения.
Поскольку PL / SQL не может назвать эти исключения для вас (они специфичны для вашего
приложения), вы должны сделать это самостоятельно, объявив исключение в разделе объявления
вашего блока PL / SQL.

DECLARE
    v_num_1     NUMBER := 6;
    v_num_2     NUMBER := 1;
    v_rezult    NUMBER;
    exc_divide_by_one   EXCEPTION;          -- DECLARATION
BEGIN
    IF v_num_2 = 1
    THEN
            RAISE exc_divide_by_one;        -- STOPS normal EXECUTION and TRANSFERS CONTROL to EXCEPTION HANDLER
    ELSE
        v_rezult := v_num_1 / v_num_2; 
        DBMS_OUTPUT.PUT_LINE('Result is -> ' || v_rezult);   
    END IF;
EXCEPTION
    WHEN    exc_divide_by_one                -- EXCEPTION HANDLER
    THEN    DBMS_OUTPUT.PUT_LINE('There is no need to divide by 1. Exit program.' );
    WHEN    OTHERS
    THEN    DBMS_OUTPUT.PUT_LINE('An OTHER error. Exit program.' );
END;


--------------------------------------------------------------------------------------------------------------------------------
--      UNNAMED SYSTEM EXCEPTIONS
--------------------------------------------------------------------------------------------------------------------------------

DECLARE
    v_num_1     NUMBER := 6;
    v_num_2     NUMBER := 1;
    v_rezult    NUMBER;
    exc_divide_by_one   EXCEPTION;                          -- DECLARATION
    PRAGMA EXCEPTION_INIT (exc_divide_by_one, -13467);      -- DECLARATION
BEGIN
    IF v_num_2 = 1
    THEN
            RAISE exc_divide_by_one;                        -- STOPS normal EXECUTION and TRANSFERS CONTROL to EXCEPTION HANDLER
    ELSE
        v_rezult := v_num_1 / v_num_2; 
        DBMS_OUTPUT.PUT_LINE('Result is -> ' || v_rezult);   
    END IF;
EXCEPTION
    WHEN    exc_divide_by_one                               -- EXCEPTION HANDLER
    THEN    DBMS_OUTPUT.PUT_LINE( 'There is no need to divide by 1. Exit program. ' || SQLCODE );
END;


--------------------------------------------------------------------------------------------------------------------------------
--      UNNAMED PROGRAMMER-DEFINED EXCEPTIONS
--------------------------------------------------------------------------------------------------------------------------------
    This kind of exception occurs when you need to raise an application-specific error
from within the server and communicate this error back to the client application process.
To do this, you need a way to identify application-specific errors and return information
about those error back to the client.
    Такого рода исключения возникают, когда вам нужно вызвать ошибку, относящуюся к конкретному приложению, 
с сервера и передать эту ошибку обратно в процесс клиентского приложения.
Чтобы сделать это, вам нужен способ идентифицировать ошибки, относящиеся к конкретному приложению, и возвращать информацию
об этих ошибках обратно клиенту.

    Oracle provides a special procedure to allow communication of an unnamed, yet programmer-defined, server-side exception: RAISE_APPLICATION_ERROR.
    Oracle предоставляет специальную процедуру, позволяющую передавать неназванное, но определенное программистом исключение на 
стороне сервера: RAISE_APPLICATION_ERROR.

PROCEDURE RAISE_APPLICATION_ERROR (error_number_in IN NUMBER, error_msg_in IN VARCHAR2);

DECLARE
    v_num_1     NUMBER := 6;
    v_num_2     NUMBER := 1;
    v_rezult    NUMBER;
BEGIN
    IF v_num_2 = 1
    THEN
            raise_application_error (-20001, 'Division by ZERO');  -- STOPS normal EXECUTION and TRANSFERS CONTROL to EXCEPTION HANDLER
    ELSE
        v_rezult := v_num_1 / v_num_2; 
        DBMS_OUTPUT.PUT_LINE('Result is -> ' || v_rezult);   
    END IF;
END;


--------------------------------------------------------------------------------------------------------------------------------
--      SCOPE OF AN EXCEPTION AND PROPAGATION (ОБЛАСТЬ ДЕЙСТВИЯ ИСКЛЮЧЕНИЯ И РАСПРОСТРАНЕНИЕ)
--------------------------------------------------------------------------------------------------------------------------------
    /* The scope of an exception is that portion of the code which is "covered" by that exception.
An exception covers a block of code if it can be raised in that block.

    Named system exceptions - these exceptions are globally available because they are not
declared in or confined to any particular block of code. You can raise and handle a named
system exception in any block.

    Named programmer-defined exceptions - these exceptions can only be raised and handled in
the execution and exception sections of the block in which they are declared (and all nested
blocks).

    Unnamed system exceptions - these exceptions can be handled in any PL/SQL exception
section via the WHEN OTHERS section. If they are assigned a name, then the scope of that
name is the same as that of the named programmer-defined exception.

    Unnamed programmer-defined exceptions - this exception is only defined in the call to
RAISE_APPLICATION_ERROR and then is passed back to the calling program.

    Область действия исключения - это та часть кода, которая "охвачена" этим исключением.
Исключение распространяется на блок кода, если оно может быть вызвано в этом блоке.

    Именованные системные исключения - эти исключения доступны во всем мире, поскольку они не
объявлены в каком-либо конкретном блоке кода и не ограничены им. Вы можете вызвать и обработать именованное
системное исключение в любом блоке.

    Именованные исключения, определяемые программистом. Эти исключения могут вызываться и обрабатываться только в
разделах выполнения и исключения блока, в котором они объявлены (и во всех вложенных
блоках).

    Неназванные системные исключения - эти исключения могут быть обработаны в любом разделе исключений PL/SQL
через раздел WHEN OTHERS. Если им присвоено имя, то область действия этого
имени такая же, как и у именованного исключения, определенного программистом.

    Неназванные исключения, определенные программистом. Это исключение определяется только при вызове
RAISE_APPLICATION_ERROR, а затем передается обратно вызывающей программе. */

BEGIN 
    DECLARE
        v_surname   VARCHAR2(50);
    BEGIN
        SELECT surname INTO v_surname FROM employees WHERE depid = 10;  -- 
    EXCEPTION
        WHEN    NO_DATA_FOUND               
        THEN    
            DBMS_OUTPUT.PUT_LINE('NO DATA found. Error handling in nested block. Exit from nested block.' );  -- Error handling in nested block. 
    END;
    
    DBMS_OUTPUT.PUT_LINE('Execution of outer block' );
END;

/*    When an exception is raised, PL/SQL looks for an exception handler in the current block (anonymous block,
procedure, or function) for this exception. If it does not find a match, then PL/SQL propagates the exception to
the enclosing block of that current block. PL/SQL then attempts to handle the exception by raising that
exception once more in the enclosing block. It continues to do this in each successive enclosing block until there
are no more blocks in which to raise the exception.
    Когда возникает исключение, PL/SQL ищет обработчик исключения в текущем блоке (анонимный блок,
процедура или функция) для этого исключения. Если он не находит совпадения, то PL/SQL распространяет исключение на
заключающий блок этого текущего блока. Затем PL/SQL пытается обработать исключение, вызывая это
исключение еще раз во включающем блоке. Он продолжает делать это в каждом последующем включающем блоке до тех пор, пока не останется
больше блоков, в которых можно вызвать исключение.
*/

BEGIN 
    DECLARE
        v_surname   VARCHAR2(50);
    BEGIN
        SELECT surname INTO v_surname FROM employees WHERE depid = 10;  -- 
    DBMS_OUTPUT.PUT_LINE('Execution of outer block 1' );
    END;
        DBMS_OUTPUT.PUT_LINE('Execution of outer block 2' );
EXCEPTION
    WHEN    NO_DATA_FOUND               
    THEN    
        DBMS_OUTPUT.PUT_LINE('NO DATA found. Error handling in nested block. Exit from nested block.' );  -- Error handling in nested block. 
END;

----------------------------------------------------------------

CREATE OR REPLACE FUNCTION count_employees_2 (p_dep_id INT)
    RETURN NUMBER
IS
    v_max_depid INT;
    v_count     INT;
BEGIN
    SELECT  MAX(depid)
    INTO    v_max_depid
    FROM    departments;
    
    IF p_dep_id < v_max_depid  -- If there is no depid equal p_dep_id then raise the error with code -20001
    THEN
        raise_application_error (-20003, 'Wrong department');
    ELSE
        SELECT  COUNT(*)
        INTO    v_count
        FROM    employees
        WHERE   depid = p_dep_id;
        
        RETURN  v_count;
    END IF;
END;

-- Когда вы находитесь внутри обработчика исключений в разделе исключений, вы можете повторно вызвать исключение, 
-- которое "привело вас туда", выдав неквалифицированный оператор RAISE
CREATE OR REPLACE PROCEDURE print_count_emp
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(count_employees_2(10));
EXCEPTION
    WHEN OTHERS
    THEN
        RAISE;
END;
    
DECLARE
    v_count_emp INT;
BEGIN
    v_count_emp := count_employees_2(2);
EXCEPTION
    WHEN OTHERS    
    THEN
        IF SQLCODE = -20001
        THEN 
            DBMS_OUTPUT.PUT_LINE('Wrong department NUMBER');
        ELSE
            DBMS_OUTPUT.PUT_LINE('An ERROR');
        END IF;
END;

/* 
    You can use the WHEN OTHERS clause in the exception section to trap all otherwise unhandled exceptions, including internal 
errors which are not predefined by PL/SQL. Once inside the exception handler, however, you will often want to know which error 
occurred. We can use the SQL CODE and
    Вы можете использовать предложение WHEN OTHERS в разделе exception , чтобы перехватывать все необработанные исключения, 
включая внутренние ошибки, которые не предопределены PL/SQL. Однако, оказавшись внутри обработчика исключений, вы часто захотите 
узнать, какая ошибка произошла. Мы можем использовать SQL-КОД и Функции SQLERRM для получения этой информации.
*/
SQLERRM functions to obtain this information.
DECLARE
    v_dep_name  VARCHAR2(50);
BEGIN
    SELECT  NAME
    INTO    v_dep_name
    FROM    departments
    WHERE   depid = 10;
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.PUT_LINE('ERROR occured');
        DBMS_OUTPUT.PUT_LINE('SQL Code -> ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('SQL_ERRM -> ' || SQLERRM);
END;


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Lesson 5: Packages
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

set serveroutput on;
/* В PL SQL предоставляет возможность гармонично группировать программные единицы – процедуры и функции.
Такая возможность позволяют осуществить специальные конструкции пакеты или модули.
Так же в пакетах PL SQL объявления, процедур функций, переменных отделены от реализации.
Дополнительно пакеты реализуют своеобразную инкапсуляцию PL SQL кода, часть кода публичная отделена от внутренней реализации.
Вызываемые, публичные процедуры функции и переменные описываются в спецификации пакета, а их реализация, 
внутренние программное устройство в теле пакета.
Можно вызывать процедуры и функции пакета, объявленные в спецификации пакета из других пакетов, других процедур, 
функции из SQL, а так же из анонимных PL SQL подпрограмм.
Private - определяется только в теле пакета, но не отображается в спецификации.
На закрытый элемент нельзя ссылаться вне пакета. Однако любой другой элемент
пакета может ссылаться на закрытый элемент и использовать его. Частные элементы в пакете
должны быть определены, прежде чем на них смогут ссылаться другие элементы пакета. Если, другими
словами, общедоступная процедура вызывает закрытую функцию, эта функция должна быть определена над
общедоступной процедурой в теле пакета.
*/

--синтаксис
  PACKAGE имя IS  -- спецификация (видимая часть)
            -- объявления публичных типов и объектов, переменных , констант
            -- спецификации подпрограмм
        END [имя];

        PACKAGE BODY имя IS  -- тело (скрытая часть)
            -- объявления внутренних типов и объектов
            -- тела подпрограмм
        [BEGIN
            -- предложения инициализации]
        END [имя];

-- Пример
CREATE OR REPLACE PACKAGE pck_test 
IS
  gr_test   NUMBER := 10;
  gc_cr     CONSTANT VARCHAR2(30) := 'test'; -- константа менять нельзя
  PROCEDURE pr_test; -- публичная процедура 
  FUNCTION get_gr return number; -- публичная функция
--->
END;

CREATE OR REPLACE PACKAGE BODY pck_test 
IS
    gc_div constant VARCHAR2(30) := '**********************';
    
    PROCEDURE pr_print(v VARCHAR2) -- внутрення процедура
    IS
    BEGIN 
        dbms_output.put_line(v);
    END;    
  
    FUNCTION get_gr RETURN NUMBER -- -- публичная функция , есть в спецификации
    IS
    BEGIN 
        return gr_test;
    END;    

    PROCEDURE pr_test IS -- публичная процедура , есть в спецификации
        a_test      VARCHAR2(100);
    BEGIN
        pr_print('gc_cr =');
        pr_print(to_char(gc_cr));
        pr_print('gr_test=');
        pr_print(to_char(get_gr));    
        pr_print(gc_div);    
    End;
BEGIN 
    pck_test.gr_test := gr_test*10; -- инициализация
END;

-- Вызов 
begin
  pck_test.pr_test;
  dbms_output.put_line( pck_test.get_gr);
end;
-- или в SQL
select pck_test.get_gr from dual


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Lesson 6: Triggers
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

-- A trigger is a named PL/SQL block stored in the Oracle Database and executed automatically when a triggering event takes place. 
-- The event can be any of the following:
--   A data manipulation language (DML) statement executed against a table e.g., INSERT, UPDATE, or DELETE.
--   A data definition language (DDL) statement executes e.g., CREATE or ALTER statement.
--   A system event such as STARTUP or SHUTDOWN of the Oracle Database.
--   A USER event such as LOGIN or Logout.

-- Oracle trigger usages
-- Oracle triggers are useful in many cases such as the following:
--    Enforcing complex business rules that cannot be established using integrity constraint such as UNIQUE, NOT NULL, and CHECK.
--    Preventing invalid transactions.
--    Gathering statistical information on table accesses.
--    Generating value automatically for derived columns.
--    Auditing sensitive data.

CREATE [OR REPLACE] TRIGGER trigger_name
    {BEFORE | AFTER } triggering_event(UPDATE OR DELETE or INSERT) 
     ON table_name
    [FOR EACH ROW] --  If you omit the FOR EACH ROW clause, the CREATE TRIGGER statement will create a STATEMENT-LEVEL trigger.
    [FOLLOWS | PRECEDES another_trigger]
    [ENABLE / DISABLE ]
    [WHEN condition]
        DECLARE
            declaration statements
        BEGIN
            executable statements
        EXCEPTION
        exception_handling statements
END;

-- First, create a new table for recording the UPDATE and DELETE events:
CREATE TABLE audits (
      audit_id         NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
      table_name       VARCHAR2(255),
      transaction_name VARCHAR2(10),
      by_user          VARCHAR2(30),
      transaction_date DATE
);

-- Second, create a new trigger associated with the customers table:
CREATE OR REPLACE TRIGGER customers_audit_trg
    AFTER UPDATE OR DELETE 
    ON customers
    FOR EACH ROW    
DECLARE
   l_transaction VARCHAR2(10);
BEGIN
   -- determine the transaction type
   l_transaction := 
        CASE  
            WHEN UPDATING THEN 'UPDATE'
            WHEN DELETING THEN 'DELETE'
        END;
    -- insert a row into the audit table   
    INSERT INTO audits (table_name, transaction_name, by_user, transaction_date)
    VALUES('CUSTOMERS', l_transaction, USER, SYSDATE);
END;

-- The following statement updates the credit limit of the customer 10 to 2000.
UPDATE
   customers
SET
   credit_limit = 2000
WHERE
   customer_id =10;

-- Now, check the contents of the table audits to see if the trigger was fired:
SELECT * FROM audits;

-- 
DELETE FROM customers
WHERE customer_id = 10;

SELECT * FROM audits;

---------------------------------------------------------------------
--      Oracle Statement-level Triggers
---------------------------------------------------------------------

-- A statement-level trigger is fired whenever a trigger event occurs on a table regardless of how many rows are affected. 
-- In other words, a statement-level trigger executes once for each transaction.
-- It’s typically used to enforce extra security measures on the kind of transaction that may be performed on a table.

-- Suppose, you want to restrict users to update credit of customers from 28th to 31st of every month so that you can close the financial month.

CREATE OR REPLACE TRIGGER customers_credit_trg
    BEFORE UPDATE OF credit_limit  
    ON customers
DECLARE
    l_day_of_month NUMBER;
BEGIN
    -- determine the transaction type
    l_day_of_month := EXTRACT(DAY FROM sysdate);

    IF l_day_of_month BETWEEN 28 AND 31 THEN
        raise_application_error(-20100,'Cannot update customer credit from 28th to 31st');
    END IF;
END;

-- The following statement uses the UPDATE statement to increase the credit limit of all customer 10%:
UPDATE 
    customers 
SET 
    credit_limit = credit_limit * 110;

---------------------------------------------------------------------
--      Oracle Row-level Triggers
---------------------------------------------------------------------   

-- Row-level triggers fires once for each row affected by the triggering event such as INSERT, UPDATE, or DELETE.
-- Row-level triggers are useful for data-related activities such as data auditing and data validation.   

-- row-level triggers allow you to track the BEFORE and AFTER values.
-- :OLD.column_name
-- :NEW.column_name

-- The following example creates a row-level trigger that prevents users from updating credit for a customer 
-- if the new credit increases to more than double:

CREATE OR REPLACE TRIGGER customers_update_credit_trg 
    BEFORE UPDATE OF credit_limit
    ON customers
    FOR EACH ROW
    WHEN (NEW.credit_limit > 0)
BEGIN
    -- check the credit limit
    IF :NEW.credit_limit >= 2 * :OLD.credit_limit THEN
        raise_application_error(-20101,'The new credit ' || :NEW.credit_limit || 
            ' cannot increase to more than double, the current credit ' || :OLD.credit_limit);
    END IF;
END;
-- Testing the trigger
SELECT * FROM customers;
SELECT credit_limit FROM customers WHERE customer_id = 1;  -- 100

UPDATE customers
SET credit_limit = 5000
WHERE customer_id = 1;

---------------------------------------------------
-- Oracle INSTEAD OF Triggers
---------------------------------------------------

-- When you issue a DML statement such as INSERT, UPDATE, or DELETE to a non-updatable view, Oracle will issue an error.
-- In Oracle, you can create an INSTEAD OF trigger for a view only. You cannot create an INSTEAD OF trigger for a table.

-- First, create a view based on the customers and contacts tables:
CREATE VIEW vw_customers AS
    SELECT          name, address, website, credit_limit, first_name, last_name, email, phone
    FROM            customers
    INNER           JOIN contacts USING (customer_id); -- View VW_CUSTOMERS created.
-- Next, attempt to insert a new customer and contact into the underlying tables via the view vw_customers:
INSERT INTO 
    vw_customers(   name, address, website, credit_limit, first_name, last_name, email, phone )
    VALUES( 'Lam Research', 'Fremont, California, USA', 'https://www.lamresearch.com/',  2000,
            'John', 'Smith', 'john.smith@lamresearch.com', '+1-510-572-0200' );
-- Oracle issued the following error: SQL Error: ORA-01779: cannot modify a column which maps to a non key-preserved table

-- Then, create an INSTEAD OF trigger on the view vw_customers:
CREATE OR REPLACE TRIGGER new_customer_trg
    INSTEAD OF INSERT ON vw_customers
    FOR EACH ROW
DECLARE
    l_customer_id NUMBER;
BEGIN
    -- insert a new customer first
    INSERT INTO customers(name, address, website, credit_limit)
    VALUES(:NEW.NAME, :NEW.address, :NEW.website, :NEW.credit_limit)
    RETURNING customer_id INTO l_customer_id;
    -- insert the contact
    INSERT INTO contacts(first_name, last_name, email, phone, customer_id)
    VALUES(:NEW.first_name, :NEW.last_name, :NEW.email, :NEW.phone, l_customer_id);
END; -- Trigger NEW_CUSTOMER_TRG compiled
-- In this trigger, we inserted a new customer, get customer id, and use that id to insert a new contact.
-- After that, execute the following statement again:
INSERT INTO 
    vw_customers(   name, address, website, credit_limit, first_name, last_name, email, phone )
    VALUES( 'Lam Research', 'Fremont, California, USA', 'https://www.lamresearch.com/',  2000,
            'John', 'Smith', 'john.smith@lamresearch.com', '+1-510-572-0200' ); -- 1 row inserted.
-- Finally, verify data from the customers table:
SELECT * FROM customers 
ORDER BY customer_id DESC
FETCH FIRST ROWS ONLY;

