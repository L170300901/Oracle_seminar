-- 1. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸���
-- ����϶�.
SELECT e.ENAME, e.JOB, e.DEPTNO, d.DNAME
FROM (SELECT deptno, dname
					FROM DEPT
          WHERE loc='DALLAS') d, EMP e
WHERE e.DEPTNO=d.DEPTNO;


-- 2. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������
--����ϴµ� ������ 3000�̻��� ����� ����϶�.
SELECT e.ENAME, d.DNAME, e.SAL
FROM (SELECT ename, deptno, sal
					FROM EMP
          WHERE sal>=3000) e, DEPT d
WHERE e.DEPTNO=d.DEPTNO(+);


-- 3. ������ 'SALESMAN'�� ������� ������ �� ����̸�, �׸���
-- �� ����� ���� �μ� �̸��� ����϶�.
SELECT e.ENAME, e.JOB, d.DNAME
FROM (SELECT job, ename, deptno
					FROM EMP
          WHERE job='SALESMAN')e ,DEPT d
WHERE e.DEPTNO=d.DEPTNO(+);

-- 4. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�,
-- �޿������ ����ϵ�, ������ �÷����� '�����ȣ', '����̸�',
-- '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.

SELECT * FROM SALGRADE


-- 5. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�,
-- ����, �޿������ ����϶�.


-- 6. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�,
-- ����̸�, ����, �޿������ ����϶�. �׸��� �� ��µ�
-- ������� �μ���ȣ�� ���� ������, ������ ���� ������
-- �����϶�.


-- 7. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� ��������
-- �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ',
-- '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.
SELECT e.EMPNO �����ȣ, e.ENAME ����̸�, e.MGR �����ڹ�ȣ, m.EMPNO �������̸�
FROM EMP e, EMP m
WHERE e.MGR=m.EMPNO(+);

--��
-- 1. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸���
-- ����϶�.
select e.ename, e.job, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno and loc = 'DALLAS';


-- 2. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������
--����ϴµ� ������ 3000�̻��� ����� ����϶�.
select e.ename, d.dname, e.sal
where e.deptno = e.deptno AND e.sal >=3000;


-- 3. ������ 'SALESMAN'�� ������� ������ �� ����̸�, �׸���
-- �� ����� ���� �μ� �̸��� ����϶�.
select e.job, e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno AND e.job = 'SALESMAN';



-- 4. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�,
-- �޿������ ����ϵ�, ������ �÷����� '�����ȣ', '����̸�',
-- '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.
select e.empno "�����ȣ", e.ename "����̸�", e.sal*12 "����", e.sal*12+e.comm "�Ǳ޿�", s.grade "�޿����"
from emp e, salgrade s
where comm is not null AND e.sal between s.losal and s.hisal;



-- 5. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�,
-- ����, �޿������ ����϶�.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno AND
e.deptno = 10 AND e.sal BETWEEN s.losal AND s.hisal;



-- 6. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�,
-- ����̸�, ����, �޿������ ����϶�. �׸��� �� ��µ�
-- ������� �μ���ȣ�� ���� ������, ������ ���� ������
-- �����϶�.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno AND e.sal BETWEEN s.losal AND s.hisal AND
(e.deptno = 10 OR e.deptno  = 20)
order by deptno asc, sal desc;



-- 7. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� ��������
-- �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ',
-- '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.
select e.empno �����ȣ, e.ename ����̸�, e.mgr �����ڹ�ȣ, m.ename �������̸�
from emp e, emp m
where e.mgr = m.empno;

