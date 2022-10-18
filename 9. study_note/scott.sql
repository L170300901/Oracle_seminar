--������� �޿��� �޴� ������� �Ի����� ���� ����� �̸�, �Ի��� ���

SELECT e.ENAME, e.HIREDATE
FROM EMP e
WHERE e.HIREDATE>(SELECT e.HIREDATE
					FROM EMP e
          WHERE e.SAL=(SELECT MAX(e.sal)
          										FROM EMP e))

--ALLEN�� �μ��� ���� ������� �����, �Ի����� ����ϵ� ���� �޿������� ���

SELECT e.ENAME, e.HIREDATE
FROM EMP e
WHERE e.DEPTNO = (SELECT e.DEPTNO FROM EMP e WHERE e.ENAME='ALLEN')
ORDER BY e.SAL DESC;


--�̸��� 'T'�ڰ� ���� ������� �޿��� ��

SELECT SUM(e.SAL)
FROM EMP e
WHERE e.ENAME LIKE '%T%'


--������� ��ձ޿�

SELECT TRUNC(AVG(e.sal),2)
FROM EMP e


--�� �μ��� ��ձ޿�

SELECT e.DEPTNO, TRUNC(AVG(e.SAL),2)
FROM EMP e
GROUP BY e.DEPTNO
ORDER BY e.DEPTNO


--�� �μ��� ��ձ޿�, ��ü�޿�, �ְ�޿�, �����޿��� ���Ͽ� ��ձ޿��� ���������� ���

SELECT max(e.SAL), SUM(e.SAL), MIN(e.SAL), TRUNC(AVG(e.SAL),2) avg_sal
FROM EMP e
GROUP BY e.DEPTNO
ORDER BY avg_sal DESC;


--20�� �μ��� �ְ�޿����� ���� ����� �����ȣ, �����, �޿� ���

SELECT e.EMPNO, e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL > (SELECT MAX(e.SAL) FROM EMP e WHERE e.DEPTNO=20 )


--SMITH�� ���� �μ��� ���� ������� ��ձ޿����� ū �޿��� �޴� ��� ����� �����, �޿���� ***************




--ȸ�系�� �ּұ޿��� �ִ�޿��� ���� ���
SELECT max(e.SAL) - min(e.SAL)
FROM EMP e


--SCOTT�� �޿����� 1000�� �� �޿����� ���� �޴� ����� �̸�, �޿����
SELECT e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL < (SELECT e.SAL FROM EMP e WHERE e.ENAME='SCOTT') - 1000;


--JOB�� MANAGER�� ����� �߿��� �ּұ޿��� �޴� ������� �޿��� ���� ����� �̸�, �޿� ���
SELECT e.ENAME, e.sal
FROM EMP e,
				(SELECT min(e.sal) min_sal FROM EMP e WHERE e.JOB='MANAGER') m
WHERE m.min_sal > e.SAL ;


--�̸��� S�� �����ϰ� ���������ڰ� H�� ����� �̸� ���
SELECT e.ENAME
FROM EMP e
WHERE e.ENAME LIKE 'S%H';


--WARD�� �Ҽӵ� �μ� ������� ��� �޿����� �޿��� ���� ����� �̸�,�޿� ���
SELECT e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL> (SELECT TRUNC(AVG(e.sal)) avg_sal
										FROM EMP e
        					  WHERE e.DEPTNO = (SELECT e.DEPTNO
                    													FROM EMP e
                                              WHERE e.ENAME='WARD'))



--emp���̺��� ��� ��� �� ���
SELECT COUNT(*)
FROM EMP							--->���ڵ��� ���� � Į���� ������� ��� �������



--�μ��� ��� ��
SELECT COUNT(*)
FROM EMP
GROUP BY deptno


--�ּұ޿��� �޴� ����� ���� �μ��� ��� ����� ���
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



