
-- 21. SALESMAN ���� �޿��� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.

/*
-�ռҸ���? job�� salesman�� ������� ���� �޴´ٴ� ���� ������ ��ȣ��
--������ salesman�� min �޿� ���� �� ���� �޴� ����� �޿��� ��� �غ���
*/

???? ��Į�� ��������



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
 �� ��� any�� ��� �ϼ̴µ� any�� ����ϸ� �ȵ˴ϴ�
 -->any�� ���������� ����� �Ѱ��� �����ϸ� �˴ϴ�
 */


SELECT distinct e.empno, e.ename, e.sal FROM EMP e, (SELECT sal FROM EMP where job = UPPER('salesman')) j WHERE e.sal < any(j.sal);


SELECT * FROM EMP e, (SELECT empno, sal FROM EMP where job = UPPER('salesman')) j WHERE  e.sal < all(j.sal)

SELECT * FROM EMP e;

SELECT sal FROM EMP where job = UPPER('salesman');

SELECT  * FROM EMP e, (SELECT sal FROM EMP where job = UPPER('salesman'));

SELECT * FROM EMP e, (SELECT empno, sal FROM EMP where job = UPPER('salesman')) j WHERE  e.sal < all(j.sal);

SELECT * FROM EMP e, (SELECT MIN(sal)AS min FROM EMP where job = UPPER('salesman'))
/*
Ǫ�Ű� �ôµ�..
�ϴ� ó���� ���̺� ������ �ϼ̳׿�?
select * from EMP e,  (SELECT sal FROM EMP where job = UPPER('salesman')) j;
�̰Ÿ� �Ͻ� �������� emp ���̺��� 4���� ���� �ϽŰ�
�̰� �˰� �����?
SELECT e.empno, e.ename, e.sal FROM EMP e, (SELECT MIN(sal)AS min FROM EMP where job = UPPER('salesman')) j WHERE e.sal < (j.min);
*/

SELECT distinct  e.empno, e.ename, e.sal FROM EMP e, EMP j WHERE j.job = UPPER('salesman') AND e.sal < ANY(j.sal);



