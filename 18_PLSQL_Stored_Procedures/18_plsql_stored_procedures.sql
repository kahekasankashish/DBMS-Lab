-- Assignment 18: PL/SQL Stored Procedures

-- Q1. Write a PL/SQL block to Print
-- *
-- **
-- ***
-- ****
-- *****
CREATE OR REPLACE PROCEDURE print_star_pattern()
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 1..5 LOOP
        RAISE NOTICE '%', REPEAT('*', i);
    END LOOP;
END;
$$;

CALL print_star_pattern();


-- Q2. Create a procedure block to print the squares of 1 to 10.
CREATE OR REPLACE PROCEDURE print_squares_1_to_10()
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 1..10 LOOP
        RAISE NOTICE '% squared = %', i, i * i;
    END LOOP;
END;
$$;

CALL print_squares_1_to_10();


-- Q3. Create a procedure to find factorial of a number.Number should be provided by the user.

CREATE OR REPLACE PROCEDURE find_factorial(IN p_num INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
    v_factorial NUMERIC := 1;
BEGIN
    IF p_num < 0 THEN
        RAISE EXCEPTION 'Factorial is not defined for negative integers';
    END IF;

    IF p_num > 0 THEN
        FOR i IN 1..p_num LOOP
            v_factorial := v_factorial * i;
        END LOOP;
    END IF;

    RAISE NOTICE 'Factorial of % = %', p_num, v_factorial;
END;
$$;

CALL find_factorial(5);


-- Q4. Create a procedure to print the fibonacii series of a given range.
CREATE OR REPLACE PROCEDURE print_fibonacci(IN p_terms INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
    v_first BIGINT := 0;
    v_second BIGINT := 1;
    v_next BIGINT;
BEGIN
    IF p_terms < 0 THEN
        RAISE EXCEPTION 'Number of terms cannot be negative';
    END IF;

    IF p_terms = 0 THEN
        RAISE NOTICE 'No terms requested';
    ELSE
        FOR i IN 1..p_terms LOOP
            RAISE NOTICE '%', v_first;
            v_next := v_first + v_second;
            v_first := v_second;
            v_second := v_next;
        END LOOP;
    END IF;
END;
$$;

CALL print_fibonacci(10);


-- Q5. Create a procedure to print sum of first n natural numbers.
CREATE OR REPLACE PROCEDURE sum_first_n_natural_numbers(IN p_n INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    v_sum BIGINT;
BEGIN
    IF p_n < 0 THEN
        RAISE EXCEPTION 'n cannot be negative';
    END IF;

    v_sum := p_n::BIGINT * (p_n::BIGINT + 1) / 2;
    RAISE NOTICE 'Sum of first % natural numbers = %', p_n, v_sum;
END;
$$;

CALL sum_first_n_natural_numbers(10);


-- Q6. Write the PL/SQL block to find the volume of a sphere.
CREATE OR REPLACE PROCEDURE calculate_sphere_volume(IN p_radius NUMERIC)
LANGUAGE plpgsql
AS $$
DECLARE
    v_volume NUMERIC;
BEGIN
    IF p_radius < 0 THEN
        RAISE EXCEPTION 'Radius cannot be negative';
    END IF;

    v_volume := (4.0 / 3.0) * PI() * POWER(p_radius, 3);
    RAISE NOTICE 'Volume of sphere with radius % = %', p_radius, v_volume;
END;
$$;

CALL calculate_sphere_volume(5);


-- Q7. Create a table customer(cust_name, cust_street, cust_city) and create a procedure to insert into the above table.
CREATE TABLE customer (
    cust_name   VARCHAR(100),
    cust_street VARCHAR(150),
    cust_city   VARCHAR(100)
);

CREATE OR REPLACE PROCEDURE insert_customer(
    IN p_cust_name VARCHAR(100),
    IN p_cust_street VARCHAR(150),
    IN p_cust_city VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO customer (cust_name, cust_street, cust_city)
    VALUES (p_cust_name, p_cust_street, p_cust_city);

    RAISE NOTICE 'Customer % inserted', p_cust_name;
END;
$$;

CALL insert_customer('Aarav Sharma', 'Patia Road', 'Bhubaneswar');

-- Display inserted customer records.
SELECT * FROM customer;


-- Q8. Create a procedure to find the maximum and minimum salary of an employee from emp table.
CREATE OR REPLACE PROCEDURE display_min_max_employee_salary()
LANGUAGE plpgsql
AS $$
DECLARE
    v_min_salary emp.sal%TYPE;
    v_max_salary emp.sal%TYPE;
BEGIN
    SELECT MIN(sal), MAX(sal)
    INTO v_min_salary, v_max_salary
    FROM emp;

    IF v_min_salary IS NULL AND v_max_salary IS NULL THEN
        RAISE NOTICE 'EMP table contains no salary values';
    ELSE
        RAISE NOTICE 'Minimum salary = %, Maximum salary = %',
            v_min_salary, v_max_salary;
    END IF;
END;
$$;

CALL display_min_max_employee_salary();


-- Q9. Create a procedure to display the information of an department using ROWTYPE. The department number should be provided by the user.
CREATE OR REPLACE PROCEDURE display_department_info(IN p_deptno dept.deptno%TYPE)
LANGUAGE plpgsql
AS $$
DECLARE
    v_department dept%ROWTYPE;
BEGIN
    SELECT *
    INTO v_department
    FROM dept
    WHERE deptno = p_deptno;

    IF NOT FOUND THEN
        RAISE NOTICE 'No department found for department number %', p_deptno;
    ELSE
        RAISE NOTICE 'Department number: %, Name: %, Location: %',
            v_department.deptno,
            v_department.dname,
            v_department.loc;
    END IF;
END;
$$;

CALL display_department_info(10);


-- Q10. Write a PL/SQL stored procedure block to find the greatest among three numbers.
CREATE OR REPLACE PROCEDURE find_greatest_of_three(
    IN p_a NUMERIC,
    IN p_b NUMERIC,
    IN p_c NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_greatest NUMERIC;
BEGIN
    v_greatest := GREATEST(p_a, p_b, p_c);
    RAISE NOTICE 'Greatest among %, % and % is %',
        p_a, p_b, p_c, v_greatest;
END;
$$;

CALL find_greatest_of_three(12, 45, 27);
