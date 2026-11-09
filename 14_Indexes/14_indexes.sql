-- Assignment 14: Index

-- Q1. Create an index on esrno of employee table.
CREATE INDEX idx_emp
ON employee (esrno);


-- Q2. Create an index on (esrno, pno) of works_on table.
CREATE INDEX idx_works
ON works_on (esrno, pno);


-- Q3. Create an unique index on esrno of employee table.
CREATE UNIQUE INDEX idx_esrno
ON employee (esrno);


-- Q4. Create a reverse index on salary of employee.
CREATE INDEX idx_emp_sal_rev
ON employee (REVERSE(salary::text));

-- Q6. Change the index in Q4 to nonreverse.
DROP INDEX IF EXISTS idx_emp_sal_rev;

CREATE INDEX idx_emp_sal
ON employee (salary);
