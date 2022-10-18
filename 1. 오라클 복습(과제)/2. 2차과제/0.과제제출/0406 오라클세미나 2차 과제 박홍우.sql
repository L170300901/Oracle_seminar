



-- 7. 급여가 2천 이하인 사원들의 급여를 20%씩 인상한다. 단 10의 자리를 기준으로 반올림한다.
	SELECT
    round(sal * 1.20, - 2)
FROM
    emp
WHERE
    sal <= 2000;



-- 9. 사원의 이름 중에 A라는 글자가 두번째 이후에 나타나는 사원의 이름을 가져온다.***
(★2가지 방법으로 풀어보기
1.두번째 A인거 찾고 and로 첫번째 두번째  A인거 빼기
2. instr사용하기 --> 영어는 1byte 한글은 2byte)
	SELECT
    ename
FROM
    emp
WHERE
    instr(ename, 'A') > 1
	
-- 10. 사원 이름을 앞에 3자리만 출력한다.
SELECT
    substr(ename)
FROM
    emp;


-- 12. 전 사원의 근무 일을 가져온다.
	SELECT
    ename,
    trunc(months_between(sysdate, hiredate) *(365 * 12))
    || '일' AS 근무일
FROM
    emp


-- 13. 모든 사원이 근무한 개월 수를 구한다.
SELECT
    ename,
    trunc(months_between(sysdate, hiredate))
    || '개월' AS 근속개월수
FROM
    emp

-- 14. 다음달의 마지막 날짜를 구한다.
SELECT
    last_day(to_char(sysdate, 'yyyymmdd')) + INTERVAL '1' MONTH
FROM
    dual

-- 15. 사원이름, 입사일을 구한다. 단, 사원들의 입사일을 다음과 같은 양식으로 가져온다.
-- 81.10.10
	SELECT
    ename,
    to_char(hiredate, 'YY.MM.DD')
FROM
    emp

-- 16. 각 사원의이름과 부서 이름을 가져온다.
-- 부서이름은 번호별로 한글이름이 표시되게 (10='인사과', 20='개발부', 30='경원지원팀', 40='생산부')
	SELECT ename
	 , deptno
     , CASE WHEN deptno = '10' THEN '인사과'
            WHEN deptno = '20' THEN '개발부'
            WHEN deptno = '30' THEN '경원지원팀'
            WHEN deptno = '40' THEN '생산부'
       END AS "부서명"
  FROM emp

-- 17. 사원번호, 사원이름, 급여액 별 등급을 가져온다.
-- 1000 미만 : C등급
-- 1000 이상 2000미만 : B등급
-- 2000 이상 : A등급
(★ 혹시 이문제 case문 말고 decode문으로 풀수 있으신분?)

SELECT
    empno,
    sal,
    decode(sign(1000 - sal), 1, 'C등급', sign(2000 - sal), 'A등급',
           'B등급')
FROM
    emp
                
-- 18. 급여가 1500 이상인 사원들의 급여 총합을 구한다.
SELECT
    SUM(sal)
FROM
    emp
WHERE
    sal >= 1500

-- 19. 커미션을 받는 사원들의 커미션 평균을 구한다.**?
(전문가로 가는 오라클 책 p95~96 따라하기 한번읽어보기 2번째줄 중요)
SELECT
    AVG(comm)
FROM
    emp
WHERE
    comm IS NOT NULL


-- 20. 전 사원의 커미션의 평균을 구한다.
SELECT
    trunc(AVG(comm) / COUNT(empno))
FROM
    emp
	

-- 21. 사원들의 급여 최대, 최소값을 가져온다.
SELECT
    MAX(sal),
    MIN(sal)
FROM
    emp















