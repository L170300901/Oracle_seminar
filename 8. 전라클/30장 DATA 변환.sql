--실습 전 환경변수 조회
SELECT * FROM v$nls_parameters;
/* nls_character 이 AL32UTF8 인 경우 : 한글 한 글자는 3byte
   nls_character 이 AL16UTF16 또는 KO16MSWIN949 인 경우 : 한글 한 글자는 2byte  */

SELECT * FROM TEST36;
SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
FROM TEST36; 
SELECT ROWNUM AS RNUM FROM USER_TABLES WHERE ROWNUM < 13;

/* INSTRB(A.PLANMM, '월', 1, B.RNUM) 
  : PLANMM 문자열에서 '월' 을 첫 번째 바이트부터 검색하여 
    n 번째 '월' 의 위치 바이트를 반환  */
SELECT A.PLANYY AS PLAN, A.KEY1, A.SEQ, A.AMT, A.PLANMM, B.n, 
          INSTRB(A.PLANMM, '월', 1, B.n)       
FROM 
  ( SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
    FROM TEST36 ) A,  
  ( SELECT ROWNUM AS n FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE INSTRB(A.PLANMM, '월', 1, B.n) > 0;   -- n 번째 '월' 이 없는 경우 제외

/* SUBSTRB ( PLANMM, INSTRB(A.PLANMM, '월', 1, B.n )-2 , 2) 
  : PLANMM 문자열에서 ( n 번째 '월' 의 위치 바이트 ) -2 부터 검색하여
    2 바이트 길이의 문자열을 반환   
    =>  즉, n번째 '월' 앞의 2바이트 문자열을 반환하라는 의미    */
SELECT A.PLANYY AS PLAN, A.KEY1, A.SEQ, A.AMT, A.PLANMM, B.n, 
          SUBSTRB( A.PLANMM, INSTRB(A.PLANMM, '월', 1, B.n )-2 , 2)    
FROM 
  ( SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
    FROM TEST36 ) A,  
  ( SELECT ROWNUM AS n FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE INSTRB(A.PLANMM, '월', 1, B.n) > 0; 

/* 위의 결과에서 REPLACE ( ~ , ' ' , NULL ) : 공백 (' ') 을 NULL 로 치환 ,
   다시 LPAD(  ~ , 2 ,'0' ) : 좌측에 총 2자리가 되도록 '0'을 채움 ,
   마지막으로 MON 별칭을 붙인다 */
/* 뇌라클 p275 : LPAD ( ~ , n, ~ ) 에서 n 은 문자셋에 따라 
   자리수일 수도 바이트 수일 수도 있다    */
SELECT A.PLANYY AS PLAN, A.KEY1, A.SEQ, A.AMT, A.PLANMM, B.n, 
       LPAD(REPLACE(SUBSTRB( A.PLANMM, INSTRB(A.PLANMM, '월', 1, B.n )-2 , 2),' ', NULL),2,'0') AS MON
FROM 
  ( SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
    FROM TEST36 ) A,  
  ( SELECT ROWNUM AS n FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE INSTRB(A.PLANMM, '월', 1, B.n) > 0;


/* 위의 결과를 인라인 뷰 ( FROM 절의 서브쿼리 ) 로 활용한다
 (1)  ( CASE WHEN SUBSTR(MON,1,1) = '1' THEN '1' ELSE '0' END ) || SUBSTR(MON,2,1)  
   =>  ( 첫번째 바이트의 문자가 '1' 이면 '1' ,아니면 '0' ) + ( 2번째 바이트 문자 ) 반환
 (2) 위의 함수를 REPLACE( MON , ',' , '0' ) => 그냥 , 를 0 으로 치환해도 결과는 같다
 (3) 어떤 경우에도 '0', '1' 등등 문자열인 경우와 숫자인 경우를 정확히 구분해야 한다 
*/

SELECT PLAN, KEY1, 
       ( CASE WHEN SUBSTR(MON,1,1) = '1' THEN '1' ELSE '0' END ) || SUBSTR(MON,2,1) AS MON,
       SEQ, AMT
FROM          
( SELECT A.PLANYY AS PLAN, A.KEY1, A.SEQ, A.AMT, A.PLANMM, B.n, 
         LPAD(REPLACE(SUBSTRB( A.PLANMM, INSTRB(A.PLANMM, '월', 1, B.n )-2 , 2),' ', NULL),2,'0') AS MON
FROM 
  ( SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
    FROM TEST36 ) A,  
  ( SELECT ROWNUM AS n FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE INSTRB(A.PLANMM, '월', 1, B.n) > 0 )
ORDER  BY PLAN, KEY1, ( CASE WHEN SUBSTR(MON,1,1) = '1' THEN '1' ELSE '0' END ) || SUBSTR(MON,2,1);