------------------------------------------------------------------------------------------------------------------------
-- Oracle Windows Functions
------------------------------------------------------------------------------------------------------------------------

-- ��� �������� ����� ������������ ��������� �������
-- drop table student_grades;
create table student_grades 
( 
    name    varchar2(20), 
    subject varchar2(20),
    grade   NUMBER(3,2)
);

insert into student_grades 
VALUES  ('����', '����������',3);
insert into student_grades 
VALUES  ('����', '�������', 4);
insert into student_grades 
VALUES  ('����', '������', 5);
insert into student_grades 
VALUES  ('����', '�������', 4);
insert into student_grades 
VALUES  ('����', '����������', 4);
insert into student_grades 
VALUES  ('����', '�������', 3);
insert into student_grades 
VALUES  ('����', '������', 5);
insert into student_grades 
VALUES  ('����', '�������', 3);

--SELECT * FROM student_grades;

-- ������ ������� �������
-- ��������� ������� ������� ����� ��������� �� 3 ������:

-- ������������ (Aggregate)
-- ����������� (Ranking)
-- ������� �������� (Value)

-- ������������ (Aggregate)

select name, subject, grade,
sum(grade) over (partition by name) as sum_grade,
avg(grade) over (partition by name) as avg_grade,
count(grade) over (partition by name) as count_grade,
min(grade) over (partition by name) as min_grade,
max(grade) over (partition by name) as max_grade
from student_grades

-- ����������� (Ranking)

-- � ����������� ������� ��� �������� ������ OVER ������������ ���� �������� ������� ORDER BY, �� �������� ����� 
-- ����������� ���������� ������������. 

-- ROW_NUMBER() - ������� ��������� ������������������ ���� (���������� �����) ����� ������ ��������, ���������� �� ����, 
--                ���� �� � ������� ������������� �������� ��� ���.
-- RANK()       - ������� ��������� ���� ������ ������ ������ ��������. ���� ���� ������������� ��������, 
--                ������� ���������� ���������� ���� ��� ����� �������, ��������� ��� ���� ��������� �������� ����. 
-- DENSE_RANK() - �� �� ����� ��� � RANK, ������ � ������ ���������� �������� DENSE_RANK 
--                �� ���������� ��������� �������� ����, � ���� ���������������.
-- ��� SQL ������ NULL �������� ����� ������������ ���������� ������

select name, subject, grade,
row_number() over (partition by name, grade order by grade desc) "row_number",
row_number() over (partition by name order by grade desc) "row_number",
rank() over (partition by name order by grade desc) "rank",
dense_rank() over (partition by name order by grade desc) "dense_rank"
from student_grades;

-- ������� ��������:
-- ��� �������, ������� ��������� ����������� �� ���������� �������� ������� ���������� � ����������� �������� ������
-- ��� ������� ��������� ����� � ��������.

-- LAG()    - �������, ������������ ���������� �������� ������� �� ������� ����������.
-- LEAD()   - �������, ������������ ��������� �������� ������� �� ������� ����������.

-- �� ������� ������� �����, ��� ����� � ����� ������ �������� ������� ������, ���������� � ��������� ������ ���� � ���������.

--�������� ������� 
create table grades_quartal 
(
    name    varchar2(20),
    quartal varchar2(20),
    subject varchar2(20),
    grade   NUMBER(3,2));

--���������� ������� �������
insert into student_grades 
values ('����', '1 ��������', '������', 4);
insert into grades_quartal
values ('����', '2 ��������', '������', 3);
insert into grades_quartal
values ('����', '3 ��������', '������', 4);
insert into grades_quartal
values ('����', '4 ��������', '������', 5);

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