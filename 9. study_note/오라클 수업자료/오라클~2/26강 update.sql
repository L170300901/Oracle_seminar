drop table emp01;

create table emp01
as 
select * from emp;

select * from emp01;

-- ������� �μ� ��ȣ�� 40������ �����Ѵ�.
update emp01
set deptno = 40;

select * from emp01;

-- ������� �Ի����� ���÷� �����Ѵ�.
update emp01
set hiredate = sysdate;

select * from emp01;

-- ������� ������ �����ڷ� �����Ѵ�.
update emp01
set job = '������';

select * from emp01;

drop table emp01;

create table emp01
as
select * from emp;

select * from emp01;

-- ������� �μ���ȣ�� 40, �ϻ����� ����, ������ �����ڷ� �����Ѵ�.
update emp01
set deptno = 40, hiredate = sysdate, job = '������';

select * from emp01;

drop table emp01;

create table emp01
as
select * from emp;

-- 10�� �μ��� �ٹ��ϰ� �ִ� ������� 40�� �μ��� �����Ѵ�.
update emp01
set deptno = 40
where deptno = 10;

select * from emp01;

-- SALESMAN ���� �Ի����� ����, COMM�� 2000���� �����Ѵ�.
update emp01
set hiredate = sysdate, comm = 2000
where job = 'SALESMAN';

select * from emp01;

-- ��ü ����� ��� �޿����� ���� ������� �޿��� 50% �λ��Ѵ�.
update emp01
set sal = sal * 1.5
where sal < (select avg(sal)
             from emp01);
             
select * from emp01;

-- MANAGER ������� ������ Developer�� �����Ѵ�.
update emp01
set job = 'Developer'
where job = 'MANAGER';

select * from emp01;

-- 30�� �μ��� �ٹ��ϰ� �ִ� ������� �޿��� ��ü ��� �޿��� �����Ѵ�.
update emp01
set sal = (select trunc(avg(sal))
           from emp01)
where deptno = 30;

select * from emp01;

-- BLAKE �ؿ��� �ٹ��ϰ� �ִ� ������� �μ��� DALLAS ������ �μ���ȣ�� �����Ѵ�.
update emp01
set deptno = (select deptno
              from dept
              where loc = 'DALLAS')
where mgr = (select empno
            from emp01
            where ename = 'BLAKE');

select * from emp01;

-- 20�� �μ��� �ٹ��ϰ� �ִ� ������� ���ӻ���� KING���� �ϰ� �޿��� ��ü�޿��� �ְ������ �����Ѵ�.
update emp01
set mgr =(select empno
          from emp01
          where ename = 'KING'), 
    sal = (select max(sal)
           from emp01)
where deptno = 20;

select * from emp01;

drop table emp01;

create table emp01
as
select * from emp;

-- ������ CLERK �� ������� ������ �޿����� 20�� �μ��� �ٹ��ϰ� �ִ� ��� �� 
-- �޿� �ְ���� �޴� ����� ������ �޿������� �����Ѵ�.

update emp01
set job = (select job
            from emp01
            where sal = (select max(sal)
                         from emp01)), 
    sal = (select sal
            from emp01
            where sal = (select max(sal)
                         from emp01))
where job = 'CLERK';

update emp01
set (job, sal) = (select job, sal
                  from emp01
                  where sal = (select max(sal)
                               from emp01))
where job = 'CLERK';

select * from emp01;


















