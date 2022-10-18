





--시작 전 날짜 형식 바꾸기
ALTER SESSION SET nls_date_format='RR/MM/DD';






-- 1. 이름이 S로 끝나는 사원의 이름과 사원 번호를 가져온다.

SELECT ename, empno
FROM EMP
WHERE ename LIKE '%S';

-- 2. 이름에 A가 포함되어 있는 사원의 이름과 사원 번호를 가져온다.

SELECT ename, empno
FROM EMP
WHERE ename LIKE '%A%';

-- 3. 이름의 두번째 글자가 A인 사원의 사원 이름, 사원 번호를 가져온다.

SELECT ename, empno
FROM EMP
WHERE ename LIKE '_A%';

-- 4. 사원중에 커미션을 받지 않는 사원의 사원번호, 이름, 커미션을 가져온다.

SELECT empno, 
       ename, 
       comm 
  FROM EMP 
 WHERE comm IS NULL 
       OR comm<=0; 
ORDER BY 1; 

-- 5. 1981년에 입사한 사원들의 사원번호, 사원 이름, 입사일을 가져온다. 사원 번호를 기준으로 내림차순 정렬을 한다.


				--일케 하면 너무 무식한 방법인거 같아서
SELECT empno
     , ename
     , sal
     , hiredate
FROM EMP
WHERE hiredate >= '1981/01/01'
       AND hiredate <= '1981/12/31'
ORDER BY 1;

				--숫자 함수 공부했으니 ㅋㅋㅋ trunc를 이용해 다시 풀어봄
SELECT empno
     , ename
     , sal
     , hiredate
FROM EMP
WHERE TRUNC(hiredate, 'YYYY') = '1981/01/01'
ORDER BY 1;

-- 6. 급여가 1500 이상인 사원의 급여를 15% 삭감한다. 단 소수점 이하는 버린다.

SELECT TRUNC(sal*0.85) NewSal
FROM EMP
WHERE sal>=1500
ORDER BY 1;

-- 7. 급여가 2천 이하인 사원들의 급여를 20%씩 인상한다. 단 10의 자리를 기준으로 반올림한다.

SELECT ROUND((sal*1.2),-2) NewSal
FROM EMP
WHERE sal<=2000
ORDER BY 1;

-- 8. 사원들의 이름을 소문자로 가져온다.

SELECT LOWER(ename) NAME
FROM EMP;

-- 9. 사원의 이름 중에 A라는 글자가 두번째 이후에 나타나는 사원의 이름을 가져온다.***

						--방법1
            	--이건 다 아는방법 두번째 A인거 찾고 and로 첫번째 두번째  A인거 빼면됨

SELECT ename
FROM EMP
WHERE ename LIKE '__%A%'
       AND ename NOT LIKE 'A%'
       AND ename NOT LIKE '_A%'
ORDER BY 1;


					--방법2
						--오늘 본 instr쓰면 간단히 풀수 있음 영어는 1byte 한글은 2byte
            		--p.s 그럼 한자는 몇 바이트 일까????
            				--instr(컬럼or문자열,문자) 교과서 63쪽
SELECT ename
FROM EMP
WHERE INSTR(ename,'A')>2
ORDER by 1;

-- 10. 사원 이름을 앞에 3자리만 출력한다.

SELECT SUBSTR(ename,1,3) NAME
FROM EMP;

-- 11. 직무가 SALESMAN인 사원의 입사일 100일전 날짜를 가져온다.

SELECT hiredate
     , hiredate - 100
FROM EMP
WHERE job = 'SALESMAN';

-- 12. 전 사원의 근무 일을 가져온다.

SELECT TRUNC(SYSDATE - hiredate) 근무_일
FROM EMP;

-- 13. 모든 사원이 근무한 개월 수를 구한다.

SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) 근무한_개월수
FROM EMP;

-- 14. 다음달의 마지막 날짜를 구한다.

SELECT last_day(ADD_MONTHS(SYSDATE,1)) next_month_last_date
FROM dual;

-- 15. 사원이름, 입사일을 구한다. 단, 사원들의 입사일을 다음과 같은 양식으로 가져온다.
-- 81.10.10

SELECT ename
     , TO_CHAR(hiredate, 'YY.MM.DD') new_hiredate
FROM EMP;

-- 16. 각 사원의이름과 부서 이름을 가져온다.
-- 부서이름은 번호별로 한글이름이 표시되게 (10='인사과', 20='개발부', 30='경원지원팀', 40='생산부')

SELECT empno
     , ename
     , DECODE(deptno, 10, '인사과', 20, '개발부', 30, '경영지원팀', 40, '생산부') New_Decode
FROM EMP;

-- 17. 사원번호, 사원이름, 급여액 별 등급을 가져온다.
-- 1000 미만 : C등급
-- 1000 이상 2000미만 : B등급
-- 2000 이상 : A등급

					--방법1) case문 사용
SELECT empno
     , ename
     , CASE
           WHEN sal < 1000 THEN 'C등급'
           WHEN sal >= 1000 AND sal < 2000 THEN 'B등급'
           WHEN sal >= 2000 THEN 'A등급'
       END grade
  FROM EMP;

					--방법2) decode문 사용


SELECT empno ,
       ename ,
       DECODE(SIGN(sal-1000),-1,'C등급', DECODE(SIGN(sal-2000),-1,'B등급','A등급') ) grade
  FROM EMP;


-- 18. 급여가 1500 이상인 사원들의 급여 총합을 구한다.

SELECT SUM(sal) Sum_Sal
FROM EMP
WHERE sal >= 1500;

-- 19. 커미션을 받는 사원들의 커미션 평균을 구한다.**?

			--오늘 책에서 본거네 ..p96 2번째줄 딱 밑줄 친거다 ...
      	--null이 들어가면 해당 값은 아예 결과에 포함을 시키지 않음
        	--위 내용을 이용하자

SELECT TRUNC(AVG(comm)) AVG_Comm
FROM EMP;

-- 20. 전 사원의 커미션의 평균을 구한다.

SELECT TRUNC(AVG(NVL(comm, 0))) Avg_Comm
FROM EMP;
													--보기 안좋아서 그냥 trunc써서 반올림 할께용 ^^*/

-- 21. 사원들의 급여 최대, 최소값을 가져온다.

SELECT MAX(sal) MaxSal, MIN(sal) Min_Sal
FROM EMP;
