-- 각 부서별 사원들의 급여 평균을 구한다.
select deptno, avg(sal)
from emp
group by deptno;

-- 각 직무별 사원들의 급여 총합을 구한다.
select job, sum(sal)
from emp
group by job;

-- 1500 이상 급여를 받는 사원들의 부서별 급여 평균을 구한다.
select deptno, avg(sal)
from emp
where sal >= 1500
group by deptno;









