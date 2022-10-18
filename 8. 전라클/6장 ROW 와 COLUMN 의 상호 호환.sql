--p219 따라하기 : 문제 풀이
SELECT * FROM SAM_TAB02;

-- ROWNUM 추가 : 별칭 NO
SELECT ROWNUM AS NO, 
       GUBUN 
FROM SAM_TAB02;

--CEIL 함수 추가 => CEIL (n) : n 보다 크거나 같은 가장 큰 정수를 반환
--레코드를 4개씩 묶음 : 최종 결과의 몇 번째 행에 출력될지를 결정한다  
SELECT CEIL(ROWNUM/4) AS RNO, -- 1 이 4개, 2 가 4개, 3 이 4개 ... 순서로 같은 숫자가 4개씩 출력
       ROWNUM AS NO, 
       GUBUN 
FROM SAM_TAB02;

--MOD 함수 추가 => MOD (n1, n2) : n1 을 n2 로 나눈 나머지를 반환
/* 최종결과의 한 행 안에서 몇 번째 컬럼에 출력될지를 결정한다
   MOD(ROWNUM,4) 가 1 이면 첫번째 컬럼 , 2 이면 두번째 컬럼,
                             3이면 세번째 컬럼, 0이면 4번째 컬럼에 출력된다 */
SELECT CEIL(ROWNUM/4) AS RNO, 
       MOD(ROWNUM,4) AS CNO,  -- 0, 1, 2, 3, ... 이계속 반복되어 출력
       ROWNUM AS NO, 
       GUBUN 
FROM SAM_TAB02;

--ROWNUM 은 이제 필요없으므로 지움, GUBUN 은 CASE 함수에 의해 출력되므로 역시 지움
--이제 CASE 함수 추가
SELECT CEIL(ROWNUM/4) AS RNO, 
       MOD(ROWNUM,4) AS CNO,  -- 1, 2, 3, 0 ... 이 계속 반복되어 출력
       ( CASE MOD(ROWNUM,4)  WHEN 1 THEN GUBUN END ) AS C1,
       ( CASE MOD(ROWNUM,4)  WHEN 2 THEN GUBUN END ) AS C2,
       ( CASE MOD(ROWNUM,4)  WHEN 3 THEN GUBUN END ) AS C3,
       ( CASE MOD(ROWNUM,4)  WHEN 0 THEN GUBUN END ) AS C4
FROM SAM_TAB02;

--이제 CNO 컬럼도 필요없으므로 지움. 위의 결과를 CEIL(ROWNUM/4) 로 GROUP BY 하고 정렬한다
/* GROUP BY 시 ( 한개의 GUBUN 값 ) + ( 세 개의 NULL ) => ( 한개의 GUBUN 값 ) 으로 출력된다
   이 경우 NULL의 특성상 그룹함수는 MAX, MIN 모두 가능하다  <전라클 22장 참조>   */
SELECT CEIL(ROWNUM/4) AS RNO, 
       MIN( ( CASE MOD(ROWNUM,4)  WHEN 1 THEN GUBUN END ) ) AS C1,
       MIN( ( CASE MOD(ROWNUM,4)  WHEN 2 THEN GUBUN END ) ) AS C2,
       MIN( ( CASE MOD(ROWNUM,4)  WHEN 3 THEN GUBUN END ) ) AS C3,
       MIN( ( CASE MOD(ROWNUM,4)  WHEN 0 THEN GUBUN END ) ) AS C4
FROM SAM_TAB02
GROUP BY CEIL(ROWNUM/4)
ORDER BY RNO;

--전전 단계의 문장을 FROM 절의 인라인뷰로 하여 다음과 같이 해도 결과는 같다.
SELECT RNO, MAX(C1), MAX(C2), MAX(C3), MAX(C4)
FROM
( SELECT CEIL(ROWNUM/4) AS RNO, 
       ( CASE MOD(ROWNUM,4)  WHEN 1 THEN GUBUN END ) AS C1,
       ( CASE MOD(ROWNUM,4)  WHEN 2 THEN GUBUN END ) AS C2,
       ( CASE MOD(ROWNUM,4)  WHEN 3 THEN GUBUN END ) AS C3,
       ( CASE MOD(ROWNUM,4)  WHEN 0 THEN GUBUN END ) AS C4
  FROM SAM_TAB02 )
GROUP BY RNO
ORDER BY RNO;

/* 위의 결과는 SAM_TAB02 의 레코드가 얼마 되지 않으므로 
   처음에 데이터를 불러올 때 따로 정렬할 필요는 없었다. 
   그러나 데이터의 개수가 많다면 GUBUN 값이 정렬되지 않고 출력될 수 있다
   이런 경우 SAM_TAB02 도 인라인뷰로 쓸 필요가 생긴다 */
SELECT RNO, MAX(C1), MAX(C2), MAX(C3), MAX(C4)
FROM
( SELECT CEIL(ROWNUM/4) AS RNO, 
       ( CASE MOD(ROWNUM,4)  WHEN 1 THEN GUBUN END ) AS C1,
       ( CASE MOD(ROWNUM,4)  WHEN 2 THEN GUBUN END ) AS C2,
       ( CASE MOD(ROWNUM,4)  WHEN 3 THEN GUBUN END ) AS C3,
       ( CASE MOD(ROWNUM,4)  WHEN 0 THEN GUBUN END ) AS C4
  FROM ( SELECT ROWNUM, GUBUN
         FROM SAM_TAB02 
         ORDER BY GUBUN ) )  -- 처음 SAM_TAB02 을 불러올 때 GUBUN 값으로 정렬
GROUP BY RNO
ORDER BY RNO;

/* 위와 같이 인라인뷰를 여러 개 사용해야 할 수도 있다.
  코드는 길어지지만, 정렬을 직접 컨트롤할 수 있고
  무엇보다도 처음 테이블을 읽어올 때 자료의 범위를 제한할 수 있기 때문에
  데이터의 개수가 많다면 처리 속도의 향상을 기대할 수 있다.. 고 한다.  */
  
-------------------------------------------------------------------------
--p224 문제 06-1 : ROW 단위를 COLUMN 단위로
SELECT EMP_ID, EMP_NAME 
FROM TEMP;

--ROWNUM 추가 : 출력해보면 EMP_ID 가 정렬되어 있지 않다
SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
FROM TEMP;

--ORDER BY EMP_ID : EMP_ID 순으로 정렬되고 ROWNUM 도 순서대로 다시 매겨진다
SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
FROM TEMP
ORDER BY EMP_ID;

/* 우리가 원하는 방식으로 정렬되었음을 확인하였다
   위의 결과를 FROM 절의 인라인뷰로 하여 CEIL 함수, MOD 함수, 사원ID, 사원명 추가  */
--5명을 한 행에 출력 : CEIL(NO/5) , MOD(NO,5) 가 된다
SELECT CEIL(NO/5) AS RNO, 
       MOD(NO,5) AS CNO, 
       EMP_ID AS 사원ID, 
       EMP_NAME AS 사원명
FROM 
( SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
  FROM TEMP
  ORDER BY EMP_ID );

--책과 다르게 풀이 : 위의 결과를 인라인뷰로 묶은 후 RNO, CASE 함수 추가
--(중요!!) 인라인뷰를 썼을 경우, 바깥쪽 SELECT 문장에서 별칭에 주의!!
SELECT RNO, 
       ( CASE CNO WHEN 1 THEN 사원ID END ) AS ID1,
       ( CASE CNO WHEN 1 THEN 사원명 END ) AS NAME1,
       ( CASE CNO WHEN 2 THEN 사원ID END ) AS ID2,
       ( CASE CNO WHEN 2 THEN 사원명 END ) AS NAME2,
       ( CASE CNO WHEN 3 THEN 사원ID END ) AS ID3,
       ( CASE CNO WHEN 3 THEN 사원명 END ) AS NAME3,
       ( CASE CNO WHEN 4 THEN 사원ID END ) AS ID4,
       ( CASE CNO WHEN 4 THEN 사원명 END ) AS NAME4,
       ( CASE CNO WHEN 0 THEN 사원ID END ) AS ID5,
       ( CASE CNO WHEN 0 THEN 사원명 END ) AS NAME5 
FROM
( SELECT CEIL(NO/5) AS RNO, MOD(NO,5) AS CNO, 
         EMP_ID AS 사원ID, EMP_NAME AS 사원명
  FROM 
  ( SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
    FROM TEMP
    ORDER BY EMP_ID ) );
    
/* 위의 결과를 RNO 로 GROUP BY 하고 그룹함수를 추가하고 RNO 순으로 정렬한다
    ID1 , ID2 .. 도 순서대로 정렬이 이루어졌음을 알 수 있다  */
SELECT RNO, 
       MAX( ( CASE CNO WHEN 1 THEN 사원ID END ) ) AS ID1,
       MAX( ( CASE CNO WHEN 1 THEN 사원명 END ) ) AS NAME1,
       MAX( ( CASE CNO WHEN 2 THEN 사원ID END ) ) AS ID2,
       MAX( ( CASE CNO WHEN 2 THEN 사원명 END ) ) AS NAME2,
       MAX( ( CASE CNO WHEN 3 THEN 사원ID END ) ) AS ID3,
       MAX( ( CASE CNO WHEN 3 THEN 사원명 END ) ) AS NAME3,
       MAX( ( CASE CNO WHEN 4 THEN 사원ID END ) ) AS ID4,
       MAX( ( CASE CNO WHEN 4 THEN 사원명 END ) ) AS NAME4,
       MAX( ( CASE CNO WHEN 0 THEN 사원ID END ) ) AS ID5,
       MAX( ( CASE CNO WHEN 0 THEN 사원명 END ) ) AS NAME5 
FROM
( SELECT CEIL(NO/5) AS RNO, MOD(NO,5) AS CNO, EMP_ID AS 사원ID, EMP_NAME AS 사원명
  FROM 
  ( SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
    FROM TEMP
    ORDER BY EMP_ID ) )
GROUP BY RNO
ORDER BY RNO;

/* 아니면 GROUP BY 이전의 문장을 다시 인라인뷰로 묶은 후에 그룹화할 수도 있다 
   인라인뷰 안에서의 별칭과 바깥 SELECT 절의 별칭을 동일하게 하였다  
   그룹함수는 MIN, MAX 어느 것을 사용해도 결과는 같다  */
SELECT RNO, MIN(ID1) AS ID1, MIN(NAME1) AS NAME1, 
       MIN(ID2) AS ID2, MIN(NAME2) AS NAME2, 
       MIN(ID3) AS ID3, MIN(NAME3) AS NAME3, 
          MIN(ID4) AS ID4, MIN(NAME4) AS NAME4
FROM
( SELECT RNO, 
         ( CASE CNO WHEN 1 THEN 사원ID END ) AS ID1,
         ( CASE CNO WHEN 1 THEN 사원명 END ) AS NAME1,
         ( CASE CNO WHEN 2 THEN 사원ID END ) AS ID2,
         ( CASE CNO WHEN 2 THEN 사원명 END ) AS NAME2,
         ( CASE CNO WHEN 3 THEN 사원ID END ) AS ID3,
         ( CASE CNO WHEN 3 THEN 사원명 END ) AS NAME3,
         ( CASE CNO WHEN 4 THEN 사원ID END ) AS ID4,
         ( CASE CNO WHEN 4 THEN 사원명 END ) AS NAME4,
         ( CASE CNO WHEN 0 THEN 사원ID END ) AS ID5,
         ( CASE CNO WHEN 0 THEN 사원명 END ) AS NAME5 
FROM
( SELECT CEIL(NO/5) AS RNO, MOD(NO,5) AS CNO, 
         EMP_ID AS 사원ID, EMP_NAME AS 사원명
  FROM 
  ( SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
    FROM TEMP
    ORDER BY EMP_ID ) ) )  -- 인라인뷰 => SELECT ~ FROM ( GROUP BY 이전의 문장 ) ...
GROUP BY RNO
ORDER BY RNO;

----------------------------------------------------------------
--p228 따라하기 : 문제 풀이

--ROWNUM 인 CNT 컬럼에 1 ~ 4 출력하는 예제 : x4 복제에 사용
SELECT ROWNUM AS CNT 
FROM DUAL 
CONNECT BY LEVEL <= 4;   --DUAL 테이블 / 계층형 쿼리 이용

SELECT ROWNUM AS CNT 
FROM USER_TABLES 
WHERE ROWNUM <=4;  --USER_TABLES 테이블 사용

SELECT ROWNUM AS CNT 
FROM TEST01 
WHERE ROWNUM <=4;  --PR 스키마의 TEST01 사용 : 레코드 1000개

SELECT ROWNUM AS CNT 
FROM TEST11 
WHERE ROWNUM <=4;  --실습에 사용할 TEST11 테이블 자신을 사용


--Cartesian Product : TEST11 테이블의 모든 레코드를 x4 복제
SELECT * 
FROM TEST11, 
    ( SELECT ROWNUM AS CNT 
      FROM USER_TABLES 
      WHERE ROWNUM < 5);  --DEPT 로 정렬해 보면 x4 복제가 됨을 알 수 있다

/* CNT 1 : '1학년' , 1학년 학생수 (FRE) 를 출력
   CNT 2 : '2학년' , 2학년 학생수 (SUP)
   ... 이런 순서로 처리한다

   CASE 함수를 추가하여 각각의 레코드에서 학년과 학생수가 출력되도록 한다  
   마지막에 COLL (대학), DEPT (학과) KEY3 (학년) 순으로 정렬 추가*/

/* '학년' 컬럼을 KEY3 로 명명한 이유는, 
   기본적으로 테이블에서 각각의 레코드는 자기 자신을 의미하는 
   Unique 한 값, 즉 KEY 를 가져야 한다.

   원래의 테이블 TEST11 에서는 COLL 과 DEPT 로 구분하는 것이 가능했다
     ex) '공과대학' , '항공우주공학과' => 오직 1개의 레코드만 존재

   그러나 복제된 테이블에서는 동일한 COLL 과 DEPT 값이 4개 존재하게 된다

   하지만 COLL (KEY1), DEPT (KEY2) 에 학년 (KEY3) 을 추가하면 
   각각의 레코드가 확실히 구분된다.  */ 

SELECT COLL AS 대학, DEPT AS 학과,
       ( CASE CNT WHEN 1 THEN '1학년' 
                  WHEN 2 THEN '2학년'
                  WHEN 3 THEN '3학년'
                  WHEN 4 THEN '4학년' END ) AS KEY3,
       ( CASE CNT WHEN 1 THEN FRE 
                  WHEN 2 THEN SUP
                  WHEN 3 THEN JUN
                  WHEN 4 THEN SEN END ) AS 학생수          
FROM TEST11, 
    ( SELECT ROWNUM AS CNT 
      FROM USER_TABLES 
      WHERE ROWNUM < 5)
ORDER BY 대학, 학과, KEY3;

----------------------------------------------------------------
--p230 문제 06-2 : ROW 단위를 COLUMN 단위로

/* 각각의 레코드를 x2 복제 : CNT1 은 '1, 2학년' ,
                           CNT2 는 '3, 4학년' 출력에 사용된다 
   CNT1 => KEY3 는 '1, 2학년', 
           C1 은 1학년 학생수 (FRE)
           C2 는 2학년 학생수 (SUP)    
   CNT3 => KEY3 는 '3, 4학년', 
           C1 은 3학년 학생수 (JUN)
           C2 는 4학년 학생수 (SEN)    
결과적으로 C1 컬럼은 1 or 3학년 학생수를,
          C2 컬럼은 2 or 4학년 학생수를 출력하게 된다  */         

--전의 결과에서 x2 복제 / CASE 함수 수정
SELECT COLL AS 대학, DEPT AS 학과,
       ( CASE CNT WHEN 1 THEN '1, 2학년' 
                  WHEN 2 THEN '3, 4학년' END ) AS KEY3,
       ( CASE CNT WHEN 1 THEN FRE 
                  WHEN 2 THEN JUN END ) AS "C1 (1 or 3학년 학생수)",     
       ( CASE CNT WHEN 1 THEN SUP 
                  WHEN 2 THEN SEN END ) AS "C2 (2 or 4학년 학생수)"               
FROM TEST11, 
    ( SELECT ROWNUM AS CNT 
      FROM USER_TABLES 
      WHERE ROWNUM < 3 )
ORDER BY 대학, 학과, KEY3;
