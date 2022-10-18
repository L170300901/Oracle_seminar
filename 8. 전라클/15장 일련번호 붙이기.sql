--p364 따라하기 첫 번째 방법
SELECT * FROM TEST20;

-- Cartesian Product 후 자신보다 큰 포인트만 조인되도록 부등호 조인 추가
-- 56 point 가 1등 : 자신보다 큰 포인트가 없으면 NULL 로 출력되도록 Outer Join 추가
SELECT *
FROM TEST20 A, TEST20 B
WHERE A.POINT < B.POINT (+) ; 


--EMPID 와 POINT 로 Group By / 자신보다 큰 포인트의 개수를 세도록 Count 함수 추가
--(자신보다 큰 포인트의 개수) + 1 이 등수(Rank) 
--56 point 는 (0 + 1) 등 , 24 point 는 공동 10등, 그 다음 23 point 는 12등
SELECT A.EMPID, A.POINT, 
       COUNT(B.POINT) +1 AS RANK  
FROM TEST20 A, TEST20 B
WHERE A.POINT < B.POINT (+)
GROUP BY A.EMPID, A.POINT
ORDER BY RANK;

---------------------------------------------------------------
--p364 따라하기 두 번째 방법 (HARD함)
SELECT * FROM TEST20;

SELECT 1/POINT AS POINT_D
FROM TEST20
GROUP BY 1/POINT;
/* 좀 있다 조인할 A 서브쿼리
   POINT 가 커질수록 POINT_D 는 작아진다.
   POINT_D 0.04166.. ( POINT 24 ) 만 2개의 레코드가 있고 
   나머지는 모두 다른 값, 즉 한개씩 있다.

   SELECT DISTINCT 1/POINT AS POINT_D FROM TEST20; 으로
   바꿔도 상관없다 
*/


SELECT 1/POINT AS POINT_D, COUNT(*)-1 AS CNT
FROM TEST20
GROUP BY 1/POINT;
/* 좀 있다 조인할 B 서브쿼리 : A 서브쿼리에서 COUNT(*)-1 만 추가
   COUNT(*)-1 => ( 포인트별 개수 ) -1 => 즉, 자신 외에 추가로 존재하는 중복 포인트의 개수  */

--여기서는 POINT_D 0.04166.. ( POINT 24 ) 의 CNT 는 1, 나머지는 모두 0 출력

SELECT *
FROM 
 ( SELECT 1/POINT AS POINT_D
   FROM TEST20
   GROUP BY 1/POINT ) A ,
 ( SELECT 1/POINT AS POINT_D, COUNT(*)-1 AS CNT
   FROM TEST20
   GROUP BY 1/POINT ) B
WHERE A.POINT_D > B.POINT_D (+); -- 역수값 비교 : 실제 포인트는 A < B, 즉 자신의 점수보다 높은 것만 선택
/* 
  A 서브쿼리에서 POINT_D 가 0.1 ( POINT 는 10 ) 이면 
  B 서브쿼리에서 POINT_D 가 0.1 보다 작은 
  ( POINT 가 10 보다 큰 ) 값들만 조인된다
  그러나 POINT_D 가 역수이므로, 
  실제로는 A 의 POINT 10 보다 큰 값들이 연결된 것이다
  이 때 B 서브쿼리의 CNT 는 자신과 같은 다른 레코드의 수,
  즉 POINT_D 0.04166.. 의 CNT 가 1이라는 것은 
  전체 중에서 0.04166.. 값이 총 2개 있다 OR
  자신과 같은 값이 1개 더 있다는 의미

  자신보다 POINT 가 큰 (POINT_D 가 작은) 값이 
  B 서브쿼리에 없어도 출력되어야 하므로 아우터 조인을 했다 */

SELECT A.POINT_D, SUM(B.CNT) AS ADV
FROM 
 ( SELECT 1/POINT AS POINT_D
   FROM TEST20 
   GROUP BY 1/POINT ) A ,
 ( SELECT 1/POINT AS POINT_D, COUNT(*)-1 AS CNT
   FROM TEST20
   GROUP BY 1/POINT ) B
WHERE A.POINT_D > B.POINT_D (+)
GROUP BY A.POINT_D
ORDER BY A.POINT_D
/* 
  SUM(B.CNT) AS ADV : 자신보다 큰 값들 중 중복되는 값들의 개수

  POINT_D 0.017857.. ( POINT 56, 최댓값) 의 ADV 가 NULL 인 이유는
  자신보다 높은 값이 없으므로 B 서브쿼리에 대응하는 값 없음 / 
  그러나 아우터 조인이므로 A.POINT_D 의 모든 값이 출력되어야 함 / 
  => 바로 이런 경우 NULL 표시됨

  POINT_D 0.0434782.. ( POINT 23 ) 부터 ADV 가 1 출력되는 이유는
  자신의 POINT 보다 높은 범위에서 
  POINT_D 0.04166.. ( POINT 24 ) 가 2개 있기 때문..
  COUNT(*)-1 이므로 2 가 아니라 1이 출력된다.
  
  즉, 자신보다 높은 POINT 중 중복 순위가 1개 더 있으므로
  자신보다 많은 POINT 가 중복됨 없이 9개가 있다면 
  나는 10위가 아닌 11위가 된다는 것이다
  
  POINT_D 기준으로 그룹화를 시켰으므로 
  모든 POINT_D 는 중복됨 없이 출력된다.
  또한 정렬에 주의한다면 ROWNUM 도 작은 값부터 차례대로 
  1, 2, 3 .. 순서로 매겨질 것이다

  따라서 자신의 순위는 
  ROWNUM + ( 자신보다 큰 값들 중 중복되는 값들의 개수 , 즉 ADV )
  가 된다.
*/

/* POINT 가 아닌 1/POINT 로 실행해야 하는 이유 (또는 실행해야 편한 이유)
  ROWNUM 은 작은 값부터 순서대로 1, 2, 3 순서로 매겨지지만
  순위는 ( 큰 포인트 ) => ( 작은 포인트 ) 순서로 매겨진다.

  POINT 대신 1/POINT 를 쓰면 ROWNUM 이나 1/POINT 나
  똑같이 작은 값부터 매겨지게 되며 
  ROWNUM 에 (자신보다 큰 값 들 중 중복 순위의 개수) 만 더하면
  자신의 순위가 된다 
*/

SELECT POINT_D, ROWNUM AS GRAD, ADV
FROM
( SELECT A.POINT_D, SUM(B.CNT) AS ADV
  FROM
  ( SELECT 1/POINT AS POINT_D
    FROM TEST20
    GROUP BY 1/POINT ) A, 
  ( SELECT 1/POINT AS POINT_D, COUNT(*)-1 CNT
    FROM TEST20
    GROUP BY 1/POINT ) B
  WHERE A.POINT_D > B.POINT_D (+)  
  GROUP BY A.POINT_D
  ORDER BY A.POINT_D );
--이전의 문장에서 POINT_D, ROWNUM 인 GRAD, ADV 만 읽어온다
--위 문장을 원래 테이블인 TEST20 과 다시 조인한다.

SELECT A1.EMPID, 
    ( CASE WHEN GRAD+ADV IS NULL THEN 1 ELSE GRAD+ADV END ) AS 순위
FROM TEST20 A1 ,
  ( SELECT POINT_D, ROWNUM AS GRAD, ADV
    FROM
    ( SELECT A.POINT_D, SUM(B.CNT) AS ADV
      FROM
      ( SELECT 1/POINT AS POINT_D
        FROM TEST20
        GROUP BY 1/POINT ) A, 
      ( SELECT 1/POINT AS POINT_D, COUNT(*)-1 CNT
        FROM TEST20
        GROUP BY 1/POINT ) B
      WHERE A.POINT_D > B.POINT_D (+)  -- 역수값 비교 : 실제 포인트는 A < B, 즉 자신의 점수보다 높은 것만 선택
    GROUP BY A.POINT_D
    ORDER BY A.POINT_D ) ) B1 
WHERE 1/A1.POINT = B1.POINT_D -- A1.POINT = B1.POINT_D 가 아님
ORDER BY 순위;

/*  B1 서브쿼리에서 POINT_D 를 작은 값부터 정렬 
    => POINT 를 큰 값부터 정렬하는 것과 같은 의미이다

 자신의 순위는 ROWNUM 이었던 GRAD + 
 자신보다 큰 값 중 중복 순위의 개수 ADV 가 된다

 SELECT 절에서 
 ( ~ GRAD+ADV WHEN NULL ~ ) 하면  
 GRAD + ADV = NULL 과 같은 조건식이다
 그러나 NULL 을 가지고 사칙연산을 하면 TRUE/FALSE 가 아닌 NULL 반환,   
 이 경우에는 가장 큰 값의 경우 1 로 표시되어야 하나 
 실제로는 NULL 로 표시됨    */

--------------------------------------------------------------------
--만일 1/POINT 말고 POINT 로 푼다면 다음과 같이 풀면 된다
SELECT * FROM TEST20;

SELECT POINT 
FROM TEST20
GROUP BY POINT;  -- A 서브쿼리

SELECT POINT , COUNT(*)-1 
FROM TEST20
GROUP BY POINT;  --B 서브쿼리 : ( 포인트별 개수 ) -1 이 추가됨 
                 --          => 자신 외에 추가로 존재하는 중복 포인트의 개수

/*  A, B 서브쿼리를 조인 후 그룹화한다. 
    1/POINT 로 풀 때와 비교했을 때
    WHERE 조건의 부등호 방향이 바뀌고 내림차순 정렬이 추가된다 */  
-- SUM(B.CNT) AS ADV : 자신보다 큰 값들 중 중복되는 값들의 개수 

SELECT A.POINT, SUM(B.CNT) AS ADV   
FROM
( SELECT POINT 
  FROM TEST20
  GROUP BY POINT) A,
( SELECT POINT , COUNT(*)-1 AS CNT
  FROM TEST20 
  GROUP BY POINT ) B
WHERE A.POINT < B.POINT (+)  -- 책의 예제와 부등호의 순서가 반대임
GROUP BY A.POINT 
ORDER BY A.POINT DESC;  --반드시 내림차순 정렬을 해야 큰 포인트부터 ROWNUM 이 매겨진다

--ROWNUM 을 매기기 위해 위의 구문을 FROM 절의 인라인 뷰로 넣고 다시 SELECT 한다
SELECT ROWNUM AS GRAD, POINT, ADV  
FROM 
( SELECT A.POINT, SUM(B.CNT) AS ADV
  FROM
  ( SELECT POINT 
    FROM TEST20 
    GROUP BY POINT ) A,
  ( SELECT POINT , COUNT(*)-1 AS CNT
    FROM TEST20 
    GROUP BY POINT ) B
  WHERE A.POINT < B.POINT (+)  
  GROUP BY A.POINT 
  ORDER BY A.POINT DESC ); 

/* EMPID 를 출력하기 위해 위의 결과를 T1, TEST20 테이블을 T2 로 놓고 조인  */
SELECT *
FROM
( SELECT ROWNUM AS GRAD, POINT, ADV  
  FROM 
  ( SELECT A.POINT, SUM(B.CNT) AS ADV
    FROM
    ( SELECT POINT 
      FROM TEST20 
      GROUP BY POINT ) A,
    ( SELECT POINT , COUNT(*)-1 AS CNT
      FROM TEST20 
      GROUP BY POINT ) B
    WHERE A.POINT < B.POINT (+)  
    GROUP BY A.POINT 
    ORDER BY A.POINT DESC ) ) T1,
  TEST20 T2 
WHERE T1.POINT = T2.POINT;  -- 1/POINT 로 풀 때와 다른 점

/* 위의 결과에서 SELECT 절 수정 : 사원ID, 포인트, 순위  
   순위는 ( CASE WHEN ADV IS NULL THEN 1 ELSE GRAD+ADV END ) 로 처리한다  */
SELECT T2.EMPID, T2.POINT, 
       ( CASE WHEN ADV IS NULL THEN 1 ELSE GRAD+ADV END ) AS 순위
FROM
( SELECT ROWNUM AS GRAD, POINT, ADV  
  FROM 
  ( SELECT A.POINT, SUM(B.CNT) AS ADV
    FROM
    ( SELECT POINT 
      FROM TEST20 
      GROUP BY POINT ) A,
    ( SELECT POINT , COUNT(*)-1 AS CNT
      FROM TEST20 
      GROUP BY POINT ) B
    WHERE A.POINT < B.POINT (+)  
    GROUP BY A.POINT 
    ORDER BY A.POINT DESC ) ) T1,
  TEST20 T2 
WHERE T1.POINT = T2.POINT
ORDER BY 순위;

-------------------------------------------------------------------

--p370 문제 15-1 : 순위 구하기

SELECT * FROM TEMP;

SELECT 1/SALARY FROM TEMP GROUP BY 1/SALARY;

SELECT 1/SALARY, COUNT(*)-1 FROM TEMP GROUP BY 1/SALARY;

SELECT B.EMP_ID, B.SALARY, 
      ( CASE WHEN ADV IS NULL THEN 1 ELSE GRAD+ADV END ) AS 순위
FROM
( SELECT ROWNUM AS GRAD, SALARY_D, ADV
  FROM 
 ( SELECT A.SALARY_D, SUM(B.CNT) AS ADV
   FROM 
   ( SELECT 1/SALARY AS SALARY_D 
     FROM TEMP
     GROUP BY 1/SALARY) A ,
   ( SELECT 1/SALARY AS SALARY_D, COUNT(*)-1 AS CNT 
     FROM TEMP 
     GROUP BY 1/SALARY ) B
   WHERE A.SALARY_D > B.SALARY_D (+)
   GROUP BY A.SALARY_D
   ORDER BY A.SALARY_D ) ) A, TEMP B
WHERE 1/B.SALARY = A.SALARY_D
ORDER BY  순위;

-------------------------------------------------------------------
--p374 따라하기 : 그룹 단위별 순위 부여


--그냥 TEST12 가 아니라 정렬된 TEST12 를 사용한다. 이유는 마지막에 나온다
SELECT * FROM TEST12 ORDER BY PRESS, BOOK_TYPE;  

/* 위의 결과를 PRESS, BOOK_TYPE 으로 그룹화한다 
   각 그룹의 레코드 수가 CNT 가 된다.    
   여기서는 CNT 값이 (서울 출판사) 소설 4, 수필 4, 시 4, 
                    (한국출판) 교과서 7, 참고서 5 로 출력된다 */
SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
FROM ( SELECT * FROM TEST12 ORDER BY PRESS, BOOK_TYPE )
GROUP BY PRESS, BOOK_TYPE;  

/* 테이블 복제 1단계 : 위의 결과를  ROWNUM 만 있는 TEST12 테이블과 Cartesian Product */
SELECT * 
FROM
( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
  FROM ( SELECT * FROM TEST12 ORDER BY PRESS, BOOK_TYPE )
  GROUP BY PRESS, BOOK_TYPE ) A ,
( SELECT ROWNUM AS RCNT FROM TEST12 ) B;

/* 테이블 복제 2단계 : 우리가 원하는 것은 각각의 그룹의 CNT 수만큼 복제가 이루어지는 것
   위의 결과는 너무 많은 레코드가 출력된다. 
   필요한 결과로 좁히기 위해 WHERE 조건을 추가한다   */

/*  <중요!> 나중에 실제 Data 와 1:1 로 조인할 때 순서를 정확히 맞추기 위해서
            마지막에 ORDER BY PRESS, BOOK_TYPE, RCNT 를 추가한다      */
SELECT * 
FROM
( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
  FROM TEST12
  GROUP BY PRESS, BOOK_TYPE ) A ,
( SELECT ROWNUM AS RCNT FROM TEST12 ) B   --RCNT 가 그룹별 일련번호 역할을 한다
WHERE A.CNT >= B.RCNT  
ORDER BY PRESS, BOOK_TYPE, RCNT;


/* 위 구문을 FROM 절의 인라인뷰로 하여 
   ROWNUM 인 RNUM 과 그룹별 일련번호인 RCNT 만 추려낸다  
   RCNT 는 (서울 출판사) 소설 1~4, 수필 1~4, 시 1~4, 
           (한국출판) 교과서 1~7, 참고서 1~5 순으로 출력되어야 한다   */

SELECT ROWNUM AS RNUM, RCNT
FROM
( SELECT * 
  FROM
  ( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
    FROM TEST12
    GROUP BY PRESS, BOOK_TYPE ) A ,
  ( SELECT ROWNUM AS RCNT FROM TEST12 ) B
  WHERE A.CNT >= B.RCNT 
  ORDER BY PRESS, BOOK_TYPE, RCNT );



/* 위의 결과, 즉 그룹별 일련번호가 있는 쪽을 서브쿼리 T1, 
   실제 Data 가 있는 ( SELECT * FROM TEST12 ORDER BY PRESS, BOOK_TYPE ) 를 
   서브쿼리 T2 로 놓고 1:1 로 조인하여 합치면 끝.
   
   문제는 두 서브쿼리에서 조인시 사용할 Unique 한 값이 ROWNUM 인 RNUM 밖에 없다는 것.

   A, B 모두 순서를 정확히 정렬했다면 두 결과의 레코드 순서는 일치할 수 밖에 없다.
   정렬하지 않았다면 이상한 레코드에 일련번호가 매겨질 수 있다.   */

SELECT *
FROM
( SELECT ROWNUM AS RNUM, RCNT 
  FROM
  ( SELECT * 
    FROM
    ( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
      FROM TEST12
      GROUP BY PRESS, BOOK_TYPE ) A ,
    ( SELECT ROWNUM AS RCNT FROM TEST12 ) B
    WHERE A.CNT >= B.RCNT 
    ORDER BY PRESS, BOOK_TYPE, RCNT ) ) T1,  -- ROWNUM 과 일련번호 제공
( SELECT ROWNUM AS RNUM, PRESS, BOOK_TYPE, BOOK_NAME, PRICE 
  FROM TEST12 
  ORDER BY PRESS, BOOK_TYPE ) T2  -- ROWNUM 과 실제 Data 제공
WHERE T1.RNUM = T2.RNUM;

--최종 : 위의 SELECT 절에 출력될 컬럼만 지정해 주면 끝.
SELECT T1.RNUM AS 전체번호, T1.RCNT AS 일련번호, PRESS AS 출판사, BOOK_TYPE AS 종류,
          BOOK_NAME AS 책명, PRICE AS 가격 
FROM
( SELECT ROWNUM AS RNUM, RCNT 
FROM
( SELECT * 
  FROM
  ( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
    FROM TEST12
    GROUP BY PRESS, BOOK_TYPE ) A ,
  ( SELECT ROWNUM AS RCNT FROM TEST12 ) B
  WHERE A.CNT >= B.RCNT 
  ORDER BY PRESS, BOOK_TYPE, RCNT ) ) T1,
( SELECT ROWNUM AS RNUM, PRESS, BOOK_TYPE, BOOK_NAME, PRICE 
  FROM TEST12 
  ORDER BY PRESS, BOOK_TYPE ) T2
WHERE T1.RNUM = T2.RNUM;