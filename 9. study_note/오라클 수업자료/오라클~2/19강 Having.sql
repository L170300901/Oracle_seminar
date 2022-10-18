-- 부서별 평균 급여가 2000이상인 부서의 급여 평균을 가져온다.

select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 2000;

-- 부서별 최대 급여액이 3000이하인 부서의 급여 총합을 가져온다.
select sum(sal)
from emp
group by deptno
having max(sal) <= 3000;

-- 부서별 최소 급여액이 1000 이하인 부서에서 직무가 CLERK인 사원들의 급여 총합을 구한다.
select sum(sal)
from emp
where job = 'CLERK'
group by deptno
having min(sal) <= 1000;

-- 각 부서의 급여 최소가 900이상 최대가 10000이하인 부서의 사원들 중 1500이상의 
-- 급여를 받는 사원들의 평균 급여액을 가져온다.

select avg(sal)
from emp
where sal >= 1500
group by deptno
having min(sal) >= 900 and max(sal) <= 10000;










