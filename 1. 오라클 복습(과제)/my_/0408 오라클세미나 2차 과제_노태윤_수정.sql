-- 6. 급여가 1500 이상인 사원의 급여를 15% 삭감한다. 단 소수점 이하는 버린다.
SELECT TRUNC(sal*0.85) NewSal
FROM EMP
WHERE sal>=1500
ORDER BY 1;
