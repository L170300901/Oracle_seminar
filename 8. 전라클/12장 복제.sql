SELECT * FROM TEST06;

SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13;

/* TEST06 인라인뷰 A, 1~12 까지의 ROWNUM을 인라인뷰 B 로 조인한다
   WHERE 조건에 의해 TEST06 테이블의 YMD 가 1월이면 B테이블의 1~12, 
   2월은 2~12, 3월은 3~12  .. 이런 식으로 조인된다   */
SELECT *
FROM TEST06 A, 
  ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE B.R_CNT >= TO_CHAR(TO_DATE(A.YMD),'MM');

--책의 두번째 방법, 결과 확인 위해 정렬했음
SELECT B.R_CNT, A.YMD, A.LEASE, 
       LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || 
                LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS 이자계산일
FROM TEST06 A, 
   ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
      LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || 
               LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM'))
ORDER BY A.YMD, B.R_CNT;  

/* 대출받은 일자     이자일     => 같은 달일 때 : 빌린 일자 반환
 ex) 2001/01/15   2001/01/31                        16
-- 대출받은 일자     이자일     => 다른달 일 때 : 이자계산일의 마지막 일자 반환
 ex) 2001/01/15   2001/02/28                               28           */
SELECT B.R_CNT, A.YMD, A.LEASE, 
    LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS 이자계산일,
    ( CASE WHEN TO_CHAR(TO_DATE(A.YMD),'MM') = LPAD(TO_CHAR(B.R_CNT),2,'0')
           THEN LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM'))
                - TO_DATE(A.YMD) 
           ELSE TO_NUMBER ( TO_CHAR(   -- 이자일을 CHAR 변환 후 NUMMBER ('DD') 변환 => 이자월의 총 일자 반환
                   LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')), 'DD'))
           END ) AS TERM
FROM TEST06 A, 
  ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
      LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM'))
ORDER BY A.YMD, B.R_CNT;    


--책대로 하면 너무 복잡해지므로 수정함
/* 각각의 레코드 별로 
   빌린 금액 (LEASE) * 빌린 일자 (TERM) / 365 * 연이율 (0.125) = "이자" 가 계산된다.
   이자일별로 GROUP BY 하면 SUM( (이자) ) => 월별이자총액이 된다   */ 
SELECT 이자일, SUM(LEASE*TERM/365*0.125) AS 월별이자총액
FROM
( SELECT B.R_CNT, A.YMD, A.LEASE, 
    LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS 이자일,
    ( CASE WHEN TO_CHAR(TO_DATE(A.YMD),'MM') = LPAD(TO_CHAR(B.R_CNT),2,'0')
           THEN LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM'))
                     - TO_DATE(A.YMD) 
           ELSE TO_NUMBER ( TO_CHAR(   -- 이자일을 CHAR 변환 후 NUMMBER ('DD') 변환 => 이자월의 총 일자 반환
                LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')), 'DD'))
           END ) AS TERM
FROM TEST06 A, 
  ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
      LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) )
GROUP BY 이자일 

--------------------------------------------------------------------------------------

--문제 12-1 : 복제의 이용 => 책과 다르게 풀이했음
SELECT R_CNT
FROM ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 )
WHERE R_CNT IN (3, 6, 9, 12);   --ROWNUM 을 3, 6, 9, 12 만 출력 => 3월, 6월, 9월, 12월


/* TO_CHAR( (날짜), 'Q') => 분기값 1, 2, 3, 4 중 하나를 반환한다  */

SELECT B.R_CNT, A.YMD, A.LEASE, 
    LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS 이자일,
--빌린 일자와 이자일이 같은 분기일 때 : (이자일) - (빌린일자) => 대출기간
    ( CASE WHEN TO_CHAR(TO_DATE(A.YMD,'RRRRMMDD'),'Q') =
                TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')),'Q')
           THEN LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) 
                 - TO_DATE(A.YMD,'RRRRMMDD')  
--빌린 일자와 이자일이 다른 분기일 때 : ( 이자일 ) - ( 이자일 전분기의 마지막 일자 ) = > 대출 기간
      ELSE LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) -
         ( CASE TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')),'Q')
           WHEN '2' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '03' ,'RRRRMM'))
           WHEN '3' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '06' ,'RRRRMM'))
           WHEN '4' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '09' ,'RRRRMM'))
           END )
    END )  AS TERM
FROM TEST06 A, 
  ( SELECT R_CNT FROM ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) 
    WHERE R_CNT IN (3, 6, 9, 12) ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
          LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) ;



--최종 : 위의 코드를 이자일로 그룹화
SELECT 이자일, SUM(LEASE*TERM/365*0.125) AS 분기별이자총액
FROM
( SELECT B.R_CNT, A.YMD, A.LEASE, 
    LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS 이자일,
--빌린 일자와 이자일이 같은 분기일 때 : (이자일) - (빌린일자) => 대출기간
    ( CASE WHEN TO_CHAR(TO_DATE(A.YMD,'RRRRMMDD'),'Q') =
                TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')),'Q')
           THEN LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) 
                 - TO_DATE(A.YMD,'RRRRMMDD')  
-- ( 이자일 ) - ( 이자일 전분기의 마지막 일자 ) = > 대출 기간
      ELSE LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) -
         ( CASE TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')),'Q')
           WHEN '2' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '03' ,'RRRRMM'))
           WHEN '3' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '06' ,'RRRRMM'))
           WHEN '4' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '09' ,'RRRRMM'))
           END )
    END )  AS TERM
FROM TEST06 A, 
  ( SELECT R_CNT FROM ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) 
    WHERE R_CNT IN (3, 6, 9, 12) ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
          LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) )
GROUP BY 이자일;      

-----------------------------------------------------------------------------------

--p330 따라하기 : 합계와 비율 계산
SELECT * FROM TEST35;

--p329 의 결과와 최대한 유사하게 출력되도록 A, B 컬럼 추가
SELECT KEY1, KEY2,  -- KEY2 는 결과 확인 후 지울 것
       ( CASE KEY2 WHEN 'A' THEN AMT END ) AS "A" ,
       ( CASE KEY2 WHEN 'B' THEN AMT END ) AS "B"
FROM TEST35;

/* 위의 테이블을 KEY1 으로 그룹화 : 그룹 함수는 MIN, MAX, SUM,, AVG 중 아무 거나 상관없음 
   p329 의 결과와 같이 여기서 바로 
   MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) - MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) )
   하여 C 컬럼을 추가할 수도 있지만, 하지 않음. 나중에 할 수 있는데 괜히 복잡해진다
   p329 의 마지막 레코드 , 즉 합계를 구하는데 집중한다.   */

SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
             MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
FROM TEST35
GROUP BY KEY1;

-- 위의 결과를 x 2 복제 :  RNUM 1 은 그냥 DATA 출력, RNUM 2 는 총 합계를 구하는데 사용한다.
SELECT *
FROM 
( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
               MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
  FROM TEST35
  GROUP BY KEY1 ) , 
( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 );  -- ROWNUM 1, 2 

-- KEY1 컬럼에서 RNUM = 1 일 때 KEY1, 2 일 때 '합계 문자열이 출력되도록 CASE 함수 추가
SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END ) AS "KEY1", A, B
FROM 
( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
               MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
  FROM TEST35
  GROUP BY KEY1 ) , 
( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 );

/* 위의 결과를 ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END ), 
   즉, KEY1 으로 GROUP BY 한다
   KEY1 의 출력되는 값은 0001 ~ 0006 각 1개씩 6개 + '합계' 6개 총 12개, 
   GROUP BY 할 경우 총 7개의 그룹으로 묶여진다 
    -- 0001 ~ 0006 6개의 레코드 => 각각 6개의 그룹
    -- '합계' 6개 레코드 => 하나의 그룹               

   0001 ~ 0006 레코드는 각각 1개의 레코드가 각각 1개의 그룹이 된다
   따라서 SUM(A) , SUM(B) 를 해도 그냥 원래 값을 출력한다
   
   그러나 RNUM 2, 즉 KE1 이 '합계' 인 6개의 레코드에는 원래 TEST35 에 있었던
   전제 DATE 들이 그대로 복제되어 있다. 
   이 경우 SUM(A) , SUM(B) 는 전체 합계 값을 출력한다    */

/* A와 B의 차이, 즉 C 컬럼도 추가한다. 컬럼 C 는 SUM (A-B) 해도 상관없음 */

SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END ) AS "KEY1" , 
         SUM(A) AS "A" ,   
         SUM(B) AS "B" ,   
         ( SUM(A) - SUM(B) ) AS C  
FROM 
  ( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
                 MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
    FROM TEST35
    GROUP BY KEY1 ) , 
  ( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END )
ORDER BY KEY1;



/* 위의 문장을 실행하면 p331의 마지막 결과가 출력된다. 
   여기에 C/A * 100 , 즉 PER 컬럼만 추가하면 끝난다. 방법은 2가지.
    (1) 자체 풀이 : 위의 결과에서 SELECT 절에 바로 PER 컬럼 추가
    (2) 책대로 풀이 : 위의 결과를 FROM 절의 인라인뷰로 하여 PER 컬럼 추가
   두 방법 모두 마지막에 KEY1 으로 정렬한다.  */

/* 전라클 p333 설명 : 방법 (1) 은 테이블을 한 번 더 읽어야 한다는 단점이 있다고 한다   */

--(1) 자체 풀이 : 위의 결과에서 PER 추가
SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END ) AS "KEY1" , 
         SUM(A) AS "A" , SUM(B) AS "B", ( SUM(A) - SUM(B) ) AS "C" , 
         ROUND( 100 * ( SUM(A) - SUM(B) ) / SUM(A) ) AS "PER"  
FROM 
  ( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
                 MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
    FROM TEST35
    GROUP BY KEY1 ) , 
  ( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END )
ORDER BY KEY1;

--(2) 책대로 풀이 : 위의 결과를 다시 SELECT 해서 PER 계산
SELECT KEY1, A, B, C, 
       ROUND(100*(A-B)/A) AS PER     --PER컬럼 추가
FROM 
(  SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END ) AS "KEY1" , 
            SUM(A) AS "A" , SUM(B) AS "B", ( SUM(A) - SUM(B) ) AS C  
FROM 
  ( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
                 MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
    FROM TEST35
    GROUP BY KEY1 ) , 
  ( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END )  )
ORDER BY KEY1;

-----------------------------------------------------------------------------

--p333 문제 12-2 : 합계의 비율 계산
SELECT * FROM TEMP;

/* CASE 구문에서 값이 NULL 일 경우 0 으로 출력되도록 해야 이후에 그룹함수를 쓸 수 있다 
   정확히는 SUM 함수와 PER (비율) 계산이 가능해진다 */
SELECT DEPT_CODE AS KEY1,
      ( CASE LEV WHEN '부장' THEN SALARY ELSE 0 END ) AS "부장",
      ( CASE LEV WHEN '차장' THEN SALARY ELSE 0 END ) AS "차장",
      ( CASE LEV WHEN '과장' THEN SALARY ELSE 0 END ) AS "과장",
      ( CASE LEV WHEN '대리' THEN SALARY ELSE 0 END ) AS "대리",
      ( CASE LEV WHEN '사원' THEN SALARY ELSE 0 END ) AS "사원",
      ( CASE LEV WHEN '수습' THEN SALARY ELSE 0 END ) AS "수습"
FROM TEMP; 

--위의 결과를 x 2 복제 : RNUM = 1 일 때 KEY1, 2 일 때 합계로 출력됨
SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END ) AS "KEY1" ,
       부장, 차장, 과장, 대리, 사원, 수습
FROM
( SELECT DEPT_CODE AS KEY1,
        ( CASE LEV WHEN '부장' THEN SALARY ELSE 0 END ) AS "부장",
        ( CASE LEV WHEN '차장' THEN SALARY ELSE 0 END ) AS "차장",
        ( CASE LEV WHEN '과장' THEN SALARY ELSE 0 END ) AS "과장",
        ( CASE LEV WHEN '대리' THEN SALARY ELSE 0 END ) AS "대리",
        ( CASE LEV WHEN '사원' THEN SALARY ELSE 0 END ) AS "사원",
        ( CASE LEV WHEN '수습' THEN SALARY ELSE 0 END ) AS "수습"
  FROM TEMP ), 
( SELECT ROWNUM AS RNUM FROM USER_TABLES WHERE ROWNUM < 3 );


--위의 결과를 KEY1 으로 그룹화하고 각각의 SUM 함수 추가
SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END ) AS "KEY1" ,
      SUM(부장) AS "부장" , SUM(차장) AS "차장" , SUM(과장) AS "과장" ,
      SUM(대리) AS "대리" , SUM(사원) AS "사원" , SUM(수습) AS "수습" ,
      SUM(부장+차장+과장+대리+사원+수습) AS "전체"
FROM
( SELECT DEPT_CODE AS KEY1,
        ( CASE LEV WHEN '부장' THEN SALARY ELSE 0 END ) AS "부장",
        ( CASE LEV WHEN '차장' THEN SALARY ELSE 0 END ) AS "차장",
        ( CASE LEV WHEN '과장' THEN SALARY ELSE 0 END ) AS "과장",
        ( CASE LEV WHEN '대리' THEN SALARY ELSE 0 END ) AS "대리",
        ( CASE LEV WHEN '사원' THEN SALARY ELSE 0 END ) AS "사원",
        ( CASE LEV WHEN '수습' THEN SALARY ELSE 0 END ) AS "수습"
  FROM TEMP ), 
( SELECT ROWNUM AS RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END )
ORDER BY KEY1;

--최종 : 위의 결과를 인라인뷰로 묶고 PER 컬럼 추가
SELECT KEY1, 부장, 차장, 과장, 대리, 사원, 수습,
       ROUND( 100 * 수습 / 전체 ) AS PER
FROM
( SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END ) AS "KEY1" ,
         SUM(부장) AS "부장" , SUM(차장) AS "차장" , SUM(과장) AS "과장" ,
         SUM(대리) AS "대리" , SUM(사원) AS "사원" , SUM(수습) AS "수습" ,
         SUM(부장+차장+과장+대리+사원+수습) AS "전체"
  FROM
  ( SELECT DEPT_CODE AS KEY1,
          ( CASE LEV WHEN '부장' THEN SALARY ELSE 0 END ) AS "부장",
          ( CASE LEV WHEN '차장' THEN SALARY ELSE 0 END ) AS "차장",
          ( CASE LEV WHEN '과장' THEN SALARY ELSE 0 END ) AS "과장",
          ( CASE LEV WHEN '대리' THEN SALARY ELSE 0 END ) AS "대리",
          ( CASE LEV WHEN '사원' THEN SALARY ELSE 0 END ) AS "사원",
          ( CASE LEV WHEN '수습' THEN SALARY ELSE 0 END ) AS "수습"
    FROM TEMP ), 
  ( SELECT ROWNUM AS RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
  GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '합계' END )
  ORDER BY KEY1 );