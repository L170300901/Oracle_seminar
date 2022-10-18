1.ALLEN과 부서가 같은 사원들의 사원명, 입사일을 출력하되 높은 급여순으로 출력하세요.
SELECT e.ename, e.hiredate
FROM (SELECT deptno
					FROM EMP
          WHERE ename='ALLEN')a, EMP e
WHERE a.deptno=e.deptno
ORDER BY sal DESC;

--1.준혁
SELECT E.ENAME,E.HIREDATE
FROM EMP E,
(SELECT *
FROM EMP
WHERE ename LIKE 'ALLEN') ANLLEN_DEPT
WHERE ANLLEN_DEPT.DEPTNO = E.DEPTNO;

!!!!! 2.가장 높은 급여를 받는 사원보다 입사일이 늦은 사원의 이름, 입사일을 출력하세요.
SELECT m.ENAME, m.HIREDATE
FROM (SELECT empno, hiredate
          FROM emp
          WHERE sal=(SELECT MAX(sal)
                           FROM emp))e, EMP m
WHERE m.HIREDATE>e.hiredate;

--원찬
SELECT ename, hiredate
FROM EMP
WHERE hiredate >(
SELECT hiredate
FROM EMP
WHERE sal =(
SELECT MAX(sal)
FROM EMP) );

--답
SELECT ENAME,HIREDATE
FROM EMP
WHERE HIREDATE >
(SELECT HIREDATE FROM EMP WHERE SAL=(SELECT MAX(SAL) FROM EMP));



3.이름에 "T"자가 들어가는 사원들의 급여의 합을 구하세요. (LIKE)
SELECT SUM(sal)
FROM EMP
WHERE ename LIKE '%T%';

3.이름에 "T"자가 들어가는 사원들의 급여의 합을 구하세요. (LIKE)
SELECT SUM(SAL)
FROM EMP
WHERE ENAME LIKE '%T%';
<속도개선 Tip>
SELECT SUM(SAL)
FROM EMP
WHERE INSTR(ENAME,'T') > 0;



4.모든 사원의 평균급여를 구하세요.
SELECT AVG(sal)
FROM emp



5. 각 부서별 평균 급여를 구하세요. (GROUP BY)
SELECT TRUNC(AVG(sal),2)
FROM EMP
GROUP BY deptno;


6.각 부서별 평균급여,전체급여,최고급여,최저급여을 구하여 평균급여가
   많은 순으로 출력하세요.
SELECT TRUNC(AVG(sal),2) avs, SUM(sal), max(sal), MIN(sal)
FROM EMP
GROUP BY deptno
ORDER BY avs DESC;


7.20번 부서의 최고 급여보다 많은 사원의 사원번호,사원명,급여를 출력하세요.
SELECT e.empno, e.ename, e.sal
FROM (SELECT MAX(sal) ms
          FROM EMP
          WHERE deptno=20) m, EMP e
WHERE e.sal>m.ms;


!!!!!!!! 8.SMITH와 같은 부서에 속한 사원들의 평균 급여보다 큰 급여를 받는 모든 사원의 사원명,급여를 출력하세요
SELECT e.ename, e.sal
FROM (SELECT AVG(sal) avs
					FROM emp
          WHERE deptno=(SELECT deptno FROM EMP WHERE ename='SMITH')) s, EMP e
WHERE e.sal>s.avs;

--답
SELECT ENAME,SAL
FROM EMP
WHERE SAL >
(SELECT AVG(SAL) FROM EMP WHERE DEPTNO=
  (SELECT DEPTNO FROM EMP WHERE ENAME='SMITH')
)


--이거는 왜 틀렸지? 스미스의 평균을 구했다
SELECT e.ename, e.sal
FroM (SELECT deptno, AVG(sal) avs
					FROM EMP
					WHERE ename='SMITH'
          GROUP BY deptno, AVG(sal)) s, EMP e
WHERE e.sal>s.avs



9.회사내의 최소급여와 최대급여의 차이를 구하세요
SELECT max(sal)-min(sal)
FROM EMP




10.SCOTT의 급여에서 1000 을 뺀 급여보다 적게 받는 사원의 이름,급여를
    출력하세요.
SELECT e.ename, e.sal
FROM (SELECT sal
          FROM emp
          WHERE ename='SCOTT')s, EMP e
WHERE e.sal< s.sal-1000;

--원찬
SELECT ename,sal
FROM EMP
WHERE sal < (SELECT sal - 1000
										FROM EMP
                    WHERE ename = 'SCOTT'
                    )

--답
SELECT ENAME,SAL
FROM EMP
WHERE SAL < (SELECT SAL-1000 FROM EMP WHERE ENAME='SCOTT')



11.JOB이 MANAGER인 사원들 중 최소급여를 받는 사원보다  급여가 적은
    사원의 이름, 급여를 출력하세요
SELECT e.ename, e.sal
FROM (SELECT min(sal) ms
          FROM  emp
          WHERE job='MANAGER') m,  EMP e
WHERE e.sal< m.ms;

--답
SELECT ENAME,SAL
FROM EMP
WHERE SAL<
(SELECT MIN(SAL) FROM EMP WHERE JOB='MANAGER')

--준혁 11.JOB이 MANAGER인 사원들 중 최소급여를 받는 사원보다  급여가 적은 사원의 이름, 급여를 출력하세요
SELECT E.ENAME,E.SAL
FROM EMP E,
(SELECT MIN(SAL) MIN_SAL
FROM EMP
WHERE JOB LIKE 'MANAGER') MIN_SAL
WHERE E.SAL < MIN_SAL.MIN_SAL



12.이름이 S로 시작하고 마지막글자가 H인 사원의 이름을 출력하세요.
SELECT ename
FROM EMP
WHERE ename LIKE 'S%H';


13.WARD가 소속된 부서 사원들의 평균 급여보다 , 급여가 높은 사원의
    이름 ,급여를 출력하세요.
SELECT e.ename, e.sal
FROM (SELECT AVG(sal) avs
          FROM EMP
          WHERE deptno=(SELECT deptno FROM EMP WHERE ename='WARD')) w, EMP e
WHERE e.sal>w.avs;

--원찬 13.WARD가 소속된 부서 사원들의 평균 급여보다 , 급여가 높은 사원의 이름 ,급여를 출력하세요.
SELECT ename, sal
FROM EMP
WHERE sal > (
SELECT TRUNC(AVG(sal))
FROM EMP
WHERE deptno = (
SELECT deptno
FROM EMP
WHERE ename = 'WARD'))

14.EMP 테이블의 모든 사원수를 출력하세요.
SELECT COUNT(*)
FROM EMP

14-2 : 부서별 사원수를 출력하세요
SELECT deptno, COUNT(*)
FROM EMP
GROUP BY deptno;



15.업무별(JOB) 사원수를 출력하세요
SELECT job, COUNT(*)
FROM EMP
GROUP BY job;


16.최소급여를 받는 사원과 같은 부서의 모든 사원명을 출력하세요.


SELECT e.ENAME
  FROM
       (SELECT deptno
         FROM EMP
        WHERE sal=
              (SELECT min(sal)
                FROM emp
              )
       )m
     , EMP e
 WHERE m.deptno=e.DEPTNO;

