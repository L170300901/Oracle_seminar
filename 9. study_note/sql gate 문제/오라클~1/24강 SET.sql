-- 10�� �μ��� �ٹ��ϰ� �ִ� ����� �����ȣ, �̸�, ����, �ٹ��μ� ��ȣ
select empno, ename, job, deptno
from emp
where deptno=10;

-- ������ CLERK�� ����� �����ȣ, �̸�, ����, �ٹ��μ� ��ȣ
select empno, ename, job, deptno
from emp
where job = 'CLERK';

-- UNION
select empno, ename, job, deptno
from emp
where deptno=10
union
select empno, ename, job, deptno
from emp
where job = 'CLERK';

-- UNION ALL
select empno, ename, job, deptno
from emp
where deptno=10
union all
select empno, ename, job, deptno
from emp
where job = 'CLERK';

-- INTERSECT 
select empno, ename, job, deptno
from emp
where deptno=10
intersect
select empno, ename, job, deptno
from emp
where job = 'CLERK';

-- MINUS
select empno, ename, job, deptno
from emp
where deptno=10
minus
select empno, ename, job, deptno
from emp
where job = 'CLERK';
















