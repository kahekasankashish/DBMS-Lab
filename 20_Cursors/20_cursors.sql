-- Assignment 20: Cursors

-- Q1. Write a PL/SQL block to retrieve ESRNO, ENAME and SALARY from EMPLOYEE table and display using cursors for those employees whose salary is more than 25,000.
DO $$
DECLARE
    employee_cursor CURSOR FOR
        SELECT esrno, ename, salary
        FROM employee
        WHERE salary > 25000
        ORDER BY esrno;
    v_esrno employee.esrno%TYPE;
    v_ename employee.ename%TYPE;
    v_salary employee.salary%TYPE;
BEGIN
    OPEN employee_cursor;
    LOOP
        FETCH employee_cursor INTO v_esrno, v_ename, v_salary;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ESRNO: %, ENAME: %, SALARY: %',
            v_esrno, v_ename, v_salary;
    END LOOP;
    CLOSE employee_cursor;
END;
$$ LANGUAGE plpgsql;


-- Q2. Write a PL/SQL block to display table-based detail information for the employee with ESRNO 216852 from the EMPLOYEE table.
DO $$
DECLARE
    v_employee employee%ROWTYPE;
BEGIN
    SELECT *
    INTO v_employee
    FROM employee
    WHERE esrno = 216852;

    IF NOT FOUND THEN
        RAISE NOTICE 'No employee found with ESRNO 216852';
    ELSE
        RAISE NOTICE 'Employee details: ESRNO=%, ENAME=%, ADDRESS=%, SEX=%, SALARY=%, MANAGER ESRNO=%, MANAGER START DATE=%, DNO=%',
            v_employee.esrno,
            v_employee.ename,
            v_employee.address,
            v_employee.sex,
            v_employee.salary,
            v_employee.mgrsrno,
            v_employee.mgrstartd,
            v_employee.dno;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Q3. Write a PL/SQL block to display cursor-based detail information of all male employees from the EMPLOYEE table.
DO $$
DECLARE
    male_employee_cursor CURSOR FOR
        SELECT *
        FROM employee
        WHERE UPPER(sex) = 'M'
        ORDER BY esrno;
    v_employee employee%ROWTYPE;
BEGIN
    OPEN male_employee_cursor;
    LOOP
        FETCH male_employee_cursor INTO v_employee;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ESRNO: %, ENAME: %, ADDRESS: %, SEX: %, SALARY: %, MANAGER ESRNO: %, MANAGER START DATE: %, DNO: %',
            v_employee.esrno,
            v_employee.ename,
            v_employee.address,
            v_employee.sex,
            v_employee.salary,
            v_employee.mgrsrno,
            v_employee.mgrstartd,
            v_employee.dno;
    END LOOP;
    CLOSE male_employee_cursor;
END;
$$ LANGUAGE plpgsql;


-- Q4. Write a PL/SQL block to find the number of rows affected by the use of SQL%ROWCOUNT attribute of an implicit cursor.
DO $$
DECLARE
    v_rows_affected INTEGER;
BEGIN
    UPDATE employee
    SET salary = salary
    WHERE dno = 10;

    GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
    RAISE NOTICE 'Number of rows affected = %', v_rows_affected;
END;
$$ LANGUAGE plpgsql;


-- Q5. Create a PL/SQL block to increase the salary of all employees working in DNO 10 by 20% and also determine the number of rows affected.
DO $$
DECLARE
    v_rows_affected INTEGER;
BEGIN
    UPDATE employee
    SET salary = salary * 1.20
    WHERE dno = 10;

    GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
    RAISE NOTICE 'Number of employees whose salary was increased = %',
        v_rows_affected;
END;
$$ LANGUAGE plpgsql;


-- Q6. Write a PL/SQL block to display the ENAME, ERSNO and ADDRESS of all employees working in RESEARCH department.
DO $$
DECLARE
    v_row RECORD;
BEGIN
    FOR v_row IN
        SELECT e.ename, e.esrno, e.address
        FROM employee AS e
        JOIN department AS d
          ON d.dnumber = e.dno
        WHERE UPPER(d.dname) = 'RESEARCH'
        ORDER BY e.esrno
    LOOP
        RAISE NOTICE 'ENAME: %, ESRNO: %, ADDRESS: %',
            v_row.ename, v_row.esrno, v_row.address;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- Q7. Count the number of employees working in each department by creating a PL/SQL block.
DO $$
DECLARE
    v_row RECORD;
BEGIN
    FOR v_row IN
        SELECT d.dnumber, d.dname, COUNT(e.esrno) AS employee_count
        FROM department AS d
        LEFT JOIN employee AS e
          ON e.dno = d.dnumber
        GROUP BY d.dnumber, d.dname
        ORDER BY d.dnumber
    LOOP
        RAISE NOTICE 'DEPARTMENT: % (%), EMPLOYEE COUNT: %',
            v_row.dname, v_row.dnumber, v_row.employee_count;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- Q8. WAP in PL/SQL to fetch the first three rows of a result set into three records using same explicit cursor into different variables.
DO $$
DECLARE
    employee_cursor CURSOR FOR
        SELECT *
        FROM employee
        ORDER BY esrno;
    v_employee1 employee%ROWTYPE;
    v_employee2 employee%ROWTYPE;
    v_employee3 employee%ROWTYPE;
BEGIN
    OPEN employee_cursor;

    FETCH employee_cursor INTO v_employee1;
    IF FOUND THEN
        RAISE NOTICE 'First row: ESRNO=%, ENAME=%, SALARY=%',
            v_employee1.esrno, v_employee1.ename, v_employee1.salary;
    END IF;

    FETCH employee_cursor INTO v_employee2;
    IF FOUND THEN
        RAISE NOTICE 'Second row: ESRNO=%, ENAME=%, SALARY=%',
            v_employee2.esrno, v_employee2.ename, v_employee2.salary;
    END IF;

    FETCH employee_cursor INTO v_employee3;
    IF FOUND THEN
        RAISE NOTICE 'Third row: ESRNO=%, ENAME=%, SALARY=%',
            v_employee3.esrno, v_employee3.ename, v_employee3.salary;
    END IF;

    CLOSE employee_cursor;
END;
$$ LANGUAGE plpgsql;


-- Q9. Write a PL/SQL block to display the manager’s name, department name, date of joining of managers and salary of managers.
DO $$
DECLARE
    v_row RECORD;
BEGIN
    FOR v_row IN
        SELECT DISTINCT
            m.ename AS manager_name,
            d.dname AS department_name,
            m.mgrstartd AS date_of_joining,
            m.salary AS manager_salary
        FROM employee AS m
        JOIN employee AS report
          ON report.mgrsrno = m.esrno
        LEFT JOIN department AS d
          ON d.dnumber = m.dno
        ORDER BY m.ename
    LOOP
        RAISE NOTICE 'MANAGER: %, DEPARTMENT: %, DATE OF JOINING: %, SALARY: %',
            v_row.manager_name,
            v_row.department_name,
            v_row.date_of_joining,
            v_row.manager_salary;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- Q10. Print the name of first six employees who got the highest salary.ORDER BY salary DESC, then ESRNO for deterministic ordering.
SELECT ename, esrno, salary
FROM employee
ORDER BY salary DESC, esrno
LIMIT 6;
