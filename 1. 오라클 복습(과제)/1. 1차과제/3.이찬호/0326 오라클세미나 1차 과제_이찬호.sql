1��.
DESC emp

2��.
SELECT* FROM dept;

3��

SELECT sal,
					sal+1000,
          sal-200,
          sal*2,
          sal/2
FROM emp

4��
SELECT sal,
					comm,
          sal+comm
FROM EMP

5��
������ �𸣰���

6��.

SELECT deptno
FROM EMP
GROUP BY deptno

7��

SELECT empno,
					ename,
          sal
FROM EMP
WHERE sal>=1500;

8��
SELECT empno,
					ename,
          job
FROM EMP
WHERE job = 'SALESMAN'

9��

SELECT empno,
					ename,
          hiredate
FROM EMP
WHERE hiredate>'82/01/01'

10��

SELECT empno,
					ename,
          deptno,
          job
FROM EMP
WHERE deptno=10
					AND job ='MANAGER'

11��

SELECT empno,
					ename,
          sal,
          hiredate
FROM EMP
WHERE sal>1500
					AND hiredate LIKE '81%'

12��.

SELECT empno,
					ename,
          sal
FROM EMP
WHERE sal >2000 or sal<1000

13��.

SELECT empno,
					ename,
          job
FROM EMP
WHERE job IN('CLERK','SALESMAN','ANALYST')

14��

SELECT empno,
					ename
FROM EMP
WHERE empno NOT IN (7499,7566,7839)


