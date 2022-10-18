-- 사원의 사원번호, 이름, 급여를 가져온다. 급여를 기준으로 오름차순 정렬을 한다.
select empno, ename, sal
from emp
order by sal asc;

select empno, ename, sal
from emp
order by sal;

-- 사원의 사원번호, 이름, 급여를 가져온다. 사원번호를 기준으로 내림차순 정렬을 한다.
select empno, ename, sal
from emp
order by empno desc;

-- 사원의 사원번호, 이름을 가져온다, 사원의 이름을 기준으로 오름차순 정렬을 한다.
select empno, ename
from emp
order by ename;

-- 사원의 사원번호, 이름, 입사일을 가져온다. 입사일을 기준으로 내림차순 정렬을 한다.
select empno, ename, hiredate
from emp
order by hiredate desc;

-- 직무가 SALESMAN인 사원의 사원이름, 사원번호, 급여를 가져온다. 급여를 기준으로 오름차순 정렬을 한다.
select ename, empno, sal
from emp
where job = 'SALESMAN'
order by sal;

-- 1981년에 입사한 사원들의 사원번호, 사원 이름, 입사일을 가져온다. 사원 번호를 기준으로 내림차순 정렬을 한다.
select empno, ename, hiredate
from emp
where hiredate between '1981/01/01' and '1981/12/31'
order by empno desc;

-- 사원의 이름, 급여, 커미션을 가져온다. 커미션을 기준으로 오름차순 정렬을 한다.
select ename, sal, comm
from emp
order by comm;

-- 사원의 이름, 급여, 커미션을 가져온다. 커미션을 기준으로 내림차순 정렬을 한다.
select ename, sal, comm
from emp
order by comm desc;

-- 사원의 이름, 사원번호, 급여를 가져온다. 급여를 기준으로 내림차순 정렬, 이름을 기준으로 오름차순 정렬
select ename, empno, sal
from emp
order by sal desc, ename asc;













