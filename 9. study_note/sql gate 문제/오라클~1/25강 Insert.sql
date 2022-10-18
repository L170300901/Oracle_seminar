drop table emp01;

create table emp01
as
select empno, ename, job from emp where 1=0;

select * from emp01;

-- 다음과 같은 사원 정보를 추가한다.
-- 1111 홍길동 인사
-- 2222 김길동 개발
-- 3333 최길동 인사
-- 4444 박길동 생산
insert into emp01 (empno, ename, job)
values (1111, '홍길동', '인사');

insert into emp01 (empno, ename, job)
values (2222, '김길동', '개발');

insert into emp01 (empno, ename, job)
values (3333, '최길동', '인사');

insert into emp01 (empno, ename, job)
values (4444, '박길동', '생산');

select * from emp01;

-- 컬럼 목록을 생략하는 경우
insert into emp01
values (5555, '황길동', '개발');

select * from emp01;

-- 컬럼 목록에 모든 컬럼이 있지 않을 경우
insert into emp01 (empno, ename)
values (6666, '이길동');

select * from emp01;

-- null을 명시적으로 저장
insert into emp01 (empno, ename, job)
values (7777, '박보검', null);

select * from emp01;

drop table emp02;

create table emp02
as
select empno, ename, job from emp where 1=0;


insert into emp02(empno, ename, job)
select empno, ename, job from emp;

select * from emp02;

insert into emp02
select empno, ename, job from emp01;

select * from emp02;

drop table emp03;
drop table emp04;

create table emp03
as
select empno, ename, job from emp where 1=0;

create table emp04
as
select empno, ename, hiredate from emp where 1=0;

insert all
into emp03 (empno, ename, job) values (empno, ename, job)
into emp04 (empno, ename, hiredate) values (empno, ename, hiredate)
select empno, ename, job, hiredate from emp;

select * from emp03;
select * from emp04;

-- 사원번호 이름 급여를 저장할 수 있는 빈 테이블을 만들고
-- 급여가 1500 이상인 사원들의 사원번호, 이름, 급여를 저장한다.
drop table emp05;

create table emp05
as
select empno, ename, sal from emp where 1=0;

insert into emp05 (empno, ename, sal)
select empno, ename, sal
from emp
where sal >= 1500;

select * from emp05;

-- 사원번호, 이름, 부서명을 저장할 수 있는 빈 테이블을 만들고
-- DALLAS 지역에 근무하고 있는 사원들의 사원번호, 이름, 부서명을 저장한다.
drop table emp06;

create table emp06
as
select a1.empno, a1.ename, a2.dname
from emp a1, dept a2
where a1.deptno = a2.deptno and 1=0;

insert into emp06 (empno, ename, dname)
select a1.empno, a1.ename, a2.dname
from emp a1, dept a2
where a1.deptno = a2.deptno;

select * from emp06;






















