-- 1. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을
-- 출력하라.
SELECT e.ENAME, e.JOB, e.DEPTNO, d.DNAME
FROM (SELECT deptno, dname
					FROM DEPT
          WHERE loc='DALLAS') d, EMP e
WHERE e.DEPTNO=d.DEPTNO;


-- 2. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을
--출력하는데 월급이 3000이상인 사원을 출력하라.
SELECT e.ENAME, d.DNAME, e.SAL
FROM (SELECT ename, deptno, sal
					FROM EMP
          WHERE sal>=3000) e, DEPT d
WHERE e.DEPTNO=d.DEPTNO(+);


-- 3. 직위가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
SELECT e.ENAME, e.JOB, d.DNAME
FROM (SELECT job, ename, deptno
					FROM EMP
          WHERE job='SALESMAN')e ,DEPT d
WHERE e.DEPTNO=d.DEPTNO(+);

-- 4. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.

SELECT * FROM SALGRADE


-- 5. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.


-- 6. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름,
-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로
-- 정렬하라.


-- 7. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
SELECT e.EMPNO 사원번호, e.ENAME 사원이름, e.MGR 관리자번호, m.EMPNO 관리자이름
FROM EMP e, EMP m
WHERE e.MGR=m.EMPNO(+);

--답
-- 1. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을
-- 출력하라.
select e.ename, e.job, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno and loc = 'DALLAS';


-- 2. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을
--출력하는데 월급이 3000이상인 사원을 출력하라.
select e.ename, d.dname, e.sal
where e.deptno = e.deptno AND e.sal >=3000;


-- 3. 직위가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
select e.job, e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno AND e.job = 'SALESMAN';



-- 4. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.
select e.empno "사원번호", e.ename "사원이름", e.sal*12 "연봉", e.sal*12+e.comm "실급여", s.grade "급여등급"
from emp e, salgrade s
where comm is not null AND e.sal between s.losal and s.hisal;



-- 5. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno AND
e.deptno = 10 AND e.sal BETWEEN s.losal AND s.hisal;



-- 6. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름,
-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로
-- 정렬하라.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno AND e.sal BETWEEN s.losal AND s.hisal AND
(e.deptno = 10 OR e.deptno  = 20)
order by deptno asc, sal desc;



-- 7. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
select e.empno 사원번호, e.ename 사원이름, e.mgr 관리자번호, m.ename 관리자이름
from emp e, emp m
where e.mgr = m.empno;

