
--p404 따라하기 : 최댓값과 해당 해의 다른 값 가져오기

/* 매달 (YYMM_YM) , 제품(ITEM_CD)별로 
   BUDGET_CD '62099011' 항목으로 매출수량 , 
   BUDGET_CD '62099101' 항목으로 총원가 
   Data 가 금액 (PROD_AM) 컬럼에 저장된다  */

SELECT * FROM TEST17;



/* p403 공식에 따라 제품별 단위당 변동원가와 고정원가를 구하기 위해서는,
  해당 기간, 여기서는 '199703' ~ '199802' 12개월 중의
  최고판매량과 바로 그 때의 원가, ( 전체 기간 중 최고 원가가 아님! )
  최저판매량과 바로 그 때의 원가 Data 가 필요하다.*/ 

/* 먼저 1998년 3월보다 이전의 1년치 Data 를 읽어온다 ('199703' ~ '199802') 
   '62099011' (매출수량) 항목은 "Q_판매량" ,
   '62099101' (총원가) 항목은 "C_총원가" 에 출력되도록 CASE 함수를 추가한다 */

/* 단순히 WHERE 절을
     
     WHERE YYMM_YM BETWEEN '199703' AND '199802' 
   
   해도 되지만 나중에 '199803' 을 매개변수로 바꿔도 실행될 수 있도록 하였다.  */

SELECT YYMM_YM AS 년월, ITEM_CD AS 제품, 
    ROUND(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END )) AS Q_판매량,
    ROUND(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END )) AS C_총원가
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803';  --책과는 달리 ADD_MONTH 함수 사용


/* 위 문장을 년월(YYMM_YM), 제품(ITEM_CD) 별로 GROUP BY 한다
   월별로 제품의 매출수량, 총원가 Data 가 각각 한번씩 저장되어  
   위 문장에서 2개의 레코드씩 한 그룹으로 묶여진다.   */
--이 경우 그룹함수는 SUM, MAX, MIN, AVG 아무 거나 써도 상관없다.

SELECT YYMM_YM AS 년월, ITEM_CD AS 제품, 
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_판매량,
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_총원가
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD;

/* 위 문장을 인라인뷰로 하여 제품별로 GROUP BY 하고
   12개월 중 각 제품의 최소 / 최대 판매량과 그 때의 원가를 찾아야 한다. */

-------------------------------------------------------------------------

--다음은 잘못된 풀이 방법임      
--(잘못된 풀이)  
SELECT 제품 , 
       MIN(Q_판매량) AS 최소판매량, 
       MIN(C_총원가) AS "최소 총원가", --12개월 중 가장 작은 총원가 값
       MAX(Q_판매량) AS 최대판매량, 
       MIN(C_총원가) AS "최대 총원가"  --12개월 중 가장 큰 총원가 값
FROM 
( SELECT YYMM_YM AS 년월, ITEM_CD AS 제품, 
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_판매량,
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_총원가
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD )
GROUP BY 제품;

/* <위 문장이 잘못된 이유 >
   제품ID MC4 : 최소판매량 / 최소판매량의 총원가는 모두 1997년 12월로 맞지만
                위의 코드로 출력되는 최대판매량 334920377 는 1997년 11월, 
                최대판매량의 총원가 383730696 는 1997년 12월 DATA 로 맞지 않다
   제품ID C2- : 최대판매량 197557081 는 1998년 02월,
               최대판매량의 총원가 118509480 는 1997년 12월로 역시 맞지 않다 
  
  <결론> 
   단순히 전체 기간 중의 최소, 최대가 아니라
   제품의 판매량이 최소, 최대인 월의 총원가가 출력되도록 해야 한다  */

---------------------------------------------------------------------------

SELECT YYMM_YM AS 년월, ITEM_CD AS 제품, 
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_판매량,
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_총원가
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD;

/* 위 문장을 인라인뷰로 하여 제품별로 GROUP BY 하고, 
   제품의 판매량이 최소, 최대인 월의 총원가가 출력되도록 수정한다.  */
   
/* C_총원가를 충분히 큰 값 (1조 정도.. ) 로 나누면 매우 작은 값이 나온다.
   이 매우 작은 값을 Q_판매량에 더한 후 MIN / MAX 함수를 써도 
   전체 순위는 바뀌지 않을 것이고, 결국 같은 레코드를 반환할 것이다.
   이 값을 다시 MIN(Q_판매량) 또는 MAX(Q_판매량) 으로 뺀 후,
   다시 처음에 나누었던 충분히 큰 값을 곱하면 된다  */

SELECT 제품 , 
    MIN( Q_판매량 ) AS "1년중_최소판매량", 
    ( MIN( Q_판매량 + C_총원가/1000000000000 ) - MIN(Q_판매량) ) * 1000000000000   
    AS "최소판매월_총원가", 
    MAX( Q_판매량 ) AS "1년중_최대판매량", 
    ( MAX(Q_판매량 + C_총원가/1000000000000) - MAX(Q_판매량) )  * 1000000000000 
    AS "최대판매월_총원가"     --  입력 가능한 충분히 큰 총원가 : 1조 ( 1000000000000 )
FROM 
( SELECT YYMM_YM AS 년월, ITEM_CD AS 제품, 
    ROUND( SUM(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_판매량 ,
    ROUND( SUM(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_총원가
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD )
GROUP BY 제품;

/*
<예제>   
제품  판매량  원가  판매량 + 원가/(100000: 충분히 큰값)  판매량 + 원가/(100000: 충분히 큰값) - 판매량
 m1     1     30         1.00030                             0.00030
 m1     2     20         2.00020                             0.00020
 m2     3     10         3.00010                             0.00010

제품 m1 의 최소판매량은 1, 그때의 원가 30 을 가져오고 싶다.
MIN(판매량) 으로 구하는 것이 아니다. 그러면 원가를 가져올 방법이 마땅치 않다.
핵심은 가져오고 싶은 값을 충분히 큰 값으로 나눠서 최소/최대 데이터에 더하는 것
(1) MIN(판매량 + 원가/100000) 으로 최솟값을 구하고  => 위의 데이터에서는 1.000030
(2) 여기에 다시 MIN(판매량) 을 뺀 후  => MIN(판매량 + 원가/100000) - MIN(판매량) = 0.00030
(3) * (충분히 큰 값) 한다        => 최소판매량일 때의 원가 30 
*/


/* 위의 문장을 인라인뷰로 하여 단위당 변동원가와 고정원가를 계산해야 한다
   한글 별칭은 잘 인식이 안되므로 영어 별칭으로 수정하였다  */
SELECT 제품 , 
    MIN( Q_판매량 ) AS YEARLY_MIN_SALES, 
    ( MIN( Q_판매량 + C_총원가/1000000000000 ) - MIN(Q_판매량) ) * 1000000000000   
    AS MIN_TOTALCOST, 
    MAX( Q_판매량 ) AS YEARLY_MAX_SALES, 
    ( MAX(Q_판매량 + C_총원가/1000000000000) - MAX(Q_판매량) )  * 1000000000000 
    AS MAX_TOTALCOST     --  입력 가능한 충분히 큰 총원가 : 1조 ( 1000000000000 )
FROM 
( SELECT YYMM_YM AS 년월, ITEM_CD AS 제품, 
    ROUND( SUM(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_판매량 ,
    ROUND( SUM(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_총원가
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD )
GROUP BY 제품;


/* (최종) 
   위 문장을 인라인뷰로 하여 단위당 변동원가와 고정원가를 출력한다
   1년중 최대판매량과 최소판매량이 같은 경우에는 변동사항이 없으므로
   NULL 로 출력되도록 CASE 함수를 추가하였다  */
SELECT 제품, 
   ( CASE WHEN YEARLY_MAX_SALES = YEARLY_MIN_SALES THEN NULL
          ELSE ROUND( (MAX_TOTALCOST - MIN_TOTALCOST) / 
                      (YEARLY_MAX_SALES - YEARLY_MIN_SALES) )
          END ) AS 단위당변동원가 ,
  ( CASE WHEN YEARLY_MAX_SALES = YEARLY_MIN_SALES THEN NULL
         ELSE ROUND( MAX_TOTALCOST - (MAX_TOTALCOST - MIN_TOTALCOST) /
                     (YEARLY_MAX_SALES - YEARLY_MIN_SALES) * YEARLY_MAX_SALES )
         END ) AS 고정원가
FROM 
( SELECT 제품 , 
        MIN( Q_판매량 ) AS "YEARLY_MIN_SALES", 
        ( MIN( Q_판매량 + C_총원가/1000000000000 ) - MIN(Q_판매량) ) * 1000000000000   
        AS "MIN_TOTALCOST", 
        MAX( Q_판매량 ) AS "YEARLY_MAX_SALES", 
        ( MAX(Q_판매량 + C_총원가/1000000000000) - MAX(Q_판매량) )  * 1000000000000 
        AS "MAX_TOTALCOST"     --  입력 가능한 충분히 큰 총원가 : 1조 ( 1000000000000 )
FROM 
( SELECT YYMM_YM AS 년월, ITEM_CD AS 제품, 
      ROUND( SUM(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_판매량 ,
      ROUND( SUM(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_총원가
FROM TEST17
WHERE YYMM_YM < '199803' AND 
          YYMM_YM >= 
          TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
GROUP BY YYMM_YM, ITEM_CD )
GROUP BY 제품 )

---------------------------------------------------------------------------

--p409 문제 18-1 : 최댓값의 다른 해
SELECT * FROM TEST02;

--최대 CRATE 1390 을 가지는 일자 : 20100904 => 그 때의 AMT 10900
--최소 CRATE 1290 을 가지는 일자 : 20010911  => 그 때의 AMT 12000
SELECT ( MAX( CRATE + AMT/100000 ) - MAX( CRATE ) ) * 100000  AS MAX_CRATE ,
       ( MIN( CRATE + AMT/100000 ) - MIN( CRATE ) ) * 100000  AS MIN_CRATE
FROM TEST02;
-- GROUP BY 필요없음 : 전체 레코드가 하나의 그룹으로 간주된다