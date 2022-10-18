-- ��������(SubQuery)��?
SELECT ROUND(AVG(salary))
  FROM employees;

SELECT employee_id, first_name, last_name
  FROM employees
 WHERE salary < 6462;

SELECT employee_id, first_name, last_name
  FROM employees
 WHERE salary <  ( SELECT ROUND(AVG(salary))
                     FROM employees );

-- ������ ���� ��������
SELECT *
  FROM departments
 WHERE location_id IN ( SELECT location_id
                           FROM locations
                          WHERE state_province IS NULL );

SELECT *
  FROM departments
 WHERE location_id IN ( 1000, 1100, 1300, 2000, 2300, 2400);


SELECT employee_id, first_name, last_name
  FROM employees
 WHERE salary <  ( SELECT ROUND(AVG(salary))
                     FROM employees );

-- ���� �ο�, ���� �÷��� ��ȯ
SELECT a.first_name, a.last_name, b.job_title
  FROM employees a, jobs b
 WHERE a.salary = ( SELECT MAX(salary)
                      FROM employees )
   AND a.job_id = b.job_id;


SELECT a.first_name, a.last_name, b.job_title
  FROM employees a, jobs b
 WHERE a.salary = ( SELECT MIN(salary)
                     FROM employees)
   AND a.job_id = b.job_id;


SELECT a.first_name, a.last_name, b.job_title
  FROM employees a, jobs b
 WHERE a.salary = ( SELECT AVG(emp.salary)
                      FROM employees emp, 
                           departments dep,
                           locations loc
                     WHERE emp.department_id = dep.department_id
                       AND dep.location_id = loc.location_id
                       AND loc.country_id = 'US' )
   AND a.job_id = b.job_id;

-- ���� �ο�, ���� �÷��� ��ȯ
SELECT dep.department_name
  FROM departments dep, locations loc
 WHERE dep.location_id = loc.location_id
   AND loc.country_id = 'US';


SELECT department_name
  FROM departments
 WHERE location_id IN ( SELECT location_id
                          FROM locations
                         WHERE country_id = 'US');


SELECT salary
  FROM employees
 WHERE department_id = 30;


SELECT employee_id, department_id, salary
  FROM employees
 WHERE salary > ANY ( SELECT salary
                        FROM employees
                       WHERE department_id = 30);


SELECT employee_id, salary
  FROM employees
 WHERE salary > ( SELECT MIN(salary)
                    FROM employees
                   WHERE department_id = 30);


SELECT employee_id, department_id, salary
  FROM employees
 WHERE salary > ALL ( SELECT salary
                        FROM employees
                       WHERE department_id = 30);


SELECT employee_id, department_id, salary
  FROM employees
 WHERE salary >  ( SELECT MAX(salary)
                     FROM employees
                    WHERE department_id = 30);

SELECT employee_id, department_id, salary
  FROM employees
 WHERE salary = ANY ( SELECT salary
                        FROM employees
                       WHERE department_id = 30);


SELECT employee_id, department_id, salary
  FROM employees
 WHERE salary IN ( SELECT salary
                     FROM employees
                    WHERE department_id = 30);


SELECT department_id
  FROM departments
 WHERE department_id NOT IN ( 10,20);


SELECT department_id
  FROM departments
 WHERE department_id <> ANY ( 10,20 );


SELECT department_id
  FROM departments
 WHERE department_id = ALL ( SELECT department_id
                               FROM departments
                              WHERE department_id IN (10, 20));


SELECT department_id
  FROM departments
 WHERE department_id = ALL ( 10,20 );


SELECT department_id
  FROM departments
 WHERE department_id = ALL ( SELECT department_id
                               FROM departments
                              WHERE department_id = 10);


SELECT department_id
  FROM departments
 WHERE department_id = ALL (10);


UPDATE employees
    SET salary = ( SELECT salary
                    FROM employees
                   WHERE department_id = 10 );


UPDATE employees
   SET salary = ( SELECT salary
                    FROM employees
                   WHERE department_id IN (10,20) );
                   
UPDATE employees
   SET salary = ( SELECT salary
                    FROM employees
                   WHERE department_id = 10) 
 WHERE department_id IN ( SELECT department_id
                            FROM departments
                           WHERE manager_id IS NOT NULL );

DELETE countries
 WHERE country_id NOT IN ( SELECT country_id
                             FROM locations);
                   

-- ���� �÷��� ��ȯ

SELECT department_id, department_name
  FROM departments
 WHERE ( department_id, manager_id ) IN ( SELECT department_id, employee_id
                                            FROM employees
                                           WHERE manager_id IS NULL );


CREATE TABLE month_salary (
     magam_date      DATE NOT NULL,       /* ������   */
     department_id   NUMBER,              /* �μ���ȣ */
     emp_count       NUMBER,              /* �����   */
     total_salary    NUMBER(9,2),         /* �޿��Ѿ� */
     average_salary  NUMBER(9,2)          /* �޿���� */
);


INSERT INTO month_salary ( magam_date, department_id)
SELECT LAST_DAY(SYSDATE),
       department_id
  FROM employees
 GROUP BY department_id;


SELECT magam_date, department_id
  FROM month_salary;


UPDATE month_salary a
   SET a.emp_count = ( SELECT COUNT(*)
                         FROM employees k
                        WHERE k.department_id = a.department_id
                         GROUP BY k.department_id),
       a.total_salary = ( SELECT SUM(k.salary)
                            FROM employees k
                           WHERE k.department_id = a.department_id
                           GROUP BY k.department_id),
       a.average_salary = ( SELECT ROUND(SUM(k.salary))
                              FROM employees k
                             WHERE k.department_id = a.department_id
                             GROUP BY k.department_id);


UPDATE month_salary a
   SET ( a.emp_count, a.total_salary, a.average_salary )  = 
                ( SELECT COUNT(*), SUM(k.salary), ROUND(SUM(k.salary))
                    FROM employees k
                   WHERE k.department_id = a.department_id
                   GROUP BY k.department_id);


SELECT *
 FROM month_salary;

-- ������ �ִ� ��������

SELECT count(*)
  FROM employees
 WHERE department_id IN ( SELECT department_id
                            FROM departments
                           WHERE manager_id IS NOT NULL);


SELECT count(*)
  FROM employees emp
 WHERE EXISTS ( SELECT 1
                  FROM departments dep
                 WHERE dep.manager_id IS NOT NULL
                   AND emp.department_id = dep.department_id);


 SELECT emp.first_name || ' ' || emp.last_name emp_names,
        emp.department_id,
	      dep.department_name
   FROM employees emp, departments dep
  WHERE emp.department_id = dep.department_id;


 SELECT emp.first_name || ' ' || emp.last_name emp_names,
        emp.department_id,
	     ( SELECT dep.department_name 
           FROM departments dep 
          WHERE dep.department_id = emp.department_id) dep_name
   FROM employees emp;


DELETE month_salary a
 WHERE EXISTS ( SELECT 1
                  FROM employees emp
                 WHERE emp.department_id = a.department_id
                 GROUP BY emp.department_id
                HAVING COUNT(*) = a.emp_count
                   AND SUM(emp.salary) = 51600 );


SELECT *
  FROM month_salary;

-- �ζ��� ��
SELECT a.employee_id, a.first_name || ' ' || a.last_name names, a.salary
  FROM employees a  
 WHERE a.salary >= ( SELECT AVG(salary) 
                       FROM employees )
   AND a.salary <= ( SELECT MAX(salary) 
                       FROM employees )   
 ORDER BY a.salary DESC;


SELECT a.employee_id, a.first_name || ' ' || a.last_name names, a.salary,
       ROUND(b.avgs), b.maxs
  FROM employees a, 
       ( SELECT AVG(salary) avgs, 
                MAX(salary) maxs
	         FROM employees ) b
 WHERE a.salary BETWEEN b.avgs AND b.maxs
 ORDER BY a.salary DESC;


SELECT DECODE(TO_CHAR(hire_date,'mm'), '01', COUNT(*), 0) "1��",
       DECODE(TO_CHAR(hire_date,'mm'), '02', COUNT(*), 0) "2��",
       DECODE(TO_CHAR(hire_date,'mm'), '03', COUNT(*), 0) "3��",
       DECODE(TO_CHAR(hire_date,'mm'), '04', COUNT(*), 0) "4��",
       DECODE(TO_CHAR(hire_date,'mm'), '05', COUNT(*), 0) "5��",
       DECODE(TO_CHAR(hire_date,'mm'), '06', COUNT(*), 0) "6��",
       DECODE(TO_CHAR(hire_date,'mm'), '07', COUNT(*), 0) "7��",
       DECODE(TO_CHAR(hire_date,'mm'), '08', COUNT(*), 0) "8��",
       DECODE(TO_CHAR(hire_date,'mm'), '09', COUNT(*), 0) "9��",
       DECODE(TO_CHAR(hire_date,'mm'), '10', COUNT(*), 0) "10��",
       DECODE(TO_CHAR(hire_date,'mm'), '11', COUNT(*), 0) "11��",
       DECODE(TO_CHAR(hire_date,'mm'), '12', COUNT(*), 0) "12��"
FROM employees
GROUP BY TO_CHAR(hire_date,'mm')
ORDER BY TO_CHAR(hire_date,'mm');


SELECT SUM(m1) "1��", SUM(m2) "2��", SUM(m3) "3��", 
       SUM(m4) "4��", SUM(m5) "5��", SUM(m6) "6��",
       SUM(m7) "7��", SUM(m8) "8��", SUM(m9) "9��", 
       SUM(m10) "10��", SUM(m11) "11��", SUM(m12) "12��"
FROM (
      SELECT DECODE(TO_CHAR(hire_date,'mm'), '01', COUNT(*), 0) m1,
             DECODE(TO_CHAR(hire_date,'mm'), '02', COUNT(*), 0) m2,
             DECODE(TO_CHAR(hire_date,'mm'), '03', COUNT(*), 0) m3,
             DECODE(TO_CHAR(hire_date,'mm'), '04', COUNT(*), 0) m4,
             DECODE(TO_CHAR(hire_date,'mm'), '05', COUNT(*), 0) m5,
             DECODE(TO_CHAR(hire_date,'mm'), '06', COUNT(*), 0) m6,
             DECODE(TO_CHAR(hire_date,'mm'), '07', COUNT(*), 0) m7,
             DECODE(TO_CHAR(hire_date,'mm'), '08', COUNT(*), 0) m8,
             DECODE(TO_CHAR(hire_date,'mm'), '09', COUNT(*), 0) m9,
             DECODE(TO_CHAR(hire_date,'mm'), '10', COUNT(*), 0) m10,
             DECODE(TO_CHAR(hire_date,'mm'), '11', COUNT(*), 0) m11,
             DECODE(TO_CHAR(hire_date,'mm'), '12', COUNT(*), 0) m12
        FROM employees
       GROUP BY TO_CHAR(hire_date,'mm')
);

SELECT employee_id, first_name, last_name, salary
  FROM employees
 ORDER BY salary DESC;


SELECT employee_id, first_name, last_name, salary
  FROM employees
 WHERE ROWNUM < 11
 ORDER BY salary DESC;


SELECT *
  FROM ( SELECT employee_id, first_name, last_name, salary
           FROM employees
          ORDER BY salary DESC )
 WHERE ROWNUM < 11;


SELECT *
  FROM ( SELECT employee_id, first_name, last_name, salary
           FROM employees
          ORDER BY salary ASC )
 WHERE ROWNUM < 11;


