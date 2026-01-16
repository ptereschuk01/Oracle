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

-- ****************************************************************************************
-- Lesson 1: PL/SQL Introduction / Lektion 1: Einführung in PL/SQL
-- ****************************************************************************************

SET SERVEROUTPUT ON; -- Ausgabe aktivieren / Enable output

-- ===============================================
-- Create tables / Tabellen erstellen
-- ===============================================
CREATE TABLE departments
(
    depid INT PRIMARY KEY,
    name VARCHAR2(50)
); -- Tabelle DEPARTMENTS erstellt / Table DEPARTMENTS created

CREATE TABLE employees
(
    employeeid  INT PRIMARY KEY,
    depid       INT,
    surname     VARCHAR2(40),
    name        VARCHAR2(30),
    bossid      INT,
    salary      NUMBER,
    CONSTRAINT fk FOREIGN KEY(depid) REFERENCES departments(depid)
); -- Tabelle EMPLOYEES erstellt / Table EMPLOYEES created

-- ===============================================
-- Drop tables if needed / Tabellen löschen, falls notwendig
-- ===============================================
-- DROP TABLE employees;
-- DROP TABLE departments;

-- ===============================================
-- Insert sample data / Beispieldaten einfügen
-- ===============================================
INSERT INTO departments (depid, name) VALUES (1, 'Management'); -- 1 Zeile eingefügt / 1 row inserted
INSERT INTO departments (depid, name) VALUES (2, 'Administration'); 
INSERT INTO departments (depid, name) VALUES (3, 'Technological');
INSERT INTO departments (depid, name) VALUES (4, 'Business');
INSERT INTO departments (depid, name) VALUES (5, 'Support');

INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (1, 1, 'Smith', 'Jacob', NULL, 23000);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (2, 2, 'Johnson', 'Ethan', 1, 5300);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (3, 3, 'Williams', 'Isabella', 1, 4500);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (4, 2, 'Jones', 'Alexander', 2, 6900);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (5, 3, 'Brown', 'Joshua', 3, 4300);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (6, 4, 'Davis', 'Jan', 3, 6590);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (7, 5, 'Smith', 'Madison', 4, 4560);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (8, 5, 'Williams', 'Joshua', 3, 3300);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (9, 1, 'Nowicki', 'William', 4, 13800);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (10, 2, 'Miller', 'Emma', 1, 16000);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (11, 4, 'Moore', 'Laurence', 4, 4500);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (12, 2, 'Brown', 'Madison', 2, 9800);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (13, 4, 'Davis', 'Alexander', 3, 7800);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (14, 5, 'Taylor', 'Olivia', 4, 4500);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (15, 5, 'Moore', 'Madison', 4, 4000);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (16, 1, 'Baranowski', 'Jacob', 2, 7600);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (17, 1, 'Jakow', 'Isabella', 4, 5800);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (18, 1, 'Jackson', 'Robert', 2, 7100);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (19, 1, 'Taylor', 'Jurgen', 3, 8200);
INSERT INTO employees (employeeid, depid, surname, name, bossid, salary) VALUES (20, 1, 'Williams', 'Emma', 4, 7300);

COMMIT; -- Änderungen speichern / Save changes

-- ===============================================
-- Basics: Anonymous Block / Grundlegender anonymer Block
-- ===============================================
DECLARE
    var1 INTEGER; -- Integer Variable / Ganzzahl Variable
    var2 VARCHAR2(6) := 'World'; -- String Variable / String Variable
BEGIN
    var1 := 5; -- Wert zuweisen / Assign value
    DBMS_OUTPUT.PUT_LINE('Hello ' || var2); -- Ausgabe / Output
END;
/

-- ===============================================
-- Basic Datatypes / Grundlegende Datentypen
-- ===============================================
DECLARE
    num_var      NUMBER(4,2)   := 11.25; -- Number variable / Zahlenvariable
    int_var      INTEGER        := 5;     -- Integer variable / Ganzzahlvariable
    date_var     DATE           := TO_DATE('02/04/2022','dd/mm/yyyy'); -- Date variable / Datumsvariable
    string_var   VARCHAR2(50)  := 'string 1';
    string_no_var VARCHAR2(50) := '5.30';
    char_var     CHAR(50)      := 'string 2';
BEGIN
    DBMS_OUTPUT.PUT_LINE('num_var: ' || num_var);
    DBMS_OUTPUT.PUT_LINE('int_var: ' || int_var);
    DBMS_OUTPUT.PUT_LINE('date_var: ' || date_var);
    DBMS_OUTPUT.PUT_LINE('string_var: ' || string_var);
    DBMS_OUTPUT.PUT_LINE('char_var: ' || char_var);
    
    -- Type conversion / Typkonvertierung
    DBMS_OUTPUT.PUT_LINE('Convert number to string: ' || TO_CHAR(num_var)); -- Zahl -> String
    DBMS_OUTPUT.PUT_LINE('Convert string to number: ' || TO_NUMBER(string_no_var, '9.99')); -- String -> Zahl
END;
/

-- ===============================================
-- %ROWTYPE Example / %ROWTYPE Beispiel
-- ===============================================
DECLARE
    emp_record employees%ROWTYPE; -- Record vom Typ Mitarbeiter / Record of employee type
BEGIN
    SELECT * INTO emp_record FROM employees WHERE employeeid = 5; -- Zeile holen / Fetch row
    DBMS_OUTPUT.PUT_LINE('Name: ' || emp_record.name || ', Surname: ' || emp_record.surname || ', BossID: ' || emp_record.bossid);
END;
/

-- ===============================================
-- Conditional Structures / Bedingte Strukturen
-- ===============================================
DECLARE
    var1 INTEGER := 5;
BEGIN
    IF var1 = 5 THEN
        DBMS_OUTPUT.PUT_LINE('var1 equals 5 / var1 ist 5');
    ELSIF var1 > 5 THEN
        DBMS_OUTPUT.PUT_LINE('var1 > 5 / var1 ist größer als 5');
    ELSE
        DBMS_OUTPUT.PUT_LINE('var1 < 5 / var1 ist kleiner als 5');
    END IF;
END;
/

DECLARE
    var1 INTEGER := -12;
BEGIN
    CASE
        WHEN var1 = 5 THEN DBMS_OUTPUT.PUT_LINE('var1 = 5 / var1 ist 5');
        WHEN var1 > 5 THEN DBMS_OUTPUT.PUT_LINE('var1 > 5 / var1 ist größer als 5');
        WHEN var1 < 5 THEN DBMS_OUTPUT.PUT_LINE('var1 < 5 / var1 ist kleiner als 5');
        ELSE DBMS_OUTPUT.PUT_LINE('Unknown / Unbekannt');
    END CASE;
END;
/

-- ===============================================
-- Iterative Structures / Schleifen
-- ===============================================

-- Simple LOOP / Einfache Schleife
DECLARE
    i INTEGER := 0;
BEGIN
    LOOP
        i := i + 1;
        DBMS_OUTPUT.PUT_LINE('Index: ' || i);
        EXIT WHEN i >= 10;
    END LOOP;
END;
/

-- WHILE LOOP
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE('Index: ' || i);
        i := i + 1;
    END LOOP;
END;
/

-- FOR LOOP
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE('Index: ' || i);
    END LOOP;
END;
/

-- FOR LOOP over SELECT / Schleife über SELECT
BEGIN
    FOR i IN (SELECT surname FROM employees WHERE depid = 2) LOOP
        DBMS_OUTPUT.PUT_LINE('Department 2 -> ' || i.surname);
    END LOOP;
END;
/



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
Êóðñîð - ýòî èìåíîâàííàÿ èíñòðóêöèÿ SQL SELECT, êîòîðóþ ìû ìîæåì èñïîëüçîâàòü â íàøåé ïðîãðàììå PL/SQL äëÿ äîñòóïà 
ê íåñêîëüêèì ñòðîêàì èç òàáëèöû è èçâëå÷åíèÿ èõ ïî îäíîé ñòðîêå çà ðàç.
Êóðñîð - ýòî ìåõàíèçì, ñ ïîìîùüþ êîòîðîãî ìû ìîæåì ïðèñâîèòü èìÿ "îïåðàòîðó âûáîðà" è ìàíèïóëèðîâàòü èíôîðìàöèåé âíóòðè íåãî Èíñòðóêöèÿ SQL.
Ñóùåñòâóåò äâà òèïà ÊÓÐÑÎÐÎÂ: ÍÅßÂÍÛÅ è ßÂÍÛÅ.
*/

--------------------------------------------------------------------------------------------------------------------------------
--      Implicit cursors
--------------------------------------------------------------------------------------------------------------------------------
-- Implicit cursors are simple SELECT statements and are written in the BEGIN block (executable section)
-- Íåÿâíûå êóðñîðû ïðåäñòàâëÿþò ñîáîé ïðîñòûå îïåðàòîðû SELECT è çàïèñûâàþòñÿ â áëîêå BEGIN (ðàçäåë executable)

-- Every SQL statement in a PL/SQL block is actual an implicit cursor.
-- Êàæäàÿ èíñòðóêöèÿ SQL â áëîêå PL/SQL ôàêòè÷åñêè ÿâëÿåòñÿ íåÿâíûì êóðñîðîì.

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
Íåÿâíûå êóðñîðû àâòîìàòè÷åñêè óïðàâëÿþòñÿ PL/SQL, ïîýòîìó íàì íå òðåáóåòñÿ ïèñàòü êàêîé-ëèáî êîä äëÿ îáðàáîòêè ýòèõ êóðñîðîâ. 
Îäíàêî, ìû ìîæåì îòñëåæèâàòü èíôîðìàöèþ î âûïîëíåíèè íåÿâíîãî êóðñîðà ÷åðåç åãî àòðèáóòû êóðñîðà.

We can see how many rows are selected or changed by any statement using the %ROWCOUNT attribute after a Data Manipulation 
Language (DML) statement. INSERT, UPDATE, and DELETE statements are DML statements.
The reserved word SQL before the %ROWCOUNT cursor attribute stands for any implicit cursor.
Ìû ìîæåì âèäåòü, ñêîëüêî ñòðîê âûáðàíî èëè èçìåíåíî ëþáûì îïåðàòîðîì, èñïîëüçóÿ àòðèáóò %ROWCOUNT ïîñëå èíñòðóêöèè ßçûêà 
îáðàáîòêè äàííûõ (DML). Èíñòðóêöèè INSERT, UPDATE è DELETE - ýòî èíñòðóêöèè DML.
Çàðåçåðâèðîâàííîå ñëîâî SQL ïåðåä àòðèáóòîì êóðñîðà %ROWCOUNT îáîçíà÷àåò ëþáîé íåÿâíûé êóðñîð.

%FOUND - this attribute yields TRUE if an INSERT, UPDATE, or DELETE statement affected one or more rows or a SELECT INTO 
statement returned one or more rows. Otherwise, it yields FALSE.
%FOUND - ýòîò àòðèáóò âîçâðàùàåò çíà÷åíèå TRUE, åñëè èíñòðóêöèÿ INSERT, UPDATE èëè DELETE çàòðîíóëà îäíó èëè íåñêîëüêî ñòðîê 
èëè èíñòðóêöèÿ SELECT INTO âåðíóëà îäíó èëè íåñêîëüêî ñòðîê. Â ïðîòèâíîì ñëó÷àå îí âûäàåò çíà÷åíèå FALSE.
*/


-------------------------------------------------------------------------------------------------------------
--      EXPLICIT CURSORS
-------------------------------------------------------------------------------------------------------------
/*
EXPLICIT CURSORS can be STATIC or DYNAMIC SELECT statements. 
ßÂÍÛÅ ÊÓÐÑÎÐÛ ìîãóò áûòü ÑÒÀÒÈ×ÅÑÊÈÌÈ èëè ÄÈÍÀÌÈ×ÅÑÊÈÌÈ îïåðàòîðàìè.
- STATIC SELECT statements return the same query each time with potentially different results. The results change as the data 
changes in the tables or views.
Îïåðàòîðû STATIC SELECT êàæäûé ðàç âîçâðàùàþò îäèí è òîò æå çàïðîñ ñ ïîòåíöèàëüíî ðàçíûìè ðåçóëüòàòàìè. 
Ðåçóëüòàòû ìåíÿþòñÿ ïî ìåðå èçìåíåíèÿ äàííûõ â òàáëèöàõ èëè ïðåäñòàâëåíèÿõ.
- DYNAMIC SELECT statements act like parameterized subroutines. They run different queries each time, depending on the actual 
parameters provided when they are opened.
Îïåðàòîðû ÄÈÍÀÌÈ×ÅÑÊÎÃÎ ÂÛÁÎÐÀ äåéñòâóþò êàê ïàðàìåòðèçîâàííûå ïîäïðîãðàììû. Êàæäûé ðàç îíè âûïîëíÿþò ðàçíûå çàïðîñû, 
â çàâèñèìîñòè îò ôàêòè÷åñêèõ ïàðàìåòðîâ, ïðåäîñòàâëÿåìûõ ïðè èõ îòêðûòèè.
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
-- ßâíûå êóðñîðû òðåáóþò, ÷òîáû âû îòêðûâàëè, èçâëåêàëè è çàêðûâàëè èõ, íåçàâèñèìî îò òîãî, èñïîëüçóåòå ëè âû
-- ïðîñòûå öèêëû èëè öèêëû WHILE èëè îïåðàòîðû cursor FOR loop. Âû èñïîëüçóåòå èíñòðóêöèþ OPEN äëÿ îòêðûòèÿ êóðñîðîâ, èíñòðóêöèþ 
-- FETCH äëÿ èçâëå÷åíèÿ çàïèñåé èç êóðñîðîâ è èíñòðóêöèþ CLOSE äëÿ çàêðûòèÿ è îñâîáîæäåíèÿ ðåñóðñîâ êóðñîðîâ.

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
-- ×òîáû óïðîñòèòü âûðàæåíèå, ìû ìîæåì èñïîëüçîâàòü ÄËß öèêëà. Îïåðàòîðû Cursor FOR loop íåÿâíî îòêðûâàþò, èçâëåêàþò è 
-- çàêðûâàþò êóðñîðû äëÿ âàñ. Íåò íåîáõîäèìîñòè èçâëåêàòü çàïèñè â äîïîëíèòåëüíûå ïåðåìåííûå.
-- Öèêë CURSOR FOR çàâåðøèòñÿ, êîãäà áóäóò èçâëå÷åíû âñå çàïèñè â êóðñîðå.
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
-- Îïåðàòîð cursor FOR loop íå ïîääåðæèâàåò ïðÿìîå ïðèñâîåíèå ïåðåìåííûõ ëþáîãî òèïà, íî ìû ìîæåì ïðèñâàèâàòü çíà÷åíèÿ âíóòðè 
-- îïåðàòîðà FOR loop ñ ïîìîùüþ èíäåêñà êóðñîðà. Ìû ìîæåì íàçíà÷èòü ñòðóêòóðó çàïèñè èëè ýëåìåíò ñòðóêòóðû çàïèñè.
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
Äèíàìè÷åñêèå ÿâíûå êóðñîðû î÷åíü ïîõîæè íà ñòàòè÷åñêèå ÿâíûå êóðñîðû. Îíè èñïîëüçóþò îïåðàòîð SQL SELECT. Òîëüêî îïåðàòîð SELECT 
èñïîëüçóåò ïåðåìåííûå, êîòîðûå èçìåíÿþò ïîâåäåíèå çàïðîñà. Ïåðåìåííûå çàìåíÿþò òî, ÷òî â ïðîòèâíîì ñëó÷àå áûëî áû áóêâàëüíûìè çíà÷åíèÿìè.
Dynamic explicit cursors have the same four components as static cursors: you define, open, fetch from, and close a dynamic cursor.
Äèíàìè÷åñêèå ÿâíûå êóðñîðû èìåþò òå æå ÷åòûðå êîìïîíåíòà, ÷òî è ñòàòè÷åñêèå êóðñîðû: âû îïðåäåëÿåòå, îòêðûâàåòå, èçâëåêàåòå è 
çàêðûâàåòå äèíàìè÷åñêèé êóðñîð.
*/

-- The example program defines a cursor as a SELECT statement that queries the EMPLOYEES table for employees from department 4 
-- (defined as v_dep_no variable). This variable is declared as local variable and assigned numeric literal value. 
-- Ïðèìåð ïðîãðàììû îïðåäåëÿåò êóðñîð êàê îïåðàòîð SELECT, êîòîðûé çàïðàøèâàåò òàáëèöó EMPLOYEES äëÿ ñîòðóäíèêîâ èç îòäåëà 4 
-- (îïðåäåëÿåòñÿ êàê ïåðåìåííàÿ v_dep_no). Ýòà ïåðåìåííàÿ îáúÿâëÿåòñÿ êàê ëîêàëüíàÿ ïåðåìåííàÿ è ïðèñâàèâàåòñÿ ÷èñëîâîå 
-- áóêâàëüíîå çíà÷åíèå. 
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
-- Ñëåäóþùàÿ ïðîãðàììà èñïîëüçóåò ëîêàëüíóþ ïåðåìåííóþ âíóòðè îïåðàòîðà ÂÛÁÎÐÀ êóðñîðà.
-- Çíà÷åíèå äëÿ íîìåðà îòäåëà ïîäñòàâëÿåòñÿ, êîãäà ìû îòêðûâàåì êóðñîð. Ýòî òàêæå ðàáîòàåò â öèêëàõ cursor FOR è WHILE, 
-- ïîñêîëüêó ïåðåìåííûå çàìåíÿþòñÿ ïðè îòêðûòèè êóðñîðà.

-- The variable which indicates department number in the SELECT statement is no longer local variable name. It is local variable 
-- to the cursor, defined by the formal parameter in the cursor definition. You should note that the variable have no physical size, 
-- because that is derived at run time. When we run the program, the value 4 is assigned to local variable v_dep_no. The local 
-- variables become actual parameter passed to open the cursor. The actual parameter is then assigned to the department number 
-- cursor-scoped variable.
-- Ïåðåìåííàÿ, óêàçûâàþùàÿ íîìåð îòäåëà â èíñòðóêöèè SELECT, áîëüøå íå ÿâëÿåòñÿ èìåíåì ëîêàëüíîé ïåðåìåííîé. Ýòî ëîêàëüíàÿ ïåðåìåííàÿ
-- êóðñîðà, îïðåäåëåííàÿ ôîðìàëüíûì ïàðàìåòðîì â îïðåäåëåíèè êóðñîðà. Âû äîëæíû îòìåòèòü, ÷òî ïåðåìåííàÿ íå èìååò ôèçè÷åñêîãî ðàçìåðà, 
-- ïîñêîëüêó îíà âûâîäèòñÿ âî âðåìÿ âûïîëíåíèÿ. Êîãäà ìû çàïóñêàåì ïðîãðàììó, ëîêàëüíîé ïåðåìåííîé v_dep_no ïðèñâàèâàåòñÿ çíà÷åíèå 4. 
-- Ëîêàëüíûå ïåðåìåííûå ñòàíîâÿòñÿ ôàêòè÷åñêèì ïàðàìåòðîì, ïåðåäàâàåìûì äëÿ îòêðûòèÿ êóðñîðà. Çàòåì ôàêòè÷åñêèé ïàðàìåòð ïðèñâàèâàåòñÿ 
-- ïåðåìåííîé ñ îáëàñòüþ äåéñòâèÿ êóðñîðà íîìåðà îòäåëà.

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
-- Òà æå ëîãèêà ðàáîòàåò, êîãäà âû çàìåíÿåòå îïåðàòîð öèêëà êóðñîðîì.
-- Ñëåäóþùàÿ ñòðóêòóðà öèêëà ýêâèâàëåíòíà ñòðóêòóðå â èíñòðóêöèè simple loop.

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
-- Ìû ìîæåì èñïîëüçîâàòü êóðñîð äëÿ èçìåíåíèÿ (îáíîâëåíèÿ èëè óäàëåíèÿ) òåêóùåé ñòðîêè.
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

Êîãäà âû âûïîëíÿåòå îïåðàòîð SELECT äëÿ áàçû äàííûõ äëÿ çàïðîñà íåêîòîðûõ çàïèñåé, íà âûáðàííûå ñòðîêè íå íàêëàäûâàþòñÿ 
áëîêèðîâêè . Â öåëîì, ýòî çàìå÷àòåëüíàÿ ôóíêöèÿ, ïîòîìó ÷òî êîëè÷åñòâî çàïèñåé, çàáëîêèðîâàííûõ â ëþáîé ìîìåíò âðåìåíè, 
(ïî óìîë÷àíèþ) ñâåäåíî ê àáñîëþòíîìó ìèíèìóìó: áëîêèðóþòñÿ òîëüêî òå çàïèñè, êîòîðûå áûëè èçìåíåíû, íî åùå íå çàôèêñèðîâàíû. 
Äàæå â ýòîì ñëó÷àå äðóãèå ïîëüçîâàòåëè ñìîãóò ïðî÷èòàòü ýòè çàïèñè â òîì âèäå, â êàêîì îíè áûëè äî èçìåíåíèÿ.

There are times, however, when you will want to lock a set of records even before you change themin your program. 
Oracle offers the FOR UPDATE clause of the SELECT statement to perform this locking.

Îäíàêî áûâàþò ñëó÷àè, êîãäà âàì çàõî÷åòñÿ çàáëîêèðîâàòü íàáîð çàïèñåé åùå äî òîãî, êàê âû èçìåíèòå èõ â ñâîåé ïðîãðàììå. 
Oracle ïðåäëàãàåò ïðåäëîæåíèå FOR UPDATE èíñòðóêöèè SELECT äëÿ âûïîëíåíèÿ ýòîé áëîêèðîâêè.

When we issue a SELECT FOR UPDATE statement, the server automatically obtains exclusive row-level locks on all the rows 
identified by the SELECT statement, holding the records "for our changes only" as we move through the rows retrieved by the cursor. 
No one else will be able to change any of these records until we perform a ROLLBACK or a COMMIT.
The COMMIT statement makes permanent any changes made to the database during the currentransaction. A commit also makes the 
changes visible to other users. The ROLLBACK statement is the inverse of the COMMIT statement. It undoes some or all database 
changes made during the current transaction.

Êîãäà ìû âûäàåì èíñòðóêöèþ SELECT FOR UPDATE, ñåðâåð àâòîìàòè÷åñêè ïîëó÷àåò ýêñêëþçèâíûå áëîêèðîâêè íà óðîâíå ñòðîê äëÿ âñåõ 
ñòðîê, îïðåäåëåííûõ èíñòðóêöèåé SELECT, óäåðæèâàÿ çàïèñè "òîëüêî äëÿ íàøèõ èçìåíåíèé", êîãäà ìû ïåðåìåùàåìñÿ ïî ñòðîêàì , 
èçâëå÷åííûì êóðñîðîì. Íèêòî äðóãîé íå ñìîæåò èçìåíèòü íè îäíó èç ýòèõ çàïèñåé, ïîêà ìû íå âûïîëíèì ÎÒÊÀÒ èëè ñîâåðøèòü. 
Èíñòðóêöèÿ COMMIT äåëàåò ïîñòîÿííûìè ëþáûå èçìåíåíèÿ, âíåñåííûå â áàçó äàííûõ âî âðåìÿ currenttransaction. Ôèêñàöèÿ òàêæå 
äåëàåò èçìåíåíèÿ âèäèìûìè äëÿ äðóãèõ ïîëüçîâàòåëåé. Îïåðàòîð ROLLBACK ÿâëÿåòñÿ îáðàòíûì îïåðàòîðó COMMIT. Ýòî îòìåíÿåò 
íåêîòîðûå èëè âñå èçìåíåíèÿ áàçû äàííûõ, âíåñåííûå âî âðåìÿ òåêóùåé òðàíçàêöèè.

We can use the FOR UPDATE option to declare an update cursor. We can use the update cursor to modify (update or delete) 
the current row.

Ìû ìîæåì èñïîëüçîâàòü îïöèþ ÄËß ÎÁÍÎÂËÅÍÈß, ÷òîáû îáúÿâèòü êóðñîð îáíîâëåíèÿ. Ìû ìîæåì èñïîëüçîâàòü êóðñîð îáíîâëåíèÿ, 
÷òîáû èçìåíèòü (îáíîâèòü èëè óäàëèòü) òåêóùóþ ñòðîêó.

In an update cursor, we can update or delete rows in the active set. After we create an update cursor, we can update or delete 
the currently selected row by using an UPDATE or DELETE statement with the WHERE CURRENT OF clause. The words CURRENT OF refer 
to the row that was most recently fetched; they take the place of the usual test expressions in the WHERE clause.

Â êóðñîðå îáíîâëåíèÿ ìû ìîæåì îáíîâëÿòü èëè óäàëÿòü ñòðîêè â àêòèâíîì íàáîðå. Ïîñëå òîãî, êàê ìû ñîçäàäèì êóðñîð îáíîâëåíèÿ, 
ìû ìîæåì îáíîâèòü èëè óäàëèòü âûáðàííóþ â äàííûé ìîìåíò ñòðîêó ñ ïîìîùüþ èíñòðóêöèè UPDATE èëè DELETE ñ ïðåäëîæåíèåì 
WHERE CURRENT OF. Ñëîâà CURRENT OF îòíîñÿòñÿ ê ñòðîêå, êîòîðàÿ áûëà èçâëå÷åíà ñîâñåì íåäàâíî; îíè çàìåíÿþò îáû÷íûå òåñòîâûå 
âûðàæåíèÿ â ïðåäëîæåíèè WHERE.
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
-- Íàèáîëåå âàæíûì ïðåèìóùåñòâîì èñïîëüçîâàíèÿ WHERE CURRENT ÂÌÅÑÒÎ where íàì íóæíî èçìåíèòü ñòðîêó, âûáðàííóþ ïîñëåäíåé, 
-- ÿâëÿåòñÿ òî, ÷òî íàì íå íóæíî êîäèðîâàòü êðèòåðèè, èñïîëüçóåìûå äëÿ îäíîçíà÷íîé èäåíòèôèêàöèè ñòðîêè â òàáëèöå.
/*
    The FOR UPDATE keywords notify the database server that updating is possible and cause it to use more stringent locking 
than with a select cursor. We declare an update cursor to let the database server know that the program might update 
(or delete) any row that it fetches as part of the SELECT statement. The update cursor employs promotable locks for rows 
that the program fetches. Other programs can read the locked row, but no other program can place a promotable lock 
(also called a write lock). Before the program modifies the row, the row lock is promoted to an exclusive lock.
    Êëþ÷åâûå ñëîâà FOR UPDATE óâåäîìëÿþò ñåðâåð áàçû äàííûõ î òîì, ÷òî îáíîâëåíèå âîçìîæíî, è çàñòàâëÿþò åãî èñïîëüçîâàòü 
áîëåå ñòðîãóþ áëîêèðîâêó, ÷åì ïðè èñïîëüçîâàíèè êóðñîðà âûáîðà. Ìû îáúÿâëÿåì update êóðñîð, ÷òîáû ñîîáùèòü ñåðâåðó áàçû 
äàííûõ, ÷òî ïðîãðàììà ìîæåò îáíîâèòü (èëè óäàëèòü) ëþáóþ ñòðîêó, êîòîðóþ îíà èçâëåêàåò êàê ÷àñòü èíñòðóêöèè SELECT. 
Update êóðñîð èñïîëüçóåò ïðîäâèãàåìûå áëîêèðîâêè äëÿ ñòðîê, êîòîðûå èçâëåêàåò ïðîãðàììà. Äðóãèå ïðîãðàììû ìîãóò ñ÷èòûâàòü 
çàáëîêèðîâàííóþ ñòðîêó, íî íèêàêàÿ äðóãàÿ ïðîãðàììà íå ìîæåò óñòàíîâèòü ïðîäâèãàåìóþ áëîêèðîâêó (òàêæå íàçûâàåìóþ áëîêèðîâêîé 
çàïèñè). Ïåðåä òåì, êàê ïðîãðàììà èçìåíèò ñòðîêó, áëîêèðîâêà ñòðîêè áóäåò ïîâûøåíà äî ýêñêëþçèâíîé áëîêèðîâêè.
*/


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Lesson 3: Procedures and functions
--       POSITIONAL, NAMED and MIXED NOTATION
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/*    There are two types of subroutines: FUNCTIONS and PROCEDURES. You use these to build database tier libraries to encapsulate 
application functionality, which is then co-located on the database tier for efficiency.
    Ñóùåñòâóåò äâà òèïà ïîäïðîãðàìì: ÔÓÍÊÖÈÈ è ÏÐÎÖÅÄÓÐÛ. Âû èñïîëüçóåòå èõ äëÿ ñîçäàíèÿ áèáëèîòåê óðîâíÿ áàçû äàííûõ äëÿ 
èíêàïñóëÿöèè ôóíêöèîíàëüíîñòè ïðèëîæåíèÿ, êîòîðàÿ çàòåì ñîâìåñòíî ðàçìåùàåòñÿ íà óðîâíå áàçû äàííûõ äëÿ ïîâûøåíèÿ ýôôåêòèâíîñòè.

    They are named PL/SQL blocks. You can deploy them as standalone subroutines or as components in packages. Packages and 
object types can contain both functions and procedures. Anonymous blocks can also have local functions and procedures defined 
in their declaration blocks. You can also nest furctions and procedures inside other functions and procedures.
    Îíè íàçûâàþòñÿ áëîêàìè PL/SQL. Âû ìîæåòå ðàçâåðíóòü èõ êàê îòäåëüíûå ïîäïðîãðàììû èëè êàê êîìïîíåíòû â ïàêåòàõ. Ïàêåòû è 
òèïû îáúåêòîâ ìîãóò ñîäåðæàòü êàê ôóíêöèè, òàê è ïðîöåäóðû. Àíîíèìíûå áëîêè òàêæå ìîãóò èìåòü ëîêàëüíûå ôóíêöèè è ïðîöåäóðû, 
îïðåäåëåííûå â èõ áëîêàõ îáúÿâëåíèé. Âû òàêæå ìîæåòå âëîæèòü ôóíêöèè è ïðîöåäóðû â äðóãèå ôóíêöèè è ïðîöåäóðû.

    You publish functions and procedures as standalone units or within packages and object types. This means that they are 
defined in the package specification or object type, not the package body or object type body. They are local subroutines when 
you define functions or procedures inside package bodies or object type bodies. Local subroutines are not published subroutines. 
Likewise, subroutines defined in the declaration block of anonymous block programs are local subroutines.
    Âû ïóáëèêóåòå ôóíêöèè è ïðîöåäóðû êàê îòäåëüíûå ìîäóëè èëè âíóòðè ïàêåòîâ è òèïîâ îáúåêòîâ. Ýòî îçíà÷àåò, ÷òî îíè îïðåäåëåíû 
â ñïåöèôèêàöèè ïàêåòà èëè òèïå îáúåêòà, à íå â òåëå ïàêåòà èëè òåëå òèïà îáúåêòà. Îíè ÿâëÿþòñÿ ëîêàëüíûìè ïîäïðîãðàììàìè, êîãäà 
âû îïðåäåëÿåòå ôóíêöèè èëè ïðîöåäóðû âíóòðè òåë ïàêåòîâ èëè òåë òèïîâ îáúåêòîâ. Ëîêàëüíûå ïîäïðîãðàììû íå ÿâëÿþòñÿ 
îïóáëèêîâàííûìè ïîäïðîãðàììàìè. Àíàëîãè÷íî, ïîäïðîãðàììû, îïðåäåëåííûå â áëîêå îáúÿâëåíèÿ àíîíèìíûõ áëî÷íûõ ïðîãðàìì, 
ÿâëÿþòñÿ ëîêàëüíûìè ïîäïðîãðàììàìè.

    Functions and procedures are named PL/SQL blocks. You can also call them subroutines or subprograms. They have headers 
in place of the DECLARE statement. The header defines the function or procedure name, a list of formal parameters, and a return
data type for functions. Formal parameters define variables that you can send to subroutines when you call them. 
You use both formal parameters and local variables inside functions and procedures.
    Ôóíêöèè è ïðîöåäóðû íàçûâàþòñÿ áëîêàìè PL/SQL. Âû òàêæå ìîæåòå íàçûâàòü èõ ïîäïðîãðàììàìè èëè ïîäïðîãðàììàìè. Ó íèõ åñòü 
çàãîëîâêè âìåñòî èíñòðóêöèè DECLARE. Çàãîëîâîê îïðåäåëÿåò èìÿ ôóíêöèè èëè ïðîöåäóðû, ñïèñîê ôîðìàëüíûõ ïàðàìåòðîâ è âîçâðàùàåìûé 
òèï äàííûõ äëÿ ôóíêöèé. Ôîðìàëüíûå ïàðàìåòðû îïðåäåëÿþò ïåðåìåííûå, êîòîðûå âû ìîæåòå îòïðàâëÿòü ïîäïðîãðàììàì ïðè èõ âûçîâå. 
Âû èñïîëüçóåòå êàê ôîðìàëüíûå ïàðàìåòðû, òàê è ëîêàëüíûå ïåðåìåííûå âíóòðè ôóíêöèé è ïðîöåäóð.

    While functions return a datatype, procedures do not. Functions return output as values represented as SQL or PL/SQL 
datatypes Procedures can return values through their formal parameter list variables when they are passed by reference.
    Â òî âðåìÿ êàê ôóíêöèè âîçâðàùàþò òèï äàííûõ, ïðîöåäóðû ýòîãî íå äåëàþò. 
	Ôóíêöèè âîçâðàùàþò âûõîäíûå äàííûå â âèäå çíà÷åíèé, ïðåäñòàâëåííûõ â âèäå SQL èëè ïðîöåäóðû òèïîâ äàííûõ PL/SQL ìîãóò 
	âîçâðàùàòü çíà÷åíèÿ ÷åðåç ñâîè ôîðìàëüíûå ïåðåìåííûå ñïèñêà ïàðàìåòðîâ, êîãäà îíè ïåðåäàþòñÿ ïî ññûëêå.

    There are four types of generic subroutines in programming languages. The four types are defined by two behaviors, whether 
they return a formal value or not and whether their parameter lists are passed by value
(subroutines receive copies of values) or reference (subroutines receive references to variables).
    Â ÿçûêàõ ïðîãðàììèðîâàíèÿ ñóùåñòâóåò ÷åòûðå òèïà óíèâåðñàëüíûõ ïîäïðîãðàìì. ×åòûðå òèïà îïðåäåëÿþòñÿ äâóìÿ ïîâåäåíèÿìè, 
íåçàâèñèìî îò òîãî, âîçâðàùàþò ëè îíè ôîðìàëüíîå çíà÷åíèå èëè íåò, è ïåðåäàþòñÿ ëè èõ ñïèñêè ïàðàìåòðîâ ïî çíà÷åíèþ
(ïîäïðîãðàììû ïîëó÷àþò êîïèè çíà÷åíèé) èëè ïî ññûëêå (ïîäïðîãðàììû ïîëó÷àþò ññûëêè íà ïåðåìåííûå).

    You set formal parameters when you define subroutines. You call subroutines with actual parameters. Formal parameters define 
the list of possible variables, and their positions and datatypes. Formal
parameters do not assign values other than a default value, which makes a parameter optional. Actual
parameters are the values you provide to subroutines when calling
them. You can call subroutines without an actual parameter when the formal parameter has a default value.
    Âû óñòàíàâëèâàåòå ôîðìàëüíûå ïàðàìåòðû ïðè îïðåäåëåíèè ïîäïðîãðàìì. Âû âûçûâàåòå ïîäïðîãðàììû ñ ôàêòè÷åñêèìè ïàðàìåòðàìè. 
Ôîðìàëüíûå ïàðàìåòðû îïðåäåëÿþò ñïèñîê âîçìîæíûõ ïåðåìåííûõ, à òàêæå èõ ïîçèöèè è òèïû äàííûõ. 
Ôîðìàëüíûì ïàðàìåòðàì íå ïðèñâàèâàþòñÿ çíà÷åíèÿ, îòëè÷íûå îò çíà÷åíèÿ ïî óìîë÷àíèþ, ÷òî äåëàåò ïàðàìåòð íåîáÿçàòåëüíûì. 
Ôàêòè÷åñêèå ïàðàìåòðû - ýòî çíà÷åíèÿ, êîòîðûå âû ïðåäîñòàâëÿåòå ïîäïðîãðàììàì ïðè èõ âûçîâå. 
Âû ìîæåòå âûçûâàòü ïîäïðîãðàììû áåç ôàêòè÷åñêîãî ïàðàìåòðà, åñëè ôîðìàëüíûé ïàðàìåòð èìååò çíà÷åíèå ïî óìîë÷àíèþ.

    You can use functions as right operands in assignments because their result is a value of a datatype defined in the database 
catalog. Both pass-by-value and pass-by-reference functions fill this role equally
inside PL/SQL blocks. You can use pass-by-reference functions in SQL statements only when you manage
the actual parameters before and after the function call. You can also use the CALL statement with the
INTO clause to return SQL data types from functions.
    Âû ìîæåòå èñïîëüçîâàòü ôóíêöèè â êà÷åñòâå ïðàâèëüíûõ îïåðàíäîâ ïðè ïðèñâàèâàíèè, ïîñêîëüêó èõ ðåçóëüòàòîì ÿâëÿåòñÿ çíà÷åíèå 
òèïà äàííûõ, îïðåäåëåííîãî â êàòàëîãå áàçû äàííûõ. Êàê ôóíêöèè ïåðåäà÷è ïî çíà÷åíèþ, òàê è ôóíêöèè ïåðåäà÷è ïî ññûëêå îäèíàêîâî âûïîëíÿþò ýòó ðîëü
âíóòðè áëîêîâ PL/SQL. Âû ìîæåòå èñïîëüçîâàòü ôóíêöèè ïåðåäà÷è ïî ññûëêå â îïåðàòîðàõ SQL òîëüêî â òîì ñëó÷àå, åñëè âû óïðàâëÿåòå
ôàêòè÷åñêèìè ïàðàìåòðàìè äî è ïîñëå âûçîâà ôóíêöèè. Âû òàêæå ìîæåòå èñïîëüçîâàòü îïåðàòîð CALL ñ
ïðåäëîæåíèåì INTO äëÿ âîçâðàòà òèïîâ äàííûõ SQL èç ôóíêöèé.

    PL/SQL qualifies functions and procedures as pass-by-value or pass-by-reference subroutines by the mode of their formal 
parameter lists. PL/SQL supports three modes: read-only, write-only, and read-write. The IN
mode is the default and designates a formal parameter as read-only. OUT mode designates a write-only
parameter, and IN OUT mode designates a read-write parameter mode.

    PL/SQL êâàëèôèöèðóåò ôóíêöèè è ïðîöåäóðû êàê ïîäïðîãðàììû ïåðåäà÷è ïî çíà÷åíèþ èëè ïåðåäà÷è ïî ññûëêå ñ ïîìîùüþ ðåæèìà 
èç èõ ôîðìàëüíûõ ñïèñêîâ ïàðàìåòðîâ. 
PL/SQL ïîääåðæèâàåò òðè ðåæèìà: 
-- òîëüêî äëÿ ÷òåíèÿ, 
-- òîëüêî äëÿ çàïèñè,
-- äëÿ ÷òåíèÿ è äëÿ çàïèñè.
Ðåæèì IN èñïîëüçóåòñÿ ïî óìîë÷àíèþ è îïðåäåëÿåò ôîðìàëüíûé ïàðàìåòð êàê äîñòóïíûé òîëüêî äëÿ ÷òåíèÿ. 
Ðåæèì OUT îïðåäåëÿåò ïàðàìåòð, äîñòóïíûé òîëüêî äëÿ çàïèñè, à 
ðåæèì IN OUT îïðåäåëÿåò ðåæèì ïàðàìåòðîâ äëÿ ÷òåíèÿ è çàïèñè.

    The IN mode is the default mode. It means a formal parameter is read-only. When you set a formal parameter as read-only, 
you can not alter it during the execution of the subroutine. You can assign a
default value to a parameter, making the parameter optional. You use the IN mode for all formal
parameters when you want to define a pass-by-value subroutine. The IN parameter allows you to pass
values in to the module, but will not pass anything out of the module and back to the calling PL/SQL
block.
    Ðåæèì IN - ýòî ðåæèì ïî óìîë÷àíèþ. Ýòî îçíà÷àåò, ÷òî ôîðìàëüíûé ïàðàìåòð äîñòóïåí òîëüêî äëÿ ÷òåíèÿ. 
Êîãäà âû óñòàíàâëèâàåòå ôîðìàëüíûé ïàðàìåòð êàê äîñòóïíûé òîëüêî äëÿ ÷òåíèÿ, âû íå ìîæåòå èçìåíÿòü åãî âî âðåìÿ âûïîëíåíèÿ ïîäïðîãðàììû.
Âû ìîæåòå ïðèñâîèòü ïàðàìåòðó çíà÷åíèå ïî óìîë÷àíèþ, ñäåëàâ åãî íåîáÿçàòåëüíûì. Âû èñïîëüçóåòå ðåæèì IN äëÿ âñåõ ôîðìàëüíûõ
ïàðàìåòðîâ, êîãäà õîòèòå îïðåäåëèòü ïîäïðîãðàììó ïåðåäà÷è ïî çíà÷åíèþ. Ïàðàìåòð IN ïîçâîëÿåò âàì ïåðåäàâàòü
çíà÷åíèÿ â ìîäóëü, íî íå áóäåò ïåðåäàâàòü íè÷åãî èç ìîäóëÿ è îáðàòíî â âûçûâàþùèé áëîê PL/SQL

    The OUT mode means a formal parameter is write-only. When you set a formal parameter as write-only, there is no initial 
physical size allocated to the variable. You allocate the physical sizeand value inside
your subroutine. You can't assign a default value, which would make an OUT mode formal parameter
optional. You use an OUT mode with one or more formal parameters when you want a write-only pass-
by-reference subroutine. Use the OUT parameter to pass a value back from the program to the calling
PL/SQL block.
    Ðåæèì OUT îçíà÷àåò, ÷òî ôîðìàëüíûé ïàðàìåòð äîñòóïåí òîëüêî äëÿ çàïèñè. Êîãäà âû óñòàíàâëèâàåòå ôîðìàëüíûé ïàðàìåòð êàê 
äîñòóïíûé òîëüêî äëÿ çàïèñè, äëÿ ïåðåìåííîé íå âûäåëÿåòñÿ íà÷àëüíûé ôèçè÷åñêèé ðàçìåð. Âû âûäåëÿåòå ôèçè÷åñêèé ðàçìåð è çíà÷åíèå âíóòðè
ñâîåé ïîäïðîãðàììû. Âû íå ìîæåòå ïðèñâîèòü çíà÷åíèå ïî óìîë÷àíèþ, êîòîðîå ñäåëàëî áû ôîðìàëüíûé ïàðàìåòð OUT mode
íåîáÿçàòåëüíûì. Âû èñïîëüçóåòå ðåæèì OUT ñ îäíèì èëè íåñêîëüêèìè ôîðìàëüíûìè ïàðàìåòðàìè, êîãäà âàì íóæíà ïîäïðîãðàììà ïåðåäà÷è
ïî ññûëêå òîëüêî äëÿ çàïèñè. Èñïîëüçóéòå ïàðàìåòð OUT äëÿ ïåðåäà÷è çíà÷åíèÿ îáðàòíî èç ïðîãðàììû âûçûâàþùåìó
Áëîê PL/SQL.

    The IN OUT mode means a formal parameter is read-write. When you set a formal parameter as read-write, the actual parameter 
provides the physical size of the actual parameter. While you can change the contents of the variable inside the subroutine, 
you can't change or exceed the actual parameters
allocated size. You can't assign a default value making an IN OUT mode parameter optional. You use an
IN OUT mode with one or more formal parameters when you want a read-write pass-by-reference
subroutine. With an IN OUT parameter, you can pass values into the program and return a value back to
the calling program (either the original, unchanged value or a new value set within the program).
    Ðåæèì IN OUT îçíà÷àåò, ÷òî ôîðìàëüíûì ïàðàìåòðîì ÿâëÿåòñÿ ÷òåíèå-çàïèñü. Êîãäà âû óñòàíàâëèâàåòå ôîðìàëüíûé ïàðàìåòð 
êàê ÷òåíèå-çàïèñü, ôàêòè÷åñêèé ïàðàìåòð ïðåäîñòàâëÿåò ôèçè÷åñêèé ðàçìåð ôàêòè÷åñêîãî ïàðàìåòðà. Â òî âðåìÿ êàê âû ìîæåòå èçìåíÿòü
ñîäåðæèìîå ïåðåìåííîé âíóòðè ïîäïðîãðàììû, âû íå ìîæåòå èçìåíÿòü èëè ïðåâûøàòü ôàêòè÷åñêèé ðàçìåð âûäåëåííûõ ïàðàìåòðîâ.
Âû íå ìîæåòå ïðèñâîèòü çíà÷åíèå ïî óìîë÷àíèþ, ñäåëàâ ïàðàìåòð IN OUT mode íåîáÿçàòåëüíûì. Âû èñïîëüçóåòå Â ðåæèìå OUT ñ îäíèì
èëè íåñêîëüêèìè ôîðìàëüíûìè ïàðàìåòðàìè, êîãäà âàì íóæíà ïîäïðîãðàììà ïåðåäà÷è ÷òåíèÿ-çàïèñè ïî ññûëêå. Ñ ïîìîùüþ ïàðàìåòðà 
IN OUT âû ìîæåòå ïåðåäàâàòü çíà÷åíèÿ â ïðîãðàììó è âîçâðàùàòü çíà÷åíèå îáðàòíî â âûçûâàþùàÿ ïðîãðàììà (ëèáî èñõîäíîå, 
íåèçìåíåííîå çíà÷åíèå, ëèáî íîâîå çíà÷åíèå, óñòàíîâëåííîå â ïðîãðàììå).
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
-- Ìû ìîæåì èñïîëüçîâàòü ÏÎÇÈÖÈÎÍÍÓÞ, ÈÌÅÍÎÂÀÍÍÓÞ è ÑÌÅØÀÍÍÓÞ ÍÎÒÀÖÈÞ ïðè âûçîâå ïîäïðîãðàìì â ïðîãðàììíûõ åäèíèöàõ PL/SQL.

-- POSITIONAL NOTATION means that you provide a value for each variable in the formal parameter list. 
-- The values must be in sequential order and must also match the datatype.
-- ÏÎÇÈÖÈÎÍÍÀß ÍÎÒÀÖÈß îçíà÷àåò, ÷òî âû óêàçûâàåòå çíà÷åíèå äëÿ êàæäîé ïåðåìåííîé â ñïèñêå ôîðìàëüíûõ ïàðàìåòðîâ. 
-- Çíà÷åíèÿ äîëæíû áûòü â ïîñëåäîâàòåëüíîì ïîðÿäêå, à òàêæå äîëæíû ñîîòâåòñòâîâàòü òèïó äàííûõ.
BEGIN
    print_strings ('first_str_1', 'second_str_2');
END;

-- NAMED NOTATION means that you pass actual parameters by using their formal parameter name, the association operator (=>), 
-- and the value. Named notation lets you only pass values to required parameters, which means you accept the default 
-- values for any optional parameters.
-- Èìåíîâàííàÿ íîòàöèÿ îçíà÷àåò, ÷òî âû ïåðåäàåòå ôàêòè÷åñêèå ïàðàìåòðû, èñïîëüçóÿ èõ ôîðìàëüíîå èìÿ ïàðàìåòðà, îïåðàòîð 
-- àññîöèàöèè (=>) è çíà÷åíèå. Èìåíîâàííàÿ íîòàöèÿ ïîçâîëÿåò ïåðåäàâàòü çíà÷åíèÿ òîëüêî òðåáóåìûì ïàðàìåòðàì, ÷òî îçíà÷àåò, 
-- ÷òî âû ïðèíèìàåòå çíà÷åíèÿ ïî óìîë÷àíèþ äëÿ ëþáûõ íåîáÿçàòåëüíûõ ïàðàìåòðîâ.
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
-- Ôóíêöèÿ 
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/*
Ôóíêöèÿ   ýòî ïîäïðîãðàììà íà ÿçûêå ORACLE PL SQL, êîòîðàÿ âû÷èñëÿåò çíà÷åíèÿ è âîçâðàùàåò ðåçóëüòàò âû÷èñëåíèÿ.
Ó ôóíêöèè åñòü óíèêàëüíîå â ðàìêàõ ñõåìû ÁÄ èìÿ è íàáîð ïàðàìåòðîâ.
Ôóíêöèþ ìîæíî âûçûâàòü èç äðóãîé ïðîöåäóðû èëè ôóíêöèè, à òàêæå èç àíîíèìíîãî PL SQL áëîêà.
Çàìå÷àòåëüíûì ñâîéñòâîì ôóíêöèè ÿâëÿåòñÿ òî, ÷òî ôóíêöèþ ìîæíî èñïîëüçîâàòü â SQL çàïðîñå,
ïåðåäàâàÿ ôóíêöèè PL SQL ïàðàìåòðû èç SQL çàïðîñà.
*/
-- Ñèíòàêñèñ

CREATE OR REPLACE FUNCTION -- èìÿ_ôóíêöèè
-- [ (ïàðàìåòð [, ïàðàìåòð, ]) ] 
RETURN -- âîçâðàùàåìûé òèï 
IS
-- [ëîêàëüíûå îáúÿâëåíèÿ]
BEGIN
-- èñïîëíÿåìûå ïðåäëîæåíèÿ
RETURN -- âîçâðàùàåìîå çíà÷åíèå;
[EXCEPTION
-- îáðàáîò÷èêè èñêëþ÷åíèé]
END -- [èìÿ_ôóíêöèè];


-- Óäàëåíèå ïðîöåäóðû èç ÁÄ îñóùåñòâëÿåòñÿ êîìàíäîé 
DROP FUNCTION "èìÿ ïðîöåäóðû".

-- Ïàðàìåòðû, ïåðåäàâàåìûå â ôóíêöèþ, ìîãóò áûòü in èëè/è out(ïî óìîë÷àíèþ in)
-- Ïàðàìåòðû in ìîæíî èñïîëüçîâàòü â ôóíêöèè, íî èì íåëüçÿ ïðèñâàèâàòü çíà÷åíèå.
-- Ïàðàìåòðû Out ìîæíî èñïîëüçîâàòü â ôóíêöèè, èì ïðèñâàèâàåòñÿ çíà÷åíèå, êîòîðîå ïåðåäàåòñÿ âî âíåøíèé ïðîãðàììîé áëîê.

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
-- Ïðèìåðû âûçîâà ôóíêöèè
---------------------------------------------------------

--      Àíîíèìíûé áëîê
BEGIN
     DBMS_OUTPUT.PUT_LINE( add_number(2, 3) );
END;

--      Ïðîöåäóðà
create or replace procedure test_proc(par1 number:=10, par2 out number, par3 in out number)
is
  t varchar2(50):= 'test1';
  r number;
begin
  t:= 'test';
  r := 11;
  par2 := par1 * r;
  -- ÂÛÇÎÂ X_3
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
-- Ëþáîé ôîðìàëüíûé ïàðàìåòð ìîæåò èìåòü íà÷àëüíîå çíà÷åíèå ïî óìîë÷àíèþ.
CREATE OR REPLACE FUNCTION add_number (num1 NUMBER := 4, num2 NUMBER := 5) 
    RETURN NUMBER
IS
BEGIN
    RETURN num1 + num2;
END add_number;

-- If the function has declared default values we can omit parameters and parentheses when we call the function.
-- Åñëè ôóíêöèÿ èìååò îáúÿâëåííûå çíà÷åíèÿ ïî óìîë÷àíèþ, ìû ìîæåì îïóñòèòü ïàðàìåòðû è êðóãëûå ñêîáêè ïðè âûçîâå ôóíêöèè.
DECLARE
    result  NUMBER;
BEGIN
    --result := add_number; -- Åñëè ôóíêöèÿ èìååò îáúÿâëåííûå çíà÷åíèÿ ïî óìîë÷àíèþ, ìû ìîæåì îïóñòèòü ïàðàìåòðû è êðóãëûå ñêîáêè ïðè âûçîâå ôóíêöèè.
    result := add_number (5); -- ìîæíî îïóñòèòü òîëüêî îäèí ïàðàìåòð (â äàííîì ñëó÷àå num1 = 5, num2 = 5 ïî óìîë÷àíèþ)
    DBMS_OUTPUT.PUT_LINE(result);
END;

-- We use pass-by-reference functions when we want to perform an operation, return a value from the function, and alter one 
-- or more actual parameters.
-- Ìû èñïîëüçóåì ôóíêöèè ïåðåäà÷è ïî ññûëêå, êîãäà õîòèì âûïîëíèòü îïåðàöèþ, âåðíóòü çíà÷åíèå èç ôóíêöèè è èçìåíèòü îäèí 
-- èëè íåñêîëüêî ôàêòè÷åñêèõ ïàðàìåòðîâ.

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

-- Ôóíêöèÿ äîëæíà èìåòü ïî êðàéíåé ìåðå îäèí îïåðàòîð RETURN â ñâîåì ðàçäåëå èíñòðóêöèé execution. Îí ìîæåò èìåòü áîëåå îäíîãî 
-- ÂÎÇÂÐÀÒÀ, íî ïðè êàæäîì âûçîâå ôóíêöèè âûïîëíÿåòñÿ òîëüêî îäèí èç ýòèõ îïåðàòîðîâ. Îïåðàòîð RETURN, âûïîëíÿåìûé ôóíêöèåé, 
-- îïðåäåëÿåò çíà÷åíèå, âîçâðàùàåìîå ýòîé ôóíêöèåé. Êîãäà îïåðàòîð RETURN îáðàáàòûâàåòñÿ, ôóíêöèÿ íåìåäëåííî çàâåðøàåòñÿ è 
-- âîçâðàùàåò óïðàâëåíèå âûçûâàþùåìó áëîêó PL/SQL.
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

-- Lesson 4: EXCEPTION HANDLING  (ÎÁÐÀÁÎÒÊÀ ÈÑÊËÞ×ÅÍÈÉ)

--      NAMED SYSTEM EXCEPTION EXAMPLES
--      NAMED PROGRAMMER-DEFINED EXCEPTIONS
--      UNNAMED SYSTEM EXCEPTIONS
--      UNNAMED PROGRAMMER-DEFINED EXCEPTIONS
--      SCOPE OF AN EXCEPTION AND PROPAGATION (ÎÁËÀÑÒÜ ÄÅÉÑÒÂÈß ÈÑÊËÞ×ÅÍÈß È ÐÀÑÏÐÎÑÒÐÀÍÅÍÈÅ)
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/*
Â Oracle ñóùåòâóþò èñêëþ÷èòåëüíûå ñèòóàöèè, êîòîðûå âîçíèêàþò ïðè îïðåäåëííûõ îáû÷íî íåêîððåêòíûõ äåñòâèÿõ â ïðîãðàììå
Èñêëþ÷åíèå Oracle Error SQLCODE Value

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
×òîáû îçíàêîìèòñÿ ñ áîëåå ïîäðîáíûì ñïèñêîì èñêëþ÷åíèé, ñìîòðèòå Server Messages.

Îïèñàíèå èñêëþ÷åíèé :
CURSOR_ALREADY_OPEN âûçûâàåòñÿ, åñëè âû ðàííåå óæå îòêðûëè äàííûé êóðñîð. Âû äîëæíû çàêðûòü êóðñîð, ïåðåä òåì êàê ñíîâà îòêðûòü åãî.
        Êóðñîð äëÿ öèêëà FOR îòêðûâàåòñÿ àâòîìàòè÷åñêè , ïîýòîìó âû íå ìîæåòå âûïîëíèòü êópñîðíûé öèêë ïî óæå îòêðûòîìó êóðñîðó. 
DUP_VAL_ON_INDEX âûçûâàåòñÿ ïðè ïîïûòêå ñîõðàíèòü íåñêîëüêî îäèíàêîâûõ çíà÷åíèé â êîëîíêó òàáëèöû, êîãäà íà äàííóþ êîëîíêó 
                 óñòàíîâëåí óíèêàëüíûé èíäåêñ.
INVALID_CURSOR âûçûâàåòñÿ ,åñëè âû ïûòàåòåñü âûïîëíèòü íåêîððåêòíóþ îïåðàöèþ ñ êóðñîðîì. Íàïðèìåð, INVALID_CURSOR âûçûâàåòñÿ, 
                åñëè âû ïûòàåòåñü çàêðûòü åùå íå îòêðûòûé êóðñîð.
INVALID_NUMBER âûçûâàåòñÿ â SQL âûðàæåíèÿõ, êîãäà íå ïîëó÷àåòñÿ êîððåêòíî êîíâåðòèðîâàòü ñòðîêó â ÷èñëî , ïîòîìó ÷òî ñòðîêà 
                íå ïðåîáðàçóåòñÿ êîððåêòíî â ÷èñëî. Íàïðèìåð, ñëåäóþùåå âûðàæåíèå INSERT âûçûâàåò INVALID_NUMBER êîãäà Oracle 
                ïûòàåòñÿ ïðåîáðàçîâàòü ñòðîêó 'HALL' â ÷èñëî:


INSERT INTO emp (empno, ename, deptno) VALUES ('HALL', 7888, 20);
 Ñëåäóåò ïîìíèòü, ÷òî ïðîöåäóðíûõ âûðàæåíèÿõ âûçûâàåòñÿ èñêëþ÷åíèå VALUE_ERROR .
LOGIN_DENIED âûçûâàåòñÿ åñëè âû ïûòàåòåñü ñîåäèíèòñÿ ñ Oracle ñ íåïðàâèëüíûì èìåíåì ïîëüçîâàòåëÿ èëè ïàðîëåì.
NO_DATA_FOUND âûçûâàåòñÿ åñëè â âûðàæåíèå SELECT INTO íå âîçâðàùàåò íè îäíîé ñòðîêè èëè åñëè âû îáðàùàåòåñü ê íåóñòàíîâëåííîé ñòðîêå â PL/SQL òàáëèöå. Âûðàæåíèå FETCH â ñëó÷àå êîãäà íå âûáðàíî ñòðîê, âûïîëíÿåòñÿ óñïåøíî, íå âûçûâàÿ èñêëþ÷åíèÿ.

Ãðóïïîâûå âûðàæåíèÿ SQL ,òàêèå êàê AVG è SUM âñåãäà âîçâðàùàþò çíà÷åíèå èëè null. Òàê, âûðàæåíèå SELECT INTO statement ñ ãðóïïîâîé ôóíêöèåé íèêîãäà íå âûçîâåò èñêëþ÷åíèå NO_DATA_FOUND.

NOT_LOGGED_ON âûçûâàåòñÿ åñëè âû â PL/SQL ïðèëîæåíèè îáðàùàåòåñü ê áàçå äàííûõ áåç ïðåäâàðèòåëüíîãî ñîåäèíåíèÿ ñ Oracle.
PROGRAM_ERROR âûçûâàåòñÿ åñëè â PL/SQL ïðè âíóòðåííèèõ ñòðóêòóðíûõ îøèáêàõ.
ROWTYPE_MISMATCH âûçûâàåòñÿ , êîãäà êóðñîð èëè âûðàæåíèå PL/SQL âû ïûòàåòåñü ïðåîáðàçîâàòü ê ïåðåìííîé íåñîâìåñòèìîãî òèïà. 
Íàïðèìåð, êîãäà âû îòêðûëè êóðñîð â õðàíèìîé ïðîöåäóðå, åñëè âîçâðàùàåìûé òèï èìååò íåñîâìåòèìûé ôîðìàò ïàðàìåòðîâ, PL/SQL âûçûâàåò ROWTYPE_MISMATCH.
STORAGE_ERROR âûçûâàåòñÿ åñëè PL/SQL íå õâàòåò îïåðàòèâíîé ïàìÿòè èëè â îïðàòèâíîé ïàìÿòè åñòü ïîâðåæäåííûå áëîêè.
TIMEOUT_ON_RESOURCE âûçâàåòñÿ êîãäà ïðåâûøåí èíòåðâàë îæèäàíèÿ Oracle íåîáõîäèìîãî ðåñóðñà.
TOO_MANY_ROWS âûçûâàåòñÿ åñëè â âûðàæåíèå SELECT INTO âîçâðàùàåòñÿ áîëåå îäíîé ñòðîêè.
VALUE_ERROR âîçíèêàåò â îïåðàöèÿõ ïðåîáðàçîâàíèÿ, ìàòåìàòè÷åñêèõ îïåðàöèÿõ, èëè êîãäà íå ñîâïàäàåò ðàçìåðíîñòü òèïîâ. Íàïðèìåð, êîãäà âû âûáèðàåòå çíà÷åíèå êîëîíêè ñòðîêó, è åñëè äëèíà ïåðåìåííî ìåíüøå ðàçìåðíîñòè äàííîé ñòðîêè, PL/SQL ïðåðûâàåò âûïîëíåíèå ïðîãðàììû èñêëþ÷åíèåì VALUE_ERROR.
Â ïðîöåäóðíûõ âûðàæåíèÿõ, VALUE_ERROR âûçûâàåòñÿ åñëè ïðåîáðàçîâàíèå ñòðîêè â ÷èñëî îøèáî÷íî. Íàïðèìåð, ñëåäóþùåå âûðàæåíèå âûçûâàåò VALUE_ERROR êîãäà PL/SQL ïûòàåòñÿ ïðåîáðàçîâàòü ñòðîêó 'HALL' â ÷èñëî:
â âûðàæåíèÿõ SQL âûçûâàåòñÿ èñêëþ÷åíèå INVALID_NUMBER 
ZERO_DIVIDE âûçûâàåòñÿ ïðè ïîïûòêå äåëåíèÿ íà íîëü.

êàê ýòî èñïîëüçîâàòü èñêëþ÷åíèÿ â ïðîãðììíîì êîäå

Ôóíêöèÿ SQLERRM âîçâðàùàåò ñîîáùåíèå îá îøèáêå ñâÿçàííîå ñ ïîñëåäíèì âîçíèêøèì èñêëþ÷åíèåì (îøèáêîé).
Ôóíêöèÿ SQLERRM  íå èìååò ïàðàìåòðîâ.

Ôóíêöèÿ SQLCODE âîçâðàùàåò êîä îøèáêè ñâÿçàííûé ñ ïîñëåäíèì âîçíèêøèì èñêëþ÷åíèåì (îøèáêîé)

*/

-- Îáû÷íî îáðàáîòêà èñêëþ÷åíèé EXCEPTION âûãëÿäèò ñëåäóþùèì îáðàçîì:
EXCEPTION
   WHEN íàèìåíîâàíèå_îøèáêè_1 THEN
      [statements]

   WHEN íàèìåíîâàíèå_îøèáêè_2 THEN
      [statements]

   WHEN íàèìåíîâàíèå_îøèáêè_N THEN
      [statements]

   WHEN OTHERS THEN
      [statements]

END [íàèìåíîâàíèå_ïðîöåäóðû];

--------------------------------------------
-- ïðèìåðû
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
  WHEN ZERO_DIVIDE THEN dbms_output.put_line('äåëåíèå íà 0 '||SQLCODE ||' '||SQLERRM );
  WHEN VALUE_ERROR THEN dbms_output.put_line('îøèáêà ïðåîáðàçîâàíèÿ  '||SQLCODE||' '||SQLERRM  );
  WHEN OTHERS  THEN  dbms_output.put_line('åùå êàêàÿ òî îøèáêà '||SQLCODE ||' '||SQLERRM );
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
  when ZERO_DIVIDE then dbms_output.put_line('äåëåíèå íà 0 '||SQLCODE ||' '||SQLERRM );
  when VALUE_ERROR then dbms_output.put_line('îøèáêà ïðåîáðàçîâàíèÿ  '||SQLCODE||' '||SQLERRM  );
  when others  then  dbms_output.put_line('åùå êàêàÿ òî îøèáêà '||SQLCODE ||' '||SQLERRM );
end;

--------------------------------------------------------------------------------------------------------------------------------
    Run-time errors arise from design faults, coding mistakes, hardware failures, and many other sources. Although you cannot 
anticipate all possible errors, you can plan to handle certain kinds of errors meaningful to your PL/SQL program.
    Îøèáêè âî âðåìÿ âûïîëíåíèÿ âîçíèêàþò èç-çà îøèáîê ïðîåêòèðîâàíèÿ, îøèáîê êîäèðîâàíèÿ, àïïàðàòíûõ ñáîåâ è ìíîãèõ äðóãèõ èñòî÷íèêîâ. 
Õîòÿ âû íå ìîæåòå ïðåäâèäåòü âñå âîçìîæíûå îøèáêè, âû ìîæåòå ñïëàíèðîâàòü îáðàáîòêó îïðåäåëåííûõ òèïîâ îøèáîê, çíà÷èìûõ äëÿ âàøåé ïðîãðàììû PL/SQL.

    In the PL/SQL language, errors of any kind are treated as exceptions - situations that should not occur.
An exception can be one of the following:
- an error generated by the system (such as "out of memory" or "duplicate value in index")
- an error caused by a user action
- a warning issued by the application to the user.
    Â ÿçûêå PL/SQL îøèáêè ëþáîãî ðîäà ðàññìàòðèâàþòñÿ êàê èñêëþ÷åíèÿ - ñèòóàöèè, êîòîðûå íå äîëæíû âîçíèêàòü.
Èñêëþ÷åíèåì ìîæåò áûòü îäíî èç ñëåäóþùèõ:
- îøèáêà, ñãåíåðèðîâàííàÿ ñèñòåìîé (íàïðèìåð, "íå õâàòàåò ïàìÿòè" èëè "ïîâòîðÿþùååñÿ çíà÷åíèå â èíäåêñå")
- îøèáêà, âûçâàííàÿ äåéñòâèåì ïîëüçîâàòåëÿ
- ïðåäóïðåæäåíèå, âûäàííîå ïðèëîæåíèåì ïîëüçîâàòåëþ

    PL/SQL traps and responds to errors using an architecture of exception handlers. The exception-handler mechanism allows you 
to cleanly separate your error processing code from your executable statements. It also provides an event-driven model, as 
opposed to a linear code model, for processing errors. In other words, no matter how a particular exception is raised, it is 
handled by the same exception handler in the exception section.
    PL/SQL óëàâëèâàåò îøèáêè è ðåàãèðóåò íà íèõ, èñïîëüçóÿ àðõèòåêòóðó îáðàáîò÷èêîâ èñêëþ÷åíèé. Ìåõàíèçì îáðàáîòêè èñêëþ÷åíèé 
ïîçâîëÿåò âàì ÷åòêî îòäåëÿòü âàø êîä îáðàáîòêè îøèáîê îò âàøèõ èñïîëíÿåìûõ èíñòðóêöèé. Îí òàêæå ïðåäîñòàâëÿåò óïðàâëÿåìóþ 
ñîáûòèÿìè ìîäåëü, â îòëè÷èå îò ëèíåéíîé ìîäåëè êîäà, äëÿ îáðàáîòêè îøèáîê. Äðóãèìè ñëîâàìè, íåçàâèñèìî îò òîãî, êàê ñîçäàåòñÿ 
êîíêðåòíîå èñêëþ÷åíèå, îíî îáðàáàòûâàåòñÿ îäíèì è òåì æå îáðàáîò÷èêîì èñêëþ÷åíèé â ðàçäåëå èñêëþ÷åíèé.

    When an error occurs in PL/SQL, whether a system error or an application error, an exception is raised. The processing in 
the current PL/SQL blocks execution section halts and control is transferred to the separate exception section of your program, 
if one exists, to handle the exception. You cannot return to that block after you finish handling the exception. Instead, 
control is passed to the enclosing block, if any.
    Ïðè âîçíèêíîâåíèè îøèáêè â PL/SQL, áóäü òî ñèñòåìíàÿ îøèáêà èëè îøèáêà ïðèëîæåíèÿ, âîçíèêàåò èñêëþ÷åíèå. Îáðàáîòêà â ðàçäåëå 
âûïîëíåíèÿ òåêóùåãî áëîêà PL/SQL îñòàíàâëèâàåòñÿ, è óïðàâëåíèå ïåðåäàåòñÿ â îòäåëüíûé ðàçäåë èñêëþ÷åíèÿ âàøåé ïðîãðàììû, åñëè 
òàêîâîé ñóùåñòâóåò, äëÿ îáðàáîòêè èñêëþ÷åíèÿ. Âû íå ìîæåòå âåðíóòüñÿ ê ýòîìó áëîêó ïîñëå çàâåðøåíèÿ îáðàáîòêè èñêëþ÷åíèÿ. 
Âìåñòî ýòîãî óïðàâëåíèå ïåðåäàåòñÿ âêëþ÷àþùåìó áëîêó, åñëè òàêîâîé èìååòñÿ.

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

Â PL/SQL ñóùåñòâóåò ÷åòûðå âèäà èñêëþ÷åíèé:

- èìåíîâàííûå ñèñòåìíûå èñêëþ÷åíèÿ - èñêëþ÷åíèÿ, êîòîðûì PL/SQL ïðèñâîèë èìåíà è êîòîðûå âîçíèêëè â ðåçóëüòàòå îøèáêè ïðè 
îáðàáîòêå PL/SQL èëè ÑÓÁÄ.
- èìåíîâàííûå èñêëþ÷åíèÿ, îïðåäåëÿåìûå ïðîãðàììèñòîì - èñêëþ÷åíèÿ, êîòîðûå âîçíèêàþò â ðåçóëüòàòå îøèáîê â êîäå âàøåãî ïðèëîæåíèÿ. 
Âû äàåòå ýòèì èñêëþ÷åíèÿì èìåíà, îáúÿâëÿÿ èõ â ðàçäåëå îáúÿâëåíèÿ. Çàòåì âû âûçûâàåòå èñêëþ÷åíèÿ ÿâíî â ïðîãðàììå.
- áåçûìÿííûå ñèñòåìíûå èñêëþ÷åíèÿ - èñêëþ÷åíèÿ, êîòîðûå âîçíèêàþò â ðåçóëüòàòå îøèáêè ïðè îáðàáîòêå PL/SQL èëè ÑÓÁÄ, íî 
êîòîðûì PL/SQL íå ïðèñâîèë èìåí. Òàê íàçûâàþòñÿ òîëüêî íàèáîëåå ðàñïðîñòðàíåííûå îøèáêè.;
îñòàëüíûå èìåþò íîìåðà, è èì ìîãóò áûòü ïðèñâîåíû èìåíà ñ ïîìîùüþ ñïåöèàëüíîãî ñèíòàêñèñà PRAGMA EXCEPTION_INIT.
- íåíàçâàííûå èñêëþ÷åíèÿ, îïðåäåëåííûå ïðîãðàììèñòîì - èñêëþ÷åíèÿ, êîòîðûå îïðåäåëÿþòñÿ è âûçûâàþòñÿ íà ñåðâåðå ïðîãðàììèñòîì. 
Â ýòîì ñëó÷àå ïðîãðàììèñò ïðåäîñòàâëÿåò êàê íîìåð îøèáêè (îò -20000 äî - 20999), òàê è ñîîáùåíèå îá îøèáêå è âûçûâàåò ýòî 
èñêëþ÷åíèå ñ ïîìîùüþ âûçîâà RAISE_APPLICATION_ERROR. Ýòà îøèáêà âìåñòå ñ åå ñîîáùåíèåì ïåðåäàåòñÿ îáðàòíî â êëèåíòñêîå ïðèëîæåíèå.

    The system exceptions (both named and unnamed) are raised by PL/SQL whenever a program violates a rule in the RDBMS or 
causes a resource limit to be exceeded. Each of these RDBMS errors has a number associated with it. In addition, PL/SQL 
predefines names for some of the most commonly encountered errors.
    Ñèñòåìíûå èñêëþ÷åíèÿ (êàê èìåíîâàííûå, òàê è íåíàçâàííûå) âûçûâàþòñÿ PL/SQL âñÿêèé ðàç, êîãäà ïðîãðàììà íàðóøàåò ïðàâèëî 
â ÑÓÁÄ èëè ïðèâîäèò ê ïðåâûøåíèþ ëèìèòà ðåñóðñîâ. Êàæäàÿ èç ýòèõ îøèáîê ÑÓÁÄ èìååò ñâÿçàííûé ñ íåé íîìåð. Êðîìå òîãî, PL/SQL 
ïðåäîïðåäåëÿåò èìåíà äëÿ íåêîòîðûõ íàèáîëåå ÷àñòî âñòðå÷àþùèõñÿ îøèáîê.

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
    WHEN    OTHERS  -- The WHEN OTHERS clause is used to trap all remaining exceptions (ïåðåõâàòà âñåõ îñòàâøèõñÿ)
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
    Èñêëþ÷åíèÿ, îáúÿâëåííûå PL/SQL â ÑÒÀÍÄÀÐÒÍÎÌ ïàêåòå, îõâàòûâàþò âíóòðåííèå
èëè ñèñòåìíûå îøèáêè. Îäíàêî ìíîãèå ïðîáëåìû, ñ êîòîðûìè ïîëüçîâàòåëü ñòîëêíåòñÿ (èëè âûçîâåò) â
ïðèëîæåíèè, ñïåöèôè÷íû äëÿ ýòîãî ïðèëîæåíèÿ. Âàøåé ïðîãðàììå ìîæåò ïîòðåáîâàòüñÿ
ïåðåõâàòûâàòü è îáðàáàòûâàòü òàêèå îøèáêè, êàê "îòðèöàòåëüíûé áàëàíñ íà ñ÷åòå" èëè "äàòà âûçîâà íå ìîæåò áûòü
â ïðîøëîì". Íåñìîòðÿ íà òî, ÷òî ýòè îøèáêè îòëè÷àþòñÿ ïî ñâîåé ïðèðîäå îò "äåëåíèÿ íà íîëü", îíè ïî-ïðåæíåìó
ÿâëÿþòñÿ èñêëþ÷åíèÿìè èç îáû÷íîé îáðàáîòêè è äîëæíû êîððåêòíî îáðàáàòûâàòüñÿ âàøåé ïðîãðàììîé.
    
    Of course, to handle an exception, you must have a name for that exception.
Because PL/SQL cannot name these exceptions for you (they are specific to your
application), you must do so yourself by declaring an exception in the declaration
section of your PL/SQL block.
    Êîíå÷íî, ÷òîáû îáðàáîòàòü èñêëþ÷åíèå, ó âàñ äîëæíî áûòü èìÿ äëÿ ýòîãî èñêëþ÷åíèÿ.
Ïîñêîëüêó PL / SQL íå ìîæåò íàçâàòü ýòè èñêëþ÷åíèÿ äëÿ âàñ (îíè ñïåöèôè÷íû äëÿ âàøåãî
ïðèëîæåíèÿ), âû äîëæíû ñäåëàòü ýòî ñàìîñòîÿòåëüíî, îáúÿâèâ èñêëþ÷åíèå â ðàçäåëå îáúÿâëåíèÿ
âàøåãî áëîêà PL / SQL.

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
    Òàêîãî ðîäà èñêëþ÷åíèÿ âîçíèêàþò, êîãäà âàì íóæíî âûçâàòü îøèáêó, îòíîñÿùóþñÿ ê êîíêðåòíîìó ïðèëîæåíèþ, 
ñ ñåðâåðà è ïåðåäàòü ýòó îøèáêó îáðàòíî â ïðîöåññ êëèåíòñêîãî ïðèëîæåíèÿ.
×òîáû ñäåëàòü ýòî, âàì íóæåí ñïîñîá èäåíòèôèöèðîâàòü îøèáêè, îòíîñÿùèåñÿ ê êîíêðåòíîìó ïðèëîæåíèþ, è âîçâðàùàòü èíôîðìàöèþ
îá ýòèõ îøèáêàõ îáðàòíî êëèåíòó.

    Oracle provides a special procedure to allow communication of an unnamed, yet programmer-defined, server-side exception: RAISE_APPLICATION_ERROR.
    Oracle ïðåäîñòàâëÿåò ñïåöèàëüíóþ ïðîöåäóðó, ïîçâîëÿþùóþ ïåðåäàâàòü íåíàçâàííîå, íî îïðåäåëåííîå ïðîãðàììèñòîì èñêëþ÷åíèå íà 
ñòîðîíå ñåðâåðà: RAISE_APPLICATION_ERROR.

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
--      SCOPE OF AN EXCEPTION AND PROPAGATION (ÎÁËÀÑÒÜ ÄÅÉÑÒÂÈß ÈÑÊËÞ×ÅÍÈß È ÐÀÑÏÐÎÑÒÐÀÍÅÍÈÅ)
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

    Îáëàñòü äåéñòâèÿ èñêëþ÷åíèÿ - ýòî òà ÷àñòü êîäà, êîòîðàÿ "îõâà÷åíà" ýòèì èñêëþ÷åíèåì.
Èñêëþ÷åíèå ðàñïðîñòðàíÿåòñÿ íà áëîê êîäà, åñëè îíî ìîæåò áûòü âûçâàíî â ýòîì áëîêå.

    Èìåíîâàííûå ñèñòåìíûå èñêëþ÷åíèÿ - ýòè èñêëþ÷åíèÿ äîñòóïíû âî âñåì ìèðå, ïîñêîëüêó îíè íå
îáúÿâëåíû â êàêîì-ëèáî êîíêðåòíîì áëîêå êîäà è íå îãðàíè÷åíû èì. Âû ìîæåòå âûçâàòü è îáðàáîòàòü èìåíîâàííîå
ñèñòåìíîå èñêëþ÷åíèå â ëþáîì áëîêå.

    Èìåíîâàííûå èñêëþ÷åíèÿ, îïðåäåëÿåìûå ïðîãðàììèñòîì. Ýòè èñêëþ÷åíèÿ ìîãóò âûçûâàòüñÿ è îáðàáàòûâàòüñÿ òîëüêî â
ðàçäåëàõ âûïîëíåíèÿ è èñêëþ÷åíèÿ áëîêà, â êîòîðîì îíè îáúÿâëåíû (è âî âñåõ âëîæåííûõ
áëîêàõ).

    Íåíàçâàííûå ñèñòåìíûå èñêëþ÷åíèÿ - ýòè èñêëþ÷åíèÿ ìîãóò áûòü îáðàáîòàíû â ëþáîì ðàçäåëå èñêëþ÷åíèé PL/SQL
÷åðåç ðàçäåë WHEN OTHERS. Åñëè èì ïðèñâîåíî èìÿ, òî îáëàñòü äåéñòâèÿ ýòîãî
èìåíè òàêàÿ æå, êàê è ó èìåíîâàííîãî èñêëþ÷åíèÿ, îïðåäåëåííîãî ïðîãðàììèñòîì.

    Íåíàçâàííûå èñêëþ÷åíèÿ, îïðåäåëåííûå ïðîãðàììèñòîì. Ýòî èñêëþ÷åíèå îïðåäåëÿåòñÿ òîëüêî ïðè âûçîâå
RAISE_APPLICATION_ERROR, à çàòåì ïåðåäàåòñÿ îáðàòíî âûçûâàþùåé ïðîãðàììå. */

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
    Êîãäà âîçíèêàåò èñêëþ÷åíèå, PL/SQL èùåò îáðàáîò÷èê èñêëþ÷åíèÿ â òåêóùåì áëîêå (àíîíèìíûé áëîê,
ïðîöåäóðà èëè ôóíêöèÿ) äëÿ ýòîãî èñêëþ÷åíèÿ. Åñëè îí íå íàõîäèò ñîâïàäåíèÿ, òî PL/SQL ðàñïðîñòðàíÿåò èñêëþ÷åíèå íà
çàêëþ÷àþùèé áëîê ýòîãî òåêóùåãî áëîêà. Çàòåì PL/SQL ïûòàåòñÿ îáðàáîòàòü èñêëþ÷åíèå, âûçûâàÿ ýòî
èñêëþ÷åíèå åùå ðàç âî âêëþ÷àþùåì áëîêå. Îí ïðîäîëæàåò äåëàòü ýòî â êàæäîì ïîñëåäóþùåì âêëþ÷àþùåì áëîêå äî òåõ ïîð, ïîêà íå îñòàíåòñÿ
áîëüøå áëîêîâ, â êîòîðûõ ìîæíî âûçâàòü èñêëþ÷åíèå.
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

-- Êîãäà âû íàõîäèòåñü âíóòðè îáðàáîò÷èêà èñêëþ÷åíèé â ðàçäåëå èñêëþ÷åíèé, âû ìîæåòå ïîâòîðíî âûçâàòü èñêëþ÷åíèå, 
-- êîòîðîå "ïðèâåëî âàñ òóäà", âûäàâ íåêâàëèôèöèðîâàííûé îïåðàòîð RAISE
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
    Âû ìîæåòå èñïîëüçîâàòü ïðåäëîæåíèå WHEN OTHERS â ðàçäåëå exception , ÷òîáû ïåðåõâàòûâàòü âñå íåîáðàáîòàííûå èñêëþ÷åíèÿ, 
âêëþ÷àÿ âíóòðåííèå îøèáêè, êîòîðûå íå ïðåäîïðåäåëåíû PL/SQL. Îäíàêî, îêàçàâøèñü âíóòðè îáðàáîò÷èêà èñêëþ÷åíèé, âû ÷àñòî çàõîòèòå 
óçíàòü, êàêàÿ îøèáêà ïðîèçîøëà. Ìû ìîæåì èñïîëüçîâàòü SQL-ÊÎÄ è Ôóíêöèè SQLERRM äëÿ ïîëó÷åíèÿ ýòîé èíôîðìàöèè.
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
/* Â PL SQL ïðåäîñòàâëÿåò âîçìîæíîñòü ãàðìîíè÷íî ãðóïïèðîâàòü ïðîãðàììíûå åäèíèöû  ïðîöåäóðû è ôóíêöèè.
Òàêàÿ âîçìîæíîñòü ïîçâîëÿþò îñóùåñòâèòü ñïåöèàëüíûå êîíñòðóêöèè ïàêåòû èëè ìîäóëè.
Òàê æå â ïàêåòàõ PL SQL îáúÿâëåíèÿ, ïðîöåäóð ôóíêöèé, ïåðåìåííûõ îòäåëåíû îò ðåàëèçàöèè.
Äîïîëíèòåëüíî ïàêåòû ðåàëèçóþò ñâîåîáðàçíóþ èíêàïñóëÿöèþ PL SQL êîäà, ÷àñòü êîäà ïóáëè÷íàÿ îòäåëåíà îò âíóòðåííåé ðåàëèçàöèè.
Âûçûâàåìûå, ïóáëè÷íûå ïðîöåäóðû ôóíêöèè è ïåðåìåííûå îïèñûâàþòñÿ â ñïåöèôèêàöèè ïàêåòà, à èõ ðåàëèçàöèÿ, 
âíóòðåííèå ïðîãðàììíîå óñòðîéñòâî â òåëå ïàêåòà.
Ìîæíî âûçûâàòü ïðîöåäóðû è ôóíêöèè ïàêåòà, îáúÿâëåííûå â ñïåöèôèêàöèè ïàêåòà èç äðóãèõ ïàêåòîâ, äðóãèõ ïðîöåäóð, 
ôóíêöèè èç SQL, à òàê æå èç àíîíèìíûõ PL SQL ïîäïðîãðàìì.
Private - îïðåäåëÿåòñÿ òîëüêî â òåëå ïàêåòà, íî íå îòîáðàæàåòñÿ â ñïåöèôèêàöèè.
Íà çàêðûòûé ýëåìåíò íåëüçÿ ññûëàòüñÿ âíå ïàêåòà. Îäíàêî ëþáîé äðóãîé ýëåìåíò
ïàêåòà ìîæåò ññûëàòüñÿ íà çàêðûòûé ýëåìåíò è èñïîëüçîâàòü åãî. ×àñòíûå ýëåìåíòû â ïàêåòå
äîëæíû áûòü îïðåäåëåíû, ïðåæäå ÷åì íà íèõ ñìîãóò ññûëàòüñÿ äðóãèå ýëåìåíòû ïàêåòà. Åñëè, äðóãèìè
ñëîâàìè, îáùåäîñòóïíàÿ ïðîöåäóðà âûçûâàåò çàêðûòóþ ôóíêöèþ, ýòà ôóíêöèÿ äîëæíà áûòü îïðåäåëåíà íàä
îáùåäîñòóïíîé ïðîöåäóðîé â òåëå ïàêåòà.
*/

--ñèíòàêñèñ
  PACKAGE èìÿ IS  -- ñïåöèôèêàöèÿ (âèäèìàÿ ÷àñòü)
            -- îáúÿâëåíèÿ ïóáëè÷íûõ òèïîâ è îáúåêòîâ, ïåðåìåííûõ , êîíñòàíò
            -- ñïåöèôèêàöèè ïîäïðîãðàìì
        END [èìÿ];

        PACKAGE BODY èìÿ IS  -- òåëî (ñêðûòàÿ ÷àñòü)
            -- îáúÿâëåíèÿ âíóòðåííèõ òèïîâ è îáúåêòîâ
            -- òåëà ïîäïðîãðàìì
        [BEGIN
            -- ïðåäëîæåíèÿ èíèöèàëèçàöèè]
        END [èìÿ];

-- Ïðèìåð
CREATE OR REPLACE PACKAGE pck_test 
IS
  gr_test   NUMBER := 10;
  gc_cr     CONSTANT VARCHAR2(30) := 'test'; -- êîíñòàíòà ìåíÿòü íåëüçÿ
  PROCEDURE pr_test; -- ïóáëè÷íàÿ ïðîöåäóðà 
  FUNCTION get_gr return number; -- ïóáëè÷íàÿ ôóíêöèÿ
--->
END;

CREATE OR REPLACE PACKAGE BODY pck_test 
IS
    gc_div constant VARCHAR2(30) := '**********************';
    
    PROCEDURE pr_print(v VARCHAR2) -- âíóòðåííÿ ïðîöåäóðà
    IS
    BEGIN 
        dbms_output.put_line(v);
    END;    
  
    FUNCTION get_gr RETURN NUMBER -- -- ïóáëè÷íàÿ ôóíêöèÿ , åñòü â ñïåöèôèêàöèè
    IS
    BEGIN 
        return gr_test;
    END;    

    PROCEDURE pr_test IS -- ïóáëè÷íàÿ ïðîöåäóðà , åñòü â ñïåöèôèêàöèè
        a_test      VARCHAR2(100);
    BEGIN
        pr_print('gc_cr =');
        pr_print(to_char(gc_cr));
        pr_print('gr_test=');
        pr_print(to_char(get_gr));    
        pr_print(gc_div);    
    End;
BEGIN 
    pck_test.gr_test := gr_test*10; -- èíèöèàëèçàöèÿ
END;

-- Âûçîâ 
begin
  pck_test.pr_test;
  dbms_output.put_line( pck_test.get_gr);
end;
-- èëè â SQL
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
-- Its typically used to enforce extra security measures on the kind of transaction that may be performed on a table.

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


