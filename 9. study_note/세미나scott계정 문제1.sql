-- 30�� �μ��� ����� �����ȣ��, �̸� , �μ����� ����Ͻÿ�. SCOTT/ EMP���̺�
SELECT e.EMPNO, e.ENAME, d.DNAME
FROM EMP e, DEPT d
WHERE e.DEPTNO=d.DEPTNO
 AND d.DEPTNO=30




--BLAKE�� ���� �μ��� ������ �̸��� �Ի����� ����ϼ���. SCOTT/ EMP���̺�
SELECT e.ENAME
				 ,e.HIREDATE
FROM EMP e
WHERE e.DEPTNO IN (SELECT deptno FROM EMP WHERE ename='BLAKE');


--BLAKE�� ���� �μ��� ������ �̸��� �Ի����� ����ϼ���. SCOTT/ EMP���̺�
SELECT e.ename, e.hiredate
FROM EMP e, (SELECT deptno
									FROM EMP e
									WHERE e.ename = 'BLAKE') m
WHERE  e.DEPTNO =m.deptno;



--  KING�� �������� ����� �����ȣ�� �̸�, �μ����� ����ϼ���. SCOTT/ EMP���̺�
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



-- �� �μ��� ��� �޿����� ���ϰ� �μ��� ��� �޿��� ���� �޿��� ���� �޴� ����� �����ȣ
-- �̸�, �޿�, �μ���ȣ, �μ��̸�, �� �μ��� ��ձ޿����� ���Ͻÿ�.
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




-- �� �μ��� ��� �޿����� ���ϰ� �μ��� ��� �޿��� ���� �޿��� ���� �޴� ����� �����ȣ
-- �̸�, �޿�, �μ���ȣ, �μ���, �� �μ��� ��ձ޿����� ���Ͻÿ�.
SELECT e.empno, e.ename, e.sal, e.deptno, d.asal
FROM EMP e, (SELECT deptno, avg(sal) asal FROM EMP GROUP BY deptno) d
WHERE e.DEPTNO=d.deptno
AND e.sal > d.asal
ORDER BY e.DEPTNO








select rownum, deptno, gap
        from (select e.deptno, (m.sal - e.sal) gap
                from emp e, emp m
                where e.mgr = m.empno
                order by gap desc);									------>���������� ���� ���� rownum�� �ϴ� ���� : order by �� ���� ������ ��, rownum�� �ϱ� ����

------------------------------------------------

select e.deptno, (m.sal - e.sal) gap, rownum
                from emp e, emp m
                where e.mgr = m.empno
                order by gap DESC;								------->���������� ������ ������ rownum�� ���� ������ ���� order by �ϱ� ������ rownum���� ���� ����







--�� �μ����� �ְ�޿��� �޴� ������ �μ���, �μ� ���̵�, ����� �̸�, SAL�� ����Ͻÿ�.
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



--*5. �� �μ����� �ְ�޿��� �޴� ������ �μ���, �μ� ���̵�, ����� �̸�, SAL�� ����Ͻÿ�.
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





-- ���ӻ�� ���� ������ ���� �޴� ����� ���ϼ���.
SELECT e.ENAME
				, e.sal
        , m.ENAME m_ename
        , m.sal m_sal
FROM EMP e
				,EMP m
WHERE e.MGR = m.EMPNO
 AND e.sal > m.sal








-- ���� ������ ���� ���̰� ���� ū ����� ���� �μ��� �����
-- �����ȣ, �̸�, �μ���, ����, �������� �̸�,�������� �޿�, ��������� ���� ���̸� ������ּ���.



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



-- ���� ������ ���� ���̰� ���� ū ����� ���� �μ��� �����
-- �����ȣ, �̸�, �μ���, ����, �������� �̸�,�������� �޿�, ��������� ���� ���̸� ������ּ���.
SELECT e.EMPNO, e.DEPTNO, e.ENAME, d.DNAME, e.SAl, e1.ENAME ������, e1.SAL �����, (e1.SAL-e.SAL) GAP
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
AND f.mgr=g.empno(+);												--ABS : ���밪�� ���ϴ� �Լ�









 -- ������� 2���� �Ѵ� �μ��� �μ���, �ٹ������� ����ϼ���.
SELECT a.deptno
				, d.dname
				, d.loc
FROM (SELECT e.DEPTNO, count(*)
					FROM EMP e
          GROUP BY e.DEPTNO
          HAVING COUNT(*)>=2) a
          ,DEPT d
WHERE d.deptno = a.deptno;



-- ADAMS���� �޿��� ���� ������ SALESMAN�� ����� �̸��� �޿��� ����ϼ���.
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





--������ 'CLERK'�� ����� ��� 2�� �̻� ���� �μ� �̸��� ����ϼ���.
SELECT a.DEPTNO
				, d.DNAME
FROM DEPT d
				,(SELECT e.DEPTNO
        FROM EMP e
        WHERE e.JOB='CLERK'
        GROUP BY e.DEPTNO
        HAVING COUNT(*)>=2) a
WHERE d.DEPTNO =a.deptno;



