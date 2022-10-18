--------------Group By----------------
SELECT SUM(total) FROM S_ORD;   ----s_ord를 하나의 그룹으로 보고 총액을 줌

SELECT*FROM S_ORD
ORDER BY customer_id;

SELECT customer_id, SUM(total) FROM S_ORD   -----select절에는 group by다음에 나오는 칼럼만 올 수 있다.
                                   --ex) date_orderd같은 칼럼이 오면 오류남. 각자 합쳐진 칼럼도 주문 날짜가 달라서
GROUP BY customer_id            ----------고객별 주문 총액

-------
SELECT * FROM EMP
ORDER BY deptno;

SELECT deptno, SUM(sal) total, max(sal), min(sal)
FROM EMP
GROUP BY deptno;   -----그룹당 한행씩 출력한다

--각 job별로 최고급여를 출력하시오
SELECT job, max(sal)
FROM EMP
GROUP BY job;

SELECT customer_id, SUM( total )
FROM S_ORD
WHERE date_ordered LIKE '92/08%'
GROUP BY customer_id
ORDER BY SUM(total) desc
---1. where  2. group by 3. select 그룹함수 적용


-----------------having----------------------
81년도에 입사한 사원들의 부서별 급여총액을 출력하되
총 급여가 7000$이상인 부서만 출력하라
SELECT deptno, SUM(sal) FROM EMP
WHERE hiredate LIKE '81%'
GROUP BY deptno
HAVING SUM(sal)>=7000
ORDER BY SUM(sal)

1. WHERE절로 대상이 되는 레코드를 검색
2. GROUP BY
3. HAVING 조건절절이 실행되어 그룹을 선택
4. SELECT 그룹함수 적용
5. ORDER BY 정렬


81년도에 입사한 사원들에 대해서
부서별 사원수가 3명 이상인 부서에 대한
부서별 총 급여를 구하여 오름차순으로 정렬하시오
SELECT deptno, SUM(sal) FROM EMP
WHERE hiredate LIKE '81%'
GROUP BY deptno
HAVING COUNT(*)>=3   ---having은 그룹을 선택하는 조건
ORDER BY SUM(sal)


-------------복습----------------
SELECT * FROM S_ORD;
SELECT * FROM S_ITEM;
SELECT * FROM S_PRODUCT;
SELECT product_id, SUM(price*quantity)  ---상품별 매출총액
FROM S_ITEM
GROUP BY product_id;

92년 8월에 판매된 제품들의 제품판매총액을 구하라
SELECT product_id, SUM(price * quantity)
FROM S_ITEM i, S_ORD o
WHERE i.ORD_ID=o.ID
AND  o.DATE_ORDERED LIKE  '92/08%'    -----like는 index를 쓸 수 없어서 좋지 않다.
GROUP BY product_id;

2회 이상 판매된 제품들의 제품별 판매 총액을 구하라
SELECT product_id, SUM(price * quantity)
FROM S_ITEM i, S_ORD o
WHERE i.ORD_ID=o.ID
AND  o.DATE_ORDERED LIKE  '92/08%'
GROUP BY product_id
HAVING COUNT(*)>=2  ----group by의 조건절
ORDER BY SUM(price * quantity)

92년 8월에 판매된 각 제품들의 판매총액을 출력하시오
출력 내용은 상품아이디, 상품명, 판매총액
이때 판매 횟수가 2건 이상인 제품들만 출력하시오
SELECT i.product_id, P.NAME, SUM(price * quantity)
FROM S_ITEM i, S_ORD o, S_PRODUCT p
WHERE i.ORD_ID=o.ID
AND i.PRODUCT_ID=p.ID
AND  o.DATE_ORDERED LIKE  '92/08%'
GROUP BY i.product_id, p.name  -----p.name이 문법상 group by절에도 나와야 함
HAVING COUNT(*)>=2
ORDER BY SUM(price * quantity)


일대다 : 부서와 사원의 관계
다대다 : 주문과 상품의 관계 - - - 한 주문은 여러 상품을 주문할 수 있고
                                            한 상품은 여러 주문에서 주문 될 수 있다.

상품아이디, 상품명, 창고아이디, 창고주소,
창고관리자아이디, 창고관리자직장상사명
SELECT i.PRODUCT_ID
          , P.NAME
          , i.warehouse_id
          , w.ADDRESS
          , w.MANAGER_ID
          , m.FIRST_NAME
FROM S_INVENTORY i
				, S_PRODUCT p
        , S_WAREHOUSE w
        , S_EMP e
        , S_EMP m
WHERE i.PRODUCT_ID=p.ID
AND i.warehouse_id=w.ID
AND w.MANAGER_ID=e.ID
---AND e.ID=m.MANAGER_ID ( x ) warehouse에 있는 manager_id는 창고관리자 id다.
AND e.MANAGER_ID=m.ID(+) --그 창고관리자의 직장상사를 출력해야함