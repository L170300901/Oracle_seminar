
--[5�� ����]
--���޿� ���������� �� ���̶� �ִ� �����(JOB_HISTORY)��
--���, Ǯ����, ����(JOB_TITLE), �Ի糯¥, �޿�, ������ ���� Ƚ���� ���ϼ���
--(������ ���������� �� �� �̻��� ������� �ֽ��ϴ�..)

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
(SELECT Fullname2,COUNT(*)AS ���޺���Ƚ�� from
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