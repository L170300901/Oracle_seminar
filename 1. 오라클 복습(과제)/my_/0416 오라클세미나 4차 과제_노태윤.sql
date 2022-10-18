
-- 1. SMITH ����� �����ȣ, �̸�, ���ӻ�� �̸��� �����´�.


    --1) �������� ���
SELECT e.empno
     ,e.ename
     ,   m.ename m_ename
  FROM EMP m
     ,
       (SELECT *
         FROM EMP
        WHERE ename=UPPER('smith')
       ) e
 WHERE m.empno IN
       (SELECT e.mgr
         FROM EMP e
        WHERE e.ename=UPPER('smith')
       );


 		--2) join ���
SELECT e.empno
     , e.ename
     , m.ename m_ename
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND e.ename=UPPER('smith');


-- 2. FORD ��� �ؿ��� ���ϴ� ������� �����ȣ, �̸�, ������ �����´�.


    --1) �������� ���
SELECT e.empno
     ,e.ename
     , e.job
  FROM EMP e
 WHERE e.mgr IN
       (SELECT m.empno
         FROM EMP m
        WHERE m.ename=UPPER('ford')
       );


 		--2)join ���
SELECT e.empno
     , e.ename
     , e.job
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND m.ename=UPPER('ford');


-- 3. SMITH ����� ���ӻ���� ������ ������ ������ �ִ� ������� �����ȣ, �̸�, ������ �����´�.


 --1) �������� ���
SELECT f.empno
     , f.ename
     , f.job
  FROM EMP f
 WHERE f.job IN
       (SELECT m.job
         FROM EMP m
        WHERE m.empno IN
              (SELECT e.mgr
                FROM EMP e
               WHERE e.ename=UPPER('smith')
              )
       );


 		--2) join ���
SELECT f.empno
     , f.ename
     , f.job
  FROM EMP f
 WHERE f.job IN
       (SELECT m.job
         FROM EMP e
            , EMP m
        WHERE e.mgr=m.empno
              AND e.ename=UPPER('smith')
       );


-- 4. �� ����� �̸�, �����ȣ, ������ �̸��� �����´�. �� ���ӻ���� ���� ����� �����´�.

		--������ �� �ָ��Ѱ� ���ٰ� ������ �� .. ��簡 ���� �����  ����̶�� �ϳ���?
    --���� ����� ���� �� �ָ���..
    --> 1.���ӻ�縦 ���Ͻÿ�
    --> 2. �����縦 ���Ͻÿ�
    --�ΰ��� ���� �ٸ�


    --1) �����縦 ���Ͻÿ�

			--�ð� ������ Ǯ��.. Ǯ�� ������ ����.. �ٵ� �� ���� �����ҵ� ���� �ɸ��� ����
/*
SELECT e.empno
     , e.ename
     , m.ename m_ename
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND e.ename IN
       (SELECT m.ename
         FROM EMP e
            , EMP m
        WHERE e.mgr=m.empno
       );
 */

 		--2) ���ӻ�縦 ���Ͻÿ�
SELECT e.empno
     , e.ename
     , m.ename m_ename
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno(+);


-- 5. ��� �μ��� �Ҽ� ����� �ٹ��μ���, �����ȣ, ����̸�, �޿��� �����´�.


SELECT d.dname
     ,e.empno
     ,e.ename
     ,e.sal
  FROM DEPT d
     , EMP e
 WHERE d.deptno=e.deptno;


-- 6. SCOTT ����� �ٹ��ϰ� �ִ� �μ��� �̸��� �����´�.


		--1) �������� �̿�
SELECT dname
  FROM DEPT
 WHERE DEPTNO =
       (SELECT e.deptno
         FROM EMP e
        WHERE e.ename=UPPER('scott')
       );


		--2) join �̿�
SELECT d.dname
  FROM DEPT d
     , EMP e
 WHERE d.deptno=e.deptno
       AND e.ename=UPPER('scott')



-- 7. SMITH�� ���� �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �޿���, �μ��̸��� �����´�.


		--�޿����� ������?? ���� ���ϴ� �ǰ���?
SELECT e.empno
     , e.ename
     , e.sal
     ,d.dname
  FROM DEPT d
     , EMP e
 WHERE d.deptno=e.deptno
       AND e.deptno IN
       (SELECT deptno
         FROM EMP
        WHERE ename=UPPER('smith')
       );


-- 8. MARTIN�� ���� ������ ������ �ִ� ������� �����ȣ, �̸�, ������ �����´�.


SELECT e.empno
     , e.ename
     , e.job
  FROM EMP e
 WHERE
       e.job IN
       (SELECT job
         FROM EMP
        WHERE ename=UPPER('martin')
       );


-- 9. ALLEN�� ���� ���ӻ���� ���� ������� �����ȣ, �̸�, ���ӻ���̸��� �����´�.


SELECT e.empno
     , e.ename
     , m.ename m_ename
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND m.ename IN
       (SELECT m.ename
         FROM EMP e
            , EMP m
        WHERE e.mgr=m.empno
              AND e.ename=UPPER('allen')
       );


-- 10. WARD�� ���� �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �μ���ȣ�� �����´�.


SELECT e.empno
     , e.ename
     ,d.deptno
  FROM DEPT d
     , EMP e
 WHERE d.deptno=e.deptno
       AND e.deptno IN
       (SELECT deptno
         FROM EMP
        WHERE ename=UPPER('ward')
       );


-- 11. SALESMAN�� ��� �޿����� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.


    --�� ������ ������ salesman�� ����� ��� �ǵ� �����ڴ�
SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE sal>
       (SELECT avg(sal)
         FROM EMP
        WHERE job=UPPER('salesman')
       );


-- 12. DALLAS ������ �ٹ��ϴ� ������� ��� �޿��� �����´�.


SELECT AVG(sal)
  FROM
       (SELECT sal
         FROM EMP e
            , DEPT d
        WHERE e.deptno=d.deptno
              AND e.deptno=
              (SELECT deptno
                FROM DEPT
               WHERE LOC=UPPER('dallas')
              )
       )


-- 13. SALES �μ��� �ٹ��ϴ� ������� �����ȣ, �̸�, �ٹ������� �����´�.


/*
select * from dept;
select *from emp;
*/
SELECT e.empno
     , e.ename
     , d.loc
  FROM EMP e
     , DEPT d
 WHERE e.deptno= d.deptno
 AND d.dname=UPPER('sales');


-- 14. CHICAGO ������ �ٹ��ϴ� ����� �� BLAKE�� ���ӻ���� ������� �����ȣ, �̸�, ������ �����´�.


SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
     , DEPT d
 WHERE e.deptno= d.deptno
       AND d.loc=UPPER('chicago')
       AND e.mgr IN
       (SELECT m.empno
         FROM EMP m
        WHERE m.ename=UPPER('blake')
       );


-- 15. 3000 �̻��� �޿��� �޴� ������ ���� �μ��� �ٹ��ϰ� �ִ� ����� �����ȣ, �̸�, �޿��� �����´�


SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE e.deptno IN
       (SELECT deptno
         FROM EMP
        WHERE sal>3000
       );


-- 16. ������ CLERK�� ����� ������ �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �Ի��� �����´�.


    --clerk�� ������� ��� �μ��� �ִ�
    --�μ��� �ٹ��ϰ� �ִ� ������� ������� �ǰ�?
SELECT e.empno
     , e.ename
     , e.hiredate
  FROM EMP e
 WHERE e.deptno IN
       (SELECT deptno
         FROM EMP e
        WHERE e.job=UPPER('clerk')
       );


-- 17. KING�� ���ӻ������ ������ �ִ� ������� �ٹ��ϰ� �ִ� �ٹ� �μ���, ������ ������´�.


/*
SELECT *FROM EMP
ORDER BY mgr;
*/

SELECT d.dname
     , d.loc
  FROM EMP e
     , DEPT d
 WHERE e.deptno= d.deptno
       AND e.mgr=
       (SELECT empno
         FROM EMP
        WHERE ename=UPPER('king')
       );


-- 18. CLERK���� ���ӻ���� �����ȣ, �̸�, �޿��� �����´�.

SELECT m.empno
     , m.ename
     , m.sal
  FROM EMP e
     , EMP m
 WHERE e.mgr=m.empno
       AND e.job=UPPER('clerk');

-- 19. �� �μ��� �޿� ��պ��� �� ���� �޴� ����� �����ȣ, �̸�, �޿��� �����´�.


SELECT e.empno
     , e.ename
     , e.sal
     , e.deptno
  FROM EMP e
 WHERE sal>
       (SELECT AVG(sal)
         FROM EMP
        WHERE deptno=e.deptno
       );


-- 20. �� �μ��� �޿� ����ġ���� �� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.


SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE sal>
       (SELECT min(sal)
         FROM EMP
        WHERE deptno=e.deptno
       );


-- 21. SALESMAN ���� �޿��� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.


		--�ռҸ���? job�� salesman�� ������� ���� �޴´ٴ� ���� ������ ��ȣ��
    --������ salesman�� min �޿� ���� �� ���� �޴� ����� �޿��� ��� �ϰڽ��ϴ�
SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE sal<
       (SELECT MIN(sal)
         FROM EMP
        WHERE job=UPPER('salesman')
       );


-- 22. �� �μ��� ���� �޿� �׼����� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.


		--*20���̶� ������ ����??
SELECT e.empno
     , e.ename
     , e.sal
  FROM EMP e
 WHERE sal>
       (SELECT min(sal)
         FROM EMP
        WHERE deptno=e.deptno
       );


-- 23. DALLAS�� �ٹ��ϰ� �ִ� ����� �� ���� ���߿� �Ի��� ����� �Ի� ��¥���� �� ���� �Ի���
-- ������� �����ȣ, �̸�, �Ի����� �����´�.


SELECT e.empno
     , e.ename
     , e.hiredate
  FROM EMP e
 WHERE hiredate <
       (SELECT MAX(hiredate)
         FROM EMP e
            , DEPT d
        WHERE e.deptno=d.deptno
       );
