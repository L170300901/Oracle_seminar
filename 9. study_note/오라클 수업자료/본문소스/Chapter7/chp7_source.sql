
-- Distinct와 all
SELECT DISTINCT employee_id
  FROM employees;
  

SELECT DISTINCT department_id
  FROM employees;
  
SELECT DISTINCT department_id, employee_id
  FROM employees;
  

SELECT ALL department_id
  FROM employees;
  

-- 집계함수
SELECT COUNT(*)
FROM employees;

SELECT COUNT(*) col1,
       COUNT(employee_id) col2
 FROM  employees;

SELECT COUNT(ALL employee_id)
  FROM employees;

SELECT COUNT( ALL employee_id),
       COUNT( ALL first_name)
  FROM employees;


SELECT COUNT( DISTINCT employee_id),
       COUNT( DISTINCT first_name)
  FROM employees;


SELECT COUNT(department_id),
       COUNT( DISTINCT department_id)
  FROM employees;

-- SUM
SELECT SUM(salary)
  FROM EMPLOYEES;


CREATE TABLE sum_test ( 
    Col1 varchar2(10),
    Col2 number);


INSERT INTO sum_test VALUES('100', 100);
INSERT INTO sum_test VALUES('200', 200);
INSERT INTO sum_test VALUES('300', 300);
INSERT INTO sum_test VALUES('400', 400);


SELECT SUM(col1), 
       SUM(col2)
  FROM sum_test;


SELECT SUM(DISTINCT salary),
       SUM(salary)
  FROM employees;

-- MAX와 MIN
SELECT MAX(salary), MIN(salary)
  FROM employees;


SELECT employee_id, first_name, last_name,
       job_id, salary
  FROM employees
 WHERE salary in ( 24000, 2100 );


SELECT employee_id, first_name, last_name,
       job_id, salary
  FROM employees
 WHERE salary = MAX(salary);


SELECT MAX(salary), 
       MAX(DISTINCT salary),
       MIN(salary),
       MIN(DISTINCT salary)
  FROM employees;

-- AVG
SELECT AVG(salary)
  FROM employees;


SELECT AVG(DISTINCT salary)
  FROM employees;


SELECT AVG(salary) avg1,
       SUM(salary) / COUNT(salary) avg2
  FROM employees;

-- STDDEV와 VARIANCE
SELECT STDDEV(salary),
       VARIANCE(salary)
  FROM employees;


-- GROUP BY 절
SELECT department_id
  FROM employees
 GROUP BY department_id;

SELECT department_id, SUM(salary)
  FROM employees
 GROUP BY department_id;


SELECT department_id, SUM(salary), COUNT(salary), AVG(salary)
  FROM employees
 GROUP BY department_id;


SELECT department_id, job_id,
       SUM(salary), AVG(salary)
  FROM employees
 GROUP BY department_id;


SELECT department_id, job_id,
       SUM(salary), AVG(salary)
  FROM employees
 GROUP BY department_id, job_id;


SELECT department_id, job_id,
       SUM(salary), AVG(salary)
  FROM employees
 GROUP BY department_id, job_id
 ORDER BY department_id, job_id;


SELECT 'ORACEL' company,
       department_id, job_id,
       TO_CHAR( SUM(salary), '999,999') tot_sal,
       TO_CHAR(SUM(salary), '999,999') avg_sal
 FROM employees
 GROUP BY department_id, job_id
 ORDER BY department_id, job_id;

SELECT ROWNUM, department_id, 
       COUNT(*)
  FROM employees
 GROUP BY ROWNUM, department_id
 ORDER BY ROWNUM;


SELECT job_id,
       TO_CHAR(SUM(salary), '999,999') tot_sal,
       TO_CHAR(SUM(salary), '999,999') avg_sal
  FROM employees
 WHERE department_id = 80
 GROUP BY job_id
 ORDER BY job_id;


-- HAVING 절

SELECT department_id,
       COUNT(*)
  FROM EMPLOYEES
 WHERE department_id IS NOT NULL
 GROUP BY department_id
 ORDER BY department_id;


SELECT department_id,
       COUNT(*)
  FROM EMPLOYEES
 WHERE department_id IS NOT NULL]
   AND COUNT(*) <= 5
 GROUP BY department_id
 ORDER BY department_id;


SELECT department_id,
       COUNT(*)
  FROM EMPLOYEES
 WHERE department_id IS NOT NULL
 GROUP BY department_id
HAVING COUNT(*) <= 5
 ORDER BY department_id;


SELECT COUNT(*)
  FROM employees
HAVING COUNT(*) < 10;


SELECT department_id,
       COUNT(*)
  FROM employees
 WHERE department_id IS NOT NULL
 GROUP BY department_id
HAVING department_id > 30;


-- ROLLUP과 CUBE
SELECT c.city, b.department_name, a.job_id,
       COUNT(*) persons, SUM(a.salary) tot_sal        
  FROM employees a,
       departments b,
       locations c
 WHERE a.department_id = b.department_id
   AND b.location_id = c.location_id
 GROUP BY c.city, b.department_name, a.job_id
 ORDER BY c.city, b.department_name, a.job_id;


SELECT c.city, b.department_name, a.job_id,
       COUNT(*) persons, 
       TO_CHAR(SUM(a.salary),'999,999') tot_sal        
  FROM employees a,
       departments b,
       locations c
 WHERE a.department_id = b.department_id
   AND b.location_id = c.location_id
 GROUP BY ROLLUP(c.city, b.department_name, a.job_id)
 ORDER BY c.city, b.department_name, a.job_id;


SELECT c.city, b.department_name, a.job_id,
       COUNT(*) persons, 
       TO_CHAR(SUM(a.salary),'999,999') tot_sal        
  FROM employees a,
       departments b,
       locations c
 WHERE a.department_id = b.department_id
   AND b.location_id = c.location_id
 GROUP BY CUBE(c.city, b.department_name, a.job_id)
 ORDER BY c.city, b.department_name, a.job_id;


SELECT c.city, b.department_name, a.job_id,
       COUNT(*) persons, 
       TO_CHAR(SUM(a.salary),'999,999') tot_sal        
  FROM employees a,
       departments b,
       locations c
 WHERE a.department_id = b.department_id
   AND b.location_id = c.location_id
   AND c.city = '런던'
 GROUP BY CUBE(c.city, b.department_name, a.job_id)
 ORDER BY c.city, b.department_name, a.job_id;

 