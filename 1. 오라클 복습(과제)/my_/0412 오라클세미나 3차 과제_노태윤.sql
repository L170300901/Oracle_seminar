SELECT *FROM member;




01212/*
				�� ������ �̹� ���� ��Ģ ��

				1. ��½� �������� ���� �Ҽ������� ���ð�� TRUNC�Լ��� ����ؼ� ������ ���
				2. deptno ���� ����Ҷ� deptno�� order by �����ؼ� ���
        3. S_emp�� S_dept ���̺��� ������� �ʰ� emp�� dept ���̺��� ���

*/

												--����




-- 1. �� �μ��� ������� �޿� ����� ���Ѵ�.

--SELECT * FROM emp;
--SELECT * FROM dept;


		--1) �μ���ȣ�� ��� (�� .. �ٵ� ���� �ϸ� Ʋ���� ����)
SELECT deptno
     , TRUNC(AVG(sal)) sal_avg
  FROM EMP
 GROUP BY deptno
ORDER BY 1;

	/*          ���� �ϸ� �ȵ��� ������?
  						�ֳ��ϸ�
              >> dept ���̺� 'operations'�μ��� �ִµ�
                emp ���̺��� ���� 'operations'�μ��� �ٹ��ϴ� ����� ����
                but �μ����� ���϶�� ������ �μ���ü��  ����ؾ� ������? �ƴѰ�??
  */


--���� ���� �����ϴٰ� join�� �ؾߵ�
--�ٵ� ����  join ���ص� subquery ���� �ɵ�

		--2) �μ���ȣ+�μ��̸� ���
    		--nvl �Լ��� ������� ������
        --operation�μ��� ��հ��� null�� ���� null�� �ƴϰ� 0�� ������ ���� nvl�Լ� ���


SELECT d.deptno
     , d.dname
     , TRUNC(AVG(NVL(e.sal,0))) sal_avg
  FROM EMP e
     , DEPT d
 WHERE e.deptno(+)=d.deptno
 GROUP BY d.deptno
     ,d.dname
ORDER BY 1;


-- 2. 1500 �̻� �޿��� �޴� ������� �μ��� �޿� ����� ���Ѵ�.


SELECT deptno
     , TRUNC(AVG(sal))
  FROM EMP
 WHERE sal >= 1500
 GROUP BY deptno
ORDER BY 1;


-- 3. �μ��� ��� �޿��� 2000�̻��� �μ��� �޿� ����� �����´�.


			--���⼭���� �׳� �μ���ȣ�� ����ϰڽ��ϴ�....

SELECT deptno
     , TRUNC(AVG(sal)) sal_avg
  FROM EMP
 GROUP BY deptno
HAVING AVG(sal)>=2000
ORDER BY 1;

-- 4. �μ��� �ִ� �޿����� 3000������ �μ��� �޿� ������ �����´�.


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


-- 5. �μ��� �ּ� �޿����� 1000 ������ �μ����� ������ CLERK�� ������� �޿� ������ ���Ѵ�.


SELECT deptno
     ,SUM(sal)
  FROM EMP
 WHERE job=UPPER('clerk')
 GROUP BY deptno
HAVING MIN(sal)<=1000
ORDER BY 1;


-- 6. �� �μ��� �޿� �ּҰ� 900�̻� �ִ밡 10000������ �μ��� ����� �� 1500�̻���
-- �޿��� �޴� ������� ��� �޿����� �����´�.


SELECT deptno
     ,TRUNC(AVG(sal)) sal_avg
  FROM EMP
 WHERE sal >= 1500
 GROUP BY deptno
HAVING MIN(sal) BETWEEN 900 AND 10000
ORDER BY 1;


-- 7. ����� �����ȣ, �̸�, �ٹ������� �����´�.


SELECT e.EMPNO
     , e.ENAME
     , d.loc
  FROM EMP e
     , DEPT d
 WHERE e.DEPTNO = d.DEPTNO;


-- 8. DALLAS�� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, ������ �����´�.


SELECT e.EMPNO
     , e.ENAME
     , e.JOB
  FROM EMP e
     , DEPT d
 WHERE e.DEPTNO = d.DEPTNO
       AND d.LOC = UPPER('dallas');


-- 9. SALES �μ��� �ٹ��ϰ� �ִ� ������� �޿� ����� �����´�.


SELECT TRUNC(AVG(e.sal)) sal_avg
  FROM EMP e
     , DEPT d
 WHERE e.deptno=d.deptno
       AND d.dname=UPPER('sales')
 GROUP BY d.dname;


-- 10. �� ������� �����ȣ, �̸�, �޿�, �޿������ �����´�.


SELECT e.empno
     , e.ename
     , e.sal
     , s.grade
  FROM EMP e
     , SALGRADE s
 WHERE e.sal>=s.losal
       AND e.sal<=s.hisal;


-- 11. SALES �μ��� �ٹ��ϰ� �ִ� ����� �����ȣ, �̸�, �޿������ �����´�.

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

-- 12. �� �޿� ��޺� �޿��� ���հ� ���, ����Ǽ�, �ִ�޿�, �ּұ޿��� �����´�.


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


-- 13. �޿� ����� 4����� ������� �����ȣ, �̸�, �޿�, �ٹ��μ��̸�, �ٹ������� �����´�.


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