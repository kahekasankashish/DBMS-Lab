-- Assignment 17: PL/SQL Blocks and Conditions

-- Q1. Write a PL/SQL block to print ‘HELLO WORLD’.
DO $$
BEGIN
    RAISE NOTICE 'HELLO WORLD';
END;
$$ LANGUAGE plpgsql;


-- Q2. Write a PL/SQL block to accept two numbers using substitution variables and then find their sum, difference, product and quotient.
\prompt 'Enter first number: ' q2_num1
\prompt 'Enter second number: ' q2_num2
SELECT
    :'q2_num1'::NUMERIC + :'q2_num2'::NUMERIC AS sum,
    :'q2_num1'::NUMERIC - :'q2_num2'::NUMERIC AS difference,
    :'q2_num1'::NUMERIC * :'q2_num2'::NUMERIC AS product,
    CASE
        WHEN :'q2_num2'::NUMERIC = 0 THEN NULL
        ELSE :'q2_num1'::NUMERIC / :'q2_num2'::NUMERIC
    END AS quotient;


-- Q3. Write a PL/SQL block to accept the value of A, B and C and display which is greater.
\prompt 'Enter value of A: ' q3_a
\prompt 'Enter value of B: ' q3_b
\prompt 'Enter value of C: ' q3_c
SELECT CASE
    WHEN :'q3_a'::NUMERIC = :'q3_b'::NUMERIC
     AND :'q3_b'::NUMERIC = :'q3_c'::NUMERIC
        THEN 'All three values are equal'
    WHEN :'q3_a'::NUMERIC >= :'q3_b'::NUMERIC
     AND :'q3_a'::NUMERIC >= :'q3_c'::NUMERIC
        THEN 'A is greatest'
    WHEN :'q3_b'::NUMERIC >= :'q3_a'::NUMERIC
     AND :'q3_b'::NUMERIC >= :'q3_c'::NUMERIC
        THEN 'B is greatest'
    ELSE 'C is greatest'
END AS greatest_value;


-- Q4. Write a PL/SQL program to check whether a given number is positive, negative or zero.
DO $$
DECLARE
    v_num NUMERIC := -12; -- Change this value to test another number.
BEGIN
    IF v_num > 0 THEN
        RAISE NOTICE '% is positive', v_num;
    ELSIF v_num < 0 THEN
        RAISE NOTICE '% is negative', v_num;
    ELSE
        RAISE NOTICE 'The number is zero';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Q5. Write a PL/SQL program to check whether a given character is letter or digit.
DO $$
DECLARE
    v_char TEXT := 'A';
BEGIN
    IF v_char ~ '^[[:alpha:]]$' THEN
        RAISE NOTICE '% is a letter', v_char;
    ELSIF v_char ~ '^[0-9]$' THEN
        RAISE NOTICE '% is a digit', v_char;
    ELSE
        RAISE NOTICE '% is neither a single letter nor a digit', v_char;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Q6. Write a PL/SQL block to print even numbers from 1 to 10.
DO $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 1..10 LOOP
        IF i % 2 = 0 THEN
            RAISE NOTICE '%', i;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- Q7. Write a PL/SQL block to find the sum of numbers from 1 to 10.
DO $$
DECLARE
    i INTEGER;
    v_sum INTEGER := 0;
BEGIN
    FOR i IN 1..10 LOOP
        v_sum := v_sum + i;
    END LOOP;
    RAISE NOTICE 'Sum = %', v_sum;
END;
$$ LANGUAGE plpgsql;


-- Q8. Write a PL/SQL block to accept a number and find the sum of the digits of that number.
DO $$
DECLARE
    v_num BIGINT := 12345;
    v_temp BIGINT;
    v_sum INTEGER := 0;
BEGIN
    v_temp := ABS(v_num);
    WHILE v_temp > 0 LOOP
        v_sum := v_sum + (v_temp % 10)::INTEGER;
        v_temp := v_temp / 10;
    END LOOP;
    RAISE NOTICE 'Sum of digits of % = %', v_num, v_sum;
END;
$$ LANGUAGE plpgsql;


-- Q9. Write a PL/SQL block to accept a number and print it in reverse order.
DO $$
DECLARE
    v_num BIGINT := 12345;
    v_temp BIGINT;
    v_reverse BIGINT := 0;
BEGIN
    v_temp := ABS(v_num);
    WHILE v_temp > 0 LOOP
        v_reverse := v_reverse * 10 + (v_temp % 10);
        v_temp := v_temp / 10;
    END LOOP;

    IF v_num < 0 THEN
        v_reverse := -v_reverse;
    END IF;

    RAISE NOTICE 'Reverse of % = %', v_num, v_reverse;
END;
$$ LANGUAGE plpgsql;


-- Q10. Create a table TBL_STUDENT with attributes ROLLNO, SNAME and MARKS. Insert five records by using PL/SQL block.
CREATE TABLE tbl_student (
    rollno INTEGER PRIMARY KEY,
    sname  VARCHAR(50),
    marks  NUMERIC(5,2)
);

DO $$
BEGIN
    INSERT INTO tbl_student (rollno, sname, marks) VALUES
        (1, 'Student1', 3),
        (2, 'Student2', 7),
        (3, 'Student3', 15),
        (4, 'Student4', 20),
        (5, 'Student5', 10);
END;
$$ LANGUAGE plpgsql;


-- Q11. Then, update and display the marks of each student basing on
-- the following conditions:
-- Source conditions:
--   if MARKS < 5, give a grace mark of 24 to the original marks obtained
--   if 5 > MARKS <= 10, offer a grace of 20 to the original marks secured
--   if 10 > MARKS < 20, update the marks by adding 15 to the original marks
--   otherwise, do not change the original marks.
DO $$
BEGIN
    UPDATE tbl_student
    SET marks = CASE
        WHEN marks < 5 THEN marks + 24
        WHEN marks >= 5 AND marks <= 10 THEN marks + 20
        WHEN marks > 10 AND marks < 20 THEN marks + 15
        ELSE marks
    END;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM tbl_student ORDER BY rollno;


-- Q12. Write a PL/SQL block to insert numbers from 1 to 10 into a table
-- called TBL_NUM. The table should contain two fields - NUM and CATEGORY.
-- Then, check if the number is even, insert EVEN as the category and if it
-- is odd then, insert ODD as the category into the table.
CREATE TABLE tbl_num (
    num      INTEGER PRIMARY KEY,
    category VARCHAR(4)
);

DO $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO tbl_num (num, category)
        VALUES (i, CASE WHEN i % 2 = 0 THEN 'EVEN' ELSE 'ODD' END);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM tbl_num ORDER BY num;


-- Q13. Write a PL/SQL block to calculate the perimeter of a circle for three different values of radius and simultaneously enter the values of radius and perimeter into a table TBL_CIRCLE.
CREATE TABLE tbl_circle (
    radius    NUMERIC(8,2),
    perimeter NUMERIC(10,2)
);

DO $$
DECLARE
    v_radius NUMERIC(8,2);
    v_perimeter NUMERIC(10,2);
    v_radii NUMERIC(8,2)[] := ARRAY[2.00, 5.00, 7.50];
BEGIN
    FOREACH v_radius IN ARRAY v_radii LOOP
        v_perimeter := 2 * PI() * v_radius;
        INSERT INTO tbl_circle (radius, perimeter)
        VALUES (v_radius, v_perimeter);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM tbl_circle ORDER BY radius;


-- Q14. Write a PL/SQL block to assign ENAME, EMPNO, SAL and JOB from EMP table for ‘SMITH’ into some variables and display the contents of those variables. Mention an exception handler if no such employees exists in the table.
DO $$
DECLARE
    v_ename emp.ename%TYPE;
    v_empno emp.empno%TYPE;
    v_sal   emp.sal%TYPE;
    v_job   emp.job%TYPE;
BEGIN
    SELECT ename, empno, sal, job
    INTO STRICT v_ename, v_empno, v_sal, v_job
    FROM emp
    WHERE ename = 'SMITH';

    RAISE NOTICE 'ENAME: %, EMPNO: %, SAL: %, JOB: %',
        v_ename, v_empno, v_sal, v_job;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE NOTICE 'No employee named SMITH exists in EMP.';
    WHEN TOO_MANY_ROWS THEN
        RAISE NOTICE 'More than one employee named SMITH exists in EMP.';
END;
$$ LANGUAGE plpgsql;


-- Q15. Accept the values of EMPNO, ENAME, SAL and COMM into some variables and then find the total salary of each employee who is a ‘CLERK’ and ‘SALESMAN’.
DO $$
DECLARE
    v_empno emp.empno%TYPE;
    v_ename emp.ename%TYPE;
    v_sal   emp.sal%TYPE;
    v_comm  emp.comm%TYPE;
    v_total NUMERIC;
    employee_record RECORD;
BEGIN
    FOR employee_record IN
        SELECT empno, ename, sal, comm
        FROM emp
        WHERE job IN ('CLERK', 'SALESMAN')
        ORDER BY empno
    LOOP
        v_empno := employee_record.empno;
        v_ename := employee_record.ename;
        v_sal := employee_record.sal;
        v_comm := employee_record.comm;
        v_total := v_sal + COALESCE(v_comm, 0);

        RAISE NOTICE 'EMPNO: %, ENAME: %, SAL: %, COMM: %, TOTAL: %',
            v_empno, v_ename, v_sal, v_comm, v_total;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- Q16. Create a table TBL_STUD with attributes SID, SNAME, MARK1, MARK2,MARK3 and GRADE. Enter five records into it and then calculate and display the grade of each student according to BPUT gradation system.
CREATE TABLE tbl_stud (
    sid   INTEGER PRIMARY KEY,
    sname VARCHAR(50),
    mark1 NUMERIC(5,2),
    mark2 NUMERIC(5,2),
    mark3 NUMERIC(5,2),
    grade VARCHAR(2)
);

INSERT INTO tbl_stud (sid, sname, mark1, mark2, mark3)
VALUES
    (1, 'StudentA', 85, 88, 91),
    (2, 'StudentB', 72, 75, 70),
    (3, 'StudentC', 61, 65, 68),
    (4, 'StudentD', 48, 52, 55),
    (5, 'StudentE', 35, 40, 38);

UPDATE tbl_stud
SET grade = CASE
    WHEN (mark1 + mark2 + mark3) / 3.0 >= 90 THEN 'O'
    WHEN (mark1 + mark2 + mark3) / 3.0 >= 80 THEN 'A+'
    WHEN (mark1 + mark2 + mark3) / 3.0 >= 70 THEN 'A'
    WHEN (mark1 + mark2 + mark3) / 3.0 >= 60 THEN 'B+'
    WHEN (mark1 + mark2 + mark3) / 3.0 >= 50 THEN 'B'
    WHEN (mark1 + mark2 + mark3) / 3.0 >= 40 THEN 'C'
    ELSE 'F'
END;

SELECT
    sid,
    sname,
    mark1,
    mark2,
    mark3,
    ROUND((mark1 + mark2 + mark3) / 3.0, 2) AS average_marks,
    grade
FROM tbl_stud
ORDER BY sid;
