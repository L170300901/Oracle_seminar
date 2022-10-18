from / join / select

SELECT * FROM EMP;

-- 1. SMITH ����� �����ȣ, �̸�, ���ӻ�� �̸��� �����´�.

SELECT empno, ename, (SELECT m.ename FROM EMP m WHERE e.mgr = m.empno) mgr FROM EMP e WHERE ename = 'SMITH';

SELECT e.empno, e.ename, m.ename FROM EMP e, (SELECT ename, empno FROM EMP) m WHERE e.mgr = m.empno AND e.ename='SMITH';

SELECT e.empno, e.ename, m.ename mgr FROM EMP e JOIN EMP m ON e.mgr = m.empno WHERE e.ename = 'SMITH';


-- 2. FORD ��� �ؿ��� ���ϴ� ������� �����ȣ, �̸�, ������ �����´�.

???? ��Į�� ��������

SELECT (SELECT empno FROM EMP e WHERE e.mgr = m.empno) empno, (SELECT ename FROM EMP e WHERE e.mgr = m.empno) ename,  (SELECT job FROM EMP e WHERE e.mgr = m.empno) job  FROM EMP m WHERE m.ename= 'FORD';

SELECT e.empno, e.ename, e.job FROM EMP e, (SELECT ename, empno FROM EMP WHERE ename = 'FORD') m WHERE e.mgr = m.empno;

SELECT e.empno, e.ename, e.job FROM EMP e JOIN EMP m ON e.mgr = m.empno where m.ename = 'FORD';


-- 3. SMITH ����� ���ӻ���� ������ ������ ������ �ִ� ������� �����ȣ, �̸�, ������ �����´�.

��Į�� ���������� SELECT ���� ���� ���� ������ �ѹ��� ����� 1�྿ ��ȯ�Ѵ� ==> SELECT �� �������� ����� �ȵȴ�.

???? ��Į�� ��������

SELECT s.empno, s.ename, s.job FROM EMP s, (SELECT m.job FROM EMP e, EMP m WHERE e.mgr = m.empno AND e.ename = 'SMITH') m WHERE m.job = s.job;

SELECT s.empno, s.ename, s.job  FROM EMP e, EMP m, EMP s WHERE e.mgr = m.empno AND m.job = s.job AND E.eNAME = 'SMITH';


-- 4. �� ����� �̸�, �����ȣ, ������(���ӻ��) �̸��� �����´�. �� ���ӻ���� ���� ����� �����´�.

/*
--������ �� �ָ��Ѱ� ���ٰ� ������ �� .. ��簡 ���� �����  ����̶�� �ϳ���?
    --���� ����� ���� �� �ָ���..
    --> 1.���ӻ�縦 ���Ͻÿ�
    --> 2. �����縦 ���Ͻÿ�
    --�ΰ��� ���� �ٸ� (�� ����)
--�츮�� ���ӻ�縦 ������!
*/
SELECT e.ename, e.empno, (SELECT m.ename FROM EMP m WHERE e.mgr = m.empno) mname FROM EMP e;

SELECT e.ename, e.empno, m.ename mname FROM EMP e, (SELECT empno, ename FROM EMP) m WHERE e.mgr = m.empno(+);

SELECT e.ename, e.empno, m.ename mname FROM EMP e, EMP m WHERE e.mgr = m.empno(+);

-- 5. ��� �μ��� �Ҽ� ����� �ٹ��μ���, �����ȣ, ����̸�, �޿��� �����´�.

SELECT (SELECT dname FROM DEPT d WHERE d.deptno = e.deptno) dname, empno, ename, sal FROM EMP e;

SELECT d.dname, e.empno, e.ename, e.sal FROM EMP e, (SELECT deptno, dname FROM dept) d WHERE e.deptno = d.deptno;

SELECT d.dname, e.empno, e.ename, e.sal FROM EMP e, DEPT d WHERE e.deptno = d.deptno;

-- 6. SCOTT ����� �ٹ��ϰ� �ִ� �μ��� �̸��� �����´�.

SELECT (SELECT dname FROM DEPT d WHERE e.deptno = d.deptno) dname FROM EMP e WHERE ename = 'SCOTT';

SELECT d.dname FROM EMP e, (SELECT dname, deptno FROM dept) d WHERE e.deptno = d.deptno and e.ename = 'SCOTT';

SELECT d.dname FROM EMP e JOIN DEPT d ON e.deptno = d.deptno WHERE e.ename = 'SCOTT';


-- 7. SMITH�� ���� �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, ����, �μ��̸��� �����´�.

SELECT e.empno, e.ename, e.sal, (SELECT dname FROM DEPT d WHERE e.deptno = d.deptno ) dname FROM EMP e, EMP j WHERE j.deptno = e.deptno AND  j.ename = 'SMITH';

SELECT e.empno, e.ename, e.sal, d.dname from EMP e, DEPT d, (SELECT deptno FROM EMP j WHERE j.ename = 'SMITH') j WHERE e.deptno = d.deptno AND e.deptno = j.deptno;

SELECT e.empno, e.ename, e.sal, d.dname from EMP e, EMP j, DEPT d WHERE j.ename = 'SMITH' AND j.deptno = d.deptno AND j.deptno = e.deptno;


-- 8. MARTIN�� ���� ������ ������ �ִ� ������� �����ȣ, �̸�, ������ �����´�.

SELECT e.empno, e.ename, (SELECT job FROM EMP j WHERE j.empno = e.empno) job FROM EMP e, EMP m WHERE m.ename = UPPER('martin') and m.job = e.job;

SELECT e.empno, e.ename, e.job FROM EMP e, (SELECT job FROM EMP WHERE ename = UPPER('martin')) j WHERE j.job = e.job;

SELECT e.empno, e.ename, e.job FROM EMP e, EMP j WHERE j.ename = UPPER('martin') AND j.job = e.job;


-- 9. ALLEN�� ���� ���ӻ���� ���� ������� �����ȣ, �̸�, ���ӻ���̸��� �����´�.

???? ��Į�� ��������

SELECT e.empno, e.ename, (SELECT ename FROM EMP b WHERE s.mgr = b.empno) mname FROM EMP e, EMP m, EMP s WHERE s.ename = UPPER('allen') AND e.mgr = m.empno AND s.mgr = m.empno;

SELECT e.empno, e.ename, m.ename mname FROM EMP e, (SELECT b.ename, b.empno FROM EMP s, EMP b WHERE s.mgr = b.empno AND s.ename = UPPER('allen')) m where m.empno = e.mgr;

SELECT b.empno, b.ename, m.ename mname FROM EMP e, EMP m, EMP b WHERE e.ename = UPPER('allen') AND e.mgr = m.empno AND m.empno = b.mgr;

-- 10. WARD�� ���� �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �μ���ȣ�� �����´�.

???? ��Į�� ��������

SELECT e.empno, e.ename, e.deptno FROM EMP e, (SELECT deptno FROM EMP d WHERE ename = UPPER('ward')) d WHERE e.deptno = d.deptno;

SELECT e.empno, e.ename, e.deptno FROM EMP e, EMP d WHERE d.ename=UPPER('ward') AND e.deptno = d.deptno;

-- 11. SALESMAN�� ��� �޿����� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.
/*
  --�� ������ ������ salesman�� ����� ��� �ǵ� �����ڴ�
*/

???? ��Į�� ��������

SELECT e.empno, e.ename, (SELECT sal FROM EMP a WHERE a.empno = e.empno) sal FROM EMP e,  (SELECT AVG(sal) AVG FROM EMP WHERE job = UPPER('salesman')) s WHERE e.sal > S.AVG;

SELECT e.empno, e.ename, e.sal FROM EMP e, (SELECT AVG(sal) avg FROM EMP GROUP BY job HAVING job = UPPER('salesman')) A WHERE e.sal > A.AVG;

SELECT e.empno, e.ename, e.sal FROM EMP e, EMP s WHERE s.job = UPPER('salesman') GROUP BY  e.empno, e.ename, e.sal HAVING e.sal > AVG(s.sal);

-- 12. DALLAS ������ �ٹ��ϴ� ������� ��� �޿��� �����´�.

SELECT (SELECT AVG(sal) FROM EMP e WHERE e.deptno= d.deptno) avg FROM DEPT d WHERE d.loc = UPPER('dallas');

SELECT AVG(sal) FROM EMP e, (SELECT deptno FROM DEPT WHERE loc = UPPER('dallas')) d WHERE e.deptno = d.deptno;

SELECT AVG(sal) FROM EMP e JOIN DEPT  d ON e.DEPTNO = D.deptno AND d.loc = UPPER('dallas');

-- 13. SALES �μ��� �ٹ��ϴ� ������� �����ȣ, �̸�, �ٹ������� �����´�.

???? ��Į�� ��������

SELECT e.empno, e.ename, (SELECT loc FROM DEPT d WHERE dname = UPPER('sales') AND  e.deptno = d.deptno) loc FROM EMP e, DEPT d;

SELECT e.empno, e.ename, d.loc FROM EMP e,(SELECT deptno, loc FROM DEPT WHERE dname = UPPER('sales')) d WHERE e.deptno = d.deptno;

SELECT e.empno, e.ename, d.loc FROM EMP e JOIN DEPT d ON e.deptno = d.deptno WHERE d.dname = UPPER('sales');


-- 14. CHICAGO ������ �ٹ��ϴ� ����� �� BLAKE�� ���ӻ���� ������� �����ȣ, �̸�, ������ �����´�.

???? ��Į�� ��������

SELECT e.empno, e.ename, e.job FROM DEPT d, (SELECT a.empno, a.ename, a.job, a.deptno FROM EMP a, EMP m WHERE a.mgr = m.empno and m.ename = UPPER('blake')) e WHERE d.deptno = e.deptno and d.loc = UPPER('chicago');

SELECT e.empno, e.ename, e.job FROM EMP e, EMP m, DEPT d WHERE e.deptno = d.deptno AND e.mgr = m.empno AND d.loc = UPPER('chicago') AND m.ename=UPPER('blake');


-- 15. 3000 �̻��� �޿��� �޴� ������ ���� �μ��� �ٹ��ϰ� �ִ� ����� �����ȣ, �̸�, �޿��� �����´�

???? ��Į�� ��������

SELECT distinct e.empno, e.ename, (SELECT sal FROM EMP n WHERE e.empno = n.empno) sal FROM EMP e, EMP s WHERE s.deptno = e.deptno AND s.sal >= 3000;

SELECT e.empno, e.ename, e.sal FROM EMP e, (SELECT DISTINCT deptno FROM EMP WHERE sal >= 3000) d WHERE e.deptno = d.deptno;

SELECT DISTINCT e.empno, e.ename, e.sal FROM EMP e, EMP s WHERE s.deptno = e.deptno AND s.sal >= 3000;

SELECT DISTINCT e.empno, e.ename, e.sal FROM EMP e, EMP s WHERE s.deptno = e.deptno AND s.sal >= 3000 GROUP BY e.empno, e.ename, e.sal;


-- 16. ������ CLERK�� ����� ������ �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �Ի��� �����´�.

/*
clerk�� ������� ��� �μ��� �ִ�
�μ��� �ٹ��ϰ� �ִ� ������� ������� �ǰ�? (�� ����)
*/

???? ��Į�� ��������

SELECT e.empno, e.ename, e.hiredate FROM EMP e, (SELECT distinct deptno FROM EMP WHERE job = UPPER('clerk')) j WHERE e.deptno = j.deptno;

SELECT distinct e.empno, e.ename, e.hiredate FROM EMP e, EMP j where e.deptno = j.deptno and j.job = UPPER('clerk');


-- 17. KING�� ���ӻ������ ������ �ִ� ������� �ٹ��ϰ� �ִ� �ٹ� �μ���, ������ ������´�.

???? ��Į�� ��������

SELECT d.dname, d.loc FROM (SELECT d.dname, d.loc, e.empno, e.mgr FROM DEPT d, EMP e WHERE e.deptno = d.deptno) d, EMP m WHERE m.ename = UPPER('king') AND m.empno = d.mgr;

SELECT d.dname, d.loc FROM DEPT d, EMP e, EMP m WHERE m.ename = UPPER('king') and e.mgr = m.empno and e.deptno = d.deptno;

-- 18. CLERK���� ���ӻ���� �����ȣ, �̸�, �޿��� �����´�.

???? ��Į�� ��������

SELECT m.empno, m.ename, m.sal FROM EMP m, (SELECT mgr FROM EMP WHERE job = UPPER('clerk')) e WHERE m.empno = e.mgr;

SELECT m.empno, m.ename, m.sal FROM EMP e, EMP m WHERE e.job = UPPER('clerk') AND e.mgr = m.empno;

-- 19. �� �μ��� �޿� ��պ��� �� ���� �޴� ����� �����ȣ, �̸�, �޿��� �����´�.

???? ��Į�� ��������

SELECT e.empno, e.ename, e.sal FROM EMP e, (SELECT deptno, AVG(sal) avg FROM EMP GROUP BY deptno) a WHERE e.deptno = a.deptno AND e.sal > a.avg GROUP BY  e.empno, e.ename, e.sal, e.deptno;

SELECT e.empno, e.ename, e.sal FROM EMP e, EMP s WHERE e.deptno = s.deptno GROUP BY e.empno, e.ename, e.sal, e.deptno  HAVING e.sal > AVG(s.sal);


-- 20. �� �μ��� �޿� ����ġ���� �� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.

???? ��Į�� ��������

SELECT e.empno, e.ename, e.sal FROM EMP e, (SELECT deptno, min(sal) MIN FROM EMP GROUP BY deptno) m WHERE e.deptno = m.deptno AND e.sal > M.MIN GROUP BY e.empno, e.ename, e.sal, e.deptno;

SELECT e.empno, e.ename, e.sal FROM EMP e, EMP m WHERE e.deptno = m.deptno GROUP BY e.empno, e.ename, e.sal, e.deptno HAVING e.sal > min(m.sal);

-- 21. SALESMAN ���� �޿��� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.

/*
-�ռҸ���? job�� salesman�� ������� ���� �޴´ٴ� ���� ������ ��ȣ��
--������ salesman�� min �޿� ���� �� ���� �޴� ����� �޿��� ��� �غ���
*/

???? ��Į�� ��������

SELECT empno, ename, sal FROM EMP WHERE sal < ANY (SELECT sal FROM EMP WHERE job = UPPER('salesman'));

SELECT distinct e.empno, e.ename, e.sal FROM EMP e, (SELECT sal FROM EMP where job = UPPER('salesman')) j WHERE e.sal < ANY(j.sal);

SELECT distinct  e.empno, e.ename, e.sal FROM EMP e, EMP j WHERE j.job = UPPER('salesman') AND e.sal < ANY(j.sal);


-- 23. DALLAS�� �ٹ��ϰ� �ִ� ����� �� ���� ���߿� �Ի��� ����� �Ի� ��¥���� �� ���� �Ի���
-- ������� �����ȣ, �̸�, �Ի����� �����´�.

???? ��Į�� ��������

SELECT  empno, ename, hiredate FROM EMP WHERE hiredate < (SELECT max(hiredate) FROM EMP h, DEPT d WHERE h.deptno = d.deptno AND d.loc = UPPER('dallas'));

SELECT e.empno, e.ename, e.hiredate FROM EMP e, (SELECT MAX(hiredate) hiredate FROM EMP m, DEPT d WHERE m.deptno = d.deptno AND d.loc = UPPER('dallas')) h WHERE e.hiredate < h.hiredate;

SELECT e.empno, e.ename, e.hiredate FROM EMP e, DEPT d, EMP h WHERE h.deptno = d.deptno AND d.loc= UPPER('dallas') GROUP BY e.empno, e.ename, e.hiredate HAVING e.hiredate < max(h.hiredate);
