-- 18. CLERK들의 직속상관의 사원번호, 이름, 급여를 가져온다.


SELECT m.empno
     , m.ename
     , m.sal
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND e.job=UPPER('clerk');