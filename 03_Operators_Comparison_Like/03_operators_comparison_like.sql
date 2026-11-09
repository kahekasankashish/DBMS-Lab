-- Assignment 3: SQL Operators, Comparison and LIKE
-- Table: EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)

-- Question 1: Display all employee information whose job is Clerk.
SELECT * FROM emp WHERE job = 'CLERK';

-- Question 2: Display all employee information whose employee number is 7788.
SELECT * FROM emp WHERE empno = 7788;

-- Question 3: Display all employee information whose commission is greater than salary.
SELECT * FROM emp WHERE comm > sal;

-- Question 4: Display employees drawing salary between 1000 and 2700.
SELECT * FROM emp WHERE sal BETWEEN 1000 AND 2700;

-- Question 5: Display employees whose employee number falls within a selected list.
SELECT * FROM emp WHERE empno IN (7369, 7788, 7839, 7902);

-- Question 6: Display employees whose commission is not known.
SELECT * FROM emp WHERE comm IS NULL;

-- Question 7: Display employees whose name starts with S.
SELECT * FROM emp WHERE ename LIKE 'S%';

-- Question 8: Display employees whose third character is O.
SELECT * FROM emp WHERE ename LIKE '__O%';

-- Question 9: Display employees whose name has exactly four characters.
SELECT * FROM emp WHERE ename LIKE '____';

-- Question 10: Display employees whose job is MANAGER.
SELECT * FROM emp WHERE job LIKE 'MANAGER';

-- Question 11(a): Negative form of Question 4.
SELECT * FROM emp WHERE sal NOT BETWEEN 1000 AND 2700;

-- Question 11(b): Negative form of Question 5.
SELECT * FROM emp WHERE empno NOT IN (7369, 7788, 7839, 7902);

-- Question 11(c): Negative form of Question 6.
SELECT * FROM emp WHERE comm IS NOT NULL;

-- Question 11(d): Negative form of Question 7.
SELECT * FROM emp WHERE ename NOT LIKE 'S%';

-- Question 11(e): Negative form of Question 8.
SELECT * FROM emp WHERE ename NOT LIKE '__O%';

-- Question 11(f): Negative form of Question 9.
SELECT * FROM emp WHERE ename NOT LIKE '____';

-- Question 11(g): Negative form of Question 10.
SELECT * FROM emp WHERE job NOT LIKE 'MANAGER';

-- Question 12: Display the sum of salary and commission for each employee.
SELECT ename, sal + COALESCE(comm, 0) AS salary_plus_commission FROM emp;

-- Question 13: Replace NULL or zero commission with 100 before adding to salary.
SELECT ename,
       sal + CASE WHEN comm IS NULL OR comm = 0 THEN 100 ELSE comm END
       AS salary_plus_adjusted_commission
FROM emp;

-- Question 14: Display employee name and annual remuneration with an alias.
SELECT ename, sal * 12 AS annual_remuneration FROM emp;

-- Question 15: Salary > 2000 and job of choice (SALESMAN selected).
SELECT * FROM emp WHERE sal > 2000 AND job = 'SALESMAN';

-- Question 16: Salary > 3000 or job of choice (SALESMAN selected).
SELECT * FROM emp WHERE sal > 3000 OR job = 'SALESMAN';

-- Question 17: Employees in department 20 not drawing salary greater than 2000.
SELECT * FROM emp WHERE deptno = 20 AND sal <= 2000;

-- Question 18: Employees drawing > 2000 whose job is manager or chosen job SALESMAN.
SELECT * FROM emp WHERE sal > 2000 AND job IN ('MANAGER', 'SALESMAN');

-- Question 19: Display names WARD and FORD using pattern matching.
SELECT * FROM emp WHERE ename LIKE 'WARD' OR ename LIKE 'FORD';

-- Question 20: Pattern-match concatenated name and job for SMITH_CLERK and ADAMS_CLERK.
SELECT ename, job FROM emp
WHERE ename || '_' || job LIKE 'SMITH_CLERK'
   OR ename || '_' || job LIKE 'ADAMS_CLERK';

-- Question 21: Pattern-match concatenated name and job for %ALLEN_SALESMAN and %ADAMS_CLERK.
SELECT ename, job FROM emp
WHERE ename || '_' || job LIKE '%ALLEN_SALESMAN'
   OR ename || '_' || job LIKE '%ADAMS_CLERK';
