USE employees;
-- 2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:
SELECT DISTINCT title FROM titles;
-- List the first 10 distinct last name sorted in descending order: Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker
SELECT DISTINCT last_name FROM employees ORDER by last_name DESC LIMIT 10;
-- 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
-- Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter	Stroustrup
SELECT first_name, last_name, emp_no FROM employees WHERE hire_date LIKE '199%-%-%' AND birth_date LIKE '%-12-25' ORDER BY hire_date LIMIT 5;
-- 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
-- Pranay Narwekar, Marjo Farrow, Ennio Karcich, Dines Lubachevsky, Ipke Fontan
-- OFFSET = number of results to skip / LIMIT = The number of results to show / Page number = each page has a limit of 5, so the 10th page would be shown by skipping 45 results, before showing the next 5. 
SELECT first_name, last_name, emp_no FROM employees WHERE hire_date LIKE '199%-%-%' AND birth_date LIKE '%-12-25' ORDER BY hire_date LIMIT 5 OFFSET 45;
-- Offset = (Page-1) * Limit 
-- O = (N-1)*5
-- O = (10-1)*5 
-- Offset = 9*5 = 45
-- Offset = 45
