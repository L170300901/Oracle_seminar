-- 3000 �̻��� �޿��� �޴� ������ ���� �μ��� �ٹ��ϰ� �ִ� ����� �����ȣ, �̸�, �޿��� �����´�
select empno, ename, sal
from emp
where deptno in (select deptno
                from emp
                where sal >= 3000);
                
-- ������ CLERK�� ����� ������ �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �Ի��� �����´�.
select empno, ename, hiredate
from emp
where deptno in (select deptno
                    from emp
                    where job = 'CLERK');

-- KING�� ���ӻ������ ������ �ִ� ������� �ٹ��ϰ� �ִ� �ٹ� �μ���, ������ ������´�.
select dname, loc
from dept
where deptno in (select deptno
                from emp
                where mgr = (select empno
                            from emp
                            where ename = 'KING'));

--  CLERK���� ���ӻ���� �����ȣ, �̸�, �޿��� �����´�.
select empno, ename, sal
from emp
where empno in (select mgr
                from emp
                where job = 'CLERK');

-- �� �μ��� �޿� ��պ��� �� ���� �޴� ����� �����ȣ, �̸�, �޿��� �����´�.
select empno, ename, sal
from emp
where sal > all (select avg(sal)
                from emp
                group by deptno);

select empno, ename, sal
from emp
where sal > (select max(avg(sal))
                from emp
                group by deptno);
                
--  �� �μ��� �޿� ����ġ���� �� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.
select empno, ename, sal
from emp
where sal > all (select min(sal)
                from emp
                group by deptno);

select empno, ename, sal
from emp
where sal >  (select max(min(sal))
                from emp
                group by deptno);
                
-- SALESMAN ���� �޿��� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.
select empno, ename, sal
from emp
where sal < all (select sal
                from emp
                where job = 'SALESMAN');
                
select empno, ename, sal
from emp
where sal <  (select min(sal)
                from emp
                where job = 'SALESMAN');

-- �� �μ��� ���� �޿� �׼����� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.

select empno, ename, sal
from emp
where sal > any (select min(sal)
                from emp
                group by deptno);

-- DALLAS�� �ٹ��ϰ� �ִ� ����� �� ���� ���߿� �Ի��� ����� �Ի� ��¥���� �� ���� �Ի��� 
-- ������� �����ȣ, �̸�, �Ի����� �����´�.

select empno, ename hiredate
from emp 
where hiredate < any (select hiredate
                    from emp
                    where deptno = (select deptno
                                    from dept
                                    where loc='DALLAS'));










