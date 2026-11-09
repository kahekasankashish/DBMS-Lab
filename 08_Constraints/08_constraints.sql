-- Assignment 8: Constraints

-- Q1. Create EMPLOYEE with the specified constraints.
CREATE TABLE employee (
    ename   VARCHAR(30) NOT NULL,
    esrno   NUMERIC(6,0) PRIMARY KEY
            CHECK (esrno BETWEEN 100000 AND 999999),
    bdate   DATE
            CHECK (bdate >= DATE '1955-01-01'
               AND bdate <  DATE '1980-01-01'),
    address VARCHAR(50),
    sex     CHAR(1) DEFAULT 'M',
    salary  NUMERIC(8,2)
            CHECK (salary BETWEEN 20000 AND 40000),
    mgrsrno NUMERIC(6,0),
    dno     NUMERIC(2,0),
    CONSTRAINT ck_employee_sex CHECK (sex IN ('M', 'F'))
);

-- Q2. Create DEPARTMENT with the specified constraints.
CREATE TABLE department (
    dname     VARCHAR(20)
              CHECK (dname IN ('RESEARCH', 'ADMIN', 'PROJECT', 'ACADEMIC')),
    dnumber   NUMERIC(2,0) PRIMARY KEY
              CHECK (dnumber > 0 AND dnumber <= 4),
    mgrsrno   NUMERIC(6,0),
    mgrstartd DATE
);

-- Q3. Create DEPT_LOCATIONS with the specified constraints.
CREATE TABLE dept_locations (
    dnumber  NUMERIC(2,0)
             CHECK (dnumber > 0 AND dnumber <= 4),
    dlocation VARCHAR(20)
              CHECK (dlocation IN ('SINGAPORE', 'INDIA', 'QUUENSLAND', 'LONDON')),
    CONSTRAINT pk_dept_locations PRIMARY KEY (dnumber, dlocation)
);

-- Q4. Create PROJECT with the specified constraints.
CREATE TABLE project (
    pname     VARCHAR(30)
              CHECK (pname IN ('NETWORKING', 'BIO INFORMATICS', 'LINUX')),
    pnumber   NUMERIC(3,0) PRIMARY KEY,
    plocation VARCHAR(20)
              CHECK (plocation IN ('KOREA', 'SOUTH AFRICA', 'INDIA')),
    dnum      NUMERIC(2,0)
);

-- Q5. Create WORKS_ON with all columns greater than zero.
-- No primary key is added because the sample data repeats ESRNO/PNO pairs.
CREATE TABLE works_on (
    esrno NUMERIC(6,0) CHECK (esrno > 0),
    pno   NUMERIC(3,0) CHECK (pno > 0),
    hours NUMERIC(4,2) CHECK (hours > 0)
);

-- Insert the sample EMPLOYEE records shown in the assignment.
INSERT INTO employee (ename, esrno, bdate, address, sex, salary, mgrsrno, dno) VALUES
('AJIT NAYAK', 133100, DATE '1955-04-25', '73 BOSTON', 'M', 35000, NULL, 1),
('SATYA', 495823, DATE '1966-07-17', '26 FINE OAK', 'M', 32770, 133100, 4),
('AJIT BEHERA', 315152, DATE '1971-07-09', '10 KALINGA', 'M', 32802, 133100, 3),
('UMASHANKAR', 216852, DATE '1967-07-17', '26 FINE OAK', 'M', 32770, 133100, 2),
('BHAGWAT', 215152, DATE '1971-03-23', '55 FLORIDA', 'M', 32802, 216852, 2),
('MEENAKSHI', 334548, DATE '1979-04-25', '73 BRIKLY', 'F', 25125, 315152, 3),
('JASWASI', 215485, DATE '1979-08-12', '17 BOSTON', 'M', 20500, 495823, 4),
('NIHAR NAYAK', 334524, DATE '1966-12-17', '73 DALLAS', 'M', 29105, 315152, 3),
('DEBASMITA', 295485, DATE '1970-04-16', '1 QUEENS LAND', 'F', 20500, 216852, 2);

-- Insert DEPARTMENT records.
INSERT INTO department (dname, dnumber, mgrsrno, mgrstartd) VALUES
('RESEARCH', 4, 495823, DATE '1999-04-20'),
('ADMIN', 1, 133100, DATE '1988-01-06'),
('PROJECT', 2, 216852, DATE '1999-07-17'),
('ACADEMIC', 3, 315152, DATE '1989-12-20');

-- Insert DEPT_LOCATIONS records.
INSERT INTO dept_locations (dnumber, dlocation) VALUES
(2, 'SINGAPORE'),
(1, 'INDIA'),
(4, 'QUUENSLAND'),
(3, 'LONDON');

-- Insert PROJECT records.
INSERT INTO project (pname, pnumber, plocation, dnum) VALUES
('NETWORKING', 11, 'KOREA', 4),
('BIO INFORMATICS', 19, 'SOUTH AFRICA', 3),
('LINUX', 17, 'INDIA', 2);

-- Insert all WORKS_ON sample rows shown in the PDF.
INSERT INTO works_on (esrno, pno, hours) VALUES
(495823, 11, 5.27),
(215152, 17, 2.32),
(495823, 11, 4.15),
(315152, 19, 1.25),
(334548, 19, 3.28),
(215485, 17, 1.25),
(295485, 17, 5.35),
(334548, 19, 2.54),
(295485, 17, 7.20),
(216852, 17, 2.41),
(334524, 19, 3.24),
(295485, 17, 1.36),
(495823, 11, 2.36),
(215152, 17, 1.25),
(495823, 11, 3.14),
(315152, 19, 2.05),
(334548, 19, 2.50),
(215485, 17, 2.34);

-- Add the foreign keys listed in foreign key.txt.
-- They are added after the inserts to handle the circular employee/department
-- manager and department-number references without disabling constraints.
ALTER TABLE employee
    ADD CONSTRAINT fk_employee_mgr
    FOREIGN KEY (mgrsrno) REFERENCES employee (esrno);

ALTER TABLE employee
    ADD CONSTRAINT fk_employee_dept
    FOREIGN KEY (dno) REFERENCES department (dnumber);

ALTER TABLE department
    ADD CONSTRAINT fk_department_mgr
    FOREIGN KEY (mgrsrno) REFERENCES employee (esrno);

ALTER TABLE dept_locations
    ADD CONSTRAINT fk_dept_locations_dept
    FOREIGN KEY (dnumber) REFERENCES department (dnumber);

ALTER TABLE project
    ADD CONSTRAINT fk_project_dept
    FOREIGN KEY (dnum) REFERENCES department (dnumber);

ALTER TABLE works_on
    ADD CONSTRAINT fk_works_on_project
    FOREIGN KEY (pno) REFERENCES project (pnumber);

ALTER TABLE works_on
    ADD CONSTRAINT fk_works_on_employee
    FOREIGN KEY (esrno) REFERENCES employee (esrno);

-- Optional verification queries.
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM dept_locations;
SELECT * FROM project;
SELECT * FROM works_on;
