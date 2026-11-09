-- Assignment 1
-- Question 1: Create the EMP, Dept, and Student tables with the column
-- names and data types specified in the assignment.

CREATE TABLE emp (
    empno NUMERIC(4, 0),
    ename VARCHAR(10),
    job VARCHAR(9),
    mgr NUMERIC(4, 0),
    hiredate DATE,
    sal NUMERIC(7, 2),
    comm NUMERIC(7, 2),
    deptno NUMERIC(2, 0)
);

CREATE TABLE dept (
    deptno NUMERIC(2, 0),
    dname VARCHAR(14),
    loc VARCHAR(13)
);

CREATE TABLE student (
    roll INTEGER,
    name VARCHAR(100),
    dob DATE,
    cgpa NUMERIC(4, 2),
    dept_id INTEGER
);
