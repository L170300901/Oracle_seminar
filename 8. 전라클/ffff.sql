--[6번 문제]
--94년부터 년도 까지 입사한 사람들 중에서 입사년도 별로 가장많은 급여를 받는 사람을 출력하세요
--각 년도와 풀네임과 보너스까지 합친 총급여를 출력하세요
--(94년도는 두 명 출력되는게 정상입니다)

SELECT * FROM EMPLOYEES
ALTER SESSION SET nls_date_format = 'rr/mm/dd'



SELECT DISTINCT *
  FROM EMPLOYEES b
 WHERE (b.salary)
       IN
       (SELECT
            MAX(e.SALARY) ms
         FROM EMPLOYEES e
        WHERE e.HIRE_DATE < '940101'
        GROUP BY e.HIRE_DATE
       )
       AND b.HIRE_DATE < '940101'
