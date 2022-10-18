-- 30번 부서의 사원의 사원번호와, 이름 , 부서명을 출력하시오. SCOTT/ EMP테이블
SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e, DEPT d
WHERE e.DEPTNO=d.DEPTNO
 AND d.DEPTNO=30




--BLAKE와 같은 부서의 직원의 이름과 입사일을 출력하세요. SCOTT/ EMP테이블
SELECT e.ENAME
				 ,e.HIREDATE
FROM EMP e
WHERE e.DEPTNO IN (SELECT deptno FROM EMP WHERE ename='BLAKE');


--BLAKE와 같은 부서의 직원의 이름과 입사일을 출력하세요. SCOTT/ EMP테이블
SELECT e.ename, e.hiredate
FROM EMP e, (SELECT deptno
									FROM EMP e
									WHERE e.ename = 'BLAKE') m
WHERE  e.DEPTNO =m.deptno;



--  KING이 직장상사인 사람의 사원번호와 이름, 부서명을 출력하세요. SCOTT/ EMP테이블
SELECT e.EMPNO
				, e.ENAME
        , d.DNAME
FROM EMP e
				,EMP m
				,DEPT d
WHERE e.DEPTNO = d.DEPTNO
 AND e.MGR = m.EMPNO
 AND m.ENAME = 'KING'


SELECT e.EMPNO,e.ENAME,d.DNAME ,e.DEPTNO
FROM EMP e , DEPT d /*,   (SELECT empno
                                   FROM EMP
                                  WHERE ename ='KING') m*/
WHERE   e.mgr =(SELECT m.EMPNO
                       FROM EMP m
                        WHERE m.ename ='KING')
      AND e.deptno=d.DEPTNO



-- 각 부서별 평균 급여액을 구하고 부서별 평균 급여액 보다 급여를 많이 받는 사원의 사원번호
-- 이름, 급여, 부서번호, 부서이름, 각 부서의 평균급여액을 구하시오.
SELECT e.ENAME
				, e.SAL
        , e.DEPTNO
        , d.DNAME
        , a.avg_sal
FROM (SELECT e.DEPTNO, TRUNC(avg(e.SAL),2) avg_sal FROM EMP e GROUP BY e.DEPTNO) a
				,EMP e
        ,DEPT d
WHERE e.DEPTNO = d.DEPTNO
 AND e.DEPTNO = a.deptno
 AND e.SAL > a.avg_sal
ORDER BY e.sal ASC;

-----------------------------------------------------
SELECT E.EMPNO,E.ENAME, E.SAL, E.DEPTNO, D.DNAME, M.AV
FROM  EMP E,
				(SELECT DEPTNO, AVG(SAL) AV FROM EMP GROUP BY DEPTNO) M
				, DEPT D
WHERE  E.DEPTNO=D.DEPTNO
	AND E.DEPTNO=M.DEPTNO
	AND E.SAL>=M.AV
ORDER BY D.DNAME ASC;




-- 각 부서별 평균 급여액을 구하고 부서별 평균 급여액 보다 급여를 많이 받는 사원의 사원번호
-- 이름, 급여, 부서번호, 부서명, 각 부서의 평균급여액을 구하시오.
SELECT e.empno, e.ename, e.sal, e.deptno, d.asal
FROM EMP e, (SELECT deptno, avg(sal) asal FROM EMP GROUP BY deptno) d
WHERE e.DEPTNO=d.deptno
AND e.sal > d.asal
ORDER BY e.DEPTNO








select rownum, deptno, gap
        from (select e.deptno, (m.sal - e.sal) gap
                from emp e, emp m
                where e.mgr = m.empno
                order by gap desc);									------>서브쿼리로 감싼 다음 rownum을 하는 이유 : order by 를 먼저 실행한 뒤, rownum을 하기 위해

------------------------------------------------

select e.deptno, (m.sal - e.sal) gap, rownum
                from emp e, emp m
                where e.mgr = m.empno
                order by gap DESC;								------->서브쿼리로 감싸지 않으면 rownum을 먼저 실행한 다음 order by 하기 때문에 rownum순서 맞지 않음







--각 부서별로 최고급여를 받는 직원의 부서명, 부서 아이디, 사원의 이름, SAL를 출력하시오.
SELECT d.dname
				, a.deptno
        , e.ENAME
        , a.max_sal
FROM (SELECT e.DEPTNO, max(e.sal) max_sal FROM EMP e GROUP BY e.DEPTNO) a
				,EMP e
        ,DEPT d
WHERE e.DEPTNO = a.deptno
 AND d.deptno = a.deptno
ORDER BY a.deptno;



--*5. 각 부서별로 최고급여를 받는 직원의 부서명, 부서 아이디, 사원의 이름, SAL를 출력하시오.
SELECT e.DEPTNO, d.DNAME, e.ENAME, e.SAL
FROM(SELECT max(sal) ms, deptno
         FROM EMP
         GROUP BY deptno) m, EMP e, DEPT d
WHERE e.sal=m.ms
AND e.DEPTNO=d.DEPTNO
ORDER BY e.DEPTNO;


SELECT d.dname, e.deptno, e.ename, e.sal
FROM EMP e,DEPT d, (SELECT deptno, MAX(sal) AS asal
FROM EMP
GROUP BY deptno) m
WHERE e.deptno = m.deptno(+)
AND e.sal = m.asal
AND e.deptno = d.deptno;





-- 직속상사 보다 월급을 많이 받는 사원을 구하세요.
SELECT e.ENAME
				, e.sal
        , m.ENAME m_ename
        , m.sal m_sal
FROM EMP e
				,EMP m
WHERE e.MGR = m.EMPNO
 AND e.sal > m.sal








-- 직속 상사와의 월급 차이가 가장 큰 사람과 같은 부서의 사원의
-- 사원번호, 이름, 부서명, 월급, 직장상사의 이름,직장상사의 급여, 직장상사와의 월급 차이를 출력해주세요.



SELECT e.EMPNO
				, e.ENAME
        , d.dname
        , e.sal
        , m.ENAME
        , m.SAL
        , (m.sal - e.SAL)
FROM (
					SELECT e.DEPTNO
					FROM	(SELECT max(m.SAL - e.SAL) total_sal
										FROM EMP e, EMP m
     								WHERE e.MGR = m.EMPNO) a
         					 ,EMP e
        				   ,EMP m
					WHERE e.MGR = m.EMPNO
 					AND ( m.sal - e.sal ) IN a.total_sal
				 ) p
				 , DEPT d
         , EMP e
         , EMP m
 WHERE p.deptno = d.deptno
  AND e.DEPTNO = p.deptno
  AND e.MGR = m.EMPNO(+);


----------------------------------------------------------


SELECT P.EMPNO, P.ENAME, D.DNAME, P.SAL, P.MNAME, P.MSAL, P.GAB
FROM
      (SELECT A.EMPNO, A.ENAME, A.SAL, S.ENAME MNAME, S.SAL MSAL, A.DEPTNO, (S.SAL-A.SAL) GAB
         FROM EMP A, EMP S
            WHERE A.MGR=S.EMPNO(+)
            ) P
            ,DEPT D
            ,(SELECT *
               FROM
            (SELECT MAX(M.SAL-E.SAL) GAB , E.DEPTNO
            FROM EMP E, EMP M
            WHERE E.MGR=M.EMPNo
            AND (M.SAL-E.SAL)>0
            GROUP BY  E.DEPTNO
            ORDER BY  MAX(M.SAL-E.SAL) DESC)
            WHERE ROWNUM =1
            ) Q
WHERE P.DEPTNO=D.DEPTNO
AND P.DEPTNO=Q.DEPTNO;



-- 직속 상사와의 월급 차이가 가장 큰 사람과 같은 부서의 사원의
-- 사원번호, 이름, 부서명, 월급, 직장상사의 이름,직장상사의 급여, 직장상사와의 월급 차이를 출력해주세요.
SELECT e.EMPNO, e.DEPTNO, e.ENAME, d.DNAME, e.SAl, e1.ENAME 직상이, e1.SAL 직상월, (e1.SAL-e.SAL) GAP
FROM EMP e, DEPT d, EMP e1
WHERE e.DEPTNO=d.DEPTNO
AND e1.EMPNO=e.MGR
AND e.DEPTNO=(SELECT e1.DEPTNO FROM EMP e1, EMP e2 WHERE e1.MGR=e2.EMPNO
AND (e2.sal-e1.sal)=(SELECT max(e2.sal-e1.sal) FROM EMP e1, EMP e2 WHERE e1.MGR=e2.EMPNO))





SELECT f.empno, f.ename, f.deptno, f.sal, g.ename, g.sal, g.sal-f.sal
FROM (SELECT ROWNUM, a.DEPTNO
					FROM EMP a, (SELECT ABS(m.SAL-e.SAL) ms, e.empno
          									FROM EMP e, EMP m
                            WHERE e.MGR=m.EMPNO
                            ORDER BY ms desc) s
           WHERE a.EMPNO=s.empno
      		 AND rownum=1) c, EMP f, EMP g
WHERE c.deptno=f.deptno
AND f.mgr=g.empno(+);												--ABS : 절대값을 구하는 함수









 -- 사원수가 2명이 넘는 부서의 부서명, 근무지역을 출력하세요.
SELECT a.deptno
				, d.dname
				, d.loc
FROM (SELECT e.DEPTNO, count(*)
					FROM EMP e
          GROUP BY e.DEPTNO
          HAVING COUNT(*)>=2) a
          ,DEPT d
WHERE d.deptno = a.deptno;



-- ADAMS보다 급여가 높고 직종이 SALESMAN인 사원의 이름과 급여를 출력하세요.
SELECT M.ENAME,M.SAL
FROM EMP M,
      (
        SELECT E.SAL
        FROM EMP E
        WHERE UPPER(E.ENAME)=UPPER('ADAMS')
        ) F
WHERE M.SAL>F.SAL
AND UPPER(M.JOB)=UPPER('SALESMAN');

-------------------------------------------
SELECT e.ENAME
				, e.SAL
FROM EMP e
WHERE e.SAL > (SELECT e.sal FROM EMP e WHERE e.ENAME='ADAMS')
 AND e.JOB='SALESMAN';


SELECT e.ENAME, e.SAL
FROM EMP e, EMP m
WHERE  e.JOB='SALESMAN'
AND e.SAL> m.SAL
AND m.ENAME='ADAMS';





--직종이 'CLERK'인 사원이 적어도 2명 이상 속한 부서 이름을 출력하세요.
SELECT a.DEPTNO
				, d.DNAME
FROM DEPT d
				,(SELECT e.DEPTNO
        FROM EMP e
        WHERE e.JOB='CLERK'
        GROUP BY e.DEPTNO
        HAVING COUNT(*)>=2) a
WHERE d.DEPTNO =a.deptno;



