-- ����� �����ȣ, �̸�, �޿�, �ٹ��μ��̸�, �ٹ������� ������ �ִ� �並 �����Ѵ�.
drop view emp_dept_view;

create view emp_dept_view
as
select a1.empno, a1.ename, a1.sal, a2.dname, a2.loc
from emp a1, dept a2
where a1.deptno = a2.deptno;

-- �並 ��ȸ�Ѵ�.
select * from emp_dept_view;

-- ���̺��� ����
drop table emp100;

create table emp100
as
select * from emp;

drop table dept100;

create table dept100
as
select * from dept;

create view emp100_dept100_view
as
select a1.empno, a1.ename, a1.sal, a2.dname, a2.loc
from emp100 a1, dept100 a2
where a1.deptno = a2.deptno;

select * from emp100_dept100_view;

-- ���� ���̺� �����͸� �����Ѵ�.
insert into emp100 (empno, ename, sal, deptno)
values (5000, 'ȫ�浿', 2000, 10);

select * from emp100;

select * from emp100_dept100_view;

insert into emp100_dept100_view (empno, ename, sal)
values (6000, '��浿', 2000);

create view emp200_view
as
select empno, ename, sal
from emp100;

insert into emp200_view (empno, ename, sal)
values (7000, '�ڱ浿', 3000);

select * from emp100;




















