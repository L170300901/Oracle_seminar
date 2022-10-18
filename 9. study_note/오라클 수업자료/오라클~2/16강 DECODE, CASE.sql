-- 각 사원의 부서 이름을 가져온다.
-- 10 : 인사과, 20 : 개발부, 30 : 경원지원팀,   
-- 40 : 생산부

select empno, ename, 
       decode(deptno, 10, '인사과', 
                      20, '개발부', 
                      30, '경영지원팀', 
                      40, '생산부')
from emp;

-- 직급에 따라 인상된 급여액을 가져온다.
-- CLERK : 10% 
-- SALESMAN : 15%
-- PRESIDENT : 200%
-- MANAGER : 5%
-- ANALYST : 20%
select empno, ename, job,
       decode(job, 'CLERK', sal * 1.1,
                   'SALESMAN', sal * 1.15,
                   'PRESIDENT', sal * 3,
                   'MANAGER', sal * 1.05,
                   'ANALYST', sal * 1.2)
from emp;

-- 급여액 별 등급을 가져온다.
-- 1000 미만 : C등급
-- 1000 이상 2000미만 : B등급
-- 2000 이상 : A등급
select empno, ename,
       case when sal < 1000 then 'C등급'
            when sal >= 1000 and sal < 2000 then 'B등급'
            when sal >= 2000 then 'A등급'
       end
from emp;

-- 직원들의 급여를 다음과 같이 인상한다.
-- 1000 이하 : 100%
-- 1000 초과 2000미만 : 50%
-- 2000 이상 : 200%
select empno, ename, 
       case when sal <= 1000 then sal * 2
            when sal > 1000 and sal <= 2000 then sal * 1.5
            when sal >= 2000 then sal * 3
       end
from emp;