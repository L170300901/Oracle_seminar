-- 1. SMITH 사원의 사원번호, 이름, 직속상관 이름을 가져온다.
/*
서브쿼리랑 조인 두가지 방법으로 풀어보세요
*/
select e1.empno, e1.ename, e2.ename from emp e1, emp e2 where e1.ename='SMITH' and e1.mgr=e2.empno;
select e2.empno, e2.ename, e1.ename from emp e1, (select * from emp where ename='SMITH') e2 where e2.mgr=e1.empno;
select empno, ename , (select ename from emp where empno=e.mgr) mgr from emp e where ename='SMITH';

-- 2. FORD 사원 밑에서 일하는 사원들의 사원번호, 이름, 직무를 가져온다.
/*
서브쿼리랑 조인 두가지 방법으로 풀어보세요
*/
select e2.empno, e2.ename, e2.job from emp e1, emp e2 where e1.ename='FORD' and e1.empno=e2.mgr;
select empno, ename, job from emp where mgr=(select empno from emp where ename='FORD');


-- 3. SMITH 사원의 직속상관과 동일한 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
/*
서브쿼리랑 조인 두가지 방법으로 풀어보세요
*/
select empno, ename, job 
from emp e
where job=(select  job from emp e1, (select mgr from emp where ename='SMITH') e2 where e1.empno=e2.mgr );

select e1.empno, e1.ename, e1.job 
from emp e1, emp e2, emp e3
where e2.ename='SMITH' and e2.mgr=e3.empno and e1.job=e3.job;


-- 4. 각 사원의 이름, 사원번호, 직장상사(직속상사) 이름을 가져온다. 단 직속상관이 없는 사원도 가져온다.
/*
--문제가 좀 애매한거 같다고 생각이 듬 .. 상사가 없는 사람도  사원이라고 하나요?
    --직장 상사라는 말이 또 애매함..
    --> 1.직속상사를 구하시오
    --> 2. 직장상사를 구하시오
    --두개의 값이 다름 (내 생각)
--우리는 직속상사를 구하자! 
*/
select e1.empno, e1.ename, e2.ename from emp e1, emp e2 where e1.mgr=e2.empno(+);


-- 5. 모든 부서의 소속 사원의 근무부서명, 사원번호, 사원이름, 급여를 가져온다.
select d.dname, e.empno, e.ename, e.sal from emp e, dept d where e.deptno=d.deptno;


-- 6. SCOTT 사원이 근무하고 있는 부서의 이름을 가져온다.
/*
서브쿼리랑 조인 두가지 방법으로 풀어보세요
*/
select dname from emp e, dept d where e.deptno=d.deptno and e.ename='SCOTT';
select dname from dept where deptno=(select deptno from emp where ename='SCOTT');


-- 7. SMITH와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 연봉, 부서이름을 가져온다.
select e1.empno, e1.ename, sal, d.dname
from emp e1, dept d
where e1.deptno=(select deptno from emp where ename='SMITH') and e1.deptno=d.deptno;

-- 8. MARTIN과 같은 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
select empno, ename, job from emp where job=(select job from emp where ename='MARTIN');

-- 9. ALLEN과 같은 직속상관을 가진 사원들의 사원번호, 이름, 직속상관이름을 가져온다.
select e1.empno, e1.ename, e2.ename from emp e1, emp e2 where e1.mgr=(select mgr from emp where ename='ALLEN') and e1.mgr=e2.empno;

-- 10. WARD와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 부서번호를 가져온다.
select empno, ename, deptno from emp where deptno=(select deptno from emp where ename='WARD');

-- 11. SALESMAN의 평균 급여보다 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.
/*
  --이 문제는 직업이 salesman인 사람이 출력 되도 괜찮겠다
*/
select empno, ename, sal from emp where sal>(select avg(sal) from emp where job='SALESMAN');
             
-- 12. DALLAS 지역에 근무하는 사원들의 평균 급여를 가져온다.
select avg(sal) from emp e, dept d where e.deptno=d.deptno and d.loc='DALLAS';

-- 13. SALES 부서에 근무하는 사원들의 사원번호, 이름, 근무지역을 가져온다.
select e.empno, e.ename, d.loc from emp e, dept d where e.deptno=d.deptno and d.dname='SALES';

-- 14. CHICAGO 지역에 근무하는 사원들 중 BLAKE이 직속상관인 사원들의 사원번호, 이름, 직무를 가져온다.	
select e1.empno, e1.ename, e1.job 
from (select * from emp e, dept d where e.deptno=d.deptno and d.loc='CHICAGO') e1, emp e2 
where e2.ename='BLAKE' and e1.mgr=e2.empno;

-- 15. 3000 이상의 급여를 받는 사원들과 같은 부서에 근무하고 있는 사원의 사원번호, 이름, 급여를 가져온다
select empno, ename, sal from emp where deptno in (select deptno from emp where sal>=3000);


-- 16. 직무가 CLERK인 사원과 동일한 부서에 근무하고 있는 사원들의 사원번호, 이름, 입사일 가져온다.
/*
clerk인 사람들은 모든 부서에 있다
부서에 근무하고 있는 사람들을 뽑으라는 건가? (내 생각)
*/
select empno, ename, hiredate from emp where deptno in (select deptno from emp where job='CLERK');


-- 17. KING을 직속상관으로 가지고 있는 사원들이 근무하고 있는 근무 부서명, 지역을 가지고온다.
select dname, loc from emp e, dept d where mgr=(select empno from emp where ename='KING') and e.deptno=d.deptno;


-- 18. CLERK들의 직속상관의 사원번호, 이름, 급여를 가져온다.
select e2.empno, e2.ename, e2.sal from (select mgr from emp where job='CLERK') e1, emp e2 where e1.mgr=e2.empno;

-- 19. 각 부서별 급여 평균보다 더 많이 받는 사원의 사원번호, 이름, 급여를 가져온다.
select distinct e.empno, e.ename, e.sal from emp e,(select avg(sal) avg from emp group by deptno) e2 where e.sal>e2.avg;


-- 20. 각 부서별 급여 최저치보다 더 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.
select distinct empno, ename, sal from emp e, (select min(sal) min from emp group by deptno) e2 where e.sal>e2.min;
                
-- 21. SALESMAN 보다 급여를 적게 받는 사원들의 사원번호, 이름, 급여를 가져온다.
/*
--먼소리지? job이 salesman인 사람보다 적게 받는다는 말이 굉장히 모호함
--직업이 salesman의 min 급여 보다 더 적게 받는 사원의 급여를 출력 해보자
*/
select empno, ename, sal from emp where sal>(select min(sal) from emp where job='SALESMAN');


-- 23. DALLAS에 근무하고 있는 사원들 중 가장 나중에 입사한 사원의 입사 날짜보다 더 먼저 입사한 
-- 사원들의 사원번호, 이름, 입사일을 가져온다.
select empno, ename, hiredate from emp where hiredate<(select max(hiredate) from emp e, dept d where e.deptno=d.deptno and loc='DALLAS');
select e1.empno, e1.ename, e1.hiredate 
from emp e1, (select max(hiredate) max_hiredate from emp e, dept d where e.deptno=d.deptno and loc='DALLAS') e2 
where e1.hiredate<e2.max_hiredate;




