-- Assignment 1
-- Question 2: Add Address and Zipcode columns to the Student table.
ALTER TABLE student
    ADD COLUMN address VARCHAR(100),
    ADD COLUMN zipcode INTEGER;

-- Question 3: Increase the capacity of Address and Zipcode in a single
-- ALTER TABLE statement. PostgreSQL INTEGER has a fixed storage size,
-- so Zipcode is widened to BIGINT; Address is widened to VARCHAR(150).
ALTER TABLE student
    ALTER COLUMN address TYPE VARCHAR(150),
    ALTER COLUMN zipcode TYPE BIGINT;

-- Question 4: Rename the Zipcode column to pincode.
ALTER TABLE student
    RENAME COLUMN zipcode TO pincode;

-- Question 5: Rename the Student table to Stud.
ALTER TABLE student
    RENAME TO stud;

-- Question 6: Increase the precision of EMP.empno from NUMERIC(4,0)
-- to NUMERIC(10,0).
ALTER TABLE emp
    ALTER COLUMN empno TYPE NUMERIC(10, 0);

-- Question 7: Drop the pincode and Address columns from Stud.
ALTER TABLE stud
    DROP COLUMN pincode,
    DROP COLUMN address;
