--p284 따라하기 : 부등호 조인의 사용 => 패스..

--p286 문제 10-1 : 부등호 조인 => 패스..

----------------------------------------------------------------
--p289 따라하기 : 인라인뷰

SELECT * FROM COMCOSTTARGET;
SELECT * FROM COMCOSTTARGETB;

--p287~p293 : 2. 조인과 서브쿼리가 동일한 예 => 패스..


----------------------------------------------------------------
--p293  3. 선택적 조인
SELECT * FROM TEST34;

/* 일반적인 방법 : 단, TEST34 테이블을 2번 읽어야 한다는 단점이 있다 */
SELECT 'A' TYPE , -- TYPE 이라는 컬럼이 'A' 값을 가짐
       SUM(AMT)   -- KEY_TYPE 이 1, 3일 때 AMT 의 총합
FROM TEST34 
WHERE KEY_TYPE IN (1, 3)
UNION ALL
SELECT 'B' AS TYPE , -- TYPE 이라는 컬럼이 'B' 값을 가짐
       SUM(AMT)      -- KEY_TYPE 이 2, 3일 때 AMT 의 총합
FROM TEST34
WHERE KEY_TYPE IN (2, 3);

--------------------------------------------------------------------------

--테이블의 복제를 이용한 선택적 조인

SELECT * FROM TEST34;   -- 총 9개의 레코드 => 인라인뷰 T1

--ROWNUM 1,2 2개의 레코드 => 인라인뷰 T2
SELECT ROWNUM R_CNT FROM TEST34 WHERE ROWNUM < 3; 

-- TEST34 테이블을 x 2 복제 : 총 9 x 2 = 18 개 레코드 출력
SELECT *
FROM TEST34 T1 ,
     ( SELECT ROWNUM R_CNT FROM TEST34 WHERE ROWNUM < 3 ) T2;

--T2.R_CNT 가 1 이면 'A' , 2 이면 'B' 로 출력되는 TYPE 컬럼 추가
SELECT R_CNT, KEY_TYPE, 
       ( CASE  T2.R_CNT WHEN 1 THEN 'A' WHEN 2 THEN 'B' END ) TYPE , AMT
FROM TEST34 T1 ,
     ( SELECT ROWNUM R_CNT FROM TEST34 WHERE ROWNUM < 3 ) T2;
  
/* 이제 R_CNT, KEY_TYPE 는 출력될 필요 없으므로 지우고
   ( CASE  T2.R_CNT WHEN 1 THEN 'A'  WHEN 2 THEN 'B' END ) 
   으로 GROUP BY 하고 SUM(AMT) 추가 */   

/* TYPE 'A' 와 'B' 모두 450 출력 => TEST 34 테이블의 AMT 전체 총합  */
SELECT ( CASE T2.R_CNT WHEN 1 THEN 'A' WHEN 2 THEN 'B' END ) TYPE , 
       SUM(AMT)
FROM TEST34 T1 ,
     ( SELECT ROWNUM R_CNT FROM TEST34 WHERE ROWNUM < 3 ) T2
GROUP BY ( CASE T2.R_CNT WHEN 1 THEN 'A' WHEN 2 THEN 'B' END );

/* 일반적으로는 WHERE 조건으로 출력 결과를 제한하고 GROUP BY 하는 것이 맞지만,
  책에서는 중간 과정을 확인하기 위해 반대로 진행했다
  ROWNUM 인 R_CNT 가 1 일 때는 KEY_TYPE 1, 즉 TYPE A 만, 
  R_CNT 가 2 일때는 KEY_TYPE 2, 즉 TYPE B 만 선택되도록 WHERE 조건을 추가한다  */

-- 이렇게 하면 KEY_TYPE 이 1 일 때의 합과 2일 때의 합을 출력한다
SELECT ( CASE T2.R_CNT WHEN 1 THEN 'A' WHEN 2 THEN 'B' END ) TYPE , 
       SUM(AMT)
FROM TEST34 T1 ,
     ( SELECT ROWNUM R_CNT FROM TEST34 WHERE ROWNUM < 3 ) T2
WHERE T2.R_CNT = T1.KEY_TYPE  
GROUP BY ( CASE T2.R_CNT WHEN 1 THEN 'A' WHEN 2 THEN 'B' END );


/* 이제 KEY_TYPE 이 3일 때의 합이 위의 결과 각각에 더해지도록 하면 된다 */
  
/* 최종 결과 : WHERE 조건 수정 
   => T1.KEY_TYPE 이 3 일 경우, T2.R_CNT 대신 그냥 KEY_TYPE 이 되도록, 
      아니면 T2.R_CNT 가 되도록 CASE 함수를 추가한다  */

--T2.R_CNT 가 NUMBER 값 : TO_CHAR 함수로 문자열로 변환한다 
SELECT ( CASE T2.R_CNT WHEN 1 THEN 'A' WHEN 2 THEN 'B' END ) TYPE , 
         SUM(AMT)
FROM TEST34 T1 ,
     ( SELECT ROWNUM R_CNT FROM TEST34 WHERE ROWNUM < 3 ) T2
WHERE ( CASE WHEN T1.KEY_TYPE = 3 THEN T1.KEY_TYPE ELSE TO_CHAR(T2.R_CNT) END ) 
      = T1.KEY_TYPE
GROUP BY ( CASE T2.R_CNT WHEN 1 THEN 'A' WHEN 2 THEN 'B' END );

-------------------------------------------------------------------------

/* 사실 위의 결과는, 굉장히 복잡하게 한 것임  */

-- TEST34 테이블 x2 복제 후 WHERE 조건 추가 
SELECT *
FROM TEST34 T1 ,
        ( SELECT ROWNUM R_CNT FROM TEST34 WHERE ROWNUM < 3 ) T2
WHERE T1.KEY_TYPE = ( CASE WHEN T1.KEY_TYPE = 3 
                           THEN T1.KEY_TYPE ELSE TO_CHAR(T2.R_CNT) END );   


-- 위의 문장을 R_CNT 로 그룹화
SELECT  T2.R_CNT AS TYPE, SUM(AMT) AS 총합
FROM TEST34 T1 ,
     ( SELECT ROWNUM R_CNT FROM TEST34 WHERE ROWNUM < 3 ) T2
WHERE T1.KEY_TYPE = ( CASE WHEN T1.KEY_TYPE = 3 
                           THEN T1.KEY_TYPE ELSE TO_CHAR(T2.R_CNT) END )
GROUP BY T2.R_CNT;

--------------------------------------------------------------------------

--p298 문제 10-2  선택적 복제

--레코드 추가 / COMMIT
INSERT INTO TEST34 VALUES ('A10',4,100);
INSERT INTO TEST34 VALUES ('A11',4,110);
COMMIT;

SELECT * FROM TEST34;  -- 총 11개 레코드

/* TEST34 테이블을 x 3 복제하고 마지막에 ROWNUM 인 R_CNT 로 그룹화한다   
   R_CNT 1 : KEY_TYPE 이 1 또는 4 인 레코드의 AMT 총합계산 ,
   R_CNT 2 : KEY_TYPE 이 2 또는 4 인 레코드의 AMT 총합계산 ,
   R_CNT 3 : KEY_TYPE 이 3 또는 4 인 레코드의 AMT 총합계산  에 사용한다  */

/* 즉, R_CNT 1 에서는 KEY_TYPE 1 , 4 레코드만 있어야 하며
   다른 R_CNT 에서도 마찬가지, 그렇게 되도록 나중에 WHERE 조건을 추가한다 */

SELECT *
FROM TEST34 T1,  
     ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 4 ) T2;

/* 이제 WHERE 조건을 추가한다 
   KEY_TYPE 이 4 일 때 : T1.KEY_TYPE = T1.KEY_TYPE  => 무조건 출력 
   KEY_TYPE 이 4 가 아닐 경우 : T2.R_CNT 가 같을 때만 출력 */

--T2.R_CNT 가 number 값 : 문자열로 변환하였다
SELECT *
FROM TEST34 T1, 
     ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 4 ) T2
WHERE T1.KEY_TYPE = ( CASE WHEN T1.KEY_TYPE = 4 THEN T1.KEY_TYPE 
                           ELSE TO_CHAR(T2.R_CNT) END );


/* 최종 : 위의 결과를 R_CNT 로 그룹화하고 별칭 준 다음 출력  */
SELECT T2.R_CNT AS TYPE, SUM(AMT) AS 총합
FROM TEST34 T1, 
     ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 4 ) T2
WHERE T1.KEY_TYPE = ( CASE WHEN T1.KEY_TYPE = 4 THEN T1.KEY_TYPE 
                           ELSE TO_CHAR(T2.R_CNT) END )
GROUP BY T2.R_CNT;