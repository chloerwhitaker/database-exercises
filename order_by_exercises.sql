USE employees;
-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
-- Irena Reutenauer / Vidya	Simmen
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name DESC, emp_no DESC;
-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
-- Irena Acton / Vidya	Zweizig
SELECT * FROM employees WhERE first_name = 'Irena' OR first_name = 'Vidya' or first_name = 'Maya' ORDER BY first_name, last_name;
SELECT * FROM employees WhERE first_name = 'Irena' OR first_name = 'Vidya' or first_name = 'Maya' ORDER BY first_name DESC, last_name DESC;
 -- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
 -- Irena Acton / Maya	Zyda
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name, first_name;
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name DESC, first_name DESC;
-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
-- Ramzi Erde / Tadahiro Erde
SELECT * FROM employees WHERE last_name LIKE 'e%e' ORDER BY emp_no;
SELECT * FROM employees WHERE last_name LIKE 'e%e' ORDER BY emp_no DESC;
-- 6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.
-- Teiji Eldridge / 899 / Sergi	Erde
SELECT * FROM employees WHERE last_name LIKE 'e%e' ORDER BY hire_date DESC;
SELECT * FROM employees WHERE last_name LIKE 'e%e' ORDER BY hire_date;
-- 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.
-- Khun	Bernini / Douadi Pettis
SELECT * FROM employees WHERE hire_date LIKE '199%-%-%' AND birth_date LIKE '%-12-25' ORDER BY birth_date, hire_date DESC;
SELECT * FROM employees WHERE hire_date LIKE '199%-%-%' AND birth_date LIKE '%-12-25' ORDER BY birth_date DESC, hire_date ASC;
