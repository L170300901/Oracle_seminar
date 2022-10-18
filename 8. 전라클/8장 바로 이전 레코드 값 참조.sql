--p262 따라하기 : 환산금액 구하기

SELECT * FROM TEST02;

/* 동일한 구조의 두 서브쿼리 생성
   TEMP01 에서 CDATE (일자), AMT (금액) , TEMP02 에서 CRATE (환율) 이 필요하다
   TEMP01 에서 자신의 이전 레코드의 Data, 즉 전일의 환율이 TEMP02 에서  출력되도록
   각각의 ROWNUM 을 이용하여 조인할 것이다   */
--일자가 연속적인 값이었다면 ROWNUM 대신 일자로 조인할 수 있었을 것이다 
--책에서는 특정 일자 사이만 추가되도록 BETWEEN 추가 : 여기서는 생략
SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02;
SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02;

-- 두 서브쿼리의 Cartesian Product : 원하는 결과가 무엇인지 유심히 관찰해 볼 것
SELECT *
FROM
( SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP01,
( SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP02;

/* WHERE 조건 추가 : TEMP01 의 모든 결과가 출력되도록 OUTER JOIN ,
   OUTER JOIN 을 하지 않으면 전일 Data 가 없는 2001년 9월 1일 레코드가 출력되지 않는다 */
SELECT *
FROM
( SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP01,
( SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP02
WHERE TEMP01.MAIN_CNT -1 = TEMP02.SUB_CNT (+);  

-- * 를 필요한 컬럼들로 수정 , CDATE (일자) 순으로 정렬
SELECT TEMP01.CDATE, TEMP01.AMT, TEMP02.CRATE
FROM
( SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP01,
( SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP02
WHERE TEMP01.MAIN_CNT -1 = TEMP02.SUB_CNT (+)
ORDER BY CDATE;

/* 각각의 별칭을 넣고 ( 금액 * 전일 환율 ) = ( 환산금액 ) 컬럼 추가  
   이전 문장의 ORDER BY CDATE 를 수정하지 않으면
   "열의 정의가 애매합니다" 오류문 출력      */
SELECT TEMP01.CDATE AS 일자 , TEMP01.AMT AS 금액  , TEMP02.CRATE AS 전일환율 ,
       ( TEMP01.AMT * TEMP02.CRATE ) AS 환산금액
FROM
( SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP01,
( SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP02
WHERE TEMP01.MAIN_CNT -1 = TEMP02.SUB_CNT (+)
ORDER BY 일자;   

----------------------------------------------------------------------

--p265 문제 8-1번 : 이전 Record 값의 참조
SELECT * FROM TEST02;

-- t1, t2 두 서브쿼리를 Cartesian Product : 원하는 결과가 무엇인지 유심히 관찰해 볼 것
SELECT *
FROM 
( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
( SELECT ROWNUM as no2, CDATE, AMT, CRATE FROM test02 ) t2;

/* t1 에서 ( 자신의 이전 레코드 ) or ( 자기 자신 + 자신의 이전 레코드 ) 가 
   t2 에서 출력되도록 수정한다 */

--방법 1 : 아우터 조인 
SELECT *
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE T1.NO1 > T2.NO2 (+) 
ORDER BY T1.CDATE, T1.NO1;   -- 결과 확인을 쉽게 하기 위해 임시로 정렬 추가

--방법 2 : t2 에서 ROWNUM-1 으로 수정
SELECT *
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE T1.NO1 > T2.NO2 
ORDER BY T1.CDATE, T1.NO1;   -- 결과 확인을 쉽게 하기 위해 임시로 정렬 추가


-- 결과 확인을 쉽게 하기 위해 "D-1 일자", "D-1 환율" .. 도 같이 출력한다 
SELECT T1.CDATE AS 금일, T1.AMT AS 금액, T1.CRATE AS 금일환율,
       ( CASE WHEN T2.NO2 = T1.NO1 -2  THEN  T2.CDATE END ) "D-1 일자",
       ( CASE WHEN T2.NO2 = T1.NO1 -2  THEN  T2.CRATE END ) "D-1 환율",
       ( CASE WHEN T2.NO2 = T1.NO1 -3  THEN  T2.CDATE END ) "D-2 일자",
       ( CASE WHEN T2.NO2 = T1.NO1 -3  THEN  T2.CRATE END ) "D-2 환율",
       ( CASE WHEN T2.NO2 = T1.NO1 -4  THEN  T2.CDATE END ) "D-3 일자",
       ( CASE WHEN T2.NO2 = T1.NO1 -4  THEN  T2.CRATE END ) "D-3 환율"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE T1.NO1 > T2.NO2
ORDER BY 금일;

/* 위의 결과를 T1.CDATE, T1.AMT, T1.CRATE 로 GROUP BY 한다. 

   ( null 여러개 + DATA 1개 ) 
   이런 경우에는 SUM, MAX, MIN, AVG 함수 중 아무거나 써도
   같은 결과가 나온다.
   COUNT 는 안됨 : 전부 1 이 출력된다.

   < 전라클 22 장 참조>   */

SELECT T1.CDATE AS 금일, T1.AMT AS 금액, T1.CRATE AS 금일환율,
       AVG( CASE WHEN T2.NO2 = T1.NO1 -2  THEN  T2.CDATE END ) "D-1 일자",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -2  THEN  T2.CRATE END ) "D-1 환율",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -3  THEN  T2.CDATE END ) "D-2 일자",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -3  THEN  T2.CRATE END ) "D-2 환율",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -4  THEN  T2.CDATE END ) "D-3 일자",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -4  THEN  T2.CRATE END ) "D-3 환율"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE T1.NO1 > T2.NO2
GROUP BY T1.CDATE, T1.AMT, T1.CRATE
ORDER BY 금일;


-- 책의 최종 결과 출력 전 / 그룹화 이전 문장
SELECT T1.CDATE AS 금일, T1.AMT AS 금액, T1.CRATE AS 금일환율,
     ( CASE WHEN T2.NO2 = T1.NO1-2  THEN T2.CRATE END ) "D-1" ,
     ( CASE WHEN T2.NO2 = T1.NO1-3  THEN T2.CRATE END ) "D-2" ,
     ( CASE WHEN T2.NO2 = T1.NO1-4  THEN T2.CRATE END ) "D-3" ,
     ( CASE WHEN T2.NO2 = T1.NO1-5  THEN T2.CRATE END ) "D-4" ,
     ( CASE WHEN T2.NO2 = T1.NO1-6  THEN T2.CRATE END ) "D-5" ,
     ( CASE WHEN T2.NO2 = T1.NO1-7  THEN T2.CRATE END ) "D-6"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE t1.no1 > t2.no2
ORDER BY 금일;

-- 최종 (1) : T2 에서 ROWNUM-1 
SELECT T1.CDATE AS 금일, T1.AMT AS 금액, T1.CRATE AS 금일환율,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-2  THEN T2.CRATE END ) ) "D-1" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-3  THEN T2.CRATE END ) ) "D-2" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-4  THEN T2.CRATE END ) ) "D-3" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-5  THEN T2.CRATE END ) ) "D-4" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-6  THEN T2.CRATE END ) ) "D-5" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-7  THEN T2.CRATE END ) ) "D-6"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE t1.no1 > t2.no2
GROUP BY T1.NO1, T1.CDATE, T1.AMT , T1.CRATE
ORDER BY 금일;

--최종(2) : OUTER JOIN 추가 => 이 경우 CASE 문에서 빼 주는 숫자 수정
SELECT T1.CDATE AS 금일, T1.AMT AS 금액, T1.CRATE AS 금일환율,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-1  THEN T2.CRATE END ) ) "D-1" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-2  THEN T2.CRATE END ) ) "D-2" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-3  THEN T2.CRATE END ) ) "D-3" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-4  THEN T2.CRATE END ) ) "D-4" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-5  THEN T2.CRATE END ) ) "D-5" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-6  THEN T2.CRATE END ) ) "D-6"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE t1.no1 > t2.no2 (+)
GROUP BY T1.NO1, T1.CDATE, T1.AMT , T1.CRATE
ORDER BY 금일;

--최종(3) : 그룹화 전의 문장을 인라인 뷰로 사용한 후 그룹화 
SELECT 금일, 금액, 금일환율, 
       SUM("D-1") AS "D-1", SUM("D-2") AS "D-2", 
       SUM("D-3") AS "D-3", SUM("D-4") AS "D-4", 
       SUM("D-5") AS "D-5", SUM("D-2") AS "D-6" 
FROM          
( SELECT T1.CDATE AS 금일, T1.AMT AS 금액, T1.CRATE AS 금일환율,
     ( CASE WHEN T2.NO2 = T1.NO1-2  THEN T2.CRATE END ) "D-1" ,
     ( CASE WHEN T2.NO2 = T1.NO1-3  THEN T2.CRATE END ) "D-2" ,
     ( CASE WHEN T2.NO2 = T1.NO1-4  THEN T2.CRATE END ) "D-3" ,
     ( CASE WHEN T2.NO2 = T1.NO1-5  THEN T2.CRATE END ) "D-4" ,
     ( CASE WHEN T2.NO2 = T1.NO1-6  THEN T2.CRATE END ) "D-5" ,
     ( CASE WHEN T2.NO2 = T1.NO1-7  THEN T2.CRATE END ) "D-6"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE t1.no1 > t2.no2 )
GROUP BY 금일, 금액, 금일환율;

--------------------------------------------------------------------------

--전라클 p267 8-2번 : LAG(), LEAD() 사용

SELECT CDATE, AMT, 
    LAG(CDATE,1) OVER (ORDER BY CDATE DESC) "D+1 일자", 
    LAG(CRATE,1) OVER (ORDER BY CDATE DESC) "D+1 환율",
    LAG(CDATE,2) OVER (ORDER BY CDATE DESC) "D+2 일자", 
    LAG(CRATE,2) OVER (ORDER BY CDATE DESC) "D+2 환율",
    LAG(CDATE,3) OVER (ORDER BY CDATE DESC) "D+3 일자", 
    LAG(CRATE,3) OVER (ORDER BY CDATE DESC) "D+4 환율"
FROM TEST02
ORDER BY CDATE;


SELECT CDATE, AMT, 
    LEAD(CDATE,1) OVER (ORDER BY CDATE) "D+1 일자", 
    LEAD(CRATE,1) OVER (ORDER BY CDATE) "D+1 환율",
    LEAD(CDATE,2) OVER (ORDER BY CDATE) "D+2 일자", 
    LEAD(CRATE,2) OVER (ORDER BY CDATE) "D+2 환율",
    LEAD(CDATE,3) OVER (ORDER BY CDATE) "D+3 일자", 
    LEAD(CRATE,3) OVER (ORDER BY CDATE) "D+4 환율"
FROM TEST02
ORDER BY CDATE;