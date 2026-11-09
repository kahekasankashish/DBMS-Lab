-- Assignment 4: Single Row Functions
-- Table: EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno)

-- Question 1: Display names, jobs and bonus: managers 500, clerks 200,
-- others except president 350, president 20 percent of salary.
SELECT ename, job,
       CASE WHEN job = 'MANAGER' THEN 500
            WHEN job = 'CLERK' THEN 200
            WHEN job = 'PRESIDENT' THEN sal * 0.20
            ELSE 350 END AS bonus
FROM emp;

-- Question 2: Bonus is 20 percent of salary, capped at Rs. 200.
SELECT ename, LEAST(sal * 0.20, 200) AS bonus FROM emp;

-- Question 3: Sentence with joining date.
SELECT INITCAP(ename) || ' joined on the ' || TO_CHAR(hiredate, 'FMDDth') ||
       ' of ' || TO_CHAR(hiredate, 'FMMonth') ||
       ' of the year ' || TO_CHAR(hiredate, 'YYYY') AS joining_sentence
FROM emp;

-- Question 4: Display name and Greater/Smaller according to salary vs 1500.
SELECT ename,
       CASE WHEN sal > 1500 THEN 'Greater'
            WHEN sal < 1500 THEN 'Smaller'
            ELSE 'Equal' END AS salary_comparison
FROM emp;

-- Question 5: DA: 75% for salary >= 5000, 60% for salary >= 3000 and < 5000,
-- otherwise 50%.
SELECT ename, sal,
       CASE WHEN sal >= 5000 THEN sal * 0.75
            WHEN sal >= 3000 AND sal < 5000 THEN sal * 0.60
            ELSE sal * 0.50 END AS da
FROM emp;

-- Question 6: Names, job and hire date; hire dates descending within each department.
SELECT deptno, ename, job, hiredate FROM emp
ORDER BY deptno, hiredate DESC;

-- Question 7: What would be the date after two months?
SELECT CURRENT_DATE + INTERVAL '2 months' AS date_after_two_months;

-- Question 8: Employee number, name with first letter uppercase, department descending.
SELECT empno, INITCAP(LOWER(ename)) AS employee_name, deptno
FROM emp ORDER BY deptno DESC;

-- Question 9: Concatenate name and job separated by three spaces.
SELECT CONCAT(ename, '   ', job) AS employee_and_job FROM emp;

-- Question 10: Right-pad employee names to 16 characters with spaces.
SELECT RPAD(ename, 16, ' ') AS padded_name FROM emp;

-- Question 11: First three characters of employee names.
SELECT ename, LEFT(ename, 3) AS first_three_characters FROM emp;

-- Question 12: Round salary to the nearest Rs. 1000.
SELECT ename, sal, ROUND(sal / 1000.0) * 1000 AS salary_rounded_to_1000 FROM emp;

-- Question 13: Names whose last character equals the job's last character.
SELECT ename, job FROM emp WHERE RIGHT(ename, 1) = RIGHT(job, 1);

-- Question 14: Names and salary in descending order of income.
-- Income is interpreted as salary plus commission, with NULL commission as zero.
SELECT ename, sal, COALESCE(comm, 0) AS commission,
       sal + COALESCE(comm, 0) AS income
FROM emp ORDER BY income DESC;

-- Question 15: Employees whose name contains A.
SELECT * FROM emp WHERE ename LIKE '%A%';

-- Question 16: Employees hired before the 16th day of the month.
SELECT * FROM emp WHERE EXTRACT(DAY FROM hiredate) < 16;

-- Question 17: Indicate YES or NO whether employees receive commission.
SELECT ename,
       CASE WHEN comm IS NOT NULL AND comm <> 0 THEN 'YES' ELSE 'NO' END
       AS receives_commission
FROM emp;

-- Question 18: Employees whose names start with J, K, L or M.
SELECT * FROM emp WHERE LEFT(ename, 1) IN ('J', 'K', 'L', 'M');

-- Question 19: Display the length of employee names.
SELECT ename, LENGTH(ename) AS name_length FROM emp;

-- Question 20: Names and jobs of employees without a manager.
SELECT ename, job FROM emp WHERE mgr IS NULL;

-- Question 21: Names exactly five characters long and ending in N.
SELECT * FROM emp WHERE ename LIKE '____N';

-- Question 22: Names and department number for departments 10 and 30, alphabetical by name.
SELECT ename, deptno FROM emp
WHERE deptno IN (10, 30) ORDER BY ename;

-- Question 23: Employees without commission or with commission < Rs. 100.
SELECT * FROM emp WHERE comm IS NULL OR comm < 100;

-- Question 24: Employees whose commission is Rs. 0.
SELECT * FROM emp WHERE comm = 0;
