ALTER SESSION SET nls_date_format='RR/MM/DD';
-- 1. emp ���̺��� ������ ��ȸ.(Ư����ɹ�)

DESC EMP;

-- 2. �μ��� ��� ������ �����´�.

SELECT *FROM DEPT;

-- 3. �� ������� �޿��װ� �޿��׿��� 1000�� ���� ��, 200�� �� ��, 2�� ���� ��, 2�� ���� ���� �����´�.



SELECT sal ,
       sal+1000 ,
       sal-200 ,
       sal*2,
       sal/2
  FROM EMP;


-- 4. �� ����� �޿���, Ŀ�̼�, �޿� + Ŀ�̼� �׼��� �����´�.

SELECT  sal,comm,sal+nvl(comm,0)
FROM EMP;

-- 5. ������� �̸��� ������ ���� ������� �����´�.
-- 000 ����� ��� ������ XXX �Դϴ�.

SELECT ename || ' ����� ��� ������ '|| job || '�Դϴ�. '
FROM EMP;

-- 6. ������� �ٹ��ϰ� �ִ� �ٹ� �μ��� ��ȣ�� �����´�.
--(�ٹ��ϰ� �ִ� �μ���ȣ�̱� ������ dept ���̺� ��ȸ���� �ʰ� emp���̺��� ��ȸ�Ѵ�)
--(��, �μ���ȣ�� �ߺ����� �������ʰ� �ѹ��� ���´�.)

SELECT DISTINCT deptno FROM EMP;

-- 7. �޿��� 1500�̻��� ������� �����ȣ, �̸�, �޿��� �����´�.

SELECT  empno,ename,sal
FROM emp
WHERE sal >=1500
ORDER BY 3;

-- 8. ������ SALESMAN�� ����� �����ȣ, �̸�, ������ �����´�.

SELECT empno,ename,job
FROM emp
WHERE job=upper('salesman');


-- 9. 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �����ȣ, �̸�, �Ի����� �����´�.

SELECt empno, ename, hiredate
FROM emp
WHERE hiredate>'1982-01-01';

-- 10. 10�� �μ����� �ٹ��ϰ� �ִ� ������ MANAGER�� ����� �����ȣ, �̸�, �ٹ��μ�, ������ �����´�.

SELECT empno, ename, deptno, job
FROM emp
WHERE deptno =10
AND job=upper('manager');

-- 11. �Ի�⵵�� 1981���� ����߿� �޿��� 1500 �̻��� ����� �����ȣ, �̸�, �޿�, �Ի����� �����´�. ***

SELECT  empno,ename,sal,hiredate
FROM emp
WHERE TO_CHAR(hiredate,'yyyy')='1981'
AND sal>=1500
ORDER BY 3;

-- 12. �޿��� 2000���� ũ�ų� 1000���� ���� ����� �����ȣ, �̸�, �޿��� �����´�.

SELECT  empno,ename,sal
FROM emp
WHERE sal >2000
OR sal <1000
ORDER BY 3;

-- 13. ������ CLERK, SALESMAN, ANALYST�� ����� �����ȣ, �̸�, ������ �����´�

SELECT empno,ename,job
FROM emp
WHERE job=upper('clerk')
OR job=upper('salesman')
OR job=upper('analyst')
ORDER BY 3;

-- 14. ��� ��ȣ�� 7499, 7566, 7839�� �ƴ� ������� �����ȣ, �̸��� �����´�.

SELECT empno,ename
FROM emp
WHERE empno NOT IN (7499, 7566, 7839)
ORDER BY 1;

select empno, ename
from emp
where not(empno in(7499, 7566, 7839));


