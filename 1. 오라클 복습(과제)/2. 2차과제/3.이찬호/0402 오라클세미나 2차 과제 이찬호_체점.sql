






-- 17. 사원번호, 사원이름, 급여액 별 등급을 가져온다.
-- 1000 미만 : C등급
-- 1000 이상 2000미만 : B등급
-- 2000 이상 : A등급
(★ 혹시 이문제 case문 말고 decode문으로 풀수 있으신분?)

SELECT empno,
        ename,
        CASE 
          WHEN sal>=2000 THEN 'A등급'
          WHEN sal>=1000 THEN 'B등급'
          ELSE 'C등급'
          END
FROM EMP;

/*
SELECT empno , 
       ename , 
       DECODE(SIGN(sal-1000),-1,'C등급', DECODE(SIGN(sal-2000),-1,'B등급','A등급') ) grade 
  FROM EMP;
*/















