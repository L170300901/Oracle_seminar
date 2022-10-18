☆★☆★☆★☆★☆★☆★
# 개념추가설명. 
그룹함수와 다른컬럼을 섞어서쓰는것은 불가능하다.
그룹함수는 널값은 다제외시키고 계산을 해준다.
trunc = 소수점 생략.

☆★☆★☆★☆★☆★☆★☆★☆★
#모르는함수



-- 사원들의 급여 총합을 구한다.
select sum(sal)
from emp;

-- 사원들의 커미션을 가져온다.
select sum(comm)
from emp;

-- 급여가 1500 이상인 사원들의 급여 총합을 구한다.
select sum(sal)
from emp
where sal >= 1500;

-- 20번 부서에 근부하고 있는 사원들의 급여 총합을 구한다.
select sum(sal)
from emp
where deptno=20;

-- 직무가 SALESMAN인 사원들의 급여 총합을 구한다.
select sum(sal)
from emp
where job = 'SALESMAN';

-- 직무가 SALESMAN인 사원들의 이름과 급여총합을 가져온다.
select ename, sum(sal)
from emp
where job = 'SALESMAN';

-- 전 사원의 급여 평균을 구한다.
select trunc(avg(sal))
from emp;

-- 커미션을 받는 사원들의 커미션 평균을 구한다.**?
select trunc(avg(comm))
from emp;

-- 전 사원의 커미션의 평균을 구한다.
select trunc(avg(nvl(comm, 0)))
from emp;

--  커미션을 받는 사원들의 급여 평균을 구한다.
select trunc(avg(sal))
from emp
where comm is not null;

-- 30번 부서에 근무하고 있는 사원들의 급여 평균을 구한다.
select trunc(avg(sal))
from emp
where deptno  = 30;

-- 직무가 SALESMAN인 사원들의 급여 + 커미션 평균을 구한다.
select avg(sal + comm)
from emp
where job = 'SALESMAN';

-- 사원들의 총 수를 가져온다.
select count(empno)
from emp;

select count(*)
from emp;

-- 커미션을 받는 사원들의 총 수를 가져온다.
select count(comm)
from emp;

-- 사원들의 급여 최대, 최소값을 가져온다.
select max(sal), min(sal)
from emp;












