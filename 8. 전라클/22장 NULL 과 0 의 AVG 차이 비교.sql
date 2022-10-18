SELECT * FROM TEST26;

SELECT YYMMDD, AVG(VAL1), AVG(VAL2), AVG(VAL3)
FROM TEST26
GROUP BY YYMMDD;
/*  19990601 기준만 이해하면 된다
   AVG(VAL1) : 10, NULL, NULL, NULL 의 평균 => 10
   AVG(VAL2) : 10, 0, 0 , 0 의 평균 => 2.5
   AVG(VAL3) : 10, 10, 10, 10 의 평균 => 10
*/
-- AVG 함수는 NULL 을 0 으로 치환해서 계산할 경우, 결과가 달라진다

SELECT KEY1, AVG(VAL1), AVG(VAL2), AVG(VAL3)
FROM TEST26
GROUP BY KEY1;
--위와 원리 동일

SELECT YYMMDD, SUM(VAL1), SUM(VAL2), SUM(VAL3)
FROM TEST26
GROUP BY YYMMDD;
-- NULL을 아예 무시하거나 0 으로 보나 결과는 같다
-- 정확히는 SUM 함수는 NULL 을 제외하고 연산을 수행한다
-- SUM 함수에서는 NULL 을 0 으로 치환하거나 안하거나 결과는 같다


SELECT YYMMDD, SUM(VAL1) + SUM(VAL2), SUM(VAL1 + VAL2)
FROM TEST26
GROUP BY YYMMDD;
/* 19990603 만 이해하면 된다
  SUM(VAL1) = 10 과 10의 SUM : 20 , 
  SUM(VAL2) = NULL 과 10의 SUM : 10  =>  결과 30  

  SUM(VAL1 + VAL2) 의 경우  (1) 10 + NULL = NULL , (2) 10+10 = 20
                                     NULL 과 20 의 SUM 결과 : 20   
*/

-- (Poin) 20 + NULL = NULL  , 20 과 NULL 의 SUM : 20  

SELECT KEY1, MAX(VAL1), MIN(VAL2), COUNT(VAL3)
FROM TEST26
GROUP BY KEY1;
-- NULL 만 있는 경우 MAX, MIN 함수의 결과는 NULL
-- AVG, MAX, MIN, COUNT, SUM 등 모든 그룹 함수는 모두 NULL 을 제외하고 연산을 수행한다
-- SUM 함수만 적용한다면 NULL 을 0으로 치환할 필요가 없다
-- AVG, MAX, MIN, COUNT 는 NULL 을 0으로 치환할 경우 결과가 달라진다

