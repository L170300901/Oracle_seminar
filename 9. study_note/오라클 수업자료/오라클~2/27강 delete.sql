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

-- 사원번호가 7499인 사원의 정보를 삭제한다.
delete from emp01
where empno = 7499;

select * from emp01;

-- 사원의 급여가 평균 급여 이하인 사원의 정보를 삭제한다.
delete from emp01
where sal <= (select avg(sal)
              from emp01);
              
select * from emp01;

-- 커미션을 받지 않는 사원들의 정보를 삭제한다.
drop table emp01;

create table emp01
as
select * from emp;

select * from emp01;

delete from emp01
where comm is null;

select * from emp01;













