-- 1. emp ���̺��� ������ ��ȸ.(Ư����ɹ�)

	SELECT * from emp

-- 2. �μ��� ��� ������ �����´�.

	SELECT * from emp

-- 3. �� ������� �޿��װ� �޿��׿��� 1000�� ���� ��, 200�� �� ��, 2�� ���� ��, 2�� ���� ���� �����´�.

	SELECT sal from EMP
	SELECT sal + 1000 from EMP
	SELECT sal - 200 from EMP
	SELECT sal * 2 from EMP
	SELECT sal / 2 from EMP

-- 4. �� ����� �޿���, Ŀ�̼�, �޿� + Ŀ�̼� �׼��� �����´�.

	SELECT sal , comm, sal+comm FROM emp

-- 5. ������� �̸��� ������ ���� ������� �����´�.
-- 000 ����� ��� ������ XXX �Դϴ�.


-- 6. ������� �ٹ��ϰ� �ִ� �ٹ� �μ��� ��ȣ�� �����´�.
--(�ٹ��ϰ� �ִ� �μ���ȣ�̱� ������ dept ���̺� ��ȸ���� �ʰ� emp���̺��� ��ȸ�Ѵ�)
--(��, �μ���ȣ�� �ߺ����� �������ʰ� �ѹ��� ���´�.)



-- 7. �޿��� 1500�̻��� ������� �����ȣ, �̸�, �޿��� �����´�.

	select empno, ename, sal FROM emp where 1500 <= sal

-- 8. ������ SALESMAN�� ����� �����ȣ, �̸�, ������ �����´�.

	select empno, ename, job FROM emp WHERE job = 'SALESMAN'


-- 9. 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �����ȣ, �̸�, �Ի����� �����´�.




-- 10. 10�� �μ����� �ٹ��ϰ� �ִ� ������ MANAGER�� ����� �����ȣ, �̸�, �ٹ��μ�, ������ �����´�.

	SELECT empno, ename, deptno, job FROM EMP WHERE job = 'MANAGER' AND deptno =10


-- 11. �Ի�⵵�� 1981���� ����߿� �޿��� 1500 �̻��� ����� �����ȣ, �̸�, �޿�, �Ի����� �����´�. ***




-- 12. �޿��� 2000���� ũ�ų� 1000���� ���� ����� �����ȣ, �̸�, �޿��� �����´�.

	SELECT empno, ename, sal FROM EMP WHERE 1000 > sal OR 2000 < sal

-- 13. ������ CLERK, SALESMAN, ANALYST�� ����� �����ȣ, �̸�, ������ �����´�

SELECT empno, ename, job FROM emp WHERE job = 'CLERK' OR  job = 'SALESMAN' OR  job = 'ANALYST'

-- 14. ��� ��ȣ�� 7499, 7566, 7839�� �ƴ� ������� �����ȣ, �̸��� �����´�.

SELECT EMPNO, ENAME FROM EMP WHERE EMPNO != 7499 OR EMPNO != 7566 OR EMPNO != 7839
















