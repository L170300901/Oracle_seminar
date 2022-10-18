--p262 �����ϱ� : ȯ��ݾ� ���ϱ�

SELECT * FROM TEST02;

/* ������ ������ �� �������� ����
   TEMP01 ���� CDATE (����), AMT (�ݾ�) , TEMP02 ���� CRATE (ȯ��) �� �ʿ��ϴ�
   TEMP01 ���� �ڽ��� ���� ���ڵ��� Data, �� ������ ȯ���� TEMP02 ����  ��µǵ���
   ������ ROWNUM �� �̿��Ͽ� ������ ���̴�   */
--���ڰ� �������� ���̾��ٸ� ROWNUM ��� ���ڷ� ������ �� �־��� ���̴� 
--å������ Ư�� ���� ���̸� �߰��ǵ��� BETWEEN �߰� : ���⼭�� ����
SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02;
SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02;

-- �� ���������� Cartesian Product : ���ϴ� ����� �������� ������ ������ �� ��
SELECT *
FROM
( SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP01,
( SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP02;

/* WHERE ���� �߰� : TEMP01 �� ��� ����� ��µǵ��� OUTER JOIN ,
   OUTER JOIN �� ���� ������ ���� Data �� ���� 2001�� 9�� 1�� ���ڵ尡 ��µ��� �ʴ´� */
SELECT *
FROM
( SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP01,
( SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP02
WHERE TEMP01.MAIN_CNT -1 = TEMP02.SUB_CNT (+);  

-- * �� �ʿ��� �÷���� ���� , CDATE (����) ������ ����
SELECT TEMP01.CDATE, TEMP01.AMT, TEMP02.CRATE
FROM
( SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP01,
( SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP02
WHERE TEMP01.MAIN_CNT -1 = TEMP02.SUB_CNT (+)
ORDER BY CDATE;

/* ������ ��Ī�� �ְ� ( �ݾ� * ���� ȯ�� ) = ( ȯ��ݾ� ) �÷� �߰�  
   ���� ������ ORDER BY CDATE �� �������� ������
   "���� ���ǰ� �ָ��մϴ�" ������ ���      */
SELECT TEMP01.CDATE AS ���� , TEMP01.AMT AS �ݾ�  , TEMP02.CRATE AS ����ȯ�� ,
       ( TEMP01.AMT * TEMP02.CRATE ) AS ȯ��ݾ�
FROM
( SELECT ROWNUM AS MAIN_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP01,
( SELECT ROWNUM AS SUB_CNT, CDATE, AMT, CRATE FROM TEST02 ) TEMP02
WHERE TEMP01.MAIN_CNT -1 = TEMP02.SUB_CNT (+)
ORDER BY ����;   

----------------------------------------------------------------------

--p265 ���� 8-1�� : ���� Record ���� ����
SELECT * FROM TEST02;

-- t1, t2 �� ���������� Cartesian Product : ���ϴ� ����� �������� ������ ������ �� ��
SELECT *
FROM 
( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
( SELECT ROWNUM as no2, CDATE, AMT, CRATE FROM test02 ) t2;

/* t1 ���� ( �ڽ��� ���� ���ڵ� ) or ( �ڱ� �ڽ� + �ڽ��� ���� ���ڵ� ) �� 
   t2 ���� ��µǵ��� �����Ѵ� */

--��� 1 : �ƿ��� ���� 
SELECT *
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE T1.NO1 > T2.NO2 (+) 
ORDER BY T1.CDATE, T1.NO1;   -- ��� Ȯ���� ���� �ϱ� ���� �ӽ÷� ���� �߰�

--��� 2 : t2 ���� ROWNUM-1 ���� ����
SELECT *
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE T1.NO1 > T2.NO2 
ORDER BY T1.CDATE, T1.NO1;   -- ��� Ȯ���� ���� �ϱ� ���� �ӽ÷� ���� �߰�


-- ��� Ȯ���� ���� �ϱ� ���� "D-1 ����", "D-1 ȯ��" .. �� ���� ����Ѵ� 
SELECT T1.CDATE AS ����, T1.AMT AS �ݾ�, T1.CRATE AS ����ȯ��,
       ( CASE WHEN T2.NO2 = T1.NO1 -2  THEN  T2.CDATE END ) "D-1 ����",
       ( CASE WHEN T2.NO2 = T1.NO1 -2  THEN  T2.CRATE END ) "D-1 ȯ��",
       ( CASE WHEN T2.NO2 = T1.NO1 -3  THEN  T2.CDATE END ) "D-2 ����",
       ( CASE WHEN T2.NO2 = T1.NO1 -3  THEN  T2.CRATE END ) "D-2 ȯ��",
       ( CASE WHEN T2.NO2 = T1.NO1 -4  THEN  T2.CDATE END ) "D-3 ����",
       ( CASE WHEN T2.NO2 = T1.NO1 -4  THEN  T2.CRATE END ) "D-3 ȯ��"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE T1.NO1 > T2.NO2
ORDER BY ����;

/* ���� ����� T1.CDATE, T1.AMT, T1.CRATE �� GROUP BY �Ѵ�. 

   ( null ������ + DATA 1�� ) 
   �̷� ��쿡�� SUM, MAX, MIN, AVG �Լ� �� �ƹ��ų� �ᵵ
   ���� ����� ���´�.
   COUNT �� �ȵ� : ���� 1 �� ��µȴ�.

   < ����Ŭ 22 �� ����>   */

SELECT T1.CDATE AS ����, T1.AMT AS �ݾ�, T1.CRATE AS ����ȯ��,
       AVG( CASE WHEN T2.NO2 = T1.NO1 -2  THEN  T2.CDATE END ) "D-1 ����",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -2  THEN  T2.CRATE END ) "D-1 ȯ��",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -3  THEN  T2.CDATE END ) "D-2 ����",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -3  THEN  T2.CRATE END ) "D-2 ȯ��",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -4  THEN  T2.CDATE END ) "D-3 ����",
       AVG( CASE WHEN T2.NO2 = T1.NO1 -4  THEN  T2.CRATE END ) "D-3 ȯ��"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE T1.NO1 > T2.NO2
GROUP BY T1.CDATE, T1.AMT, T1.CRATE
ORDER BY ����;


-- å�� ���� ��� ��� �� / �׷�ȭ ���� ����
SELECT T1.CDATE AS ����, T1.AMT AS �ݾ�, T1.CRATE AS ����ȯ��,
     ( CASE WHEN T2.NO2 = T1.NO1-2  THEN T2.CRATE END ) "D-1" ,
     ( CASE WHEN T2.NO2 = T1.NO1-3  THEN T2.CRATE END ) "D-2" ,
     ( CASE WHEN T2.NO2 = T1.NO1-4  THEN T2.CRATE END ) "D-3" ,
     ( CASE WHEN T2.NO2 = T1.NO1-5  THEN T2.CRATE END ) "D-4" ,
     ( CASE WHEN T2.NO2 = T1.NO1-6  THEN T2.CRATE END ) "D-5" ,
     ( CASE WHEN T2.NO2 = T1.NO1-7  THEN T2.CRATE END ) "D-6"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE t1.no1 > t2.no2
ORDER BY ����;

-- ���� (1) : T2 ���� ROWNUM-1 
SELECT T1.CDATE AS ����, T1.AMT AS �ݾ�, T1.CRATE AS ����ȯ��,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-2  THEN T2.CRATE END ) ) "D-1" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-3  THEN T2.CRATE END ) ) "D-2" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-4  THEN T2.CRATE END ) ) "D-3" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-5  THEN T2.CRATE END ) ) "D-4" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-6  THEN T2.CRATE END ) ) "D-5" ,
    MIN( ( CASE WHEN T2.NO2 = T1.NO1-7  THEN T2.CRATE END ) ) "D-6"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE t1.no1 > t2.no2
GROUP BY T1.NO1, T1.CDATE, T1.AMT , T1.CRATE
ORDER BY ����;

--����(2) : OUTER JOIN �߰� => �� ��� CASE ������ �� �ִ� ���� ����
SELECT T1.CDATE AS ����, T1.AMT AS �ݾ�, T1.CRATE AS ����ȯ��,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-1  THEN T2.CRATE END ) ) "D-1" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-2  THEN T2.CRATE END ) ) "D-2" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-3  THEN T2.CRATE END ) ) "D-3" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-4  THEN T2.CRATE END ) ) "D-4" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-5  THEN T2.CRATE END ) ) "D-5" ,
    MAX( ( CASE WHEN T2.NO2 = T1.NO1-6  THEN T2.CRATE END ) ) "D-6"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE t1.no1 > t2.no2 (+)
GROUP BY T1.NO1, T1.CDATE, T1.AMT , T1.CRATE
ORDER BY ����;

--����(3) : �׷�ȭ ���� ������ �ζ��� ��� ����� �� �׷�ȭ 
SELECT ����, �ݾ�, ����ȯ��, 
       SUM("D-1") AS "D-1", SUM("D-2") AS "D-2", 
       SUM("D-3") AS "D-3", SUM("D-4") AS "D-4", 
       SUM("D-5") AS "D-5", SUM("D-2") AS "D-6" 
FROM          
( SELECT T1.CDATE AS ����, T1.AMT AS �ݾ�, T1.CRATE AS ����ȯ��,
     ( CASE WHEN T2.NO2 = T1.NO1-2  THEN T2.CRATE END ) "D-1" ,
     ( CASE WHEN T2.NO2 = T1.NO1-3  THEN T2.CRATE END ) "D-2" ,
     ( CASE WHEN T2.NO2 = T1.NO1-4  THEN T2.CRATE END ) "D-3" ,
     ( CASE WHEN T2.NO2 = T1.NO1-5  THEN T2.CRATE END ) "D-4" ,
     ( CASE WHEN T2.NO2 = T1.NO1-6  THEN T2.CRATE END ) "D-5" ,
     ( CASE WHEN T2.NO2 = T1.NO1-7  THEN T2.CRATE END ) "D-6"
FROM 
    ( SELECT ROWNUM as no1, CDATE, AMT, CRATE FROM test02 ) t1,
    ( SELECT ROWNUM-1 as no2, CDATE, AMT, CRATE FROM test02 ) t2
WHERE t1.no1 > t2.no2 )
GROUP BY ����, �ݾ�, ����ȯ��;

--------------------------------------------------------------------------

--����Ŭ p267 8-2�� : LAG(), LEAD() ���

SELECT CDATE, AMT, 
    LAG(CDATE,1) OVER (ORDER BY CDATE DESC) "D+1 ����", 
    LAG(CRATE,1) OVER (ORDER BY CDATE DESC) "D+1 ȯ��",
    LAG(CDATE,2) OVER (ORDER BY CDATE DESC) "D+2 ����", 
    LAG(CRATE,2) OVER (ORDER BY CDATE DESC) "D+2 ȯ��",
    LAG(CDATE,3) OVER (ORDER BY CDATE DESC) "D+3 ����", 
    LAG(CRATE,3) OVER (ORDER BY CDATE DESC) "D+4 ȯ��"
FROM TEST02
ORDER BY CDATE;


SELECT CDATE, AMT, 
    LEAD(CDATE,1) OVER (ORDER BY CDATE) "D+1 ����", 
    LEAD(CRATE,1) OVER (ORDER BY CDATE) "D+1 ȯ��",
    LEAD(CDATE,2) OVER (ORDER BY CDATE) "D+2 ����", 
    LEAD(CRATE,2) OVER (ORDER BY CDATE) "D+2 ȯ��",
    LEAD(CDATE,3) OVER (ORDER BY CDATE) "D+3 ����", 
    LEAD(CRATE,3) OVER (ORDER BY CDATE) "D+4 ȯ��"
FROM TEST02
ORDER BY CDATE;