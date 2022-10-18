-- 사원테이블(emp)과 부서테이블(dept)을 join 한다.
select * from emp;

select * from dept;

select * 
from emp a1, dept a2
where a1.deptno = a2.deptno;

-- 사원의 사원번호, 이름, 근무부서 이름을 가져온다.

select a1.empno, a1.ename, a2.dname
from emp a1, dept a2
where a1.deptno = a2.deptno;

-- 사원의 사원번호, 이름, 근무지역을 가져온다.
select a1.empno, a1.ename, a2.loc
from emp a1, dept a2
where a1.deptno = a2.deptno;

-- DALLAS에 근무하고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
select a1.empno, a1.ename, a1.job
from emp a1, dept a2
where a1.deptno = a2.deptno and a2.loc = 'DALLAS';

-- SALES 부서에 근무하고 있는 사원들의 급여 평균을 가져온다.
select avg(sal)
from emp a1, dept a2
where a1.deptno = a2.deptno and a2.dname='SALES';

-- 1982년에 입사한 사원들의 사원번호, 이름, 입사일, 근무부서이름을 가져온다.
select a1.empno, a1.ename, a1.hiredate, a2.dname
from emp a1, dept a2
where a1.deptno = a2.deptno and a1.hiredate between '1982/01/01' and '1982/12/31';

-- 각 사원들의 사원번호, 이름, 급여, 급여등급을 가져온다.
select a1.empno, a1.ename, a1.sal, a2.grade
from emp a1, salgrade a2
where a1.sal between a2.losal and a2.hisal;

-- SALES 부서에 근무하고 있는 사원의 사원번호, 이름, 급여등급을 가져온다.
select a1.empno, a1.ename, a2.grade
from emp a1, salgrade a2, dept a3
where a1.sal between a2.losal and a2.hisal and a1.deptno = a3.deptno
      and a3.dname = 'SALES';
      
-- 각 급여 등급별 급여의 총합과 평균, 사원의수, 최대급여, 최소급여를 가져온다.
select sum(a1.sal), trunc(avg(a1.sal)), count(a1.sal), max(a1.sal), min(a1.sal)
from emp a1, salgrade a2
where a1.sal between a2.losal and a2.hisal
group by a2.grade;

-- 급여 등급이 4등급인 사원들의 사원번호, 이름, 급여, 근무부서이름, 근무지역을 가져온다.
select a1.empno, a1.ename, a1.sal, a3.dname, a3.loc
from emp a1, salgrade a2, dept a3
where a1.sal between a2.losal and a2.hisal and a1.deptno=a3.deptno
      and a2.grade = 4;










