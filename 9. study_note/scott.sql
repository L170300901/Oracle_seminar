--가장높은 급여를 받는 사원보다 입사일이 늦은 사원의 이름, 입사일 출력

SELECT e.ENAME, e.HIREDATE
FROM EMP e
WHERE e.HIREDATE>(SELECT e.HIREDATE
					FROM EMP e
          WHERE e.SAL=(SELECT MAX(e.sal)
          										FROM EMP e))

--ALLEN과 부서가 같은 사원들의 사원명, 입사일을 출력하되 높은 급여순으로 출력

SELECT e.ENAME, e.HIREDATE
FROM EMP e
WHERE e.DEPTNO = (SELECT e.DEPTNO FROM EMP e WHERE e.ENAME='ALLEN')
ORDER BY e.SAL DESC;


--이름에 'T'자가 들어가는 사원들의 급여의 합

SELECT SUM(e.SAL)
FROM EMP e
WHERE e.ENAME LIKE '%T%'


--모든사원의 평균급여

SELECT TRUNC(AVG(e.sal),2)
FROM EMP e


--각 부서별 평균급여

SELECT e.DEPTNO, TRUNC(AVG(e.SAL),2)
FROM EMP e
GROUP BY e.DEPTNO
ORDER BY e.DEPTNO


--각 부서별 평균급여, 전체급여, 최고급여, 최저급여를 구하여 평균급여가 많은순으로 출력

SELECT max(e.SAL), SUM(e.SAL), MIN(e.SAL), TRUNC(AVG(e.SAL),2) avg_sal
FROM EMP e
GROUP BY e.DEPTNO
ORDER BY avg_sal DESC;


--20번 부서의 최고급여보다 많은 사원의 사원번호, 사원명, 급여 출력

SELECT e.EMPNO, e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL > (SELECT MAX(e.SAL) FROM EMP e WHERE e.DEPTNO=20 )


--SMITH와 같은 부서에 속한 사원들의 평균급여보다 큰 급여를 받는 모든 사원의 사원명, 급여출력 ***************




--회사내의 최소급여와 최대급여의 차이 출력
SELECT max(e.SAL) - min(e.SAL)
FROM EMP e


--SCOTT의 급여에서 1000을 뺀 급여보다 적게 받는 사원의 이름, 급여출력
SELECT e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL < (SELECT e.SAL FROM EMP e WHERE e.ENAME='SCOTT') - 1000;


--JOB이 MANAGER인 사원들 중에서 최소급여를 받는 사원보다 급여가 적은 사원의 이름, 급여 출력
SELECT e.ENAME, e.sal
FROM EMP e,
				(SELECT min(e.sal) min_sal FROM EMP e WHERE e.JOB='MANAGER') m
WHERE m.min_sal > e.SAL ;


--이름이 S로 시작하고 마지막글자가 H인 사원의 이름 출력
SELECT e.ENAME
FROM EMP e
WHERE e.ENAME LIKE 'S%H';


--WARD가 소속된 부서 사원들의 평균 급여보다 급여가 높은 사원의 이름,급여 출력
SELECT e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL> (SELECT TRUNC(AVG(e.sal)) avg_sal
										FROM EMP e
        					  WHERE e.DEPTNO = (SELECT e.DEPTNO
                    													FROM EMP e
                                              WHERE e.ENAME='WARD'))



--emp테이블의 모든 사원 수 출력
SELECT COUNT(*)
FROM EMP							--->레코드의 수는 어떤 칼럼을 대상으로 세어도 상관없음



--부서별 사원 수
SELECT COUNT(*)
FROM EMP
GROUP BY deptno


--최소급여를 받는 사원과 같은 부서의 모든 사원명 출력
SELECT e.ENAME
FROM (SELECT e.DEPTNO
					FROM (SELECT MIN(e.sal) min_sal
										FROM EMP e) a
       						 ,EMP e
					WHERE e.SAL = a.min_sal ) m
          ,EMP e
WHERE e.DEPTNO = m.deptno;


-------------------------------------------------
SELECT ename
FROM EMP
WHERE deptno=(SELECT deptno FROM EMP WHERE sal = (SELECT MIN(sal) FROM EMP));



