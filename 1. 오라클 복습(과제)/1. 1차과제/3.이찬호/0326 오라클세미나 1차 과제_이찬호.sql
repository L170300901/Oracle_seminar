1번.
DESC emp

2번.
SELECT* FROM dept;

3번

SELECT sal,
					sal+1000,
          sal-200,
          sal*2,
          sal/2
FROM emp

4번
SELECT sal,
					comm,
          sal+comm
FROM EMP

5번
문제를 모르겠음

6번.

SELECT deptno
FROM EMP
GROUP BY deptno

7번

SELECT empno,
					ename,
          sal
FROM EMP
WHERE sal>=1500;

8번
SELECT empno,
					ename,
          job
FROM EMP
WHERE job = 'SALESMAN'

9번

SELECT empno,
					ename,
          hiredate
FROM EMP
WHERE hiredate>'82/01/01'

10번

SELECT empno,
					ename,
          deptno,
          job
FROM EMP
WHERE deptno=10
					AND job ='MANAGER'

11번

SELECT empno,
					ename,
          sal,
          hiredate
FROM EMP
WHERE sal>1500
					AND hiredate LIKE '81%'

12번.

SELECT empno,
					ename,
          sal
FROM EMP
WHERE sal >2000 or sal<1000

13번.

SELECT empno,
					ename,
          job
FROM EMP
WHERE job IN('CLERK','SALESMAN','ANALYST')

14번

SELECT empno,
					ename
FROM EMP
WHERE empno NOT IN (7499,7566,7839)


