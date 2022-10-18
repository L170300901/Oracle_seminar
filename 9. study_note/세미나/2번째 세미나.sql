----------scott계정 문제 내풀이-------------------------
--1.30번 부서의 사원의 사원번호와, 이름 , 부서명을 출력하시오. SCOTT/ EMP테이블
SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e, DEPT d
WHERE e.DEPTNO=d.DEPTNO
AND e.DEPTNO=30;


SELECT e.EMPNO, e.ENAME, d.DNAME
FROM DEPT d, (SELECT empno, deptno, ename
                     FROM EMP
                     WHERE deptno=30) e
WHERE d.DEPTNO=e.DEPTNO;



--* 2. BLAKE와 같은 부서의 직원의 이름과 입사일을 출력하세요. SCOTT/ EMP테이블
SELECT e.ENAME, e.HIREDATE
FROM EMP e, (SELECT deptno
                    FROM EMP
                    WHERE ename='BLAKE') b
WHERE e.DEPTNO=b.deptno


-- * 3.  KING이 직장상사인 사람의 사원번호와 이름, 부서명을 출력하세요. SCOTT/ EMP테이블
SELECT m.empno, m.ename, d.DNAME
FROM (SELECT e.EMPNO, e.ENAME, e.DEPTNO
          FROM EMP e, EMP k
          WHERE e.MGR=k.EMPNO
          AND k.ENAME='KING') m, DEPT d
WHERE m.deptno=d.DEPTNO

---민호
--프롬절에 놔둔것만으로도 조인
SELECT e.EMPNO,e.ENAME,d.DNAME ,e.DEPTNO
FROM EMP e , DEPT d /*,   (SELECT empno
                                                   FROM EMP
                                  WHERE   ename ='KING') m*/
WHERE   e.mgr =(SELECT EMPNO
                                    FROM EMP
                        WHERE      ename ='KING')
      AND e.deptno=d.DEPTNO



-- *4. 각 부서별 평균 급여액을 구하고 부서별 평균 급여액 보다 급여를 많이 받는 사원의 사원번호
-- 이름, 급여, 부서번호, 부서명, 각 부서의 평균급여액을 구하시오.
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO, d.DNAME, a.avs
FROM  (SELECT AVG(sal) avs, deptno
           FROM EMP
           GROUP BY deptno) a, EMP e, DEPT d
WHERE e.deptno=a.deptno
AND e.DEPTNO=d.DEPTNO
AND e.SAL>a.avs;

--원혁
SELECT e.empno, e.ename, e.sal, e.deptno, d.asal
FROM EMP e, (SELECT deptno, avg(sal) asal FROM EMP GROUP BY deptno) d
WHERE e.DEPTNO=d.deptno
AND e.sal > d.asal
ORDER BY e.DEPTNO;

--경윤
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


--*5. 각 부서별로 최고급여를 받는 직원의 부서명, 부서 아이디, 사원의 이름, SAL를 출력하시오.
SELECT e.DEPTNO, d.DNAME, e.ENAME, e.SAL
FROM(SELECT max(sal) ms, deptno
         FROM EMP
         GROUP BY deptno) m, EMP e, DEPT d
WHERE e.sal=m.ms
AND e.DEPTNO=d.DEPTNO
ORDER BY e.DEPTNO;

--경윤
--ms 하나 조인 안해줌
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

--원찬
SELECT d.dname, e.deptno, e.ename, e.sal
FROM EMP e,DEPT d, (SELECT deptno, MAX(sal) AS asal
FROM EMP
GROUP BY deptno) m
WHERE e.deptno = m.deptno(+)
AND e.sal = m.asal
AND e.deptno = d.deptno;




--* 6. 직속상사 보다 월급을 많이 받는 사원을 구하세요.
SELECT e.EMPNO, e.ENAME, e.SAL, m.SAL
FROM EMP e, EMP m
WHERE e.MGR=m.EMPNO
AND e.SAL>m.SAL


-- *7. 직속 상사와의 월급 차이가 가장 큰 사람과 같은 부서의 사원의
-- 사원번호, 이름, 부서명, 월급, 직장상사의 이름,직장상사의 급여, 직장상사와의 월급 차이를 출력해주세요.
SELECT f.empno, f.ename, f.deptno, f.sal, g.ename, g.sal, (g.sal-f.sal)
FROM (SELECT ROWNUM, a.DEPTNO
					FROM EMP a, (SELECT ABS(m.SAL-e.SAL) ms, e.empno
         	                    FROM EMP e, EMP m
          	                  WHERE e.MGR=m.EMPNO
                              ORDER BY ms desc) s
					WHERE a.EMPNO=s.empno
          AND rownum=1) c, EMP f, EMP g
WHERE c.deptno=f.deptno
AND f.mgr=g.empno(+);

--원혁
SELECT e.EMPNO, e.DEPTNO, e.ENAME, d.DNAME, e.SAl, e1.ENAME 직상이, e1.SAL 직상월, (e1.SAL-e.SAL) GAP
FROM EMP e, DEPT d, EMP e1
WHERE e.DEPTNO=d.DEPTNO
AND e1.EMPNO=e.MGR
AND e.DEPTNO=(SELECT e1.DEPTNO FROM EMP e1, EMP e2 WHERE e1.MGR=e2.EMPNO
AND (e2.sal-e1.sal)=(SELECT max(e2.sal-e1.sal) FROM EMP e1, EMP e2 WHERE e1.MGR=e2.EMPNO))

--경윤
SELECT e.EMPNO
            , e.ENAME
        , d.dname
        , e.sal
        , m.ENAME
        , m.SAL
        , (m.sal - e.SAL)
FROM (
               SELECT e.DEPTNO
               FROM   (SELECT max(m.SAL - e.SAL) total_sal
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
  AND e.MGR = m.EMPNO(+)

--경윤
SELECT P.EMPNO, P.ENAME, D.DNAME, P.SAL, P.MNAME, P.MSAL, P.GAB
FROM
      (SELECT A.EMPNO, A.ENAME, A.SAL, S.ENAME MNAME, S.SAL MSAL, A.DEPTNO, (S.SAL-A.SAL) GAB
         FROM EMP A, EMP S
            WHERE A.MGR=S.EMPNO
            ) P
            ,DEPT D
            ,(SELECT *
               FROM
            (SELECT MAX(M.SAL-E.SAL) GAB , E.DEPTNO
            FROM EMP E, EMP M
            WHERE E.MGR=M.EMPNO
            AND (M.SAL-E.SAL)>0
            GROUP BY  E.DEPTNO
            ORDER BY  MAX(M.SAL-E.SAL) DESC)
            WHERE ROWNUM =1
            ) Q
WHERE P.DEPTNO=D.DEPTNO
AND P.DEPTNO=Q.DEPTNO;

--가독성
SELECT f.empno
     , f.ename
     , f.deptno
     , f.sal
     , g.ename
     , g.sal
     , ABS((g.sal-f.sal))
  FROM
       (SELECT ROWNUM
            , a.DEPTNO
         FROM EMP a
            ,
              (SELECT ABS(m.SAL-e.SAL) ms
                   , e.empno
                FROM EMP e
                   , EMP m
               WHERE e.MGR=m.EMPNO
            ORDER BY ms desc
              ) s
        WHERE a.EMPNO=s.empno
              AND ROWNUM=1
       ) c
     , EMP f
     , EMP g
 WHERE c.deptno=f.deptno
       AND f.mgr=g.empno(+)




--태윤이 풀이
SELECT *
  FROM EMP
 WHERE deptno=
       (SELECT DEPTno
         FROM
              (SELECT e.deptno
                   ,MAX(m.sal-e.sal) sal
                FROM EMP e
                   , EMP m
               WHERE e.mgr=m.empno
               GROUP BY e.deptno
              )
        WHERE sal=
              (SELECT MAX(m.sal-e.sal) sal
                FROM EMP e
                   , EMP m
               WHERE e.mgr=m.empno
              )
       )



 --* 8. 사원수가 2명이 넘는 부서의 부서명, 근무지역을 출력하세요.
 SELECT d.DNAME, d.LOC
 FROM (SELECT deptno
           FROM EMP
           GROUP BY deptno
           HAVING COUNT(*)>2) e, DEPT d
 WHERE e.DEPTNO= d.DEPTNO;





--*9. ADAMS보다 급여가 높고 직종이 SALESMAN인 사원의 이름과 급여를 출력하세요.
SELECT e.ENAME, e.SAL
FROM EMP e, EMP m
WHERE  e.JOB='SALESMAN'
AND e.SAL> m.SAL
AND m.ENAME='ADAMS'


SELECT m.ENAME, m.SAL
FROM EMP m, (SELECT e.SAL, e.JOB, e.ENAME
                    FROM EMP e, EMP a
                    WHERE e.sal> a.SAL
                    AND a.ENAME='ADAMS') b
WHERE m.ENAME=b.ename
AND m.JOB='SALESMAN';




--*10. 직종이 'CLERK'인 사원이 적어도 2명 이상 속한 부서 이름을 출력하세요.
SELECT d.DNAME
FROM (SELECT  job, deptno
          FROM EMP
          GROUP BY job, deptno
          HAVING job='CLERK'
          AND COUNT(*)>1) c, DEPT d
WHERE c.deptno=d.DEPTNO






-----------------------답--------------------------------------------
-- 1. 30번 부서의 사원의 사원번호와, 이름 , 부서명을 출력하시오. SCOTT/ EMP테이블

EMP테이블
SELECT E.EMPNO
         ,E.ENAME
            ,D.DNAME
FROM DEPT D
      ,(SELECT *
      FROM EMP
      WHERE DEPTNO=30
        ) E
WHERE D.DEPTNO=E.DEPTNO;





--2. BLAKE와 같은 부서의 직원의 이름과 입사일을 출력하세요. SCOTT/ EMP테이블

SELECT E.ENAME, E.HIREDATE
FROM EMP E
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE UPPER(ENAME)=UPPER('BLAKE'));




-- 3. KING이 직장상사인 사람의 사원번호와 이름, 부서명을 출력하세요. SCOTT/ EMP테이블

SELECT E.EMPNO, E.ENAME, D.DNAME
FROM EMP E
      , DEPT D
        , (SELECT EMPNO FROM EMP WHERE ENAME='KING') M
WHERE E.MGR= M.EMPNO
AND E.DEPTNO=D.DEPTNO;






--4. 각 부서별 평균 급여액을 구하고 부서별 평균 급여액 보다 급여를 많이 받는 사원의 사원번호
-- 이름, 급여, 부서번호, 부서번호, 각 부서의 평균급여액을 구하시오.

SELECT E.EMPNO,E.ENAME, E.SAL, E.DEPTNO, D.DNAME, M.AV
FROM EMP E,
(SELECT DEPTNO, AVG(SAL) AV FROM EMP GROUP BY DEPTNO) M, DEPT D
WHERE  E.DEPTNO=D.DEPTNO
AND E.DEPTNO=M.DEPTNO
AND E.SAL>=M.AV
ORDER BY D.DNAME ASC;






--5. 각 부서별로 최고급여를 받는 직원의 부서명, 부서 아이디, 사원의 이름, SAL를 출력하시오.

SELECT E.ENAME, E.SAL, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D,
(SELECT DEPTNO, MAX(SAL) MX FROM EMP
GROUP BY DEPTNO) M
WHERE E.DEPTNO=D.DEPTNO
AND E.DEPTNO=M.DEPTNO
AND E.SAL = M.MX
ORDER BY DEPTNO ;


SELECT E.ENAME, E.SAL, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO
AND E.SAL IN (SELECT MAX(SAL) MX FROM EMP
            GROUP BY DEPTNO)
ORDER BY DEPTNO;






-- 6. 직속상사 보다 월급을 많이 받는 사원을 구하세요.

SELECT E.EMPNO, E.ENAME, M.EMPNO, M.ENAME, E.SAL EMPSAL, M.SAL MGRSAL ,(M.SAL-E.SAL) GAB
FROM EMP E, EMP M
WHERE E.MGR=M.EMPNO
AND E.SAL>M.SAL;





-- 7. 직속 상사와의 월급 차이가 가장 큰 사람과 같은 부서의 사원의
-- 사원번호, 이름, 부서명, 월급, 직장상사의 이름,직장상사의 급여, 직장상사와의 월급 차이를 출력해주세요.

SELECT P.EMPNO, P.ENAME, D.DNAME, P.SAL, P.MNAME, P.MSAL, P.GAB
FROM
      (SELECT A.EMPNO, A.ENAME, A.SAL, S.ENAME MNAME, S.SAL MSAL, A.DEPTNO, (S.SAL-A.SAL) GAB
         FROM EMP A, EMP S
            WHERE A.MGR=S.EMPNO
            ) P
            ,DEPT D
            ,(SELECT *
               FROM
            (SELECT MAX(M.SAL-E.SAL) GAB , E.DEPTNO
            FROM EMP E, EMP M
            WHERE E.MGR=M.EMPNO
            AND (M.SAL-E.SAL)>0
            GROUP BY  E.DEPTNO
            ORDER BY  MAX(M.SAL-E.SAL) DESC)
            WHERE ROWNUM =1
            ) Q
WHERE P.DEPTNO=D.DEPTNO
AND P.DEPTNO=Q.DEPTNO;
----------------------------------------------
--내풀이
SELECT f.empno, f.ename, f.deptno, f.sal, g.ename, g.sal, ABS((g.sal-f.sal))
FROM (SELECT ROWNUM, a.DEPTNO
					FROM EMP a, (SELECT ABS(m.SAL-e.SAL) ms, e.empno
         	                    FROM EMP e, EMP m
          	                  WHERE e.MGR=m.EMPNO
                              ORDER BY ms desc) s
					WHERE a.EMPNO=s.empno
          AND rownum=1) c, EMP f, EMP g
WHERE c.deptno=f.deptno
AND f.mgr=g.empno(+)



 -- 8. 사원수가 2명이 넘는 부서의 부서명, 근무지역을 출력하세요.

 SELECT E.DEPTNO, D.DNAME, D.LOC
 FROM DEPT D,
          (
            SELECT DEPTNO, COUNT(*) FROM EMP
            GROUP BY DEPTNO
            HAVING COUNT(*)>2
            ) E
 WHERE D.DEPTNO=E.DEPTNO;





-- 9.ADAMS보다 급여가 높고 직종이 SALESMAN인 사원의 이름과 급여를 출력하세요.

SELECT M.ENAME,M.SAL
FROM EMP M,
      (
        SELECT E.SAL
        FROM EMP E
        WHERE UPPER(E.ENAME)=UPPER('ADAMS')
        ) F
WHERE M.SAL>F.SAL
AND UPPER(M.JOB)=UPPER('SALESMAN');





--10. 직종이 'CLERK'인 사원이 적어도 2명 이상 속한 부서 이름을 출력하세요.

SELECT E.DEPTNO, D.DNAME
FROM DEPT D,
      (
        SELECT DEPTNO, COUNT(*)
        FROM EMP
        WHERE JOB='CLERK'
        GROUP BY DEPTNO
        HAVING COUNT(*)>=2
        ) E
WHERE E.DEPTNO=D.DEPTNO;


--nvl함수--
널값을 0으로 치환해서 컬럼의 수를 센다
SELECT COUNT(nvl(comm, 0))
FROM EMP;

SELECT * FROM EMP;

SELECT COUNT(*) FROM EMP;

