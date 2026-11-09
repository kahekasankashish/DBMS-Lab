-- Assignment 9: Update Exercise

-- Q1. Give all employees an increment of Rs 500.
UPDATE employee
SET salary = salary + 500;

-- Q2. Give employees of department 4 an increment of 0.5% of their salary.
UPDATE employee
SET salary = salary + (salary * 0.005)
WHERE dno = 4;

-- Q3. Change UMA SANKAR's address to 'Prasanti Vihar'.
UPDATE employee
SET address = 'Prasanti Vihar'
WHERE ename = 'UMASHANKAR';

-- Q4. Give a Rs 1000 increment to employees who do not have a manager.
-- PostgreSQL NULL comparison must use IS NULL, not = NULL.
UPDATE employee
SET salary = salary + 1000
WHERE mgrsrno IS NULL;

-- Q5. Change BISWA SAMAL's salary to Rs 20000.
UPDATE employee
SET salary = 20000
WHERE ename = 'BISWA SAMAL';

-- Q6. Reduce the salary of female employees by Rs 1000.
UPDATE employee
SET salary = salary - 1000
WHERE sex = 'F';

-- Q7. Change the manager of department 3 to employee 215152.
UPDATE department
SET mgrsrno = 215152
WHERE dnumber = 3;

-- Q8. Change the location of department 4 to INDIA.
UPDATE dept_locations
SET dlocation = 'INDIA'
WHERE dnumber = 4;

-- Q9. Change the name of project 19 to LINUX.
UPDATE project
SET pname = 'LINUX'
WHERE pnumber = 19;

-- Q10. Change the location of the project handled by department 4 to INDIA.
UPDATE project
SET plocation = 'INDIA'
WHERE dnum = 4;

-- Q11. Set the manager start date of the PROJECT department to 30-Jun-1999.
UPDATE department
SET mgrstartd = DATE '1999-06-30'
WHERE dname = 'PROJECT';

-- Q12. Delete DEBASMITA from the employee table.
DELETE FROM employee
WHERE ename = 'DEBASMITA';

-- Q13. Delete WORKS_ON rows for employee 295485.
DELETE FROM works_on
WHERE esrno = 295485;

-- Q14. Employee 315152 has stopped working on all projects.
-- Remove all of that employee's project-assignment rows.
DELETE FROM works_on
WHERE esrno = 315152;

-- Q15. Delete the employee whose birth date is 23-Mar-1971.
DELETE FROM employee
WHERE bdate = DATE '1971-03-23';

-- Q16. Change the department to 3 for the person living at 26 FINE OAK.
UPDATE employee
SET dno = 3
WHERE address = '26 FINE OAK';
