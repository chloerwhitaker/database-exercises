USE join_example_db;
-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
SELECT * FROM users;
SELECT * FROM roles;
-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
-- JOIN
SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;
-- LEFT
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;
-- RIGHT
SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;
-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name, COUNT(roles.id) as ROLE_COUNT
FROM users
RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY roles.id;
-- Employees Database
USE employees;
-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT departments.dept_name AS 'DEPARTMENT NAME', CONCAT(employees.first_name, ' ', employees.last_name) AS 'DEPRTMENT MANAGER' 
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no JOIN employees ON employees.emp_no = dept_manager.emp_no 
WHERE dept_manager.to_date > '2021-09-19'; 

-- 3. Find the name of all departments currently managed by women.
SELECT departments.dept_name AS 'DEPARTMENT NAME', CONCAT(employees.first_name, ' ', employees.last_name) AS 'DEPRTMENT MANAGER', employees.gender AS 'GENDER'
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no 
JOIN employees ON employees.emp_no = dept_manager.emp_no 
WHERE employees.gender = 'F' AND dept_manager.to_date > '2021-09-19'; 

-- 4. Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title AS 'TITLE', COUNT(employees.first_name) AS 'COUNT'
FROM employees
JOIN titles ON employees.emp_no = titles.emp_no 
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no 
WHERE dept_emp.to_date > '2021-09-19' AND dept_emp.dept_no = 'd009'
GROUP BY titles.title; 

-- 5. Find the current salary of all current managers.

SELECT department.dept_name, CONCAT(employee.first_name, ' ', employee.last_name) AS full_name,
	MAX(salary.salary)
FROM departments AS department
JOIN dept_manager AS managers ON department.dept_no = managers.dept_no
JOIN employees AS employee ON employee.emp_no = managers.emp_no
JOIN salaries AS salary ON salary.emp_no = employee.emp_no
WHERE managers.to_date > '2021-09-19'
GROUP BY department.dept_name, full_name;
	 
-- 6. Find the number of current employees in each department.
-- Someone suggested that I shorten my naming system so i'm going to try that...ha.
SELECT dp.dept_no, dp.dept_name, COUNT(e.emp_no) AS current_employees
FROM dept_emp AS de
JOIN employees AS e ON e.emp_no = de.emp_no
JOIN departments AS dp ON dp.dept_no = de.dept_no
GROUP BY dp.dept_no, dp.dept_name
ORDER BY dp.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
-- Sales at $88,842.16
SELECT dp.dept_name AS dept_name, AVG(salary) AS average_salary
FROM dept_emp AS de
JOIN departments AS dp ON dp.dept_no = de.dept_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE s.to_date > '2021-09-19'
GROUP BY dp.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department? 
-- AKemi Warwick making $145,128
SELECT e.first_name AS first_name, e.last_name AS last_name, MAX(salary)
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Marketing'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?
-- VIshwani Minakawa at $106,491 (Marketing) 
SELECT e.first_name, e.last_name, MAX(salary) AS salary, dp.dept_name
FROM departments AS dp
JOIN dept_manager AS dm ON dp.dept_no = dm.dept_no
JOIN employees AS e ON e.emp_no = dm.emp_no
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE dm.to_date > '2021-09-19'
GROUP BY e.first_name, e.last_name, dp.dept_name
ORDER BY salary DESC
LIMIT 1;

-- 10. Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', m.manager_name AS 'Manager Name'
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no AND de.to_date > '2021-09-19'
JOIN 
	(SELECT dm.dept_no, CONCAT(e.first_name, ' ', e.last_name) AS manager_name
	  FROM dept_manager AS dm
      JOIN employees AS e ON dm.emp_no = e.emp_no AND to_date > '2021-09-19') 
AS m ON m.dept_no = d.dept_no;

-- 11. Bonus Who is the highest paid employee within each department.
-- Marketing Akemi Warwick
-- Customer Service Vidya Hanabata
-- Development Khosrow Sgarro 
-- Finance Lunjin Swick
-- Human Resources Yinlin Flowers 
-- Production Youjian Cronau 
-- Quality Management Shin Luck 
-- Research Ramachenga Soicher 
-- Sales Tokuyasu Pesch 

-- Marketing Akemi Warwick
SELECT e.first_name AS first_name, e.last_name AS last_name
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Marketing'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;
-- Customer Service Vidya Hanabata
SELECT e.first_name AS first_name, e.last_name AS last_name
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Customer Service'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;
-- Development Khosrow Sgarro 
SELECT e.first_name AS first_name, e.last_name AS last_name
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Development'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;
-- Finance Lunjin Swick
SELECT e.first_name AS first_name, e.last_name AS last_name
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Finance'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;
-- Human Resources Yinlin Flowers 
SELECT e.first_name AS first_name, e.last_name AS last_name
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Human Resources'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;
-- Production Youjian Cronau 
SELECT e.first_name AS first_name, e.last_name AS last_name
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Production'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;
-- Quality Management Shin Luck 
SELECT e.first_name AS first_name, e.last_name AS last_name
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Quality Management'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;
-- Research Ramachenga Soicher 
SELECT e.first_name AS first_name, e.last_name AS last_name
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Research'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;
-- Sales Tokuyasu Pesch 
SELECT e.first_name AS first_name, e.last_name AS last_name
FROM dept_emp AS de
JOIN departments AS dp ON de.dept_no = dp.dept_no
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE dp.dept_name = 'Sales'
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;
