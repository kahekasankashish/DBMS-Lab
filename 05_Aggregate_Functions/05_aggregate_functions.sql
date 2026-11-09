-- Assignment 5: Aggregate Functions
-- Table context: EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)

-- Question 1: Replace all 'A's from 'MALAYALAM' by 'E'.
SELECT REPLACE('MALAYALAM', 'A', 'E') AS modified_word;

-- Question 2: Display 0 for all employees whose commission is NULL.
SELECT ename, COALESCE(comm, 0) AS commission
FROM emp;

-- Question 3: Find the total number of clerks.
SELECT COUNT(*) AS total_clerks
FROM emp
WHERE job = 'CLERK';

-- Question 4: Find the number of employees working under each department.
SELECT deptno, COUNT(*) AS employee_count
FROM emp
GROUP BY deptno
ORDER BY deptno;

-- Question 5: Find the total number of clerks who joined after 01-Jan-1981.
SELECT COUNT(*) AS clerks_joined_after_date
FROM emp
WHERE job = 'CLERK'
  AND hiredate > DATE '1981-01-01';

-- Question 6: Find the total of basic salary and commission.
-- NULL commissions are treated as zero.
SELECT SUM(sal + COALESCE(comm, 0)) AS total_salary_and_commission
FROM emp;

-- Question 7: Find the yearly compensation paid to all managers
-- using 12 * (salary + COALESCE(commission, 0)).
SELECT ename,
       12 * (sal + COALESCE(comm, 0)) AS yearly_compensation
FROM emp
WHERE job = 'MANAGER';

-- Question 8: Find the average salary of all salesmen.
SELECT AVG(sal) AS average_salesman_salary
FROM emp
WHERE job = 'SALESMAN';

-- Question 9: Find who is paid the most in the company.
-- Returns every employee tied for the highest salary.
SELECT ename, sal
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

-- Question 10: Display the name of the highest-paid employee(s) in each department.
-- Returns ties when multiple employees share the department's maximum salary.
SELECT e.deptno, e.ename, e.sal
FROM emp AS e
WHERE e.sal = (
    SELECT MAX(e2.sal)
    FROM emp AS e2
    WHERE e2.deptno = e.deptno
)
ORDER BY e.deptno, e.ename;

-- Question 11: Find who comes first in alphabetical order (MIN).
SELECT MIN(ename) AS first_employee_alphabetically
FROM emp;

-- Question 12: Find the minimum salary of various categories of employees.
SELECT job, MIN(sal) AS minimum_salary
FROM emp
GROUP BY job
ORDER BY job;

-- Question 13: Find the maximum salary of employees, department-wise and job-wise.
SELECT deptno, job, MAX(sal) AS maximum_salary
FROM emp
GROUP BY deptno, job
ORDER BY deptno, job;

-- Question 14: List the categories of employees and departments
-- for which the maximum salary is greater than 1500 (group by job, dept).
SELECT job, deptno, MAX(sal) AS maximum_salary
FROM emp
GROUP BY job, deptno
HAVING MAX(sal) > 1500
ORDER BY job, deptno;

-- Question 15: Find the minimum and maximum salary of all managers in all departments.
SELECT deptno,
       MIN(sal) AS minimum_salary,
       MAX(sal) AS maximum_salary
FROM emp
WHERE job = 'MANAGER'
GROUP BY deptno
ORDER BY deptno;

-- Question 16: Find the minimum salary of managers in each department
-- where the minimum salary is above 2500.
SELECT deptno, MIN(sal) AS minimum_salary
FROM emp
WHERE job = 'MANAGER'
GROUP BY deptno
HAVING MIN(sal) > 2500
ORDER BY deptno;
