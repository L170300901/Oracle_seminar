





--���� �� ��¥ ���� �ٲٱ�
ALTER SESSION SET nls_date_format='RR/MM/DD';






-- 1. �̸��� S�� ������ ����� �̸��� ��� ��ȣ�� �����´�.

SELECT ename, empno
FROM EMP
WHERE ename LIKE '%S';

-- 2. �̸��� A�� ���ԵǾ� �ִ� ����� �̸��� ��� ��ȣ�� �����´�.

SELECT ename, empno
FROM EMP
WHERE ename LIKE '%A%';

-- 3. �̸��� �ι�° ���ڰ� A�� ����� ��� �̸�, ��� ��ȣ�� �����´�.

SELECT ename, empno
FROM EMP
WHERE ename LIKE '_A%';

-- 4. ����߿� Ŀ�̼��� ���� �ʴ� ����� �����ȣ, �̸�, Ŀ�̼��� �����´�.

SELECT empno, 
       ename, 
       comm 
  FROM EMP 
 WHERE comm IS NULL 
       OR comm<=0; 
ORDER BY 1; 

-- 5. 1981�⿡ �Ի��� ������� �����ȣ, ��� �̸�, �Ի����� �����´�. ��� ��ȣ�� �������� �������� ������ �Ѵ�.


				--���� �ϸ� �ʹ� ������ ����ΰ� ���Ƽ�
SELECT empno
     , ename
     , sal
     , hiredate
FROM EMP
WHERE hiredate >= '1981/01/01'
       AND hiredate <= '1981/12/31'
ORDER BY 1;

				--���� �Լ� ���������� ������ trunc�� �̿��� �ٽ� Ǯ�
SELECT empno
     , ename
     , sal
     , hiredate
FROM EMP
WHERE TRUNC(hiredate, 'YYYY') = '1981/01/01'
ORDER BY 1;

-- 6. �޿��� 1500 �̻��� ����� �޿��� 15% �谨�Ѵ�. �� �Ҽ��� ���ϴ� ������.

SELECT TRUNC(sal*0.85) NewSal
FROM EMP
WHERE sal>=1500
ORDER BY 1;

-- 7. �޿��� 2õ ������ ������� �޿��� 20%�� �λ��Ѵ�. �� 10�� �ڸ��� �������� �ݿø��Ѵ�.

SELECT ROUND((sal*1.2),-2) NewSal
FROM EMP
WHERE sal<=2000
ORDER BY 1;

-- 8. ������� �̸��� �ҹ��ڷ� �����´�.

SELECT LOWER(ename) NAME
FROM EMP;

-- 9. ����� �̸� �߿� A��� ���ڰ� �ι�° ���Ŀ� ��Ÿ���� ����� �̸��� �����´�.***

						--���1
            	--�̰� �� �ƴ¹�� �ι�° A�ΰ� ã�� and�� ù��° �ι�°  A�ΰ� �����

SELECT ename
FROM EMP
WHERE ename LIKE '__%A%'
       AND ename NOT LIKE 'A%'
       AND ename NOT LIKE '_A%'
ORDER BY 1;


					--���2
						--���� �� instr���� ������ Ǯ�� ���� ����� 1byte �ѱ��� 2byte
            		--p.s �׷� ���ڴ� �� ����Ʈ �ϱ�????
            				--instr(�÷�or���ڿ�,����) ������ 63��
SELECT ename
FROM EMP
WHERE INSTR(ename,'A')>2
ORDER by 1;

-- 10. ��� �̸��� �տ� 3�ڸ��� ����Ѵ�.

SELECT SUBSTR(ename,1,3) NAME
FROM EMP;

-- 11. ������ SALESMAN�� ����� �Ի��� 100���� ��¥�� �����´�.

SELECT hiredate
     , hiredate - 100
FROM EMP
WHERE job = 'SALESMAN';

-- 12. �� ����� �ٹ� ���� �����´�.

SELECT TRUNC(SYSDATE - hiredate) �ٹ�_��
FROM EMP;

-- 13. ��� ����� �ٹ��� ���� ���� ���Ѵ�.

SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) �ٹ���_������
FROM EMP;

-- 14. �������� ������ ��¥�� ���Ѵ�.

SELECT last_day(ADD_MONTHS(SYSDATE,1)) next_month_last_date
FROM dual;

-- 15. ����̸�, �Ի����� ���Ѵ�. ��, ������� �Ի����� ������ ���� ������� �����´�.
-- 81.10.10

SELECT ename
     , TO_CHAR(hiredate, 'YY.MM.DD') new_hiredate
FROM EMP;

-- 16. �� ������̸��� �μ� �̸��� �����´�.
-- �μ��̸��� ��ȣ���� �ѱ��̸��� ǥ�õǰ� (10='�λ��', 20='���ߺ�', 30='���������', 40='�����')

SELECT empno
     , ename
     , DECODE(deptno, 10, '�λ��', 20, '���ߺ�', 30, '�濵������', 40, '�����') New_Decode
FROM EMP;

-- 17. �����ȣ, ����̸�, �޿��� �� ����� �����´�.
-- 1000 �̸� : C���
-- 1000 �̻� 2000�̸� : B���
-- 2000 �̻� : A���

					--���1) case�� ���
SELECT empno
     , ename
     , CASE
           WHEN sal < 1000 THEN 'C���'
           WHEN sal >= 1000 AND sal < 2000 THEN 'B���'
           WHEN sal >= 2000 THEN 'A���'
       END grade
  FROM EMP;

					--���2) decode�� ���


SELECT empno ,
       ename ,
       DECODE(SIGN(sal-1000),-1,'C���', DECODE(SIGN(sal-2000),-1,'B���','A���') ) grade
  FROM EMP;


-- 18. �޿��� 1500 �̻��� ������� �޿� ������ ���Ѵ�.

SELECT SUM(sal) Sum_Sal
FROM EMP
WHERE sal >= 1500;

-- 19. Ŀ�̼��� �޴� ������� Ŀ�̼� ����� ���Ѵ�.**?

			--���� å���� ���ų� ..p96 2��°�� �� ���� ģ�Ŵ� ...
      	--null�� ���� �ش� ���� �ƿ� ����� ������ ��Ű�� ����
        	--�� ������ �̿�����

SELECT TRUNC(AVG(comm)) AVG_Comm
FROM EMP;

-- 20. �� ����� Ŀ�̼��� ����� ���Ѵ�.

SELECT TRUNC(AVG(NVL(comm, 0))) Avg_Comm
FROM EMP;
													--���� �����Ƽ� �׳� trunc�Ἥ �ݿø� �Ҳ��� ^^*/

-- 21. ������� �޿� �ִ�, �ּҰ��� �����´�.

SELECT MAX(sal) MaxSal, MIN(sal) Min_Sal
FROM EMP;
