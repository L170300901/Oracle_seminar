SELECT *FROM member;




01212/*
				★ 나만의 이번 과제 규칙 ★

				1. 출력시 가독성을 위해 소수점으로 나올경우 TRUNC함수를 사용해서 정수로 출력
				2. deptno 값을 출력할때 deptno로 order by 정렬해서 출력
        3. S_emp와 S_dept 테이블을 사용하지 않고 emp와 dept 테이블을 사용

*/

												--시작




-- 1. 각 부서별 사원들의 급여 평균을 구한다.

--SELECT * FROM emp;
--SELECT * FROM dept;


		--1) 부서번호만 출력 (흠 .. 근데 일케 하면 틀린거 같음)
SELECT deptno
     , TRUNC(AVG(sal)) sal_avg
  FROM EMP
 GROUP BY deptno
ORDER BY 1;

	/*          일케 하면 안되지 않을까?
  						왜냐하면
              >> dept 테이블에 'operations'부서가 있는데
                emp 테이블을 보면 'operations'부서에 근무하는 사람이 없다
                but 부서별로 구하라고 했으니 부서전체를  출력해야 겠지요? 아닌가??
  */


--어케 할지 생각하다가 join울 해야됨
--근데 구지  join 안해도 subquery 쓰면 될듯

		--2) 부서번호+부서이름 출력
    		--nvl 함수를 사용하지 않으면
        --operation부서에 평균값이 null이 나옴 null이 아니고 0이 나오기 위해 nvl함수 사용


SELECT d.deptno
     , d.dname
     , TRUNC(AVG(NVL(e.sal,0))) sal_avg
  FROM EMP e
     , DEPT d
 WHERE e.deptno(+)=d.deptno
 GROUP BY d.deptno
     ,d.dname
ORDER BY 1;


-- 2. 1500 이상 급여를 받는 사원들의 부서별 급여 평균을 구한다.


SELECT deptno
     , TRUNC(AVG(sal))
  FROM EMP
 WHERE sal >= 1500
 GROUP BY deptno
ORDER BY 1;


-- 3. 부서별 평균 급여가 2000이상인 부서의 급여 평균을 가져온다.


			--여기서부터 그냥 부서번호만 출력하겠습니다....

SELECT deptno
     , TRUNC(AVG(sal)) sal_avg
  FROM EMP
 GROUP BY deptno
HAVING AVG(sal)>=2000
ORDER BY 1;

-- 4. 부서별 최대 급여액이 3000이하인 부서의 급여 총합을 가져온다.


            /*
              SELECT * FROM emp
              ORDER BY sal DESC;
            */


SELECT deptno
     ,Sum(sal)
  FROM EMP
 GROUP BY deptno
HAVING Max(sal)<=3000
ORDER BY 1;


-- 5. 부서별 최소 급여액이 1000 이하인 부서에서 직무가 CLERK인 사원들의 급여 총합을 구한다.


SELECT deptno
     ,SUM(sal)
  FROM EMP
 WHERE job=UPPER('clerk')
 GROUP BY deptno
HAVING MIN(sal)<=1000
ORDER BY 1;


-- 6. 각 부서의 급여 최소가 900이상 최대가 10000이하인 부서의 사원들 중 1500이상의
-- 급여를 받는 사원들의 평균 급여액을 가져온다.


SELECT deptno
     ,TRUNC(AVG(sal)) sal_avg
  FROM EMP
 WHERE sal >= 1500
 GROUP BY deptno
HAVING MIN(sal) BETWEEN 900 AND 10000
ORDER BY 1;


-- 7. 사원의 사원번호, 이름, 근무지역을 가져온다.


SELECT e.EMPNO
     , e.ENAME
     , d.loc
  FROM EMP e
     , DEPT d
 WHERE e.DEPTNO = d.DEPTNO;


-- 8. DALLAS에 근무하고 있는 사원들의 사원번호, 이름, 직무를 가져온다.


SELECT e.EMPNO
     , e.ENAME
     , e.JOB
  FROM EMP e
     , DEPT d
 WHERE e.DEPTNO = d.DEPTNO
       AND d.LOC = UPPER('dallas');


-- 9. SALES 부서에 근무하고 있는 사원들의 급여 평균을 가져온다.


SELECT TRUNC(AVG(e.sal)) sal_avg
  FROM EMP e
     , DEPT d
 WHERE e.deptno=d.deptno
       AND d.dname=UPPER('sales')
 GROUP BY d.dname;


-- 10. 각 사원들의 사원번호, 이름, 급여, 급여등급을 가져온다.


SELECT e.empno
     , e.ename
     , e.sal
     , s.grade
  FROM EMP e
     , SALGRADE s
 WHERE e.sal>=s.losal
       AND e.sal<=s.hisal;


-- 11. SALES 부서에 근무하고 있는 사원의 사원번호, 이름, 급여등급을 가져온다.

SELECT e.empno
     , e.ename
     , s.grade
  FROM EMP e
     , SALGRADE s
     , DEPT d
 WHERE e.deptno(+)=d.deptno
       AND e.sal>=s.losal
       AND e.sal<=s.hisal
       AND d.dname= UPPER('sales');

-- 12. 각 급여 등급별 급여의 총합과 평균, 사원의수, 최대급여, 최소급여를 가져온다.


        /*
        SELECT e.empno
             , e.ename
             , e.sal
             , s.grade
          FROM EMP e
             , SALGRADE s
         WHERE e.sal>=s.losal
               AND e.sal<=s.hisal;
         */


SELECT s.grade
     ,SUM(sal) sal_sum
     , TRUNC(AVG(sal)) sal_avg
     , COUNT(*) emp_count
     , max(sal) sal_max
     , min(sal) sal_min
  FROM EMP e
     , SALGRADE s
 WHERE e.sal>=s.losal
       AND e.sal<=s.hisal
 GROUP BY s.grade
 ORDER BY 1;


-- 13. 급여 등급이 4등급인 사원들의 사원번호, 이름, 급여, 근무부서이름, 근무지역을 가져온다.


SELECT e.empno
     , e.ename
     , e.sal
     , d.dname
     , d.loc
  FROM EMP e
     , SALGRADE s
     , DEPT d
 WHERE e.sal>=s.losal
       AND e.sal<=s.hisal
       AND s.grade ='4'
       AND e.deptno=d.deptno;