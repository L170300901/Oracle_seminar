--p351 따라하기 : 같은 값 안보여주기
* 
SELECT * FROM TEST09;

SELECT ROWNUM AS CNT1, LINE, SPEC, ITEM, QTY FROM TEST09;
SELECT ROWNUM AS CNT2, LINE, SPEC, ITEM, QTY FROM TEST09;

/* 아래 구문에서 WHERE A.CNT1-1 = B.CNT2 (심플 조인) 을 하게 되면 
   인라인뷰 A의 첫번째 레코드는 출력되지 않는다.
   이유는 자신의 이전 레코드가 없기 때문 : 심플조인은 값이 일치하는 레코드만 출력한다
   인라인뷰 A의 첫번째 레코드도 출력되도록 ( OR 인라인뷰 A의 모든 레코드가 출력되도록 )
   하기 위해 아우터 조인을 건다.
   이 때 첫 번째 레코드의 이전 레코드는 없으므로 NULL 로 표시된다.  */
SELECT *
FROM 
( SELECT ROWNUM AS CNT1, LINE, SPEC, ITEM, QTY FROM TEST09 ) A,
( SELECT ROWNUM AS CNT2, LINE, SPEC, ITEM, QTY FROM TEST09 ) B
WHERE A.CNT1-1 = B.CNT2 (+)  -- 인라인뷰 A의 모든 레코드가 출력되도록 아우터조인
ORDER BY A.CNT1;



/* CASE 함수는 IF 문과 같은 역할을 한다. 조건에 따라 출력되는 결과가 달라진다.
   인라인뷰 A 의 LINE 값과 B 의 LINE 값이 같다는 것은 자신의 이전 레코드와 값이 같다는 것이다.
   즉, 값이 중복된다는 의미 : 이런 경우 LINE 필드의 값은 NULL 
   만일 같지 않다면 (ELSE) 원래 자신의 값 (A.LINE) 을 출력한다.
   SPEC 컬럼에서의 CASE 함수도 같은 의미이다.  */

-- CASE 함수 쓸 때 반드시 마지막에 ~ END 붙일 것!
SELECT ( CASE WHEN A.LINE = B.LINE THEN NULL 
              ELSE A.LINE END ) AS LINE,   --LINE 컬럼에서의 CASE 함수 : 
       ( CASE WHEN A.LINE || A.SPEC = B.LINE || B. SPEC THEN NULL 
              ELSE A.SPEC END ) AS SPEC,   --SPEC 컬럼에서의 CASE 함수
          A.ITEM, A.QTY
FROM 
( SELECT ROWNUM AS CNT1, LINE, SPEC, ITEM, QTY FROM TEST09 ) A,
( SELECT ROWNUM AS CNT2, LINE, SPEC, ITEM, QTY FROM TEST09 ) B
WHERE A.CNT1 - 1 = B.CNT2 (+)
ORDER BY A.CNT1;

/* 위의 CASE 문은 다양하게 쓰여질 수 있다. WHEN 의 위치에 주목할 것!
 (1) CASE A.LINE WHEN B.LINE THEN NULL 
                 ELSE A.LINE END
 (2) CASE WHEN A.LINE <> B.LINE THEN A.LINE 
          WHEN A.LINE = B.LINE THEN NULL END */

----------------------------------------------------------------------

--p355 문제 14-1 : 동일한 컬럼값 안보이게 하기  => 예제와 거의 동일한 문제
SELECT ROWNUM AS CNT1, PRESS, BOOK_TYPE, BOOK_NAME, PRICE FROM TEST12;
SELECT ROWNUM AS CNT2, PRESS, BOOK_TYPE, BOOK_NAME, PRICE FROM TEST12;

SELECT ( CASE WHEN A.PRESS = B.PRESS THEN NULL 
              ELSE A.PRESS END ) AS PRESS ,
       ( CASE WHEN A.PRESS || A.BOOK_TYPE = B.PRESS || B.BOOK_TYPE THEN NULL 
              ELSE A.BOOK_TYPE END ) AS BOOK_TYPE , 
        A.BOOK_NAME, A.PRICE
FROM 
( SELECT ROWNUM AS CNT1, PRESS, BOOK_TYPE, BOOK_NAME, PRICE 
  FROM TEST12 ) A ,
( SELECT ROWNUM AS CNT2, PRESS, BOOK_TYPE, BOOK_NAME, PRICE 
  FROM TEST12 ) B
WHERE A.CNT1 -1 = B.CNT2 (+)
ORDER BY A.CNT1;