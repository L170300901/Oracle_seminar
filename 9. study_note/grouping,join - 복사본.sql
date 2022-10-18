ALTER SESSION SET nls_date_format='RR/MM/DD';
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT e.empno, e.ename, e.deptno, e.job
FROM EMP e, DEPT d
WHERE e.deptno = d.deptno
AND d.LOC = 'DALLAS';

SELECT empno, ename, dname, sal FROM EMP e, DEPT d
WHERE e.deptno= d.deptno

AND sal >= 3000
AND d.dname = 'SALES' ;
----------------------------------------1대 다 테이블


SELECT* FROM S_ORD;						 --'1'테이블
SELECT * FROM S_PRODUCT;    --'1'테이블
SELECT* FROM S_ITEM;       -- '다'테이블 = 현업에서 연관테이블 이름은 보통 s_ord_product;(두 테이블 이름 합쳐서)

SELECT i.ord_id                      ------------출력할 정보들들
					,o.customer_id
          ,C.NAME
          ,o.sales_rep_id
          ,e.FIRST_NAME
					,o.date_ordered
          ,i.PRODUCT_ID
          ,p.name
          ,i.QUANTITY
          ,i.PRICE
FROM S_ITEM i                    ----------출력할 정보를 가지고있는 테이블들 + 변수
				,S_ORD o
        , S_CUSTOMER c
        ,S_PRODUCT p
        ,S_EMP e
WHERE i.ord_id = o.id            ---------S_ITEM의 ORD_ID와  S_ORD의 ID가 동일
AND i.PRODUCT_ID = p.id       ---------S_ITEM의 PRODUCT_ID와 S_PRODUCT의 ID가 동일
AND o.customer_id = c.id       ---------S_ORD의 CUSTOMER_ID와 S_CUSTOMER의 ID가 동일
AND o.sales_rep_id = e.id;    ---------S_ORD의 SALES_REP_ID와 S_EMP의 ID가 동일

SELECT  * FROM v$nls_parameters;

SELECT * FROM EMP;
SELECT * FROM SALGRADE;
SELECT empno, ename, sal, grade
FROM EMP e, SALGRADE s
WHERE e.sal BETWEEN s.losal AND s.hisal


SELECT * FROM EMP e, DEPT d
WHERE e.deptno = d.deptno(+);


SELECT * FROM EMP e , EMP m
WHERE e.mgr = m.empno(+);

SELECT i.ord_id           -- 주문아이디
   ,o.DATE_ORDERED
     ,o.CUSTOMER_ID      -- 고객아이디
      ,C.NAME
      ,O.SALES_REP_ID
      ,e.FIRST_NAME
      ,m.FIRST_NAME mgr_name
      ,o.DATE_ORDERED
      ,i.PRODUCT_ID
      ,P.NAME
      ,g.FILENAME
      ,i.QUANTITY
      ,i.PRICE
FROM S_ITEM i
   ,S_ORD o
    ,S_CUSTOMER C
    ,S_PRODUCT p
    ,S_IMAGE g
    ,S_EMP E
    ,S_EMP m
where i.ORD_ID = o.id
 AND I.PRODUCT_ID = P.ID
 AND p.IMAGE_ID = g.id(+)
  AND O.CUSTOMER_ID = C.ID
 AND O.SALES_REP_ID = E.ID
 AND e.MANAGER_ID = m.id(+)
 AND O.DATE_ORDERED BETWEEN '92/08/01' AND '92/08/31';

SELECT * FROM s_product;

SELECT * FROM S_ORD
ORDER BY customer_id;

SELECT customer_id, SUM(total)  FROM S_ORD
GROUP BY customer_id;

SELECT * FROM EMP
ORDER BY deptno;

SELECT deptno, SUM(sal) total, max(sal), min(sal)
FROM EMP
GROUP by deptno;

SELECT job, max(sal)
FROM EMP
GROUP BY job;      --emp테이블에서 job별로(group by job) 최고급여(max(sal))

SELECT * FROM S_ORD;

SELECT customer_id, SUM(total)
FROM S_ORD
WHERE date_ordered LIKE '92/08%'
GROUP BY customer_id;

SELECT customer_id, sum(total)
FROM S_ORD
GROUP BY customer_id;
--그룹함수 적용후에 다시 정렬하고 싶을때 order by 함수 사용

SELECT * FROM EMP
ORDER BY deptno;               --부서별로 구분


SELECT deptno, sum(sal) FROM EMP     --4. 부서와 sal을 더한값을 출력
WHERE hiredate LIKE '81%'                 --1. 81년도에 입사한 사람들로 조건 제한
GROUP by deptno                            --2. 부서 그루핑
HAVING SUM(sal)>=7000                  --3. sal이 7000이상인 부서로 조건제한
ORDER BY SUM(sal)  ;                        --5. select할 것을 마지막으로 정렬
--순서-- 1.where 테이블 검색조건
--         2.group by 그루핑진행
--         3.having 그루핑한 테이블에서 조건
--         4.select 그룹함수적용
--         5.order by 정렬

SELECT deptno, sum(sal) FROM EMP
WHERE hiredate LIKE '81%'
GROUP by deptno
HAVING COUNT(*) >=2
ORDER BY SUM(sal);

SELECT i.PRODUCT_ID, P.NAME, SUM(price * quantity)
FROM S_ITEM i, S_ORD o, S_PRODUCT p
WHERE i.ord_id = o.id
AND i.PRODUCT_ID = p.id
AND o.DATE_ORDERED LIKE '92/08%'
group BY i.product_id, p.name
HAVING COUNT(*) >=2
ORDER BY SUM(quantity*price)

SELECT * FROM S_ITEM
ORDER BY product_id;


SELECT * FROM S_WAREHOUSE;
SELECT * FROM S_INVENTORY;
SELECT * FROM S_PRODUCT;


--상품아이디, 상품명, 창고아이디, 창고주소, 창고관리자 아이디, 창고관리자 직장상사명 출력--
SELECT i.PRODUCT_ID
					,P.NAME
          ,i.WAREHOUSE_ID
          ,w.ADDRESS
          ,w.MANAGER_ID
          ,m.FIRST_NAME
FROM S_WAREHOUSE w
				,S_INVENTORY i
        ,S_PRODUCT p
        ,S_EMP e
        ,S_EMP m
WHERE i.PRODUCT_ID = p.id
	AND w.id = i.WAREHOUSE_ID
  AND w.MANAGER_ID = e.id
  AND e.MANAGER_ID =m.id(+);


--subquery--
SELECT * FROM s_emp
WHERE dept_id =
									(SELECT dept_id FROM S_EMP
                  WHERE last_name ='Biri')

SELECT * FROM S_EMP
WHERE salary >
											(SELECT AVG(salary) FROM S_EMP )          --직원부서에서 평균급여보다 많이 받는사람 출력

SELECT * FROM S_EMP
WHERE first_name IN
													(SELECT min(first_name) FROM S_EMP
                          GROUP BY dept_id)


SELECT * FROM S_EMP
ORDER BY dept_id ASC, salary desc;

--1번--
SELECT * FROM S_EMP
WHERE (dept_id, salary) IN (SELECT dept_id, min(salary) FROM S_EMP
												GROUP BY dept_id)                                    ------부서별 최저급여를 받는 직원정보 출력
ORDER BY dept_id;

--2번--부서id와 최저시급을 s_emp와 조인한 것
SELECT*
FROM S_EMP e
				, (SELECT dept_id, min(salary) msal FROM S_EMP	GROUP BY dept_id) t
WHERE e.dept_id = t.dept_id
 AND e.SALARY = t.msal
ORDER BY e.dept_id

--3번--이 경우 서브커리를 여러번 반복하기 때문에 속도가 느림(상관관계서브커리 : Co-related Subquery)
SELECT * FROM S_EMP e                     --첫번째 실행(메인커리가 서브커리보다 먼저 실행)
WHERE salary =(SELECT min(salary)       --두번째 실행(e.dept_id와 서브커리(최저급여)의 dept_id가 같을경우 출력)
											FROM S_EMP
                      WHERE dept_id = e.dept_id);


CREATE TABLE S_ORD08
AS
select * FROM S_ORD
WHERE date_ordered LIKE '92/08%'

CREATE TABLE s_ord09
AS
SELECT * FROM s_ord
WHERE date_ordered LIKE '92/09%'

SELECT * FROM s_ord08
SELECT * FROM s_ord09;    --9월, 8월을 수평으로 나눈 칼럼

SELECT * FROM s_ord08
UNION ALL                    --나눠놨던 칼럼을 합치는 명령어 (행들의 합집합)
SELECT * FROM s_ord09;

--92년 8월과 9월의 주문아이디, 고객아이디, 고객명, 주문총액을 출력하시오.
SELECT o.id
					,o.customer_id
          ,o.date_ordered
          ,c.name
          ,o.total
FROM (SELECT * FROM s_ord08
					UNION ALL
					SELECT * FROM s_ord09) o
          , S_CUSTOMER c
WHERE o.customer_id = c.id;



--테이블 생성
DROP TABLE gisu;
CREATE TABLE gisu (
	id 		 					VARCHAR2(12)	PRIMARY KEY     --primary key를 선언해야 정보가 중복으로 생성되지 않음
  ,NAME 			VARCHAR2(20)
  ,age 					NUMBER(3)
  ,reg_date		DATE
  ,ssn					CHAR(13)
  );

INSERT INTO gisu
VALUES('hong', '홍길동', 20, SYSDATE, '1111');

COMMIT;

SELECT * FROM gisu;


--자신의 매니저보다 급여를 많이 받는 직원들의 성과 급여를 출력하시오
SELECT e.last_name
					,e.salary
FROM S_EMP e
				,S_EMP m
WHERE e.MANAGER_ID = m.id
 AND e.salary > m.SALARY

--AVG : 평균

-- 15] DEPT Table 에는 존재하는 부서코드이지만 해당부서에 근무하는 사람이 존재하지 않는 경우의 결과를 출력하라.
SELECT *
FROM DEPT d
				,EMP e
WHERE d.DEPTNO = e.deptno
 AND



-- 14] EMP Table의 데이터를 출력하되 해당사원에 대한 상관번호와 상관의 성명을 함께 출력하라.
SELECT *
FROM EMP
				,(SELECT m.empno mgr_no, m.ename mgr_name
        FROM EMP e, EMP m
        WHERE e.empno = m.mgr)


 사원번호, 이름, 부서명, 입사일, 지역을 출력하라.
-- 13] 10번 부서의 사람들중에서 20번 부서의 사원과 같은 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일, 지역을 출력하라.
SELECT e.empno
					,e.ename
          ,d.DNAME
          ,e.hiredate
          ,d.LOC
          ,d.DEPTNO
          ,e.job
FROM EMP e
				,DEPT d
WHERE e.deptno = d.DEPTNO
ORDER BY d.DEPTNO


--연봉이 3000 이상인 사원을 가지고 있는 부서 id와 부서명 조회
SELECT d.DEPTNO
					,d.DNAME
FROM EMP e
				,DEPT d
WHERE e.deptno =d.DEPTNO
 AND e.sal > 3000


--6 부서테이블에서 사원들의 평균연봉보다 많이 받는 사원들이 존재하는 부서의 부서id와 부서명 조회
SELECT d.DEPTNO
					,d.DNAME
FROM EMP e
				,DEPT d
WHERE e.deptno= d.DEPTNO
 AND  sal >	(SELECT AVG(sal) FROM EMP )



 SELECT LPAD(' ', LEVEL PRIOR 4,' ')|| empno, ename, mgr, level FROM EMP
 START with mgr  BY PRIOR empno= mgr


--ANSI 내부조인(inner join)--
SELECT *
FROM EMP e inner JOIN  DEPT d
						on e.DEPTno = d.DEPTNO
WHERE e.empno = 7369;


--아우터조인--
SELECT *
FROM EMP e, DEPT d
WHERE e.deptno = d.deptno(+)    --다 나와야하는 쪽이 아우터 테이블(emp테이블)--

--위 커리를 ANSI 조인을 사용--
SELECT *
FROM EMP e left outer JOIN DEPT d   	--왼쪽 테이블이 아우터테이블이기때문에 left--
				ON e.DEPTNO = d.DEPTNO

--full outer join  (필필요없어서 잘 안씀)
SELECT *
FROM EMP e FULL outer JOIN DEPT d
				ON e.deptno = d.DEPTNO
/*
SELECT *
FROM EMP e, DEPT d
WHERE e.deptno(+) = d.deptno(+)
--오라클에서는 양쪽 풀조인(+) 허용안함 (필요없어서 사용을 안함)
*/

