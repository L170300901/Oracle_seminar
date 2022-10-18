


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




-- 14. 다음달의 마지막 날짜를 구한다.
SELECT
    last_day(to_char(sysdate, 'yyyymmdd')) + INTERVAL '1' MONTH
FROM
    dual



                


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
	

















