-- Assignment 6: Nested Queries (Subqueries)
-- Table context: EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)
--                DEPT (deptno, dname, loc)
-- Table context: `EMP` and `DEPT`, using the column definitions from Assignment 1.


-- Question 1: List employee name, job, salary and department number
-- for employees working in Smith's department.
SELECT ename, job, sal, deptno
FROM emp
WHERE deptno = (
    SELECT deptno
    FROM emp
    WHERE ename = 'SMITH'
);

-- Question 2: Display employees' salary according to department and job
-- for employees earning more than the average salary in their own department and job group.
SELECT e.deptno, e.job, e.ename, e.sal
FROM emp AS e
WHERE e.sal > (
    SELECT AVG(e2.sal)
    FROM emp AS e2
    WHERE e2.deptno = e.deptno
      AND e2.job = e.job
)
ORDER BY e.deptno, e.job, e.sal DESC;

-- Question 3: Display department number, employee number and name
-- for employees whose department name is 'Operations'.
SELECT d.deptno, e.empno, e.ename
FROM emp AS e
JOIN dept AS d ON d.deptno = e.deptno
WHERE UPPER(d.dname) = 'OPERATIONS';

-- Question 4: List employee name, job, annual salary and department number
-- for employees who earn more than Jones.
SELECT ename, job, sal * 12 AS annual_salary, deptno
FROM emp
WHERE sal > (
    SELECT sal
    FROM emp
    WHERE ename = 'JONES'
);

-- Question 5: Display employees who joined after Miller.
SELECT *
FROM emp
WHERE hiredate > (
    SELECT hiredate
    FROM emp
    WHERE ename = 'MILLER'
);

-- Question 6: Find employees who earn a salary equal to the company's minimum salary.
SELECT *
FROM emp
WHERE sal = (SELECT MIN(sal) FROM emp);

-- Question 7: Find all employees who have the same job as Blake.
SELECT *
FROM emp
WHERE job = (
    SELECT job
    FROM emp
    WHERE ename = 'BLAKE'
);

-- Question 8: Find employees who earn more than every employee in department 30.
SELECT *
FROM emp
WHERE sal > ALL (
    SELECT sal
    FROM emp
    WHERE deptno = 30
);

-- Question 9: Display employees who earn more than the lowest salary in department 30.
SELECT *
FROM emp
WHERE sal > (
    SELECT MIN(sal)
    FROM emp
    WHERE deptno = 30
);

-- Question 10: Display departments whose average salary is greater
-- than the average salary of department 30.
SELECT deptno, AVG(sal) AS average_salary
FROM emp
GROUP BY deptno
HAVING AVG(sal) > (
    SELECT AVG(sal)
    FROM emp
    WHERE deptno = 30
)
ORDER BY deptno;

-- Question 11: Display the job with the highest average salary.
-- Returns all jobs tied for the highest average salary.
SELECT job, AVG(sal) AS average_salary
FROM emp
GROUP BY job
HAVING AVG(sal) = (
    SELECT MAX(job_average)
    FROM (
        SELECT AVG(sal) AS job_average
        FROM emp
        GROUP BY job
    ) AS job_averages
);

-- Question 12: For each employee, display the number of days passed
-- since the employee joined the company.
SELECT ename, hiredate, CURRENT_DATE - hiredate AS days_since_joining
FROM emp;

-- Question 13: Display employees working in a department located in Chicago.
SELECT e.*
FROM emp AS e
WHERE e.deptno IN (
    SELECT d.deptno
    FROM dept AS d
    WHERE LOWER(d.loc) = 'chicago'
);

-- Question 14: Display employee name, job and hire date for employees
-- whose salary is greater than the highest salary in the Sales department.
SELECT ename, job, hiredate
FROM emp
WHERE sal > (
    SELECT MAX(e.sal)
    FROM emp AS e
    JOIN dept AS d ON d.deptno = e.deptno
    WHERE LOWER(d.dname) = 'sales'
);

-- Question 15: Find the second-highest distinct salary of employees.
SELECT DISTINCT sal AS second_highest_salary
FROM emp
ORDER BY sal DESC
OFFSET 1
LIMIT 1;

-- Question 16: Count departments having more than five employees.
SELECT COUNT(*) AS departments_with_more_than_five_employees
FROM (
    SELECT deptno
    FROM emp
    GROUP BY deptno
    HAVING COUNT(*) > 5
) AS department_counts;

-- Question 17: Count employees who are not getting any commission.
SELECT COUNT(*) AS employees_without_commission
FROM emp
WHERE comm IS NULL;
