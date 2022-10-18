--ALLEN과 부서가 같은 사원들의 사원명, 입사일을 출력하되 높은 급여순으르 출력
SELECT e.ENAME, e.HIREDATE
FROM EMP e
WHERE e.DEPTNO = (SELECT deptno FROM EMP WHERE ename='ALLEN')
ORDER BY e.sal DESC;



--1.ALLEN과 부서가 같은 사원들의 사원명, 입사일을 출력하되 높은 급여순으로 출력하세요.
SELECT E.ENAME,E.HIREDATE
FROM EMP E,
				(SELECT *
				FROM EMP
				WHERE ename LIKE 'ALLEN') ANLLEN_DEPT
WHERE ANLLEN_DEPT.DEPTNO = E.DEPTNO;

--order by 는 속도저하될 가능성이 있음




--가장 높은 급여를 받는 ㅅㅏ원보다 입사일이 늦은 사원의 이름, 입사일 출력
SELECT e.ENAME, e.HIREDATE
FROM EMP e
				,(SELECT e1.HIREDATE
        FROM EMP e1
        WHERE e1.sal=(SELECT MAX(sal) FROM EMP)) m
WHERE m.hiredate < e.HIREDATE; -->부등호조인


--2.가장 높은 급여를 받는 사원보다 입사일이 늦은 사원의 이름, 입사일을 출력하세요.
SELECT ename, hiredate
FROM EMP
WHERE hiredate >(
												SELECT hiredate
												FROM EMP
												WHERE sal =(
																				SELECT MAX(sal)
																				FROM EMP) );



--이름에 'T'자가 들어가는 사원들의 급여의 합 출력
SELECT SUM(e.SAL)
FROM EMP e
WHERE e.ENAME LIKE '%T%';

3.이름에 "T"자가 들어가는 사원들의 급여의 합을 구하세요. (LIKE)
SELECT SUM(SAL)
FROM EMP
WHERE ENAME LIKE '%T%';
<속도개선 Tip>
SELECT SUM(SAL)
FROM EMP
WHERE INSTR(ENAME,'T') > 0;




--모든 사원의 평균급여 출력
SELECT TRUNC(AVG(e.SAL),2)
FROM EMP e;





--각 부서별 평균급여 출력
SELECT TRUNC(AVG(e.sal),2)
FROM EMP e
GROUP BY e.DEPTNO;





--각 부서별 평균급여, 전체급여, 최고급여, 최저급여를 구하여 평균급여가 많은 순으로 출력
SELECT TRUNC(AVG(e.sal),2) trunc
				, sum(e.sal) sum
        , max(e.sal) max
        , min(e.sal) min
FROM EMP e
GROUP BY e.DEPTNO
ORDER BY AVG(e.sal) DESC;


--6.각 부서별 평균급여,전체급여,최고급여,최저급여을 구하여 평균급여가
   많은 순으로 출력하세요.
SELECT round(AVG(SAL),0), SUM(SAL), MAX(SAL), MIN(SAL)  --round는 반올림, trunc는 자르기
FROM EMP GROUP BY DEPTNO
ORDER BY AVG(SAL) DESC;



--20번부서의 최고급여보다 많은 사원의 사원번호, 사원명, 급여 출력
SELECT e.EMPNO, e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL > (SELECT max(sal) FROM EMP WHERE deptno=20);


--7. 20번 부서의 최고 급여보다 많은은 사원의 사원번호,사원명급여를 출력하시오. SELECT*FROM EMP
SELECT E.EMPNO
     ,e.ENAME
  FROM EMP e
 WHERE e.SAL>
       (SELECT MAX(sal)
         FROM EMP
        WHERE DEPTNO='20'
       )

SELECT e.empno, e.ename, e.sal
FROM (SELECT MAX(sal) ms
          FROM EMP
          WHERE deptno=20) m, EMP e
WHERE e.sal>m.ms;



--SMITH와 같은 부서에 속한 사원들의 평균급여보다 큰 급여를 받는 모든 사원의 사원명, 급여 출력
SELECT e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL >(SELECT AVG(e.SAL) avg
										FROM EMP e
										WHERE e.DEPTNO = (SELECT DEPTNO
																								FROM EMP
                                                WHERE ENAME='SMITH'));


SELECT e.ename, e.sal
FROM (SELECT AVG(sal) avs
					FROM emp
          WHERE deptno=(SELECT deptno FROM EMP WHERE ename='SMITH')) s, EMP e
WHERE e.sal>s.avs;





--회사내의 최소급여와 최대급여 차이 출력
SELECT max(sal) - min(sal) gab
FROM EMP;

--SCOTT의 급여에서 1000을 뺀 급여보다 적게 받는 사원의 이름, 급여출력
SELECT e.ENAME, e.SAL
FROM EMP e
				,(SELECT sal-1000 scott_sal FROM EMP WHERE ename='SCOTT') s
WHERE e.sal < s.scott_sal;



--10.SCOTT의 급여에서 1000 을 뺀 급여보다 적게 받는 사원의 이름,급여를
    출력하세요.
SELECT e.ename, e.sal
FROM (SELECT sal
          FROM emp
          WHERE ename='SCOTT')s, EMP e
WHERE e.sal< s.sal-1000;


SELECT ename,sal
FROM EMP
WHERE sal < (
                              SELECT sal - 1000
                              FROM EMP
                              WHERE ename = 'SCOTT'
                    )


--JOB이 MANAGER인 사원들 중 최소급여를 받는 사원보다 급여가 적은 사원의 이름, 급여 출력
SELECT e.ENAME, e.SAL
FROM EMP e
				,(SELECT MIN(sal) sal
					FROM EMP
					WHERE job='MANAGER') ms
WHERE e.SAL < ms.sal;



--이름이 S로 시작하고 마지막글자가 H인 사원의 이름출력
SELECT e.ENAME
FROM EMP e
WHERE e.ENAME LIKE 'S%H';




--WARD가 소속된 부서사원들의 평균급여보다 급여가 높은 사원의 이름,급여출력
SELECT e.ENAME, e.SAL
FROM EMP e
				,(SELECT TRUNC(AVG(sal),2) sal
					FROM EMP e
								,(SELECT deptno
									FROM EMP
									WHERE ename='WARD') d
					WHERE e.DEPTNO = d.deptno) s
WHERE e.SAL > s.sal;


SELECT ename, sal
FROM EMP
WHERE sal > (
								SELECT TRUNC(AVG(sal))
								FROM EMP
								WHERE deptno = (
																				SELECT deptno
																				FROM EMP
																				WHERE ename = 'WARD'));



--emp테이블의 모든 사원수 출력
SELECT COUNT(*)
FROM EMP ;

--부서별 사원수 출력
SELECT deptno,COUNT(*)
FROM EMP
GROUP BY deptno
ORDER BY deptno;

--업무별 사원수 출력
SELECT job, COUNT(*)
FROM EMP
GROUP BY job;

--최소급여를 받는 사원과 같은 부서의 모든 사원명 출력
SELECT e.ENAME
FROM EMP e
WHERE e.DEPTNO = (SELECT deptno
          								FROM EMP e
													WHERE sal=(SELECT MIN(sal) FROM EMP));


SELECT ename
FROM EMP
WHERE deptno IN(
												SELECT deptno
												FROM emp
												WHERE sal IN (
																						SELECT min(sal)
																						FROM EMP) )





SELECT EE.ENAME
  FROM EMP EE
     ,
       (SELECT DEPTNO
         FROM EMP E
            ,
              (SELECT MIN(SAL) MIN_SAL
                FROM EMP
              ) MIN_SAL
        WHERE MIN_SAL.MIN_SAL = E.SAL
       ) SUB
 WHERE SUB.DEPTNO = EE.DEPTNO

