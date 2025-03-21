-- Section 6. Subquery
-- Subquery Ц introduce the concept of subquery and how to use the subqueries to perform advanced data selection techniques.
-- Correlated Subquery- learn about the correlated subquery which is a subquery that depends on the values returned by the outer query.
EXISTS and NOT EXISTS -- check for the existence of rows returned by a subquery.
ANY, SOME and ALL -- compare a value to a list or subquery. Note that SOME and ANY are the same so they are interchangeable.

--Section 7. Set Operators
-- This section walks you the steps of using the set operators to combine result sets of two or more independent queries.
UNION -- show you how to combine the results of two queries into a single result.
INTERSECT -- teach you how to make an intersection of the results of two independent queries.
MINUS -- learn how to subtract a result from another.

-- Section 8. More on Groupings
GROUPING SETS --Ц introduce you to the grouping set concepts and show you how to generate multiple grouping sets in a query.
CUBE Ц--- learn how to use CUBE to generate subtotals for all possible combinations of a specified group of dimensions.
ROLLUP Ц-- describe how to calculate multiple levels of subtotals across a specified group of dimensions.
PIVOT --Ц show you how to transpose rows to columns to make the crosstab reports.
UNPIVOT --Ц a guide to rotating columns into rows.

--Section 9. Modifying data
-- In this section, youТll learn how to change the contents of an Oracle database. 
--The SQL commands for modifying data are referred to as Data Manipulation Language (DML).
INSERT --Ц learn how to insert a row into a table.
INSERT INTO SELECT --Ц insert data into a table from the result of a query.
INSERT ALL --Ц discuss multitable insert statement to insert multiple rows into a table or multiple tables.
UPDATE --Ц teach you how to change the existing values of a table.
DELETE --Ц show you how to delete one or more row from a table.
MERGE --Ц walk you through the steps of performing a mixture of insertion, update, and deletion using a single statement.

--Section 10. Data definition
--This section shows you how to manage the most important database objects including databases and tables.
CREATE TABLE --Ц walk you through the steps of creating new tables in the database.
Identity Column-- learn how to use the identity clause to define the identity column for a table.
ALTER TABLE -- teach you how to change the structure of existing tables.
ALTER TABLE ADD column --Ц show you how to add one or more columns to an existing table
ALTER TABLE MODIFY column --Ц show you how to change the definition of existing columns in a table.
DROP COLUMNS --Ц learn how to use various statements to drop one or more columns from a table.
DROP TABLE --Ц show you how to delete tables from the database.
TRUNCATE TABLE --Ц delete all data from a table faster and more efficiently.
RENAME TABLE --Ц  walk you through the process of renaming a table and handling its dependent objects.
Virtual columns --Ц introduce you to virtual columns and how to use them in the database tables.

-- Section 11. Oracle data types
Oracle data types --Ц give you an overview of the built-in Oracle data types.
NUMBER --Ц introduces you to the numeric data type and show you how to use it to define numeric columns for a table.
FLOAT --Ц demystify float data type in Oracle by practical examples.
CHAR --Ц learn about fixed-length character string.
NCHAR --Ц  show you how to store fixed-length Unicode character data and explain the differences between CHAR and NCHAR data types
VARCHAR2-- Ц introduce you to the variable-length character and show you how to define variable-length character columns in a table.
NVARCHAR2 --Ц learn how to store variable-length Unicode characters in the database.
DATE --Ц discuss the date and time data type and show you how to handle date-time data effectively.
TIMESTAMP --Ц introduce you how to store date and time with the fractional seconds precision.
INTERVAL --Ц focus on the interval data types to store periods of time.
TIMESTAMP WITH TIME ZONE --Ц learn how to store datetime with timezone data.

-- Section 12. Constraints
Primary key  --Ц explain you to the primary key concept and show you how to use the primary key constraint to manage a primary key of a table.
Foreign key --Ц introduce you to the foreign key concept and show you use the foreign key constraint to enforce the relationship between tables.
NOT NULL constraint --Ц show you how to ensure a column not to accept null values.
UNIQUE constraint --Ц discuss how to ensure data stored in a column or a group of columns is unique among rows within the whole table.
CHECK constraint --Ц walk you through the process of adding logic for checking data before storing them in tables.

-- Section 13. Temporary Tables
Global temporary table --Ц learn about the global temporary tables and how to create a new global temporary table.
Private temporary table --Ц introduce the private temporary table and how to create a new private temporary table.
---------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-- Section 6. Subquery
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-- Introduce the concept of subquery and how to use the subqueries to perform advanced data selection techniques.
-----------------------------------
-- Correlated Subquery- learn about the correlated subquery which is a subquery that depends on the values returned by the outer query.
-- EXISTS and NOT EXISTS -- check for the existence of rows returned by a subquery.
-- ANY, SOME and ALL
SELECT product_id,    product_name,    list_price
FROM    products
WHERE
    list_price = (
        SELECT
            MAX( list_price )
        FROM
            products
    );
-- A) Oracle subquery in the SELECT clause example
SELECT
    product_name,
    list_price,
    ROUND(
        (
            SELECT
                AVG( list_price )
            FROM
                products p1
            WHERE
                p1. category_id = p2.category_id
        )  ,
        2
    ) avg_list_price
FROM
    products p2
ORDER BY
    product_name;

-- B) Oracle subquery in the FROM clause example - INLINE VIEW
SELECT
    order_id,
    order_value
FROM
    (
        SELECT
            order_id,
            SUM( quantity * unit_price ) order_value
        FROM
            order_items
        GROUP BY
            order_id
        ORDER BY
            order_value DESC
    )
FETCH FIRST 10 ROWS ONLY;

-- C) Oracle subquery with comparison operators example
-- The subqueries that use comparison operators e..g, >, >=, <, <=, <>, = often include aggregate functions,
-- because an aggregate function returns a single value that can be used for comparison in the WHERE clause of the outer query.

SELECT
    product_id,
    product_name,
    list_price
FROM
    products
WHERE
    list_price > (
        SELECT
            AVG( list_price )
        FROM
            products
    )
ORDER BY
    product_name;
    
-- D) Oracle subquery with IN and NOT IN operators
-- The subquery that uses the IN operator often returns a list of zero or more values. 
-- After the subquery returns the result set, the outer query makes uses of them.
SELECT employee_id, first_name, last_name
FROM
    employees
WHERE
    employee_id IN(
        SELECT
            salesman_id
        FROM
            orders INNER JOIN order_items USING(order_id)
        WHERE
            status = 'Shipped'
        GROUP BY
            salesman_id,
            EXTRACT( YEAR  FROM order_date )
        HAVING
            SUM( quantity * unit_price )  >= 1000000  
            AND EXTRACT( YEAR FROM order_date) = 2017
            AND salesman_id IS NOT NULL
    )
ORDER BY  first_name, last_name;

----------------------------------------
-- Correlated Subquery
---------------------------------------
-- A correlated subquery is also known as a repeating subquery or a synchronized subquery.

-- A) Oracle correlated subquery in the WHERE clause example
SELECT   product_id,    product_name,    list_price
FROM      products p
WHERE
    list_price > (
        SELECT
            AVG( list_price )
        FROM
            products
        WHERE
            category_id = p.category_id
    );

-- B) Oracle correlated subquery in the SELECT clause example
-- The following query returns all products and the average standard cost based on the product category:
SELECT    product_id,    product_name,   standard_cost,
    ROUND(
        (
            SELECT
                AVG( standard_cost )
            FROM
                products
            WHERE
                category_id = p.category_id
        ),
        2
    ) avg_standard_cost
FROM
    products p
ORDER BY  product_name;

-- C) Oracle correlated subquery with the EXISTS operator example
-- We usually use a correlated subquery with the EXISTS operator. 
-- For example, the following statement returns all customers who have no orders:
SELECT
    customer_id,
    name
FROM
    customers
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            orders
        WHERE
            orders.customer_id = customers.customer_id
    )
ORDER BY
    name;

------------------------------------
-- EXISTS and NOT EXISTS
------------------------------------
-- The Oracle EXISTS operator is a Boolean operator that returns either true or false. 
-- The EXISTS operator is often used with a subquery to test for the existence of rows:

-- A Oracle EXISTS with SELECT statement example

-- The following example uses the EXISTS operator to find all customers who have the order.
SELECT   name
FROM     customers c
WHERE
    EXISTS (
        SELECT  1
        FROM    orders
        WHERE   customer_id = c.customer_id
          )
ORDER BY name;

-- B Oracle EXISTS with UPDATE statement example
-- The following statement updates the names of the warehouses located in the US:

UPDATE
    warehouses w
SET
    warehouse_name = warehouse_name || ', USA'
WHERE
    EXISTS (
        SELECT  1
        FROM    locations
        WHERE   country_id = 'US'
        AND     location_id = w.location_id
    );

-- Oracle EXISTS with INSERT statement example

CREATE TABLE customers_2016(
    company_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    company varchar2(255) NOT NULL,
    first_name varchar2(255) NOT NULL,
    last_name varchar2(255) NOT NULL,
    email varchar2(255) NOT NULL,
    sent_email CHAR(1) DEFAULT 'N',
    PRIMARY KEY(company_id)
);
INSERT
    INTO
        customers_2016(
            company,
            first_name,
            last_name,
            email
        ) SELECT
            name company,
            first_name,
            last_name,
            email
        FROM
            customers c
        INNER JOIN contacts ON
            contacts.customer_id = c.customer_id
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    orders
                WHERE
                    customer_id = c.customer_id
                    AND EXTRACT(
                        YEAR
                    FROM
                        order_date)
        )            
        ORDER BY company;

-- Oracle EXISTS vs. IN
-- 
-- Typically, the EXISTS operator is faster than IN operator when the result set of the subquery is large.
-- By contrast, the IN operator is faster than EXISTS operator when the result set of the subquery is small.


-----------------------------------------------------------------
-- Oracle NOT EXISTS operator
-----------------------------------------------------------------
-- We often use the NOT EXISTS operator with a subquery to subtract one set of data from another.

-- !!!!!!!   Note that the NOT EXISTS operator returns false if the subquery returns any rows with a NULL value.  !!!!!!!

CREATE TABLE customers_archive AS
SELECT * 
FROM
    customers
WHERE
    NOT EXISTS (
        SELECT
            NULL
        FROM
            orders
        WHERE
            orders.customer_id = customers.customer_id
    );
SELECT * FROM customers_archive;

----------------------------------------------------------------------------------------------------------------------------
--EXISTS\NOT EXISTS - если хотите проверить, возвращает ли подзапрос записи
----------------------------------------------------------------------------------
--“.е. запрос выполнитс€, если EXISTS вернет True и наоборот с NOT EXISTS.
SELECT * FROM departments;  -- в табл есть department_id = 10, 20, 30 .... 260, 270 (всего 27 депертаментов)
SELECT * FROM employees e;  -- в табл есть department_id = 10, 20, 30 .... 100, 110 (всего 11 депертаментов задействованы)
-- мы возвращаем информацию о всех департаментах, дл€ которых в таблице employees есть хот€ бы один сотрудник. -- 10 - 110
SELECT * FROM departments d WHERE 
EXISTS (SELECT * FROM employees e WHERE d.department_id = e.department_id);
-- вывести онформацию о депертаментах, где нет ни одного сотрудника  -- 120 - 270
SELECT * FROM departments d WHERE 
NOT EXISTS (SELECT * FROM employees e WHERE d.department_id = e.department_id);

SELECT * FROM hr.employees 
WHERE NOT EXISTS
  (SELECT first_name FROM hr.employees WHERE FIRST_NAME = 'Michael');
----------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------
--  √рупповые услови€ (операторы сравнени€) в запросах Oracle SQL, ключевые слова ALL, ANY, SOME
-----------------------------------------------------------------------------------------------------------------
-- ALL, ANY, SOME примен€ютс€ дл€ сравнени€ указанного вами значени€ с набором значений,
-- который возвращает подзапрос (или €вно указанный набор значений):

-- ALL Ч сравнение будет производитьс€ со всеми запис€ми, которые возвращает подзапрос (или просто со всеми значени€ми в набор). 
-- True вернетс€ только в том случае, если все записи, которые возвращает подзапрос, будут удовлетвор€ть указанному вами условию. 
--  роме того, в Oracle значение True вернетс€ в ситуации, когда подзапрос не вернет ни одной записи.
-- ¬ качестве примера приведем такой запрос:
-- ќн вернет записи дл€ всех сотрудников, дл€ которых зарплата меньше или равна самой маленькой зарплате у сотрудников с должностью SH_CLERK.
select * from hr.employees where salary <= ALL(SELECT salary FROM hr.employees WHERE job_id = 'SH_CLERK');
--  ќн вернет 0 записи
select * from hr.employees where salary = ALL(SELECT salary FROM hr.employees WHERE job_id = 'SH_CLERK');

--  в Oracle значение True вернетс€ в ситуации, когда подзапрос не вернет ни одной записи.
select * from hr.employees;
select * from hr.employees where salary = ALL(SELECT salary FROM hr.employees WHERE job_id = 'KEINE_JOB_ID');
 
-- ANY Ч сравнение вернет True, если условию будет удовлетвор€ть люба€ запись из набора (или подзапроса).
-- Ќапример, такой запрос вернет всех пользователей, зарплата которых совпадает с зарплатой клерка:
select * from hr.employees where salary = ANY(SELECT salary FROM hr.employees WHERE job_id = 'SH_CLERK');

-- SOME Ч сравнение вернет True, если условию будут удовлетвор€ть некоторые записи из набора (или подзапроса).


-----------------------------------------------------------------------------------------------------------------------------
-- Section 7. Set Operators
-----------------------------------------------------------------------------------

--ќбъединени€ таблиц
--ќтбрасываем одинаковые строки
SELECT employee_id FROM HR.EMPLOYEES
UNION
SELECT employee_id FROM HR.JOB_HISTORY;

--Ѕез отбрасывани€ дубликатов
SELECT employee_id FROM HR.EMPLOYEES
UNION ALL
SELECT employee_id FROM HR.JOB_HISTORY;

--„то есть общего между таблицами
SELECT employee_id FROM HR.EMPLOYEES
INTERSECT
SELECT employee_id FROM HR.JOB_HISTORY;

--„то есть уникального между таблицами
SELECT employee_id FROM HR.EMPLOYEES
MINUS
SELECT employee_id FROM HR.JOB_HISTORY;
---------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------
-- -- Section 8. More on Groupings
-------------------------------------------------------------------
-- Grouping sets
-- Setting up a sample view
CREATE VIEW customer_category_sales AS
SELECT 
    category_name category, 
    customers.name customer, 
    SUM(quantity*unit_price) sales_amount
FROM 
    orders
    INNER JOIN customers USING(customer_id)
    INNER JOIN order_items USING (order_id)
    INNER JOIN products USING (product_id)
    INNER JOIN product_categories USING (category_id)
WHERE 
    customer_id IN (1,2)
GROUP BY 
    category_name, 
    customers.name;

-- Oracle GROUPING SETS expression
   SELECT 
    customer, 
    category,
    SUM(sales_amount)
FROM 
    customer_category_sales
GROUP BY 
    GROUPING SETS(
        (customer,category),
        (customer),
        (category),
        ()
    )
ORDER BY 
    customer, 
    category;

-- Oracle GROUPING() function
-- The GROUPING() function returns a value of 1 when the value of expression in the row is NULL 
-- representing the set of all values. Otherwise, it returns 0.
-- ‘ункци€ GROUPING() возвращает значение 1, когда значение выражени€ в строке равно NULL, представл€ющему набор всех значений. 
-- ¬ противном случае он возвращает 0.
SELECT 
    customer, 
    category,
    GROUPING(customer) customer_grouping,
    GROUPING(category) category_grouping,
    SUM(sales_amount) 
FROM customer_category_sales
GROUP BY 
    GROUPING SETS(
        (customer,category),
        (customer),
        (category),
        ()
    )
ORDER BY 
    customer, 
    category;

SELECT 
    DECODE(GROUPING(customer),1,'ALL customers', customer) customer,
    DECODE(GROUPING(category),1,'ALL categories', category) category,
    SUM(sales_amount) 
FROM 
    customer_category_sales
GROUP BY 
    GROUPING SETS(
        (customer,category),
        (customer),
        (CATEGORY),
        ()
    )
ORDER BY 
    customer, 
    category;

-- Oracle GROUPING_ID() function
-- The GROUPING_ID() function takes the Уgroup byФ columns and returns a number denoting the GROUP BY level. 
-- In other words, it provides another compact way to identify the subtotal rows.
SELECT 
    customer, 
    category,
    GROUPING_ID(customer,category) grouping,
    SUM(sales_amount) 
FROM customer_category_sales
GROUP BY 
    GROUPING SETS(
        (customer,category),
        (customer),
        (category),
        ()
    )
ORDER BY 
    customer, 
    category;

-------------------------------------------------------------    
-- Oracle CUBE
-------------------
-- 
-- DROP VIEW customer_category_sales;
CREATE or replace VIEW customer_category_sales AS
SELECT 
    category_name category, 
    customers.name customer, 
    SUM(quantity*unit_price) sales_amount
FROM 
    orders
    INNER JOIN customers USING(customer_id)
    INNER JOIN order_items USING (order_id)
    INNER JOIN products USING (product_id)
    INNER JOIN product_categories USING (category_id)
WHERE 
    customer_id IN (1,2)
GROUP BY 
    category_name, 
    customers.name;
    
SELECT * FROM customer_category_sales
ORDER BY 1,2;

-- 1
SELECT
    category,
    customer,
    SUM(sales_amount) 
FROM 
    customer_category_sales
GROUP BY 
    CUBE(category,customer)
ORDER BY 
    category NULLS LAST, 
    customer NULLS LAST;
-- 2 
SELECT
    category,
    customer,
    SUM(sales_amount) 
FROM 
    customer_category_sales
GROUP BY 
    category,
    CUBE(customer)
ORDER BY 
    category, 
    customer NULLS LAST;

------------------------------------------------------------------------
-- Oracle ROLLUP
--------------------------
-- Oracle provides a better and faster way to calculate the grand total by using the ROLLUP as shown in the following query:
SELECT
   customer_id,
   SUM(quantity * unit_price) amount
FROM
   orders
INNER JOIN order_items USING (order_id)
WHERE
   status      = 'Shipped' AND 
   salesman_id IS NOT NULL AND 
   EXTRACT(YEAR FROM order_date) = 2017
GROUP BY
   ROLLUP(customer_id);


SELECT employee_id as "Even Numbers", last_name
FROM employees 
WHERE MOD(employee_id,2) = 0;




-- 
SELECT
   salesman_id,
   customer_id,
   SUM(quantity * unit_price) amount
FROM
   orders
INNER JOIN order_items USING (order_id)
WHERE
   status      = 'Shipped' AND 
   salesman_id IS NOT NULL AND 
   EXTRACT(YEAR FROM order_date) = 2017
GROUP BY
   ROLLUP(salesman_id,customer_id);

-- The following query performs a partial rollup:
SELECT
   salesman_id,
   customer_id,
   SUM(quantity * unit_price) amount
FROM
   orders
INNER JOIN order_items USING (order_id)
WHERE
   status      = 'Shipped' AND 
   salesman_id IS NOT NULL AND 
   EXTRACT(YEAR FROM order_date) = 2017
GROUP BY
   salesman_id,
   ROLLUP(customer_id);
   
-------------------------------------------
-- Oracle PIVOT 
-----------------
-- PIVOT clause to transpose rows to columns to generate result sets in crosstab format.
-- Oracle PIVOT example

CREATE VIEW order_stats AS
SELECT 
    category_name, 
    status, 
    order_id
FROM 
    order_items
INNER JOIN orders USING (order_id)
INNER JOIN products USING (product_id)
INNER JOIN product_categories USING (category_id);

SELECT 
    category_name,
    status,
    order_id
FROM
    order_stats;

SELECT * FROM order_stats
PIVOT(
    COUNT(order_id) 
    FOR category_name
    IN ( 
        'CPU'
        ,'Video Card'
        ,'Mother Board'
        ,'Storage'
    )
)
ORDER BY status;

-- ALIASES
SELECT * FROM order_stats
PIVOT(
    COUNT(order_id) order_count
    FOR category_name
    IN ( 
        'CPU' CPU,
        'Video Card' VideoCard, 
        'Mother Board' MotherBoard,
        'Storage' Storage
    )
)
ORDER BY status;

-- Pivoting multiple columns

CREATE OR REPLACE VIEW order_stats AS
SELECT 
    category_name, 
    status, 
    order_id, 
    SUM(quantity * list_price) AS order_value
FROM 
    order_items
INNER JOIN orders USING (order_id)
INNER JOIN products USING (product_id)
INNER JOIN product_categories USING (category_id)
GROUP BY 
    order_id, 
    status, 
    category_name;

SELECT * FROM order_stats;

SELECT * FROM order_stats
PIVOT(
    COUNT(order_id) orders,
    SUM(order_value) sales
    FOR category_name
    IN ( 
        'CPU' CPU,
        'Video Card' VideoCard, 
        'Mother Board' MotherBoard,
        'Storage' Storage
    )
)
ORDER BY status;

-- Finally, use status as the pivot columns and category_name as rows:
SELECT * FROM order_stats
PIVOT(
    COUNT(order_id) orders,
    SUM(order_value) sales
    FOR status
    IN ( 
        'Canceled' Canceled,
        'Pending' Pending, 
        'Shipped' Shipped
    )
)
ORDER BY category_name;

------------------------------------------------------------------------------------------------
-- Oracle UNPIVOT
------------------------------
-- Oracle UNPIVOT clause to transpose columns to rows.

-- Setting up a sample table
CREATE TABLE sale_stats(
    id INT PRIMARY KEY,
    fiscal_year INT,
    product_a INT,
    product_b INT,
    product_c INT
);
INSERT INTO sale_stats(id, fiscal_year, product_a, product_b, product_c)
VALUES(1,2017, NULL, 200, 300);
INSERT INTO sale_stats(id, fiscal_year, product_a, product_b, product_c)
VALUES(2,2018, 150, NULL, 250);
INSERT INTO sale_stats(id, fiscal_year, product_a, product_b, product_c)
VALUES(3,2019, 150, 220, NULL);

SELECT * FROM sale_stats;

-- Oracle UNPIVOT examples

SELECT * FROM sale_stats
UNPIVOT(
    quantity  -- unpivot_clause
    FOR product_code --  unpivot_for_clause
    IN ( -- unpivot_in_clause
        product_a AS 'A', 
        product_b AS 'B', 
        product_c AS 'C'
    )
);

-- The following example uses the UNPIVOT clause to transpose values in the columns product_a, product_b, 
-- and product_c to rows, but including null-valued rows:
SELECT * FROM sale_stats
UNPIVOT INCLUDE NULLS(
    quantity
    FOR product_code 
    IN (
        product_a AS 'A', 
        product_b AS 'B', 
        product_c AS 'C'
    )
);

-- Oracle unpivot multiple columns

DROP TABLE sale_stats;
    
CREATE TABLE sale_stats(
    id INT PRIMARY KEY,
    fiscal_year INT,
    a_qty INT,
    a_value DEC(19,2),
    b_qty INT,
    b_value DEC(19,2)
);

INSERT INTO sale_stats(id, fiscal_year, a_qty, a_value, b_qty, b_value)
VALUES(1, 2018, 100, 1000, 2000, 4000);

INSERT INTO sale_stats(id, fiscal_year, a_qty, a_value, b_qty, b_value)
VALUES(2, 2019, 150, 1500, 2500, 5000);

SELECT * FROM sale_stats;

SELECT * FROM sale_stats
UNPIVOT (
    (quantity, amount)
    FOR product_code
    IN (
        (a_qty, a_value) AS 'A', 
        (b_qty, b_value) AS 'B'        
    )
);

-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------
-- Section 9. Modifying data
-----------------------------------------------------------------------
----------  DML  ----------
---------------------------
-- Data Manipulation Language (DML) The SQL commands for modifying data

INSERT INTO         -- learn how to insert a row into a table.
INSERT INTO SELECT  -- insert data into a table from the result of a query.
INSERT ALL   -- discuss multitable insert statement to insert multiple rows into a table or multiple tables.
UPDATE  -- teach you how to change the existing values of a table.
DELETE  -- show you how to delete one or more row from a table.
MERGE   -- walk you through the steps of performing a mixture of insertion, update, and deletion using a single statement.


-- To INSERT a new row into a table
INSERT INTO table_name [(column_list)]
VALUES( value_list);
-- UPDATE statement to change existing values in a table.
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    column3 = value3,
    ...
WHERE condition;
-- to DELETE one or more rows from a table.
DELETE
FROM
    table_name
WHERE
    condition;
    
    
------------------------------------------------------------------------------------------------------------------
-----  INSERT  ------------
------------------------------------------------------------------------------------------------------------------

--  1. INSERT INTO introduse  --
INSERT INTO table_name (column_list)
  VALUES( value_list);
  
CREATE TABLE discounts (
    discount_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    discount_name VARCHAR2(255) NOT NULL,
    amount NUMBER(3,1) NOT NULL,
    start_date DATE NOT NULL,
    expired_date DATE NOT NULL
);
INSERT INTO discounts(discount_name, amount, start_date, expired_date)
VALUES('Summer Promotion',      9.5,    DATE '2017-05-01',  DATE '2017-08-31')
;
INSERT INTO discounts(discount_name, amount, start_date, expired_date)
VALUES('Winter Promotion 2017', 10.5,   CURRENT_DATE,       DATE '2017-12-31')
;
SELECT * FROM discounts
;
--------------------------------------------------------------------------------------------------------------------
--  2. INSERT INTO SELECT --
--------------------------------------------------------------------------------------------------------------------
--  2.a. Insert all sales data example
CREATE TABLE sales (
    customer_id NUMBER,
    product_id NUMBER,
    order_date DATE NOT NULL,
    total NUMBER(9,2) DEFAULT 0 NOT NULL,
    PRIMARY KEY(customer_id,
                product_id,
                order_date)
);

INSERT INTO  sales(customer_id, product_id, order_date, total)
SELECT customer_id,
       product_id,
       order_date,
       SUM(quantity * unit_price) amount
FROM orders
INNER JOIN order_items USING(order_id)
WHERE status = 'Shipped'
GROUP BY customer_id, product_id, order_date
;

SELECT * FROM sales
ORDER BY order_date DESC, total DESC
;

--  2.b. Insert partial sales data example
CREATE TABLE sales_2017 
AS SELECT * FROM sales
WHERE 1 = 0
;

INSERT INTO  sales_2017
    SELECT customer_id,
           product_id,
           order_date,
           SUM(quantity * unit_price) amount
    FROM orders
    INNER JOIN order_items USING(order_id)
    WHERE status = 'Shipped' AND EXTRACT(year from order_date) = 2017        
    GROUP BY customer_id,
             product_id,
             order_date
;  -- 188

SELECT * FROM sales_2017 ORDER BY order_date DESC, total DESC
;

-- 2.c.  Insert partial data and literal value example
CREATE TABLE customer_lists(
    list_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name varchar2(255) NOT NULL,
    last_name varchar2(255) NOT NULL,
    email varchar2(255) NOT NULL,
    sent NUMBER(1) NOT NULL,
    sent_date DATE,
    PRIMARY KEY(list_id)
);

-- In this example, in addition to retrieving data from the contacts table, we also used literal 0 as the value for the sent column.
INSERT INTO
        customer_lists( first_name, last_name, email, sent )
        SELECT          first_name, last_name, email,  0
        FROM contacts
;
-- In this example, in addition to retrieving data from the contacts table, we also used literal 0 as the value for the sent column.
SELECT * FROM customer_lists
;
------------------------------
-- 3 INSERT ALL
------------------------------
-- Oracle provides you with two types of multitable insert statements: UNCONDITIONAL and CONDITIONAL.
-----------------------------------------------

-- 1 UNCONDITIONAL Oracle INSERT ALL statement

-- 1.1. Insert multiple rows into a table
INSERT ALL
    INTO table_name(col1,col2,col3) VALUES(val1,val2, val3)
    INTO table_name(col1,col2,col3) VALUES(val4,val5, val6)
    INTO table_name(col1,col2,col3) VALUES(val7,val8, val9)
Subquery;   -- SELECT * FROM dual;

CREATE TABLE fruits (
    fruit_name VARCHAR2(100) PRIMARY KEY,
    color VARCHAR2(100) NOT NULL
);
INSERT ALL 
    INTO fruits(fruit_name, color)
    VALUES ('Apple','Red') 

    INTO fruits(fruit_name, color)
    VALUES ('Orange','Orange') 

    INTO fruits(fruit_name, color)
    VALUES ('Banana','Yellow')
SELECT 1 FROM dual
;
SELECT  * FROM fruits
;

-- 1.2. Insert multiple rows into multiple tables

INSERT ALL
    INTO table_name1(col1,col2,col3) VALUES(val1,val2, val3)
    INTO table_name2(col1,col2,col3) VALUES(val4,val5, val6)
    INTO table_name3(col1,col2,col3) VALUES(val7,val8, val9)
Subquery;

-- 2. CONDITIONAL Oracle INSERT ALL Statement

INSERT [ ALL | FIRST ]
    WHEN condition1 THEN
        INTO table_1 (column_list ) VALUES (value_list)
    WHEN condition2 THEN 
        INTO table_2(column_list ) VALUES (value_list)
    ELSE
        INTO table_3(column_list ) VALUES (value_list)
Subquery;

-- 2.1. Conditional Oracle INSERT ALL example
CREATE TABLE small_orders (
    order_id NUMBER(12) NOT NULL,
    customer_id NUMBER(6) NOT NULL,
    amount NUMBER(8,2) 
);
CREATE TABLE medium_orders AS
SELECT *
FROM small_orders
;
CREATE TABLE big_orders AS
SELECT *
FROM small_orders
;
-- The following conditional Oracle INSERT ALL statement inserts order data into the three tables 
-- small_orders, medium_orders, and big_orders based on ordersТ amounts:
INSERT ALL
   WHEN amount < 10000 THEN
      INTO small_orders
   WHEN amount >= 10000 AND amount <= 30000 THEN
      INTO medium_orders
   WHEN amount > 30000 THEN
      INTO big_orders
      
  SELECT order_id,
         customer_id,
         (quantity * unit_price) amount
  FROM orders
  INNER JOIN order_items USING(order_id);
SELECT   * FROM big_orders
;
-- You can achieve the same result by using the ELSE clause in place of the insert into the big_orders tables as follows:
INSERT ALL
   WHEN amount < 10000 THEN
      INTO small_orders
   WHEN amount >= 10000 AND amount <= 30000 THEN
      INTO medium_orders
   ELSE
      INTO big_orders
  SELECT order_id,
         customer_id,
         (quantity * unit_price) amount
  FROM orders
  INNER JOIN order_items USING(order_id);

-- 2.2. CONDITIONAL Oracle INSERT FIRST example
-- This statement will not make any sense with an INSERT ALL 
-- because the orders whose amount greater than 30,000 would have ended up being inserted into the three tables.
INSERT FIRST
    WHEN amount > 30000 THEN
        INTO big_orders
    WHEN amount >= 10000 THEN
        INTO medium_orders
    WHEN amount > 0 THEN
        INTO small_orders
 SELECT order_id,
         customer_id,
         (quantity * unit_price) amount
 FROM orders
 INNER JOIN order_items USING(order_id);

-- 3. Oracle INSERT ALL restrictions     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--The Oracle multitable insert statement is subject to the following main restrictions:

It can be used to insert data into tables only, not views or materialized view.
It cannot be used to insert data into remote tables.
The number of columns in all the INSERT INTO clauses must not exceed 999.
A table collection expression cannot be used in a multitable insert statement.
The subquery of the multitable insert statement cannot use a sequence.


-------------------------------------------------------------------------------------------------------------------------
----- 3. UPDATE  ----------------------------
---------------------------------------------
-----  to change existing values in a table.
---------------------------------------------
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    column3 = value3,
    ...
WHERE condition;
-- The value1, value2, or value3 can be literals or a subquery that returns a single value.
CREATE TABLE parts (
  part_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
  part_name VARCHAR(50) NOT NULL,
  lead_time NUMBER(2,0) NOT NULL,
  cost NUMBER(9,2) NOT NULL,
  status NUMBER(1,0) NOT NULL,
  PRIMARY KEY (part_id)
);
-- Running: Update_insert.sql ---------------------------------------------------------------
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('sed dictum',5,134,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('tristique neque',3,62,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('dolor quam,',16,82,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('nec, diam.',41,10,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('vitae erat',22,116,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('parturient montes,',32,169,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('metus. In',45,88,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('at, velit.',31,182,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('nonummy ultricies',7,146,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('a, dui.',38,116,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('arcu et',37,72,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('sapien. Cras',40,197,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('et malesuada',24,46,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('mauris id',4,153,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('eleifend egestas.',2,146,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('cursus. Nunc',9,194,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('vivamus sit',37,93,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('ac orci.',35,134,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('arcu. Aliquam',36,154,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('at auctor',32,56,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('purus, accumsan',33,12,1);
--------------------------------------------------------------------------------------------
SELECT * FROM parts ORDER BY part_name;

-- 3.a. UPDATE one column of a single row
UPDATE parts
SET    cost = cost-4 -- 133-4=130
WHERE  part_id = 1
;
SELECT * FROM parts WHERE part_id = 1;

-- 3.b. UPDATE multiple columns of a single row
UPDATE parts
SET    lead_time = 30,  -- 22
       cost = 120,  -- 116
       status = 1  -- 0
WHERE  part_id = 5
;
SELECT * FROM parts WHERE part_id = 5;  -- Ok

-- 3.c. UPDATE multiple rows example
UPDATE parts
SET    cost = cost * 1.05
WHERE  part_id <= 5
;
SELECT * FROM parts WHERE part_id <= 5;  -- 120 --> 126 (120 * 1.05 = 126)


-----------------------------
----------  DML  ------------
----- 4. DELETE  ------------
------------------------------------------------------
--  delete one row or multiple rows from a table
------------------------------------------------------
SELECT COUNT(*) FROM sales ; -- 665

DELETE FROM sales
    WHERE order_id = 1
    AND   item_id = 1
;  --  1 row(s) deleted.

SELECT COUNT(*) FROM sales ; -- 664

DELETE FROM sales
       WHERE order_id = 1
;  --  12 row(s) deleted.

SELECT COUNT(*) FROM sales ; -- 652

-- 2. delete all rows from a table
DELETE FROM sales; -- 652 row(s) deleted.

-- 3. delete 2 tables ohne cascade
DELETE FROM orders
WHERE order_id = 1
;
DELETE FROM order_items
WHERE order_id = 1
;
COMMIT WORK
;

-- DELETE CASCADE
-- In this case, when you create the order_items table, you define a foreign key constraint with the DELETE CASCADE option as follows:
CREATE TABLE order_items 
(    order_id   NUMBER( 12, 0 )                                , 
    -- other columns
    -- ...
    CONSTRAINT fk_order_items_orders FOREIGN KEY( order_id )  REFERENCES orders( order_id ) ON DELETE CASCADE
);
-- By doing this, whenever you delete a row from the orders table, for example:
DELETE FROM orders
WHERE order_id = 1
;
-- All the rows whose order id is 1 in the order_items table are also deleted automatically by the database system.


---------------------------------------------------------------
--  Oracle MERGE statement 
---------------------------------------------------------------
-- The following illustrates the syntax of the Oracle MERGE statement:
MERGE INTO target_table 
USING source_table 
ON search_condition
    WHEN MATCHED THEN
        UPDATE SET col1 = value1, col2 = value2,...
        WHERE <update_condition>
        [DELETE WHERE <delete_condition>]
    WHEN NOT MATCHED THEN
        INSERT (col1,col2,...)
        values(value1,value2,...)
        WHERE <insert_condition>;

-- Oracle MERGE example
-- create and insert 2 tables --
CREATE TABLE members (
    member_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    rank VARCHAR2(20))
;
CREATE TABLE member_staging AS SELECT * FROM members
;
-- insert into members table    
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(1,'Abel','Wolf','Gold');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(2,'Clarita','Franco','Platinum');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(3,'Darryl','Giles','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(4,'Dorthea','Suarez','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(5,'Katrina','Wheeler','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(6,'Lilian','Garza','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(7,'Ossie','Summers','Gold');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(8,'Paige','Mcfarland','Platinum');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(9,'Ronna','Britt','Platinum');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(10,'Tressie','Short','Bronze');
-- insert into member_staging table
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(1,'Abel','Wolf','Silver');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(2,'Clarita','Franco','Platinum');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(3,'Darryl','Giles','Bronze');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(4,'Dorthea','Gate','Gold');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(5,'Katrina','Wheeler','Silver');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(6,'Lilian','Stark','Silver');

SELECT * FROM member_staging;  -- 6
SELECT * FROM members;  --  10

MERGE INTO member_staging x
USING (SELECT member_id, first_name, last_name, rank FROM members) y
ON (x.member_id  = y.member_id)
WHEN MATCHED THEN
    UPDATE SET x.first_name = y.first_name, 
                        x.last_name = y.last_name, 
                        x.rank = y.rank
    WHERE x.first_name <> y.first_name OR 
           x.last_name <> y.last_name OR 
           x.rank <> y.rank 
WHEN NOT MATCHED THEN
    INSERT(x.member_id, x.first_name, x.last_name, x.rank)  
    VALUES(y.member_id, y.first_name, y.last_name, y.rank);

SELECT * FROM member_staging;  -- 10
SELECT * FROM members;  --  10


-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
--Section 10. Data definition --
-------------------------------------------------------------------------------------------------------------------------

--This section shows you how to manage the most important database objects including databases and tables.
CREATE TABLE --Ц walk you through the steps of creating new tables in the database.
Identity Column -- learn how to use the identity clause to define the identity column for a table.
ALTER TABLE -- teach you how to change the structure of existing tables.
ALTER TABLE ADD column --Ц show you how to add one or more columns to an existing table
ALTER TABLE MODIFY column --Ц show you how to change the definition of existing columns in a table.
Drop columns --Ц learn how to use various statements to drop one or more columns from a table.
DROP TABLE --Ц show you how to delete tables from the database.
TRUNCATE TABLE --Ц delete all data from a table faster and more efficiently.
RENAME table --Ц  walk you through the process of renaming a table and handling its dependent objects.
Virtual columns --Ц introduce you to virtual columns and how to use them in the database tables;

-----------------------------------------------------------------------
-- Oracle CREATE TABLE statement example
-----------------------------------------------------------------------
CREATE TABLE persons(
    person_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    PRIMARY KEY(person_id)
);
SELECT * FROM persons
;
---------------------------------------------------------------------------------------------
-- Identity Column  
---------------------------------------------------------------------------------------------
-- To define an identity column, you use the identity clause as shown below:

GENERATED [ ALWAYS | BY DEFAULT [ ON NULL ] ]
AS IDENTITY [ ( identity_options ) ] 

-- Oracle identity column examples

-- A) GENERATED ALWAYS example 
CREATE TABLE identity_demo (
    id NUMBER GENERATED ALWAYS AS IDENTITY,
    description VARCHAR2(100) NOT NULL
);
INSERT INTO identity_demo(description) VALUES('Oracle identity column demo with GENERATED ALWAYS')
;
SELECT * FROM identity_demo
;  -- 1, Oracle identity column demo with GENERATED ALWAYS
INSERT INTO identity_demo(id,description) VALUES(2, 'Oracle identity column example with GENERATED ALWAYS ')
;   -- SQL Error: ORA-32795: cannot insert into a generated always identity column

-- B) GENERATED BY DEFAULT example

DROP TABLE identity_demo
;
CREATE  TABLE identity_demo  (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    description VARCHAR2(100) not null
  );
INSERT INTO identity_demo(description) VALUES('Oracle identity column demo with GENERATED BY DEFAULT')
;
INSERT INTO identity_demo(id,description) VALUES(2, 'Oracle identity column example with GENERATED BY DEFAULT')
;
SELECT * FROM identity_demo
;
INSERT INTO identity_demo(id,description) VALUES(NULL, 'Oracle identity column demo with GENERATED BY DEFAULT, NULL value')
;  --  ORA-01400: cannot insert NULL into ("OT"."IDENTITY_DEMO"."ID")

-- C) GENERATED BY DEFAULT ON NULL example
CREATE  TABLE identity_demo  (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    description VARCHAR2(100) not null
  );

-- D) START WITH option example
DROP TABLE identity_demo;

CREATE  TABLE identity_demo  (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 100,
    description VARCHAR2(100) not null
  );
INSERT INTO identity_demo(description) VALUES('Oracle 100 identity column demo with START WITH option');
INSERT INTO identity_demo(description) VALUES('Oracle 100 identity column demo with START WITH option');
INSERT INTO identity_demo(description) VALUES('Oracle 102 identity column demo with START WITH option');
SELECT * FROM identity_demo;  --  100, 101, 102 ....

-- E) INCREMENT BY option example
DROP TABLE identity_demo;

CREATE  TABLE identity_demo (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 10 INCREMENT BY 10,
    description VARCHAR2(100) not null
);
INSERT INTO identity_demo(description) VALUES('Oracle identity column demo 1 with INCREMENT BY option');
INSERT INTO identity_demo(description) VALUES('Oracle identity column demo 2 with INCREMENT BY option');
SELECT * FROM identity_demo;  --  10,20, ...

---------------------------------------------------------------------------------------------------------------------------
-- Oracle ALTER TABLE  
---------------------------------------------------------------------------------------------------------------------------
-- Oracle ALTER TABLE examples
---------------------------------------------
-- Oracle ALTER TABLE ADD column examples
ALTER TABLE persons 
ADD birthdate DATE NOT NULL;  -- ADD COLUMN examples
  DESC persons;
--  ADD MULTIPLE COLUMNS to a table at the same time,
ALTER TABLE persons 
ADD (
    phone VARCHAR(20),
    email VARCHAR(100)
);
  DESC persons;

-- Oracle ALTER TABLE MODIFY column examples
-- changes the birthdate column to a null-able column:
ALTER TABLE persons MODIFY birthdate DATE NULL;
-- changes the phone and email column to NOT NULLcolumns and extends the length of the email column to 255 characters:
ALTER TABLE persons MODIFY(
    phone VARCHAR2(20) NOT NULL,
    email VARCHAR2(255) NOT NULL
);

-- Oracle ALTER TABLE DROP COLUMN example
ALTER TABLE persons  DROP  COLUMN birthdate;
-- removes the phone and email columns from the persons table:
ALTER TABLE persons  DROP ( email, phone );
  DESC persons;

-- Oracle ALTER TABLE RENAME column example
ALTER TABLE persons RENAME COLUMN first_name TO forename;

-- Oracle ALTER TABLE RENAME table example
ALTER TABLE persons RENAME TO people;
  desc people;
  
-------------------------------------------------------------------------------------
-- Oracle ALTER TABLE ADD column examples
-------------------------------------------------------------------------------------
DROP TABLE members;
CREATE TABLE members(
    member_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    PRIMARY KEY(member_id)
);
ALTER TABLE members 
ADD birth_date DATE NOT NULL;

ALTER TABLE
    members ADD(
        created_at TIMESTAMP WITH TIME ZONE NOT NULL,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL
    );
DESC members;

-- To check whether a column exists in a table, you query the data from the user_tab_cols view.
SELECT *   -- COUNT(*)
FROM    user_tab_cols
WHERE
    column_name = 'FIRST_NAME'
    AND table_name = 'MEMBERS';

--------------------------------------------------------------------------------------------------------------------------
-- Oracle ALTER TABLE MODIFY Column 
--------------------------------------------------------------------------------------------------------------------------

-- create a new table named accounts for the demonstration:
CREATE TABLE accounts (
    account_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(25) NOT NULL,
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(100),
    phone VARCHAR2(12) ,
    full_name VARCHAR2(51) GENERATED ALWAYS AS( 
            first_name || ' ' || last_name
    ),
    PRIMARY KEY(account_id)
);
INSERT INTO accounts(first_name,last_name,phone)
VALUES('Trinity',
       'Knox',
       '410-555-0197');
INSERT INTO accounts(first_name,last_name,phone)
VALUES('Mellissa',
       'Porter',
       '410-555-0198');
INSERT INTO accounts(first_name,last_name,phone)
VALUES('Leeanna',
       'Bowman',
       '410-555-0199');

-- A) Modify the columnТs visibility
SELECT * FROM  accounts; -- 6 colums
DESCRIBE accounts; -- 6 colums

ALTER TABLE accounts 
MODIFY full_name INVISIBLE; 

SELECT * FROM  accounts; -- 5 colums
DESCRIBE accounts; -- 5 colums
SELECT a.full_name, a.* FROM  accounts a; -- OK 6 colums

ALTER TABLE accounts 
MODIFY full_name VISIBLE;

SELECT * FROM  accounts; -- 6 colums
DESCRIBE accounts; -- 6 colums

-- B) Allow or not allow null example
DESCRIBE accounts;

ALTER TABLE accounts 
MODIFY email VARCHAR2( 100 ) NOT NULL;
-- SQL Error: ORA-02296: cannot enable (OT.) - null values found
-- Because when you changed a column from nullable to non-nullable, you must ensure that the existing data meets the new constraint.

UPDATE    accounts  SET    email = LOWER(first_name || '.' || last_name || '@oracletutorial.com') ; -- 3 rows updated.

ALTER TABLE accounts 
MODIFY email VARCHAR2( 100 ) NOT NULL;  -- Table ACCOUNTS altered.

-- C) Widen or shorten the size of a column example

ALTER TABLE accounts 
MODIFY phone VARCHAR2( 15 );

UPDATE    accounts
SET    phone = '+1-' || phone;

SELECT    * FROM    accounts;

ALTER TABLE accounts 
MODIFY phone VARCHAR2( 12 );  -- ORA-01441: cannot decrease column length because some value is too big

UPDATE    accounts
SET    phone = REPLACE( phone, '+1-', '' );

ALTER TABLE accounts 
MODIFY phone VARCHAR2( 12 ); -- Table ACCOUNTS altered.

SELECT    * FROM    accounts;

-- D) Modify virtual column

SELECT    * FROM    accounts;

ALTER TABLE accounts 
MODIFY full_name VARCHAR2(52) 
GENERATED ALWAYS AS (last_name || ', ' || first_name); -- Table ACCOUNTS altered.

SELECT * FROM accounts;

-- E) Modify the default value of a column

SELECT * FROM accounts;

ALTER TABLE accounts
ADD status NUMBER( 1, 0 ) DEFAULT 1 NOT NULL ;  -- Table ACCOUNTS altered.

SELECT * FROM accounts;

-- To change the default value of the status column to 0, you use the following statement:
ALTER TABLE accounts 
MODIFY status DEFAULT 0;

-- We can add a new row to the accounts table to check whether the default value of the status column is 0 or 1:
INSERT INTO accounts ( first_name, last_name, email, phone )
VALUES ( 'Julia', 'Madden', 'julia.madden@oracletutorial.com', '410-555-0200' ); -- 1 row inserted.

SELECT * FROM accounts;

-----------------------------------------------------------------------------------------------------------------------
-- Oracle Drop Column using SET UNUSED COLUMN clause
-----------------------------------------------------------------------------------------------------------------------

-- we typically DROP the column LOGICALLY by using the ALTER TABLE SET UNUSED COLUMN statement as follows:

ALTER TABLE table_name 
SET UNUSED COLUMN column_name;
-- Once you execute the statement, the column is no longer visible for accessing.

-- During the off-peak hours, you can DROP the unused columns PHYSICALLY using the following statement:

ALTER TABLE table_name
DROP UNUSED COLUMNS;

-- Oracle SET UNUSED COLUMN example

-- LetТs create a table named suppliers for the demonstration:
DROP  TABLE suppliers;
CREATE TABLE suppliers (
    supplier_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    contact_name VARCHAR2(255) NOT NULL,
    company_name VARCHAR2(255),
    phone VARCHAR2(100) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    fax VARCHAR2(100) NOT NULL,
    PRIMARY KEY(supplier_id)
);
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Solomon F. Zamora',
        'Elit LLP',
        '1-245-616-6781',
        'enim.condimentum@pellentesqueeget.org',
        '1-593-653-6421');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Haley Franco',
        'Ante Vivamus Limited',
        '1-754-597-2827',
        'Nunc@ac.com',
        '1-167-362-9592');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Gail X. Tyson',
        'Vulputate Velit Eu Inc.',
        '1-331-448-8406',
        'sem@gravidasit.edu',
        '1-886-556-8494');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Alec N. Strickland',
        'In At Associates',
        '1-467-132-4527',
        'Lorem@sedtortor.com',
        '1-735-818-0914');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Britanni Holt',
        'Magna Cras Convallis Corp.',
        '1-842-554-5106',
        'varius@seddictumeleifend.ca',
        '1-381-532-1632');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Audra O. Ingram',
        'Commodo LLP',
        '1-934-490-5667',
        'dictum.augue.malesuada@idmagnaet.net',
        '1-225-217-4699');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Cody K. Chapman',
        'Tempor Arcu Inc.',
        '1-349-383-6623',
        'non.arcu.Vivamus@rutrumnon.co.uk',
        '1-824-229-3521');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Tobias Merritt',
        'Amet Risus Company',
        '1-457-675-2547',
        'felis@ut.net',
        '1-404-101-9940');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Ryder G. Vega',
        'Massa LLC',
        '1-655-465-4319',
        'dui.nec@convalliserateget.co.uk',
        '1-282-381-9477');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Arthur Woods',
        'Donec Elementum Lorem Foundation',
        '1-406-810-9583',
        'eros.turpis.non@anteMaecenasmi.co.uk',
        '1-462-765-8157');
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Lael Snider',
        'Ultricies Adipiscing Enim Corporation',
        '1-252-634-4780',
        'natoque.penatibus@in.com',
        '1-986-508-6373');

SELECT * FROM suppliers;  
DESC suppliers;

-- To logically drop the fax column from the suppliers table, you use the following statement:

ALTER TABLE suppliers 
SET UNUSED COLUMN fax;

SELECT * FROM suppliers; -- ohne FAX

DESC suppliers;  -- ohne FAX

-- !!!!!!!!!!!!!!!!  You can view the number of unused columns per table from the DBA_UNUSED_COL_TABS view:   !!!!!!!!!!!!!!

SELECT *
FROM   DBA_UNUSED_COL_TABS;

-- To drop the all unused columns from the suppliers table, you use the following statement:

ALTER TABLE suppliers 
DROP UNUSED COLUMNS;

-- Oracle Drop Column using DROP COLUMN clause

ALTER TABLE
    suppliers 
DROP (
        email,
        phone
    );
    
----------------?p------------------------------------------------------------------------------------------------------------
-- Oracle DROP TABLE
----------------------------------------------------------------------------------------------------------------------------

-- !!!! To move a table to the recycle bin or remove it entirely from the database, you use the DROP TABLE statement:

DROP TABLE schema_name.table_name
[CASCADE CONSTRAINTS | PURGE];

-- Basic Oracle DROP TABLE example

-- The following CREATE TABLE statement creates persons table for the demonstration:
CREATE TABLE persons (
    person_id NUMBER,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    PRIMARY KEY(person_id)
);  -- Table PERSONS created.

DROP TABLE persons; -- DROP TABLE persons;  -- 

-- Oracle DROP TABLE CASCADE CONSTRAINTS example

-- The following statements create two new tables named brands and cars:
CREATE TABLE brands(
    brand_id NUMBER PRIMARY KEY,
    brand_name varchar2(50)
);  --  Table BRANDS created.
CREATE TABLE cars(
    car_id NUMBER PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year NUMBER NOT NULL,
    plate_number VARCHAR(25),
    brand_id NUMBER NOT NULL,

    CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES brands(brand_id) ON DELETE CASCADE
    
);  --  Table CARS created.

DROP TABLE brands;  --  ORA-02449: unique/primary keys in table referenced by foreign keys

--  !!!!!!!!  The following statement returns all foreign key constraints of the cars table:   !!!!!!!!!!!!!!!!!!!!!!
SELECT
    a.table_name,
    a.column_name,
    a.constraint_name,
    c.owner,
    c.r_owner,
    c_pk.table_name r_table_name,
    c_pk.constraint_name r_pk
FROM
    all_cons_columns a
JOIN all_constraints c ON a.owner = c.owner
    AND a.constraint_name = c.constraint_name
JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
    AND c.r_constraint_name = c_pk.constraint_name
WHERE
    c.constraint_type = 'R'
    AND a.table_name = 'CARS';

DROP TABLE brands CASCADE CONSTRAINTS;  --  Table BRANDS dropped.

-- Oracle DROP TABLE PURGE example

-- The following statement drops the cars table using the PURGE clause:
DROP TABLE cars purge;

-- Drop multiple tables at once

-- Oracle provides no direct way to drop multiple tables at once. However, you can use the following PL/SQL block to do it:

CREATE TABLE test_1(c1 VARCHAR2(50));
CREATE TABLE test_2(c1 VARCHAR2(50));
CREATE TABLE test_3(c1 VARCHAR2(50));

BEGIN
  FOR rec IN
    (
      SELECT
        table_name
      FROM
        all_tables
      WHERE
        table_name LIKE 'TEST_%'
    )
  LOOP
    EXECUTE immediate 'DROP TABLE  '||rec.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;
/


----------------------------------------------------------------------------------------------------------------------------
-- Oracle TRUNCATE TABLE -- 
----------------------------------------------------------------------------------------------------------------------------

-- you use the DELETE statement without the WHERE clause as follows:
DELETE FROM table_name;

-- The following illustrates the syntax of the Oracle TRUNCATE TABLE statement:
TRUNCATE TABLE schema_name.table_name
[CASCADE]
[[ PRESERVE | PURGE] MATERIALIZED VIEW LOG ]]
[[ DROP | REUSE]] STORAGE ]

-- By default
TRUNCATE TABLE table_name;
-- you need to use the CASCADE clause:
TRUNCATE TABLE table_name CASCADE;
-- 


---------------------------------------------------------------------------------------------------------------------------
-- Oracle RENAME Table --
---------------------------------------------------------------------------------------------------------------------------
-- to rename an existing table in the database.

RENAME table_name TO new_name;

CREATE TABLE promotions(
    promotion_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    promotion_name varchar2(255),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    PRIMARY KEY(promotion_id),
    CHECK (end_date > start_date)
);  --  Table PROMOTIONS created.

CREATE OR REPLACE FUNCTION count_promotions
  RETURN NUMBER
IS
  v_count NUMBER;
BEGIN
  SELECT
    COUNT( * )
  INTO
    v_count
  FROM
    promotions;
  RETURN v_count;
END;  --  Function COUNT_PROMOTIONS compiled

RENAME promotions TO campaigns2;  --  Table renamed.

SELECT
    constraint_name,
    search_condition
FROM
    all_constraints
WHERE
    table_name = 'CAMPAIGNS2'
    AND constraint_type = 'C';

SELECT  -- COUNT_PROMOTIONS is INVALID
    owner,
    object_type,
    object_name
FROM
    all_objects
WHERE
    status = 'INVALID'
ORDER BY
    object_type,
    object_name;


---------------------------------------------------------------------------------------------------------------------------
-- Oracle Virtual Column -- 
---------------------------------------------------------------------------------------------------------------------------

-- values are calculated automatically using other column values, or another deterministic expression.

column_name [data_type] [GENERATED ALWAYS] AS (expression) [VIRTUAL]

-- Oracle virtual column examples

-- 1) Creating a table with a virtual column example.
-- In this parts table, the gross_margin column is the virtual column
CREATE TABLE parts(
    part_id INT GENERATED ALWAYS AS IDENTITY,
    part_name VARCHAR2(50) NOT NULL,
    capacity INT NOT NULL,
    cost DEC(15,2) NOT NULL,
    list_price DEC(15,2) NOT NULL,
    gross_margin AS ((list_price - cost) / cost),
    PRIMARY KEY(part_id)
);  --  Table PARTS created.
INSERT INTO parts(part_name, capacity, cost, list_price)
VALUES('G.SKILL TridentZ RGB Series 16GB (2 x 8GB)', 16, 95,105);

INSERT INTO parts(part_name, capacity, cost, list_price)
VALUES('G.SKILL TridentZ RGB Series 32GB (4x8GB)', 32, 205,220);

INSERT INTO parts(part_name, capacity, cost, list_price)
VALUES('G.SKILL TridentZ RGB Series 16GB (1 x 8GB)', 8, 50,70);

SELECT * FROM parts;

-- 2) Adding a virtual column to an existing table example

-- First, add a new column named capacity_description to the parts table using the ALTER TABLE column:
ALTER TABLE parts
ADD (
    capacity_description AS (
            CASE 
                WHEN capacity <= 8 THEN 'Small' 
                WHEN capacity > 8 AND capacity <= 16 THEN 'Medium'
                WHEN capacity > 16 THEN 'Large'
            END)
);  --  Table PARTS altered.

SELECT * FROM parts;

-- Advantages and disadvantages of virtual columns
-- Virtual columns provide the following advantages:
Virtual columns consume minimal space. Oracle only stores the metadata, not the data of the virtual columns.
Virtual columns ensure the values are always in sync with the source columns. For example, 
if you have a date column as the normal column and have the month, quarter, and year columns 
as the virtual columns. The values in the month, quarter, and year are always in sync with the date column.
Virtual columns help avoid using views to display derived values from other columns.

-- The disadvantage of virtual columns is:
Virtual columns may reduce query performance because their values are calculated at run-time.

-- Virtual column limitations
-- These are limitations of virtual columns:
Virtual columns are only supported in relational heap tables, 
but not in index-organized, external, object, cluster, or temporary tables.
The virtual column cannot be an Oracle-supplied datatype, a user-defined type, or LOB or LONG RAW.

-- The expression in the virtual column has the following restrictions:
It cannot refer to other virtual columns.
It cannot refer to normal columns of other tables.
It must return a scalar value.
It may refer to a deterministic user-defined function, however, if it does, 
the virtual column cannot be used as a partitioning key column.

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  Show virtual columns of a table  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- To show virtual columns of a table, you query from the all_tab_cols view:
SELECT 
    column_name, 
    virtual_column,
    data_default
FROM 
    all_tab_cols
WHERE owner = 'OT' 
AND table_name = 'PARTS';

SELECT * FROM PARTS;

-- Section 11. Oracle data types
Oracle data types --Ц give you an overview of the built-in Oracle data types.
NUMBER --Ц introduces you to the numeric data type and show you how to use it to define numeric columns for a table.
FLOAT --Ц demystify float data type in Oracle by practical examples.
CHAR --Ц learn about fixed-length character string.
NCHAR --Ц  show you how to store fixed-length Unicode character data and explain the differences between CHAR and NCHAR data types
VARCHAR2-- Ц introduce you to the variable-length character and show you how to define variable-length character columns in a table.
NVARCHAR2 --Ц learn how to store variable-length Unicode characters in the database.
DATE --Ц discuss the date and time data type and show you how to handle date-time data effectively.
TIMESTAMP --Ц introduce you how to store date and time with the fractional seconds precision.
INTERVAL --Ц focus on the interval data types to store periods of time.
TIMESTAMP WITH TIME ZONE --Ц learn how to store datetime with timezone data.



--------------------------------------------------------------------------------------------------------------------------------
-- Section 12. Constraints
--------------------------------------------------------------------------------------------------------------------------------

-- CONSTRAINTS --> RULES
-- EVERY TABLE has COLUMNS and CONSTRAINTS

--------------------------------------------------------------------------------------------------------------------------------
-- NOT NULL constraint -- column CANNOT contain NULL values, to be not empry
-- UNIQUE   constraint -- all values in colomn mast be DIFERENT
-- PRIMARY KEY         -- mast bee NOT NULL and UNIQUE, and NOT BE CHANGED over time
                       -- First, the primary key should be meaningless. Second, the primary keys should be compact (numeric).
-- CHECK constrain     -- 
--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE table_name (
    ...
    column_name data_type NOT NULL                                                              -- NOT NULL constraint
    
    column_name data_type UNIQUE                                                                -- UNIQUE constraint
    column_name data_type CONSTRAINT unique_constraint_name UNIQUE                              -- UNIQUE constraint
    
    column_name data_type PRIMARY KEY                                                           -- PRIMARY KEY
    PRIMARY KEY (column_name_1, column_name_2)                                                  -- PRIMARY KEY
    
    column_name data_type CHECK (expression) (z.B.: column_name > 0)                            -- CHECK constrain
    ...
    ...
    ...,
    CONSTRAINT unique_constraint_name UNIQUE(column_name)                                       -- UNIQUE constraint
    
    CONSTRAINT pk_constraint_name(table_name) PRIMARY KEY(column_name)                          -- PRIMARY KEY
    
    CONSTRAINT check_constraint_name CHECK (expresssion)                                        -- CHECK constrain
);

ALTER TABLE table_name MODIFY ( column_name NOT NULL);                                          -- NOT NULL constraint
ALTER TABLE table_name MODIFY ( column_name NULL);                                              -- NOT NULL constraint

ALTER TABLE table_name ADD CONSTRAINT unique_constraint_name UNIQUE(column_name1, column_nam2); -- UNIQUE constraint
ALTER TABLE table_name DISABLE CONSTRAINT unique_constraint_name;                               -- UNIQUE constraint
ALTER TABLE table_name ENABLE CONSTRAINT unique_constraint_name;                                -- UNIQUE constraint
ALTER TABLE table_name DROP CONSTRAINT unique_constraint_name;                                  -- UNIQUE constraint

ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY (column1, column2, ...);      -- PRIMARY KEY
ALTER TABLE table_name DROP CONSTRAINT primary_key_constraint_name;                             -- PRIMARY KEY
ALTER TABLE table_name DROP PRIMARY KEY;                                                        -- PRIMARY KEY
ALTER TABLE table_name DISABLE CONSTRAINT primary_key_constraint_name;                          -- PRIMARY KEY
ALTER TABLE table_name DISABLE PRIMARY KEY;                                                     -- PRIMARY KEY
ALTER TABLE table_name ENABLE CONSTRAINT primary_key_constraint_name;                           -- PRIMARY KEY
ALTER TABLE table_name ENABLE PRIMARY KEY;                                                      -- PRIMARY KEY

ALTER TABLE table_name ADD CONSTRAINT check_constraint_name CHECK(expression);                  -- CHECK constrain
ALTER TABLE parts ADD CONSTRAINT check_positive_cost CHECK (cost > 0);                          -- CHECK constrain
ALTER TABLE table_name DROP CONSTRAINT check_constraint_name;                                   -- CHECK constrain
ALTER TABLE table_name DISABLE CONSTRAINT check_constraint_name;                                -- CHECK constrain
ALTER TABLE table_name ENABLE CONSTRAINT check_constraint_name;                                 -- CHECK constrain

--------------------------------
-- Foreign key --
--------------------------------
-- The following statement illustrates the syntax of creating a foreign key constraint when you create a table:
CREATE TABLE child_table (
    ...
    CONSTRAINT fk_name
    FOREIGN KEY(col1, col2,...) REFERENCES parent_table(col1,col2) 
    ON DELETE [ CASCADE | SET NULL ]
);

ALTER TABLE child_table ADD CONSTRAINT fk_name FOREIGN KEY (col1,col2) REFERENCES parent_table(col1,col2);
ALTER TABLE child_table DROP CONSTRAINT fk_name;
ALTER TABLE child_table DISABLE CONSTRAINT fk_name;
ALTER TABLE child_table ENABLE CONSTRAINT fk_name;





