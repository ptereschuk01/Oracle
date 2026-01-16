------------------------------------------------------------------------------------------------------------------------
-- Oracle Windows Functions
------------------------------------------------------------------------------------------------------------------------
'''
📝 Window Functions – Exam Cheat Sheet (DE + EN)
Frage / Question	Kurzantwort / Short Answer
1. SUM(grade) OVER (PARTITION BY student_name)?	
    Berechnet Summe aller Noten pro Student / Calculates total grades per student, keeps all rows
2. Unterschied ROW_NUMBER(), RANK(), DENSE_RANK()?	
    ROW_NUMBER: fortlaufend, auch bei Duplikaten / sequential, ignores duplicates
    RANK: gleiche Werte = gleiche Rang, Lücken / same rank, gaps
    DENSE_RANK: gleiche Werte = gleiche Rang, keine Lücken / same rank, no gaps
3. LAG() / LEAD()?	LAG: vorherige Zeile / previous row
    LEAD: nächste Zeile / next row
4. FIRST_VALUE() / LAST_VALUE()?	
    FIRST_VALUE: erster Wert im Fenster / first value in window
    LAST_VALUE: letzter Wert, meist mit ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING / last value, usually with rows between unbounded preceding and following
5. PARTITION BY?	
    Teilt Daten in Gruppen / divides data into partitions (groups)
6. ORDER BY in OVER?	
    Bestimmt Reihenfolge für Ranking, LAG/LEAD / defines order for ranking, LAG/LEAD
7. WHERE vs HAVING?	
    WHERE: filtert Zeilen vor Aggregation / filters rows before aggregation
    HAVING: filtert Gruppen nach Aggregation / filters groups after aggregation
8. COUNT(*) OVER (PARTITION BY student_name)?	
    Zählt Zeilen pro Student, ohne Zeilen zu reduzieren / counts rows per student, keeps all rows
9. SUM(grade) vs SUM(grade) OVER(PARTITION BY student_name)?	
    SUM(grade): reduziert Resultset / reduces result set
    SUM(...) OVER(...): behält alle Zeilen + Aggregat / keeps all rows + aggregate
10. Erste und letzte Note eines Schülers im Quartal?	
    FIRST_VALUE() und LAST_VALUE() mit ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING / FIRST_VALUE() and LAST_VALUE() with rows between unbounded preceding and following
'''
---

-- Oracle SQL: Window Functions
-- Didaktisches Beispiel mit parallelen DE / EN Kommentaren (Uni-Style)
-----------------------------------------------------------------------

-- Beispieltabelle für Window Functions / Example table for window functions
-- drop table student_grades;

create table student_grades
(
student_name varchar2(20),  -- Name des Studenten / Student name
subject_name varchar2(20),  -- Fach / Subject
grade        number(3,2)    -- Note / Grade
);

-- Einfügen von Beispieldaten / Insert sample data
insert into student_grades values ('Peter', 'Mathematics', 3);
insert into student_grades values ('Peter', 'Russian',     4);
insert into student_grades values ('Peter', 'Physics',     5);
insert into student_grades values ('Peter', 'History',     4);

insert into student_grades values ('Masha', 'Mathematics', 4);
insert into student_grades values ('Masha', 'Russian',     3);
insert into student_grades values ('Masha', 'Physics',     5);
insert into student_grades values ('Masha', 'History',     3);

commit; -- Änderungen speichern / Persist changes

---

-- Klassen von Window Functions / Categories of window functions:
-- 1) Aggregatfunktionen / Aggregate functions
-- 2) Ranking-Funktionen / Ranking functions
-- 3) Value-Funktionen   / Value (offset) functions
---------------------------------------------------

---

## -- 1) Aggregatfunktionen / Aggregate window functions

-- Aggregation ohne Reduktion der Zeilenanzahl / Aggregation without collapsing rows

select
student_name,
subject_name,
grade,

```
-- Gesamtsumme der Noten pro Student / Total sum of grades per student
sum(grade) over (partition by student_name) as total_grade,

-- Durchschnittsnote pro Student / Average grade per student
avg(grade) over (partition by student_name) as average_grade,

-- Anzahl der Fächer pro Student / Number of subjects per student
count(*) over (partition by student_name) as subject_count,

-- Niedrigste Note pro Student / Minimum grade per student
min(grade) over (partition by student_name) as min_grade,

-- Höchste Note pro Student / Maximum grade per student
max(grade) over (partition by student_name) as max_grade
```

from student_grades;

---

## -- 2) Ranking-Funktionen / Ranking functions

-- ORDER BY in OVER bestimmt die Rangfolge / ORDER BY inside OVER defines ranking order

select
student_name,
subject_name,
grade,

```
-- Fortlaufende Zeilennummer ohne Rücksicht auf Duplikate / Sequential row number ignoring duplicates
row_number() over (
    partition by student_name
    order by grade desc
) as row_num,

-- Rang mit Lücken bei gleichen Werten / Rank with gaps for duplicate values
rank() over (
    partition by student_name
    order by grade desc
) as rank_value,

-- Rang ohne Lücken / Rank without gaps
dense_rank() over (
    partition by student_name
    order by grade desc
) as dense_rank_value
```

from student_grades;

---

## -- 3) Value-Funktionen / Offset functions

-- Zugriff auf vorherige oder nächste Zeile / Access previous or next rows within a window

-- Tabelle mit Quartalsnoten / Table with quarterly grades
-- drop table grades_quarter;

create table grades_quarter
(
student_name varchar2(20),  -- Student / Student
quarter_name varchar2(10),  -- Quartal / Quarter
subject_name varchar2(20),  -- Fach / Subject
grade        number(3,2)    -- Note / Grade
);

-- Notenverlauf über mehrere Quartale / Grade development across quarters
insert into grades_quarter values ('Петя', 'Q1', 'Physik', 4);
insert into grades_quarter values ('Петя', 'Q2', 'Physik', 3);
insert into grades_quarter values ('Петя', 'Q3', 'Physik', 4);
insert into grades_quarter values ('Петя', 'Q4', 'Physik', 5);

commit; -- Änderungen speichern / Persist changes

-- Vergleich vorheriger und nächster Werte / Compare previous and next values
select
student_name,
quarter_name,
subject_name,
grade,

```
-- Vorherige Note im Verlauf / Previous grade in sequence
lag(grade) over (
    partition by student_name
    order by quarter_name
) as previous_grade,

-- Nächste Note im Verlauf / Next grade in sequence
lead(grade) over (
    partition by student_name
    order by quarter_name
) as next_grade
```

from grades_quarter;

---

## -- FIRST_VALUE und LAST_VALUE

-- Zugriff auf erste und letzte Werte im Fenster / Access first and last values in window

select
student_name,
quarter_name,
grade,

```
-- Erste Note im Fenster / First grade in window
first_value(grade) over (
    partition by student_name
    order by quarter_name
) as first_grade,

-- Letzte Note im gesamten Fenster / Last grade across entire window
last_value(grade) over (
    partition by student_name
    order by quarter_name
    rows between unbounded preceding and unbounded following
) as last_grade
```

from grades_quarter;

