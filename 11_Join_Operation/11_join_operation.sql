-- Assignment 11: Join Operation

-- Q1. Display employee name, address, department no and department name.
SELECT e.ename, e.address, e.dno, d.dname
FROM employee AS e
INNER JOIN department AS d
    ON e.dno = d.dnumber;

-- Q2. Display managers name, department name, date of joining of manager, and salary of managers.
SELECT m.ename AS manager_name,
       d.dname AS department_name,
       d.mgrstartd AS manager_start_date,
       m.salary
FROM department AS d
INNER JOIN employee AS m
    ON d.mgrsrno = m.esrno;

-- Q3. Display department name, department number, and department location.
SELECT d.dname, d.dnumber, dl.dlocation
FROM department AS d
INNER JOIN dept_locations AS dl
    ON d.dnumber = dl.dnumber;

-- Q4. Display project name, project number and project location and total hours of all active projects.
SELECT p.pname, p.pnumber, p.plocation,
       SUM(w.hours) AS total_hours
FROM project AS p
INNER JOIN works_on AS w
    ON p.pnumber = w.pno
GROUP BY p.pname, p.pnumber, p.plocation;

-- Q5. Display all the employees who are working in ACADEMIC.
SELECT e.*
FROM employee AS e
INNER JOIN department AS d
    ON e.dno = d.dnumber
WHERE d.dname = 'ACADEMIC';

-- Q6. Display the managers’ details who started on '17-JUL-99'.
SELECT m.*
FROM employee AS m
INNER JOIN department AS d
    ON m.esrno = d.mgrsrno
WHERE d.mgrstartd = DATE '1999-07-17';

-- Q7. Display the employees those are working in BIO INFORMATICS.
SELECT DISTINCT e.*
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
INNER JOIN project AS p
    ON w.pno = p.pnumber
WHERE p.pname = 'BIO INFORMATICS';

-- Q8. Display the details of LINUX project employees.
SELECT DISTINCT e.*
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
INNER JOIN project AS p
    ON w.pno = p.pnumber
WHERE p.pname = 'LINUX';

-- Q9. Display SATYA's project location.
SELECT DISTINCT p.plocation
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
INNER JOIN project AS p
    ON w.pno = p.pnumber
WHERE e.ename = 'SATYA';

-- Q10. Display the details of the people whose projects are located at SOUTH AFRICA.
SELECT DISTINCT e.*
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
INNER JOIN project AS p
    ON w.pno = p.pnumber
WHERE p.plocation = 'SOUTH AFRICA';

-- Q11. Find the total number of hours spent on NETWORKING.
SELECT SUM(w.hours) AS total_networking_hours
FROM works_on AS w
INNER JOIN project AS p
    ON w.pno = p.pnumber
WHERE p.pname = 'NETWORKING';

-- Q12. Display the employees who are staying in INDIA.
-- Interpreted using the department-location table: employees in departments whose listed location is INDIA.
SELECT DISTINCT e.*
FROM employee AS e
INNER JOIN dept_locations AS dl
    ON e.dno = dl.dnumber
WHERE dl.dlocation = 'INDIA';

-- Q13. Display all the employees' total number of hours spent in their respective project.
SELECT e.esrno, e.ename, p.pname,
       SUM(w.hours) AS total_hours
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
INNER JOIN project AS p
    ON w.pno = p.pnumber
GROUP BY e.esrno, e.ename, p.pnumber, p.pname;

-- Q14. Display the total hours spent on LINUX.
SELECT SUM(w.hours) AS total_linux_hours
FROM works_on AS w
INNER JOIN project AS p
    ON w.pno = p.pnumber
WHERE p.pname = 'LINUX';

-- Q15. Display all INDIA project members.
SELECT DISTINCT e.*
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
INNER JOIN project AS p
    ON w.pno = p.pnumber
WHERE p.plocation = 'INDIA';

-- Q16. Display employee no, name, department no, department name, project name and number of working hours.
SELECT e.esrno, e.ename, d.dnumber, d.dname,
       p.pname, w.hours
FROM employee AS e
INNER JOIN department AS d
    ON e.dno = d.dnumber
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
INNER JOIN project AS p
    ON w.pno = p.pnumber;

-- Q17. Display all the names who are belonging to the RESEARCH department.
SELECT e.ename
FROM employee AS e
INNER JOIN department AS d
    ON e.dno = d.dnumber
WHERE d.dname = 'RESEARCH';

-- Q18. Display the details of employees who are working >5 hours.
SELECT DISTINCT e.*
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
WHERE w.hours > 5;

-- Q19. Who all are not in ACADEMIC department?
SELECT e.*
FROM employee AS e
INNER JOIN department AS d
    ON e.dno = d.dnumber
WHERE d.dname <> 'ACADEMIC';

-- Q20. Find the total working hours of all female employees.
SELECT SUM(w.hours) AS total_female_working_hours
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
WHERE e.sex = 'F';

-- Q21. Find the total working hours of each manager.
-- Counts the project hours worked by employees reporting to each manager.
SELECT m.esrno AS manager_esrno,
       m.ename AS manager_name,
       SUM(w.hours) AS team_total_hours
FROM employee AS m
INNER JOIN employee AS subordinate
    ON subordinate.mgrsrno = m.esrno
INNER JOIN works_on AS w
    ON w.esrno = subordinate.esrno
GROUP BY m.esrno, m.ename;

-- Q22. Display the details of MEENAKSHI from all tables.
-- Shows MEENAKSHI's employee, department, department-location,project-assignment and project details where matching rows exist.
SELECT e.*, d.dname, dl.dlocation, w.pno, w.hours,
       p.pname, p.plocation
FROM employee AS e
LEFT JOIN department AS d
    ON e.dno = d.dnumber
LEFT JOIN dept_locations AS dl
    ON d.dnumber = dl.dnumber
LEFT JOIN works_on AS w
    ON e.esrno = w.esrno
LEFT JOIN project AS p
    ON w.pno = p.pnumber
WHERE e.ename = 'MEENAKSHI';

-- Q23. Display the employee names who are in project number 19.
SELECT DISTINCT e.ename
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
WHERE w.pno = 19;

-- Q24. Display BOSTON employees' working hours.
SELECT e.esrno, e.ename, SUM(w.hours) AS total_working_hours
FROM employee AS e
INNER JOIN works_on AS w
    ON e.esrno = w.esrno
WHERE UPPER(e.address) LIKE '%BOSTON%'
GROUP BY e.esrno, e.ename;

-- Q25. Display project name, project location, employee serial no and total working hours of the employees.
SELECT p.pname, p.plocation, e.esrno,
       SUM(w.hours) AS total_working_hours
FROM project AS p
INNER JOIN works_on AS w
    ON p.pnumber = w.pno
INNER JOIN employee AS e
    ON w.esrno = e.esrno
GROUP BY p.pnumber, p.pname, p.plocation, e.esrno;

-- Q26. Display the total hours spent on each project.
SELECT p.pname, SUM(w.hours) AS total_hours
FROM project AS p
INNER JOIN works_on AS w
    ON p.pnumber = w.pno
GROUP BY p.pnumber, p.pname;

-- Q27. Display the department name that spends the maximum hours in its project(s). If departments tie, all departments with the maximum are shown.
WITH department_hours AS (
    SELECT d.dnumber, d.dname, SUM(w.hours) AS total_hours
    FROM department AS d
    INNER JOIN employee AS e
        ON e.dno = d.dnumber
    INNER JOIN works_on AS w
        ON w.esrno = e.esrno
    GROUP BY d.dnumber, d.dname
)
SELECT dname, total_hours
FROM department_hours
WHERE total_hours = (SELECT MAX(total_hours) FROM department_hours);

-- Q28. Show the details of AJIT NAYAK from EMPLOYEE and WORKS_ON.
SELECT e.*, w.pno, w.hours
FROM employee AS e
LEFT JOIN works_on AS w
    ON e.esrno = w.esrno
WHERE e.ename = 'AJIT NAYAK';

-- Q29. Find the details of all employees from all tables.
-- LEFT JOINs retain every employee, including employees without a matching project assignment or department-location record.
SELECT e.*, d.dname, dl.dlocation,
       w.pno, w.hours, p.pname, p.plocation
FROM employee AS e
LEFT JOIN department AS d
    ON e.dno = d.dnumber
LEFT JOIN dept_locations AS dl
    ON d.dnumber = dl.dnumber
LEFT JOIN works_on AS w
    ON e.esrno = w.esrno
LEFT JOIN project AS p
    ON w.pno = p.pnumber;
