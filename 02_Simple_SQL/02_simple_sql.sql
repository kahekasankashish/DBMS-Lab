-- Assignment 2: Simple SQL Queries
-- Tables: EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno), DEPT (deptno, dname, loc)
--  Uses `EMP` and `DEPT` from Assignment 1.
-- Question 1: Query the employee table.
SELECT * FROM emp;

-- Question 2: List employee number and employee name.
SELECT empno, ename FROM emp;

-- Question 3: List employee number and name with headings NUMBER and NAME.
SELECT empno AS "NUMBER", ename AS "NAME" FROM emp;

-- Question 4: List employees working in department 20.
SELECT * FROM emp WHERE deptno = 20;

-- Question 5: List employees of departments 10 and 20.
SELECT * FROM emp WHERE deptno IN (10, 20);

-- Question 6: List employees who joined after 01/01/82 (interpreted as 1 January 1982).
SELECT * FROM emp WHERE hiredate > DATE '1982-01-01';

-- Question 7: List employees of department 10 who joined after 01/01/82.
SELECT * FROM emp WHERE deptno = 10 AND hiredate > DATE '1982-01-01';

-- Question 8: List the salary of all employees.
SELECT sal FROM emp;

-- Question 9: List employees who do not receive commission.
SELECT * FROM emp WHERE comm IS NULL;

-- Question 10: List employees who receive 0 commission.
SELECT * FROM emp WHERE comm = 0;

-- Question 11: Select employees in department 30.
SELECT * FROM emp WHERE deptno = 30;

-- Question 12: List employee names, employee numbers and department names
-- for employees in departments numbered 20 or higher.
SELECT e.ename, e.empno, d.dname, d.deptno
FROM emp AS e JOIN dept AS d ON d.deptno = e.deptno
WHERE d.deptno >= 20
ORDER BY d.deptno, e.ename;

-- Question 13: Find employees whose commission is greater than 60 percent of salary.
SELECT * FROM emp WHERE comm > 0.60 * sal;

-- Question 14: List name, job and salary of employees in department 20 earning more than Rs. 2000.
SELECT ename, job, sal FROM emp WHERE deptno = 20 AND sal > 2000;

-- Question 15: Find salesmen in department 30 whose salary is at least Rs. 1500.
SELECT * FROM emp WHERE deptno = 30 AND job = 'SALESMAN' AND sal >= 1500;

-- Question 16: Find employees whose job is manager or president.
SELECT * FROM emp WHERE job IN ('MANAGER', 'PRESIDENT');

-- Question 17: Find managers and clerks in department 10.
SELECT * FROM emp WHERE deptno = 10 AND job IN ('MANAGER', 'CLERK');

-- Question 18: Find all managers and all clerks in department 10.
SELECT * FROM emp WHERE job = 'MANAGER' OR (job = 'CLERK' AND deptno = 10);

-- Question 19: Find managers in department 10 and clerks in department 20.
SELECT * FROM emp
WHERE (job = 'MANAGER' AND deptno = 10)
   OR (job = 'CLERK' AND deptno = 20);

-- Question 20: Find managers in department 10, clerks in department 20,
-- and employees who are neither managers nor clerks and earn at least Rs. 2000.
SELECT * FROM emp
WHERE (job = 'MANAGER' AND deptno = 10)
   OR (job = 'CLERK' AND deptno = 20)
   OR (job NOT IN ('MANAGER', 'CLERK') AND sal >= 2000);

-- Question 21: List salaries in descending order.
SELECT sal FROM emp ORDER BY sal DESC;
