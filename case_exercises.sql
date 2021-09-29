-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

USE employees; 
SELECT emp_no, dept_no, hire_date AS 'start_date', to_date AS 'end_date', IF(to_date < CURDATE(), 1, 0) AS is_current_employee
FROM employees
JOIN dept_emp USING(emp_no);

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name, last_name,
	CASE
	WHEN last_name LIKE 'A%' OR 'H%' THEN 'A-H'
    WHEN last_name LIKE 'I%' OR 'Q%' THEN 'I-Q'
    ELSE 'R-Z'
    END AS alpha_group
FROM employees; -- Couldn't get to work with LIKE... Defaults to ELSE... so tried BETWEEN 

SELECT first_name, last_name,
	CASE
	WHEN last_name BETWEEN 'A' AND 'H' THEN 'A-H'
    WHEN last_name BETWEEN 'I' AND 'Q' THEN 'I-Q'
    ELSE 'R-Z'
    END AS alpha_group
FROM employees; -- WORKS! 

-- 3. How many employees (current or previous) were born in each decade?
SELECT birth_date 
FROM employees 
ORDER BY birth_date; DESC; -- desc = 1965, asc = 1952

SELECT
SUM(CASE WHEN birth_date LIKE '195%' THEN 1 ELSE 0 END) AS '1950s Birthdays', -- 182886
SUM(CASE WHEN birth_date LIKE '196%' THEN 1 ELSE 0 END) AS '1960s Birthdays' -- 117138
FROM employees;

