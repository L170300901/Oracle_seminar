-- ����� �����ȣ, �̸�, �޿��� �����´�. �޿��� �������� �������� ������ �Ѵ�.
select empno, ename, sal
from emp
order by sal asc;

select empno, ename, sal
from emp
order by sal;

-- ����� �����ȣ, �̸�, �޿��� �����´�. �����ȣ�� �������� �������� ������ �Ѵ�.
select empno, ename, sal
from emp
order by empno desc;

-- ����� �����ȣ, �̸��� �����´�, ����� �̸��� �������� �������� ������ �Ѵ�.
select empno, ename
from emp
order by ename;

-- ����� �����ȣ, �̸�, �Ի����� �����´�. �Ի����� �������� �������� ������ �Ѵ�.
select empno, ename, hiredate
from emp
order by hiredate desc;

-- ������ SALESMAN�� ����� ����̸�, �����ȣ, �޿��� �����´�. �޿��� �������� �������� ������ �Ѵ�.
select ename, empno, sal
from emp
where job = 'SALESMAN'
order by sal;

-- 1981�⿡ �Ի��� ������� �����ȣ, ��� �̸�, �Ի����� �����´�. ��� ��ȣ�� �������� �������� ������ �Ѵ�.
select empno, ename, hiredate
from emp
where hiredate between '1981/01/01' and '1981/12/31'
order by empno desc;

-- ����� �̸�, �޿�, Ŀ�̼��� �����´�. Ŀ�̼��� �������� �������� ������ �Ѵ�.
select ename, sal, comm
from emp
order by comm;

-- ����� �̸�, �޿�, Ŀ�̼��� �����´�. Ŀ�̼��� �������� �������� ������ �Ѵ�.
select ename, sal, comm
from emp
order by comm desc;

-- ����� �̸�, �����ȣ, �޿��� �����´�. �޿��� �������� �������� ����, �̸��� �������� �������� ����
select ename, empno, sal
from emp
order by sal desc, ename asc;













