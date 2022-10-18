--DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸� ���
SELECT e.ENAME
				, e.JOB
        , e.DEPTNO
        , d.DNAME
FROM DEPT d
				,EMP e
WHERE d.LOC = 'DALLAS'
 AND e.DEPTNO = d.DEPTNO;

 --����̸��� �� ����� ���� �μ��� �μ���, ��������ϴµ� ������ 3000�̻��� ��� ���
 SELECT e.ENAME
 					,d.DNAME
 					,e.SAL
 FROM EMP e
 				, DEPT d
 WHERE e.SAL > 3000
  AND e.DEPTNO = d.DEPTNO;

  --������ 'SALESMAN'�� ������� ������ �� ����̸�, �μ��̸� ���
  SELECT e.ENAME
  				, e.JOB
  				, d.DNAME
  FROM EMP e
  				,DEPT d
  WHERE e.DEPTNO =d.DEPTNO
   AND e.JOB = 'SALESMAN';

--Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�, �޿������ ����ϵ�,
--������ Į������ '�����ȣ', '����̸�' , '����', '�Ǳ޿�', '�޿����'���� ���
SELECT e.ENAME ����̸�
				, e.EMPNO �����ȣ
        , e.SAL*12 ����
        , e.sal*12+NVL(e.COMM,0) �Ǳ޿�
        , s.GRADE �޿����
FROM EMP e
				,SALGRADE s
 where e.sal between s.losal and s.hisal;

--�μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�, ����, �޿���� ���
SELECT d.DEPTNO
				, d.DNAME
        , e.ENAME
        , e.SAL
        , s.GRADE
FROM EMP e
				,DEPT d
        ,SALGRADE s
WHERE  e.DEPTNO=10
AND e.DEPTNO =d.DEPTNO
AND e.sal BETWEEN s.losal AND s.hisal
ORDER BY s.GRADE;

--�μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�, ����̸�, ����, �޿���� ���
--��µ� ������� �μ���ȣ�� ����������, ������ ���������� ����
SELECT d.DEPTNO
				, d.DNAME
        , e.ENAME
        , e.SAL
        , s.GRADE
FROM EMP e
				,DEPT d
        ,SALGRADE s
WHERE e.DEPTNO =d.DEPTNO
 AND e.SAL BETWEEN s.LOSAL AND s.HISAL
 AND (e.DEPTNO = 10 OR e.DEPTNO = 20)
ORDER BY e.DEPTNO ASC
						, e.SAL DESC;

--�����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� �������� �����ȣ�� ����̸��� ���
--���� '�����ȣ', '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ���
SELECT  e.EMPNO �����ȣ
					,e.ENAME ����̸�
					,m.EMPNO �����ڹ�ȣ
          ,m.ENAME �������̸�
FROM EMP e
				,EMP m
WHERE e.MGR = m.EMPNO;











