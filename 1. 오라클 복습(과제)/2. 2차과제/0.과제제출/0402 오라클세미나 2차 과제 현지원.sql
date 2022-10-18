-- 1. 이름이 S로 끝나는 사원의 이름과 사원 번호를 가져온다. 
SELECT ename,empno FROM EMP
WHERE ename LIKE '%S';

-- 2. 이름에 A가 포함되어 있는 사원의 이름과 사원 번호를 가져온다.
SELECT ename,empno FROM EMP
WHERE ename LIKE '%A%';

-- 3. 이름의 두번째 글자가 A인 사원의 사원 이름, 사원 번호를 가져온다.
SELECT ename,empno FROM EMP
WHERE ename LIKE '_A%';

-- 4. 사원중에 커미션을 받지 않는 사원의 사원번호, 이름, 커미션을 가져온다.
SELECT empno,ename,comm FROM EMP
WHERE comm IS NULL;

-- 5. 1981년에 입사한 사원들의 사원번호, 사원 이름, 입사일을 가져온다. 사원 번호를 기준으로 내림차순 정렬을 한다.
(★trunc 함수를 이용해서 풀수 있으면 trunc함수를 이용해주세요)
SELECT empno,ename,hiredate
FROM EMP
WHERE hiredate BETWEEN '1981/01/01' AND '1981/12/31'
ORDER BY empno DESC;

-- 6. 급여가 1500 이상인 사원의 급여를 15% 삭감한다. 단 소수점 이하는 버린다.


-- 7. 급여가 2천 이하인 사원들의 급여를 20%씩 인상한다. 단 10의 자리를 기준으로 반올림한다.


-- 8. 사원들의 이름을 소문자로 가져온다.
select lower(ename) from emp ;

-- 9. 사원의 이름 중에 A라는 글자가 두번째 이후에 나타나는 사원의 이름을 가져온다.***
(★2가지 방법으로 풀어보기
1.두번째 A인거 찾고 and로 첫번째 두번째  A인거 빼기
2. instr사용하기 --> 영어는 1byte 한글은 2byte)

-- 10. 사원 이름을 앞에 3자리만 출력한다.
select ename,substr(ename,0,3) from emp

-- 11. 직무가 SALESMAN인 사원의 입사일 100일전 날짜를 가져온다.
select job,hiredate,hiredate-100 from emp
where job='SALESMAN'

-- 12. 전 사원의 근무 일을 가져온다.
select (sysdate-hiredate) from emp

-- 13. 모든 사원이 근무한 개월 수를 구한다.
select (sysdate-hiredate)/30 month from emp

-- 14. 다음달의 마지막 날짜를 구한다.
select LAST_DAY('2021/5/1') from dual

-- 15. 사원이름, 입사일을 구한다. 단, 사원들의 입사일을 다음과 같은 양식으로 가져온다.
-- 81.10.10
select ename,to_char(hiredate,'YY.MM.DD') from emp

-- 16. 각 사원의이름과 부서 이름을 가져온다.
-- 부서이름은 번호별로 한글이름이 표시되게 (10='인사과', 20='개발부', 30='경원지원팀', 40='생산부')


-- 17. 사원번호, 사원이름, 급여액 별 등급을 가져온다.
-- 1000 미만 : C등급
-- 1000 이상 2000미만 : B등급
-- 2000 이상 : A등급
(★ 혹시 이문제 case문 말고 decode문으로 풀수 있으신분?)


-- 18. 급여가 1500 이상인 사원들의 급여 총합을 구한다.


-- 19. 커미션을 받는 사원들의 커미션 평균을 구한다.**?
(전문가로 가는 오라클 책 p95~96 따라하기 한번읽어보기 2번째줄 중요)

-- 20. 전 사원의 커미션의 평균을 구한다.
select nvl(avg(comm),0) "평균" from emp

-- 21. 사원들의 급여 최대, 최소값을 가져온다.
select max(sal) as "최대급여" ,min(sal) as "최소급여" from emp














