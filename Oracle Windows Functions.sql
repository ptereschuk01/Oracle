------------------------------------------------------------------------------------------------------------------------
-- Oracle Windows Functions
------------------------------------------------------------------------------------------------------------------------

-- Для примеров будем использовать небольшую таблицу
-- drop table student_grades;
create table student_grades 
( 
    name    varchar2(20), 
    subject varchar2(20),
    grade   NUMBER(3,2)
);

insert into student_grades 
VALUES  ('Петя', 'математика',3);
insert into student_grades 
VALUES  ('Петя', 'русский', 4);
insert into student_grades 
VALUES  ('Петя', 'физика', 5);
insert into student_grades 
VALUES  ('Петя', 'история', 4);
insert into student_grades 
VALUES  ('Маша', 'математика', 4);
insert into student_grades 
VALUES  ('Маша', 'русский', 3);
insert into student_grades 
VALUES  ('Маша', 'физика', 5);
insert into student_grades 
VALUES  ('Маша', 'история', 3);

--SELECT * FROM student_grades;

-- Классы Оконных функций
-- Множество оконных функций можно разделять на 3 класса:

-- Агрегирующие (Aggregate)
-- Ранжирующие (Ranking)
-- Функции смещения (Value)

-- Агрегирующие (Aggregate)

select name, subject, grade,
sum(grade) over (partition by name) as sum_grade,
avg(grade) over (partition by name) as avg_grade,
count(grade) over (partition by name) as count_grade,
min(grade) over (partition by name) as min_grade,
max(grade) over (partition by name) as max_grade
from student_grades

-- Ранжирующие (Ranking)

-- В ранжирующих функция под ключевым словом OVER обязательным идет указание условия ORDER BY, по которому будет 
-- происходить сортировка ранжирования. 

-- ROW_NUMBER() - функция вычисляет последовательность ранг (порядковый номер) строк внутри партиции, НЕЗАВИСИМО от того, 
--                есть ли в строках повторяющиеся значения или нет.
-- RANK()       - функция вычисляет ранг каждой строки внутри партиции. Если есть повторяющиеся значения, 
--                функция возвращает одинаковый ранг для таких строчек, пропуская при этом следующий числовой ранг. 
-- DENSE_RANK() - то же самое что и RANK, только в случае одинаковых значений DENSE_RANK 
--                не пропускает следующий числовой ранг, а идет последовательно.
-- Для SQL пустые NULL значения будут определяться одинаковым рангом

select name, subject, grade,
row_number() over (partition by name, grade order by grade desc) "row_number",
row_number() over (partition by name order by grade desc) "row_number",
rank() over (partition by name order by grade desc) "rank",
dense_rank() over (partition by name order by grade desc) "dense_rank"
from student_grades;

-- Функции смещения:
-- Это функции, которые позволяют перемещаясь по выделенной партиции таблицы обращаться к предыдущему значению строки
-- или крайним значениям строк в партиции.

-- LAG()    - функция, возвращающая предыдущее значение столбца по порядку сортировки.
-- LEAD()   - функция, возвращающая следующее значение столбца по порядку сортировки.

-- На простом примере видно, как можно в одной строке получить текущую оценку, предыдущую и следующую оценки Пети в четвертях.

--создание таблицы 
create table grades_quartal 
(
    name    varchar2(20),
    quartal varchar2(20),
    subject varchar2(20),
    grade   NUMBER(3,2));

--наполнение таблицы данными
insert into student_grades 
values ('Петя', '1 четверть', 'физика', 4);
insert into grades_quartal
values ('Петя', '2 четверть', 'физика', 3);
insert into grades_quartal
values ('Петя', '3 четверть', 'физика', 4);
insert into grades_quartal
values ('Петя', '4 четверть', 'физика', 5);

select * from grades_quartal;

select name, quartal, subject, grade, 
lag(grade) over (order by quartal) as previous_grade,
lead(grade) over (order by quartal) as next_grade
from grades_quartal;


FIRST_VALUE()
select name, quartal, grade, 
FIRST_VALUE(grade) over (order by name) as FIRST_VALUE,
LAST_VALUE(grade) over (order by name) as LAST_VALUE
from grades_quartal;