-- Data Analysis
-- 1.What is the age distribution of employees in the company?
SELECT age, COUNT(age) AS number_of_employees
FROM hr 
GROUP BY age
HAVING age>= 18;

SELECT age
FROM hr
WHERE age >= 60;

-- No employee above 60 years old

SELECT MIN(age) AS youngest,MAX(age) AS oldest
FROM hr
WHERE age>= 18;
-- The age of youngest employee is 21 and oldest is 57

SELECT FLOOR(age/10)*10 AS age_group, COUNT(*) AS number_of_employees
FROM hr
WHERE age > 18
GROUP BY age_group
ORDER BY age_group ASC;

SELECT 
  CASE 
    WHEN age >= 20 AND age <= 29 THEN '20-29'
    WHEN age >= 30 AND age <= 39 THEN '30-39'
    WHEN age >= 40 AND age <= 49 THEN '40-49'
    WHEN age >= 50 AND age <= 59 THEN '50-59'
    ELSE '60+' 
  END AS age_group,COUNT(*) AS count
FROM hr
WHERE age >= 18
GROUP BY age_group
ORDER BY age_group;
-- Most employees belongs to the age group '30-39'and the age group '50-59' has least employees

-- 2.What is the gender breakdown of employees in the company?
SELECT gender, COUNT(gender) AS number_of_employees
FROM hr
WHERE age > 18
GROUP BY gender;
-- Most number of employees are males.
-- 3.What is the age distribution of each gender? 
SELECT 
	CASE
		WHEN age >= 20 AND age <= 29 THEN '20-29'
		WHEN age >= 30 AND age <= 39 THEN '30-39'
		WHEN age >= 40 AND age <= 49 THEN '40-49'
		WHEN age >= 50 AND age <= 59 THEN '50-59'
		ELSE '60+' 
	END AS age_group,gender,COUNT(*)
FROM hr
WHERE age > 18
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4.How many employees work at headquaters versus remote locations?
SELECT location, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location;
-- Most people work at headquaters

-- 5.How gender distribution vary across departments?
SELECT department, gender , COUNT(*) as count
FROM hr
WHERE age > 18
GROUP BY department,gender
ORDER BY department,gender;

-- 6.Find the distribution of employees across various departments?
SELECT department,COUNT(*) AS count
FROM hr
WHERE age> 18
GROUP BY department
ORDER BY count;
-- Most of the employees work in engineering department and Auditing department has least number of employees.

-- 7.Find the top 3 departments with most number of employees?
SELECT department,COUNT(*) AS count
FROM hr
WHERE age> 18
GROUP BY department
ORDER BY count DESC
LIMIT 3;

-- 8.What are the different job roles and their respective count ?
SELECT jobtitle,COUNT(*) AS count
FROM hr
WHERE age>18
GROUP BY jobtitle
ORDER BY jobtitle; 

-- 9.What is the average length of employment of those who have been terminated?
SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365) AS avg_length_of_employment
FROM hr
WHERE termdate != '0000-00-00' AND termdate <= CURDATE() AND age >= 18;

-- 10.How has the company's employee count changed over time based on hire and term dates?
SELECT year, hires, terminations, (hires - terminations) AS net_change, ROUND(((hires - terminations) / hires * 100), 2) AS net_change_percent
FROM (
    SELECT 
        YEAR(hire_date) AS year, 
        COUNT(*) AS hires, 
        SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
    FROM hr
    WHERE age >= 18
    GROUP BY YEAR(hire_date)) subquery
ORDER BY year ASC;

-- 11.What is the distribution of employees across locations by state?
SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;
-- Most employeees are from ohio.

-- Findings
-- Most employees belongs to the age group '30-39'and the age group '50-59' has least employees.
-- Most employees are male.
-- The age of youngest employee is 21 and oldest is 57.
-- A large number of employees work at headquaters(15992) rather than remotely.
-- A large number of employees belong to the state of ohio.
-- The average length of employment for terminated employees is around 8.
-- The net change in employees has increased over years.

-- Limitations
-- Some records had negative ages and these were excluded during querying(967 records). Have only considered employees aged over 18.
-- Some termdates was also need to eliminated (Only those are before current date was considered).
 

    
