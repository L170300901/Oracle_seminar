-- 1. SMITH 사원의 사원번호, 이름, 직속상관 이름을 가져온다.
/*
서브쿼리랑 조인 두가지 방법으로 풀어보세요
*/

--조인문장

select
e1.empno "사원번호"
, e1.ename "이름"
, e2.ename "직속상관"
from
emp e1
,emp e2
where e1.mgr=e2.empno
and e1.ename = 'SMITH';



--서브쿼리 Inline View

select
e.empno "사원번호"
,e.ename "이름"
,teemo.ename "직속상관"
from emp e,
(select * from emp) teemo
where e.ename = 'SMITH'
and
e.mgr = teemo.empno;

--scalar

select
e.empno "사원번호"
,e.ename "이름"
,(select ename from emp where e.mgr=empno) "직속상관"
from emp e
where 
e.ename = 'SMITH';




-- 2. FORD 사원 밑에서 일하는 사원들의 사원번호, 이름, 직무를 가져온다.

/*
서브쿼리랑 조인 두가지 방법으로 풀어보세요
*/

select
e2.empno
,e2.ename
, e2.job
from
emp e1
,emp e2
where e2.mgr = e1.empno
and e1.ename = 'FORD';


--서브쿼리 Inline-view
 
select
teemo.empno "사원번호"
, teemo.ename "이름"
, teemo.job "직무"
from
emp e,
(select * from emp) teemo
where
e.ename = 'FORD'
and e.empno = teemo.mgr;


--nested

???





-- 3. SMITH 사원의 직속상관과  동일한 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.

/*
서브쿼리랑 조인 두가지 방법으로 풀어보세요
*/

--조인
select 
e2.empno
, e2.ename
, e2.job
from
emp e1
,emp e2
where
e1.ename = 'FORD'
and e1.job = e2.job;



-- 4. 각 사원의 이름, 사원번호, 직장상사(직속상사) 이름을 가져온다. 단 직속상관이 없는 사원도 가져온다.

/*
--문제가 좀 애매한거 같다고 생각이 듬 .. 상사가 없는 사람도  사원이라고 하나요?
    --직장 상사라는 말이 또 애매함..
    --> 1.직속상사를 구하시오
    --> 2. 직장상사를 구하시오
    --두개의 값이 다름 (내 생각)
--우리는 직속상사를 구하자! 
*/






-- 5. 모든 부서의 소속 사원의 근무부서명, 사원번호, 사원이름, 급여를 가져온다.

select
d.dname
, e.empno
, e.ename
, e.sal
from
emp e
, dept d
where
e.deptno = d.deptno;


-- 6. SCOTT 사원이 근무하고 있는 부서의 이름을 가져온다.

/*
서브쿼리랑 조인 두가지 방법으로 풀어보세요
*/

-- 7. SMITH와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 연봉, 부서이름을 가져온다.

select 
e.empno
, e.ename
, e.sal
from
emp e
dept d
(select deptno from emp where ename='SMITH') a
where
a.deptno = e.deptno and a.deptno = d.deptno


-- 8. MARTIN과 같은 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.


-- 9. ALLEN과 같은 직속상관을 가진 사원들의 사원번호, 이름, 직속상관이름을 가져온다.


-- 10. WARD와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 부서번호를 가져온다.


-- 11. SALESMAN의 평균 급여보다 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.
/*
  --이 문제는 직업이 salesman인 사람이 출력 되도 괜찮겠다
*/
             
-- 12. DALLAS 지역에 근무하는 사원들의 평균 급여를 가져온다.


-- 13. SALES 부서에 근무하는 사원들의 사원번호, 이름, 근무지역을 가져온다.


-- 14. CHICAGO 지역에 근무하는 사원들 중 BLAKE이 직속상관인 사원들의 사원번호, 이름, 직무를 가져온다.	


-- 15. 3000 이상의 급여를 받는 사원들과 같은 부서에 근무하고 있는 사원의 사원번호, 이름, 급여를 가져온다


-- 16. 직무가 CLERK인 사원과 동일한 부서에 근무하고 있는 사원들의 사원번호, 이름, 입사일 가져온다.

/*
clerk인 사람들은 모든 부서에 있다
부서에 근무하고 있는 사람들을 뽑으라는 건가? (내 생각)
*/

-- 17. KING을 직속상관으로 가지고 있는 사원들이 근무하고 있는 근무 부서명, 지역을 가지고온다.


-- 18. CLERK들의 직속상관의 사원번호, 이름, 급여를 가져온다.


-- 19. 각 부서별 급여 평균보다 더 많이 받는 사원의 사원번호, 이름, 급여를 가져온다.

                
-- 20. 각 부서별 급여 최저치보다 더 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.

                
-- 21. SALESMAN 보다 급여를 적게 받는 사원들의 사원번호, 이름, 급여를 가져온다.

/*
--먼소리지? job이 salesman인 사람보다 적게 받는다는 말이 굉장히 모호함
--직업이 salesman의 min 급여 보다 더 적게 받는 사원의 급여를 출력 해보자
*/




-- 23. DALLAS에 근무하고 있는 사원들 중 가장 나중에 입사한 사원의 입사 날짜보다 더 먼저 입사한 
-- 사원들의 사원번호, 이름, 입사일을 가져온다.
