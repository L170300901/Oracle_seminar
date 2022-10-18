--p523 따라하기 : 비어있는 값 찾기

SELECT * FROM TEST;

SELECT A, MIN(B) AS MIN, MAX(B) AS MAX
FROM TEST
GROUP BY A;  
/* TEST 테이블에서 일자 A 별로 그룹화하여 각각의 최소/최대 B값을 구한다
   위 문장이 아래의 T1 서브쿼리 (인라인 뷰) 가 된다
   위 문장을 1, 2, 3, ... 연속적인 ROWNUM 이 있는 테이블과 조인하고
   ROWNUM >= ( 최솟값 MIN ), ROWNUM <= ( 최댓값 MAX ) 조건을 준다   */
  

SELECT *    -- 일단 모두 출력하고 원리 이해되면 T1.A, T2.R_CNT AS B 만 출력하도록 바꾸기
FROM
( SELECT A,  MIN(B) AS MIN, MAX(B) AS MAX
  FROM TEST
  GROUP BY A ) T1 ,
( SELECT ROWNUM as R_CNT 
  FROM TEST01    -- 충분히 많은 레코드가 있는 테이블 : TEST01 에는 1000개
  WHERE ROWNUM <= 
        ( SELECT MAX(B) FROM TEST ) ) T2   -- TEST 의 모든 B 중 최댓값보다 작은 ROWNUM 만 읽어오기
WHERE T1.MIN <=T2.R_CNT AND T1.MAX >=T2.R_CNT ;  
/* 19981113 은 최솟값 1 ~ 최댓값 11 까지, 
   19981114 은 최솟값 1 ~ 최댓값 8 까지 빠진 부분이 없는 결과 출력하는 코드 */
 

--책대로 풀이 : (위의 빠진 부분 없는 쿼리) MINUS ( TEST ) => 빠진 부분
SELECT T1.A, T2.B
FROM
( SELECT A,  MIN(B) AS MIN, MAX(B) AS MAX
  FROM TEST
  GROUP BY A ) T1 ,
( SELECT ROWNUM as R_CNT 
  FROM TEST01    -- 충분히 많은 레코드가 있는 테이블 : TEST01 에는 1000개
  WHERE ROWNUM <= 
        ( SELECT MAX(B) FROM TEST ) ) T2   -- TEST 의 모든 B 중 최댓값보다 작은 ROWNUM 만 읽어오기
WHERE T1.MIN <=T2.R_CNT AND T1.MAX >=T2.R_CNT
MINUS
SELECT A, B FROM TEST;



--다른 풀이 : 아우터 조인 이용
/* TEST 테이블을 T3, 위의 빠진 부분 없는 쿼리를 서브쿼리 T4 로 두고 조인시킨다
  빠진 자료가 없는 쪽이 T4 : T4 의 모든 행이 출력되도록 아우터 조인시킨다 */

SELECT *   -- 일단은 모두 출력 : 빠진 부분만 남길려면 어떤 필드 / 어떤 조건이 필요할까?
FROM TEST T3,
( SELECT T1.A, T2.R_CNT
  FROM
  ( SELECT A,  MIN(B) AS MIN, MAX(B) AS MAX
    FROM TEST
    GROUP BY A ) T1 ,
  ( SELECT ROWNUM as R_CNT 
    FROM TEST01    -- 충분히 많은 레코드가 있는 테이블 : TEST01 에는 1000개
    WHERE ROWNUM <= 
            ( SELECT MAX(B) FROM TEST ) ) T2   -- TEST 의 모든 B 중 최댓값보다 작은 ROWNUM 만 읽어오기
    WHERE T1.MIN <=T2.R_CNT AND T1.MAX >=T2.R_CNT ) T4
WHERE  T3.A (+) = T4.A AND T3.B (+) = T4.R_CNT ;



-- 자체 풀이 최종 : 빠진 자료만 보여주기 위해 T3.A IS NULL 조건 추가
SELECT T4.A AS A, T4.R_CNT AS B
FROM TEST T3,
( SELECT T1.A, T2.R_CNT
  FROM
  ( SELECT A,  MIN(B) AS MIN, MAX(B) AS MAX
    FROM TEST
    GROUP BY A ) T1 ,
  ( SELECT ROWNUM as R_CNT 
    FROM TEST01    -- 충분히 많은 레코드가 있는 테이블 : TEST01 에는 1000개
    WHERE ROWNUM <= 
          ( SELECT MAX(B) FROM TEST ) ) T2   -- TEST 의 모든 B 중 최댓값보다 작은 ROWNUM 만 읽어오기
    WHERE T1.MIN <=T2.R_CNT AND T1.MAX >=T2.R_CNT ) T4
WHERE T3.A (+) = T4.A AND T3.B (+) = T4.R_CNT 
   AND T3.A IS NULL;

------------------------------------------------------------------------

--p527 따라하기 : 중간값 구하기

--(1) 자체 풀이 : MONTHS_BETWEEN 함수 사용 ( 뇌라클 p294 )

SELECT MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , TO_DATE('200106' , 'RRRRMM') ) 
FROM DUAL;   -- 10 출력 : 처음 달 ('200106') 이 포함되지 않았음, 우리가 원하는 값은 11

SELECT MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , 
                       ADD_MONTHS( TO_DATE('200106' , 'RRRRMM') ,-1 ) ) 
FROM DUAL;   -- 11 출력 : 처음 달 ('200106') 의 한 달 이전부터 Count


--TEST01 에서 필요한 개월수만큼 ROWNUM 출력
SELECT ROWNUM AS n
FROM TEST01
WHERE ROWNUM <= MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , 
                                ADD_MONTHS( TO_DATE('200106' , 'RRRRMM') ,-1 ) ) ;

/* 위의 문장에 TIT 컬럼 추가 : '200106' 를 날짜 변환한 후 ROWNUM-1 만큼 ADD_MONTHS 
   이 때 01/06/01 형식으로 출력 : 출력되는 날짜의 형식은 컴에 따라 다를 수 있음 */                  
SELECT ROWNUM AS n, 
       ADD_MONTHS( TO_DATE('200106' , 'RRRRMM'), ROWNUM-1 ) AS TIT
FROM TEST01
WHERE ROWNUM <= MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , 
                                ADD_MONTHS( TO_DATE('200106' , 'RRRRMM') ,-1 ) ) ;

-- TO_CHAR ( 날짜 , 'RRRR.DD') 형식으로 날짜를 문자열로 변환 
SELECT ROWNUM AS n, 
       TO_CHAR( ADD_MONTHS( TO_DATE('200106' , 'RRRRMM'), ROWNUM-1 ) ,'RRRR.MM' )  AS TIT 
FROM TEST01
WHERE ROWNUM <= MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , 
                                ADD_MONTHS( TO_DATE('200106' , 'RRRRMM') ,-1 ) ) ;

---------------------------------------------------------------------------------

--p527 따라하기 : 중간값 구하기

--(2) 책의 풀이 : TEST01 테이블의 B 이용 (또는 ROWNUM 도 가능 )
SELECT B FROM TEST01;  -- 1, 2, 3 .. 이런 데이터가 필요하다 => 무려 1000개 출력됨


/* TIT 필드 추가 : '200106' 에 B-1 만큼 ADD_MONTHS 
   첫 번째 레코드에서 B 는 1 => '200106' 에 (1-1)달, 즉 0달 추가 => '01/06/01' 출력됨   
   이런 식으로 1000번 반복 => 마지막 1000번째 레코드는 '84/09/01' 출력됨     */
SELECT B, 
       ADD_MONTHS( TO_DATE('200106','RRRRMM'), B-1 ) AS TIT
FROM TEST01;


-- 출력 결과가  TO_DATE('200204','RRRRMM') 에서 끝나도록 WHERE 조건 추가
SELECT B, 
       ADD_MONTHS( TO_DATE('200106','RRRRMM'), B-1 )
FROM TEST01
WHERE ADD_MONTHS( TO_DATE('200106','RRRRMM'), B-1 ) <= TO_DATE('200204','RRRRMM');


--'2001.06' 형식으로 출력되도록 TO_CHAR 함수 추가
SELECT B, 
       TO_CHAR(ADD_MONTHS ( TO_DATE('200106','RRRRMM'), B-1),'RRRR.MM')
FROM TEST01
WHERE ADD_MONTHS ( TO_DATE('200106','RRRRMM'), B-1) <= TO_DATE('200204','RRRRMM');


---------------------------------------------------------------------------------

--p532 따라하기 : 빠진 이빨 구하기 II
--굳이 새로운 방법이 필요한 이유 : p531 ~ p532 설명 참조

SELECT * FROM TEST37;

--p532 (1) : 바로 이전 레코드 값과 연결하기
SELECT T1.DATA1 , T2.DATA2
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,  --DATA 값을 숫자로 치환
     ( SELECT ROWNUM as n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2
WHERE T1.n -1 = T2.n (+)  -- DATA1 의 이전 레코드 값이 DATA2 로 연결됨
ORDER BY T1.n;


--p532 (2) : 책에서처럼 인라인 뷰를 사용하지 않고 WHERE 조건 추가하여 해결하였다
/* 자신과 이전 레코드와의 값 차이가 1이라는 의미는  빠진 부분이 없다는 의미, 
   그런 DATA 는 여기서는 필요 없으므로 WHERE 조건을 추가하여 제외시켰다  */
SELECT T1.DATA1 , T2.DATA2
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,
     ( SELECT ROWNUM as n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2
WHERE T1.n -1 = T2.n (+) AND T1.DATA1 - nvl(T2.DATA2,0) > 1  --NULL 값을 0으로 치환해야 수식이 성립
ORDER BY T1.n;            



--p532 (3) : 연속된 ROWNUM 이 담긴 테이블을 FROM 절에 추가
/* 여기서는 SELECT ROWNUM AS n FROM USER_TABLES  => 1~61 까지의 ROWNUM 이 있는 테이블
   앞의 결과 4개 레코드 x 61 => 총 244 개의 레코드 출력된다 ( Cartesian Product )  */

SELECT T3.n, T1.DATA1 , T2.DATA2
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,
     ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2 ,
     ( SELECT ROWNUM AS n FROM USER_TABLES ) T3  -- 1~61 까지의 ROWNUM 이 있는 테이블
WHERE T1.n -1 = T2.n (+) AND T1.DATA1 - nvl(T2.DATA2,0) > 1  -- NULL 값을 0으로 치환해야 수식이 성립
ORDER BY T1.n;  


/*   DATA1   DATA2        빠진 숫자들 : rownum 인 n 중에서 선택되도록 하자!
       3       0      =>     1, 2          
       6       3      =>     4, 5              
      10       6      =>     7, 8, 9
      13      10      =>     11, 12
  where 조건에 ~ AND  T3.n < T1.DATA1 - T2.DATA2 를 추가한다.  */   

/* 연속한 두 Data 의 값 차이보다 크거나 같은 ROWNUM 이 필요하다는 것을
   쿼리 결과를 통해 확인할 수 있다       */
SELECT T3.n, T1.DATA1 , T2.DATA2
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,
     ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2 ,
     ( SELECT ROWNUM AS n FROM USER_TABLES ) T3  -- 1~61 까지의 ROWNUM 이 있는 테이블
WHERE T1.n -1 = T2.n (+) AND T1.DATA1 - nvl(T2.DATA2,0) > 1  -- NULL 값을 0으로 치환해야 수식이 성립
      AND  T3.n < T1.DATA1 - T2.DATA2
ORDER BY T1.n;  



/* 최종 : SELECT 절을 TO_CHAR( T3.N + T2.DATA2, '0000' ) 으로 수정한다.
   TO_CHAR 함수에 의해 결과가 4자리 문자열로 출력된다  
   정렬을 위해 ORDER BY 절도 바꿔준다          */

SELECT TO_CHAR( T3.N + T2.DATA2, '0000' ) 
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,
     ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2 ,
     ( SELECT ROWNUM AS n FROM USER_TABLES ) T3  -- 1~61 까지의 ROWNUM 이 있는 테이블
WHERE T1.n -1 = T2.n (+) AND T1.DATA1 - nvl(T2.DATA2,0) > 1  -- NULL 값을 0으로 치환해야 수식이 성립
      AND  T3.n < T1.DATA1 - T2.DATA2
ORDER BY TO_CHAR( T3.N + T2.DATA2, '0000' );  

/* <포인트> 이 방법이 통하기 위해서는, ROWNUM 이 있는 테이블의 ROWNUM 수가
   빠진 부분을 찾고자 하는 Data 중 연속한 두 값이 가지는 차이들의 
   최댓값보다 크거나 같아야 한다 */ 

------------------------------------------------------------------------------------

--p537 따라하기 : 빠진 이빨 구하기 III
SELECT * FROM TEST38;

--ASCII 함수와 CHR 함수
SELECT ASCII('A'), ASCII('B'), ASCII('C') FROM DUAL;
SELECT CHR(65), CHR(66),CHR(67) FROM DUAL;

--SUBSTR 함수를 이용하여 처음 영문자와 나머지 두자리 숫자 분리
SELECT SUBSTR(VAL1,1,1) || ' & ' || SUBSTR(VAL1,2,2) 
FROM TEST38;


/* ( 영문자의 아스키코드 값 - 65 ) * 100  =>  A 는 0, B 는 100, C 는 200 ... 으로 변환됨
   SUBSTR(VAL1,2) 은 VAL1 값의 두번째 자리부터 끝까지의 값을 반환한다
   우리가 찾는 숫자는 2자리이므로 SUBSTR(VAL1,2,2) 로 바꿔도 상관없다    */ 
SELECT ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 || ' & ' || SUBSTR(VAL1,2) 
FROM TEST38;

--위의 두 값을 더함 : A97 는 97 , B10 은 110 , B12 는 112 로 변환됨
SELECT ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) 
FROM TEST38;

------------------------------------------------------------------------------------

--1단계 끝, 2단계 : 사용할 ROWNUM 의 최대값을 구하는 2가지 방법

--(1) 위의 문장에 MAX 함수만 추가 : 최댓값 112 출력
SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
FROM TEST38;

--(2) 책의 풀이 : VAL1 을 모두 MAX(VAL1) 으로 바꾼다 : 최댓값 112 출력 
--책에서는 SUBSTR(MAX(VAL1),2) 에 다시 TO_NUMBER 함수 적용 : 안해도 값은 출력된다 
SELECT ( ASCII( SUBSTR(MAX(VAL1),1,1) ) -65 ) * 100 + SUBSTR(MAX(VAL1),2)
FROM TEST38;

/* 위의 2문장중 하나를 WHERE 조건에 넣고 TEST01 테이블의 B 컬럼으로 연속되는 숫자를 추출한다 
   단 출력되는 B 의 값을 1씩 빼준다. 그러면 0부터 112 까지 출력된다.
   빼주는 이유는 맨 처음 문자열 A00 이 0 에 대응하기 때문이다        */
SELECT B-1 NO 
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 );   

------------------------------------------------------------------------------------

--2단계 끝, 3단계 : 위의 구문에서 0 ~ 112 의 연속되는 숫자를 A00 ~ B12 로 다시 변환한다

-- 방법 (1) : B-1 값에 LPAD(), SUBSTR() 함수 사용
SELECT LPAD(B-1,3,'0')    -- 0 => '000', 12 => '012', 101 => '101' ..3자리 문자열로 바꿈
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 );  

-- SUBSTR() 함수로 ( 앞의 한자리 숫자 + 65 ) 한 값을 CHR 함수로 문자 변환 || 뒤의 2글자
SELECT CHR(SUBSTR(LPAD(B-1,3,'0'), 1,1) + 65 ) || SUBSTR( LPAD(B-1,3,'0'), 2) AS VAL
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 ); 


-- 방법 (2) : B-1 값에 FLOOR() 함수 사용하고
--        => B-1 을 100 으로 나는 값보다 작거나 같은 가장 큰 정수 반환
SELECT FLOOR((B-1)/100)     --  반드시 B-1 을 ( ) 처리, B-1/100 은 B 에 0.01 을 빼는 것   
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 );  

--위의 FLOOR((B-1)/100) 에 65 더하고 CHR() 함수로 문자 변환
--SUBSTR( LPAD(B-1,3,'0'), 2) : B-1 값을 총 3자리로 만든 후 뒤의 2글자 반환
SELECT CHR(FLOOR((B-1)/100)+65) || SUBSTR( LPAD(B-1,3,'0'), 2) AS VAL
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 );  

------------------------------------------------------------------------------------
--4단계 (최종) : 위의 완전한 Data 에서 TEST 를 빼면 (MINUS) 된다
SELECT CHR(FLOOR((B-1)/100)+65) || SUBSTR( LPAD(B-1,3,'0'), 2)
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 )
MINUS
SELECT VAL1 FROM TEST38;