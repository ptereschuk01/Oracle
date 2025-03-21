------------------------------------------------------------------------------------------------------------------------
-- Oracle Date Functions
------------------------------------------------------------------------------------------------------------------------
SELECT
ADD_MONTHS(DATE '2016-02-29', 1) "ADD_MONTHS"-- 31-MAR-16	Add a number of months (n) to a date and return the same day which is n of months away.
, CURRENT_DATE "CURRENT_DATE"	  --06-AUG-2017 19:43:44	Return the current date and time in the session time zone
, CURRENT_TIMESTAMP "CURRENT_TIMESTAMP" -- FROM dual; -- 06-AUG-17 08.26.52.742000000 PM -07:00	Return the current date and time with time zone in the session time zone
, DBTIMEZONE "DBTIMEZONE" 	 --07:00	Get the current database time zone
, EXTRACT(YEAR FROM SYSDATE) "EXTRACT YEAR"  -- 2020 Extract a value of a date time field e.g., YEAR, MONTH, DAY, … from a date time value.
, FROM_TZ(TIMESTAMP '2017-08-08 08:09:10', '-09:00') "FROM_TZ" --  FROM dual;-- 08-AUG-17 08.09.10.000000000 AM -09:00	Convert a timestamp and a time zone to a TIMESTAMP WITH TIME ZONE value

, LAST_DAY(DATE '2016-02-01') "LAST_DAY"	-- 29-FEB-16	Gets the last day of the month of a specified date.
, LOCALTIMESTAMP "LOCALTIMESTAMP" -- FROM dual	 06-AUG-17 08.26.52.742000000 PM	Return a TIMESTAMP value that represents the current date and time in the session time zone.
, MONTHS_BETWEEN( DATE '2017-07-01', DATE '2017-01-01' ) "MONTHS_BETWEEN"--	6	Return the number of months between two dates.
, NEW_TIME( TO_DATE( '08-07-2017 01:30:45', 'MM-DD-YYYY HH24:MI:SS' ), 'AST', 'PST' ) "NEW_TIME"--	 06-AUG-2017 21:30:45	Convert a date in one time zone to another
, NEXT_DAY( DATE '2000-01-01', 'SUNDAY' ) "NEXT_DAY"	-- 02-JAN-00	Get the first weekday that is later than a specified date.
, ROUND(DATE '2017-07-16', 'MM') "ROUND" --	 01-AUG-17	Return a date rounded to a specific unit of measure.
, SESSIONTIMEZONE "SESSIONTIMEZONE" --	 -07:00	Get the session time zone
, SYSDATE "SYSDATE" --	Return the current system date and time of the operating system where the Oracle Database resides.
, SYSTIMESTAMP "SYSTIMESTAMP" -- FROM dual;	--01-AUG-17 01.33.57.929000000 PM -07:00	Return the system date and time that includes fractional seconds and time zone.
, TO_CHAR( DATE'2017-01-01', 'DL' ) "TO_CHAR" --	 Sunday, January 01, 2017	Convert a DATE or an INTERVAL value to a character string in a specified format.
, TO_DATE( '01 Jan 2017', 'DD MON YYYY' ) "TO_DATE" --	 01-JAN-17	Convert a date which is in the character string to a DATE value.
, TRUNC(DATE '2017-07-16', 'MM') "TRUNC"	 --01-JUL-17	Return a date truncated to a specific unit of measure.
, TZ_OFFSET( 'Europe/London' ) "TZ_OFFSET"--	 +01:00	Get time zone offset of a time zone name from UTC
FROM dual;


