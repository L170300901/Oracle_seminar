
--[5번 문제]
--직급에 변동사항이 한 번이라도 있는 사원들(JOB_HISTORY)의
--사번, 풀네임, 직급(JOB_TITLE), 입사날짜, 급여, 직급의 변동 횟수를 구하세요
--(직급의 변동사항이 한 번 이상인 사람들이 있습니다..)

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOBS;
SELECT * FROM JOB_HISTORY;

SELECT  * from
(SELECT e.EMPLOYEE_ID, e.FIRST_NAME || ' ' || e.LAST_NAME Fullname1 ,e.HIRE_DATE, e.SALARY,H.START_DATE,h.END_DATE
FROM EMPLOYEES e, JOB_HISTORY h WHERE e.EMPLOYEE_ID = h.EMPLOYEE_ID) q,
(SELECT e.EMPLOYEE_ID, e.FIRST_NAME || ' ' || e.LAST_NAME Fullname2 ,e.HIRE_DATE, e.SALARY,h.START_DATE,h.END_DATE
FROM EMPLOYEES e, JOB_HISTORY h WHERE e.EMPLOYEE_ID = h.EMPLOYEE_ID) w
WHERE Fullname1 = Fullname2 AND Q.START_DATE <> w.start_date







SELECT *
from
(SELECT Fullname2,COUNT(*)AS 직급변동횟수 from
(SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME || ' ' || e.LAST_NAME Fullname2
     ,e.HIRE_DATE
     , e.SALARY
     ,h.START_DATE
     ,h.END_DATE
  FROM EMPLOYEES e
     , JOB_HISTORY h
 WHERE e.EMPLOYEE_ID = h.EMPLOYEE_ID) aaa
 group by Fullname2)a, EMPLOYEES b
 WHERE e.FIRST_NAME = b.first_name