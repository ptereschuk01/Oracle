--- Section 1. Querying data
-- to retrieve data from a single table.
SELECT Ц show you how to query data from a single table.

-- Section 2. Sorting data
ORDER BY Ц sort the result set of a query in ascending or descending order.

-- Section 3. Filtering data
DISTINCT  Ц- introduce you how to eliminate duplicate rows from the output of a query. -- LINE 92
WHERE Ц- learn how to specify a condition for rows in the result set returned by a query.
Alias  --
AND Ц-- combine two or more Boolean expressions and return true if all expressions are true.
OR Ц-- combine two or more Boolean expressions and return true if one of the expressions is true.
FETCH -- show you how to limit rows returned by a query using the row limiting clause.
HAVING -- 
IN -- determine if a value matches any value in a list or a subquery.
BETWEEN -- filter data based on a range of values.
LIKE  -- perform matching based on specific patterns.
IS NULL and IS NOT NULL -- check if an expression or values in a column is NULL or not.

-- Section 4. Joining tables
-- A visual explanation of Oracle Joins Ц a brief introduction to joins in Oracle using visual illustrations.
INNER JOIN -- show you how to query rows from a table that have matching rows from another table.
LEFT JOIN -- introduce you to the left-join concept and learn how to use it to select rows from the left table that have or donТt have the matching rows in the right table.
RIGHT JOIN -- explain the right-join concept and show you how to apply it to query rows from the right table that have or donТt have the matching rows in the left table.
FULL OUTER JOIN -- describe how to use the full outer join or full join to query data from two tables.
CROSS JOIN -- cover how to make a Cartesian product from multiple tables.
Self-join -- show you how to join a table to itself to query hierarchical data or compare rows within the same table.

-- Section 5. Grouping data
GROUP BY Ц teach you how to group rows into subgroups and apply an aggregate function for each group
HAVING Ц show you how to filter a group of rows.

---------------------------------------------------------------------------------------------------
-- Section 2. Sorting data
ORDER BY clause -- to sort the result set by one or more columns in ascending or descending order.
---------------------------------------------------------------------------------------------------
SELECT  column_1, column_2, column_3, ...
FROM    table_name
ORDER BY
    column_1 [ASC | DESC] [NULLS FIRST | NULLS LAST],
    column_2 [ASC | DESC] [NULLS FIRST | NULLS LAST],
    ...
-- A) Sorting rows by a column example
SELECT name, address, credit_limit
FROM   customers
--ORDER BY  name; -- ASC
ORDER BY  name DESC; -- DESC

-- B) Sorting rows by multiple columns example
-- To sort multiple columns, you separate each column in the ORDER BY clause by a comma.
SELECT
	first_name,
	last_name
FROM
	contacts
ORDER BY
	first_name,
	last_name DESC;

-- C) Sort rows by columnТs positions example
SELECT
    name,
    credit_limit
FROM
    customers
ORDER BY
    2 DESC,
    1;

-- D) Sorting rows with NULL values examples
SELECT country_id, city, state  FROM  locations ORDER BY  city,  state;
SELECT country_id, city, state  FROM  locations ORDER BY  state ASC NULLS FIRST;
SELECT country_id, city, state  FROM  locations ORDER BY  state ASC NULLS LAST;

-- E) Sorting rows by the result of a function or expression
SELECT
	customer_id,
	name
FROM
	customers
ORDER BY
	UPPER( name );

-- F) Sorting by date example

SELECT order_id, customer_id, status, order_date
FROM   orders
ORDER BY order_date DESC;

SET VERIFY ON
SELECT employee_id, last_name, e.sal
FROM   employees e
WHERE  employee_id = &employee_num;



-----------------------------------------------------------------------
-- Section 3. Filtering data
-----------------------------------------------------------------------
-- DISTINCT 
-- C) Oracle SELECT DISTINCT and NULL
-- The DISTINCT treats NULL values to be duplicates of each other. If you use the SELECT DISTINCT statement to query data 
-- from a column that has many NULL values, the result set will include only one NULL value.
SELECT  state  
FROM    locations
ORDER BY  state NULLS FIRST;
-- As you can see, ONLY ONE NULL VALUES is returned.
SELECT  DISTINCT state
FROM    locations
ORDER BY state NULLS FIRST;

--------------------------------------------
-- WHERE 
--------------------------------------------
=	/ !=,<>	 /  >	/   <	/   >=	/  <=	
IN	-- Equal to any value in a list of values
ANY/ SOME / ALL	-- Compare a value to a list or subquery. It must be preceded by another operator such as =, >, <.
NOT IN	-- Not equal to any value in a list of values
[NOT] BETWEEN n and m	-- Equivalent to [Not] >= n and <= y.
[NOT] EXISTS	-- Return true if subquery returns at least one row
IS [NOT] NULL	-- NULL test

-------------------------------------------
-- Alias
-------------------------------------------
-- column alias 
SELECT first_name AS forename, last_name  AS surname  --  SURNAME
FROM   employees;
SELECT first_name    forename, last_name     surname  --  SURNAME
FROM   employees;
SELECT first_name  "forename", last_name    "surname" --  surname
FROM   employees;
-- column alias with ORDER BY clause
SELECT 
  product_name,
  list_price - standard_cost AS gross_profit
FROM
  products
ORDER BY
  gross_profit DESC;


-------------------------------------------
-- FETCH
-------------------------------------------
-- [ OFFSET offset ROWS]  -- OFFSET clause specifies the number of rows to skip before the row limiting starts
-- FETCH NEXT [ row_count | percent PERCENT ] ROWS -- FETCH clause specifies the number of rows or percentage of rows to return
-- [ ONLY | WITH TIES ]  -- ONLY returns exactly the number of rows or percentage of rows after FETCH NEXT,
                          -- returns additional rows with the same sort key as the last row fetched

SELECT product_name, quantity
FROM   ot.inventories  
    INNER JOIN ot.products USING(product_id)
ORDER BY  quantity DESC
-- FETCH 
--OFFSET 0 ROWS FETCH NEXT 10         ROWS ONLY;  -- just 10 rows
--OFFSET 0 ROWS FETCH NEXT 10         ROWS WITH TIES;  -- 12 rows
--              FETCH FIRST 5 PERCENT ROWS ONLY;  -- table has 1112 rows, therefore, 5% of 1112 is 55.6 which is rounded up to 56 (rows)
                FETCH FIRST 5 PERCENT ROWS WITH TIES;  -- 61 quantity = 225  56, 57, 58, 59, 60, 61

---------------------------------------
-- HAVING
---------------------------------------
-- In this statement, the HAVING clause appears immediately after the GROUP BY clause.
-- If you use the HAVING clause without the GROUP BY clause, the HAVING clause works like the WHERE clause.
-- Note that the HAVING clause filters groups of rows while the WHERE clause filters rows. 

-- To find the orders whose values are greater than 1 million, you add a HAVING clause as follows:
SELECT
    order_id,
    SUM( unit_price * quantity ) order_value
FROM
    ot.order_items
GROUP BY
    order_id
HAVING
    SUM( unit_price * quantity ) > 1000000
ORDER BY
    order_value DESC;

-- statement finds orders whose values are greater than 500,000 and the number of products in each order is between 10 and 12
SELECT
    order_id,
    COUNT( item_id ) item_count,
    SUM( unit_price * quantity ) total
FROM
    ot.order_items
GROUP BY
    order_id
HAVING
    SUM( unit_price * quantity ) > 500000 AND
    COUNT( item_id ) BETWEEN 10 AND 12
ORDER BY
    total DESC,
    item_count DESC;

----------------------------------------
-- IN
----------------------------------------
-- IN operator determines whether a value matches any values in a list or a subquery.
expression [NOT] IN (v1,v2,...)
expression [NOT] IN (subquery)

-- Note that the expression:
salesman_id NOT IN (60,61,62);
salesman_id IN (60,61,62);
-- has the same effect as:
salesman_id != 60  AND  salesman_id != 61  AND  salesman_id != 62;
salesman_id = 60  AND  salesman_id = 61  AND  salesman_id = 62;

----------------------------------------------
-- BETWEEN   >= AND <=
----------------------------------------------
-- BETWEEN operator to select rows whose values are in a specified range.
expression [ NOT ] BETWEEN low AND high
-- The low and high values can be literals or expressions.
-- To be able to compare, the data types of expression, low, and high must be the same.
-- The BETWEEN operator is often used in the WHERE clause of the SELECT, DELETE, and UPDATE statement.

-- A) Oracle BETWEEN numeric values example
SELECT
    product_name,
    standard_cost
FROM
    products
WHERE
    standard_cost BETWEEN 500 AND 600
    -- standard_cost NOT BETWEEN 500 AND 600
ORDER BY
    standard_cost;
-- B) Oracle BETWEEN dates example
SELECT
    order_id,
    customer_id,
    status,
    order_date
FROM
    ot.orders
WHERE
    order_date BETWEEN DATE '2016-12-01' AND DATE '2016-12-31'
ORDER BY
    order_date;
    
----------------------------------------
-- LIKE 
----------------------------------------
-- 
expresion [NOT] LIKE pattern [ ESCAPE escape_characters ]
-- % (percent) matches any string of zero or more character.
-- _ (underscore) matches any single character.

-- A) % wildcard character examples
SELECT  first_name, last_name, phone
FROM    ot.contacts
WHERE
    --last_name LIKE 'St%'
    last_name NOT LIKE 'St%'
    --UPPER( last_name ) LIKE 'ST%'
    --LOWER(last_name LIKE 'st%'
    --last_name LIKE '%er'
    --phone NOT LIKE '+1%'
ORDER BY
    last_name;
-- B) _ wildcard character examples
SELECT first_name, last_name, email, phone
FROM   ot.contacts
WHERE
    first_name LIKE 'Je_i'
ORDER BY first_name;
-- C) Mixed wildcard characters example
SELECT
    first_name,
    last_name,
    email,
    phone
FROM
    contacts
WHERE
    first_name LIKE 'Je_%';
-- D) ESCAPE clause examples
CREATE TABLE discounts
  ( product_id NUMBER, 
    discount_message VARCHAR2( 255 ) NOT NULL,
    PRIMARY KEY( product_id )
  );
INSERT INTO discounts(product_id, discount_message)
VALUES(1,  'Buy 1 and Get 25% OFF on 2nd ');
INSERT INTO discounts(product_id, discount_message)
VALUES(2,   'Buy 2 and Get 50% OFF on 3rd ');
INSERT INTO discounts(product_id, discount_message)
VALUES(3,   'Buy 3 Get 1 free');
-----
SELECT
	product_id,
	discount_message
FROM
	discounts
WHERE
	discount_message LIKE '%25!%%' ESCAPE '!';

-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-- IS NULL and IS NOT NULL 
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-- Oracle IS NULL and IS NOT NULL operators to check if a value in a column or an expression is NULL or not.
NVL
NVL2
COALESCE
--‘ункци€ NVL (expr1, expr2) возвращает значение expr1. ¬ случаеб если expr1 is null, то функци€ NVL возвращает значение expr2.
SELECT first_name, COMMISSION_PCT COMMISSION, NVL(COMMISSION_PCT, 0) nvl_COMMISSION FROM hr.employees;

--‘ункци€ NVL2 (expr1, expr2, expr3)
--expr1 Ц выражение
--expr2 Ц если expr1 Уis not nullФ будет возвращено expr2
--expr3 Ц если expr1 Уis nullФ будет возвращено expr3
SELECT first_name, COMMISSION_PCT, NVL2(COMMISSION_PCT, 0, 13) FROM hr.employees;

--≈сли передать в COALESCE три аргумента, то будет возвращен первый, если он не NULL, иначе второй, если он не NULL, иначе третий
SELECT first_name, COMMISSION_PCT, MANAGER_ID
, COALESCE(COMMISSION_PCT, MANAGER_ID, 777) FROM hr.employees
WHERE first_name IN ('John', 'Peter', 'Steven') ;


-- онструкци€ CASE провер€ет выражение
SELECT COMMISSION_PCT AS COMMISSION_PCT_13,
  CASE NVL(COMMISSION_PCT, 0) 
  WHEN 0 THEN 1000 
  --ELSE WHEN 1 THEN 1111 -- Ќ≈ –јЅќ“ј≈“ ¬“ќ–ќ… ќѕ≈–ј“ќ– !!! --
  ELSE COMMISSION_PCT
  END AS "NULL = 13"
FROM hr.employees;

-- онструкци€ DECODE провер€ет выражение
SELECT DISTINCT COMMISSION_PCT,
  DECODE (NVL(COMMISSION_PCT, 0),
    0, 'No money',
    0.1, 'Low money',
  COMMISSION_PCT) AS DECODE_COMMISSION_PCT
FROM hr.employees;

----------------------------------
-- -- Section 4. Joining tables
----------------------------------
CREATE TABLE palette_a (
    id INT PRIMARY KEY,
    color VARCHAR2 (100) NOT NULL
);

CREATE TABLE palette_b (
    id INT PRIMARY KEY,
    color VARCHAR2 (100) NOT NULL
);

INSERT INTO palette_a (id, color)
VALUES (1, 'Red');

INSERT INTO palette_a (id, color)
VALUES (2, 'Green');

INSERT INTO palette_a (id, color)
VALUES (3, 'Blue');

INSERT INTO palette_a (id, color)
VALUES (4, 'Purple');

-- insert data for the palette_b
INSERT INTO palette_b (id, color)
VALUES (1, 'Green');

INSERT INTO palette_b (id, color)
VALUES (2, 'Red');

INSERT INTO palette_b (id, color)
VALUES (3, 'Cyan');

INSERT INTO palette_b (id, color)
VALUES (4, 'Brown');
----- 

select * from palette_a;
select * from palette_b;

-- inner join
SELECT  a.id id_a, a.color color_a,
        b.id id_b, b.color color_b
FROM palette_a a INNER JOIN palette_b b ON a.color = b.color;
-- left outer join
SELECT
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    hr.palette_a a
LEFT JOIN hr.palette_b b ON a.color = b.color;
-- left outer join ONLY rows fromthe left table
SELECT
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a
LEFT JOIN palette_b b ON a.color = b.color
WHERE b.id IS NULL;

--  right outer join
SELECT
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a
RIGHT JOIN palette_b b ON a.color = b.color;
-- right outer join ONLY rows fromthe right table
SELECT
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a
RIGHT JOIN palette_b b ON a.color = b.color
WHERE a.id IS NULL;

-- full outer join
SELECT
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a
FULL OUTER JOIN palette_b b ON a.color = b.color;
-- full outer join ONLY rows unique for both table
SELECT
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a
FULL JOIN palette_b b ON a.color = b.color
WHERE a.id IS NULL OR b.id IS NULL;
---------------
-- INNER JOIN 
--------------
-- To query data from two or more related tables, you use the INNER JOIN clause.
-- Oracle INNER JOIN example
SELECT  *
FROM   ot.orders
INNER JOIN ot.order_items ON order_items.order_id = orders.order_id
-- INNER JOIN ot.order_items USING(order_id)
ORDER BY order_date DESC;
-- Oracle INNER JOIN with USING clause
SELECT  *
FROM   ot.orders
INNER JOIN ot.order_items USING( order_id )
ORDER BY  order_date DESC;
-- Oracle INNER JOIN Ц joining multiple tables

SELECT  name AS customer_name, order_id, order_date, item_id, product_name, quantity, unit_price
FROM   ot.orders
INNER JOIN ot.order_items USING(order_id)
INNER JOIN ot.customers   USING(customer_id)
INNER JOIN ot.products    USING(product_id)
ORDER BY order_date DESC, order_id DESC, item_id ASC;

-- LEFT OUTER JOIN
SELECT order_id, name AS customer_name, status, first_name, last_name
FROM
    orders
LEFT JOIN employees ON
    employee_id = salesman_id
LEFT JOIN customers USING(customer_id)
ORDER BY
    order_date DESC;

---------------------------------------------
-- Section 5. Grouping data
---------------------------------------------
-- GROUP BY to group rows into groups
--------------------------------------
-- The GROUP BY clause is used in a SELECT statement to group rows into a set of summary rows 
-- by values of columns or expressions. The GROUP BY clause returns one row per group.

-- A) Oracle GROUP BY basic example
SELECT  status
FROM    orders;
GROUP BY status;

-- B) Oracle GROUP BY with an aggregate function example
SELECT
    customer_id,
    COUNT( order_id )
FROM
    orders
GROUP BY
    customer_id
ORDER BY
    customer_id;

-- C) Oracle GROUP BY with an expression example
SELECT
    EXTRACT(YEAR FROM order_date) YEAR,
    COUNT( order_id )
FROM  orders
GROUP BY
    EXTRACT(YEAR FROM order_date)
ORDER BY YEAR;

-- D) Oracle GROUP BY with WHERE clause example
SELECT 
   name, 
   COUNT( order_id ) 
FROM orders 
   INNER JOIN customers USING(customer_id) 
WHERE 
   status = 'Shipped'
GROUP BY 
   name 
ORDER BY 
   name;
    
-- E) Oracle GROUP BY with ROLLUP example
SELECT
    customer_id,
    status,
    SUM( quantity * unit_price ) sales
FROM
    orders
INNER JOIN order_items
        USING(order_id)
GROUP BY
    ROLLUP(
        customer_id,
        status
    );

SELECT
   salesman_id,
   customer_id,
   SUM(quantity * unit_price) amount
FROM
   ot.orders
INNER JOIN ot.order_items USING (order_id)
WHERE
   status      = 'Shipped' AND 
   salesman_id IS NOT NULL AND 
   EXTRACT(YEAR FROM order_date) = 2017
GROUP BY --salesman_id,customer_id;
   ROLLUP(salesman_id,customer_id);

---------------------------------------
-- HAWING
---------------------------------------
-- In this statement, the HAVING clause appears immediately after the GROUP BY clause.
-- If you use the HAVING clause without the GROUP BY clause, the HAVING clause works like the WHERE clause.
-- Note that the HAVING clause filters groups of rows while the WHERE clause filters rows. 

-- To find the orders whose values are greater than 1 million, you add a HAVING clause as follows:
SELECT
    order_id,
    SUM( unit_price * quantity ) order_value
FROM
    ot.order_items
GROUP BY
    order_id
HAVING
    SUM( unit_price * quantity ) > 1000000
ORDER BY
    order_value DESC;

-- statement finds orders whose values are greater than 500,000 and the number of products in each order is between 10 and 12
SELECT
    order_id,
    COUNT( item_id ) item_count,
    SUM( unit_price * quantity ) total
FROM
    ot.order_items
GROUP BY
    order_id
HAVING
    SUM( unit_price * quantity ) > 500000 AND
    COUNT( item_id ) BETWEEN 10 AND 12
ORDER BY
    total DESC,
    item_count DESC;
    