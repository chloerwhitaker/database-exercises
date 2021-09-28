SHOW GRANTS;
USE employees;

CREATE TEMPORARY TABLE hopper_1568.employees_with_salaries AS 
SELECT * FROM employees JOIN salaries USING(emp_no);

USE hopper_1568;
SELECT * FROM hopper_1568.employees_with_salaries;

-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.


USE employees;

CREATE TEMPORARY TABLE 
hopper_1568.employees_with_departments AS 
SELECT first_name, last_name, dept_name 
FROM employees 
JOIN dept_emp USING(emp_no)
JOIN departments USING (dept_no);

USE hopper_1568;
SELECT * FROM employees_with_departments;
-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
SELECT max(length(concat(first_name, ' ', last_name))) FROM hopper_1568.employees_with_departments; -- 30

ALTER TABLE hopper_1568.employees_with_departments ADD full_name 
VARCHAR(30);
SELECT * FROM employees_with_departments; -- created column with NULLs 
-- b. Update the table so that full name column contains the correct data
UPDATE hopper_1568.employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

SELECT * FROM hopper_1568.employees_with_departments;
-- c. Remove the first_name and last_name columns from the table.
ALTER TABLE hopper_1568.employees_with_departments DROP COLUMN first_name; 
SELECT * FROM hopper_1568.employees_with_departments;
ALTER TABLE hopper_1568.employees_with_departments DROP COLUMN last_name; 
SELECT * FROM hopper_1568.employees_with_departments;

-- d. What is another way you could have ended up with this same table?
-- Used "DESCRIBE" to get the VARCHAR count

-- 2. Create a temporary table based on the payment table from the sakila database. Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
USE sakila;
CREATE TEMPORARY TABLE hopper_1568.payments AS
SELECT * FROM sakila.payment;
SELECT * FROM hopper_1568.payments;
SELECT max(length(amount)) FROM hopper_1568.payments; -- (5)
ALTER TABLE hopper_1568.payments ADD amount_cents VARCHAR(8);
USE hopper_1568;
SELECT * FROM hopper_1568.payments;
UPDATE hopper_1568.payments SET amount_cents = amount*100;
SELECT * FROM hopper_1568.payments;
UPDATE hopper_1568.payments SET amount_cents = FLOOR(amount*100); -- FLOOR rounds up
SELECT * FROM hopper_1568.payments;
-- 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

CREATE temporary table hopper_1568.avg_dept_pay AS (
    SELECT dept_name, AVG(salary) AS dept_current_avg_salary
    FROM employees.salaries
    JOIN employees.dept_emp USING(emp_no)
    JOIN employees.departments USING(dept_no)
    WHERE employees.dept_emp.to_date > curdate()
    AND employees.salaries.to_date > curdate()
    GROUP BY dept_name
);

SELECT * FROM hopper_1568.avg_dept_pay;
USE hopper_1568; 

ALTER TABLE avg_dept_pay ADD COLUMN co_avg_salary FLOAT(10, 2); -- Added FLOAT after exercise explaination
UPDATE avg_dept_pay
SET co_avg_salary = 
    (SELECT AVG(salary) 
    FROM employees.salaries); 
SELECT * FROM hopper_1568.avg_dept_pay;

ALTER TABLE avg_dept_pay ADD COLUMN co_std_salary FLOAT(10, 2);
UPDATE avg_dept_pay
SET co_std_salary = 
    (SELECT stddev(salary) 
    FROM employees.salaries);
SELECT * FROM hopper_1568.avg_dept_pay;

ALTER TABLE avg_dept_pay ADD COLUMN zscore FLOAT(10, 2);
SELECT * FROM hopper_1568.avg_dept_pay;

UPDATE avg_dept_pay
SET zscore = 
    (dept_current_avg_salary - co_avg_salary) 
        / 
    co_std_salary
ORDER BY zscore DESC;
SELECT * FROM hopper_1568.avg_dept_pay;

-- Break big problems down to small ones. Do each step at a time,... then add to temporary table... cleaned up my thought process after excercise explaination 


