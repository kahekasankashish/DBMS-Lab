-- Assignment 7: DDL Statements — Create, Alter, Drop

-- Question 1: Create REGIONS, COUNTRIES, LOCATIONS, DEPARTMENTS, JOBS, JOB_HISTORY, EMPLOYEES.
CREATE TABLE regions (
    region_id NUMERIC(2,0), region_name VARCHAR(25)
);
CREATE TABLE countries (
    country_id VARCHAR(2), country_name VARCHAR(40), region_id NUMERIC(2,0)
);
CREATE TABLE locations (
    location_id NUMERIC(4,0), street_address VARCHAR(40), postal_code VARCHAR(40),
    city VARCHAR(30), state_province VARCHAR(25), country_id VARCHAR(2)
);
CREATE TABLE departments (
    department_id NUMERIC(4,0), department_name VARCHAR(30),
    manager_id NUMERIC(8,0), location_id NUMERIC(4,0)
);
CREATE TABLE jobs (
    job_id VARCHAR(10), job_title VARCHAR(35),
    min_salary NUMERIC(8,2), max_salary NUMERIC(8,2)
);
CREATE TABLE job_history (
    employee_id NUMERIC(6,0), start_date DATE, end_date DATE,
    job_id VARCHAR(10), department_id NUMERIC(4,0)
);
CREATE TABLE employees (
    employee_id NUMERIC(6,0), first_name VARCHAR(20), last_name CHAR(25),
    email VARCHAR(25), phone_number VARCHAR(20), hire_date DATE,
    job_id VARCHAR(10), salary NUMERIC(8,2), commission_pct NUMERIC(2,2),
    manager_id NUMERIC(8,0), department_id NUMERIC(4,0)
);

-- Question 2: Describe the structure of all tables created in Question 1.
SELECT table_name, ordinal_position, column_name, data_type,
       character_maximum_length, numeric_precision, numeric_scale
FROM information_schema.columns
WHERE table_schema = current_schema()
  AND table_name IN ('regions', 'countries', 'locations', 'departments',
                     'jobs', 'job_history', 'employees')
ORDER BY table_name, ordinal_position;

-- Question 3: Add zipcode NUMERIC(2,0) and street_no VARCHAR(50) to locations.
ALTER TABLE locations
    ADD COLUMN zipcode NUMERIC(2,0),
    ADD COLUMN street_no VARCHAR(50);

-- Question 4: Increase zipcode and street_address sizes in a single query.
ALTER TABLE locations
    ALTER COLUMN zipcode TYPE NUMERIC(4,0),
    ALTER COLUMN street_address TYPE VARCHAR(60);

-- Question 5: Drop zipcode and see structural changes.
ALTER TABLE locations DROP COLUMN zipcode;
SELECT column_name, data_type, character_maximum_length, numeric_precision
FROM information_schema.columns
WHERE table_schema = current_schema() AND table_name = 'locations'
ORDER BY ordinal_position;

-- Question 6: Rename street_no to street_code and see structural changes.
ALTER TABLE locations RENAME COLUMN street_no TO street_code;
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_schema = current_schema() AND table_name = 'locations'
ORDER BY ordinal_position;

-- Question 7: Rename locations to sit_location.
ALTER TABLE locations RENAME TO sit_location;

-- Question 8: Modify employees.last_name from CHAR to VARCHAR.
ALTER TABLE employees ALTER COLUMN last_name TYPE VARCHAR(25);

-- Question 9: Increase employees.employee_id precision to 10.
ALTER TABLE employees ALTER COLUMN employee_id TYPE NUMERIC(10,0);

-- Question 10: Decrease employees.last_name length to 20.
ALTER TABLE employees ALTER COLUMN last_name TYPE VARCHAR(20);

-- Question 11: Decrease employees.phone_number length to 18.
ALTER TABLE employees ALTER COLUMN phone_number TYPE VARCHAR(18);

-- Question 12: Add ANNSAL column to employees.
-- The PDF does not specify a type; NUMERIC(12,2) is chosen.
ALTER TABLE employees ADD COLUMN annsal NUMERIC(12,2);

-- Question 13: Show tables in the current schema (PostgreSQL catalog query).
SELECT table_name
FROM information_schema.tables
WHERE table_schema = current_schema() AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- Question 14: Change employees.last_name length to 24.
ALTER TABLE employees ALTER COLUMN last_name TYPE VARCHAR(24);

-- Question 15: Drop employees.annsal.
ALTER TABLE employees DROP COLUMN annsal;

-- Question 16: Increase departments.manager_id precision to 12.
ALTER TABLE departments ALTER COLUMN manager_id TYPE NUMERIC(12,0);

-- Question 17: Drop street_code from sit_location.
ALTER TABLE sit_location DROP COLUMN street_code;

-- Question 18: Rename sit_location back to locations.
ALTER TABLE sit_location RENAME TO locations;

-- Question 19: See structural changes to departments.
SELECT ordinal_position, column_name, data_type,
       character_maximum_length, numeric_precision, numeric_scale
FROM information_schema.columns
WHERE table_schema = current_schema() AND table_name = 'departments'
ORDER BY ordinal_position;
