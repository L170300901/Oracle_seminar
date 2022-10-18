--DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름 출력
SELECT e.ENAME
				, e.JOB
        , e.DEPTNO
        , d.DNAME
FROM DEPT d
				,EMP e
WHERE d.LOC = 'DALLAS'
 AND e.DEPTNO = d.DEPTNO;

 --사원이름과 그 사원이 속한 부서의 부서명, 월급출력하는데 월급이 3000이상인 사원 출력
 SELECT e.ENAME
 					,d.DNAME
 					,e.SAL
 FROM EMP e
 				, DEPT d
 WHERE e.SAL > 3000
  AND e.DEPTNO = d.DEPTNO;

  --직위가 'SALESMAN'인 사원들의 직위와 그 사원이름, 부서이름 출력
  SELECT e.ENAME
  				, e.JOB
  				, d.DNAME
  FROM EMP e
  				,DEPT d
  WHERE e.DEPTNO =d.DEPTNO
   AND e.JOB = 'SALESMAN';

--커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션, 급여등급을 출력하되,
--각각의 칼럼명을 '사원번호', '사원이름' , '연봉', '실급여', '급여등급'으로 출력
SELECT e.ENAME 사원이름
				, e.EMPNO 사원번호
        , e.SAL*12 연봉
        , e.sal*12+NVL(e.COMM,0) 실급여
        , s.GRADE 급여등급
FROM EMP e
				,SALGRADE s
 where e.sal between s.losal and s.hisal;

--부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급, 급여등급 출력
SELECT d.DEPTNO
				, d.DNAME
        , e.ENAME
        , e.SAL
        , s.GRADE
FROM EMP e
				,DEPT d
        ,SALGRADE s
WHERE  e.DEPTNO=10
AND e.DEPTNO =d.DEPTNO
AND e.sal BETWEEN s.losal AND s.hisal
ORDER BY s.GRADE;

--부서번호가 10번, 20번인 사원들의 부서번호, 부서이름, 사원이름, 월급, 급여등급 출력
--출력된 결과물을 부서번호가 낮은순으로, 월급이 높은순으로 정렬
SELECT d.DEPTNO
				, d.DNAME
        , e.ENAME
        , e.SAL
        , s.GRADE
FROM EMP e
				,DEPT d
        ,SALGRADE s
WHERE e.DEPTNO =d.DEPTNO
 AND e.SAL BETWEEN s.LOSAL AND s.HISAL
 AND (e.DEPTNO = 10 OR e.DEPTNO = 20)
ORDER BY e.DEPTNO ASC
						, e.SAL DESC;

--사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력
--각각 '사원번호', '사원이름', '관리자번호', '관리자이름'으로 하여 출력
SELECT  e.EMPNO 사원번호
					,e.ENAME 사원이름
					,m.EMPNO 관리자번호
          ,m.ENAME 관리자이름
FROM EMP e
				,EMP m
WHERE e.MGR = m.EMPNO;











