-- 현재 날짜 구하기
select sysdate from dual;

-- 날짜 데이터 연산
select sysdate, sysdate - 10000, sysdate + 10000
from dual;

-- 각 사원이 입사한 날짜로 부터 1000일 후가 되는 날짜를 가져온다.
select hiredate, hiredate + 1000
from emp;

-- 직무가 SALESMAN인 사원의 입사일 100일전 날짜를 가져온다.
select hiredate, hiredate - 100
from emp
where job = 'SALESMAN';

-- 전 사원의 근무 일을 가져온다.
select trunc(sysdate - hiredate)
from emp;

-- 반올림
select sysdate, round(sysdate, 'CC') as "년도두자리", round(sysdate, 'YYYY') as "월기준",
       round(sysdate, 'DDD') as "시기준", round(sysdate, 'HH') as "분기준",
       round(sysdate, 'MM') as "일기준", round(sysdate, 'DAY') as "주기준",
       round(sysdate, 'MI') as "초기준"
from dual;

-- 각 사원의 입사일을 월 기준으로 반올림한다.
select hiredate, round(hiredate, 'YYYY')
from emp;

-- 버림
select sysdate, trunc(sysdate, 'CC') as "년도두자리", trunc(sysdate, 'YYYY') as "월",
       trunc(sysdate, 'DDD') as "시", trunc(sysdate, 'HH') as "분",
       trunc(sysdate, 'MM') as "일", trunc(sysdate, 'DAY') as "주",
       trunc(sysdate, 'MI') as "초"
from dual;

-- 1981년에 입사한 사원들의 사원번호, 사원이름, 급여, 입사일을 가져온다.
select empno, ename, sal, hiredate
from emp
where hiredate >= '1981/01/01' and hiredate <= '1981/12/31';

select empno, ename, sal, hiredate
from emp
where hiredate between '1981/01/01' and '1981/12/31';

select empno, ename, sal, hiredate
from emp
where trunc(hiredate, 'YYYY') = '1981/01/01';

-- 두 날짜 사이의 일수를 구한다.
select sysdate - hiredate
from emp;

-- 모든 사원이 근무한 개월 수를 구한다.
select trunc(months_between(sysdate, hiredate))
from emp;

-- 개월수를 더한다.
select sysdate + 100, add_months(sysdate, 100)
from dual;

-- 각 사원들의 입사일 후 100개월 되는 날짜를 구한다.
select hiredate, add_months(hiredate, 100)
from emp;

-- 지정된 날자를 기준으로 지정된 요일이 몇일인지...
select sysdate, next_day(sysdate, '월요일') from dual;

-- 지정된 날짜의 월의 마지막 날짜를 구한다.
select sysdate, last_day(sysdate) from dual;

-- to_char : 오라클 -> 프로그램
select sysdate, to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
select sysdate, to_char(sysdate, 'YYYY년 MM월 DD일 HH시 MI분 SS초 AM') from dual;

-- to_date : 프로그램 -> 오라클
select to_date('2018-03-20 01:58:20 오후', 'YYYY-MM-DD HH:MI:SS AM') from dual;

-- 사원들의 입사일을 다음과 같은 양식으로 가져온다.
-- 1900-10-10

select hiredate, to_char(hiredate, 'YYYY-MM-DD') from emp;

























