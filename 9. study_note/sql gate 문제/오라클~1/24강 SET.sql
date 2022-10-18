-- 10번 부서에 근무하고 있는 사원의 사원번호, 이름, 직무, 근무부서 번호
select empno, ename, job, deptno
from emp
where deptno=10;

-- 직무가 CLERK인 사원의 사원번호, 이름, 직무, 근무부서 번호
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
















