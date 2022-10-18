��������������������������������������������������������������������������������������
4�� ������ ��ųʸ�
-- ���� ������ ������ ���̽����� ���̺��� ��ȸ�Ѵ�.

select * from tab;

-- ���ϴ� ���̺��� ������ ��ȸ�Ѵ�.
desc bonus;
��������������������������������������������������������������������������������������
6�� DML - Select �⺻ sql

--�μ��� ��� ������ �����´�.
select *
from dept;

--����� ��� ������ �����´�
select *
from emp;

--����� �̸��� ��� ��ȣ�� �����´�.
select ename, empno
from emp;

--����� �̸��� ��� ��ȣ, ����, �޿��� �����´�.
select ename, empno, job, sal
from emp;

--�μ� ��ȣ�� �μ� �̸��� �����´�.
select deptno, dname
from dept;


��������������������������������������������������������������������������������������
7�� DML ������ ����ϱ�.sql

-- �� ������� �޿��װ� �޿��׿��� 1000�� ���� ��, 200�� �� ��, 2�� ���� ��, 2�� ���� ���� �����´�.
select sal, sal + 1000, sal - 200, sal * 2, sal / 2
from emp;

-- �� ����� �޿���, Ŀ�̼�, �޿� + Ŀ�̼� �׼��� �����´�.
select sal, nvl(comm, 0), sal + nvl(comm, 0)
from emp;

-- ������� �̸��� ������ ���� ������� �����´�.
-- 000 ����� ��� ������ XXX �Դϴ�.
select ename, job
from emp;

select ename || '����� ��� ������ ' || job || '�Դϴ�'
from emp;

-- ������� �ٹ��ϰ� �ִ� �ٹ� �μ��� ��ȣ�� �����´�.
select distinct deptno
from emp;


��������������������������������������������������������������������������������������
8�� ������ ����ϱ�

--�ٹ� �μ��� 10���� ������� �����ȣ, �̸�, �ٹ� �μ��� �����´�.
select empno, ename, deptno
from emp
where deptno=10;

-- �ٹ� �μ� ��ȣ�� 10���� �ƴ� ������� �����ȣ, �̸�, �ٹ� �μ� ��ȣ�� �����´�.
select empno, ename, deptno
from emp
where deptno <> 10;

-- �޿��� 1500�̻��� ������� �����ȣ, �̸�, �޿��� �����´�.
select empno, ename, sal
from emp
where sal >= 1500;

-- �̸��� SCOTT ����� �����ȣ, �̸�, ����, �޿��� �����´�.
select empno, ename, job, sal
from emp
where ename='SCOTT';

-- ������ SALESMAN�� ����� �����ȣ, �̸�, ������ �����´�.
select empno, ename, job
from emp
where job = 'SALESMAN';

-- ������ CLERK�� �ƴ� ����� �����ȣ, �̸�, ������ �����´�.
select empno, ename, job
from emp
where job <> 'CLERK';

-- 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �����ȣ, �̸�, �Ի����� �����´�.
select empno, ename, hiredate
from emp
where hiredate >= '1982/01/01';

��������������������������������������������������������������������������������������
9�� �������� ����ϱ�

-- 10�� �μ����� �ٹ��ϰ� �ִ� ������ MANAGER�� ����� �����ȣ, �̸�, �ٹ��μ�, ������ �����´�.
select empno, ename, deptno, job
from emp
where deptno=10 and job='MANAGER';

-- �Ի�⵵�� 1981���� ����߿� �޿��� 1500 �̻��� ����� �����ȣ, �̸�, �޿�, �Ի����� �����´�. ***
select empno, ename, sal, hiredate
from emp
where hiredate >= '1981/01/01' and hiredate <= '1981/12/31' and sal >= 1500;

select empno, ename, sal, hiredate
from emp
where hiredate between '1981/01/01' and '1981/12/31' and sal >= 1500;

-- 20�� �μ��� �ٹ��ϰ� �ִ� ��� �߿� �޿��� 1500 �̻��� ����� �����ȣ, �̸�, �μ���ȣ, �޿��� �����´�.
select empno, ename, deptno, sal
from emp
where deptno=20 and sal >= 1500;

-- ���ӻ�� ��� ��ȣ�� 7698���� ����߿� ������ CLERK�� ����� �����ȣ, �̸�, ���ӻ����ȣ, ������ �����´�.
select empno, ename, mgr, job
from emp
where mgr=7698 and job='CLERK';

-- �޿��� 2000���� ũ�ų� 1000���� ���� ����� �����ȣ, �̸�, �޿��� �����´�.
select empno, ename, sal
from emp
where sal > 2000 or sal < 1000;

select empno, ename, sal
from emp
where not(sal >= 1000 and sal <= 2000);

select empno, ename, sal
from emp
where not(sal between 1000 and 2000);

-- �μ���ȣ�� 20�̰ų� 30�� ����� �����ȣ, �̸�, �μ���ȣ�� �����´�.
select empno, ename, deptno
from emp
where deptno = 20 or deptno = 30;

-- ������ CLERK, SALESMAN, ANALYST�� ����� �����ȣ, �̸�, ������ �����´�
select empno, ename, job
from emp
where job = 'CLERK' or job = 'SALESMAN' or job = 'ANALYST';

select empno, ename, job
from emp
where job in ('CLERK', 'SALESMAN', 'ANALYST');

-- ��� ��ȣ�� 7499, 7566, 7839�� �ƴ� ������� �����ȣ, �̸��� �����´�.
select empno, ename
from emp
where empno <> 7499 and empno <> 7566 and empno <> 7839;

select empno, ename
from emp
where not(empno = 7499 or empno = 7566 or empno = 7839);

select empno, ename
from emp
where not(empno in(7499, 7566, 7839));


��������������������������������������������������������������������������������������
10��	Like ������ ����ϱ�

-- �̸��� F�� �����ϴ� ����� �̸��� ��� ��ȣ�� �����´�.
select ename, empno
from emp
where ename like 'F%';

-- �̸��� S�� ������ ����� �̸��� ��� ��ȣ�� �����´�.
select ename, empno
from emp
where ename like '%S';

-- �̸��� A�� ���ԵǾ� �ִ� ����� �̸��� ��� ��ȣ�� �����´�.
select ename, empno
from emp
where ename like '%A%';

-- �̸��� �ι�° ���ڰ� A�� ����� ��� �̸�, ��� ��ȣ�� �����´�.
select ename, empno
from emp
where ename like '_A%';

-- �̸��� 4������ ����� ��� �̸�, ��� ��ȣ�� �����´�.
select ename, empno
from emp
where ename like '____';

��������������������������������������������������������������������������������������





























