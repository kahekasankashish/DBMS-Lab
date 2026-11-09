-- Assignment 21: Exception Handling

-- Q1. Write a pl/SQL block to display salary of employee whose ename='SMITH'. If salary >800 then it will raise max_salary exception.
DO $$
DECLARE
    v_salary emp.sal%TYPE;
BEGIN
    SELECT sal
    INTO STRICT v_salary
    FROM emp
    WHERE UPPER(ename) = 'SMITH';

    RAISE NOTICE 'Salary of SMITH = %', v_salary;

    IF v_salary > 800 THEN
        RAISE EXCEPTION USING
            ERRCODE = 'P8001',
            MESSAGE = 'max_salary: SMITH salary is greater than 800';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE NOTICE 'NO_DATA_FOUND: employee SMITH does not exist';
    WHEN SQLSTATE 'P8001' THEN
        RAISE NOTICE 'max_salary exception: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;


-- Q2. Write a pl/sql block to check salary of SMITH is less than minimum salary of all the emp. If it is less than it will raise less_salary exception.
DO $$
DECLARE
    v_smith_salary emp.sal%TYPE;
    v_min_salary emp.sal%TYPE;
BEGIN
    SELECT sal
    INTO STRICT v_smith_salary
    FROM emp
    WHERE UPPER(ename) = 'SMITH';

    SELECT MIN(sal)
    INTO v_min_salary
    FROM emp;

    IF v_smith_salary < v_min_salary THEN
        RAISE EXCEPTION USING
            ERRCODE = 'P8002',
            MESSAGE = 'less_salary: SMITH salary is below the minimum salary';
    ELSE
        RAISE NOTICE 'SMITH salary (%) is not below the minimum EMP salary (%)',
            v_smith_salary, v_min_salary;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE NOTICE 'NO_DATA_FOUND: employee SMITH does not exist';
    WHEN SQLSTATE 'P8002' THEN
        RAISE NOTICE 'less_salary exception: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;


-- Q3. Write a pl/sql block to check any manager salary <5000.If any record found then it will raise less_salary exception.
DO $$
DECLARE
    v_manager RECORD;
BEGIN
    SELECT empno, ename, sal
    INTO v_manager
    FROM emp
    WHERE UPPER(job) = 'MANAGER'
      AND sal < 5000
    ORDER BY sal
    LIMIT 1;

    IF NOT FOUND THEN
        RAISE NOTICE 'No manager has a salary below 5000';
    ELSE
        RAISE EXCEPTION USING
            ERRCODE = 'P8003',
            MESSAGE = FORMAT(
                'less_salary: manager %s (EMPNO %s) has salary %s below 5000',
                v_manager.ename, v_manager.empno, v_manager.sal
            );
    END IF;
EXCEPTION
    WHEN SQLSTATE 'P8003' THEN
        RAISE NOTICE 'less_salary exception: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;


-- Q4. Write a program using PL/SQL to display manager name and manager address of all managers who are not getting any commission. If no data found then it will display no_data_found exception.
DO $$
DECLARE
     v_row RECORD;
     v_found BOOLEAN := FALSE;
 BEGIN
     FOR v_row IN
         SELECT manager_name, manager_address
         FROM employee_manager_commission
         WHERE commission IS NULL
     LOOP
         v_found := TRUE;
         RAISE NOTICE 'Manager: %, Address: %',
             v_row.manager_name, v_row.manager_address;
     END LOOP;

     IF NOT v_found THEN
         RAISE EXCEPTION USING
             ERRCODE = 'P8004',
             MESSAGE = 'no_data_found: no manager without commission';
     END IF;
 EXCEPTION
     WHEN SQLSTATE 'P8004' THEN
         RAISE NOTICE 'no_data_found exception: %', SQLERRM;
 END;
 $$ LANGUAGE plpgsql;


-- Q5. Write a pl/sql block to delete record of employees who dlocation='XYZ'. If dlocation is not valid then it will raise invalid_dept_location exception.
DO $$
DECLARE
    v_deleted_count INTEGER;
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM dept_locations
        WHERE UPPER(dlocation) = 'XYZ'
    ) THEN
        RAISE EXCEPTION USING
            ERRCODE = 'P8005',
            MESSAGE = 'invalid_dept_location: XYZ is not a valid department location';
    END IF;

    DELETE FROM employee AS e
    USING dept_locations AS dl
    WHERE e.dno = dl.dnumber
      AND UPPER(dl.dlocation) = 'XYZ';

    GET DIAGNOSTICS v_deleted_count = ROW_COUNT;
    RAISE NOTICE 'Number of employee records deleted = %', v_deleted_count;
EXCEPTION
    WHEN SQLSTATE 'P8005' THEN
        RAISE NOTICE 'invalid_dept_location exception: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;


-- Q6. Write a program using PL/SQL to display details of employees whose name ends with S. If not found then raise no_data_name exception.
DO $$
DECLARE
    v_employee RECORD;
    v_found BOOLEAN := FALSE;
BEGIN
    FOR v_employee IN
        SELECT *
        FROM employee
        WHERE UPPER(ename) LIKE '%S'
        ORDER BY esrno
    LOOP
        v_found := TRUE;
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

    IF NOT v_found THEN
        RAISE EXCEPTION USING
            ERRCODE = 'P8006',
            MESSAGE = 'no_data_name: no employee name ends with S';
    END IF;
EXCEPTION
    WHEN SQLSTATE 'P8006' THEN
        RAISE NOTICE 'no_data_name exception: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;


-- Q7. Write a program using function to display ename whose salary=1500. If data not found then it will display no_data_found exception.
CREATE OR REPLACE FUNCTION get_employee_names_with_salary_1500()
RETURNS TABLE (ename VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT e.ename::VARCHAR
    FROM emp AS e
    WHERE e.sal = 1500
    ORDER BY e.ename;

    IF NOT FOUND THEN
        RAISE EXCEPTION USING
            ERRCODE = 'P8007',
            MESSAGE = 'NO_DATA_FOUND: no employee has salary 1500';
    END IF;
END;
$$;

-- Display the names returned by the function.
SELECT * FROM get_employee_names_with_salary_1500();
