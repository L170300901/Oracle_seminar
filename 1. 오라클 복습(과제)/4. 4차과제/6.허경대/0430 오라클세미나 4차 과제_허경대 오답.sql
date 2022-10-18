
-- 21. SALESMAN 보다 급여를 적게 받는 사원들의 사원번호, 이름, 급여를 가져온다.

/*
-먼소리지? job이 salesman인 사람보다 적게 받는다는 말이 굉장히 모호함
--직업이 salesman의 min 급여 보다 더 적게 받는 사원의 급여를 출력 해보자
*/

???? 스칼라 서브쿼리



SELECT empno,
       ename,
       sal
  FROM EMP
 WHERE sal < ANY
       (SELECT sal
         FROM EMP
        WHERE job = UPPER('salesman')
       );
 /*
 이 경우 any를 사용 하셨는데 any를 사용하면 안됩니다
 -->any는 서브쿼리의 결과를 한개만 만족하면 됩니다
 */


SELECT distinct e.empno, e.ename, e.sal FROM EMP e, (SELECT sal FROM EMP where job = UPPER('salesman')) j WHERE e.sal < any(j.sal);


SELECT * FROM EMP e, (SELECT empno, sal FROM EMP where job = UPPER('salesman')) j WHERE  e.sal < all(j.sal)

SELECT * FROM EMP e;

SELECT sal FROM EMP where job = UPPER('salesman');

SELECT  * FROM EMP e, (SELECT sal FROM EMP where job = UPPER('salesman'));

SELECT * FROM EMP e, (SELECT empno, sal FROM EMP where job = UPPER('salesman')) j WHERE  e.sal < all(j.sal);

SELECT * FROM EMP e, (SELECT MIN(sal)AS min FROM EMP where job = UPPER('salesman'))
/*
푸신걸 봤는데..
일단 처음에 테이블 복제를 하셨네요?
select * from EMP e,  (SELECT sal FROM EMP where job = UPPER('salesman')) j;
이거를 하신 순간부터 emp 테이블이 4개로 복제 하신거
이건 알고 계시죠?
SELECT e.empno, e.ename, e.sal FROM EMP e, (SELECT MIN(sal)AS min FROM EMP where job = UPPER('salesman')) j WHERE e.sal < (j.min);
*/

SELECT distinct  e.empno, e.ename, e.sal FROM EMP e, EMP j WHERE j.job = UPPER('salesman') AND e.sal < ANY(j.sal);



