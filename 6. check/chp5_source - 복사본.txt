-- WHERE 절

-- 연산자 
SELECT *
   FROM employees
 WHERE employee_id = 101;


SELECT first_name || last_name full_name
FROM employees
WHERE employee_id = 101;

SELECT first_name || last_name AS full_name 
FROM employees
WHERE employee_id = 101;

SELECT first_name || last_name  "full name"
FROM employees
WHERE employee_id = 101;

-- AND , OR , NOT

SELECT first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE department_id = 30
   AND salary < 10000;
   

SELECT first_name || ' ' || last_name  성명, 
       Salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE department_id = 30
   AND salary < 10000
   AND hire_date < '1996-01-01';


SELECT first_name || ' ' || last_name  성명, 
       Salary 월급, 
       department_id 부서번호
FROM employees
WHERE department_id = 30
   OR department_id = 60;


SELECT first_name || ' '  || last_name  성명, 
       Salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE department_id = 30 
   AND salary < 10000 
    OR department_id = 60
   AND salary > 5000;
   
   
SELECT first_name || ' ' || last_name  성명, 
       Salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE ( department_id = 30 AND salary < 10000 )
    OR ( department_id = 60  AND salary > 5000 ) ;
   
-- 범위조건 
SELECT employee_id 사원번호, 
       first_name || ' ' || last_name  성명, 
       Salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE employee_id BETWEEN 110 AND 120;


SELECT employee_id 사원번호,
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE employee_id >= 110 
   AND employee_id  <= 120;


SELECT employee_id 사원번호, 
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE employee_id >= 110 
   AND employee_id  <= 120
   AND salary BETWEEN 5000 AND 10000;


SELECT employee_id 사원번호, 
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE employee_id BETWEEN 110 AND 120
   AND salary BETWEEN 5000 AND 10000;



SELECT employee_id 사원번호, 
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE employee_id < 110 
   AND employee_id > 120;


SELECT employee_id 사원번호, 
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE employee_id < 110 
    OR employee_id > 120;


SELECT employee_id 사원번호, 
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id 부서번호
  FROM employees
 WHERE NOT employee_id BETWEEN 110 AND 120;


SELECT employee_id 사원번호, 
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       hire_date 입사일자
  FROM employees
 WHERE hire_date BETWEEN '1995-01-01' AND '1999-12-31';


SELECT employee_id 사원번호, 
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       hire_date 입사일자
  FROM employees
 WHERE hire_date BETWEEN TO_DATE('1995-01-01') 
                     AND TO_DATE('1999-12-31');


-- IN 

SELECT employee_id 사원번호,
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id  부서코드
  FROM employees
  WHERE department_id = 30
     OR department_id = 60
     OR department_id = 90;


SELECT employee_id 사원번호,
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id  부서코드
  FROM employees
 WHERE department_id IN (30, 60, 90);


SELECT employee_id 사원번호,
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id  부서코드
 FROM employees
WHERE department_id NOT IN (30, 60, 90);


SELECT employee_id 사원번호,
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id  부서코드
 FROM employees
WHERE department_id NOT IN 
             ( SELECT department_id
                 FROM departments
                WHERE department_id IN (30, 60, 90) );

-- EXISTS

SELECT emp.employee_id 사원번호,
       emp.first_name || ' ' || last_name  성명, 
       emp.salary 월급, 
       emp.department_id  부서코드
  FROM employees emp
 WHERE EXISTS
      ( SELECT dep.department_id 
          FROM departments dep
         WHERE dep.department_id IN (30, 60, 90)
           AND emp.department_id = dep.department_id );



SELECT emp.employee_id 사원번호,
       emp.first_name || ' ' || last_name  성명, 
       emp.salary 월급, 
       emp.department_id  부서코드
  FROM employees emp
 WHERE EXISTS
      ( SELECT 1 
          FROM departments dep
         WHERE dep.department_id IN (30, 60, 90)
           AND emp.department_id = dep.department_id );


SELECT emp.employee_id 사원번호,
       emp.first_name || ' ' || last_name  성명, 
       emp.salary 월급, 
       emp.department_id  부서코드
  FROM employees emp
 WHERE NOT EXISTS
      ( SELECT dep.department_id 
          FROM departments dep
         WHERE dep.department_id IN (30, 60, 90)
           AND emp.department_id = dep.department_id ) ;

-- LIKE

SELECT employee_id 사원번호,
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       department_id  부서코드
 FROM employees
WHERE phone_number LIKE '515%';


SELECT employee_id 사원번호,
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       phone_number  전화번호
 FROM employees
WHERE phone_number LIKE '%123%';


SELECT employee_id 사원번호,
       first_name || ' ' || last_name  성명, 
       salary 월급, 
       phone_number  전화번호
 FROM employees
WHERE phone_number NOT LIKE '515%';


SELECT employee_id 사원번호,
       first_name || ' ' || last_name  성명, 
       email  이메일계정, 
       phone_number  전화번호
 FROM employees
WHERE email LIKE '%S_I%';

-- NULL 처리

SELECT location_id, street_address, city, state_province
  FROM locations
WHERE state_province LIKE '%';


SELECT location_id, street_address, city, state_province
  FROM locations ;


UPDATE locations
   SET state_province = ' '
 WHERE location_id = 1000;


SELECT location_id, street_address, city, state_province
  FROM locations
 WHERE state_province LIKE '%';


SELECT location_id, street_address, city, state_province
  FROM locations
 WHERE state_province IS NULL;


SELECT location_id, street_address, city, state_province
  FROM locations
 WHERE state_province  IS NOT NULL;


SELECT COUNT(*)
  FROM locations
 WHERE state_province IS NULL; 


SELECT COUNT(*)
  FROM locations
 WHERE state_province IS NOT NULL;


SELECT COUNT(*)
  FROM locations
 WHERE state_province = NULL;


SELECT COUNT(*)
  FROM locations
 WHERE state_province != NULL;


-- 조인
SELECT first_name, last_name, email, phone_number, hire_date,
       salary, job_id, department_id
  FROM employees;

SELECT employees.first_name, employees.last_name, employees.email, 
       departments.department_name
  FROM employees, departments
 WHERE employees.department_id = departments.department_id;


SELECT employees.first_name, employees.last_name, employees.email, 
       departments.department_name, 
       department_id
  FROM employees, departments
 WHERE employees.department_id = departments.department_id;


SELECT emp.first_name, emp.last_name, emp.email, 
       dep.department_id, dep.department_name
  FROM employees emp, departments dep
 WHERE emp.department_id = dep.department_id;


SELECT emp.first_name, emp.last_name, emp.email, 
       emp.department_id, dep.department_name,
       emp.job_id, job.job_title
  FROM employees emp, 
       departments dep,
       jobs job
 WHERE emp.department_id = dep.department_id
   AND emp.job_id        = job.job_id; 


-- 내부조인
-- 두 개 이상의 테이블 조인

SELECT emp.first_name, emp.last_name, emp.email, 
       emp.department_id, dep.department_name,
       emp.job_id, job.job_title
  FROM employees emp, 
       departments dep,
       jobs job
 WHERE emp.department_id = dep.department_id
   AND emp.job_id        = job.job_id; 


SELECT emp.first_name, emp.last_name, emp.email, 
       emp.department_id, dep.department_name,
       emp.job_id, job.job_title,
       loc.city
  FROM employees emp, 
       departments dep,
       jobs job, 
       locations loc
 WHERE emp.department_id = dep.department_id
   AND emp.job_id        = job.job_id
   AND dep.location_id   = loc.location_id;

-- 일반조건과 조인조건을 포함한 조인
SELECT emp.first_name, emp.last_name, emp.email, 
       dep.department_name, job.job_title,
       loc.city
  FROM employees emp,  
       departments dep,
       jobs job, 
       locations loc
 WHERE emp.department_id = dep.department_id
   AND emp.job_id        = job.job_id
   AND dep.location_id    = loc.location_id
   AND loc.state_province  = '캘리포니아';

-- Cartesian Product
SELECT a.employee_id, 
       a.first_name, 
       a.email, 
       b.department_name
  FROM employees a, departments b;


SELECT a.employee_id, 
       a.first_name, 
       a.email,
       a.department_id, 
       b.department_name
  FROM employees a, departments b;


SELECT COUNT(*)
  FROM employees;


SELECT COUNT(*)
  FROM departments;


SELECT a.employee_id, b.first_name, b.last_name
  FROM employees a, employees b
 WHERE a.employee_id = b.employee_id
   AND rownum < 5;


-- 셀프조인(Self-Join)
SELECT a.employee_id, b.first_name, b.last_name
  FROM employees a, employees b
 WHERE a.employee_id = b.employee_id
   AND rownum < 5;

SELECT employees.employee_id, 
       employees.first_name,
       employees.department_id,
       departments.department_name
  FROM employees, departments
 WHERE employees.department_id = departments.department_id;


SELECT employee_id, first_name
  FROM employees, employees
 WHERE employees.employee_id = employees.employee_id;


SELECT emp.employee_id, 
       emp.first_name,
       man.employee_id manager_id,
       man.first_name manager
  FROM employees emp, employees man
 WHERE emp.manager_id = man.employee_id ;


SELECT employee_id, first_name
  FROM employees
 WHERE manager_id IS NULL;

-- 안티조인(Antijoin)
SELECT emp.employee_id, emp.first_name,
       emp.department_id, dep.department_name
  FROM employees emp, departments dep
 WHERE emp.department_id <> dep.department_id;


SELECT emp.employee_id, emp.first_name
  FROM employees emp
 WHERE emp.department_id NOT IN 
         ( SELECT dep.department_id
             FROM departments dep
            WHERE dep.location_id =  3200 );

--세미조인
SELECT dep.*
  FROM departments dep
 WHERE EXISTS ( SELECT 1 
                  FROM employees emp
                 WHERE emp.department_id = dep.department_id
                   AND emp.salary > 10000 )
ORDER BY dep.department_id;

SELECT dep.*
  FROM departments dep
 WHERE EXISTS ( SELECT 1 
                  FROM employees emp
                 WHERE emp.department_id = dep.department_id
                   AND emp.salary > 10000 )
ORDER BY dep.department_id;


--외부조인

SELECT emp.employee_id,
       emp.first_name,
       emp.department_id, 
       dep.department_name
  FROM employees emp, departments dep
 WHERE emp.department_id = dep.department_id;


SELECT emp.employee_id,
       emp.first_name,
       emp.department_id, 
       dep.department_name
  FROM employees emp, departments dep
 WHERE emp.department_id = dep.department_id (+)
ORDER BY emp.department_id;


SELECT emp.employee_id,
       emp.first_name,
       emp.department_id, 
       dep.department_name
  FROM employees emp, departments dep,
       locations loc
 WHERE emp.department_id = dep.department_id(+)
   AND dep.location_id = loc.location_id
 ORDER BY emp.department_id;


SELECT emp.employee_id,
       emp.first_name,
       dep.department_name,
       loc.city
  FROM employees emp, 
       departments dep,
       locations loc
 WHERE emp.department_id = dep.department_id(+)
   AND dep.location_id    = loc.location_id(+)
 ORDER BY emp.department_id;


SELECT *
  FROM job_history;


SELECT e.employee_id, e.first_name, e.hire_date,
       j.start_date, j.end_date, j.job_id, j.department_id
  FROM employees e,
       job_history j
  WHERE e.employee_id = j.employee_id(+)
  ORDER BY j.employee_id;


SELECT e.employee_id, e.first_name, e.department_id current_dept,
       j.start_date, j.end_date, j.job_id, j.department_id old_dept
  FROM employees e,
       job_history j
  WHERE e.employee_id = j.employee_id(+)
    AND e.department_id = j.department_id
  ORDER BY j.employee_id;
  
  
SELECT e.employee_id, e.first_name, e.department_id current_dept,
       j.start_date, j.end_date, j.job_id, j.department_id old_dept
  FROM employees e,
       job_history j
  WHERE e.employee_id = j.employee_id(+)
    AND e.department_id = j.department_id(+)
  ORDER BY j.employee_id;


SELECT e.employee_id, e.first_name, 
       j.start_date, j.end_date, j.job_id, j.department_id old_dept
  FROM employees e,
       job_history j
 WHERE e.employee_id = j.employee_id(+)
   AND j.department_id = 80
 ORDER BY j.employee_id;

 SELECT e.employee_id, e.first_name,
        j.start_date, j.end_date, j.job_id, j.department_id old_dept
   FROM employees e,
        job_history j
  WHERE e.employee_id = j.employee_id(+)
    AND j.department_id(+) = 80
  ORDER BY j.employee_id;


 SELECT employee_id, manager_id
   FROM employees
  WHERE manager_id(+) = employee_id;


   SELECT e1.employee_id, e1.manager_id, e2.employee_id
     FROM employees e1, employees e2
    WHERE e1.manager_id(+) = e2.employee_id;


SELECT e.employee_id, e.first_name, e.department_id current_dept,
       j.start_date, j.end_date, j.job_id, j.department_id old_dept
  FROM employees e,
       job_history j
 WHERE e.employee_id = j.employee_id(+)
    OR e.department_id = j.department_id
 ORDER BY j.employee_id;


SELECT e.employee_id, e.first_name, e.department_id current_dept,
       j.start_date, j.end_date, j.job_id, j.department_id old_dept, d.department_name
  FROM employees e,
       job_history j, departments d
 WHERE e.employee_id = j.employee_id(+)
   AND e.department_id = j.department_id(+)
   AND d.department_id = j.department_id(+)
 ORDER BY j.employee_id; 


SELECT e.employee_id, e.first_name, e.department_id current_dept,
       j.start_date, j.end_date, j.job_id, j.department_id old_dept
  FROM employees e,
       job_history j
 WHERE e.employee_id = j.employee_id(+)
   AND e.department_id = j.department_id(+)
   AND j.department_id(+) IN (80, 90)
 ORDER BY j.employee_id;


SELECT e.employee_id, e.first_name, e.department_id current_dept,
       j.start_date, j.end_date, j.job_id, j.department_id old_dept
  FROM employees e,
       job_history j
 WHERE e.employee_id = j.employee_id(+)
   AND e.department_id = j.department_id(+)
   AND j.department_id(+) IN ( 80 )
 ORDER BY j.employee_id;


SELECT e.employee_id, e.first_name, e.department_id current_dept,
       j.start_date, j.end_date, j.job_id, j.department_id old_dept
  FROM employees e,
       job_history j
 WHERE e.employee_id = j.employee_id(+)
   AND e.department_id = j.department_id(+)
   AND j.department_id(+) = ( SELECT k.department_id
                                FROM departments k
                               WHERE k.department_id = 80 )
 ORDER BY j.employee_id;


SELECT dep.department_id, dep.department_name,
       emp.employee_id, emp.first_name
  FROM employees emp,
       departments dep
 WHERE dep.manager_id = emp.employee_id(+);


SELECT dep.department_id, dep.department_name,
       emp.employee_id, emp.first_name
  FROM employees emp,
       departments dep
 WHERE dep.manager_id(+) = emp.employee_id;


SELECT dep.department_id, dep.department_name,
       emp.employee_id, emp.first_name
  FROM employees emp,
       departments dep
 WHERE dep.manager_id(+) = emp.employee_id(+);


SELECT dep.department_id, dep.department_name,
       emp.employee_id, emp.first_name
  FROM employees emp,
       departments dep
 WHERE dep.manager_id = emp.employee_id(+)
   AND dep.manager_id(+) = emp.employee_id;


-- ANSI 조인
-- ANSI 내부조인
SELECT emp.employee_id, emp.first_name, dep.department_name
  FROM employees emp, departments dep
 WHERE emp.department_id = dep.department_id;


SELECT emp.employee_id, emp.first_name, dep.department_name
  FROM employees emp INNER JOIN departments dep
    ON emp.department_id = dep.department_id;


SELECT emp.employee_id, emp.first_name, dep.department_name
  FROM employees emp INNER JOIN departments dep
 USING ( department_id );


SELECT emp.employee_id, emp.first_name, dep.department_name, 
       dep.department_id
  FROM employees emp INNER JOIN departments dep
 USING ( department_id );


SELECT emp.employee_id, emp.first_name, dep.department_name, 
       department_id
  FROM employees emp INNER JOIN departments dep
  USING ( department_id );


SELECT emp.employee_id, emp.first_name, dep.department_name
  FROM employees emp INNER JOIN departments dep
    ON emp.employee_id = dep.manager_id;

-- 크로스 조인
SELECT *
  FROM employees CROSS JOIN departments;

-- ANSI 외부조인
SELECT Jhis.employee_id, emp.first_name
  FROM employees emp, job_history jhis
 WHERE emp.employee_id = jhis.employee_id(+)
 ORDER BY jhis.employee_id;


SELECT Jhis.employee_id, emp.first_name
  FROM employees emp LEFT OUTER JOIN job_history jhis
    ON emp.employee_id = jhis.employee_id
ORDER BY jhis.employee_id;


SELECT Jhis.employee_id, emp.first_name
  FROM job_history jhis RIGHT OUTER JOIN employees emp
    ON emp.employee_id = jhis.employee_id
ORDER BY jhis.employee_id;


SELECT employee_id, emp.first_name
  FROM job_history jhis RIGHT OUTER JOIN employees emp
 USING ( employee_id )
ORDER BY employee_id;


SELECT emp.employee_id, emp.first_name, dep.department_name
  FROM employees emp FULL OUTER JOIN departments dep
    ON emp.employee_id = dep.manager_id;

SELECT Jhis.employee_id, emp.first_name
  FROM employees emp, job_history jhis
 WHERE emp.employee_id = jhis.employee_id(+)
 ORDER BY jhis.employee_id;
