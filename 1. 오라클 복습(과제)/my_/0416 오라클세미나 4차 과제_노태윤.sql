
-- 1. SMITH 사원의 사원번호, 이름, 직속상관 이름을 가져온다.


    --1) 서브쿼리 사용
SELECT e.empno
     ,e.ename
     ,   m.ename m_ename
  FROM EMP m
     ,
       (SELECT *
         FROM EMP
        WHERE ename=UPPER('smith')
       ) e
 WHERE m.empno IN
       (SELECT e.mgr
         FROM EMP e
        WHERE e.ename=UPPER('smith')
       );


 		--2) join 사용
SELECT e.empno
     , e.ename
     , m.ename m_ename
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND e.ename=UPPER('smith');


-- 2. FORD 사원 밑에서 일하는 사원들의 사원번호, 이름, 직무를 가져온다.


    --1) 서브쿼리 사용
SELECT e.empno
     ,e.ename
     , e.job
  FROM EMP e
 WHERE e.mgr IN
       (SELECT m.empno
         FROM EMP m
        WHERE m.ename=UPPER('ford')
       );


 		--2)join 사용
SELECT e.empno
     , e.ename
     , e.job
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND m.ename=UPPER('ford');


-- 3. SMITH 사원의 직속상관과 동일한 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.


 --1) 서브쿼리 사용
SELECT f.empno
     , f.ename
     , f.job
  FROM EMP f
 WHERE f.job IN
       (SELECT m.job
         FROM EMP m
        WHERE m.empno IN
              (SELECT e.mgr
                FROM EMP e
               WHERE e.ename=UPPER('smith')
              )
       );


 		--2) join 사용
SELECT f.empno
     , f.ename
     , f.job
  FROM EMP f
 WHERE f.job IN
       (SELECT m.job
         FROM EMP e
            , EMP m
        WHERE e.mgr=m.empno
              AND e.ename=UPPER('smith')
       );


-- 4. 각 사원의 이름, 사원번호, 직장상사 이름을 가져온다. 단 직속상관이 없는 사원도 가져온다.

		--문제가 좀 애매한거 같다고 생각이 듬 .. 상사가 없는 사람도  사원이라고 하나요?
    --직장 상사라는 말이 또 애매함..
    --> 1.직속상사를 구하시오
    --> 2. 직장상사를 구하시오
    --두개의 값이 다름


    --1) 직장상사를 구하시오

			--시간 남으면 풀자.. 풀수 있을거 같음.. 근데 좀 많이 복잡할듯 오래 걸릴거 같음
/*
SELECT e.empno
     , e.ename
     , m.ename m_ename
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND e.ename IN
       (SELECT m.ename
         FROM EMP e
            , EMP m
        WHERE e.mgr=m.empno
       );
 */

 		--2) 직속상사를 구하시오
SELECT e.empno
     , e.ename
     , m.ename m_ename
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno(+);


-- 5. 모든 부서의 소속 사원의 근무부서명, 사원번호, 사원이름, 급여를 가져온다.


SELECT d.dname
     ,e.empno
     ,e.ename
     ,e.sal
  FROM DEPT d
     , EMP e
 WHERE d.deptno=e.deptno;


-- 6. SCOTT 사원이 근무하고 있는 부서의 이름을 가져온다.


		--1) 서브쿼리 이용
SELECT dname
  FROM DEPT
 WHERE DEPTNO =
       (SELECT e.deptno
         FROM EMP e
        WHERE e.ename=UPPER('scott')
       );


		--2) join 이용
SELECT d.dname
  FROM DEPT d
     , EMP e
 WHERE d.deptno=e.deptno
       AND e.ename=UPPER('scott')



-- 7. SMITH와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 급여액, 부서이름을 가져온다.


		--급여액이 뭔가요?? 연봉 말하는 건가요?
SELECT e.empno
     , e.ename
     , e.sal
     ,d.dname
  FROM DEPT d
     , EMP e
 WHERE d.deptno=e.deptno
       AND e.deptno IN
       (SELECT deptno
         FROM EMP
        WHERE ename=UPPER('smith')
       );


-- 8. MARTIN과 같은 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.


SELECT e.empno
     , e.ename
     , e.job
  FROM EMP e
 WHERE
       e.job IN
       (SELECT job
         FROM EMP
        WHERE ename=UPPER('martin')
       );


-- 9. ALLEN과 같은 직속상관을 가진 사원들의 사원번호, 이름, 직속상관이름을 가져온다.


SELECT e.empno
     , e.ename
     , m.ename m_ename
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND m.ename IN
       (SELECT m.ename
         FROM EMP e
            , EMP m
        WHERE e.mgr=m.empno
              AND e.ename=UPPER('allen')
       );


-- 10. WARD와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 부서번호를 가져온다.


SELECT e.empno
     , e.ename
     ,d.deptno
  FROM DEPT d
     , EMP e
 WHERE d.deptno=e.deptno
       AND e.deptno IN
       (SELECT deptno
         FROM EMP
        WHERE ename=UPPER('ward')
       );


-- 11. SALESMAN의 평균 급여보다 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.


    --이 문제는 직업이 salesman인 사람이 출력 되도 괜찮겠다
SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE sal>
       (SELECT avg(sal)
         FROM EMP
        WHERE job=UPPER('salesman')
       );


-- 12. DALLAS 지역에 근무하는 사원들의 평균 급여를 가져온다.


SELECT AVG(sal)
  FROM
       (SELECT sal
         FROM EMP e
            , DEPT d
        WHERE e.deptno=d.deptno
              AND e.deptno=
              (SELECT deptno
                FROM DEPT
               WHERE LOC=UPPER('dallas')
              )
       )


-- 13. SALES 부서에 근무하는 사원들의 사원번호, 이름, 근무지역을 가져온다.


/*
select * from dept;
select *from emp;
*/
SELECT e.empno
     , e.ename
     , d.loc
  FROM EMP e
     , DEPT d
 WHERE e.deptno= d.deptno
 AND d.dname=UPPER('sales');


-- 14. CHICAGO 지역에 근무하는 사원들 중 BLAKE이 직속상관인 사원들의 사원번호, 이름, 직무를 가져온다.


SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
     , DEPT d
 WHERE e.deptno= d.deptno
       AND d.loc=UPPER('chicago')
       AND e.mgr IN
       (SELECT m.empno
         FROM EMP m
        WHERE m.ename=UPPER('blake')
       );


-- 15. 3000 이상의 급여를 받는 사원들과 같은 부서에 근무하고 있는 사원의 사원번호, 이름, 급여를 가져온다


SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE e.deptno IN
       (SELECT deptno
         FROM EMP
        WHERE sal>3000
       );


-- 16. 직무가 CLERK인 사원과 동일한 부서에 근무하고 있는 사원들의 사원번호, 이름, 입사일 가져온다.


    --clerk인 사람들은 모든 부서에 있다
    --부서에 근무하고 있는 사람들을 뽑으라는 건가?
SELECT e.empno
     , e.ename
     , e.hiredate
  FROM EMP e
 WHERE e.deptno IN
       (SELECT deptno
         FROM EMP e
        WHERE e.job=UPPER('clerk')
       );


-- 17. KING을 직속상관으로 가지고 있는 사원들이 근무하고 있는 근무 부서명, 지역을 가지고온다.


/*
SELECT *FROM EMP
ORDER BY mgr;
*/

SELECT d.dname
     , d.loc
  FROM EMP e
     , DEPT d
 WHERE e.deptno= d.deptno
       AND e.mgr=
       (SELECT empno
         FROM EMP
        WHERE ename=UPPER('king')
       );


-- 18. CLERK들의 직속상관의 사원번호, 이름, 급여를 가져온다.

SELECT m.empno
     , m.ename
     , m.sal
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND e.job=UPPER('clerk');

-- 19. 각 부서별 급여 평균보다 더 많이 받는 사원의 사원번호, 이름, 급여를 가져온다.


SELECT e.empno
     , e.ename
     , e.sal
     , e.deptno
  FROM EMP e
 WHERE sal>
       (SELECT AVG(sal)
         FROM EMP
        WHERE deptno=e.deptno
       );


-- 20. 각 부서별 급여 최저치보다 더 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.


SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE sal>
       (SELECT min(sal)
         FROM EMP
        WHERE deptno=e.deptno
       );


-- 21. SALESMAN 보다 급여를 적게 받는 사원들의 사원번호, 이름, 급여를 가져온다.


		--먼소리지? job이 salesman인 사람보다 적게 받는다는 말이 굉장히 모호함
    --직업이 salesman의 min 급여 보다 더 적게 받는 사원의 급여를 출력 하겠습니다
SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE sal<
       (SELECT MIN(sal)
         FROM EMP
        WHERE job=UPPER('salesman')
       );


-- 22. 각 부서별 최저 급여 액수보다 많이 받는 사원들이 사원번호, 이름, 급여를 가져온다.


		--*20번이랑 동일한 문제??
SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE sal>
       (SELECT min(sal)
         FROM EMP
        WHERE deptno=e.deptno
       );


-- 23. DALLAS에 근무하고 있는 사원들 중 가장 나중에 입사한 사원의 입사 날짜보다 더 먼저 입사한
-- 사원들의 사원번호, 이름, 입사일을 가져온다.


SELECT e.empno
     , e.ename
     , e.hiredate
  FROM EMP e
 WHERE hiredate <
       (SELECT MAX(hiredate)
         FROM EMP e
            , DEPT d
        WHERE e.deptno=d.deptno
       );
