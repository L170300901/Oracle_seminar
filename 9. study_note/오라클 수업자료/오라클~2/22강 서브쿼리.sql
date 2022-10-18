-- SCOTT 사원이 근무하고 있는 부서의 이름을 가져온다.
select dname
from dept
where deptno = (select deptno
                from emp
                where ename = 'SCOTT');

select a2.dname
from emp a1, dept a2
where a1.deptno = a2.deptno and a1.ename = 'SCOTT';

-- SMITH와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 급여액, 부서이름을 가져온다.
select a1.empno, a1.ename, a1.sal, a2.dname
from emp a1, dept a2
where a1.deptno = a2.deptno and a1.deptno = (select deptno
                                             from emp
                                             where ename = 'SMITH');

-- MARTIN과 같은 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
select empno, ename, job
from emp
where job = (select job
             from emp
             where ename = 'MARTIN');

-- ALLEN과 같은 직속상관을 가진 사원들의 사원번호, 이름, 직속상관이름을 가져온다.
-- a1 : 사원의 정보
-- a2 : 직속상관 정보
select a1.empno, a1.ename, a2.ename
from emp a1, emp a2
where a1.mgr = a2.empno and a1.mgr = (select mgr
                                      from emp
                                      where ename='ALLEN');

-- WARD와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 부서번호를 가져온다.
select empno, ename, deptno
from emp
where deptno = (select deptno
                from emp
                where ename='WARD');

-- SALESMAN의 평균 급여보다 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.
select empno, ename, sal
from emp
where sal > (select avg(sal)
             from emp
             where job = 'SALESMAN');
             
-- DALLAS 지역에 근무하는 사원들의 평균 급여를 가져온다.
select trunc(avg(sal))
from emp
where deptno = (select deptno
                from dept
                where loc='DALLAS');

--  SALES 부서에 근무하는 사원들의 사원번호, 이름, 근무지역을 가져온다.
select a1.empno, a1.ename, a2.loc
from emp a1, dept a2
where a1.deptno = a2.deptno and a1.deptno = (select deptno
                                            from dept
                                            where dname='SALES');

-- CHICAGO 지역에 근무하는 사원들 중 BLAKE이 직속상관인 사원들의 사원번호, 이름, 직무를 가져온다.	
select empno, ename, job
from emp
where deptno = (select deptno
                from dept
                where loc='CHICAGO') 
      and mgr = (select empno
                 from emp
                 where ename='BLAKE');
















