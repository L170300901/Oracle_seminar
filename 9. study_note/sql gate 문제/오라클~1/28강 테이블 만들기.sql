-- ������ ���� ������ �����ϱ� ���� ���̺��� �����.
-- �л���ȣ, �л��̸�, �л�����, �л���������, ��������, ��������

create table stu_table(
stu_idx number,
stu_name char(10),
stu_age number,
stu_kor number,
stu_eng number,
stu_math number
);

insert into stu_table(stu_idx, stu_name, stu_age, stu_kor, stu_eng, stu_math)
values (1111, 'ȫ�浿', 30, 100, 80, 70);

select * from stu_table;

create table number_table(
number1 number,
number2 number(3),
number3 number(5, 2)
);

insert into number_table(number1)
values (10000);

select * from number_table;

insert into number_table(number2)
values (100);

select * from number_table;

insert into number_table(number3)
values (100.111111);

select * from number_table;

-- emp ���̺� ������ emp01 ���̺��� ����ÿ�
drop table emp01;

create table emp01
as
select * from emp;

select * from emp01;

-- emp ���̺��� ����� ��ȣ, �̸�, �޿� ������ ������ �ִ� ���̺��� �����Ͻÿ�
drop table emp02;

create table emp02
as
select empno, ename, sal
from emp;

select * from emp02;

-- 30�� �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �ٹ��μ� �̸��� ������ �ִ� ���̺��� �����Ѵ�.
drop table emp03;

create table emp03
as
select a1.empno, a1.ename, a2.dname
from emp a1, dept a2
where a1.deptno = a2.deptno and a1.deptno = 30;

select * from emp03;

-- �� �μ��� �޿� ����, ���, �ְ��, ������, ������� ������ �ִ� ���̺��� �����Ͻÿ�
drop table emp04;


create table emp04
as
select sum(sal) as sum, trunc(avg(sal)) as avg, max(sal) as max, 
       min(sal) as min, count(sal) as count
from emp
group by deptno;

select * from emp04;



















