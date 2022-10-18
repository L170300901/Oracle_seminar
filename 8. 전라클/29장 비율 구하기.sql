SELECT * FROM TEST100; 
SELECT * FROM T100; 
SELECT * FROM TEST101; 

--보정을 고려하지 않은 비율 구하기
SELECT T1.C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
FROM TEST100 T1 ,
    ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2;

/* 위의 결과를 x 2 복제 ,
   단 RCNT 가 2 일 경우 C1 은 NULL 로 출력되도록 한다
   RCNT 가 2인 경우는 다음 구문에서 전체 비율의 총합을 계산할 때 쓰인다  */ 
SELECT D2.RCNT, 
      ( CASE D2.RCNT WHEN 2 THEN NULL 
                     ELSE D1.C1 END ) C1, 
       D1.C2_RATIO
FROM
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2;

/* 위의 구문에서 D2.RCNT 는 뺀 다음
   ( CASE D2.RCNT WHEN 2 THEN NULL ELSE D1.C1 END ) 으로 GROUP BY   */
/* C1 이 NULL 일 때의 C2_RATIO 값이 전체 비율의 총합이다.
   여기서는 1.001 이 출력 : ROUND 함수에 의한 반올림으로 오차 0.001 이 생겼다. 
   오차 0.001 이 가장 큰 비율값에 더해지도록 출력하는 것이 목적이다   */
SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                      ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  --RCNT 1 인 경우는 그대로 출력    
FROM                                            --RCNT 2 는 모든 비율의 총합 출력
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END );

/*  위의 문장에 ORDER BY C2_RATIO 를 추가한다
    가장 아래에 전체 비율의 총합, 그 위에 전체 비율 중 최댓값이 온다  
    오라클 8i 이상 가능하다고 책에 나옴  */
SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                      ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  
FROM                                         
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END )
ORDER BY C2_RATIO;  -- 이 절이 추가됨

/* 전체 비율의 합 ( RNUM 4, C1 이 NULL 일 때 ) 과 
   전체 비율의 최댓값 ( RNUM 3 ) 이 
   같은 그룹이 되도록 CASE 함수를 추가한다.  */
/* CASE 함수를 다음과 같이 쓰면 안된다
      CASE C1 WHEN NULL THEN ~ 
   위의 구문은 C1 = NULL 의 의미 => 반드시 FALSE 반환, 
                                   RNUM 이 바뀌지 않는다  */
SELECT ( CASE WHEN C1 IS NULL THEN RNUM-1 
              ELSE RNUM END ) AS RNUM ,
          C1, C2_RATIO
FROM 
( SELECT ROWNUM AS RNUM, C1, C2_RATIO
FROM 
( SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  
FROM                                         
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END )
ORDER BY C2_RATIO ) ); --바로 위의 구문을 인라인뷰로 추가함


/* 위의 구문에 GROUP BY ( CASE WHEN C1 IS NULL THEN RNUM-1 
                              ELSE RNUM END )  를 추가한다
   이 때 ( 전체 비율의 합 ) + ( 전체 비율 중 최댓값 ), 즉 1.517 이 RNUM 3 에 출력된다         */
SELECT ( CASE WHEN C1 IS NULL THEN RNUM-1 
              ELSE RNUM END ) AS RNUM ,
          MAX(C1), -- RNUM 3 일 때 C1 은 A 와 NULL , 이 중 A 가 출력된다
          SUM(C2_RATIO)
FROM 
( SELECT ROWNUM AS RNUM, C1, C2_RATIO
  FROM 
( SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  
  FROM                                         
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
  GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                          ELSE D1.C1 END )
  ORDER BY C2_RATIO ) ) 
GROUP BY ( CASE WHEN C1 IS NULL THEN RNUM-1 
                ELSE RNUM END ) ;

/* 최종 결과 : SUM(C2_RATIO) 에서 C1 이 NULL 일 때 C2_RATIO 값이 1 - C2_RATIO, 
   즉 - 0.001 이 되도록 한 후 전체 비율의 최댓값 0.516 과 더해지도록 수정한다   
   전체 비율의 합은 1이여야 하는데 그 초과/부족분만큼 
   전체 비율 중 최댓값에 반영되도록 하는 것이다. */ 

SELECT ( CASE WHEN C1 IS NULL THEN RNUM-1 
              ELSE RNUM END ) AS RNUM ,
       MAX(C1), 
       SUM( ( CASE WHEN C1 IS NULL THEN 1-C2_RATIO
                   ELSE C2_RATIO END ) ) AS RATIO     -- 이 부분이 위 구문과 다른 점이다.     
FROM 
( SELECT ROWNUM AS RNUM, C1, C2_RATIO
  FROM 
( SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  
  FROM                                         
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
  GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                          ELSE D1.C1 END )
  ORDER BY C2_RATIO ) ) 
GROUP BY ( CASE WHEN C1 IS NULL THEN RNUM-1 
                ELSE RNUM END ) ;

---------------------------------------------------------------------

--p555 따라하기 : 한번 읽은 테이블로 백분율 구하기

SELECT * FROM T100;

/* T100 테이블을 x2 복제   */
SELECT B.NO, A.C1, A.C2 
FROM T100 A, 
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B ;
/*  다음 단계에서 C1 컬럼을 NO = 1 일 때는 C1 자신의 값, 
    NO = 2 일 때는 NULL 로 출력되도록 CASE 함수를 쓴다.
    C1 컴럼의 출력값은 A , B , C , D , E , NULL
    이 중 C1 이 NULL 일 때 T100 테이블의 전체 레코드가 하나로 묶여진다는 것이다 

    그리고 ( CASE WHEN B.NO =1 THEN A.C1 END ) 로 GROUP BY 한다
    1, 2, 3, 4, 5, NULL 총 6개의 그룹으로 묶여지고
    이 때 NULL 그룹에는  T100 테이블의 전체 레코드가 들어있다 */   
    
/* ( CASE WHEN B.NO =1 THEN A.C1 END ) 는 
   ( CASE WHEN B.NO =1 THEN A.C1 ELSE NULL END ) 과 같은 의미이다
   NO 가 1이면 C1 값을, 아니면 NULL 을 출력한다.  */

/* 책에서는 ( CASE WHEN B.NO =1 THEN A.C1 END ) 을 DECODE 함수로 구현한 후 
   MIN 함수로 또 묶어버림 => 왜 그랬는지 이해가 안가요 ㅜㅜ 
   GROUP BY 로 중복된 자료가 모두 제거되었는데 그럴 필요가 있나? */

/* 책에서는 WHERE B.NO <=2 조건이 또 있다 => 이건 왜 있는걸까?  */    

SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, -- 6개 그룹 각각의 레코드 수
         SUM(C2) AS C2    -- 6개 그룹 각각의 C2의 합
FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ; --정렬을 위해 추가함



/* 위의 문장을 X 서브쿼리, 새로운 ROWNUM 테이블을 Y 서브쿼리로 두고
  각각의 레코드가 CNT 의 개수만큼 복제되도록 WHERE 조건을 추가한다 */
SELECT *
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO;

/* 위의 문장의 SELECT 절에 ROWNUM 을 추가, 그 외 필요한 컬럼을 넣고
   ROWNUM 으로 정렬한다.

  사소한 문제 하나 : ROWNUM 이 매겨지는 순서와 정렬된 결과가 책과 다르게 나온다  */
SELECT Y.NO, ROWNUM, X.CNT, X.C1, X.C2
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY ROWNUM;

--p557의 구문을 똑같이 실행 : 그래도 ROWNUM 이 매겨지는 순서와 정렬된 결과는 책과 다르게 나온다
SELECT NO, ROWNUM, CNT, C1, C2
FROM ( SELECT COUNT(B.NO) CNT ,
              MIN(DECODE(B.NO, 1, A.C1 ) ) C1,
              SUM(A.C2) C2
       FROM T100 A, 
            ( SELECT ROWNUM NO
              FROM USER_TABLES WHERE ROWNUM < 3 ) B
       WHERE B.NO <= 2
       GROUP BY DECODE(B.NO, 1, A.C1 ) ) X ,
       ( SELECT ROWNUM NO FROM USER_TABLES ) Y
WHERE Y.NO <= X.CNT;

/* ROWNUM 이 매겨지는 순서가 다르기 때문에 이후 과정을 책처럼 진행할 수 없다 ㅜㅜ 
  책에서 ROWNUM 컬럼을 제외한 결과만 강제로 정렬한 후 출력 , 
  그 결과를 인라인뷰로 하여 다시 ROWNUM 을 매긴다  */

--p557에서 ROWNUM 을 제외하고 나머지 결과만 출력되도록 강제 정렬
SELECT Y.NO, X.CNT, X.C1, X.C2
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY C1, NO;   -- ROWNUM 만 빼고 나머지는 책과 똑같이 출력됨


--위의 결과를 FROM 절의 인라인뷰로 하여 이제 ROWNUM 추가
SELECT NO, ROWNUM, CNT, C1, C2
FROM
( SELECT Y.NO, X.CNT, X.C1, X.C2
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY C1, NO )   -- 드디어 책과 똑같이 출력됨!! ㅜㅜ
 
/* 마지막 전 단계 : 원래 T100 테이블의 레코드가 상위 5개, 
                   합계값을 가진 레코드가 하위 5개 있다
  상위의 1개 레코드당 합계값을 가진 하위 레코드 1개가 그룹으로 묶여지도록 
  위 구문의 SELECT 절을 수정한다   */
/* ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) 
   CNT 가 1 일 때 ( T100 테이블의 자료 ) 는 ROWNUM 을 출력 ( 1, 2, 3, 4, 5 )
   아니면 NO ( 역시 1, 2, 3, 4, 5 ) 을 출력한다 */

SELECT ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) AS GRP_UNIT, 
       C1, C2
FROM
( SELECT Y.NO, X.CNT, X.C1, X.C2
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY C1, NO );

/* 최종 단계 : 위 구문을 ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) 로 
   그룹화하고 MIN, MAX 함수를 쓴다  */
/* MIN(C1) AS C1 의 경우 
  => 1로 그룹화 : A, null 중 A 출력 ,   
     2로 그룹화 : B, null 중 B 출력 , ....   */
/* MIN(C2) AS C2 의 경우
  => 1로 그룹화 : 10, 150 중 10 출력,   
     2로 그룹화 : 20, 150 중 20 출력 , ....  */
--MAX(C2) : 전체 총합 150 의미
SELECT MIN(C1) AS C1 , 
       MIN(C2) AS C2 ,  
       ROUND( MIN(C2) / MAX(C2) * 100, 2) AS C2_RT  --비율 계산
FROM
( SELECT Y.NO, X.CNT, X.C1, X.C2
  FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY C1, NO )
GROUP BY ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END );

----------------------------------------------------------------
--p555 따라하기 : 한번 읽은 테이블로 백분율 구하기

SELECT * FROM TEST100;

--T100 테이블을 x2 복제
SELECT B.NO, A.C1, A.C2 
FROM TEST100 A, 
     ( SELECT ROWNUM AS NO 
       FROM USER_TABLES 
       WHERE ROWNUM < 3 ) B ;

-- C1 컬럼에 CASE 함수 적용 : C1 은 A, B, C, null 출력
SELECT B.NO, ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , C2
FROM TEST100 A, 
     ( SELECT ROWNUM AS NO 
       FROM USER_TABLES 
       WHERE ROWNUM < 3 ) B;      

--GROUP BY 적용
SELECT COUNT(*) AS CNT, 
       ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
       SUM(C2) AS C2
FROM TEST100 A, 
     ( SELECT ROWNUM AS NO 
       FROM USER_TABLES 
       WHERE ROWNUM < 3 ) B
GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END );

/* 위의 결과를 인라인뷰로 하고 새로운 ROWNUM 테이블과 조인시켜서
   각각의 레코드를 CNT 값만큼 복제한다.     */
SELECT *
FROM
( SELECT COUNT(*) AS CNT, 
         ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
         SUM(C2) AS C2
  FROM TEST100 A, 
       ( SELECT ROWNUM AS NO 
         FROM USER_TABLES 
         WHERE ROWNUM < 3 ) B
  GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
( SELECT ROWNUM AS NO FROM USER_TABLES ) B
WHERE A.CNT >= B.NO;

/* 위의 결과를 인라인뷰로 하여 바로 ROWNUM 을 붙이면
   우리가 원하는 방향과 달라질 수 있다  
   그러므로 먼저 위의 결과를 강제 정렬 => ORDER BY CNT1, C1 추가  */
SELECT *
FROM
( SELECT COUNT(*) AS CNT, 
        ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
        SUM(C2) AS C2
  FROM TEST100 A, 
     ( SELECT ROWNUM AS NO 
       FROM USER_TABLES 
       WHERE ROWNUM < 3 ) B
       GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
( SELECT ROWNUM AS NO FROM USER_TABLES ) B
WHERE A.CNT >= B.NO
ORDER BY CNT, C1;   

/* 위의 결과를 다시 FROM 절의 인라인뷰로 하여 ROWNUM 추가  */
SELECT ROWNUM, CNT, C1, C2, NO
FROM
( SELECT *
  FROM
  ( SELECT COUNT(*) AS CNT, 
           ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
           SUM(C2) AS C2
    FROM TEST100 A, 
         ( SELECT ROWNUM AS NO 
           FROM USER_TABLES 
           WHERE ROWNUM < 3 ) B
    GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
  ( SELECT ROWNUM AS NO FROM USER_TABLES ) B
  WHERE A.CNT >= B.NO
  ORDER BY CNT, C1 );

/* 마지막 전단계 :상위 3개의 1개 레코드당 합계값을 가진 하위 레코드 1개가 
   그룹으로 묶여지도록 위 구문의 SELECT 절을 수정한다   */
/* ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) 
   CNT 가 1 일 때 ( TEST100 테이블의 자료 ) 는 ROWNUM 을 출력 ( 1, 2, 3 )
   아니면 NO ( 역시 1, 2, 3 ) 을 출력한다 */
SELECT ( CASE WHEN CNT = 1 THEN ROWNUM ELSE NO END ) GRP_UNIT, 
       C1, C2
FROM
( SELECT *
  FROM
  ( SELECT COUNT(*) AS CNT, 
          ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
          SUM(C2) AS C2
    FROM TEST100 A, 
         ( SELECT ROWNUM AS NO 
           FROM USER_TABLES 
           WHERE ROWNUM < 3 ) B
    GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
  ( SELECT ROWNUM AS NO FROM USER_TABLES ) B
  WHERE A.CNT >= B.NO
  ORDER BY CNT, C1 );

/* 최종 단계 : 위 구문을 ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) 로 
   그룹화하고 MIN, MAX 함수를 쓴다  */
/* MIN(C1) AS C1 의 경우 
  => 1로 그룹화 : A, null 중 A 출력 ,   
     2로 그룹화 : B, null 중 B 출력 ,
     3으로 그룹화 : C, null 중 C 출력   */
/* MIN(C2) AS C2 의 경우
  => 1로 그룹화 : 33, 64 중 33 출력,   
     2로 그룹화 : 20, 64 중 20 출력,
     3으로 그룹화 : 11, 64 중 11 출력   */
--MAX(C2) : 전체 총합 64 의미

SELECT MIN(C1) AS C1 ,
       MIN(C2) AS C2 ,
       ROUND( MIN(C2) / MAX(C2) * 100, 2) AS C2_RT  -- 백분율 출력
FROM
( SELECT *
  FROM
  ( SELECT COUNT(*) AS CNT, 
           ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
           SUM(C2) AS C2
    FROM TEST100 A, 
         ( SELECT ROWNUM AS NO 
           FROM USER_TABLES 
           WHERE ROWNUM < 3 ) B
    GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
  ( SELECT ROWNUM AS NO FROM USER_TABLES ) B
  WHERE A.CNT >= B.NO
  ORDER BY CNT, C1 )
GROUP BY  ( CASE WHEN CNT = 1 THEN ROWNUM ELSE NO END );
