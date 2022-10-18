-- p466 따라하기

SELECT * FROM TEST01;
SELECT * FROM TEMP;

SELECT T1.EMP_ID, T1.EMP_NAME
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME,DEPT_CODE
       FROM TEMP 
       WHERE DEPT_CODE = 'AA0001' ) T1 , 
       TEST01 T2 
WHERE T2.B=T1.R_CNT (+) AND T2.B <= 10 ;

/* WHERE DEPT_CODE = 'AA0001' 의 위치가 중요!
   ROWNUM 은 WHERE 조건 적용 후에 매겨진다. 

SELECT T1.EMP_ID, T1.EMP_NAME
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME,DEPT_CODE
       FROM TEMP ) T1 , 
     TEST01 T2 
WHERE T2.B=T1.R_CNT (+) AND WHERE DEPT_CODE = 'AA0001' ;

이 구문은 제대로 실행되지 않는다. 
T1 인라인뷰 안에서 WHERE 조건 없이 모두 검색될 경우
부서번호 'AA0001' 인 2명 중 
한 명의 ROWNUM 이 10보다 크게 매겨지기 때문..

SELECT T1.EMP_ID, T1.EMP_NAME
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME,DEPT_CODE
       FROM TEMP 
       WHERE DEPT_CODE = 'AA0001' ) T1 , 
      ( SELECT B FROM TEST01 WHERE B <=10 ) T2 
WHERE T2.B=T1.R_CNT (+) ;

WHERE B <= 10 의 위치를 T2 인라인뷰 안으로 넣은 구문은 상관없이 잘 실행된다. 

*/

--p469 문제 23-1 : 고정된 ROW 수 유지
SELECT T1.R_CNT, T1.EMP_ID, T1.EMP_NAME, T2.B
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME
          FROM TEMP 
          WHERE DEPT_CODE = 'AA0001' ) T1 , 
         ( SELECT B FROM TEST01 ) T2 
WHERE T2.B=T1.R_CNT (+) 
AND T2.B <= ( CASE WHEN T1.R_CNT > 10 THEN T1.R_CNT
                   ELSE 10 END );
-- T1의 결과가 10행보다 작을 경우, 언제가는 T1.R_CNT 값에 NULL 이 들어간다
-- 그럴 경우, CASE 의 WHEN 구문은 FALSE => ELSE 구문 실행됨
-- 즉 WHERE T2.B <= 10 이 된다 

/*
다음 구문은 마지막 Case 조건을 순서만 바꾼 것인데, T1 의 결과가 10행 미만일 경우
제대로 출력되지 않는다. (2행만 출력)

SELECT T1.R_CNT, T1.EMP_ID, T1.EMP_NAME, T2.B
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME
          FROM TEMP 
          WHERE DEPT_CODE = 'AA0001' ) T1 , 
         ( SELECT B FROM TEST01 ) T2 
WHERE T2.B=T1.R_CNT (+)                -- 여기까지만 실행해보고 결과에서 R_CNT 가 NULL 일 때가 중요!
AND T2.B <= ( CASE WHEN T1.R_CNT <= 10 THEN 10
                           ELSE T1.R_CNT END );

T1.R_CNT 가 NULL 값일 때 자동적으로 CASE 의 ELSE 구문, 여기서는 T1.R_CNT 으로 넘어감
그런데 그 T1.R_CNT 가 NULL 임 : 결국 그냥 종료되는 결과를 가져온다.

*/