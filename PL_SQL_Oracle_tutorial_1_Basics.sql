/* 
PL/SQL is a blocked programming language. Program units can be named or unnamed blocks. 
Unnamed blocks are known as anonymous blocks because it's not going to be saved in the database, so it will never have a name. 
We typically use anonymous blocks when building scripts to seed data or perform one-time processing activities. 
They are also effective when we want to nest activity in another PL/SQL block's execution section.
--
PL/SQL - это заблокированный €зык программировани€. ѕрограммные блоки могут быть именованными или безым€нными блоками. 
Ѕезым€нные блоки называютс€ анонимными блоками, потому что они не будут сохранены в базе данных, поэтому у них никогда не будет имени. 
ќбычно мы используем анонимные блоки при создании сценариев дл€ заполнени€ данных или выполнени€ разовых операций обработки. 
ќни также эффективны, когда мы хотим вложить активность в раздел выполнени€ другого блока PL/SQL
*/

-- Basic anonimous block.
SET SERVEROUTPUT ON
BEGIN
    -- The basic anonymous-block structure must contain an execution section.
    DBMS_OUTPUT.put_line('sasda');
END;

DECLARE
    -- The declaration block lets us define datatypes, structures, and variables. 
    -- Defining a variable means that we give it a name, a datatype, and optionaly, a value.
    var1 INTEGER;
    -- The execution block lets us process data. It can contain variable assignments, comparisons, conditional operations,
    -- and iterations. Also, the execution block is where we access other named program units (e. g. functions, procedures). 
    -- We can also nest anonymous-block programs inside the execution block.
    -- Ѕлок выполнени€ позвол€ет нам обрабатывать данные. ќн может содержать назначени€ переменных, сравнени€, условные операции и итерации.  роме того, блок выполнени€ - это место, где мы получаем доступ к другим именованным 
    -- программным блокам (например, функци€м, процедурам). ћы также можем размещать программы с анонимным блоком внутри блока выполнени€.
BEGIN
    -- Variable names begin with letters and can contain alphabetical characters, ordinal numbers (0 to 9), the $, _, and # symbols.
    -- Variables have local scope only.
    -- ѕеременные имеют только локальную область действи€.
    var1 := 1;
    DBMS_OUTPUT.put_line('Hallo Word!');
END;

DECLARE
    var1 VARCHAR2(6) := 'World!';
BEGIN
    DBMS_OUTPUT.put_line('Hallo ' || var1);
END;

/* Basic datatypes

-- VARCHAR2(size) - variable-length character string having maximum length size bytes. Maximum size is 4000, and minimum is 1. 
We must specify size for VARCHAR2.
-- NVARCHAR2(size) - variable-length character string having maximum length size characters or bytes, depending on the
choice of national character set. Maximum size is determined by the number of bytes required to store each character, with
an upper limit of 4000 bytes. We must specify size for NVARCHAR2.
-- NUMBER(p,s) - number having precision p and scale s. The precision p can range from 1 to 38. The scale s can range from -84 to 127.
-- LONG - character data of variable length up to 2 gigabytes, or 231 -1 bytes.
-- DATE - valid date range from January 1, 4712 BC to December 31, 9999 AD.
-- RAW(size) - raw binary data of length size bytes. Maximum size is 2000 bytes. We must specify size for a RAW value.
-- ROWID - hexadecimal string representing the unique address of a row in its table. This datatype is primarily for values
returned by the ROWID pseudocolumn.
-- CHAR(size) - fixed-length character data of length size bytes. Maximum size is 2000 bytes. Default and minimum size is 1
byte.
-- NCHAR(size) - fixed-length character data of length size characters or bytes, depending on the choice of national character set. 
Maximum size is determined by the number of bytes required to store each character, with an upper limit of 2000 bytes. 
Default and minimum size is 1 character or 1 byte, depending on the character set.
-- CLOB - a character large object containing single-byte characters. Both fixed-width and variable-width character sets are 
supported, both using the CHAR database character set. Maximum size is 4 gigabytes.
-- BLOB - a binary large object. Maximum size is 4 gigabytes.
-- BFILE - contains a locator to a large binary file stored outside the database. Enables byte stream I/O access to external
-- LOBs residing on the database server. Maximum size is 4 gigabytes.

There are many sub-types, which are derived from a type and usually add a constraint to a type. For example, an INTEGER is
a sub-type of NUMBER and only whole numbers are allowed.

*/