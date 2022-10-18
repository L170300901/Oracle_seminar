--ALLEN�� �μ��� ���� ������� �����, �Ի����� ����ϵ� ���� �޿������� ���
SELECT e.ENAME, e.HIREDATE
FROM EMP e
WHERE e.DEPTNO = (SELECT deptno FROM EMP WHERE ename='ALLEN')
ORDER BY e.sal DESC;



--1.ALLEN�� �μ��� ���� ������� �����, �Ի����� ����ϵ� ���� �޿������� ����ϼ���.
SELECT E.ENAME,E.HIREDATE
FROM EMP E,
				(SELECT *
				FROM EMP
				WHERE ename LIKE 'ALLEN') ANLLEN_DEPT
WHERE ANLLEN_DEPT.DEPTNO = E.DEPTNO;

--order by �� �ӵ����ϵ� ���ɼ��� ����




--���� ���� �޿��� �޴� ���������� �Ի����� ���� ����� �̸�, �Ի��� ���
SELECT e.ENAME, e.HIREDATE
FROM EMP e
				,(SELECT e1.HIREDATE
        FROM EMP e1
        WHERE e1.sal=(SELECT MAX(sal) FROM EMP)) m
WHERE m.hiredate < e.HIREDATE; -->�ε�ȣ����


--2.���� ���� �޿��� �޴� ������� �Ի����� ���� ����� �̸�, �Ի����� ����ϼ���.
SELECT ename, hiredate
FROM EMP
WHERE hiredate >(
												SELECT hiredate
												FROM EMP
												WHERE sal =(
																				SELECT MAX(sal)
																				FROM EMP) );



--�̸��� 'T'�ڰ� ���� ������� �޿��� �� ���
SELECT SUM(e.SAL)
FROM EMP e
WHERE e.ENAME LIKE '%T%';

3.�̸��� "T"�ڰ� ���� ������� �޿��� ���� ���ϼ���. (LIKE)
SELECT SUM(SAL)
FROM EMP
WHERE ENAME LIKE '%T%';
<�ӵ����� Tip>
SELECT SUM(SAL)
FROM EMP
WHERE INSTR(ENAME,'T') > 0;




--��� ����� ��ձ޿� ���
SELECT TRUNC(AVG(e.SAL),2)
FROM EMP e;





--�� �μ��� ��ձ޿� ���
SELECT TRUNC(AVG(e.sal),2)
FROM EMP e
GROUP BY e.DEPTNO;





--�� �μ��� ��ձ޿�, ��ü�޿�, �ְ�޿�, �����޿��� ���Ͽ� ��ձ޿��� ���� ������ ���
SELECT TRUNC(AVG(e.sal),2) trunc
				, sum(e.sal) sum
        , max(e.sal) max
        , min(e.sal) min
FROM EMP e
GROUP BY e.DEPTNO
ORDER BY AVG(e.sal) DESC;


--6.�� �μ��� ��ձ޿�,��ü�޿�,�ְ�޿�,�����޿��� ���Ͽ� ��ձ޿���
   ���� ������ ����ϼ���.
SELECT round(AVG(SAL),0), SUM(SAL), MAX(SAL), MIN(SAL)  --round�� �ݿø�, trunc�� �ڸ���
FROM EMP GROUP BY DEPTNO
ORDER BY AVG(SAL) DESC;



--20���μ��� �ְ�޿����� ���� ����� �����ȣ, �����, �޿� ���
SELECT e.EMPNO, e.ENAME, e.SAL
FROM EMP e
WHERE e.SAL > (SELECT max(sal) FROM EMP WHERE deptno=20);


--7. 20�� �μ��� �ְ� �޿����� ������ ����� �����ȣ,�����޿��� ����Ͻÿ�. SELECT*FROM EMP
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



--SMITH�� ���� �μ��� ���� ������� ��ձ޿����� ū �޿��� �޴� ��� ����� �����, �޿� ���
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





--ȸ�系�� �ּұ޿��� �ִ�޿� ���� ���
SELECT max(sal) - min(sal) gab
FROM EMP;

--SCOTT�� �޿����� 1000�� �� �޿����� ���� �޴� ����� �̸�, �޿����
SELECT e.ENAME, e.SAL
FROM EMP e
				,(SELECT sal-1000 scott_sal FROM EMP WHERE ename='SCOTT') s
WHERE e.sal < s.scott_sal;



--10.SCOTT�� �޿����� 1000 �� �� �޿����� ���� �޴� ����� �̸�,�޿���
    ����ϼ���.
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


--JOB�� MANAGER�� ����� �� �ּұ޿��� �޴� ������� �޿��� ���� ����� �̸�, �޿� ���
SELECT e.ENAME, e.SAL
FROM EMP e
				,(SELECT MIN(sal) sal
					FROM EMP
					WHERE job='MANAGER') ms
WHERE e.SAL < ms.sal;



--�̸��� S�� �����ϰ� ���������ڰ� H�� ����� �̸����
SELECT e.ENAME
FROM EMP e
WHERE e.ENAME LIKE 'S%H';




--WARD�� �Ҽӵ� �μ�������� ��ձ޿����� �޿��� ���� ����� �̸�,�޿����
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



--emp���̺��� ��� ����� ���
SELECT COUNT(*)
FROM EMP ;

--�μ��� ����� ���
SELECT deptno,COUNT(*)
FROM EMP
GROUP BY deptno
ORDER BY deptno;

--������ ����� ���
SELECT job, COUNT(*)
FROM EMP
GROUP BY job;

--�ּұ޿��� �޴� ����� ���� �μ��� ��� ����� ���
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

