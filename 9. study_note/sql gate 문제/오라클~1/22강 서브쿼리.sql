-- SCOTT ����� �ٹ��ϰ� �ִ� �μ��� �̸��� �����´�.
select dname
from dept
where deptno = (select deptno
                from emp
                where ename = 'SCOTT');

select a2.dname
from emp a1, dept a2
where a1.deptno = a2.deptno and a1.ename = 'SCOTT';

-- SMITH�� ���� �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �޿���, �μ��̸��� �����´�.
select a1.empno, a1.ename, a1.sal, a2.dname
from emp a1, dept a2
where a1.deptno = a2.deptno and a1.deptno = (select deptno
                                             from emp
                                             where ename = 'SMITH');

-- MARTIN�� ���� ������ ������ �ִ� ������� �����ȣ, �̸�, ������ �����´�.
select empno, ename, job
from emp
where job = (select job
             from emp
             where ename = 'MARTIN');

-- ALLEN�� ���� ���ӻ���� ���� ������� �����ȣ, �̸�, ���ӻ���̸��� �����´�.
-- a1 : ����� ����
-- a2 : ���ӻ�� ����
select a1.empno, a1.ename, a2.ename
from emp a1, emp a2
where a1.mgr = a2.empno and a1.mgr = (select mgr
                                      from emp
                                      where ename='ALLEN');

-- WARD�� ���� �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �μ���ȣ�� �����´�.
select empno, ename, deptno
from emp
where deptno = (select deptno
                from emp
                where ename='WARD');

-- SALESMAN�� ��� �޿����� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.
select empno, ename, sal
from emp
where sal > (select avg(sal)
             from emp
             where job = 'SALESMAN');
             
-- DALLAS ������ �ٹ��ϴ� ������� ��� �޿��� �����´�.
select trunc(avg(sal))
from emp
where deptno = (select deptno
                from dept
                where loc='DALLAS');

--  SALES �μ��� �ٹ��ϴ� ������� �����ȣ, �̸�, �ٹ������� �����´�.
select a1.empno, a1.ename, a2.loc
from emp a1, dept a2
where a1.deptno = a2.deptno and a1.deptno = (select deptno
                                            from dept
                                            where dname='SALES');

-- CHICAGO ������ �ٹ��ϴ� ����� �� BLAKE�� ���ӻ���� ������� �����ȣ, �̸�, ������ �����´�.	
select empno, ename, job
from emp
where deptno = (select deptno
                from dept
                where loc='CHICAGO') 
      and mgr = (select empno
                 from emp
                 where ename='BLAKE');
















