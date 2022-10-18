-- p238~p249 (2) IN-LINE VIEW 이용 => 패스함

---------------------------------------------------------------

--p235 따라하기 : 부등호 조인 이용

SELECT * FROM TEST01;  -- A 컬럼 : 00001 ~ 01000, B컬럼 : 1 ~ 1000 

/* TEST01 셀프 조인 후 WHERE 조건 추가 
  => T2 에서 T1 의 B 값보다 작거나 같은 값만 출력 
  
   즉, T1.B 가 1  :  T2.B 는 1 만   
                 2  :  1, 2   
                 3  :  1, 2, 3
                 4  :  1, 2, 3, 4  
                 ... 이런 순서로 출력된다.
                 
   결과 확인을 위해 T1.A 로 정렬하였다         */

SELECT *
FROM TEST01 T1 , TEST01 T2
WHERE T1.B >= T2.B  
ORDER BY T1.A;


/* 위의 결과를 T1.A, T1.B 로 GROUP BY / SUM(T2.B) 추가한다 */
SELECT T1.A, T1.B, SUM(T2.B) AS 누계
FROM TEST01 T1 , TEST01 T2
WHERE T1.B >= T2.B
GROUP BY T1.A, T1.B
ORDER BY T1.A;

/* 이 방법은 계산할 레코드의 수가 증가할수록 처리 시간이 급격하게 증가한다
   아래 문장은 1부터 10000 까지 누계를 구한다. 오래 걸림   */
SELECT T1.A, T1.B, SUM(T2.B) AS 누계
FROM ( SELECT LPAD(ROWNUM,6,'0') A, ROWNUM B 
       FROM DUAL 
       CONNECT BY LEVEL <=10000 ) T1 , 
     ( SELECT LPAD(ROWNUM,6,'0') A, ROWNUM B 
       FROM DUAL 
       CONNECT BY LEVEL <=10000 ) T2
WHERE T1.B >= T2.B
GROUP BY T1.A, T1.B
ORDER BY T1.A;


-------------------------------------------------------------

--p251 따라하기 : 문제 풀이

SELECT  * FROM A_TB;


SELECT  * FROM A_TB;

/* '200101' ~ '200112' 12개의 값 중 하나를 매개변수로 입력받으면 
    2001년의 1월부터 입력받은 달까지의 누적값을 계산하는 것이 목적이다
    편의상 매개변수 대신 '200112' 로 대신한다.
    '200101' 을 매개변수로 바꾸면 원하는 방식대로 실행됨 */

/* V_MON 의 마지막 값은 매개변수로 입력받는 값과 일치한다.
   나중에 V_MON 으로 그룹화하여 A_OUT 의 누적 총합을 계산한다   */
    
 /* SUBSTR(Char, Position, Length) : Char 문자열의 Position 위치로부터 
                                     Length 개의 문자를 떼어내어 반환

    LPAD(expr1, n, [expr2]) : expr1 을 n 자리만큼 늘려서 왼쪽에 expr2 를 붙여 반환 
                              expr2 가 없을 경우 공백문자를 붙임           */   
                              
SELECT SUBSTR('200112',1,4) ||  -- '200112' 의 1번째 자리부터 4글자, 즉 '2001' 를 읽어낸다
       LPAD(ROWNUM,2,'0')  -- ROWNUM 을 2자리로 만들 것, 빈 자리는 '0'으로 채운다
       AS V_MON            
FROM A_TB
WHERE ROWNUM < 
      TO_NUMBER(SUBSTR('200112',5,2)) + 1;  -- '200112' 의 5번째 자리부터 2글자, 
                                            -- 즉 12 를 읽어낸 후
                                            -- 숫자로 변환하고 1을 더한다.

/* 위의 문장에서 매개변수의 값이 현재일자보다 클 경우, 
   출력되는 결과가 없도록 WHERE 조건을 수정한다. ( => WHERE ROWNUM < 0 )  
   아래 문장이 인라인뷰 A가 된다    */
--LEAST 함수 : 인자로 받는 값들 중 최솟값을 반환
SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON  --V_MON : ROWNUM 에서 추출
FROM A_TB
WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  -- 매개변수와 현재일자 중 텍스트 순으로
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1  -- 먼저 등장하는 값을 반환
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END );


/* 매개변수로 입력받는 값의 연도를 읽어낸 후, 
   해당연도의 최초 월 즉, 1월부터 12월까지를 
   A_TB 테이블에서 읽어오는 문장 : 인라인뷰 B가 된다  */
SELECT * 
FROM A_TB
WHERE A_MON > SUBSTR('200112',1,4)   -- 텍스트 순서대로 정렬했을 때 '2001' 다음으로 오는 값부터
  AND A_MON <= SUBSTR('200112',1,4) || '12';  --해당연도의 12월까지 포함한 결과를 출력    

/* 인라인뷰 A, B 를 Cartesian Product 한다 */
SELECT *
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B


--여기서 누적 총합을 계산하는 방법이 2가지로 갈림


--방법 1 (정석) : Cartesian Product 후 부등호 조인 이용 

/* 위의 문장에 1월부터 매개변수의 해당 월까지 나오는 V_MON 이 
   A_TB 테이블의 A_MON 보다 크거나 같도록 WHERE 조건을 추가한다 */

SELECT *
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B
WHERE A.V_MON >= B.A_MON;


/* (방법1) 최종 : 위 문장을 A.V_MON 으로 그룹화하고 정렬 &
                  A.V_MON 과 SUM(B.A_OUT) 을 추가한다  */
SELECT A.V_MON AS 월, SUM(B.A_OUT) AS 실적
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B
WHERE A.V_MON >= B.A_MON
GROUP BY A.V_MON
ORDER BY 월;



/* 방법 2 : A_TB 테이블의 A_MON 이 V_MON 보다 작거나 같은 경우만 A_OUT 이 출력도록 
           CASE 함수를 추가한다.  */
/* LEAST 함수를 사용하여 CASE 함수를
  ( CASE LEAST( A.V_MON, B.A_MON ) WHEN B.A_MON THEN A_OUT END )  으로 
  할 수도 있다    */

SELECT A.V_MON , 
       B.A_MON ,  -- 결과 확인 후 B.A_MON 은 지울 것
       ( CASE WHEN B.A_MON <= A.V_MON THEN A_OUT END) AS A_OUT
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B
ORDER BY A.V_MON, B.A_MON;     -- 결과 확인을 위해 정렬 추가


/* (방법2) 최종 : 위 문장을 A.V_MON 으로 그룹화하고 정렬 & 
                 SUM ( CASE 함수 ) 형식으로 그룹 함수를 추가한다  */
SELECT A.V_MON AS 월,
       SUM ( ( CASE WHEN B.A_MON <= A.V_MON THEN A_OUT END) ) AS 실적
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B
GROUP BY A.V_MON
ORDER BY 월;



/* 이제 '200112' 를 매개변수 :mon 으로 바꾼 후 실행해보자 */
--방법 1
SELECT A.V_MON AS 월, SUM(B.A_OUT) AS 실적
FROM                                              
( SELECT SUBSTR(:MON,1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( :MON , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN :MON THEN TO_NUMBER(SUBSTR(:MON,5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR(:MON,1,4)   
  AND A_MON <= SUBSTR(:MON,1,4) || '12' ) B
WHERE A.V_MON >= B.A_MON
GROUP BY A.V_MON
ORDER BY 월;


--방법 2
SELECT A.V_MON AS 월,
       SUM ( ( CASE WHEN B.A_MON <= A.V_MON THEN A_OUT END) ) AS 실적
FROM                                              
( SELECT SUBSTR(:MON,1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( :MON , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN :MON THEN TO_NUMBER(SUBSTR(:MON,5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR(:MON,1,4)   
  AND A_MON <= SUBSTR(:MON,1,4) || '12' ) B
GROUP BY A.V_MON
ORDER BY 월;


---------------------------------------------------------------------------------

--p255 문제 07-1 : 누계 구하기

SELECT T1.A , T1.B, SUM(T2.B)
FROM TEST01 T1 , TEST01 T2
WHERE T1.B >= T2.B AND T1.B BETWEEN 901 AND 1000
GROUP BY T1.A , T1.B
ORDER BY T1.A , T1.B;
