───────────────────────────────────────────
4강 데이터 딕셔너리
-- 현재 접속한 데이터 베이스내의 테이블을 조회한다.

select * from tab;

-- 원하는 테이블의 구조를 조회한다.
desc bonus;
───────────────────────────────────────────
6강 DML - Select 기본 sql

--부서의 모든 정보를 가져온다.
select *
from dept;

--사원의 모든 정보를 가져온다
select *
from emp;

--사원의 이름과 사원 번호를 가져온다.
select ename, empno
from emp;

--사원의 이름과 사원 번호, 직무, 급여를 가져온다.
select ename, empno, job, sal
from emp;

--부서 번호와 부서 이름을 가져온다.
select deptno, dname
from dept;


───────────────────────────────────────────
7강 DML 연산자 사용하기.sql

-- 각 사원들의 급여액과 급여액에서 1000을 더한 값, 200을 뺀 값, 2를 곱한 값, 2로 나눈 값을 가져온다.
select sal, sal + 1000, sal - 200, sal * 2, sal / 2
from emp;

-- 각 사원의 급여액, 커미션, 급여 + 커미션 액수를 가져온다.
select sal, nvl(comm, 0), sal + nvl(comm, 0)
from emp;

-- 사원들의 이름과 직무를 다음 양식으로 가져온다.
-- 000 사원의 담당 직무는 XXX 입니다.
select ename, job
from emp;

select ename || '사원의 담당 직무는 ' || job || '입니다'
from emp;

-- 사원들이 근무하고 있는 근무 부서의 번호를 가져온다.
select distinct deptno
from emp;


───────────────────────────────────────────
8강 조건절 사용하기

--근무 부서가 10번인 사원들의 사원번호, 이름, 근무 부서를 가져온다.
select empno, ename, deptno
from emp
where deptno=10;

-- 근무 부서 번호가 10번이 아닌 사원들의 사원번호, 이름, 근무 부서 번호를 가져온다.
select empno, ename, deptno
from emp
where deptno <> 10;

-- 급여가 1500이상인 사원들의 사원번호, 이름, 급여를 가져온다.
select empno, ename, sal
from emp
where sal >= 1500;

-- 이름이 SCOTT 사원의 사원번호, 이름, 직무, 급여를 가져온다.
select empno, ename, job, sal
from emp
where ename='SCOTT';

-- 직무가 SALESMAN인 사원의 사원번호, 이름, 직무를 가져온다.
select empno, ename, job
from emp
where job = 'SALESMAN';

-- 직무가 CLERK이 아닌 사원의 사원번호, 이름, 직무를 가져온다.
select empno, ename, job
from emp
where job <> 'CLERK';

-- 1982년 1월 1일 이후에 입사한 사원의 사원번호, 이름, 입사일을 가져온다.
select empno, ename, hiredate
from emp
where hiredate >= '1982/01/01';

───────────────────────────────────────────
9강 논리연산자 사용하기

-- 10번 부서에서 근무하고 있는 직무가 MANAGER인 사원의 사원번호, 이름, 근무부서, 직무를 가져온다.
select empno, ename, deptno, job
from emp
where deptno=10 and job='MANAGER';

-- 입사년도가 1981년인 사원중에 급여가 1500 이상인 사원의 사원번호, 이름, 급여, 입사일을 가져온다. ***
select empno, ename, sal, hiredate
from emp
where hiredate >= '1981/01/01' and hiredate <= '1981/12/31' and sal >= 1500;

select empno, ename, sal, hiredate
from emp
where hiredate between '1981/01/01' and '1981/12/31' and sal >= 1500;

-- 20번 부서에 근무하고 있는 사원 중에 급여가 1500 이상인 사원의 사원번호, 이름, 부서번호, 급여를 가져온다.
select empno, ename, deptno, sal
from emp
where deptno=20 and sal >= 1500;

-- 직속상관 사원 번호가 7698번인 사원중에 직무가 CLERK인 사원의 사원번호, 이름, 직속상관번호, 직무를 가져온다.
select empno, ename, mgr, job
from emp
where mgr=7698 and job='CLERK';

-- 급여가 2000보다 크거나 1000보다 작은 사원의 사원번호, 이름, 급여를 가져온다.
select empno, ename, sal
from emp
where sal > 2000 or sal < 1000;

select empno, ename, sal
from emp
where not(sal >= 1000 and sal <= 2000);

select empno, ename, sal
from emp
where not(sal between 1000 and 2000);

-- 부서번호가 20이거나 30인 사원의 사원번호, 이름, 부서번호를 가져온다.
select empno, ename, deptno
from emp
where deptno = 20 or deptno = 30;

-- 직무가 CLERK, SALESMAN, ANALYST인 사원의 사원번호, 이름, 직무를 가져온다
select empno, ename, job
from emp
where job = 'CLERK' or job = 'SALESMAN' or job = 'ANALYST';

select empno, ename, job
from emp
where job in ('CLERK', 'SALESMAN', 'ANALYST');

-- 사원 번호가 7499, 7566, 7839가 아닌 사원들의 사원번호, 이름을 가져온다.
select empno, ename
from emp
where empno <> 7499 and empno <> 7566 and empno <> 7839;

select empno, ename
from emp
where not(empno = 7499 or empno = 7566 or empno = 7839);

select empno, ename
from emp
where not(empno in(7499, 7566, 7839));


───────────────────────────────────────────
10강	Like 연산자 사용하기

-- 이름이 F로 시작하는 사원의 이름과 사원 번호를 가져온다.
select ename, empno
from emp
where ename like 'F%';

-- 이름이 S로 끝나는 사원의 이름과 사원 번호를 가져온다.
select ename, empno
from emp
where ename like '%S';

-- 이름에 A가 포함되어 있는 사원의 이름과 사원 번호를 가져온다.
select ename, empno
from emp
where ename like '%A%';

-- 이름의 두번째 글자가 A인 사원의 사원 이름, 사원 번호를 가져온다.
select ename, empno
from emp
where ename like '_A%';

-- 이름이 4글자인 사원의 사원 이름, 사원 번호를 가져온다.
select ename, empno
from emp
where ename like '____';

───────────────────────────────────────────





























