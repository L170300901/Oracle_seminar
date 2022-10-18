
-- 옵티마이저
CREATE OR REPLACE VIEW emp_v1 AS
  SELECT * FROM employees
   WHERE department_id = 50;

SELECT * FROM emp_v1
 WHERE salary > 2500;

SELECT *
  FROM employees
 WHERE department_id = 50
   AND salary > 2500;


CREATE OR REPLACE VIEW emp_v2 AS
   SELECT employee_id, first_name, last_name, salary
     FROM employees
    WHERE department_id = 10
    UNION 
   SELECT employee_id, first_name, last_name, salary
     FROM employees
    WHERE department_id = 20;

SELECT employee_id, first_name, last_name
  FROM emp_v2
 WHERE salary > 1000;


SELECT employee_id, first_name, last_name, salary
FROM (
        SELECT employee_id, first_name, last_name, salary
          FROM employees
         WHERE department_id = 10
           AND salary > 1000
         UNION 
        SELECT employee_id, first_name, last_name, salary
          FROM employees
         WHERE department_id = 20
           AND salary > 1000
     );



ANALYZE TABLE employees COMPUTE STATISTICS;

BEGIN
  DBMS_STATS.CREATE_STAT_TABLE ('hr', 'stats1');
  DBMS_STATS.GATHER_TABLE_STATS ('hr', 'employees', stattab => 'stats1');
END;


SELECT *
 FROM stats1;


SHOW PARAMETER OPTIMIZER_FEATURES_ENABLE;


-- 실행계획
SET AUTOTRACE TRACEONLY EXPLAIN;

SELECT a.employee_id, a.first_name, b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id;


SELECT a.employee_id, a.first_name, b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id;


UPDATE employees
    SET department_id = null
WHERE employee_id = 100;

ANALYZE TABLE employees COMPUTE STATISTICS;

SELECT a.employee_id, a.first_name, b.department_name, c.city
  FROM employees a,
       departments b,
       locations c
 WHERE a.department_id = b.department_id
   AND b.location_id = c.location_id;


SELECT a.order_id, a.customer_id, a.order_total, b.line_item_id, b.product_id,
       c.language_id, c.translated_name
  FROM orders a,
       order_items b,
     	 product_descriptions c
 WHERE a.order_id < 2360
   AND a.order_id = b.order_id
   AND b.product_id = c.product_id
 ORDER BY 1, 4;


SELECT DISTINCT language_id
  FROM product_descriptions;

SELECT /*+ USE_MERGE (a, b) */ 
       a.employee_id, a.first_name, b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id;


-- 일반적인 튜닝 기법

SELECT *
  FROM employees
 WHERE first_name = '도날드';


SELECT *
  FROM employees
 WHERE last_name = '오코넬'
   AND first_name = '도날드';


SELECT *
  FROM employees
 WHERE SUBSTR(last_name,1,1) = '오'
   AND first_name = '도날드';


SELECT *
  FROM employees
 WHERE email LIKE 'DOCO%';

SELECT *
  FROM employees
 WHERE SUBSTR(email,1,4) = 'DOCO';

SELECT  *
  FROM employees a, departments b
 WHERE a.department_id = b.department_id
   AND b.department_id IN ( 10, 20, 50) ;


SELECT  *
  FROM employees a
 WHERE EXISTS ( SELECT 1
                  FROM departments b
		             WHERE a.department_id = b.department_id
		               AND b.department_id IN ( 10, 20, 50) );


