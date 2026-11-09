-- Assignment 1
-- Question 8: Insert the records provided in the assignment into the
-- EMP, Dept, and Student tables. Student was renamed to Stud in Question 5.

INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
    (7369, 'SMITH',  'CLERK',     7902, '1980-12-17',  800.00, NULL, 20),
    (7499, 'ALLEN',  'SALESMAN',  7698, '1981-02-20', 1600.00, 300.00, 30),
    (7521, 'WARD',   'SALESMAN',  7698, '1981-02-22', 1250.00, 500.00, 30),
    (7566, 'JONES',  'MANAGER',   7839, '1981-04-02', 2975.00, NULL, 20),
    (7654, 'MARTIN', 'SALESMAN',  7698, '1981-09-28', 1250.00, 1400.00, 30),
    (7698, 'BLAKE',  'MANAGER',   7839, '1981-05-01', 2850.00, NULL, 30),
    (7782, 'CLARK',  'MANAGER',   7839, '1981-06-09', 2450.00, NULL, 10),
    (7788, 'SCOTT',  'ANALYST',   7566, '1982-12-09', 3000.00, NULL, 20),
    (7839, 'KING',   'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
    (7844, 'TURNER', 'SALESMAN',  7698, '1981-09-08', 1500.00, 0.00, 30),
    (7876, 'ADAMS',  'CLERK',     7788, '1983-01-12', 1100.00, NULL, 20),
    (7900, 'JAMES',  'CLERK',     7698, '1981-12-03',  950.00, NULL, 30),
    (7902, 'FORD',   'ANALYST',   7566, '1981-12-03', 3000.00, NULL, 20),
    (7934, 'MILLER', 'CLERK',     7782, '1982-01-23', 1300.00, NULL, 10);

INSERT INTO dept (deptno, dname, loc) VALUES
    (10, 'ACCOUNTING', 'NEW YORK'),
    (20, 'RESEARCH',   'DALLAS'),
    (30, 'SALES',      'CHICAGO'),
    (40, 'OPERATIONS', 'BOSTON');

INSERT INTO stud (roll, name, dob, cgpa, dept_id) VALUES
    (1, 'aaa', '2000-01-25', 9.10, 100),
    (1, 'bbb', '2000-01-26', 9.10, 100),
    (3, 'ccc', '2020-01-27', 9.20, 101),
    (4, 'ddd', '2000-01-26', 9.10, 100),
    (1, 'bbb', '2000-01-26', 9.10, 100),
    (3, 'ccc', '2020-01-27', 9.20, 101),
    (4, 'ddd', '2000-01-26', 9.10, 100);
