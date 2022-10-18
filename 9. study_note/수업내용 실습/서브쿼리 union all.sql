---��������---

--------������ ��������
SELECT * FROM S_EMP;

last_name�� Biri �� ����� �ٹ��ϴ� �μ��� �������� ���� ����Ͻÿ�
SELECT * FROM S_EMP
WHERE dept_id =
											(SELECT DEPT_id FROM S_EMP
                      WHERE UPPER(last_name)='BIRI')
--���� Biri�� �μ���ȣ�� �ȴٸ� �ٷ� �� �� ������ �𸣱⶧���� ���������� ���
--�˷����� ���� �������� ���� �˱����� ���
--���������� ���� ����ȴ�.  �ٱ��� ������ ��������. �������� �� ���� �ƿ��ͷ� ����

--�̶� =, >, < �����ڸ� ������ ���������� ����(����) �ϳ��� ���;��Ѵ�

��ü ������ ��ձ޿����� ���� �޴� ������ ����϶�
SELECT * FROM S_EMP
WHERE salary >
									(SELECT AVG(salary) FROM S_EMP)

--------������ ��������
--�Ѱ� �̻��� ���� ���Ϲ޴� �������� (��Ƽ�ο�����)
--������ ������ ��ſ� IN�� ���� ������ �����ڸ� ���

�μ����� ���ĺ� ������ ù��° ���� first_name
SELECT * FROM S_EMP
WHERE first_name IN	(SELECT min(first_name) FROM S_EMP
															GROUP BY dept_id)

 --SELECT dept_id, min(first_name)
 --FROM S_EMP
 --GROUP BY dept_id

 --ppt����
 �� �μ����� �ְ�޿��� �޴� ������
 Dept_id, ID, Last_name, Salary�� ����Ͻÿ�.
 SELECT s.DEPT_ID, s.ID, s.LAST_NAME, s.SALARY
 FROM S_EMP s
 WHERE (DEPT_ID,salary) IN( SELECT dept_id,MAX(salary) FROM S_EMP
                              GROUP BY dept_id)
 --???�� where������ ��ȣ�ؾ� �����ȳ�?
 --Ǯ�̰���
 SELECT * FROM S_EMP
 WHERE salary IN (SELECT MIN(salary) FROM S_EMP
                         GROUP BY dept_id)
 --�̷��Ը� ������ �����ϸ� � �μ��� �����޿��� �� �ٸ� �μ��� �ְ�޿��� �� �ִ�
 --���������� ����� ���� ������ ���ٰ� ����ϸ� ���ϴ� ������� ���� �� ����
 --���� �μ����̵�� �޿��� ���� ���ؼ� �� Į���� ������ ������ ����ؾ���


 --�μ��� �����޿��� ���ϴ� 3���� ���

 1. where���� ���ǿ� �������� �ֱ� 'IN' ���
 --IN������ ���� ��Ƽ���� ��ƼĮ���� ���ؼ� Ǯ��
 SELECT * FROM S_EMP s
 WHERE (dept_id, salary) IN( SELECT dept_id, MIN(salary) FROM S_EMP
                              GROUP BY dept_id)

 2. from���� 'in-line View'
 --�������� �޸𸮿� �ö� ���̺��� �����ؼ� Ǯ��
 SELECT *
 FROM S_EMP e, ( SELECT dept_id, MIN(salary) msal FROM S_EMP
                        GROUP BY dept_id) m    --�޸� �󿡼� �� �ΰ��� ���̺� ����
 WHERE e.DEPT_ID=m.dept_id
 		AND e.SALARY=m.msal

3. 'Co-related' ��������
SELECT * FROM S_EMP e
WHERE salary =(SELECT MIN(salary)
											FROM S_EMP
                      WHERE dept_id=e.DEPT_ID)
--Ư���ϰ� �ٱ��� �������� �����.
--�� �ึ�� ���������� �Ź� ����ȴ�. �ſ� ��ȿ����



------------���տ�����--------------
OLTP (ONLINE TRANSACTION Processing)
DW(������ �����Ͽ콺)

������ �̰� : �ΰ��� �����ͺ��̽��� ��ġ�ϴ°�
		�ϳ��� �����Ϳ����Ͽ�¡�ý����� ���� �ϳ��� OLTPȯ�濡�� �ٷλ��
SELECT * FROM S_ORD;
SELECT dept_id, min(salary) msal FROM S_ORD
           GROUP BY dept_id

-------���������� ���� ���̺����
CREATE TABLE S_ORD08
AS
SELECT * FROM S_ORD
WHERE date_ordered LIKE '92/08%'


--------Union all  (������)----------------
SELECT * FROM S_ORD08
UNION ALL
SELECT * FROM S_ORD09;

--join�� �ߺ����� ���������� ���� ���� ���̺��� ��ĥ�� ���. ����
--������ union all�� Ư�� ���ؿ� ���� �������� ���ڵ带 ��ĥ�� ���. ����

92�� 8���� 9�� �ֹ������� ����Ͻÿ�
�ֹ����̵�, �����̵�, ����, �ֹ��Ѿ��� ����Ͻÿ�

SELECT o.id, o.customer_id,C.NAME, o.total
FROM ( SELECT * FROM S_ORD08
                       UNION ALL
                       SELECT * FROM S_ORD09) o, S_CUSTOMER c
WHERE o.customer_id=c.ID










