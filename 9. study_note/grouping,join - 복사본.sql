ALTER SESSION SET nls_date_format='RR/MM/DD';
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT e.empno, e.ename, e.deptno, e.job
FROM EMP e, DEPT d
WHERE e.deptno = d.deptno
AND d.LOC = 'DALLAS';

SELECT empno, ename, dname, sal FROM EMP e, DEPT d
WHERE e.deptno= d.deptno

AND sal >= 3000
AND d.dname = 'SALES' ;
----------------------------------------1�� �� ���̺�


SELECT* FROM S_ORD;						 --'1'���̺�
SELECT * FROM S_PRODUCT;    --'1'���̺�
SELECT* FROM S_ITEM;       -- '��'���̺� = �������� �������̺� �̸��� ���� s_ord_product;(�� ���̺� �̸� ���ļ�)

SELECT i.ord_id                      ------------����� �������
					,o.customer_id
          ,C.NAME
          ,o.sales_rep_id
          ,e.FIRST_NAME
					,o.date_ordered
          ,i.PRODUCT_ID
          ,p.name
          ,i.QUANTITY
          ,i.PRICE
FROM S_ITEM i                    ----------����� ������ �������ִ� ���̺�� + ����
				,S_ORD o
        , S_CUSTOMER c
        ,S_PRODUCT p
        ,S_EMP e
WHERE i.ord_id = o.id            ---------S_ITEM�� ORD_ID��  S_ORD�� ID�� ����
AND i.PRODUCT_ID = p.id       ---------S_ITEM�� PRODUCT_ID�� S_PRODUCT�� ID�� ����
AND o.customer_id = c.id       ---------S_ORD�� CUSTOMER_ID�� S_CUSTOMER�� ID�� ����
AND o.sales_rep_id = e.id;    ---------S_ORD�� SALES_REP_ID�� S_EMP�� ID�� ����

SELECT  * FROM v$nls_parameters;

SELECT * FROM EMP;
SELECT * FROM SALGRADE;
SELECT empno, ename, sal, grade
FROM EMP e, SALGRADE s
WHERE e.sal BETWEEN s.losal AND s.hisal


SELECT * FROM EMP e, DEPT d
WHERE e.deptno = d.deptno(+);


SELECT * FROM EMP e , EMP m
WHERE e.mgr = m.empno(+);

SELECT i.ord_id           -- �ֹ����̵�
   ,o.DATE_ORDERED
     ,o.CUSTOMER_ID      -- �����̵�
      ,C.NAME
      ,O.SALES_REP_ID
      ,e.FIRST_NAME
      ,m.FIRST_NAME mgr_name
      ,o.DATE_ORDERED
      ,i.PRODUCT_ID
      ,P.NAME
      ,g.FILENAME
      ,i.QUANTITY
      ,i.PRICE
FROM S_ITEM i
   ,S_ORD o
    ,S_CUSTOMER C
    ,S_PRODUCT p
    ,S_IMAGE g
    ,S_EMP E
    ,S_EMP m
where i.ORD_ID = o.id
 AND I.PRODUCT_ID = P.ID
 AND p.IMAGE_ID = g.id(+)
  AND O.CUSTOMER_ID = C.ID
 AND O.SALES_REP_ID = E.ID
 AND e.MANAGER_ID = m.id(+)
 AND O.DATE_ORDERED BETWEEN '92/08/01' AND '92/08/31';

SELECT * FROM s_product;

SELECT * FROM S_ORD
ORDER BY customer_id;

SELECT customer_id, SUM(total)  FROM S_ORD
GROUP BY customer_id;

SELECT * FROM EMP
ORDER BY deptno;

SELECT deptno, SUM(sal) total, max(sal), min(sal)
FROM EMP
GROUP by deptno;

SELECT job, max(sal)
FROM EMP
GROUP BY job;      --emp���̺��� job����(group by job) �ְ�޿�(max(sal))

SELECT * FROM S_ORD;

SELECT customer_id, SUM(total)
FROM S_ORD
WHERE date_ordered LIKE '92/08%'
GROUP BY customer_id;

SELECT customer_id, sum(total)
FROM S_ORD
GROUP BY customer_id;
--�׷��Լ� �����Ŀ� �ٽ� �����ϰ� ������ order by �Լ� ���

SELECT * FROM EMP
ORDER BY deptno;               --�μ����� ����


SELECT deptno, sum(sal) FROM EMP     --4. �μ��� sal�� ���Ѱ��� ���
WHERE hiredate LIKE '81%'                 --1. 81�⵵�� �Ի��� ������ ���� ����
GROUP by deptno                            --2. �μ� �׷���
HAVING SUM(sal)>=7000                  --3. sal�� 7000�̻��� �μ��� ��������
ORDER BY SUM(sal)  ;                        --5. select�� ���� ���������� ����
--����-- 1.where ���̺� �˻�����
--         2.group by �׷�������
--         3.having �׷����� ���̺��� ����
--         4.select �׷��Լ�����
--         5.order by ����

SELECT deptno, sum(sal) FROM EMP
WHERE hiredate LIKE '81%'
GROUP by deptno
HAVING COUNT(*) >=2
ORDER BY SUM(sal);

SELECT i.PRODUCT_ID, P.NAME, SUM(price * quantity)
FROM S_ITEM i, S_ORD o, S_PRODUCT p
WHERE i.ord_id = o.id
AND i.PRODUCT_ID = p.id
AND o.DATE_ORDERED LIKE '92/08%'
group BY i.product_id, p.name
HAVING COUNT(*) >=2
ORDER BY SUM(quantity*price)

SELECT * FROM S_ITEM
ORDER BY product_id;


SELECT * FROM S_WAREHOUSE;
SELECT * FROM S_INVENTORY;
SELECT * FROM S_PRODUCT;


--��ǰ���̵�, ��ǰ��, â����̵�, â���ּ�, â������� ���̵�, â������� ������� ���--
SELECT i.PRODUCT_ID
					,P.NAME
          ,i.WAREHOUSE_ID
          ,w.ADDRESS
          ,w.MANAGER_ID
          ,m.FIRST_NAME
FROM S_WAREHOUSE w
				,S_INVENTORY i
        ,S_PRODUCT p
        ,S_EMP e
        ,S_EMP m
WHERE i.PRODUCT_ID = p.id
	AND w.id = i.WAREHOUSE_ID
  AND w.MANAGER_ID = e.id
  AND e.MANAGER_ID =m.id(+);


--subquery--
SELECT * FROM s_emp
WHERE dept_id =
									(SELECT dept_id FROM S_EMP
                  WHERE last_name ='Biri')

SELECT * FROM S_EMP
WHERE salary >
											(SELECT AVG(salary) FROM S_EMP )          --�����μ����� ��ձ޿����� ���� �޴»�� ���

SELECT * FROM S_EMP
WHERE first_name IN
													(SELECT min(first_name) FROM S_EMP
                          GROUP BY dept_id)


SELECT * FROM S_EMP
ORDER BY dept_id ASC, salary desc;

--1��--
SELECT * FROM S_EMP
WHERE (dept_id, salary) IN (SELECT dept_id, min(salary) FROM S_EMP
												GROUP BY dept_id)                                    ------�μ��� �����޿��� �޴� �������� ���
ORDER BY dept_id;

--2��--�μ�id�� �����ñ��� s_emp�� ������ ��
SELECT*
FROM S_EMP e
				, (SELECT dept_id, min(salary) msal FROM S_EMP	GROUP BY dept_id) t
WHERE e.dept_id = t.dept_id
 AND e.SALARY = t.msal
ORDER BY e.dept_id

--3��--�� ��� ����Ŀ���� ������ �ݺ��ϱ� ������ �ӵ��� ����(������輭��Ŀ�� : Co-related Subquery)
SELECT * FROM S_EMP e                     --ù��° ����(����Ŀ���� ����Ŀ������ ���� ����)
WHERE salary =(SELECT min(salary)       --�ι�° ����(e.dept_id�� ����Ŀ��(�����޿�)�� dept_id�� ������� ���)
											FROM S_EMP
                      WHERE dept_id = e.dept_id);


CREATE TABLE S_ORD08
AS
select * FROM S_ORD
WHERE date_ordered LIKE '92/08%'

CREATE TABLE s_ord09
AS
SELECT * FROM s_ord
WHERE date_ordered LIKE '92/09%'

SELECT * FROM s_ord08
SELECT * FROM s_ord09;    --9��, 8���� �������� ���� Į��

SELECT * FROM s_ord08
UNION ALL                    --�������� Į���� ��ġ�� ��ɾ� (����� ������)
SELECT * FROM s_ord09;

--92�� 8���� 9���� �ֹ����̵�, �����̵�, ����, �ֹ��Ѿ��� ����Ͻÿ�.
SELECT o.id
					,o.customer_id
          ,o.date_ordered
          ,c.name
          ,o.total
FROM (SELECT * FROM s_ord08
					UNION ALL
					SELECT * FROM s_ord09) o
          , S_CUSTOMER c
WHERE o.customer_id = c.id;



--���̺� ����
DROP TABLE gisu;
CREATE TABLE gisu (
	id 		 					VARCHAR2(12)	PRIMARY KEY     --primary key�� �����ؾ� ������ �ߺ����� �������� ����
  ,NAME 			VARCHAR2(20)
  ,age 					NUMBER(3)
  ,reg_date		DATE
  ,ssn					CHAR(13)
  );

INSERT INTO gisu
VALUES('hong', 'ȫ�浿', 20, SYSDATE, '1111');

COMMIT;

SELECT * FROM gisu;


--�ڽ��� �Ŵ������� �޿��� ���� �޴� �������� ���� �޿��� ����Ͻÿ�
SELECT e.last_name
					,e.salary
FROM S_EMP e
				,S_EMP m
WHERE e.MANAGER_ID = m.id
 AND e.salary > m.SALARY

--AVG : ���

-- 15] DEPT Table ���� �����ϴ� �μ��ڵ������� �ش�μ��� �ٹ��ϴ� ����� �������� �ʴ� ����� ����� ����϶�.
SELECT *
FROM DEPT d
				,EMP e
WHERE d.DEPTNO = e.deptno
 AND



-- 14] EMP Table�� �����͸� ����ϵ� �ش����� ���� �����ȣ�� ����� ������ �Բ� ����϶�.
SELECT *
FROM EMP
				,(SELECT m.empno mgr_no, m.ename mgr_name
        FROM EMP e, EMP m
        WHERE e.empno = m.mgr)


 �����ȣ, �̸�, �μ���, �Ի���, ������ ����϶�.
-- 13] 10�� �μ��� ������߿��� 20�� �μ��� ����� ���� ������ �ϴ� ����� �����ȣ, �̸�, �μ���, �Ի���, ������ ����϶�.
SELECT e.empno
					,e.ename
          ,d.DNAME
          ,e.hiredate
          ,d.LOC
          ,d.DEPTNO
          ,e.job
FROM EMP e
				,DEPT d
WHERE e.deptno = d.DEPTNO
ORDER BY d.DEPTNO


--������ 3000 �̻��� ����� ������ �ִ� �μ� id�� �μ��� ��ȸ
SELECT d.DEPTNO
					,d.DNAME
FROM EMP e
				,DEPT d
WHERE e.deptno =d.DEPTNO
 AND e.sal > 3000


--6 �μ����̺��� ������� ��տ������� ���� �޴� ������� �����ϴ� �μ��� �μ�id�� �μ��� ��ȸ
SELECT d.DEPTNO
					,d.DNAME
FROM EMP e
				,DEPT d
WHERE e.deptno= d.DEPTNO
 AND  sal >	(SELECT AVG(sal) FROM EMP )



 SELECT LPAD(' ', LEVEL PRIOR 4,' ')|| empno, ename, mgr, level FROM EMP
 START with mgr  BY PRIOR empno= mgr


--ANSI ��������(inner join)--
SELECT *
FROM EMP e inner JOIN  DEPT d
						on e.DEPTno = d.DEPTNO
WHERE e.empno = 7369;


--�ƿ�������--
SELECT *
FROM EMP e, DEPT d
WHERE e.deptno = d.deptno(+)    --�� ���;��ϴ� ���� �ƿ��� ���̺�(emp���̺�)--

--�� Ŀ���� ANSI ������ ���--
SELECT *
FROM EMP e left outer JOIN DEPT d   	--���� ���̺��� �ƿ������̺��̱⶧���� left--
				ON e.DEPTNO = d.DEPTNO

--full outer join  (���ʿ��� �� �Ⱦ�)
SELECT *
FROM EMP e FULL outer JOIN DEPT d
				ON e.deptno = d.DEPTNO
/*
SELECT *
FROM EMP e, DEPT d
WHERE e.deptno(+) = d.deptno(+)
--����Ŭ������ ���� Ǯ����(+) ������ (�ʿ��� ����� ����)
*/

