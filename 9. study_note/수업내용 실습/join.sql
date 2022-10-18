ALTER SESSION SET nls_date_format='RR/MM/DD';
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT * FROM S_ORD;
SELECT * FROM S_PRODUCT;
SELECT * FROM S_ITEM;             ----중간테이블(다)를 기준으로 삼아야 한다

주문아이디, 고객아이디, 주문날짜, 상품아이디, 수량, 가격
SELECT i.ord_id
					, o.CUSTOMER_ID
          , o.DATE_ORDERED
          ,o.SALES_REP_ID
          , i.PRODUCT_ID                    ------ 현업에서는 무조건 열을 띄워서 가독성을 높인다
          ,P.NAME
          ,e.FIRST_NAME
				  , i.QUANTITY
          , i.PRICE
FROM S_ITEM i    ------ 가장 중심이 되는 테이블 '다'
				, S_ORD o
        , S_PRODUCT p
        , S_CUSTOMER c
        , S_EMP e
WHERE i.ORD_ID=o.ID
AND i.PRODUCT_ID=p.ID
AND o.CUSTOMER_ID=c.ID
AND o.SALES_REP_ID=e.ID
AND o.DATE_ORDERED BETWEEN '92/08/01' AND '92/08/31'  -- 92년 8월에 주문된 상품들만 출력
SELECT * FROM S_CUSTOMER;
SELECT * FROM S_ORD;

SELECT * FROM v$nls_parameters;

-----Non-Equi Join-----------
SELECT*FROM EMP;
SELECT*FROM SALGRADE;
SELECT empno, ename, sal, grade
FROM EMP e, SALGRADE s
WHERE e.sal BETWEEN s.losal AND s.hisal

------ 값 삽입하기 ------
SELECT * FROM EMP;
INSERT INTO EMP
VALUES (
						7977
            , 'daeyu'
            , 'sales'
            , 7902
            , SYSDATE
            , 3100
            ,200
            , NULL
            )
COMMIT;       ----컴퓨터가 꺼지더라도 하드에 확실히 저장하라


--------Outer Join----------
SELECT*FROM EMP;
SELECT*FROM DEPT;

SELECT *
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO (+) ;  -----null을 추가하라는 의미

------------self join------------------
SELECT*
FROM  EMP e , EMP m
WHERE e.mgr = m.empno(+);

----------------------------------------
1992년 8월에 판매된 제품들의
주문아이디, 고객아이디, 고객명, 영업사원아이디, 영업사원명,
영업사원직장상사명, 제품아이디, 제품명, 가격,수량을 출력하시오.
이때 대표이사도 영업을 할 수 있다.
SELECT i.ORD_ID
					, o.CUSTOMER_ID
          ,c.NAME
          , o.SALES_REP_ID
          , e.FIRST_NAME
          , m.FIRST_NAME mgrN
          , i.PRODUCT_ID
          , p.NAME
          , i.PRICE
          , i.QUANTITY
FROM S_ITEM i
				, S_ORD o
        , S_CUSTOMER c
        , S_EMP e
        , S_EMP m
        ,S_PRODUCT p
WHERE i.ORD_ID=o.ID
AND o.CUSTOMER_ID=c.ID
AND o.SALES_REP_ID=e.ID
AND e.MANAGER_ID=m.id(+)   ------ID랑 first_name 조인불가
AND i.PRODUCT_ID=p.ID
AND o.DATE_ORDERED BETWEEN '92/08/01' AND '92/08/31'


