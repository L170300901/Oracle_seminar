--p384 따라하기
SELECT std_id AS 학번, TERM,
      SUM( ROUND( ( test1+test2+test3+test4+test5-Least( test1, test2, test3, test4, test5) 
      - Greatest( test1, test2, test3, test4, test5) ) / 3 ) * UNIT ) / SUM(UNIT) AS AVRG
from TEST99
GROUP BY STD_ID, TERM;


SELECT A.학번, A.TERM, A.AVRG , COUNT(B.AVRG)+1 as RANK
FROM
( SELECT std_id AS 학번, TERM,
      SUM( ROUND( ( test1+test2+test3+test4+test5-Least( test1, test2, test3, test4, test5) 
      - Greatest( test1, test2, test3, test4, test5) ) / 3 ) * UNIT ) / SUM(UNIT) AS AVRG
FROM TEST99
GROUP BY STD_ID, TERM ) A,
( SELECT std_id AS 학번, TERM,
      SUM( ROUND( ( test1+test2+test3+test4+test5-Least( test1, test2, test3, test4, test5) 
      - Greatest( test1, test2, test3, test4, test5) ) / 3 ) * UNIT ) / SUM(UNIT) AS AVRG 
 FROM TEST99
GROUP BY STD_ID, TERM ) B
WHERE A.AVRG < B.AVRG (+)
GROUP BY A.학번, A.TERM, A.AVRG
ORDER BY RANK;


--p387 문제 16-1
SELECT std_id AS 학번, TERM,
      SUM( test5 * UNIT ) / SUM(UNIT) AS AVRG
FROM TEST99
GROUP BY STD_ID, TERM;

SELECT A.학번, A.TERM, A.AVRG , COUNT(B.AVRG)+1 as RANK
FROM
 ( SELECT std_id AS 학번, TERM,
             SUM( test5 * UNIT ) / SUM(UNIT) AS AVRG
 FROM TEST99
 GROUP BY STD_ID, TERM ) A,
( SELECT std_id AS 학번, TERM,
      SUM( test5 * UNIT ) / SUM(UNIT) AS AVRG
FROM TEST99
GROUP BY STD_ID, TERM ) B
WHERE A.AVRG < B.AVRG (+)
GROUP BY A.학번, A.TERM, A.AVRG
ORDER BY RANK;
