-- Assignment 19: PL/SQL Functions


-- Q1. Create a function to find the cube of a number.Number should be user defined.
CREATE OR REPLACE FUNCTION find_cube(p_num NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN POWER(p_num, 3);
END;
$$;

SELECT find_cube(5);


-- Q2. Create a function to find factorial of a number. Number should be provided by the user.
CREATE OR REPLACE FUNCTION find_factorial_function(p_num INTEGER)
RETURNS NUMERIC
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

    RETURN v_factorial;
END;
$$;

SELECT find_factorial_function(5);


-- Q3. Create a function to print the fibonaccii series of a given range.
CREATE OR REPLACE FUNCTION fibonacci_series(p_terms INTEGER)
RETURNS TABLE (term_number INTEGER, fibonacci_value NUMERIC)
LANGUAGE plpgsql
AS $$
DECLARE
    i INTEGER;
    v_first NUMERIC := 0;
    v_second NUMERIC := 1;
    v_next NUMERIC;
BEGIN
    IF p_terms < 0 THEN
        RAISE EXCEPTION 'Number of terms cannot be negative';
    END IF;

    FOR i IN 1..p_terms LOOP
        term_number := i;
        fibonacci_value := v_first;
        RETURN NEXT;

        v_next := v_first + v_second;
        v_first := v_second;
        v_second := v_next;
    END LOOP;
END;
$$;

SELECT * FROM fibonacci_series(10);


-- Q4. Create a function to print sum of first n natural numbers.
CREATE OR REPLACE FUNCTION sum_first_n(p_n INTEGER)
RETURNS BIGINT
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_n < 0 THEN
        RAISE EXCEPTION 'n cannot be negative';
    END IF;

    RETURN p_n::BIGINT * (p_n::BIGINT + 1) / 2;
END;
$$;

SELECT sum_first_n(10);


-- Q5. Write a function to find the volume of a sphere.
CREATE OR REPLACE FUNCTION sphere_volume(p_radius NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_radius < 0 THEN
        RAISE EXCEPTION 'Radius cannot be negative';
    END IF;

    RETURN (4.0 / 3.0) * PI() * POWER(p_radius, 3);
END;
$$;

SELECT sphere_volume(5);


-- Q6. Create a function that returns the employee name those who are working department no 20.
-- Uses the EMP table from the earlier assignment
CREATE OR REPLACE FUNCTION employees_in_department_20()
RETURNS TABLE (employee_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT e.ename::VARCHAR
    FROM emp AS e
    WHERE e.deptno = 20
    ORDER BY e.ename;
END;
$$;

-- Return employee names working in department 20.
SELECT * FROM employees_in_department_20();
