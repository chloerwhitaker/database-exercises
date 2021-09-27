USE employees;
-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
-- 55 rows (hire date = 1190-10-22)
SELECT *
FROM employees
JOIN dept_emp USING(emp_no)
WHERE hire_date = 
	(SELECT hire_date 
	FROM employees 
	WHERE emp_no = '101010')
AND to_date > CURDATE();


-- 2. Find all the titles ever held by all current employees with the first name Aamod.
-- 168 rows - after GROUP BY - Senior Staff, Engineer, Technique Leader, Senior Engineer, Staff, Assistant Engineer
SELECT title
FROM titles 
WHERE emp_no IN 
	(SELECT emp_no 
	FROM employees 
	WHERE first_name = 'Aamod') 
AND to_date > CURDATE()
GROUP BY title; 

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
-- 59,900
SELECT *
FROM employees
WHERE emp_no NOT IN 
	(SELECT emp_no
	FROM salaries
	WHERE to_date = '9999-01-01' GROUP BY emp_no);
-- 4. Find all the current department managers that are female. List their names in a comment in your code.
-- Isamu Legleitner	, Karsten Sigstam, Leon	DasSarma, Hilary Kambil
SELECT first_name, Last_name, gender
FROM employees
WHERE gender = 'F' AND emp_no IN 
	(SELECT emp_no
	FROM dept_manager
	WHERE to_date > CURDATE());
-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT avg(salary)
FROM salaries;

SELECT first_name, last_name
FROM employees
WHERE emp_no IN 
	(SELECT emp_no FROM salaries WHERE salary > 63810.7448 AND to_date > CURDATE())	; -- 154543

SELECT emp_no, first_name, last_name, salary
FROM salaries
JOIN employees
	USING(emp_no)	
WHERE salary > 
	(SELECT avg(salary) 
	FROM salaries 
	WHERE to_date > CURDATE()); -- 808962 
-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- Hint Number 1 You will likely use a combination of different kinds of subqueries.
-- Hint Number 2 Consider that the following code will produce the z score for current salaries.
SELECT COUNT(*)
FROM salaries 
WHERE SALARY > 
	(SELECT MAX(salary)
	FROM salaries 
	WHERE to_date > now())
	-
	(SELECT STDDEV(salary)
	FROM salaries
	WHERE to_date > now())
AND to_date > CURDATE(); -- 83

-- what % of all salaries is 83 -- code above / count of all salaries

SELECT
	((SELECT COUNT(*)
	FROM salaries 
	WHERE SALARY > 
		(SELECT MAX(salary)
		FROM salaries 
		WHERE to_date > now())
		-
		(SELECT STDDEV(salary)
		FROM salaries
		WHERE to_date > now())
	AND to_date > CURDATE()))
/
	(SELECT count(*)
	FROM salaries 
	WHERE to_date > now()) * 100 AS "percentage of salaries within 1 stddev of max salary"; -- 0.0346 (3%) 




