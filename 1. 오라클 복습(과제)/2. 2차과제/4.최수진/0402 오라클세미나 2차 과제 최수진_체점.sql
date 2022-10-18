

 5. 1981년에 입사한 사원들의 사원번호, 사원 이름, 입사일을 가져온다. 사원 번호를 기준으로 내림차순 정렬을 한다.
--(★trunc 함수를 이용해서 풀수 있으면 trunc함수를 이용해주세요)
select empno, ename,hiredate from emp order by empno;

/*

1981년에 입사한 << 조건 빠짐 (실수)

*/


-- 7. 급여가 2천 이하인 사원들의 급여를 20%씩 인상한다. 단 10의 자리를 기준으로 반올림한다.
select ename, sal, round(sal*1.2, -1) "인상급여" from emp where sal<=2000;


/*

10의자리 기준으로 반올림:
round(sal*1.2, -1) 이렇게 하면 일의자리 기준으로 반올림~

*/



9. 사원의 이름 중에 A라는 글자가 두번째 이후에 나타나는 사원의 이름을 가져온다.***
--(★2가지 방법으로 풀어보기
--1.두번째 A인거 찾고 and로 첫번째 두번째  A인거 빼기
--2. instr사용하기 --> 영어는 1byte 한글은 2byte)


-- 10. 사원 이름을 앞에 3자리만 출력한다.

/*

문자열 자르기는 너무 중요해요! 
문자열 자르기는 자바, 자스에서도 너무 중요 꼭 외우기!
흰트: substr() 사용

*/

-- 11. 직무가 SALESMAN인 사원의 입사일 100일전 날짜를 가져온다.
select hiredate, hiredate-100 "100일전 날짜" from emp;

/*

직무가 SALESMAN 조건이 빠졌어요~
(실수)

*/



-- 13. 모든 사원이 근무한 개월 수를 구한다.
select to_char(hiredate, 'MM') from emp;

/*

흰트: MONTHS_BETWEEN() 사용

MONTHS_BETWEEN(a,b) --> a날짜와 b날짜의 사이의 개월 수 를 계산가능 

*/

-- 14. 다음달의 마지막 날짜를 구한다.

/*

흰트: last_day() 사용

*/


16. 각 사원의이름과 부서 이름을 가져온다.
-- 부서이름은 번호별로 한글이름이 표시되게 (10='인사과', 20='개발부', 30='경원지원팀', 40='생산부')
select  ename, d.deptno||'='||dname "부서이름" from emp e, dept d where e.deptno=d.deptno;

/*

잘하셨는데 문제의도랑 답이 다른거 같아요~
10번 부서이면 인사과 
2번이면 개발부 이런식으로 출력하고 싶어요~

흰트: decode 사용

*/


-- 17. 사원번호, 사원이름, 급여액 별 등급을 가져온다.
-- 1000 미만 : C등급
-- 1000 이상 2000미만 : B등급
-- 2000 이상 : A등급
--(★ 혹시 이문제 case문 말고 decode문으로 풀수 있으신분?)



-- 19. 커미션을 받는 사원들의 커미션 평균을 구한다.**?
--(전문가로 가는 오라클 책 p95~96 따라하기 한번읽어보기 2번째줄 중요)
select avg(comm)
from( select comm from emp where comm is not null);

/*
이 문제 해주고 싶었던 얘기가 

a)
select avg(comm)
from( select comm from emp where comm is not null);
b)
select avg(comm)
from emp;

a랑 b가 같은 결과값이 나온다는 것 
이유는 책에 적혀 있어요~

*/



-- 21. 사원들의 급여 최대, 최소값을 가져온다.



--이번 과제는 검색해야 풀수있을듯ㅠㅠㅠㅠ