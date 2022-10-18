-- 1. 각 도시(city)에 있는 모든 부서 직원들의 평균급여를 조회하고자 한다.
--   평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 직원수를 출력하시오.
--   단, 도시에 근 무하는 직원이 10명 이상인 곳은 제외하고 조회하시오.



--2. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 출력하시오.
--   출력 시 년도를 기준으로 오름차순 정렬하시오.



 --3. ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하시오.
--   (현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 않는다.)
--   이름은 first_name, last_name을 아래의 실행결과와 같이 출력한다.



--4. 1997년에 입사(hire_date)한 직원들의 사번(employee_id), 이름(first_name), 성(last_name),
--   부서명(department_name)을 조회합니다.
--   이때, 부서에 배치되지 않은 직원의 경우, ‘<Not Assigned>’로 출력하시오



--5. 업무명(job_title)이 ‘Sales Representative’인 직원 중에서 연봉(salary)이 9,000이상, 10,000 이하인
--   직원들의 이름(first_name), 성(last_name)과 연봉(salary)를 출력하시오



--6. 부서별로 가장 적은 급여를 받고 있는 직원의 이름, 부서이름, 급여를 출력하시오.
--   이름은 last_name만 출력하며, 부서이름으로 오름차순 정렬하고,
--   부서가 같은 경우 이름을 기준 으로 오름차순 정렬하여 출력합니다.

SELECT E.LAST_NAME, E.DEPARTMENT_ID ,D.DEPARTMENT_NAME, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D,
				(
        SELECT DEPARTMENT_ID, MIN(SALARY) MIN_S
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ) S
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
AND E.DEPARTMENT_ID=S.DEPARTMENT_ID
AND E.SALARY = S.MIN_S;

SELECT * FROM EMPLOYEES
order BY DEPARTMENT_ID ;

SELECT e.LAST_NAME
					,a.*
FROM EMPLOYEES e
				,(SELECT d.DEPARTMENT_NAME, min(e.SALARY) min_sal
        	FROM EMPLOYEES e, DEPARTMENTS d
          WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
          GROUP BY d.DEPARTMENT_NAME) a
WHERE e.SALARY = a.min_sal
ORDER BY a.department_name , e.LAST_NAME;


--7. EMPLOYEES 테이블에서 급여를 많이 받는 순서대로 조회했을 때 결과처럼 6번째부터 10 번째까지
--   5명의 last_name, first_name, salary를 조회하는 sql문장을 작성하시오.
--****어려운 문제****--



--  1. 평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 직원수를 출력하시오.
--   단, 도시에 근 무하는 직원이 10명 이상인 곳은 제외하고 조회하시오.
SELECT l.CITY
            ,AVG(e.SALARY)
        ,COUNT(*)
FROM LOCATIONS l
            ,EMPLOYEES e
        ,DEPARTMENTS d
WHERE l.LOCATION_ID = d.LOCATION_ID
 AND d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY l.CITY
HAVING COUNT(*) < 10

--2. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 출력하시오.
--   출력 시 년도를 기준으로 오름차순 정렬하시오.
SELECT  to_char(e.HIRE_DATE,'yyyy') , AVG(e.salary)
  FROM EMPLOYEES e
              , JOBS j
 WHERE e.JOB_ID = j.JOB_ID
  AND j.JOB_TITLE = 'Sales Manager'
 GROUP BY to_Char(e.HIRE_DATE,'yyyy')
 ORDER BY to_Char(e.HIRE_DATE,'yyyy') ASC

 --이렇게하면 월이 다른사람이 다른것으로 구분됨
 SELECT  (e.HIRE_DATE) , AVG(e.salary)
  FROM EMPLOYEES e
              , JOBS j
 WHERE e.JOB_ID = j.JOB_ID
  AND j.JOB_TITLE = 'Sales Manager'
 GROUP BY (e.HIRE_DATE)
 ORDER BY (e.HIRE_DATE) ASC


  --3. ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하시오.
--   (현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 않는다.)
--   이름은 first_name, last_name을 아래의 실행결과와 같이 출력한다.
SELECT e.EMPLOYEE_ID 사번, e.FIRST_NAME||' '||e.LAST_NAME 이름
FROM EMPLOYEES e,
(SELECT * FROM JOB_HISTORY
WHERE job_id IN (SELECT job_id FROM JOBS WHERE job_title='Public Accountant')) j
WHERE e.EMPLOYEE_ID=j.EMPLOYEE_ID
ORDER BY e.EMPLOYEE_ID;
SELECT * FROM EMPLOYEES

--숭쌤풀이
SELECT H.EMPLOYEE_ID, H.START_DATE, H.END_DATE, E.FIRST_NAME, J.JOB_TITLE
FROM EMPLOYEES E, JOB_HISTORY H, JOBS J
WHERE E.EMPLOYEE_ID=H.EMPLOYEE_ID
AND J.JOB_ID=H.JOB_ID
AND UPPER(J.JOB_TITLE) = UPPER('PUBLIC ACCOUNTANT');

--4. 07년에 입사(hire_date)한 직원들의 사번(employee_id), 이름(first_name), 성(last_name),
--   부서명(department_name)을 조회합니다.
--   이때, 부서에 배치되지 않은 직원의 경우, ‘<Not Assigned>’로 출력하시오
SELECT e.hire_date 입사날짜 ,e.employee_id 사번 ,e.first_name 이름 ,e.last_name 성 ,NVL(d.department_name,'<Not Assigned>') 부서명
FROM EMPLOYEES e,DEPARTMENTS d
WHERE TO_CHAR(hire_date) LIKE '07%'
AND e.DEPARTMENT_ID = d.DEPARTMENT_ID(+) ;

--5. 업무명(job_title)이 ‘Sales Representative’인 직원 중에서 연봉(salary)이 9,000이상, 10,000 이하인
--   직원들의 이름(first_name), 성(last_name)과 연봉(salary)를 출력하시오
--SELECT * FROM JOBS;
--SELECT * FROM EMPLOYEES;
SELECT e.FIRST_NAME, e.LAST_NAME, e.SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.job_id = j.job_id
AND job_title LIKE 'Sales Representative'
AND salary BETWEEN 9000 AND 10000
ORDER BY salary;


--6. 부서별로 가장 적은 급여를 받고 있는 직원의 이름, 부서이름, 급여를 출력하시오.
--   이름은 last_name만 출력하며, 부서이름으로 오름차순 정렬하고,
--   부서가 같은 경우 이름을 기준 으로 오름차순 정렬하여 출력합니다.

SELECT E.LAST_NAME, E.DEPARTMENT_ID ,D.DEPARTMENT_NAME, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D,
				(
        SELECT DEPARTMENT_ID, MIN(SALARY) MIN_S
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ) S
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
AND E.DEPARTMENT_ID=S.DEPARTMENT_ID
AND E.SALARY = S.MIN_S;


 --7. EMPLOYEES 테이블에서 급여를 많이 받는 순서대로 조회했을 때 결과처럼 6번째부터 10 번째까지
--   5명의 last_name, first_name, salary를 조회하는 sql문장을 작성하시오.
SELECT a.last_name,a.first_name,a.salary
FROM
(SELECT last_name,first_name,salary,ROW_NUMBER() over(ORDER BY salary desc) num
FROM EMPLOYEES) a
WHERE a.NUM BETWEEN 6 AND 10;


--답
SELECT *
   FROM (
             SELECT last_name, first_name, salary , ROWNUM rank
             FROM (SELECT last_name, first_name, salary FROM EMPLOYEES ORDER BY salary desc)
            )
WHERE RANK > 5 AND RANK < 11