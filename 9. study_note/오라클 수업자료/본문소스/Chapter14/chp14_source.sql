-- 분석 함수의 사용
SELECT TO_CHAR(order_date, 'YYYY') YEARS, SUM(order_total)
  FROM orders
 GROUP BY TO_CHAR(order_date, 'YYYY');


SELECT TO_CHAR(order_date, 'YYYY') YEARS, customer_id, SUM(order_total)
  FROM orders
 GROUP BY TO_CHAR(order_date, 'YYYY'), customer_id
 ORDER BY TO_CHAR(order_date, 'YYYY'), customer_id;


SELECT cust.ord_year, cust.customer_id,  cust.cus_amt
  FROM ( SELECT to_char(order_date, 'YYYY') ord_year, customer_id, 
                sum(order_total) cus_amt
           FROM orders
          GROUP BY to_char(order_date, 'YYYY'), customer_id ) cust,
       ( SELECT to_char(order_date, 'YYYY') sale_year, SUM(order_total) tot_amt
           FROM orders 
          GROUP BY to_char(order_date, 'YYYY')) ords
 WHERE cust.ord_year = ords.sale_year
   AND cust.cus_amt > ( ords.tot_amt * 0.2)
 ORDER BY cust.ord_year;


SELECT cust.years, cust.customer_id, cust.sub_amt
  FROM ( SELECT TO_CHAR(order_date,'YYYY') years, customer_id, sum(order_total) sub_amt,
                SUM(SUM(order_total)) OVER ( PARTITION BY to_char(order_date,'YYYY') )  total_amt
           FROM orders 
          GROUP BY TO_CHAR(order_date,'YYYY'), customer_id ) cust
 WHERE cust.sub_amt > cust.total_amt * 0.2;


SELECT department_id, last_name names, salary,
       SUM(salary) OVER ( PARTITION BY department_id ORDER BY last_name ) cumm_sal
  FROM employees;


-- 순위함수

SELECT employee_id, salary, 
       RANK() OVER (ORDER BY salary DESC) salary_ranking
  FROM employees;


SELECT employee_id, salary, 
       RANK() OVER (ORDER BY salary DESC) ranking1,
       DENSE_RANK() OVER (ORDER BY salary DESC) ranking2
  FROM employees;


SELECT employee_id, salary, 
       RANK() OVER (ORDER BY salary DESC) ranking1,
       DENSE_RANK() OVER (ORDER BY salary DESC) ranking2,
       ROW_NUMBER() OVER (ORDER BY salary DESC) ranking3
  FROM employees;


SELECT *
  FROM ( SELECT employee_id, first_name, last_name, salary
           FROM employees
          ORDER BY salary DESC )
 WHERE ROWNUM < 11;


SELECT employee_id, salary, 
       ROW_NUMBER() OVER (ORDER BY salary DESC) ranking
  FROM employees
 WHERE ROW_NUMBER() OVER (ORDER BY salary DESC) < 11;


SELECT employee_id, salary, 
       ROW_NUMBER() OVER (ORDER BY salary DESC) ranking
  FROM employees
 WHERE ROWNUM < 11;


SELECT t.*
  FROM ( SELECT department_id , last_name, 
                ROW_NUMBER() OVER ( PARTITION BY department_id
                                           ORDER BY salary DESC ) sal
           FROM employees) t
 WHERE t.sal <= 3;


SELECT department_id, MAX(salary)
  FROM employees
 GROUP BY department_id
 ORDER BY department_id;


SELECT department_id, MIN(salary)
  FROM employees
 GROUP BY department_id
 ORDER BY department_id;


SELECT emp1.department_id, emp1.employee_id || ' ' ||emp1.last_name max_sawon, 
       emp1.salary,
       emp2.employee_id || ' ' || emp2.last_name min_sawon, emp2.salary
  FROM employees emp1, employees emp2,
      ( SELECT department_id, MAX(salary) max_sal
          FROM employees
         GROUP BY department_id ) max_dep, -- 최대급여를 받는 사원명단
      ( SELECT department_id, MIN(salary) min_sal
          FROM employees
         GROUP BY department_id ) min_dep  -- 최소급여를 받는 사원명단
 WHERE emp1.department_id = max_dep.department_id
   AND emp1.salary = max_dep.max_sal
   AND emp2.department_id = min_dep.department_id
   AND emp2.salary = min_dep.min_sal
   AND emp1.department_id = emp2.department_id
 ORDER BY emp1.department_id;


SELECT department_id, 
       MAX(employee_id || ' ' || last_name ) KEEP ( DENSE_RANK FIRST ORDER BY salary DESC) 최대급여,
       MAX(salary) 최대값,
       MIN(employee_id || ' ' || last_name) KEEP ( DENSE_RANK LAST ORDER BY salary DESC) 최소급여,
       MIN(salary) 최소값
  FROM employees
 GROUP BY department_id;


SELECT department_id, 
       MAX(employee_id || ' ' || last_name) KEEP ( DENSE_RANK LAST ORDER BY salary DESC) max_sawon,
       MIN(employee_id || ' ' || last_name) KEEP ( DENSE_RANK LAST ORDER BY salary DESC) min_sawon,
       MIN(salary)
  FROM employees
 WHERE department_id = 90
 GROUP BY department_id;


SELECT customer_id,
       NTILE(5) OVER ( ORDER BY SUM(order_total) desc) rank,
	     SUM(order_total)
  FROM orders
 WHERE TO_CHAR(order_date, 'YYYY') = '1999'
 GROUP BY customer_id;


SELECT SUM(b.total) "상위20",  
       MAX(a.tot_amt) "전체",
       ROUND(SUM(b.total) / MAX(a.tot_amt),3) "비율"
  FROM ( SELECT SUM(order_total) tot_amt
           FROM orders
          WHERE TO_CHAR(order_date, 'YYYY') = '1999') a, -- 99년도 전체 매출액
       ( SELECT customer_id,
                NTILE(5) OVER ( ORDER BY SUM(order_total) desc) rank,
	              SUM(order_total) total
           FROM orders
          WHERE TO_CHAR(order_date, 'YYYY') = '1999'
          GROUP BY customer_id) B --고객별 매출 순위
 WHERE  b.rank = 1


CREATE TABLE stat_test (
         t_value NUMBER );


INSERT INTO stat_test VALUES(10);
INSERT INTO stat_test VALUES(35);
INSERT INTO stat_test VALUES(26);
INSERT INTO stat_test VALUES(55);
INSERT INTO stat_test VALUES(49);
INSERT INTO stat_test VALUES(75);
INSERT INTO stat_test VALUES(9);
INSERT INTO stat_test VALUES(29);
INSERT INTO stat_test VALUES(44);
INSERT INTO stat_test VALUES(99);


SELECT *
  FROM stat_test
 ORDER BY t_value;


SELECT t_value,
       WIDTH_BUCKET(t_value, 1, 100, 4) width
  FROM stat_test
 ORDER BY width;


SELECT t_value,
       WIDTH_BUCKET(t_value, 1, 100, 4) width,
       NTILE(4) OVER (ORDER BY t_value) tile
  FROM stat_test
 ORDER BY t_value;



SELECT t_value,
       WIDTH_BUCKET(t_value, 10, 90, 4) width,
       NTILE(4) OVER (ORDER BY t_value) tile
  FROM stat_test
 ORDER BY t_value;


SELECT salary, 
       DENSE_RANK() OVER ( PARTITION BY department_id ORDER BY salary) dense,
       ROUND(CUME_DIST() OVER ( PARTITION BY department_id ORDER BY salary),3) cum,
       ROUND(PERCENT_RANK() OVER ( PARTITION BY department_id ORDER BY salary),3) per
  FROM employees
 WHERE department_id = 60
 ORDER BY  department_id;


--윈도우 함수(Windowing Function)

SELECT employee_id, salary,
       SUM(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
	                        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) w1,
       SUM(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
	                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) w2,
       SUM(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
	                        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) w3 
  FROM employees
 WHERE department_id = 60;


SELECT employee_id, salary,
       SUM(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
	                        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) w1,
       SUM(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
	                        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) w2,
       SUM(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
	                        ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) w3						  						    
  FROM employees
 WHERE department_id = 60;


SELECT employee_id, salary,
       FIRST_VALUE(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
	                                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) wf1,
       LAST_VALUE(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
                                 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) wl1,
       FIRST_VALUE(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
	                                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) wf2,
       LAST_VALUE(salary) OVER ( PARTITION BY department_id ORDER BY employee_id
                                 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) wl2	
  FROM employees
 WHERE department_id = 60;


-- 기타 분석 함수들
SELECT TO_CHAR(hire_date, 'YYYY') 입사년도,
       COUNT(*) 사원수
  FROM employees
 GROUP BY TO_CHAR(hire_date, 'YYYY')
 ORDER BY TO_CHAR(hire_date, 'YYYY');


SELECT a.ipsa 입사년도, a.sawon 사원수, b.pre_sawon 이전년도사원수
 FROM ( SELECT TO_CHAR(hire_date, 'YYYY') ipsa,
               COUNT(*) sawon
          FROM employees
         GROUP BY TO_CHAR(hire_date, 'YYYY')) a, -- 년도별 사원 수
	    ( SELECT TO_CHAR(hire_date, 'YYYY') pre_ipsa,
               COUNT(*) pre_sawon
          FROM employees
         GROUP BY TO_CHAR(hire_date, 'YYYY')) b -- 이전년도를 구하기 위한 사원 수
 WHERE a.ipsa = b.pre_ipsa(+) + 1
 ORDER BY a.ipsa;


SELECT TO_CHAR(hire_date, 'YYYY') 입사년도,
       COUNT(*) 사원수,
       LAG(COUNT(*)) OVER ( ORDER BY TO_CHAR(hire_date, 'YYYY')) 이전년도사원수
  FROM employees
 GROUP BY TO_CHAR(hire_date, 'YYYY')
 ORDER BY TO_CHAR(hire_date, 'YYYY');


SELECT TO_CHAR(hire_date, 'YYYY') 입사년도,
       COUNT(*) 사원수,
       LAG(COUNT(*), 1, 0) OVER ( ORDER BY TO_CHAR(hire_date, 'YYYY')) 이전년도사원수,
       LEAD(COUNT(*), 1, 0) OVER ( ORDER BY TO_CHAR(hire_date, 'YYYY')) 이후년도사원수
  FROM employees
 GROUP BY TO_CHAR(hire_date, 'YYYY')
 ORDER BY TO_CHAR(hire_date, 'YYYY');


SELECT emp.last_name 이름, SUM(ord.order_total) 개인별실적
  FROM orders ord,
       employees emp
 WHERE TO_CHAR(ord.order_date, 'YYYY') = '1999'
   AND ord.sales_rep_id = emp.employee_id
 GROUP BY  emp.last_name
 ORDER BY  emp.last_name;


SELECT emp.last_name 이름, SUM(ord.order_total) 개인별실적,
       ROUND(SUM(ord.order_total) / SUM(SUM(ord.order_total)) OVER ( PARTITION BY TO_CHAR(ord.order_date, 'YYYY')),2) 개인별비율
  FROM orders ord,
       employees emp
 WHERE TO_CHAR(ord.order_date, 'YYYY') = '1999'
   AND ord.sales_rep_id = emp.employee_id
 GROUP BY  emp.last_name, TO_CHAR(ord.order_date, 'YYYY')
 ORDER BY  emp.last_name;


SELECT emp.last_name 이름, SUM(ord.order_total) 개인별실적,
       ROUND(RATIO_TO_REPORT(SUM(ord.order_total)) OVER ( PARTITION BY  TO_CHAR(ord.order_date, 'YYYY')),2) RATIO
  FROM orders ord,
       employees emp
 WHERE TO_CHAR(ord.order_date, 'YYYY') = '1999'
   AND ord.sales_rep_id = emp.employee_id
 GROUP BY  emp.last_name, TO_CHAR(ord.order_date, 'YYYY')
 ORDER BY  emp.last_name;





