-- Assignment 12: Views

-- Q1. Create a view from EMPLOYEE with ENAME, BDATE, ADDRESS, SEX.
CREATE VIEW emp_info AS
SELECT ename, bdate, address, sex
FROM employee;

-- Q2. Create a view from EMPLOYEE with ENAME, ESRNO, SALARY, MGRSRNO, DNO.
CREATE VIEW emp_sorted AS
SELECT ename, esrno, salary, mgrsrno, dno
FROM employee
ORDER BY ename ASC;

-- Q3. Create a view with aliases NAME and DOB, showing only departments 1 and 3.
CREATE VIEW emp_dept_1_3 AS
SELECT ename AS name, bdate AS dob, esrno, salary, mgrsrno, dno
FROM employee
WHERE dno IN (1, 3);

-- Q4. Create a view with computed commission equal to 45% of salary.
CREATE VIEW emp_detail AS
SELECT esrno AS eid,
       dno,
       salary AS sal,
       salary * 0.45 AS comm
FROM employee;

-- Q5. Create a view with capitalized employee name, birth year, gender and address.
CREATE VIEW emp_info2 AS
SELECT INITCAP(ename) AS ename,
       EXTRACT(YEAR FROM bdate)::INTEGER AS yob,
       sex AS gender,
       address AS addr
FROM employee;

-- Q6. Create a view from DEPT_LOCATIONS with aliases and uppercase location.
CREATE VIEW deptloc_view AS
SELECT dnumber AS dnum,
       UPPER(dlocation) AS dloc
FROM dept_locations;

-- Q7. Create a view joining EMPLOYEE and DEPARTMENT.
CREATE VIEW emp_dept_view AS
SELECT e.ename, e.esrno, e.mgrsrno, e.salary,
       d.dnumber, d.dname
FROM employee AS e
INNER JOIN department AS d
    ON e.dno = d.dnumber;

-- Q8. Create a view joining EMPLOYEE and DEPT_LOCATIONS.
CREATE VIEW emp_deptloc_view AS
SELECT e.ename, e.esrno, e.bdate, e.dno, dl.dlocation
FROM employee AS e
INNER JOIN dept_locations AS dl
    ON e.dno = dl.dnumber;

-- Q9. Create a view showing total project hours for each employee.
CREATE VIEW works_on_view AS
SELECT esrno, SUM(hours) AS time
FROM works_on
GROUP BY esrno;

-- Q10. Create a view joining EMPLOYEE, DEPARTMENT, PROJECT and DEPT_LOCATIONS.
CREATE VIEW emp_dept_proj_deptloc_view AS
SELECT e.esrno, e.ename, e.dno, d.dname,
       dl.dlocation, p.pnumber, p.pname, p.plocation
FROM employee AS e
INNER JOIN department AS d
    ON e.dno = d.dnumber
INNER JOIN dept_locations AS dl
    ON d.dnumber = dl.dnumber
INNER JOIN project AS p
    ON d.dnumber = p.dnum;

-- Q11. Create a view with employee salary and their manager's name and salary.
CREATE VIEW emp_mgr_view AS
SELECT e.ename,
       e.esrno,
       e.salary AS esal,
       e.mgrsrno,
       m.ename AS mgrname,
       m.salary AS msal
FROM employee AS e
LEFT JOIN employee AS m
    ON e.mgrsrno = m.esrno;

-- Q12-Q13
CREATE OR REPLACE FUNCTION deptloc_view_write()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO dept_locations (dnumber, dlocation)
        VALUES (NEW.dnum, NEW.dloc);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE dept_locations
        SET dnumber = NEW.dnum
        WHERE dnumber = OLD.dnum
          AND UPPER(dlocation) = OLD.dloc;
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$;

CREATE TRIGGER trg_deptloc_view_write
INSTEAD OF INSERT OR UPDATE ON deptloc_view
FOR EACH ROW
EXECUTE FUNCTION deptloc_view_write();

-- Q14-Q15. Insert the supplied record into the department-location view:
-- DNUMBER = 5, DLOCATION = 'Mancheswar'.
-- The view columns are named DNUM and DLOC; DLOC is displayed uppercase.
INSERT INTO deptloc_view (dnum, dloc)
VALUES (5, 'Mancheswar');

-- Q16. Update all view rows with DNUMBER 5 to DNUMBER 10.
-- The view's corresponding column name is DNUM.
UPDATE deptloc_view
SET dnum = 10
WHERE dnum = 5;

SELECT * FROM emp_info;
SELECT * FROM emp_sorted ORDER BY ename;
SELECT * FROM emp_dept_1_3;
SELECT * FROM emp_detail;
SELECT * FROM emp_info2;
SELECT * FROM deptloc_view;
SELECT * FROM emp_dept_view;
SELECT * FROM emp_deptloc_view;
SELECT * FROM works_on_view;
SELECT * FROM emp_dept_proj_deptloc_view;
SELECT * FROM emp_mgr_view;
