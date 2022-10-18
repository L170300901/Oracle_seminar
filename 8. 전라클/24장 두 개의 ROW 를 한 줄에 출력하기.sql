--p475 �����ϱ� : �� RECORD �� �� �ٿ� �����ֱ�

-- (å�� Ǯ��)
-- TEMP ���� R_CNT (ROWNUM), ���ID (EMP_ID), ����� (EMP_NAME) ���
-- ���� ����� Ȯ���� ���ĵǵ��� ORDER BY EMP_ID �� �߰�
SELECT * FROM TEMP;

SELECT ROWNUM AS R_CNT, EMP_ID AS ���ID, EMP_NAME AS ����� 
FROM TEMP 
ORDER BY EMP_ID;

/*���� ����� FROM ���� �ζ��κ�� �Ͽ� 
  ���� ( CASE �Լ� ), ���ID, ������� �߰��Ѵ�    */

/*  ROWNUM �� R_CNT �� 2�� ���� �������� ,

       1 => R_CNT �� Ȧ�� =>  �״�� ��� (Ȧ��)
       2�� ���� �������� 0 => R_CNT �� ¦�� =>  R_CNT - 1 ��� (Ȧ��)  

    ������ 1 , 1 , 3 , 3 , 5 , 5 , ... �� ���� Ȧ���� 2���� ��µȴ�
    ���������� ���߿� GROUP BY => �� ���ڵ带 �� �׷����� ���´�    */

SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                           WHEN 0 THEN R_CNT-1 END ) AS ���� ,
       ���ID , �����
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS ���ID, EMP_NAME AS ����� 
       FROM TEMP 
       ORDER BY EMP_ID );



/* ���ID, ������� CASE �Լ��� ���� ��µǵ��� ���� ����� �����Ѵ�.
   R_CNT �� Ȧ��, �� MOD(R_CNT,2) = 1 �� �� ���ID1, �����1 ��,
   R_CNT �� ¦��, �� MOD(R_CNT,2) = 0 �� �� ���ID2, �����2 �� ��µǵ��� �Ѵ�.  */
SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                           WHEN 0 THEN R_CNT-1 END ) AS ���� ,
       ( CASE MOD(R_CNT,2) WHEN 1 THEN ���ID END ) AS ���ID1 ,
       ( CASE MOD(R_CNT,2) WHEN 1 THEN ����� END ) AS �����1 ,
       ( CASE MOD(R_CNT,2) WHEN 0 THEN ���ID END ) AS ���ID2 ,
       ( CASE MOD(R_CNT,2) WHEN 0 THEN ����� END ) AS ����� 2
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS ���ID, EMP_NAME AS ����� 
       FROM TEMP 
       ORDER BY EMP_ID );



/* ���� ������ 
   ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                       WHEN 0 THEN R_CNT-1 END ) �� �׷�ȭ�ϰ� �����Ѵ�.
   GROUP BY ���� => �ȵ� ( �ζ��κ並 ���� �ʴ� �� .. )
   ORDER BY ���� => ��
   �׷��Լ��� MIN, MAX �ƹ� �ų� �����ϴ�   */

SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                           WHEN 0 THEN R_CNT-1 END ) AS ���� ,  --��� ��� Ȯ�� �� ���� ��
       MAX( ( CASE MOD(R_CNT,2) WHEN 1 THEN ���ID END ) ) AS ���ID1 ,
       MAX( ( CASE MOD(R_CNT,2) WHEN 1 THEN ����� END ) ) AS �����1 ,
       MAX( ( CASE MOD(R_CNT,2) WHEN 0 THEN ���ID END ) ) AS ���ID2 ,
       MAX( ( CASE MOD(R_CNT,2) WHEN 0 THEN ����� END ) ) AS �����2
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS ���ID, EMP_NAME AS ����� 
       FROM TEMP 
       ORDER BY EMP_ID )  --���⸦ ����� ������� �� ��
GROUP BY  ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                              WHEN 0 THEN R_CNT-1 END )
ORDER BY ����;

/* ���� ������� �Ʒ� 4��° �ٿ� �ִ� ORDER BY EMP_ID �� ����� ����� ����
   ����� EMP_ID ������ ��µ��� �ʴ� ���� �� �� �ִ�.. ( 100% �� �ƴ� )

   å������ ORDER BY EMP_ID ��� WHERE EMP_ID > 0 �� �ᵵ �ȴٰ� �����ִ�
   WHERE EMP_ID > 0 ���ǵ� ������ ���ִ� ��..  */



--(��ü Ǯ��) Cartesian Product �� WHERE �������� ���ϴ� ���ڵ常 ����ϱ�

SELECT A.����, A.���ID AS ���ID1, A.����� AS �����1, 
       B.����, B.���ID AS ���ID2, B.����� AS �����2
FROM 
( SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                             WHEN 0 THEN R_CNT-1 END ) AS ���� ,
          ���ID , �����
  FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS ���ID, EMP_NAME AS ����� 
         FROM TEMP 
         ORDER BY EMP_ID ) ) A , 
( SELECT ( CASE MOD(R_CNT,2) WHEN 1 THEN R_CNT 
                             WHEN 0 THEN R_CNT-1 END ) AS ���� ,
          ���ID , �����
  FROM ( SELECT ROWNUM AS R_CNT, EMP_ID AS ���ID, EMP_NAME AS ����� 
         FROM TEMP 
         ORDER BY EMP_ID ) ) B
WHERE A.���� = B.���� AND A.���ID < B.���ID;

-----------------------------------------------------------------------------------

--p481 �����ϱ� : �� ���� ROW �� ���ٿ� 

SELECT * FROM TEST27;  --12�� ���ڵ� ��� : A001 4��, A002 4��, A003 4��

SELECT * FROM TEST27 A, TEST27 B;  -- Cartesian Product : 12 X 12 = 144 �� ���

/* A.TYPE_CD �� B.TYPE_CD ���� �۾ƾ� �Ѵ�.
   å���� ���ϴ� ����ʹ� �ٸ����� ������ ���� WHERE ������ �� �� �ִ�.  */
SELECT * 
FROM TEST27 A, TEST27 B
WHERE A.KEY1 = B.KEY1
  AND A.TYPE_CD < B.TYPE_CD;    -- 18�� ���ڵ� ��� 

/* A.TYPE_CD �� B.TYPE_CD ���� 1��ŭ �۾ƾ� �Ѵ�.
  WHERE AND A.TYPE_CD < B.TYPE_CD 
     AND A.TYPE_CD + 1 = B.TYPE_CD      
  �̷��� WHERE ������ �� ���� ������, ��� ó�� WHERE ������ �ʿ���� */

SELECT * 
FROM TEST27 A, TEST27 B
WHERE A.KEY1 = B.KEY1 
  AND A.TYPE_CD < B.TYPE_CD   --�� ������ �����ص� ��. �Ʒ� �������� ���
  AND A.TYPE_CD + 1 = B.TYPE_CD;

/* �� ������ ������� ��, ������ �� ���ڵ尡 ���ĵǾ� ���� ������ �� �� �ִ�
  �̸� �ذ��ϴ� ����� ũ�� 2����..  */

--(1) �ܼ��ϰ� �������� ORDER BY ~ �߰�
SELECT *   -- ���⿡�� �Ȱ��� �̸��� �÷��� ���� 2���� �ִ�
FROM TEST27 A, TEST27 B
WHERE A.KEY1 = B.KEY1 
  AND A.TYPE_CD + 1 = B.TYPE_CD
ORDER BY A.KEY1, A.TYPE_CD;  --�ܼ��� KEY1, TYPE_CD �� �ϸ� "���� ���ǰ� �ָ��մϴ�" ���� ���


--(2) FROM ���� �ζ��κ�� �����ϰ� WHERE KEY1 > ' ' ���� �߰�
SELECT *   -- ���⿡�� �Ȱ��� �̸��� �÷��� ���� 2���� �ִ�
FROM ( SELECT * FROM TEST27 WHERE KEY1 > ' ' ) A , 
     ( SELECT * FROM TEST27 WHERE KEY1 > ' ' ) B
WHERE A.KEY1 = B.KEY1 
  AND A.TYPE_CD + 1 = B.TYPE_CD;

/* KEY1 �� �ؽ�Ʈ �÷� : WHERE KEY1 > ' ' �̶�� ������ �������� �־���.
   �� �������� ���� ���̺��� SCAN ����� �ٲ�ٰ� å�� ���� */
/* WHERE KEY1 > ' ' ��� ORDER BY KEY1 ���� �����ϸ�
   �������� ��� ����� ���ĵ��� �ʴ´�                    */