---서브쿼리---

--------단일행 서브쿼리
SELECT * FROM S_EMP;

last_name이 Biri 인 사원이 근무하는 부서의 직원들을 전부 출력하시오
SELECT * FROM S_EMP
WHERE dept_id =
											(SELECT DEPT_id FROM S_EMP
                      WHERE UPPER(last_name)='BIRI')
--만약 Biri의 부서번호를 안다면 바로 할 수 있지만 모르기때문에 서브쿼리를 사용
--알려지지 않은 데이터의 값을 알기위해 사용
--서브쿼리가 먼저 실행된다.  바깥의 쿼리가 메인쿼리. 서브이후 그 값을 아우터로 전달

--이때 =, >, < 연산자를 썼으면 서브쿼리의 값은(행은) 하나만 나와야한다

전체 직원의 평균급여보다 많이 받는 직원을 출력하라
SELECT * FROM S_EMP
WHERE salary >
									(SELECT AVG(salary) FROM S_EMP)

--------복수행 서브쿼리
--한개 이상의 값을 리턴받는 서브쿼리 (멀티로우쿼리)
--단일행 연산자 대신에 IN과 같은 복수행 연산자를 사용

부서별로 알파벳 순으로 첫번째 오는 first_name
SELECT * FROM S_EMP
WHERE first_name IN	(SELECT min(first_name) FROM S_EMP
															GROUP BY dept_id)

 --SELECT dept_id, min(first_name)
 --FROM S_EMP
 --GROUP BY dept_id

 --ppt예제
 각 부서별로 최고급여를 받는 직원의
 Dept_id, ID, Last_name, Salary를 출력하시오.
 SELECT s.DEPT_ID, s.ID, s.LAST_NAME, s.SALARY
 FROM S_EMP s
 WHERE (DEPT_ID,salary) IN( SELECT dept_id,MAX(salary) FROM S_EMP
                              GROUP BY dept_id)
 --???왜 where절에서 괄호해야 오류안남?
 --풀이과정
 SELECT * FROM S_EMP
 WHERE salary IN (SELECT MIN(salary) FROM S_EMP
                         GROUP BY dept_id)
 --이렇게만 조건을 형성하면 어떤 부서의 최저급여가 또 다른 부서의 최고급여일 수 있다
 --서브쿼리가 실행된 값과 무조건 같다고 출력하면 원하는 결과값을 얻을 수 없다
 --따라서 부서아이디와 급여를 같이 비교해서 두 칼럼의 조합이 같을때 출력해야함


 --부서별 최저급여를 구하는 3가지 방식

 1. where절의 조건에 서브쿼리 주기 'IN' 사용
 --IN절에서 나온 멀티행을 멀티칼럼과 비교해서 풀이
 SELECT * FROM S_EMP s
 WHERE (dept_id, salary) IN( SELECT dept_id, MIN(salary) FROM S_EMP
                              GROUP BY dept_id)

 2. from절의 'in-line View'
 --가상으로 메모리에 올라간 테이블을 조인해서 풀이
 SELECT *
 FROM S_EMP e, ( SELECT dept_id, MIN(salary) msal FROM S_EMP
                        GROUP BY dept_id) m    --메모리 상에서 이 두개의 테이블 존재
 WHERE e.DEPT_ID=m.dept_id
 		AND e.SALARY=m.msal

3. 'Co-related' 서브쿼리
SELECT * FROM S_EMP e
WHERE salary =(SELECT MIN(salary)
											FROM S_EMP
                      WHERE dept_id=e.DEPT_ID)
--특이하게 바깥의 쿼리부터 실행됨.
--각 행마다 서브쿼리가 매번 실행된다. 매우 비효율적



------------집합연산자--------------
OLTP (ONLINE TRANSACTION Processing)
DW(데이터 웨어하우스)

데이터 이관 : 두개의 데이터베이스를 설치하는것
		하나는 데이터웨어하우징시스템을 쓰고 하나는 OLTP환경에서 바로사용
SELECT * FROM S_ORD;
SELECT dept_id, min(salary) msal FROM S_ORD
           GROUP BY dept_id

-------서브쿼리에 의한 테이블생성
CREATE TABLE S_ORD08
AS
SELECT * FROM S_ORD
WHERE date_ordered LIKE '92/08%'


--------Union all  (합집합)----------------
SELECT * FROM S_ORD08
UNION ALL
SELECT * FROM S_ORD09;

--join은 중복성의 문제때문에 나눠 놓은 테이블을 합칠때 사용. 수직
--합집합 union all은 특정 기준에 따라 나눠놓은 레코드를 합칠때 사용. 수평

92년 8월과 9월 주문정보를 출력하시오
주문아이디, 고객아이디, 고객명, 주문총액을 출력하시오

SELECT o.id, o.customer_id,C.NAME, o.total
FROM ( SELECT * FROM S_ORD08
                       UNION ALL
                       SELECT * FROM S_ORD09) o, S_CUSTOMER c
WHERE o.customer_id=c.ID










