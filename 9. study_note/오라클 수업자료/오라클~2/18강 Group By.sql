-- �� �μ��� ������� �޿� ����� ���Ѵ�.
select deptno, avg(sal)
from emp
group by deptno;

-- �� ������ ������� �޿� ������ ���Ѵ�.
select job, sum(sal)
from emp
group by job;

-- 1500 �̻� �޿��� �޴� ������� �μ��� �޿� ����� ���Ѵ�.
select deptno, avg(sal)
from emp
where sal >= 1500
group by deptno;









