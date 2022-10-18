-- 1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력하라.
SELECT deptno, count(*),SUM(sal)
FROM emp
GROUP BY deptno
HAVING COUNT(*)>4;


-- 2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력하라.
SELECT deptno, COUNT(*)
FROM EMP
GROUP BY deptno
HAVING COUNT(*)=(SELECT MAX(COUNT(*))
																		FROM emp
                                    GROUP BY deptno);


SELECT ROWNUM,n.*
FROM  (SELECT deptno,COUNT(*) num
										FROM EMP
										GROUP BY deptno
                    ORDER BY num desc) n
WHERE rownum=1;

-- 3. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 출력하라.
SELECT mgr
FROM EMP
GROUP BY mgr
HAVING COUNT(*)=(SELECT max(COUNT(*))
														FROM EMP
														GROUP BY mgr);



-- 4. EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 30인 사원수를 각각 출력하라.
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING deptno IN(10,30);



SELECT
COUNT(DECODE(deptno,10,1)) "10",
COUNT(DECODE(deptno,30,1)) "30"
FROM EMP;



-- 5. EMP 테이블에서 사원번호가 7521인 사원의 직업과 같고 사원번호가 7934인 사원의 급여(SAL)보다 많은 사원의
--사원번호, 이름, 직업, 급여를 출력하라.
SELECT e.empno, e.ename, e.job, e.sal
FROM (SELECT job
					FROM emp
          WHERE empno=7521) j,
          (SELECT sal
          FROM emp
          WHERE empno=7934) s,
          EMP e
WHERE j.job=e.job
AND e.sal>s.sal;


SELECT empno, ename, job, sal
FROM emp
WHERE job=(SELECT job
					FROM emp
          WHERE empno=7521)
AND sal>(SELECT sal
							FROM emp
              WHERE empno=7934);




-- 6. 직업(JOB)별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명을 출력하라.
-- 조건1 : 직업별로 내림차순 정렬
SELECT e.empno, e.ename, e.job, d.dname
FROM EMP e, (SELECT MIN(sal) salary, job
										FROM emp
										GROUP BY job) j, DEPT d
WHERE e.sal=j.salary
AND e.job=j.job
AND e.DEPTNO=d.deptno
ORDER BY job DESC;




-- 7. 각 사원 별 시급을 계산하여 부서번호, 사원이름, 시급을 출력하라.
-- 조건1. 한달 근무일수는 20일, 하루 근무시간은 8시간이다.
-- 조건2. 시급은 소수 두 번째 자리에서 반올림한다.
-- 조건3. 부서별로 오름차순 정렬
-- 조건4. 시급이 많은 순으로 출력



-- 8. 각 사원 별 커미션이 0 또는 NULL이고 부서위치가 ‘GO’로 끝나는 사원의 정보를
--사원번호, 사원이름, 커미션, 부서번호, 부서명, 부서위치를 출력하라.
-- 조건1. 보너스가 NULL이면 0으로 출력



-- 9. 각 부서 별 평균 급여가 2000 이상이면 초과, 그렇지 않으면 미만을 출력하라.



-- 10. 각 부서 별 입사일이 가장 오래된 사원을 한 명씩 선별해 사원번호, 사원명, 부서번호, 입사일을 출력하라.
SELECT  e.empno, e.ename, e.deptno, e.hiredate
FROM (SELECT deptno,min(hiredate) hdate
					FROM emp
          GROUP BY deptno )h, EMP e
WHERE e.deptno=h.deptno(+)
AND e.HIREDATE = h.hdate;


--부서번호가 없는 대유도 뽑으려면
SELECT t1.empno, t1.ename, t1.deptno, t1.hiredate
  FROM (SELECT e.empno, e.ename, e.deptno, e.hiredate
            FROM (SELECT deptno, min(hiredate) hdate
                      FROM emp
                      GROUP BY deptno)h, EMP e
            WHERE e.deptno=h.deptno(+) )t1, (SELECT deptno,min(hiredate) hdate
					                                                 FROM emp
                                                           GROUP BY deptno) t2
 WHERE t2.hdate = t1.hiredate;





-- 11. 1980년~1980년 사이에 입사된 각 부서별 사원수를 부서번호, 부서명, 입사1980, 입사1981, 입사1982로 출력하라.



-- 12. 1981년 5월 31일 이후 입사자 중 커미션이 NULL이거나 0인 사원의 커미션은 500으로 그렇지 않으면 기존 커미션을 출력하라.



-- 13. 1981년 6월 1일 ~ 1981년 12월 31일 입사자 중 부서명이 SALES인 사원의 부서번호, 사원명, 직업, 입사일을 출력하라.
-- 조건1. 입사일 오름차순 정렬



-- 14. 현재 시간과 현재 시간으로부터 한 시간 후의 시간을 출력하라.
-- 조건1. 현재시간 포맷은 ‘4자리년-2자일월-2자리일 24시:2자리분:2자리초’로 출력
-- 조건1. 한시간후 포맷은 ‘4자리년-2자일월-2자리일 24시:2자리분:2자리초’로 출력




-- 15. 각 부서별 사원수를 출력하라.
-- 조건1. 부서별 사원수가 없더라도 부서번호, 부서명은 출력
-- 조건2. 부서별 사원수가 0인 경우 ‘없음’ 출력
-- 조건3. 부서번호 오름차순 정렬



-- 16. 사원 테이블에서 각 사원의 사원번호, 사원명, 매니저번호, 매니저명을 출력하라.
-- 조건1. 각 사원의 급여(SAL)는 매니저 급여보다 많거나 같다.



-- 18. 사원명의 첫 글자가 ‘A’이고, 처음과 끝 사이에 ‘LL’이 들어가는 사원의 커미션이 COMM2일때,
--모든 사원의 커미션에 COMM2를 더한 결과를 사원명, COMM, COMM2, COMM+COMM2로 출력하라.



-- 19. 각 부서별로 1981년 5월 31일 이후 입사자의 부서번호, 부서명, 사원번호, 사원명, 입사일을 출력하시오.
-- 조건1. 부서별 사원정보가 없더라도 부서번호, 부서명은 출력
-- 조건2. 부서번호 오름차순 정렬
-- 조건3. 입사일 오름차순 정렬




-- 20. 입사일로부터 지금까지 근무년수가 30년 이상 미만인 사원의 사원번호, 사원명, 입사일, 근무년수를 출력하라.
-- 조건1. 근무년수는 월을 기준으로 버림 (예:30.4년 = 30년, 30.7년=30년)



