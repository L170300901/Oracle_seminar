SELECT * FROM SAM_TAB01;  

--P_var1 파라미터 사용
/*  '1' : 모든 사원 (EMP_ID)의 직급 (LEV) 별 급여 (SALARY) 평균
 '2' : 직급 (LEV) 이 '01' 인 사원 (EMP_ID) 의 급여 (SALARY) 평균
 '3' : 직급 (LEV) 이 '02' 인 사원 (EMP_ID) 의 급여 (SALARY) 평균
 '4' : 직급 (LEV) 이 '03 인 사원 (EMP_ID) 의 급여 (SALARY) 평균
 '5' : 직급 (LEV) 이 '04' '05 인 사원 (EMP_ID) 의 급여 (SALARY) 평균
*/

SELECT LEV, AVG(SALARY) FROM SAM_TAB01 GROUP BY LEV;
SELECT LEV, AVG(SALARY) FROM SAM_TAB01 WHERE LEV = '01' GROUP BY LEV;
SELECT LEV, AVG(SALARY) FROM SAM_TAB01 WHERE LEV = '02' GROUP BY LEV;
SELECT LEV, AVG(SALARY) FROM SAM_TAB01 WHERE LEV = '03' GROUP BY LEV;
SELECT LEV, AVG(SALARY) FROM SAM_TAB01 WHERE LEV = '04' OR LEV = '05' GROUP BY LEV;

SELECT LEV, AVG(SALARY) 
FROM SAM_TAB01 
WHERE LEV = ( CASE P_var1 WHEN 1 THEN LEV
                          WHEN 2 THEN '01'
                          WHEN 3 THEN '02'
                          WHEN 4  THEN '03'
                          WHEN 5 THEN '04' END )
         OR LEV = ( CASE P_var1 WHEN 5 THEN '05' END )                            
GROUP BY LEV;

--p494 문제 25-1 풀이 : 실행할 때마다 결과 달라짐
SELECT LEV, AVG(SALARY) 
FROM SAM_TAB01 
WHERE LEV = ( CASE MOD(TO_CHAR(SYSDATE,'SS'),5)+1 
                                    WHEN 1 THEN LEV
                                    WHEN 2 THEN '01'
                                    WHEN 3 THEN '02'
                                    WHEN 4  THEN '03'
                                    WHEN 5 THEN '04' END )
         OR LEV = ( CASE MOD(TO_CHAR(SYSDATE,'SS'),5) WHEN 5 THEN '05' END )                            
GROUP BY LEV;

--p499 따라하기 : 책과 결과가 다른 듯? 
--처음 테이블 생성할 때 NO_EMP 필드에 DECODE(MOD(ROWNUM,2),0,2,1) 로 입력
--아마 ROWNUM 매기는 순서가 달라서 그런 것 같다

SELECT * FROM TEST08;

SELECT DECODE(PARAM1 , 'SITE', SITE,
                       'DEPT', DEPT,
                       'LEV', LEV,
                       'LOCAL', LOCAL ) GR1,
       DECODE(PARAM2 , 'SITE', SITE,
                       'DEPT', DEPT,
                       'LEV', LEV ,
                       'LOCAL', LOCAL ) GR2, 
       DECODE(PARAM3 , 'SITE', SITE,
                       'DEPT', DEPT,
                       'LEV', LEV ,
                       'LOCAL', LOCAL ) GR3 , SUM(NO_EMP)                     
FROM TEST08
GROUP BY DECODE(PARAM1 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV,
                                 'LOCAL', LOCAL ) ,
          DECODE(PARAM2 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) , 
          DECODE(PARAM3 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL );

--Parameter 에 'SITE', 'LEV', 'LOCAL' 적용                               
SELECT DECODE('SITE' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR1,
          DECODE('LEV' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR2, 
          DECODE('LOCAL' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR3 , SUM(NO_EMP) AS "총직원수"
FROM TEST08
GROUP BY DECODE('SITE' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ,
          DECODE('LEV' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) , 
          DECODE('LOCAL' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ;     

--Parameter 에 'SITE', 'LOCAL', '' 적용 ( '' 대신 NULL 도 가능 )                               
SELECT DECODE('SITE' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR1,
          DECODE('LOCAL' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR2, 
          DECODE('' , 'SITE', SITE,                  
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR3 , SUM(NO_EMP) AS "총직원수"
FROM TEST08
GROUP BY DECODE('SITE' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ,
          DECODE('LOCAL' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) , 
          DECODE('' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ;                                    

--p502 문제 25-2
--첫번째 풀이 : PARAM 에 바로 MOD(TO_CHAR(SYSDATE,'SS'),4)+1 적용
SELECT DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, SITE,
                                 2, DEPT,
                                 3, DEPT,
                                 4, DEPT ) GR1,
          DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, DEPT,
                                 2, SITE,
                                 3, SITE ,
                                 4, '' ) GR2, 
          DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, LEV,
                                 2, 'LEV',
                                 3, '' ,
                                 4, '' ) GR3 , SUM(NO_EMP)                     
FROM TEST08
GROUP BY DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, SITE,
                                 2, DEPT,
                                 3, DEPT,
                                 4, DEPT ) ,
          DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, DEPT,
                                 2, SITE,
                                 3, SITE ,
                                 4, '' ) , 
          DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, LEV,
                                 2, 'LEV',
                                 3, '' ,
                                 4, '' ) ;    

--GROUP BY 적용 전 : GR1, GR2, GR3 가 실행 때마다 바뀜
SELECT DECODE(PARAM1 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV,
                                 'LOCAL', LOCAL ) GR1,
          DECODE(PARAM2 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR2, 
          DECODE(PARAM3 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR3                     
FROM TEST08 ,
        ( SELECT DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'SITE' ,
                                2, 'DEPT' ,
                                3, 'DEPT' ,
                                4, 'DEPT' ) AS PARAM1 ,
            DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'DEPT' ,
                                2, 'SITE'  , 
                                3, 'SITE'  ,
                                4, ''       ) AS PARAM2 ,
             DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1,  'LEV' , 
                                2, 'LEV' , 
                                3, '' ,    
                                4, ''      ) AS PARAM3  FROM dual );

--GROUP BY 적용 후
SELECT DECODE(PARAM1 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV,
                                 'LOCAL', LOCAL ) GR1,
          DECODE(PARAM2 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR2, 
          DECODE(PARAM3 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR3 , SUM(NO_EMP) AS 총직원수        
FROM TEST08 ,
        ( SELECT DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'SITE' ,
                                2, 'DEPT' ,
                                3, 'DEPT' ,
                                4, 'DEPT' ) AS PARAM1 ,
            DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'DEPT' ,
                                2, 'SITE'  , 
                                3, 'SITE'  ,
                                4, ''       ) AS PARAM2 ,
             DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'LEV' , 
                                2, 'LEV' , 
                                3, '' ,    
                                4, ''      ) AS PARAM3  FROM dual )
GROUP BY DECODE(PARAM1 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV,
                                 'LOCAL', LOCAL ) ,
          DECODE(PARAM2 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) , 
          DECODE(PARAM3 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ;




