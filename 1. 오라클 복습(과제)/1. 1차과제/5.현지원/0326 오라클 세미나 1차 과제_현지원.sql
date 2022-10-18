-- 1. emp 테이블의 구조를 조회.(특정명령문)
	select * from emp;

-- 2. 부서의 모든 정보를 가져온다.
	SELECT * FROM S_EMP;

-- 3. 각 사원들의 급여액과 급여액에서 1000을 더한 값, 200을 뺀 값, 2를 곱한 값, 2로 나눈 값을 가져온다.
	SELECT ename, empno, salary  FROM EMP, s_EMP;
	SELECT ename, empno, salary+1000  FROM EMP, s_EMP;
	SELECT ename, empno, salary-200  FROM EMP, s_EMP;
	SELECT ename, empno, salary*2  FROM EMP, s_EMP;
	SELECT ename, empno, salary/2  FROM EMP, s_EMP;

-- 4. 각 사원의 급여액, 커미션, 급여 + 커미션 액수를 가져온다.
	SELECT ename, empno, salary, comm, salary+comm  FROM EMP, s_EMP;

-- 5. 사원들의 이름과 직무를 다음 양식으로 가져온다.
-- 000 사원의 담당 직무는 XXX 입니다.
	SELECT  last_name||first_name AS fullname,  job FROM EMP, S_EMP;



-- 7. 급여가 1500이상인 사원들의 사원번호, 이름, 급여를 가져온다.
	SELECT empno, last_name||first_name AS fullname, salary FROM  emp, S_EMP
	WHERE salary>=1500;

-- 8. 직무가 SALESMAN인 사원의 사원번호, 이름, 직무를 가져온다.
	SELECT ename, empno, job FROM EMP
	WHERE job = 'SALESMAN';

-- 9. 1982년 1월 1일 이후에 입사한 사원의 사원번호, 이름, 입사일을 가져온다.
	Alter session set NLS_DATE_FORMAT='RRRR/MM/DD HH24:MI:SS';
	SELECT ename, empno, hiredate FROM EMP
	WHERE hiredate >= '1982/01/01' ;

-- 10. 10번 부서에서 근무하고 있는 직무가 MANAGER인 사원의 사원번호, 이름, 근무부서, 직무를 가져온다.
	SELECT ename, empno, job, deptno FROM emp
	WHERE deptno=10 AND job='MANAGER';

-- 11. 입사년도가 1981년인 사원중에 급여가 1500 이상인 사원의 사원번호, 이름, 급여, 입사일을 가져온다. ***
	SELECT empno, ename, sal, hiredate FROM EMP
	WHERE sal>=1500 AND hiredate>='1981/01/01' AND hiredate<= '1981/12/31';

-- 12. 급여가 2000보다 크거나 1000보다 작은 사원의 사원번호, 이름, 급여를 가져온다.
	SELECT empno, ename, sal FROM EMP
	WHERE sal>2000 AND sal<1000;

-- 13. 직무가 CLERK, SALESMAN, ANALYST인 사원의 사원번호, 이름, 직무를 가져온다
	SELECT empno, ename, job FROM EMP
	WHERE job='clerk' OR  job='salesman' OR  job='analyst' ;

-- 14. 사원 번호가 7499, 7566, 7839가 아닌 사원들의 사원번호, 이름을 가져온다.


















