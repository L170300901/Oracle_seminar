�١ڡ١ڡ١ڡ١ڡ١ڡ١�
# �����߰�����. 
�׷��Լ��� �ٸ��÷��� ������°��� �Ұ����ϴ�.
�׷��Լ��� �ΰ��� �����ܽ�Ű�� ����� ���ش�.
trunc = �Ҽ��� ����.

�١ڡ١ڡ١ڡ١ڡ١ڡ١ڡ١ڡ١�
#�𸣴��Լ�



-- ������� �޿� ������ ���Ѵ�.
select sum(sal)
from emp;

-- ������� Ŀ�̼��� �����´�.
select sum(comm)
from emp;

-- �޿��� 1500 �̻��� ������� �޿� ������ ���Ѵ�.
select sum(sal)
from emp
where sal >= 1500;

-- 20�� �μ��� �ٺ��ϰ� �ִ� ������� �޿� ������ ���Ѵ�.
select sum(sal)
from emp
where deptno=20;

-- ������ SALESMAN�� ������� �޿� ������ ���Ѵ�.
select sum(sal)
from emp
where job = 'SALESMAN';

-- ������ SALESMAN�� ������� �̸��� �޿������� �����´�.
select ename, sum(sal)
from emp
where job = 'SALESMAN';

-- �� ����� �޿� ����� ���Ѵ�.
select trunc(avg(sal))
from emp;

-- Ŀ�̼��� �޴� ������� Ŀ�̼� ����� ���Ѵ�.**?
select trunc(avg(comm))
from emp;

-- �� ����� Ŀ�̼��� ����� ���Ѵ�.
select trunc(avg(nvl(comm, 0)))
from emp;

--  Ŀ�̼��� �޴� ������� �޿� ����� ���Ѵ�.
select trunc(avg(sal))
from emp
where comm is not null;

-- 30�� �μ��� �ٹ��ϰ� �ִ� ������� �޿� ����� ���Ѵ�.
select trunc(avg(sal))
from emp
where deptno  = 30;

-- ������ SALESMAN�� ������� �޿� + Ŀ�̼� ����� ���Ѵ�.
select avg(sal + comm)
from emp
where job = 'SALESMAN';

-- ������� �� ���� �����´�.
select count(empno)
from emp;

select count(*)
from emp;

-- Ŀ�̼��� �޴� ������� �� ���� �����´�.
select count(comm)
from emp;

-- ������� �޿� �ִ�, �ּҰ��� �����´�.
select max(sal), min(sal)
from emp;












