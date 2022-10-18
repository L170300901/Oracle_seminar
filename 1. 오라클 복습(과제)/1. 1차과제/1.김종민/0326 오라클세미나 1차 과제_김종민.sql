-- 1. emp 테이블의 구조를 조회.(특정명령문)

DESC EMP;


-- 2. 부서의 모든 정보를 가져온다.

SELECT * FROM DEPT;


-- 3. 각 사원들의 급여액과 급여액에서 1000을 더한 값, 200을 뺀 값, 2를 곱한 값, 2로 나눈 값을 가져온다.

SELECT ENAME, SAL FROM EMP;  -- 사원이름, 급여
SELECT ENAME, SAL+1000 FROM EMP; --칼럼명이 SAL+1000으로 표기.
SELECT ENAME, SAL-200 FROM EMP;
SELECT ENAME, SAL*2 FROM EMP;
SELECT ENAME, SAL/2 FROM EMP;


-- 4. 각 사원의 급여액, 커미션, 급여 + 커미션 액수를 가져온다.

SELECT ENMAE, SAL FROM EMP;
SELECT ENAME, COMM FROM EMP;
SELECT ENAME, SAL+NVL(COMM,0) FROM EMP;


-- 5. 사원들의 이름과 직무를 다음 양식으로 가져온다.
-- 000 사원의 담당 직무는 XXX 입니다.

SELECT ENAME || '사원의 담당 직무는 ' || JOB "별칭되나?"   FROM EMP;
SELECT ENAME || '사원의 담당 직무는 ' || JOB || '입니다' ||   FROM EMP;
입니다 왜 안돼누...


-- 6. 사원들이 근무하고 있는 근무 부서의 번호를 가져온다.
--(근무하고 있는 부서번호이기 때문에 dept 테이블에 조회하지 않고 emp테이블에서 조회한다)
--(단, 부서번호는 중복으로 나오지않고 한번만 나온다.)

SELECT DISTINCT DEPTNO FROM EMP;


-- 7. 급여가 1500이상인 사원들의 사원번호, 이름, 급여를 가져온다.

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL>=1500;


-- 8. 직무가 SALESMAN인 사원의 사원번호, 이름, 직무를 가져온다.
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE SAL=???

-- 9. 1982년 1월 1일 이후에 입사한 사원의 사원번호, 이름, 입사일을 가져온다.

SELECT EMPNO, ENMAE, HIREDATE
FROM EMP
WHERE HIREDATE>='???'

-- 10. 10번 부서에서 근무하고 있는 직무가 MANAGER인 사원의 사원번호, 이름, 근무부서, 직무를 가져온다.

SELECT EMPNO, ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO=10 AND JOB='MANAGER'

-- 11. 입사년도가 1981년인 사원중에 급여가 1500 이상인 사원의 사원번호, 이름, 급여, 입사일을 가져온다. ***
SELECT EMPNO, ENMAE, SAL, HIREDATE
FROM EMP
WHERE HIREDATE>='???' AND SAL>=1500

-- 12. 급여가 2000보다 크거나 1000보다 작은 사원의 사원번호, 이름, 급여를 가져온다.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL>=2000 OR SAL<=1000

-- 13. 직무가 CLERK, SALESMAN, ANALYST인 사원의 사원번호, 이름, 직무를 가져온다
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE JOB IN('CLEREK', 'SALESMAN', 'ANALYT')

-- 14. 사원 번호가 7499, 7566, 7839가 아닌 사원들의 사원번호, 이름을 가져온다.
???



















