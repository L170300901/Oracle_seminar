/* 문제 이해를 돕기 위해 WHERE 조건, ORDER 정렬을 추가하였다. 
   각각의 A.YMD 값에 조인되는 여러 B.YMD 중 최댓값, 
   여기서는 정렬되었을 때 출력되는 마지막 값의 일자에 해당하는 
   환율 (EXC_RATE) 이 필요하다.  */

SELECT * FROM TEST04 A, TEST05 B;

--문제 이해를 돕기 위한 문장
SELECT * FROM TEST04 A, TEST05 B
WHERE A.YMD > B.YMD  -- 문제 이해를 위해 WHERE 조건 추가
order by A.ymd, B.ymd;  --A.YMD 에 대해 정렬된 값 중 마지막 B.YMD, B.EXC_RATE 가 필요 



--(방법 1) p272 연관성 있는 서브쿼리 사용

/*  Cartesian Product 를 생성한다. 
   A.us_amount * B.exc_rate , 즉 총액도 출력한다  */
SELECT A.YMD AS 일자, A.us_amount AS 달러총액, 
       B.ymd AS 환율일자, B.exc_rate AS 환율, 
       A.us_amount * B.exc_rate AS 총액
FROM TEST04 A, TEST05 B   -- 일단 두 테이블을 Cartesian Product
order by A.ymd, B.ymd;    -- Data 확인을 위해 임시로 추가

/* 위 문장이 연관성 있는 서브쿼리의 바깥 쿼리 or 가장 기본이 되는 쿼리가 된다 
   
   위 문장에,
   WHERE B.YMD = ( SELECT MAX(C.YMD) 
                  FROM TEST05 C 
                  WHERE A.YMD > C.YMD )  만 추가하면 원하는 결과가 출력된다.
   
   A.YMD, 즉 일자를 서브쿼리 내에서 사용하기 위해 TEST05, 별칭 C 테이블을 
   새로운 원본으로 하는 연관성 있는 서브쿼리를 위와 같이 추가한다.

  실행되는 순서는 다음과 같다

  (1) SELECT ~~
      FROM TEST04 A, TEST05 B;  
      => 여기까지 Cartesian Product 생성, SELECT 절은 나중에 수행됨에 주의!
  
  (2) 처음 레코드의 A.YMD 값 '19980102'에 대해 연관성 있는 서브쿼리 실행
      즉, 서브쿼리 내에서 A.YMD 가 '19980102' 로 바뀐다 
      여기서는 MAX(C.YMD) 로 '19971231' 가 출력된다   */

      SELECT MAX(C.YMD) 
      FROM TEST05 C 
      WHERE '19980102' > C.YMD ;   --'19971231' 가 출력됨

/* (3) 다시 Cartesian Product 로 돌아가서 첫번째 행의 B.YMD 값이
       서브쿼리의 실행결과 '19971231' 와 같은지 검사한다.
       첫번째 행의 B.YMD 값은 '19961231' => 다르다
       => 이 행은 WHERE 조건을 만족하지 않으므로 출력되지 않는다.

   (4) 두 번째 레코드에 대해 위의 (1) ~ (3) 실행 => 
       서브쿼리의 실행 결과는 동일('19971231'), 
       두번째 행의 B.YMD 값은 '19970630' => 다르다 => 출력되지 않음

   (5) 세 번째 레코드도 똑같이 실행 => WHERE 조건 만족 => 출력

   (6) 네 번째 레코드도 똑같이 실행 => WHERE 조건 불만족 => 출력되지 않음

   ....  Cartesian Product 의 마지막 레코드까지 반복
        => 그리고 SELECT 절에 의해 출력될 필드 결정
        => 마지막으로 ORDEY BY 절이 있을 경우 정렬            */


-- B.YMD 나 C.YMD 나 전체 데이터는 동일하므로 '=', 동등 조인이 가능하다
SELECT A.YMD AS 일자, A.us_amount AS 달러총액, 
       B.ymd AS 환율일자, B.exc_rate AS 환율,
       A.us_amount * B.exc_rate AS 총액
FROM TEST04 A, TEST05 B
WHERE B.YMD = ( SELECT MAX(C.YMD) 
                FROM TEST05 C 
                WHERE A.YMD > C.YMD );   

-----------------------------------------------------------------------
--(추가 방법1) EXISTS 사용

/* 일단 Cartesian Product 를 생성한다 : 여기서는 모든 환율에 대한 총액이 출력된다
   이 문장이 바깥 쿼리 or 가장 기본이 되는 쿼리가 된다. */
SELECT A.YMD AS 일자, A.us_amount AS 달러총액, 
       B.ymd AS 환율일자, B.exc_rate AS 환율, 
       A.us_amount * B.exc_rate AS 총액
FROM TEST04 A, TEST05 B;

/* 위 문장에 WHERE EXISTS ~ 구문을 추가하는 것이 목적이다  
   만일 WHERE 구문을 그냥 평범하게 짠다면 다음과 같은 내용이 될 것이다

   WHERE A.YMD = ( ( 다른 서브쿼리의 ) 일자 )  
     AND B.YMD = ( 일자별 자신보다 이전 일자 중 최댓값 )  => 여기서 max() 함수가 필요!

   문제는 WHERE 절에 MAX() 함수를 바로 넣을 수는 없다는 것, 
   필요한 데이터, 즉 (일자) + (자신보다 이전 일자 중 최댓값) 이 있는 
   인라인뷰를 써야 한다  */

--일자별로 자신보다 이전 일자 중 최댓값, 즉 환율일자를 구한다 
SELECT C.YMD AS 일자, MAX(D.YMD) AS 환율일자
FROM TEST04 C, TEST05 D
WHERE C.YMD > D.YMD
GROUP BY C.YMD;


--(최종) 위의 문장이 WHERE EXISTS ~ 절의 인라인뷰의 인라인뷰(..) 가 된다
SELECT A.YMD AS 일자, A.us_amount AS 달러총액, 
       B.ymd AS 환율일자, B.exc_rate AS 환율, 
       A.us_amount * B.exc_rate AS 총액
FROM TEST04 A, TEST05 B
WHERE EXISTS ( SELECT NULL  -- 여기에 뭐라도 있어야 함!!
               FROM ( SELECT C.YMD AS 일자, MAX(D.YMD) AS 환율일자
                      FROM TEST04 C, TEST05 D
                      WHERE C.YMD > D.YMD
                      GROUP BY C.YMD; ) T1    
               WHERE A.YMD = T1.일자 AND B.YMD = T1.환율일자 );


/* 만일 EXISTS 안에서 인라인뷰를 사용하지 않았다면 다음과 같은 형태가 될 것이다.
   하지만 "그룹 함수는 허가되지 않습니다" 오류 : 실행되지 않는다  */
SELECT A.YMD AS 일자, A.us_amount AS 달러총액, 
       B.ymd AS 환율일자, B.exc_rate AS 환율, 
       A.us_amount * B.exc_rate AS 총액
FROM TEST04 A, TEST05 B
WHERE EXISTS ( SELECT C.YMD AS 일자, MAX(D.YMD) AS 환율일자
               FROM TEST04 C, TEST05 D
               WHERE C.YMD > D.YMD
                 AND A.YMD = C.YMD AND B.YMD = MAX(D.YMD)
               GROUP BY C.YMD  );  --이 열에서 "그룹 함수는 허가되지 않습니다" 오류

-----------------------------------------------------------------------

--(방법 2) p273 인라인 뷰 사용
SELECT * FROM TEST04;
SELECT * FROM TEST05;

/* A.YMD, 즉 일자보다 나중의 Data 는 필요없으므로 
   WHERE 조건으로 걸러주기 */
SELECT *
FROM TEST04 A, TEST05 B
WHERE A.YMD > B.YMD
order by A.YMD, B.YMD; -- 결과 확인 후 GROUP BY 하기 전에 지울 것


/* 위의 문장을 A.YMD, A.us_amount 로 그룹화하고 별칭을 추가한다
   각각의 그룹별 가장 늦은 환율일자가 MAX(B.YMD) 이 된다  */

SELECT A.YMD AS 일자, A.US_AMOUNT AS 달러총액, 
       MAX(B.YMD) AS 환율일자
FROM TEST04 A, TEST05 B
WHERE A.YMD > B.YMD
GROUP BY A.YMD, A.US_AMOUNT;


/* 위의 문장을 인라인뷰 T1, TEST05 테이블으로 T2 로 놓고 조인한다  
   T1 의 환율일자와 T2.YMD, 즉 일자가 같도록 WHERE 조건 추가   */
SELECT *
FROM ( SELECT A.YMD AS 일자, A.us_amount AS 달러총액, 
       MAX(B.YMD) AS 환율일자
       FROM TEST04 A, TEST05 B
       WHERE A.YMD > B.YMD
       GROUP BY A.YMD,  A.us_amount ) T1, 
       TEST05 T2
WHERE T1.환율일자 = t2.YMD;


/* SELECT 절 수정 : T1.달러총액 * t2.exc_rate 가 구하고자 하는 총액이 된다.
   결과 확인을 쉽게 하기 위해 ORDER BY 절도 추가한다   */

SELECT T1.일자, T1.달러총액, t2.ymd as 환율일자, t2.exc_rate AS 적용환율, 
       T1.달러총액 * t2.exc_rate AS 총액
FROM ( SELECT A.YMD AS 일자, A.us_amount AS 달러총액, 
       MAX(B.YMD) AS 환율일자
       FROM TEST04 A, TEST05 B
       WHERE A.YMD > B.YMD
       GROUP BY A.YMD,  A.us_amount ) T1, 
       TEST05 T2
WHERE T1.환율일자 = t2.YMD
ORDER BY T1.일자;

--------------------------------------------------------------------------

--(방법 3) HINTS 사용
SELECT A.YMD AS 일자, A.us_amount AS 달러총액, 
       B.ymd AS 환율일자, B.exc_rate AS 환율,
       A.us_amount * B.exc_rate AS 총액
FROM TEST04 A, TEST05 B
WHERE B.YMD = ( SELECT /*+ INDEX_DESC(TEST05 TEST05_PK) */ YMD 
                FROM TEST05    --별칭 쓰지 말 것!!
                WHERE A.YMD > YMD
                AND ROWNUM=1);   
                -- 내부 TEST05 테이블에 별칭 쓰지 말 것!

--P276 문제 09-1 : INDEX_DESC Hints 의 사용
SELECT INDEX_NAME
FROM USER_INDEXES
WHERE TABLE_NAME = 'TEMP';  --여기서는 SYS_C005752

SELECT * FROM TEMP;  
SELECT * FROM TEMP A, TEMP B;

SELECT A.EMP_ID, A.EMP_NAME, 
       B.EMP_ID AS "바로전 사원ID", B.EMP_NAME AS "바로 전 사원이름"
FROM TEMP A, TEMP B
WHERE B.EMP_ID = ( SELECT /*+ INDEX_DESC(TEMP SYS_C005752) */ EMP_ID 
                            FROM TEMP
                            WHERE A.EMP_ID > EMP_ID AND ROWNUM=1 )
ORDER BY A.EMP_ID; 

--바로 전전 사원 검색 : ROWNUM = 2 로 검색할 수 없으므로 
--ROWNUM 에 별칭을 준 다음 인라인뷰로 한번 더 가공
SELECT A.EMP_ID, A.EMP_NAME, 
       B.EMP_ID AS "바로전전 사원ID", B.EMP_NAME AS "바로전전 사원이름"
FROM TEMP A, TEMP B
WHERE B.EMP_ID = 
    ( SELECT EMP_ID 
    FROM ( SELECT /*+ INDEX_DESC(TEMP SYS_C005752) */ EMP_ID , 
                  ROWNUM AS NO
           FROM TEMP  WHERE A.EMP_ID > EMP_ID ) 
           WHERE NO = 2 )
ORDER BY A.EMP_ID;                         