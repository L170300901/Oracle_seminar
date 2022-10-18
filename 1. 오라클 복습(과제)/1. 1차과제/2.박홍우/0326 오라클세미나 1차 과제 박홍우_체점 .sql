-- 1. emp 테이블의 구조를 조회.(특정명령문)

	SELECT * from emp

-- 2. 부서의 모든 정보를 가져온다.

	SELECT * from emp

-- 3. 각 사원들의 급여액과 급여액에서 1000을 더한 값, 200을 뺀 값, 2를 곱한 값, 2로 나눈 값을 가져온다.

	SELECT sal from EMP
	SELECT sal + 1000 from EMP
	SELECT sal - 200 from EMP
	SELECT sal * 2 from EMP
	SELECT sal / 2 from EMP

-- 4. 각 사원의 급여액, 커미션, 급여 + 커미션 액수를 가져온다.

	SELECT sal , comm, sal+comm FROM emp

-- 5. 사원들의 이름과 직무를 다음 양식으로 가져온다.
-- 000 사원의 담당 직무는 XXX 입니다.


-- 6. 사원들이 근무하고 있는 근무 부서의 번호를 가져온다.
--(근무하고 있는 부서번호이기 때문에 dept 테이블에 조회하지 않고 emp테이블에서 조회한다)
--(단, 부서번호는 중복으로 나오지않고 한번만 나온다.)

-- 9. 1982년 1월 1일 이후에 입사한 사원의 사원번호, 이름, 입사일을 가져온다.

-- 11. 입사년도가 1981년인 사원중에 급여가 1500 이상인 사원의 사원번호, 이름, 급여, 입사일을 가져온다. ***

-- 14. 사원 번호가 7499, 7566, 7839가 아닌 사원들의 사원번호, 이름을 가져온다.

SELECT EMPNO, ENAME FROM EMP WHERE EMPNO != 7499 OR EMPNO != 7566 OR EMPNO != 7839
















