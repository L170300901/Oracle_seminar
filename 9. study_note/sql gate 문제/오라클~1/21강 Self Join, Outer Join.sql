-- SMITH ����� �����ȣ, �̸�, ���ӻ�� �̸��� �����´�.
-- a1 : SMITH ����� ����
-- a2 : ���ӻ���� ����
select a1.empno, a1.ename, a2.ename
from emp a1, emp a2
where a1.mgr = a2.empno and a1.ename = 'SMITH';

--  FORD ��� �ؿ��� ���ϴ� ������� �����ȣ, �̸�, ������ �����´�.
-- a1 : FORD�� ����
-- a2 : ���� ������ ����
select a2.empno, a2.ename, a2.job
from emp a1, emp a2
where a1.empno = a2.mgr and a1.ename='FORD';

--  SMITH ����� ���ӻ���� ������ ������ ������ �ִ� ������� �����ȣ, �̸�, ������ �����´�.
-- a1 : SMITH�� ����
-- a2 : SMITH�� ���ӻ�� ����
-- a3 : ���ӻ���� ������ ������ ������ �ִ� ������� ����
select a3.empno, a3.ename, a3.job
from emp a1, emp a2, emp a3
where a1.mgr = a2.empno and a2.job = a3.job and a1.ename='SMITH';

-- �� ����� �̸�, �����ȣ, ������ �̸��� �����´�. �� ���ӻ���� ���� ����� �����´�.
-- a1 : �� ����� ����
-- a2 : �������� ����
select a1.ename, a1.empno, a2.ename
from emp a1, emp a2
where a1.mgr = a2.empno(+);

-- ��� �μ��� �Ҽ� ����� �ٹ��μ���, �����ȣ, ����̸�, �޿��� �����´�.
select a2.dname, a1.empno, a1.ename, a1.sal
from emp a1, dept a2
where a1.deptno(+) = a2.deptno;










