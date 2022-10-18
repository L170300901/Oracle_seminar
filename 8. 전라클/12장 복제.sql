SELECT * FROM TEST06;

SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13;

/* TEST06 �ζ��κ� A, 1~12 ������ ROWNUM�� �ζ��κ� B �� �����Ѵ�
   WHERE ���ǿ� ���� TEST06 ���̺��� YMD �� 1���̸� B���̺��� 1~12, 
   2���� 2~12, 3���� 3~12  .. �̷� ������ ���εȴ�   */
SELECT *
FROM TEST06 A, 
  ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE B.R_CNT >= TO_CHAR(TO_DATE(A.YMD),'MM');

--å�� �ι�° ���, ��� Ȯ�� ���� ��������
SELECT B.R_CNT, A.YMD, A.LEASE, 
       LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || 
                LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS ���ڰ����
FROM TEST06 A, 
   ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
      LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || 
               LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM'))
ORDER BY A.YMD, B.R_CNT;  

/* ������� ����     ������     => ���� ���� �� : ���� ���� ��ȯ
 ex) 2001/01/15   2001/01/31                        16
-- ������� ����     ������     => �ٸ��� �� �� : ���ڰ������ ������ ���� ��ȯ
 ex) 2001/01/15   2001/02/28                               28           */
SELECT B.R_CNT, A.YMD, A.LEASE, 
    LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS ���ڰ����,
    ( CASE WHEN TO_CHAR(TO_DATE(A.YMD),'MM') = LPAD(TO_CHAR(B.R_CNT),2,'0')
           THEN LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM'))
                - TO_DATE(A.YMD) 
           ELSE TO_NUMBER ( TO_CHAR(   -- �������� CHAR ��ȯ �� NUMMBER ('DD') ��ȯ => ���ڿ��� �� ���� ��ȯ
                   LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')), 'DD'))
           END ) AS TERM
FROM TEST06 A, 
  ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
      LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM'))
ORDER BY A.YMD, B.R_CNT;    


--å��� �ϸ� �ʹ� ���������Ƿ� ������
/* ������ ���ڵ� ���� 
   ���� �ݾ� (LEASE) * ���� ���� (TERM) / 365 * ������ (0.125) = "����" �� ���ȴ�.
   �����Ϻ��� GROUP BY �ϸ� SUM( (����) ) => ���������Ѿ��� �ȴ�   */ 
SELECT ������, SUM(LEASE*TERM/365*0.125) AS ���������Ѿ�
FROM
( SELECT B.R_CNT, A.YMD, A.LEASE, 
    LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS ������,
    ( CASE WHEN TO_CHAR(TO_DATE(A.YMD),'MM') = LPAD(TO_CHAR(B.R_CNT),2,'0')
           THEN LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM'))
                     - TO_DATE(A.YMD) 
           ELSE TO_NUMBER ( TO_CHAR(   -- �������� CHAR ��ȯ �� NUMMBER ('DD') ��ȯ => ���ڿ��� �� ���� ��ȯ
                LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')), 'DD'))
           END ) AS TERM
FROM TEST06 A, 
  ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
      LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) )
GROUP BY ������ 

--------------------------------------------------------------------------------------

--���� 12-1 : ������ �̿� => å�� �ٸ��� Ǯ������
SELECT R_CNT
FROM ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 )
WHERE R_CNT IN (3, 6, 9, 12);   --ROWNUM �� 3, 6, 9, 12 �� ��� => 3��, 6��, 9��, 12��


/* TO_CHAR( (��¥), 'Q') => �бⰪ 1, 2, 3, 4 �� �ϳ��� ��ȯ�Ѵ�  */

SELECT B.R_CNT, A.YMD, A.LEASE, 
    LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS ������,
--���� ���ڿ� �������� ���� �б��� �� : (������) - (��������) => ����Ⱓ
    ( CASE WHEN TO_CHAR(TO_DATE(A.YMD,'RRRRMMDD'),'Q') =
                TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')),'Q')
           THEN LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) 
                 - TO_DATE(A.YMD,'RRRRMMDD')  
--���� ���ڿ� �������� �ٸ� �б��� �� : ( ������ ) - ( ������ ���б��� ������ ���� ) = > ���� �Ⱓ
      ELSE LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) -
         ( CASE TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')),'Q')
           WHEN '2' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '03' ,'RRRRMM'))
           WHEN '3' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '06' ,'RRRRMM'))
           WHEN '4' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '09' ,'RRRRMM'))
           END )
    END )  AS TERM
FROM TEST06 A, 
  ( SELECT R_CNT FROM ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) 
    WHERE R_CNT IN (3, 6, 9, 12) ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
          LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) ;



--���� : ���� �ڵ带 �����Ϸ� �׷�ȭ
SELECT ������, SUM(LEASE*TERM/365*0.125) AS �б⺰�����Ѿ�
FROM
( SELECT B.R_CNT, A.YMD, A.LEASE, 
    LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) AS ������,
--���� ���ڿ� �������� ���� �б��� �� : (������) - (��������) => ����Ⱓ
    ( CASE WHEN TO_CHAR(TO_DATE(A.YMD,'RRRRMMDD'),'Q') =
                TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')),'Q')
           THEN LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) 
                 - TO_DATE(A.YMD,'RRRRMMDD')  
-- ( ������ ) - ( ������ ���б��� ������ ���� ) = > ���� �Ⱓ
      ELSE LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) -
         ( CASE TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')),'Q')
           WHEN '2' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '03' ,'RRRRMM'))
           WHEN '3' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '06' ,'RRRRMM'))
           WHEN '4' THEN LAST_DAY(TO_DATE( SUBSTR(A.YMD,1,4) || '09' ,'RRRRMM'))
           END )
    END )  AS TERM
FROM TEST06 A, 
  ( SELECT R_CNT FROM ( SELECT ROWNUM AS R_CNT FROM USER_TABLES WHERE ROWNUM < 13 ) 
    WHERE R_CNT IN (3, 6, 9, 12) ) B
WHERE TO_DATE(A.YMD,'RRRRMMDD') <= 
          LAST_DAY(TO_DATE(SUBSTR(A.YMD,1,4) || LPAD(TO_CHAR(B.R_CNT),2,'0'),'RRRRMM')) )
GROUP BY ������;      

-----------------------------------------------------------------------------------

--p330 �����ϱ� : �հ�� ���� ���
SELECT * FROM TEST35;

--p329 �� ����� �ִ��� �����ϰ� ��µǵ��� A, B �÷� �߰�
SELECT KEY1, KEY2,  -- KEY2 �� ��� Ȯ�� �� ���� ��
       ( CASE KEY2 WHEN 'A' THEN AMT END ) AS "A" ,
       ( CASE KEY2 WHEN 'B' THEN AMT END ) AS "B"
FROM TEST35;

/* ���� ���̺��� KEY1 ���� �׷�ȭ : �׷� �Լ��� MIN, MAX, SUM,, AVG �� �ƹ� �ų� ������� 
   p329 �� ����� ���� ���⼭ �ٷ� 
   MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) - MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) )
   �Ͽ� C �÷��� �߰��� ���� ������, ���� ����. ���߿� �� �� �ִµ� ���� ����������
   p329 �� ������ ���ڵ� , �� �հ踦 ���ϴµ� �����Ѵ�.   */

SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
             MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
FROM TEST35
GROUP BY KEY1;

-- ���� ����� x 2 ���� :  RNUM 1 �� �׳� DATA ���, RNUM 2 �� �� �հ踦 ���ϴµ� ����Ѵ�.
SELECT *
FROM 
( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
               MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
  FROM TEST35
  GROUP BY KEY1 ) , 
( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 );  -- ROWNUM 1, 2 

-- KEY1 �÷����� RNUM = 1 �� �� KEY1, 2 �� �� '�հ� ���ڿ��� ��µǵ��� CASE �Լ� �߰�
SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END ) AS "KEY1", A, B
FROM 
( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
               MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
  FROM TEST35
  GROUP BY KEY1 ) , 
( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 );

/* ���� ����� ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END ), 
   ��, KEY1 ���� GROUP BY �Ѵ�
   KEY1 �� ��µǴ� ���� 0001 ~ 0006 �� 1���� 6�� + '�հ�' 6�� �� 12��, 
   GROUP BY �� ��� �� 7���� �׷����� �������� 
    -- 0001 ~ 0006 6���� ���ڵ� => ���� 6���� �׷�
    -- '�հ�' 6�� ���ڵ� => �ϳ��� �׷�               

   0001 ~ 0006 ���ڵ�� ���� 1���� ���ڵ尡 ���� 1���� �׷��� �ȴ�
   ���� SUM(A) , SUM(B) �� �ص� �׳� ���� ���� ����Ѵ�
   
   �׷��� RNUM 2, �� KE1 �� '�հ�' �� 6���� ���ڵ忡�� ���� TEST35 �� �־���
   ���� DATE ���� �״�� �����Ǿ� �ִ�. 
   �� ��� SUM(A) , SUM(B) �� ��ü �հ� ���� ����Ѵ�    */

/* A�� B�� ����, �� C �÷��� �߰��Ѵ�. �÷� C �� SUM (A-B) �ص� ������� */

SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END ) AS "KEY1" , 
         SUM(A) AS "A" ,   
         SUM(B) AS "B" ,   
         ( SUM(A) - SUM(B) ) AS C  
FROM 
  ( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
                 MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
    FROM TEST35
    GROUP BY KEY1 ) , 
  ( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END )
ORDER BY KEY1;



/* ���� ������ �����ϸ� p331�� ������ ����� ��µȴ�. 
   ���⿡ C/A * 100 , �� PER �÷��� �߰��ϸ� ������. ����� 2����.
    (1) ��ü Ǯ�� : ���� ������� SELECT ���� �ٷ� PER �÷� �߰�
    (2) å��� Ǯ�� : ���� ����� FROM ���� �ζ��κ�� �Ͽ� PER �÷� �߰�
   �� ��� ��� �������� KEY1 ���� �����Ѵ�.  */

/* ����Ŭ p333 ���� : ��� (1) �� ���̺��� �� �� �� �о�� �Ѵٴ� ������ �ִٰ� �Ѵ�   */

--(1) ��ü Ǯ�� : ���� ������� PER �߰�
SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END ) AS "KEY1" , 
         SUM(A) AS "A" , SUM(B) AS "B", ( SUM(A) - SUM(B) ) AS "C" , 
         ROUND( 100 * ( SUM(A) - SUM(B) ) / SUM(A) ) AS "PER"  
FROM 
  ( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
                 MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
    FROM TEST35
    GROUP BY KEY1 ) , 
  ( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END )
ORDER BY KEY1;

--(2) å��� Ǯ�� : ���� ����� �ٽ� SELECT �ؼ� PER ���
SELECT KEY1, A, B, C, 
       ROUND(100*(A-B)/A) AS PER     --PER�÷� �߰�
FROM 
(  SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END ) AS "KEY1" , 
            SUM(A) AS "A" , SUM(B) AS "B", ( SUM(A) - SUM(B) ) AS C  
FROM 
  ( SELECT KEY1, MAX( ( CASE KEY2 WHEN 'A' THEN AMT END ) ) AS "A" ,
                 MAX( ( CASE KEY2 WHEN 'B' THEN AMT END ) ) AS "B"
    FROM TEST35
    GROUP BY KEY1 ) , 
  ( SELECT ROWNUM RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END )  )
ORDER BY KEY1;

-----------------------------------------------------------------------------

--p333 ���� 12-2 : �հ��� ���� ���
SELECT * FROM TEMP;

/* CASE �������� ���� NULL �� ��� 0 ���� ��µǵ��� �ؾ� ���Ŀ� �׷��Լ��� �� �� �ִ� 
   ��Ȯ���� SUM �Լ��� PER (����) ����� ���������� */
SELECT DEPT_CODE AS KEY1,
      ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
      ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
      ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
      ( CASE LEV WHEN '�븮' THEN SALARY ELSE 0 END ) AS "�븮",
      ( CASE LEV WHEN '���' THEN SALARY ELSE 0 END ) AS "���",
      ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����"
FROM TEMP; 

--���� ����� x 2 ���� : RNUM = 1 �� �� KEY1, 2 �� �� �հ�� ��µ�
SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END ) AS "KEY1" ,
       ����, ����, ����, �븮, ���, ����
FROM
( SELECT DEPT_CODE AS KEY1,
        ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
        ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
        ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
        ( CASE LEV WHEN '�븮' THEN SALARY ELSE 0 END ) AS "�븮",
        ( CASE LEV WHEN '���' THEN SALARY ELSE 0 END ) AS "���",
        ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����"
  FROM TEMP ), 
( SELECT ROWNUM AS RNUM FROM USER_TABLES WHERE ROWNUM < 3 );


--���� ����� KEY1 ���� �׷�ȭ�ϰ� ������ SUM �Լ� �߰�
SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END ) AS "KEY1" ,
      SUM(����) AS "����" , SUM(����) AS "����" , SUM(����) AS "����" ,
      SUM(�븮) AS "�븮" , SUM(���) AS "���" , SUM(����) AS "����" ,
      SUM(����+����+����+�븮+���+����) AS "��ü"
FROM
( SELECT DEPT_CODE AS KEY1,
        ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
        ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
        ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
        ( CASE LEV WHEN '�븮' THEN SALARY ELSE 0 END ) AS "�븮",
        ( CASE LEV WHEN '���' THEN SALARY ELSE 0 END ) AS "���",
        ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����"
  FROM TEMP ), 
( SELECT ROWNUM AS RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END )
ORDER BY KEY1;

--���� : ���� ����� �ζ��κ�� ���� PER �÷� �߰�
SELECT KEY1, ����, ����, ����, �븮, ���, ����,
       ROUND( 100 * ���� / ��ü ) AS PER
FROM
( SELECT ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END ) AS "KEY1" ,
         SUM(����) AS "����" , SUM(����) AS "����" , SUM(����) AS "����" ,
         SUM(�븮) AS "�븮" , SUM(���) AS "���" , SUM(����) AS "����" ,
         SUM(����+����+����+�븮+���+����) AS "��ü"
  FROM
  ( SELECT DEPT_CODE AS KEY1,
          ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
          ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
          ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����",
          ( CASE LEV WHEN '�븮' THEN SALARY ELSE 0 END ) AS "�븮",
          ( CASE LEV WHEN '���' THEN SALARY ELSE 0 END ) AS "���",
          ( CASE LEV WHEN '����' THEN SALARY ELSE 0 END ) AS "����"
    FROM TEMP ), 
  ( SELECT ROWNUM AS RNUM FROM USER_TABLES WHERE ROWNUM < 3 )
  GROUP BY ( CASE RNUM WHEN 1 THEN KEY1 WHEN 2 THEN '�հ�' END )
  ORDER BY KEY1 );