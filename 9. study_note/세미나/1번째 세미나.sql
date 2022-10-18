-- 1. �� ����(city)�� �ִ� ��� �μ� �������� ��ձ޿��� ��ȸ�ϰ��� �Ѵ�.
--   ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ �������� ����Ͻÿ�.
--   ��, ���ÿ� �� ���ϴ� ������ 10�� �̻��� ���� �����ϰ� ��ȸ�Ͻÿ�.



--2. ��å(Job Title)�� Sales Manager�� ������� �Ի�⵵�� �Ի�⵵(hire_date)�� ��� �޿��� ����Ͻÿ�.
--   ��� �� �⵵�� �������� �������� �����Ͻÿ�.



 --3. ��Public  Accountant���� ��å(job_title)���� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� ����Ͻÿ�.
--   (���� ��Public Accountant���� ��å(job_title)���� �ٹ��ϴ� ����� ��� ���� �ʴ´�.)
--   �̸��� first_name, last_name�� �Ʒ��� �������� ���� ����Ѵ�.



--4. 1997�⿡ �Ի�(hire_date)�� �������� ���(employee_id), �̸�(first_name), ��(last_name),
--   �μ���(department_name)�� ��ȸ�մϴ�.
--   �̶�, �μ��� ��ġ���� ���� ������ ���, ��<Not Assigned>���� ����Ͻÿ�



--5. ������(job_title)�� ��Sales Representative���� ���� �߿��� ����(salary)�� 9,000�̻�, 10,000 ������
--   �������� �̸�(first_name), ��(last_name)�� ����(salary)�� ����Ͻÿ�



--6. �μ����� ���� ���� �޿��� �ް� �ִ� ������ �̸�, �μ��̸�, �޿��� ����Ͻÿ�.
--   �̸��� last_name�� ����ϸ�, �μ��̸����� �������� �����ϰ�,
--   �μ��� ���� ��� �̸��� ���� ���� �������� �����Ͽ� ����մϴ�.

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


--7. EMPLOYEES ���̺��� �޿��� ���� �޴� ������� ��ȸ���� �� ���ó�� 6��°���� 10 ��°����
--   5���� last_name, first_name, salary�� ��ȸ�ϴ� sql������ �ۼ��Ͻÿ�.
--****����� ����****--



--  1. ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ �������� ����Ͻÿ�.
--   ��, ���ÿ� �� ���ϴ� ������ 10�� �̻��� ���� �����ϰ� ��ȸ�Ͻÿ�.
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

--2. ��å(Job Title)�� Sales Manager�� ������� �Ի�⵵�� �Ի�⵵(hire_date)�� ��� �޿��� ����Ͻÿ�.
--   ��� �� �⵵�� �������� �������� �����Ͻÿ�.
SELECT  to_char(e.HIRE_DATE,'yyyy') , AVG(e.salary)
  FROM EMPLOYEES e
              , JOBS j
 WHERE e.JOB_ID = j.JOB_ID
  AND j.JOB_TITLE = 'Sales Manager'
 GROUP BY to_Char(e.HIRE_DATE,'yyyy')
 ORDER BY to_Char(e.HIRE_DATE,'yyyy') ASC

 --�̷����ϸ� ���� �ٸ������ �ٸ������� ���е�
 SELECT  (e.HIRE_DATE) , AVG(e.salary)
  FROM EMPLOYEES e
              , JOBS j
 WHERE e.JOB_ID = j.JOB_ID
  AND j.JOB_TITLE = 'Sales Manager'
 GROUP BY (e.HIRE_DATE)
 ORDER BY (e.HIRE_DATE) ASC


  --3. ��Public  Accountant���� ��å(job_title)���� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� ����Ͻÿ�.
--   (���� ��Public Accountant���� ��å(job_title)���� �ٹ��ϴ� ����� ��� ���� �ʴ´�.)
--   �̸��� first_name, last_name�� �Ʒ��� �������� ���� ����Ѵ�.
SELECT e.EMPLOYEE_ID ���, e.FIRST_NAME||' '||e.LAST_NAME �̸�
FROM EMPLOYEES e,
(SELECT * FROM JOB_HISTORY
WHERE job_id IN (SELECT job_id FROM JOBS WHERE job_title='Public Accountant')) j
WHERE e.EMPLOYEE_ID=j.EMPLOYEE_ID
ORDER BY e.EMPLOYEE_ID;
SELECT * FROM EMPLOYEES

--����Ǯ��
SELECT H.EMPLOYEE_ID, H.START_DATE, H.END_DATE, E.FIRST_NAME, J.JOB_TITLE
FROM EMPLOYEES E, JOB_HISTORY H, JOBS J
WHERE E.EMPLOYEE_ID=H.EMPLOYEE_ID
AND J.JOB_ID=H.JOB_ID
AND UPPER(J.JOB_TITLE) = UPPER('PUBLIC ACCOUNTANT');

--4. 07�⿡ �Ի�(hire_date)�� �������� ���(employee_id), �̸�(first_name), ��(last_name),
--   �μ���(department_name)�� ��ȸ�մϴ�.
--   �̶�, �μ��� ��ġ���� ���� ������ ���, ��<Not Assigned>���� ����Ͻÿ�
SELECT e.hire_date �Ի糯¥ ,e.employee_id ��� ,e.first_name �̸� ,e.last_name �� ,NVL(d.department_name,'<Not Assigned>') �μ���
FROM EMPLOYEES e,DEPARTMENTS d
WHERE TO_CHAR(hire_date) LIKE '07%'
AND e.DEPARTMENT_ID = d.DEPARTMENT_ID(+) ;

--5. ������(job_title)�� ��Sales Representative���� ���� �߿��� ����(salary)�� 9,000�̻�, 10,000 ������
--   �������� �̸�(first_name), ��(last_name)�� ����(salary)�� ����Ͻÿ�
--SELECT * FROM JOBS;
--SELECT * FROM EMPLOYEES;
SELECT e.FIRST_NAME, e.LAST_NAME, e.SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.job_id = j.job_id
AND job_title LIKE 'Sales Representative'
AND salary BETWEEN 9000 AND 10000
ORDER BY salary;


--6. �μ����� ���� ���� �޿��� �ް� �ִ� ������ �̸�, �μ��̸�, �޿��� ����Ͻÿ�.
--   �̸��� last_name�� ����ϸ�, �μ��̸����� �������� �����ϰ�,
--   �μ��� ���� ��� �̸��� ���� ���� �������� �����Ͽ� ����մϴ�.

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


 --7. EMPLOYEES ���̺��� �޿��� ���� �޴� ������� ��ȸ���� �� ���ó�� 6��°���� 10 ��°����
--   5���� last_name, first_name, salary�� ��ȸ�ϴ� sql������ �ۼ��Ͻÿ�.
SELECT a.last_name,a.first_name,a.salary
FROM
(SELECT last_name,first_name,salary,ROW_NUMBER() over(ORDER BY salary desc) num
FROM EMPLOYEES) a
WHERE a.NUM BETWEEN 6 AND 10;


--��
SELECT *
   FROM (
             SELECT last_name, first_name, salary , ROWNUM rank
             FROM (SELECT last_name, first_name, salary FROM EMPLOYEES ORDER BY salary desc)
            )
WHERE RANK > 5 AND RANK < 11