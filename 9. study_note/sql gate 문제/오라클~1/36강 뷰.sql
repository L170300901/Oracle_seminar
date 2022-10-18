-- 사원의 사원번호, 이름, 급여, 근무부서이름, 근무지역을 가지고 있는 뷰를 생성한다.
drop view emp_dept_view;

create view emp_dept_view
as
select a1.empno, a1.ename, a1.sal, a2.dname, a2.loc
from emp a1, dept a2
where a1.deptno = a2.deptno;

-- 뷰를 조회한다.
select * from emp_dept_view;

-- 테이블을 생성
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

-- 원본 테이블에 데이터를 저장한다.
insert into emp100 (empno, ename, sal, deptno)
values (5000, '홍길동', 2000, 10);

select * from emp100;

select * from emp100_dept100_view;

insert into emp100_dept100_view (empno, ename, sal)
values (6000, '김길동', 2000);

create view emp200_view
as
select empno, ename, sal
from emp100;

insert into emp200_view (empno, ename, sal)
values (7000, '박길동', 3000);

select * from emp100;




















