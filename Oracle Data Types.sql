-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Section 11. Oracle Data Type. --
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
Oracle data types --– give you an overview of the built-in Oracle data types.
NUMBER --– introduces you to the numeric data type and show you how to use it to define numeric columns for a table.
FLOAT --– demystify float data type in Oracle by practical examples.
CHAR --– learn about fixed-length character string.
NCHAR --–  show you how to store fixed-length Unicode character data and explain the differences between CHAR and NCHAR data types
VARCHAR2-- – introduce you to the variable-length character and show you how to define variable-length character columns in a table.
NVARCHAR2 --– learn how to store variable-length Unicode characters in the database.
DATE --– discuss the date and time data type and show you how to handle date-time data effectively.
TIMESTAMP --– introduce you how to store date and time with the fractional seconds precision.
INTERVAL --– focus on the interval data types to store periods of time.
TIMESTAMP WITH TIME ZONE --– learn how to store datetime with timezone data.
------------------------------------------------------------------------------------------------------------------------------
                                    MIN    MAX   
1	VARCHAR2(size [BYTE | CHAR])
1	NVARCHAR2(size)
96	CHAR [(size [BYTE | CHAR])]
96	NCHAR[(size)]
2	NUMBER[(precision [, scale])]    1       38
8	LONG
12	DATE
    FLOAT                            1      126
21	BINARY_FLOAT
22	BINARY_DOUBLE
23	RAW(size)   - up to 2000 bytes
24	LONG RAW    - up to 2GB
69	ROWID
112	CLOB
112	NCLOB
113	BLOB
114	BFILE
180	TIMESTAMP [(fractional_seconds)]
181	TIMESTAMP [(fractional_seconds)] WITH TIME ZONE
182	INTERVAL YEAR [(year_precision)] TO MONTH
183	INTERVAL DAY [(day_precision)] TO SECOND[(fractional_seconds)]
208	UROWID [(size)]
231	TIMESTAMP [(fractional_seconds)] WITH LOCAL TIMEZONE


---------------------------------------------------------------------------
---------------------------------------------------------------------------
--  Oracle NUMBER Data Type
---------------------------------------------------------------------------
NUMBER[(precision [, scale])]
------------------------------
-- precision 1...38
-- scale -84...127

CREATE TABLE number_demo ( 
    number_6_2 NUMBER(6, 2), 
    number_leir NUMBER,
    number_4 NUMBER(4),
    number_4_0 NUMBER(4,0)    
);

INSERT INTO number_demo
VALUES (1234.1234,  -- number_6_2   1234.12
        345354340.2454786,   -- number_leir = MAX SIZE    3450.2
        1234.67,     -- number_4    1234
        1234.123 );  -- number_4_0  1234

SELECT * FROM number_demo;


DROP TABLE number_demo;
CREATE TABLE number_demo ( 
    number_value NUMERIC(6, 2) 
);
INSERT INTO number_demo
VALUES(100.99); -- Ok
INSERT INTO number_demo
VALUES(90.551); -- 90.55   !!!!!
INSERT INTO number_demo
VALUES(87.556); -- 87.56   !!!!!
INSERT INTO number_demo
VALUES(9999.99); -- 9999.99 Ok
INSERT INTO number_demo
VALUES(-9999.99); -- -9999.99 Ok

INSERT INTO number_demo
VALUES(-10000);  --  ORA-01438: value larger than specified precision allowed for this column
INSERT INTO number_demo
VALUES(9999.999);  --  ORA-01438: value larger than specified precision allowed for this column

SELECT * FROM number_demo;

----------------------------------------------
-- FLOAT
----------------------------------------------

FLOAT(p)   -- max 127

-- In FLOAT, the precision is in BINARY bits
-- You use the following formula to convert between BINARY and decimal precision:

P(d) = 0.30103 * P(b)

DROP TABLE float_demo;
CREATE TABLE float_demo ( f1 FLOAT(1),  f2 FLOAT(2),  f3 FLOAT(3), f4 FLOAT(4),  f5 FLOAT(5), f6 FLOAT(6), f7 FLOAT(7));

INSERT INTO  float_demo ( f1,           f2,           f3,          f4,           f5,          f6,          f7 )
    VALUES( 1/3, 1/3, 1/3,  1/3, 1/3, 1/3, 1/3);
SELECT * FROM float_demo;


-----------------------------------
-- Oracle CHAR
-----------------------------------
-- CHAR data type which is a FIXED-LENGTH character string type. 
-- (Oracle PADS the spaces to the character string up TO THE MAXIMUM LENGTH)
-- The CHAR data type can store a character string with the size from 1 to 2000 BYTES.

CHAR(length BYTE)  --  1 to 2000 BYTES
CHAR(length CHAR)

-- If you don’t explicitly specify BYTE or CHAR followed the length, Oracle uses the BYTE by default.
-- The default value of length is 1 if you skip it like the following example:

column_name CHAR(5)  -- Defoult: 5 BYTEs
column_name CHAR     -- Defoult: 1 BYTEs

-- Oracle CHAR examples

-- A) Space usage example
CREATE TABLE t (
    x CHAR(10),
    y VARCHAR2(10)
);
INSERT INTO t(x, y ) VALUES('Oracle', 'Oracle')
;
SELECT * FROM t
;
--  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!    DUMP DUMP DUMP DUMP DUMP DUMP DUMP DUMP DUMP !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT x, DUMP(x),
       y, DUMP(y)
FROM t;
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT
    LENGTHB(x),
    LENGTHB(y)
FROM t;

SELECT * FROM t WHERE x = 'Oracle';
SELECT * FROM t WHERE y = 'Oracle';

-- B) Characters comparison example

-- The following statements return the same result:
SELECT * FROM t WHERE x = 'Oracle';
SELECT * FROM t WHERE y = 'Oracle';

-- However, if you use bind variables, the effect is different. Consider the following example:
variable v varchar2(10)
exec :v := 'Oracle';  --  PL/SQL procedure successfully completed.

select * from t where x = :v;  --  no rows selected
-- The statement returned an empty result set.

-- The following query uses the v variable to compare with the y column:
select * from t where y = :v;

-- To make it work, you need to use the RTRIM() function to strip spaces from the CHAR data

select * from t where rtrim(x) = :v;


-----------------------------------------------------------------------------------------------------------------------
--  NCHAR  -- 
-----------------------------------------------------------------------------------------------------------------------

-- The Oracle NCHAR datatype is used to store fixed-length Unicode character data. 
-- The character set of NCHAR can only be AL16UTF16 or UTF8

-- !!!!!! When you create a table with an NCHAR column, the MAXIMUM size is always in the CHARACTER LENGTH SEMANTICS !!!!!!!

CREATE TABLE nchar_demo (
    description NCHAR(10)
);    --  It is not possible to use the byte length for maximum size of the NCHAR columns 

-- To find the current national character set, you use the following statement:

SELECT  *
FROM    nls_database_parameters
WHERE   PARAMETER = 'NLS_NCHAR_CHARACTERSET';
-- The AL16UTF16 character set uses 2 bytes for storing a character so the description column 
-- has the maximum byte length of 20 bytes.
-- Oracle limits the maximum length of the NCHAR column to 2000 bytes. It means that an NCHAR column 
-- can only hold up to 2000 characters for 1-byte characters or 1000 characters for 2-byte characters.

-- Oracle NCHAR vs. CHAR

-- First, the maximum size of NCHAR is only in the character length semantics while the maximum size of CHAR -
-- can be in either character or byte length semantics.
-- Second, NCHAR stores characters in national default character set whereas the CHAR stores characters in the default character set.
-- The following statement returns the default character set used by CHAR and default national character set used by NCHAR:

--   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  nls_database_parameters  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT  *
FROM    nls_database_parameters
WHERE   PARAMETER IN(
          'NLS_CHARACTERSET',
          'NLS_NCHAR_CHARACTERSET')
; 


---------------------------------------------------------------------------------------------------------------------
--  Oracle VARCHAR2  --
---------------------------------------------------------------------------------------------------------------------
-- from 1 to 4000 bytes. It means that for a single-byte character set, you can store up to 4000 characters in a VARCHAR2 column
-- When you create a table with a VARCHAR2 column, you must specify the maximum string length, either in bytes or in characters:
VARCHAR2(max_size BYTE)  --  By default, Oracle uses BYTE
VARCHAR2(max_size CHAR)

--  When comparing VARCHAR2 values, Oracle uses the non-padded comparison semantics.

-- Oracle VARCHAR2 max length

-- If the MAX_STRING_SIZE is STANDARD, then the maximum size for VARCHAR2 is 4000 bytes. In case, 
-- the MAX_STRING_SIZE is EXTENDED, the size limit for VARCHAR2 is 32767.
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  MAX_STRING_SIZE  °!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT
    name,
    value
FROM
    v$parameter
WHERE
    name = 'max_string_size';
-- OR AS:
SHOW PARAMETER max_string_size;

-- Oracle VARCHAR2 examples

CREATE TABLE econtacts (
    econtact_id NUMBER generated BY DEFAULT AS identity PRIMARY KEY,
    employee_id NUMBER NOT NULL,
    first_name  VARCHAR2( 20 ) NOT NULL,
    last_name   VARCHAR2( 20 ) NOT NULL,
    phone       VARCHAR2( 12 ) NOT NULL,
    FOREIGN KEY( employee_id ) REFERENCES employees( employee_id ) 
        ON  DELETE CASCADE
);  --  Table ECONTACTS created.
INSERT
    INTO
        econtacts(
            employee_id,
            first_name,
            last_name,
            phone
        )
    VALUES(
        1,
        'Branden',
        'Wiley',
        '202-555-0193'
    );  --  1 row inserted.
-- the following statement fails to insert:
INSERT
    INTO
        econtacts(
            employee_id,
            first_name,
            last_name,
            phone
        )
    VALUES(
        10,
        'Pablo Diego Jose Francisco',
        'Gray',
        '202-555-0195'
    ); -- ORA-12899: value too large for column "OT"."ECONTACTS"."FIRST_NAME" (actual: 26, maximum: 20)


---------------------------------------------------------------------------------------------------------------------
--  Oracle NVARCHAR2  
---------------------------------------------------------------------------------------------------------------------
-- To find the character set of the NVARCHAR2 in your database, you use the following query:  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT  *
FROM   nls_database_parameters
WHERE   PARAMETER = 'NLS_NCHAR_CHARACTERSET'
;  --  The AL16UTF16 use 2 bytes to store a character.

-- Oracle NVARCHAR2 examples
CREATE TABLE nvarchar2_demo (
    description NVARCHAR2(50)
);  --  Table NVARCHAR2_DEMO created.
INSERT INTO nvarchar2_demo
VALUES('ABCDE');
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT
    description,
    DUMP(description,1016)
FROM
    nvarchar2_demo;
--  !!!!!!!!!!!!!!!!!!!!!  The following query returns the default character set used by the VARCHAR2 data type. !!!!!!!!!!!!!!
SELECT
  *
FROM
  nls_database_parameters
WHERE
  parameter = 'NLS_CHARACTERSET';


-----------------------------------------------------------------------------------------------------------------------------
--  Oracle DATE
-----------------------------------------------------------------------------------------------------------------------------
-- The DATE data type stores the year (which includes the century), the month, the day, the hours, the minutes, and the seconds.
-- It uses fixed-length fields of 7 bytes

-- Oracle date format - NLS_DATE_FORMAT parameter:   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11!!
SELECT  value  
FROM    V$NLS_PARAMETERS
WHERE   parameter = 'NLS_DATE_FORMAT';  --  DD-MON-RR

SELECT   sysdate  FROM  dual;  --  09-OCT-20

-- Suppose, you want to change the standard date forma
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- Format date using TO_CHAR() function
SELECT TO_CHAR( SYSDATE, 'FMMonth DD, YYYY' )
FROM  dual;  --  October 9, 2020

-- The language that the TO_CHAR()function uses for displaying
SELECT   value
FROM   V$NLS_PARAMETERS
WHERE   parameter = 'NLS_DATE_LANGUAGE';  --  AMERICAN
-- to change the current language
ALTER SESSION SET NLS_DATE_LANGUAGE = 'FRENCH';
SELECT TO_CHAR( SYSDATE, 'FMMonth DD, YYYY' )
FROM  dual;  --  Octobre 9, 2020

ALTER SESSION SET NLS_DATE_LANGUAGE = 'AMERICAN';

-- Convert string to date
SELECT   TO_DATE( 'August 01, 2017', 'MONTH DD, YYYY' )
FROM  dual;  --  2017-08-01

SELECT DATE '2017-08-01'
FROM dual;

--  Oracle DATE data type example

CREATE TABLE my_events (
    event_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    event_name VARCHAR2 ( 255 ) NOT NULL,
    location VARCHAR2 ( 255 ) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    PRIMARY KEY ( event_id ) 
);
INSERT INTO my_events 
            (event_name, location, start_date,  end_date)
VALUES      ( 'TechEd Europe', 'Barcelona, Spain',         DATE '2017-11-14', DATE '2017-11-16' );
INSERT INTO my_events
            (event_name, location, start_date, end_date)
VALUES     ( 'Oracle OpenWorld', 'San Francisco, CA, USA', TO_DATE( 'October 01, 2017', 'MONTH DD, YYYY' ),
            TO_DATE( 'October 05, 2017', 'MONTH DD, YYYY'));
INSERT INTO my_events
                (event_name, location, start_date, end_date)
    VALUES     ( 'TechEd US', 'Las Vegas, NV, USA',        DATE '2017-09-25', DATE '2017-09-29' );

SELECT * FROM my_events;
--  You can, of course, use the TO_CHAR() function to format the dates of events:
SELECT
  event_name, 
  location,
  TO_CHAR( start_date, 'FMMonth DD, YYYY' )  start_date, 
  TO_CHAR( end_date, 'FMMonth DD, YYYY' ) end_date 
from
  my_events;

