-- Assignment 10: DML Statements (INSERT, UPDATE, DELETE)

-- Q1. Insert the rows in the tables created in Assignment 7.

INSERT INTO regions (region_id, region_name) VALUES
(1, 'Europe'), (2, 'Americas'), (3, 'Asia'), (4, 'Middle East and Africa');

INSERT INTO countries (country_id, country_name, region_id) VALUES
('IT', 'Italy', 1), ('JP', 'Japan', 3),
('US', 'United States of America', 2), ('CA', 'Canada', 2),
('CN', 'China', 3), ('IN', 'India', 3), ('ZW', 'Zimbabwe', 4);

INSERT INTO locations
(location_id, street_address, postal_code, city, state_province, country_id)
VALUES
(1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT'),
(1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT'),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 114, 1700),
(40, 'Human Resources', 203, 1400),
(50, 'Shipping', 121, 1500);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES
('AD_PRES', 'President', 20000, 40000),
('AD_VP', 'Administration Vice President', 15000, 30000),
('AD_ASST', 'Administration Assistant', 3000, 6000),
('FI_MGR', 'Finance Manager', 8200, 16000);

INSERT INTO employees
(employee_id, first_name, last_name, email, phone_number, hire_date,
 job_id, salary, commission_pct, manager_id, department_id)
VALUES
(100, 'Steven', 'King', 'sking@yahoo.com', '515.123.4567',
 DATE '1987-06-17', 'AD_PRES', 24000, NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'nkochhar@yahoo.co.in', '515.123.4568',
 DATE '1989-09-21', 'AD_VP', 17000, NULL, 100, 90),
(102, 'Lex', 'De Haan', 'ldehaan@rediffmail.com', '515.123.4569',
 DATE '1993-01-13', 'AD_VP', 17000, NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'ahunold@gmail.com', '590.423.4567',
 DATE '1990-01-03', 'SA_REP', 9000, NULL, 102, 60);

INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
VALUES
(102, DATE '1993-01-13', DATE '1998-07-24', 'SA_REP', 60),
(101, DATE '1989-09-21', DATE '1993-10-27', 'AC_ACCOUNT', 100),
(104, DATE '1993-10-28', DATE '1997-03-15', 'AC_MGR', 100),
(201, DATE '1996-02-17', DATE '1999-12-19', 'SA_REP', 20);

-- Q2. Change all the manager id with department id concatenating location id
-- in DEPARTMENTS table.
UPDATE departments
SET manager_id = (department_id::text || location_id::text)::NUMERIC;

-- Q3. Change all the location id with first three digits of existing location id
-- in LOCATIONS table.
UPDATE locations
SET location_id = LEFT(location_id::text, 3)::NUMERIC;

-- Q4. Change the min salary incremented by 5% and max salary decrement by 5%
-- in JOBS table.
UPDATE jobs
SET min_salary = min_salary * 1.05,
    max_salary = max_salary * 0.95;

-- Q5. Change all the job title concatenated with "Sr."
UPDATE jobs
SET job_title = 'Sr. ' || job_title;

-- Q6. Change all the job id without underscore in JOBS table.
UPDATE jobs
SET job_id = REPLACE(job_id, '_', '');

-- Q7. Delete all the employee data who have joined before 18th September 1988.
DELETE FROM employees
WHERE hire_date < DATE '1988-09-18';

-- Q8. Delete the employee whose name is "Neena Kochhar".
DELETE FROM employees
WHERE first_name = 'Neena' AND last_name = 'Kochhar';

-- Q9. Change the state province with city where state province is not known
-- in LOCATIONS table.
UPDATE locations
SET state_province = city
WHERE state_province IS NULL;

-- Q10. Delete the departments from department table which is located in
-- Location ID 1500.
DELETE FROM departments
WHERE location_id = 1500;

-- Q11. Display the countries that are located either in region_id 2 and 3.
SELECT country_name
FROM countries
WHERE region_id IN (2, 3);

-- Q12. Display the employees those who are working in department no 90.
SELECT *
FROM employees
WHERE department_id = 90;

-- Q13. Update the department of Steven to 20.
UPDATE employees
SET department_id = 20
WHERE first_name = 'Steven';
