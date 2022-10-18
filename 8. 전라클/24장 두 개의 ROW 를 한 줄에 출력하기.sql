--p475 따라하기 : 두 RECORD 를 한 줄에 보여주기

-- (책의 풀이)
-- TEMP 에서 R_CNT (ROWNUM), 사원ID (EMP_ID), 사원명 (EMP_NAME) 출력
-- 최종 결과가 확실히 정렬되도록 ORDER BY EMP_ID 절 추가
SELECT * FROM TEMP;

SELECT ROWNUM AS R_CNT, EMP_ID AS 사원ID, EMP_NAME AS 사원명 
FROM TEMP 
ORDER BY EMP_ID;

/*위의 결과를 FROM 절의 인라인뷰로 하여 
  단위 ( CASE 함수 ), 사원ID, 사원명을 추가한다    */

/*  ROWNUM 인 R_CNT 를 2로 나눈 나머지가 ,

       1 => R_CNT 는 홀수 =>  그대로 출력 (홀수)
       2로 나눈 나머지가 0 => R_CNT 는 짝수 =>  R_CNT - 1 출력 (홀수)  

    단위는 1 , 1 , 3 , 3 , 5 , 5 , ... 와 같이 홀수가 2번씩 출력된다
    단위값으로 나중에 GROUP BY => 두 레코드를 한 그룹으로 묶는다    */

SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                           WHEN 0 THEN R_CNT-1 END ) AS 단위 ,
       사원ID , 사원명
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS 사원ID, EMP_NAME AS 사원명 
       FROM TEMP 
       ORDER BY EMP_ID );



/* 사원ID, 사원명이 CASE 함수에 의해 출력되도록 위의 결과를 수정한다.
   R_CNT 가 홀수, 즉 MOD(R_CNT,2) = 1 일 때 사원ID1, 사원명1 로,
   R_CNT 가 짝수, 즉 MOD(R_CNT,2) = 0 일 때 사원ID2, 사원명2 로 출력되도록 한다.  */
SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                           WHEN 0 THEN R_CNT-1 END ) AS 단위 ,
       ( CASE MOD(R_CNT,2) WHEN 1 THEN 사원ID END ) AS 사원ID1 ,
       ( CASE MOD(R_CNT,2) WHEN 1 THEN 사원명 END ) AS 사원명1 ,
       ( CASE MOD(R_CNT,2) WHEN 0 THEN 사원ID END ) AS 사원ID2 ,
       ( CASE MOD(R_CNT,2) WHEN 0 THEN 사원명 END ) AS 사원명 2
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS 사원ID, EMP_NAME AS 사원명 
       FROM TEMP 
       ORDER BY EMP_ID );



/* 위의 문장을 
   ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                       WHEN 0 THEN R_CNT-1 END ) 로 그룹화하고 정렬한다.
   GROUP BY 단위 => 안됨 ( 인라인뷰를 쓰지 않는 한 .. )
   ORDER BY 단위 => 됨
   그룹함수는 MIN, MAX 아무 거나 가능하다   */

SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                           WHEN 0 THEN R_CNT-1 END ) AS 단위 ,  --출력 결과 확인 후 지울 것
       MAX( ( CASE MOD(R_CNT,2) WHEN 1 THEN 사원ID END ) ) AS 사원ID1 ,
       MAX( ( CASE MOD(R_CNT,2) WHEN 1 THEN 사원명 END ) ) AS 사원명1 ,
       MAX( ( CASE MOD(R_CNT,2) WHEN 0 THEN 사원ID END ) ) AS 사원ID2 ,
       MAX( ( CASE MOD(R_CNT,2) WHEN 0 THEN 사원명 END ) ) AS 사원명2
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS 사원ID, EMP_NAME AS 사원명 
       FROM TEMP 
       ORDER BY EMP_ID )  --여기를 지우고 실행시켜 볼 것
GROUP BY  ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                              WHEN 0 THEN R_CNT-1 END )
ORDER BY 단위;

/* 위의 결과에서 아래 4번째 줄에 있는 ORDER BY EMP_ID 를 지우고 출력해 보면
   결과가 EMP_ID 순서로 출력되지 않는 것을 알 수 있다.. ( 100% 는 아님 )

   책에서는 ORDER BY EMP_ID 대신 WHERE EMP_ID > 0 을 써도 된다고 나와있다
   WHERE EMP_ID > 0 조건도 정렬을 해주는 듯..  */



--(자체 풀이) Cartesian Product 후 WHERE 조건으로 원하는 레코드만 출력하기

SELECT A.단위, A.사원ID AS 사원ID1, A.사원명 AS 사원명1, 
       B.단위, B.사원ID AS 사원ID2, B.사원명 AS 사원명2
FROM 
( SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                             WHEN 0 THEN R_CNT-1 END ) AS 단위 ,
          사원ID , 사원명
  FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS 사원ID, EMP_NAME AS 사원명 
         FROM TEMP 
         ORDER BY EMP_ID ) ) A , 
( SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                             WHEN 0 THEN R_CNT-1 END ) AS 단위 ,
          사원ID , 사원명
  FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS 사원ID, EMP_NAME AS 사원명 
         FROM TEMP 
         ORDER BY EMP_ID ) ) B
WHERE A.단위 = B.단위 AND A.사원ID < B.사원ID;

-----------------------------------------------------------------------------------

--p481 따라하기 : 두 개의 ROW 를 한줄에 

SELECT * FROM TEST27;  --12개 레코드 출력 : A001 4개, A002 4개, A003 4개

SELECT * FROM TEST27 A, TEST27 B;  -- Cartesian Product : 12 X 12 = 144 개 출력

/* A.TYPE_CD 가 B.TYPE_CD 보다 작아야 한다.
   책에서 원하는 결과와는 다르지만 다음과 같이 WHERE 조건을 줄 수 있다.  */
SELECT * 
FROM TEST27 A, TEST27 B
WHERE A.KEY1 = B.KEY1
  AND A.TYPE_CD < B.TYPE_CD;    -- 18개 레코드 출력 

/* A.TYPE_CD 가 B.TYPE_CD 보다 1만큼 작아야 한다.
  WHERE AND A.TYPE_CD < B.TYPE_CD 
     AND A.TYPE_CD + 1 = B.TYPE_CD      
  이렇게 WHERE 조건을 줄 수도 있으나, 사실 처음 WHERE 조건은 필요없다 */

SELECT * 
FROM TEST27 A, TEST27 B
WHERE A.KEY1 = B.KEY1 
  AND A.TYPE_CD < B.TYPE_CD   --이 조건은 생략해도 됨. 아래 조건으로 충분
  AND A.TYPE_CD + 1 = B.TYPE_CD;

/* 위 문장을 출력했을 때, 마지막 두 레코드가 정렬되어 있지 않음을 알 수 있다
  이를 해결하는 방법은 크게 2가지..  */

--(1) 단순하게 마지막에 ORDER BY ~ 추가
SELECT *   -- 여기에는 똑같은 이름의 컬럼이 각각 2개씩 있다
FROM TEST27 A, TEST27 B
WHERE A.KEY1 = B.KEY1 
  AND A.TYPE_CD + 1 = B.TYPE_CD
ORDER BY A.KEY1, A.TYPE_CD;  --단순히 KEY1, TYPE_CD 로 하면 "열의 정의가 애매합니다" 에러 출력


--(2) FROM 절을 인라인뷰로 수정하고 WHERE KEY1 > ' ' 각각 추가
SELECT *   -- 여기에는 똑같은 이름의 컬럼이 각각 2개씩 있다
FROM ( SELECT * FROM TEST27 WHERE KEY1 > ' ' ) A , 
     ( SELECT * FROM TEST27 WHERE KEY1 > ' ' ) B
WHERE A.KEY1 = B.KEY1 
  AND A.TYPE_CD + 1 = B.TYPE_CD;

/* KEY1 이 텍스트 컬럼 : WHERE KEY1 > ' ' 이라는 희한한 조건절을 주었다.
   이 조건절에 의해 테이블의 SCAN 방식이 바뀐다고 책에 나옴 */
/* WHERE KEY1 > ' ' 대신 ORDER BY KEY1 으로 수정하면
   마지막의 출력 결과가 정렬되지 않는다                    */