-- Use the employees database.
USE employees;
-- List all the tables in the database
SHOW TABLES;
-- Explore the employees table. What different data types are present on this table? int, date, varchar, enum, date
DESCRIBE employees;
-- Which table(s) do you think contain a numeric type column? salaries specifically but probably all
DESCRIBE salaries;
DESCRIBE employees;
DESCRIBE titles;
DESCRIBE departments;
DESCRIBE dept_manager;
DESCRIBE dept_emp;
DESCRIBE current_dept_emp;
DESCRIBE dept_emp_latest_date
-- Which table(s) do you think contain a string type column? current_dept_emp, departments, dept_emp, employees, titles,..
DESCRIBE employees;
DESCRIBE titles;
DESCRIBE departments;
DESCRIBE dept_manager;
DESCRIBE dept_emp;
DESCRIBE current_dept_emp;
-- Which table(s) do you think contain a date type column? dept_emp_latest_date
DESCRIBE dept_emp_latest_date
-- What is the relationship between the employees and the departments tables? If you find the employee number you can find their dept. 
-- Show the SQL that created the dept_manager table.
SHOW CREATE TABLE dept_manager;