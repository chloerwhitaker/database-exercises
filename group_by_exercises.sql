-- 1. Create a new file named group_by_exercises.sql

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
--  7 
SELECT DISTINCT title
FROM titles;
-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
-- Erde, Eldridge, Etalle, Erie, Erbe
SELECT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
-- 846 rows
SELECT concat(first_name, " ", last_name) AS full_name, count(*) AS n_same_full_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY full_name;

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
-- Chleq, Lindqvist, Qiwen
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' 
GROUP BY last_name
HAVING last_name NOT LIKE '%qu%'; 



-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
-- Chleq (189), Lindqvist (190), Qiwen (168)
SELECT last_name, count(*) AS n_same_last_name
FROM employees
WHERE last_name LIKE '%q%' 
GROUP BY last_name
HAVING last_name NOT LIKE '%qu%'; 

-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
-- Vidya	M	151, Irena	M	144, Irena	F	97, Maya	F	90, Vidya	F	81, Maya	M	146
SELECT first_name, gender, count(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender; 


-- 8.Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
-- 283988 rows
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4),"_", SUBSTR(hire_date, 6, 2), SUBSTR(hire_date, 3, 2))) 
AS username, COUNT(*) AS duplicates 
FROM employees
GROUP BY username
ORDER BY duplicates DESC;


-- 9.  More practice with aggregate functions:
-- Find the historic average salary for all employees. Now determine the current average salary.
-- 63810.7448 / 72012.2359
SELECT avg(salary)
FROM salaries; 

SELECT avg(salary)
FROM salaries
WHERE to_date > curdate(); 
10. -- Now find the historic average salary for each employee. Reminder that when you hear "for each" in the problem statement, you'll probably be grouping by that exact column.
-- 300024 rows
SELECT emp_no, avg(salary)
FROM salaries
GROUP BY emp_no;
-- 11. Find the current average salary for each employee.
--240124 rows
SELECT emp_no, avg(salary)
FROM salaries
WHERE to_date > curdate()
GROUP BY emp_no;
-- 12. Find the maximum salary for each current employee.
-- 240124 rows
SELECT emp_no, max(salary)
FROM salaries
WHERE to_date > curdate()
GROUP BY emp_no;
-- 13. Now find the max salary for each current employee where that max salary is greater than $150,000.
-- 15 rows
SELECT emp_no, max(salary)
FROM salaries
WHERE to_date > curdate()
GROUP BY emp_no
HAVING max(salary) > 150000;
-- 14. Find the current average salary for each employee where that average salary is between $80k and $90k.
-- 32351
SELECT emp_no, max(salary)
FROM salaries
WHERE to_date > curdate()
GROUP BY emp_no
HAVING max(salary) between 80000 and 90000;