1.ALLEN�� �μ��� ���� ������� �����, �Ի����� ����ϵ� ���� �޿������� ����ϼ���.
SELECT e.ename, e.hiredate
FROM (SELECT deptno
					FROM EMP
          WHERE ename='ALLEN')a, EMP e
WHERE a.deptno=e.deptno
ORDER BY sal DESC;

--1.����
SELECT E.ENAME,E.HIREDATE
FROM EMP E,
(SELECT *
FROM EMP
WHERE ename LIKE 'ALLEN') ANLLEN_DEPT
WHERE ANLLEN_DEPT.DEPTNO = E.DEPTNO;

!!!!! 2.���� ���� �޿��� �޴� ������� �Ի����� ���� ����� �̸�, �Ի����� ����ϼ���.
SELECT m.ENAME, m.HIREDATE
FROM (SELECT empno, hiredate
          FROM emp
          WHERE sal=(SELECT MAX(sal)
                           FROM emp))e, EMP m
WHERE m.HIREDATE>e.hiredate;

--����
SELECT ename, hiredate
FROM EMP
WHERE hiredate >(
SELECT hiredate
FROM EMP
WHERE sal =(
SELECT MAX(sal)
FROM EMP) );

--��
SELECT ENAME,HIREDATE
FROM EMP
WHERE HIREDATE >
(SELECT HIREDATE FROM EMP WHERE SAL=(SELECT MAX(SAL) FROM EMP));



3.�̸��� "T"�ڰ� ���� ������� �޿��� ���� ���ϼ���. (LIKE)
SELECT SUM(sal)
FROM EMP
WHERE ename LIKE '%T%';

3.�̸��� "T"�ڰ� ���� ������� �޿��� ���� ���ϼ���. (LIKE)
SELECT SUM(SAL)
FROM EMP
WHERE ENAME LIKE '%T%';
<�ӵ����� Tip>
SELECT SUM(SAL)
FROM EMP
WHERE INSTR(ENAME,'T') > 0;



4.��� ����� ��ձ޿��� ���ϼ���.
SELECT AVG(sal)
FROM emp



5. �� �μ��� ��� �޿��� ���ϼ���. (GROUP BY)
SELECT TRUNC(AVG(sal),2)
FROM EMP
GROUP BY deptno;


6.�� �μ��� ��ձ޿�,��ü�޿�,�ְ�޿�,�����޿��� ���Ͽ� ��ձ޿���
   ���� ������ ����ϼ���.
SELECT TRUNC(AVG(sal),2) avs, SUM(sal), max(sal), MIN(sal)
FROM EMP
GROUP BY deptno
ORDER BY avs DESC;


7.20�� �μ��� �ְ� �޿����� ���� ����� �����ȣ,�����,�޿��� ����ϼ���.
SELECT e.empno, e.ename, e.sal
FROM (SELECT MAX(sal) ms
          FROM EMP
          WHERE deptno=20) m, EMP e
WHERE e.sal>m.ms;


!!!!!!!! 8.SMITH�� ���� �μ��� ���� ������� ��� �޿����� ū �޿��� �޴� ��� ����� �����,�޿��� ����ϼ���
SELECT e.ename, e.sal
FROM (SELECT AVG(sal) avs
					FROM emp
          WHERE deptno=(SELECT deptno FROM EMP WHERE ename='SMITH')) s, EMP e
WHERE e.sal>s.avs;

--��
SELECT ENAME,SAL
FROM EMP
WHERE SAL >
(SELECT AVG(SAL) FROM EMP WHERE DEPTNO=
  (SELECT DEPTNO FROM EMP WHERE ENAME='SMITH')
)


--�̰Ŵ� �� Ʋ����? ���̽��� ����� ���ߴ�
SELECT e.ename, e.sal
FroM (SELECT deptno, AVG(sal) avs
					FROM EMP
					WHERE ename='SMITH'
          GROUP BY deptno, AVG(sal)) s, EMP e
WHERE e.sal>s.avs



9.ȸ�系�� �ּұ޿��� �ִ�޿��� ���̸� ���ϼ���
SELECT max(sal)-min(sal)
FROM EMP




10.SCOTT�� �޿����� 1000 �� �� �޿����� ���� �޴� ����� �̸�,�޿���
    ����ϼ���.
SELECT e.ename, e.sal
FROM (SELECT sal
          FROM emp
          WHERE ename='SCOTT')s, EMP e
WHERE e.sal< s.sal-1000;

--����
SELECT ename,sal
FROM EMP
WHERE sal < (SELECT sal - 1000
										FROM EMP
                    WHERE ename = 'SCOTT'
                    )

--��
SELECT ENAME,SAL
FROM EMP
WHERE SAL < (SELECT SAL-1000 FROM EMP WHERE ENAME='SCOTT')



11.JOB�� MANAGER�� ����� �� �ּұ޿��� �޴� �������  �޿��� ����
    ����� �̸�, �޿��� ����ϼ���
SELECT e.ename, e.sal
FROM (SELECT min(sal) ms
          FROM  emp
          WHERE job='MANAGER') m,  EMP e
WHERE e.sal< m.ms;

--��
SELECT ENAME,SAL
FROM EMP
WHERE SAL<
(SELECT MIN(SAL) FROM EMP WHERE JOB='MANAGER')

--���� 11.JOB�� MANAGER�� ����� �� �ּұ޿��� �޴� �������  �޿��� ���� ����� �̸�, �޿��� ����ϼ���
SELECT E.ENAME,E.SAL
FROM EMP E,
(SELECT MIN(SAL) MIN_SAL
FROM EMP
WHERE JOB LIKE 'MANAGER') MIN_SAL
WHERE E.SAL < MIN_SAL.MIN_SAL



12.�̸��� S�� �����ϰ� ���������ڰ� H�� ����� �̸��� ����ϼ���.
SELECT ename
FROM EMP
WHERE ename LIKE 'S%H';


13.WARD�� �Ҽӵ� �μ� ������� ��� �޿����� , �޿��� ���� �����
    �̸� ,�޿��� ����ϼ���.
SELECT e.ename, e.sal
FROM (SELECT AVG(sal) avs
          FROM EMP
          WHERE deptno=(SELECT deptno FROM EMP WHERE ename='WARD')) w, EMP e
WHERE e.sal>w.avs;

--���� 13.WARD�� �Ҽӵ� �μ� ������� ��� �޿����� , �޿��� ���� ����� �̸� ,�޿��� ����ϼ���.
SELECT ename, sal
FROM EMP
WHERE sal > (
SELECT TRUNC(AVG(sal))
FROM EMP
WHERE deptno = (
SELECT deptno
FROM EMP
WHERE ename = 'WARD'))

14.EMP ���̺��� ��� ������� ����ϼ���.
SELECT COUNT(*)
FROM EMP

14-2 : �μ��� ������� ����ϼ���
SELECT deptno, COUNT(*)
FROM EMP
GROUP BY deptno;



15.������(JOB) ������� ����ϼ���
SELECT job, COUNT(*)
FROM EMP
GROUP BY job;


16.�ּұ޿��� �޴� ����� ���� �μ��� ��� ������� ����ϼ���.


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

