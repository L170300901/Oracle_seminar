-- ���� �׷� �Լ�

SELECT department_id, job_id, SUM(salary)
  FROM employees
 WHERE department_id <= 40
 GROUP BY department_id, job_id
 ORDER BY department_id;

SELECT department_id, job_id, SUM(salary)
  FROM employees
 WHERE department_id <= 40
 GROUP BY ROLLUP(department_id, job_id)
 ORDER BY department_id;


SELECT department_id, job_id, SUM(salary)
  FROM employees
 WHERE department_id <= 40
 GROUP BY CUBE(department_id, job_id)
 ORDER BY department_id;


SELECT department_id, 
       DECODE(GROUPING(job_id), 1, '�μ��� �հ�', JOB_ID) JOBS,
       SUM(salary)
  FROM employees
 WHERE department_id <= 40
 GROUP BY ROLLUP(department_id, job_id)
 ORDER BY department_id;


SELECT DECODE(GROUPING(department_id), 1, '��ü�μ�', department_id) DEP, 
       DECODE(GROUPING(job_id), 1, '�հ�', job_id) JOBS, SUM(salary)
  FROM employees
 WHERE department_id <= 40
 GROUP BY CUBE(department_id, job_id)
ORDER BY 1,2;


SELECT DECODE(GROUPING(department_id), 1, '��ü�μ�', department_id) DEP, 
       DECODE(GROUPING(job_id), 1, '�հ�', job_id) JOBS, 
       SUM(salary),
       GROUPING_ID(department_id) g_dep,
       GROUPING_ID(job_id) g_job,
       GROUPING_ID(department_id, job_id) g_total
  FROM employees
 WHERE department_id <= 40
 GROUP BY CUBE(department_id, job_id)
 ORDER BY 1,2;


SELECT DECODE(GROUPING(department_id), 1, '��ü�μ�', department_id) DEP, 
       DECODE(GROUPING(job_id), 1, '�հ�', job_id) JOBS, 
       SUM(salary)
  FROM employees
 WHERE department_id <= 40
 GROUP BY CUBE(department_id, job_id)
HAVING GROUPING_ID(department_id, job_id) > 0
 ORDER BY 1,2;


SELECT ord.order_mode �ֹ����,
       DECODE(cus.marital_status, 'single', '��ȥ', 'married', '��ȥ') ��ȥ����, 
       DECODE(cus.gender, 'F', '����', 'M','����') ����, 
       SUM(ord.order_total) �ֹ��ݾ�
  FROM orders ord,
       customers cus
 WHERE ord.customer_id = cus.customer_id
 GROUP BY ord.order_mode, ROLLUP(ord.order_mode, cus.marital_status, cus.gender);


SELECT ord.order_mode �ֹ����,
       DECODE(cus.marital_status, 'single', '��ȥ', 'married', '��ȥ') ��ȥ����, 
       DECODE(cus.gender, 'F', '����', 'M','����') ����, 
       SUM(ord.order_total) �ֹ��ݾ�, GROUP_ID() GRP
  FROM orders ord,
       customers cus
 WHERE ord.customer_id = cus.customer_id
 GROUP BY ord.order_mode, ROLLUP(ord.order_mode, cus.marital_status, cus.gender);


SELECT ord.order_mode �ֹ����,
       DECODE(cus.marital_status, 'single', '��ȥ', 'married', '��ȥ') ��ȥ����, 
       DECODE(cus.gender, 'F', '����', 'M','����') ����, 
       SUM(ord.order_total) �ֹ��ݾ�
  FROM orders ord,
       customers cus
 WHERE ord.customer_id = cus.customer_id
 GROUP BY ord.order_mode, cus.marital_status, cus.gender;


SELECT ord.order_mode �ֹ����,
       DECODE(cus.marital_status, 'single', '��ȥ', 'married', '��ȥ') ��ȥ����, 
       DECODE(cus.gender, 'F', '����', 'M','����') ����, 
       SUM(ord.order_total) �ֹ��ݾ�
  FROM orders ord,
       customers cus
 WHERE ord.customer_id = cus.customer_id
 GROUP BY GROUPING SETS (ord.order_mode, cus.marital_status, cus.gender);



-- WITH ����

SELECT a.employee_id, a.last_name, a.salary
  FROM ( SELECT employee_id, manager_id, salary, last_name
           FROM employees
		      WHERE department_id = 50 ) a,
	       ( SELECT AVG(salary) avg_salary
	         FROM employees
		      WHERE department_id = 50) b
  WHERE a.salary < b.avg_salary;


WITH a AS ( SELECT employee_id, manager_id, salary, last_name
              FROM employees
		         WHERE department_id = 50 ),
     b AS ( SELECT AVG(salary) avg_salary
	            FROM employees
		         WHERE department_id = 50) 
 SELECT a.employee_id, a.last_name, a.salary
   FROM  a, b
  WHERE a.salary < b.avg_salary;


SELECT department_name, SUM(salary) dept_total
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
 GROUP BY department_name;


SELECT dept_tot.sum_amt / dept_count.cnt �μ����
  FROM ( SELECT SUM(e.salary) sum_amt
           FROM employees e, departments d
          WHERE e.department_id = d.department_id) dept_tot,
       ( SELECT COUNT(*) cnt
           FROM departments d
          WHERE d.department_id IN ( SELECT department_id
                                       FROM employees )) dept_count;


SELECT a.department_name, a.dept_total
  FROM
  ( SELECT department_name, SUM(salary) dept_total  --�μ��� �޿��հ��
      FROM employees e, departments d
     WHERE e.department_id = d.department_id
     GROUP BY department_name ) a,                  
  ( SELECT dept_tot.sum_amt / dept_count.cnt avg_amt  --�μ��� �޿� ��վ�
      FROM ( SELECT SUM(e.salary) sum_amt
               FROM employees e, departments d
              WHERE e.department_id = d.department_id) dept_tot,
           ( SELECT COUNT(*) cnt
               FROM departments d
              WHERE d.department_id IN ( SELECT department_id
                                           FROM employees )) dept_count
  ) b
 WHERE a.dept_total > b.avg_amt;


WITH dept_costs AS ( SELECT department_name, SUM(salary) dept_total
                       FROM employees e, departments d
                      WHERE e.department_id = d.department_id
                      GROUP BY department_name),
     avg_cost AS ( SELECT SUM(dept_total)/COUNT(*) avg
                     FROM dept_costs)
SELECT dept_costs.*
  FROM dept_costs, avg_cost
 WHERE dept_costs.dept_total > avg_cost.avg;



-- MODEL ��

CREATE TABLE model_test (
       row_num INTEGER,
       term VARCHAR2(6),
       salary NUMERIC);


INSERT INTO model_test VALUES (1, '200701', 1000000 );
INSERT INTO model_test VALUES (2, '200702', 1500000 );
INSERT INTO model_test VALUES (3, '200703', 2000000 ); 
INSERT INTO model_test VALUES (4, '200704', 2300000 ); 
INSERT INTO model_test VALUES (5, '200705', 4400000 ); 
INSERT INTO model_test VALUES (6, '200706', 3300000 );

SELECT *
  FROM model_test;


SELECT terms, ori_sal,  taxes
  FROM model_test
  MODEL
  DIMENSION BY ( term terms)
  MEASURES ( salary ori_sal, 
             salary taxes   )
  RULES (
     taxes['200701'] = taxes['200701'] * 0.033,
     taxes['200702'] = taxes['200702'] * 0.033,
     taxes['200703'] = taxes['200703'] * 0.033,
     taxes['200704'] = taxes['200704'] * 0.033,
     taxes['200705'] = taxes['200705'] * 0.033,
     taxes['200706'] = taxes['200706'] * 0.033)	 
ORDER BY 1;


SELECT term, salary, salary * 0.033 taxes
  FROM model_test;


SELECT term, sal
  FROM model_test 
  MODEL
  DIMENSION BY ( term )
  MEASURES ( salary sal )
  RULES (
     sal['QTR1'] = sal['200701'] + sal['200702'] + sal['200703'],
     sal['QTR2'] = sal['200704'] + sal['200705'] + sal['200706'] )      
ORDER BY 1;


SELECT term, sal
  FROM model_test
  MODEL
  DIMENSION BY ( term )
  MEASURES ( salary sal )
  RULES (
     sal['QTR1'] = sal['200701'] + sal['200702'] + sal['200703'],
     sal['QTR2'] = sal['200704'] + sal['200705'] + sal['200706'],
     sal['TOTAL'] =  SUM(sal)[ term BETWEEN '200701' AND '200706'] )      
ORDER BY 1;


CREATE OR REPLACE VIEW order_v  AS
SELECT EXTRACT (year from order_date) years,
       DECODE(order_mode, 'direct', '��������', 'online','�¶���') modes,
	     DECODE(marital_status,'married','��ȥ','single','��ȥ') married,
	     DECODE(gender, 'F','����','M','����') gender,
	     SUM(order_total) order_amt
  FROM orders a,
       customers b
 WHERE a.customer_id = b.customer_id
 GROUP BY EXTRACT (year from order_date), 
          DECODE(order_mode, 'direct', '��������', 'online','�¶���'),
	        DECODE(marital_status,'married','��ȥ','single','��ȥ'),
	        DECODE(gender, 'F','����','M','����');


SELECT *
  FROM order_v
 ORDER BY years;


SELECT years, modes, married, gender, amts
  FROM order_v
 MODEL
 PARTITION BY (modes, married, gender)
 DIMENSION BY ( years )
 MEASURES ( order_amt amts)
 IGNORE NAV
 RULES (
   amts[2001] = amts[2000] + ROUND(amts[2000] / amts[1999], 1)
 )
ORDER BY 1, 2, 3, 4;


SELECT term �Ⱓ, ori_salary ���޿�, tax ����, real_sal �Ǽ��ɾ�
  FROM model_test
 MODEL 
 DIMENSION BY ( term )
 MEASURES ( salary ori_salary,
              salary tax,
	      salary real_sal)
 RULES (
    tax[ ANY ] =  tax[cv(term)] * 0.033,
    real_sal[ ANY ] = real_sal[cv(term)] - (real_sal[cv(term)] * 0.033)
 )
 ORDER BY 1;


SELECT row_num ����, term �Ⱓ, ori_salary ���޿�, tax ����, real_sal �Ǽ��ɾ�
  FROM model_test
 MODEL 
 DIMENSION BY ( row_num )
 MEASURES ( term, 
            salary ori_salary,
            salary tax,
	          salary real_sal)
 RULES (
    tax[ FOR row_num FROM 1 TO 6 INCREMENT 1 ] =  tax[cv(row_num)] * 0.033,
    real_sal[FOR row_num FROM 1 TO 6 INCREMENT 1  ] = 
    real_sal[cv(row_num)] - (real_sal[cv(row_num)] * 0.033)
 )
 ORDER BY 1;


SELECT years, modes, married, gender, amts
  FROM order_v
MODEL
 PARTITION BY (modes, married, gender)
 DIMENSION BY ( years )
 MEASURES ( order_amt amts)
 IGNORE NAV
 RULES (
   amts[2001] = amts[2000] + ROUND(amts[2000] / amts[1999], 1)
 )
ORDER BY 1, 2, 3, 4;


SELECT years, modes, married, gender, amts
  FROM order_v
 MODEL RETURN UPDATED ROWS
 PARTITION BY (modes, married, gender)
 DIMENSION BY ( years )
 MEASURES ( order_amt amts)
 IGNORE NAV
 RULES (
   amts[2001] = PRESENTNNV( amts[2000], 
   amts[2000] + ROUND(amts[2000] / amts[1999], 1),
  amts[1999])
 )
ORDER BY 1, 2, 3, 4;

SELECT *
  FROM order_v
WHERE years = 1990;


UPDATE orders
   SET order_total = NULL
 WHERE TO_CHAR(order_date, 'YYYY') = '1990'
   AND customer_id IN ( SELECT customer_id
                          FROM customers
                         WHERE gender = 'F');
                         
SELECT years, modes, married, gender, presentnnvs, presentvs
  FROM order_v
MODEL RETURN UPDATED ROWS
 PARTITION BY (modes, married, gender)
 DIMENSION BY ( years )
 MEASURES ( order_amt presentnnvs,
order_amt presentvs)
 IGNORE NAV
 RULES (  presentnnvs[2001] = PRESENTNNV( presentnnvs[1990], 1, 0),
          presentvs[2001] = PRESENTV (presentnnvs[1990], 1, 0)
         )
ORDER BY 1, 2, 3, 4;
                         
                         
SELECT x, s FROM DUAL
MODEL
DIMENSION BY (1 AS x) 
MEASURES ( 2 AS s)
RULES UPDATE ITERATE (4)
  (s[1] = s[1]*2);


SELECT x, s, T FROM DUAL
MODEL
DIMENSION BY (1 AS x) 
MEASURES ( 2 AS s, 1 AS t)
RULES UPDATE ITERATE (4)
 ( s[1] = s[1]*2, 
   t[1] = ITERATION_NUMBER );


SELECT x, s, T FROM DUAL
MODEL
DIMENSION BY (1 AS x) 
MEASURES ( 2 AS s, 1 AS t)
RULES UPDATE ITERATE (1000) UNTIL ( PREVIOUS(S[1]) > 100)
 ( s[1] = s[1]*2, 
   t[1] = ITERATION_NUMBER + 1 );


-- ���� ����

SELECT *
  FROM order_v
 WHERE years = :year;


DECLARE
   state1 VARCHAR2(100);
BEGIN
   EXECUTE IMMEDIATE 'CREATE TABLE dynamic1 ( id integer, value varchar2(50))';
   
   state1 := 'CREATE TABLE dynamic2 ( id integer, value varchar2(50))';
   EXECUTE IMMEDIATE state1;   
END;


SELECT *
  FROM dynamic1;


SELECT *
  FROM dynamic2;


DECLARE
   state1 VARCHAR2(100);
BEGIN
   EXECUTE IMMEDIATE 'INSERT INTO dynamic1 VALUES (1, ' || '''A''' || ')';
   EXECUTE IMMEDIATE 'INSERT INTO dynamic1 VALUES (2, ' || '''B''' || ')';   

END;


DECLARE
   v_int INTEGER;
   v_value varchar2(50);
   stmt1 varchar2(100);
BEGIN
    v_int := 3;
    v_value := 'C';
    stmt1 := 'INSERT INTO dynamic1 VALUES (:1, :2)';
    EXECUTE IMMEDIATE stmt1 USING v_int, v_value;
END;

SELECT *
  FROM dynamic1;


CREATE OR REPLACE PROCEDURE delete_tables (
                 table_name VARCHAR2,
                 conditions VARCHAR2 ) AS
  where_clause VARCHAR2(500);
BEGIN
  IF conditions IS NULL THEN
     where_clause := ' ';
  ELSE
     where_clause := ' WHERE ' || conditions;
  END IF;

  EXECUTE IMMEDIATE ' DELETE ' || table_name || where_clause;

  COMMIT;

EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE( table_name || ' delete is failed!');

END;


EXECUTE DELETE_TABLES ('DYNAMIC1', ' ID IN ( 2, 3) ');

SELECT *
  FROM dynamic1;


DECLARE
   cur1 NUMBER;
   v_int INTEGER;
   return_value INTEGER;
   v_value varchar2(50);
   stmt1 varchar2(100);
BEGIN
    v_int := 3;
    v_value := 'C';
    stmt1 := 'INSERT INTO dynamic2 VALUES (:1, :2)';
   
    -- Ŀ���� ����
    cur1 := DBMS_SQL.OPEN_CURSOR;
    
    -- �Ľ��� �Ѵ�
    DBMS_SQL.PARSE ( cur1, stmt1, DBMS_SQL.NATIVE);
    
    -- ���ε� ������ ���� ���� �����Ѵ�. 
    DBMS_SQL.BIND_VARIABLE ( cur1, ':1', v_int);
    DBMS_SQL.BIND_VARIABLE ( cur1, ':2', v_value);
    -- ������ �����Ѵ�.
    return_value  := DBMS_SQL.EXECUTE ( cur1);
    -- Ŀ���� �ݴ´�.
    DBMS_SQL.CLOSE_CURSOR(cur1);

END;


SELECT *
  FROM dynamic2;


-- MERGE

CREATE TABLE merge_test ( employee_id NUMBER, 
                          names VARCHAR2(80),
                          sal NUMBER);

INSERT INTO merge_test 
SELECT employee_id, first_name || ' ' || last_name, salary
  FROM employees
 WHERE department_id <= 30;

SELECT *
  FROM merge_test;

MERGE INTO merge_test d
USING ( SELECT *  FROM employees 
         WHERE department_id <= 50 ) s
ON ( d.employee_id = s.employee_id )
WHEN MATCHED THEN UPDATE SET d.sal = 9000
WHEN NOT MATCHED THEN INSERT ( employee_id, names, sal )
                      VALUES ( s.employee_id, s.first_name || ' ' || s.last_name, s.salary )
                      WHERE s.department_id < 50;

SELECT *
  FROM merge_test;

