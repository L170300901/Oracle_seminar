-- 1. EMP ���̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ���� ����϶�.
SELECT deptno, count(*),SUM(sal)
FROM emp
GROUP BY deptno
HAVING COUNT(*)>4;


-- 2. EMP ���̺��� ���� ���� ����� �����ִ� �μ���ȣ�� ������� ����϶�.
SELECT deptno, COUNT(*)
FROM EMP
GROUP BY deptno
HAVING COUNT(*)=(SELECT MAX(COUNT(*))
																		FROM emp
                                    GROUP BY deptno);


SELECT ROWNUM,n.*
FROM  (SELECT deptno,COUNT(*) num
										FROM EMP
										GROUP BY deptno
                    ORDER BY num desc) n
WHERE rownum=1;

-- 3. EMP ���̺��� ���� ���� ����� ���� MGR�� �����ȣ�� ����϶�.
SELECT mgr
FROM EMP
GROUP BY mgr
HAVING COUNT(*)=(SELECT max(COUNT(*))
														FROM EMP
														GROUP BY mgr);



-- 4. EMP ���̺��� �μ���ȣ�� 10�� ������� �μ���ȣ�� 30�� ������� ���� ����϶�.
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING deptno IN(10,30);



SELECT
COUNT(DECODE(deptno,10,1)) "10",
COUNT(DECODE(deptno,30,1)) "30"
FROM EMP;



-- 5. EMP ���̺��� �����ȣ�� 7521�� ����� ������ ���� �����ȣ�� 7934�� ����� �޿�(SAL)���� ���� �����
--�����ȣ, �̸�, ����, �޿��� ����϶�.
SELECT e.empno, e.ename, e.job, e.sal
FROM (SELECT job
					FROM emp
          WHERE empno=7521) j,
          (SELECT sal
          FROM emp
          WHERE empno=7934) s,
          EMP e
WHERE j.job=e.job
AND e.sal>s.sal;


SELECT empno, ename, job, sal
FROM emp
WHERE job=(SELECT job
					FROM emp
          WHERE empno=7521)
AND sal>(SELECT sal
							FROM emp
              WHERE empno=7934);




-- 6. ����(JOB)���� �ּ� �޿��� �޴� ����� ������ �����ȣ, �̸�, ����, �μ����� ����϶�.
-- ����1 : �������� �������� ����
SELECT e.empno, e.ename, e.job, d.dname
FROM EMP e, (SELECT MIN(sal) salary, job
										FROM emp
										GROUP BY job) j, DEPT d
WHERE e.sal=j.salary
AND e.job=j.job
AND e.DEPTNO=d.deptno
ORDER BY job DESC;




-- 7. �� ��� �� �ñ��� ����Ͽ� �μ���ȣ, ����̸�, �ñ��� ����϶�.
-- ����1. �Ѵ� �ٹ��ϼ��� 20��, �Ϸ� �ٹ��ð��� 8�ð��̴�.
-- ����2. �ñ��� �Ҽ� �� ��° �ڸ����� �ݿø��Ѵ�.
-- ����3. �μ����� �������� ����
-- ����4. �ñ��� ���� ������ ���



-- 8. �� ��� �� Ŀ�̼��� 0 �Ǵ� NULL�̰� �μ���ġ�� ��GO���� ������ ����� ������
--�����ȣ, ����̸�, Ŀ�̼�, �μ���ȣ, �μ���, �μ���ġ�� ����϶�.
-- ����1. ���ʽ��� NULL�̸� 0���� ���



-- 9. �� �μ� �� ��� �޿��� 2000 �̻��̸� �ʰ�, �׷��� ������ �̸��� ����϶�.



-- 10. �� �μ� �� �Ի����� ���� ������ ����� �� �� ������ �����ȣ, �����, �μ���ȣ, �Ի����� ����϶�.
SELECT  e.empno, e.ename, e.deptno, e.hiredate
FROM (SELECT deptno,min(hiredate) hdate
					FROM emp
          GROUP BY deptno )h, EMP e
WHERE e.deptno=h.deptno(+)
AND e.HIREDATE = h.hdate;


--�μ���ȣ�� ���� ������ ��������
SELECT t1.empno, t1.ename, t1.deptno, t1.hiredate
  FROM (SELECT e.empno, e.ename, e.deptno, e.hiredate
            FROM (SELECT deptno, min(hiredate) hdate
                      FROM emp
                      GROUP BY deptno)h, EMP e
            WHERE e.deptno=h.deptno(+) )t1, (SELECT deptno,min(hiredate) hdate
					                                                 FROM emp
                                                           GROUP BY deptno) t2
 WHERE t2.hdate = t1.hiredate;





-- 11. 1980��~1980�� ���̿� �Ի�� �� �μ��� ������� �μ���ȣ, �μ���, �Ի�1980, �Ի�1981, �Ի�1982�� ����϶�.



-- 12. 1981�� 5�� 31�� ���� �Ի��� �� Ŀ�̼��� NULL�̰ų� 0�� ����� Ŀ�̼��� 500���� �׷��� ������ ���� Ŀ�̼��� ����϶�.



-- 13. 1981�� 6�� 1�� ~ 1981�� 12�� 31�� �Ի��� �� �μ����� SALES�� ����� �μ���ȣ, �����, ����, �Ի����� ����϶�.
-- ����1. �Ի��� �������� ����



-- 14. ���� �ð��� ���� �ð����κ��� �� �ð� ���� �ð��� ����϶�.
-- ����1. ����ð� ������ ��4�ڸ���-2���Ͽ�-2�ڸ��� 24��:2�ڸ���:2�ڸ��ʡ��� ���
-- ����1. �ѽð��� ������ ��4�ڸ���-2���Ͽ�-2�ڸ��� 24��:2�ڸ���:2�ڸ��ʡ��� ���




-- 15. �� �μ��� ������� ����϶�.
-- ����1. �μ��� ������� ������ �μ���ȣ, �μ����� ���
-- ����2. �μ��� ������� 0�� ��� �������� ���
-- ����3. �μ���ȣ �������� ����



-- 16. ��� ���̺��� �� ����� �����ȣ, �����, �Ŵ�����ȣ, �Ŵ������� ����϶�.
-- ����1. �� ����� �޿�(SAL)�� �Ŵ��� �޿����� ���ų� ����.



-- 18. ������� ù ���ڰ� ��A���̰�, ó���� �� ���̿� ��LL���� ���� ����� Ŀ�̼��� COMM2�϶�,
--��� ����� Ŀ�̼ǿ� COMM2�� ���� ����� �����, COMM, COMM2, COMM+COMM2�� ����϶�.



-- 19. �� �μ����� 1981�� 5�� 31�� ���� �Ի����� �μ���ȣ, �μ���, �����ȣ, �����, �Ի����� ����Ͻÿ�.
-- ����1. �μ��� ��������� ������ �μ���ȣ, �μ����� ���
-- ����2. �μ���ȣ �������� ����
-- ����3. �Ի��� �������� ����




-- 20. �Ի��Ϸκ��� ���ݱ��� �ٹ������ 30�� �̻� �̸��� ����� �����ȣ, �����, �Ի���, �ٹ������ ����϶�.
-- ����1. �ٹ������ ���� �������� ���� (��:30.4�� = 30��, 30.7��=30��)



