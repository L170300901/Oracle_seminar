drop table emp01;

create table emp01
as 
select * from emp;

select * from emp01;

delete from emp01;

select * from emp01;

drop table emp01;

create table emp01
as
select * from emp;

-- �����ȣ�� 7499�� ����� ������ �����Ѵ�.
delete from emp01
where empno = 7499;

select * from emp01;

-- ����� �޿��� ��� �޿� ������ ����� ������ �����Ѵ�.
delete from emp01
where sal <= (select avg(sal)
              from emp01);
              
select * from emp01;

-- Ŀ�̼��� ���� �ʴ� ������� ������ �����Ѵ�.
drop table emp01;

create table emp01
as
select * from emp;

select * from emp01;

delete from emp01
where comm is null;

select * from emp01;













