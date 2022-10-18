-- �μ��� ��� �޿��� 2000�̻��� �μ��� �޿� ����� �����´�.

select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 2000;

-- �μ��� �ִ� �޿����� 3000������ �μ��� �޿� ������ �����´�.
select sum(sal)
from emp
group by deptno
having max(sal) <= 3000;

-- �μ��� �ּ� �޿����� 1000 ������ �μ����� ������ CLERK�� ������� �޿� ������ ���Ѵ�.
select sum(sal)
from emp
where job = 'CLERK'
group by deptno
having min(sal) <= 1000;

-- �� �μ��� �޿� �ּҰ� 900�̻� �ִ밡 10000������ �μ��� ����� �� 1500�̻��� 
-- �޿��� �޴� ������� ��� �޿����� �����´�.

select avg(sal)
from emp
where sal >= 1500
group by deptno
having min(sal) >= 900 and max(sal) <= 10000;










