-- 3000 이상의 급여를 받는 사원들과 같은 부서에 근무하고 있는 사원의 사원번호, 이름, 급여를 가져온다
select empno, ename, sal
from emp
where deptno in (select deptno
                from emp
                where sal >= 3000);
                
-- 직무가 CLERK인 사원과 동일한 부서에 근무하고 있는 사원들의 사원번호, 이름, 입사일 가져온다.
select empno, ename, hiredate
from emp
where deptno in (select deptno
                    from emp
                    where job = 'CLERK');

-- KING을 직속상관으로 가지고 있는 사원들이 근무하고 있는 근무 부서명, 지역을 가지고온다.
select dname, loc
from dept
where deptno in (select deptno
                from emp
                where mgr = (select empno
                            from emp
                            where ename = 'KING'));

--  CLERK들의 직속상관의 사원번호, 이름, 급여를 가져온다.
select empno, ename, sal
from emp
where empno in (select mgr
                from emp
                where job = 'CLERK');

-- 각 부서별 급여 평균보다 더 많이 받는 사원의 사원번호, 이름, 급여를 가져온다.
select empno, ename, sal
from emp
where sal > all (select avg(sal)
                from emp
                group by deptno);

select empno, ename, sal
from emp
where sal > (select max(avg(sal))
                from emp
                group by deptno);
                
--  각 부서별 급여 최저치보다 더 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.
select empno, ename, sal
from emp
where sal > all (select min(sal)
                from emp
                group by deptno);

select empno, ename, sal
from emp
where sal >  (select max(min(sal))
                from emp
                group by deptno);
                
-- SALESMAN 보다 급여를 적게 받는 사원들의 사원번호, 이름, 급여를 가져온다.
select empno, ename, sal
from emp
where sal < all (select sal
                from emp
                where job = 'SALESMAN');
                
select empno, ename, sal
from emp
where sal <  (select min(sal)
                from emp
                where job = 'SALESMAN');

-- 각 부서별 최저 급여 액수보다 많이 받는 사원들이 사원번호, 이름, 급여를 가져온다.

select empno, ename, sal
from emp
where sal > any (select min(sal)
                from emp
                group by deptno);

-- DALLAS에 근무하고 있는 사원들 중 가장 나중에 입사한 사원의 입사 날짜보다 더 먼저 입사한 
-- 사원들의 사원번호, 이름, 입사일을 가져온다.

select empno, ename hiredate
from emp 
where hiredate < any (select hiredate
                    from emp
                    where deptno = (select deptno
                                    from dept
                                    where loc='DALLAS'));










