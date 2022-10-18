--p219 �����ϱ� : ���� Ǯ��
SELECT * FROM SAM_TAB02;

-- ROWNUM �߰� : ��Ī NO
SELECT ROWNUM AS NO, 
       GUBUN 
FROM SAM_TAB02;

--CEIL �Լ� �߰� => CEIL (n) : n ���� ũ�ų� ���� ���� ū ������ ��ȯ
--���ڵ带 4���� ���� : ���� ����� �� ��° �࿡ ��µ����� �����Ѵ�  
SELECT CEIL(ROWNUM/4) AS RNO, -- 1 �� 4��, 2 �� 4��, 3 �� 4�� ... ������ ���� ���ڰ� 4���� ���
       ROWNUM AS NO, 
       GUBUN 
FROM SAM_TAB02;

--MOD �Լ� �߰� => MOD (n1, n2) : n1 �� n2 �� ���� �������� ��ȯ
/* ��������� �� �� �ȿ��� �� ��° �÷��� ��µ����� �����Ѵ�
   MOD(ROWNUM,4) �� 1 �̸� ù��° �÷� , 2 �̸� �ι�° �÷�,
                             3�̸� ����° �÷�, 0�̸� 4��° �÷��� ��µȴ� */
SELECT CEIL(ROWNUM/4) AS RNO, 
       MOD(ROWNUM,4) AS CNO,  -- 0, 1, 2, 3, ... �̰�� �ݺ��Ǿ� ���
       ROWNUM AS NO, 
       GUBUN 
FROM SAM_TAB02;

--ROWNUM �� ���� �ʿ�����Ƿ� ����, GUBUN �� CASE �Լ��� ���� ��µǹǷ� ���� ����
--���� CASE �Լ� �߰�
SELECT CEIL(ROWNUM/4) AS RNO, 
       MOD(ROWNUM,4) AS CNO,  -- 1, 2, 3, 0 ... �� ��� �ݺ��Ǿ� ���
       ( CASE MOD(ROWNUM,4)  WHEN 1 THEN GUBUN END ) AS C1,
       ( CASE MOD(ROWNUM,4)  WHEN 2 THEN GUBUN END ) AS C2,
       ( CASE MOD(ROWNUM,4)  WHEN 3 THEN GUBUN END ) AS C3,
       ( CASE MOD(ROWNUM,4)  WHEN 0 THEN GUBUN END ) AS C4
FROM SAM_TAB02;

--���� CNO �÷��� �ʿ�����Ƿ� ����. ���� ����� CEIL(ROWNUM/4) �� GROUP BY �ϰ� �����Ѵ�
/* GROUP BY �� ( �Ѱ��� GUBUN �� ) + ( �� ���� NULL ) => ( �Ѱ��� GUBUN �� ) ���� ��µȴ�
   �� ��� NULL�� Ư���� �׷��Լ��� MAX, MIN ��� �����ϴ�  <����Ŭ 22�� ����>   */
SELECT CEIL(ROWNUM/4) AS RNO, 
       MIN( ( CASE MOD(ROWNUM,4)  WHEN 1 THEN GUBUN END ) ) AS C1,
       MIN( ( CASE MOD(ROWNUM,4)  WHEN 2 THEN GUBUN END ) ) AS C2,
       MIN( ( CASE MOD(ROWNUM,4)  WHEN 3 THEN GUBUN END ) ) AS C3,
       MIN( ( CASE MOD(ROWNUM,4)  WHEN 0 THEN GUBUN END ) ) AS C4
FROM SAM_TAB02
GROUP BY CEIL(ROWNUM/4)
ORDER BY RNO;

--���� �ܰ��� ������ FROM ���� �ζ��κ�� �Ͽ� ������ ���� �ص� ����� ����.
SELECT RNO, MAX(C1), MAX(C2), MAX(C3), MAX(C4)
FROM
( SELECT CEIL(ROWNUM/4) AS RNO, 
       ( CASE MOD(ROWNUM,4)  WHEN 1 THEN GUBUN END ) AS C1,
       ( CASE MOD(ROWNUM,4)  WHEN 2 THEN GUBUN END ) AS C2,
       ( CASE MOD(ROWNUM,4)  WHEN 3 THEN GUBUN END ) AS C3,
       ( CASE MOD(ROWNUM,4)  WHEN 0 THEN GUBUN END ) AS C4
  FROM SAM_TAB02 )
GROUP BY RNO
ORDER BY RNO;

/* ���� ����� SAM_TAB02 �� ���ڵ尡 �� ���� �����Ƿ� 
   ó���� �����͸� �ҷ��� �� ���� ������ �ʿ�� ������. 
   �׷��� �������� ������ ���ٸ� GUBUN ���� ���ĵ��� �ʰ� ��µ� �� �ִ�
   �̷� ��� SAM_TAB02 �� �ζ��κ�� �� �ʿ䰡 ����� */
SELECT RNO, MAX(C1), MAX(C2), MAX(C3), MAX(C4)
FROM
( SELECT CEIL(ROWNUM/4) AS RNO, 
       ( CASE MOD(ROWNUM,4)  WHEN 1 THEN GUBUN END ) AS C1,
       ( CASE MOD(ROWNUM,4)  WHEN 2 THEN GUBUN END ) AS C2,
       ( CASE MOD(ROWNUM,4)  WHEN 3 THEN GUBUN END ) AS C3,
       ( CASE MOD(ROWNUM,4)  WHEN 0 THEN GUBUN END ) AS C4
  FROM ( SELECT ROWNUM, GUBUN
         FROM SAM_TAB02 
         ORDER BY GUBUN ) )  -- ó�� SAM_TAB02 �� �ҷ��� �� GUBUN ������ ����
GROUP BY RNO
ORDER BY RNO;

/* ���� ���� �ζ��κ並 ���� �� ����ؾ� �� ���� �ִ�.
  �ڵ�� ���������, ������ ���� ��Ʈ���� �� �ְ�
  �������ٵ� ó�� ���̺��� �о�� �� �ڷ��� ������ ������ �� �ֱ� ������
  �������� ������ ���ٸ� ó�� �ӵ��� ����� ����� �� �ִ�.. �� �Ѵ�.  */
  
-------------------------------------------------------------------------
--p224 ���� 06-1 : ROW ������ COLUMN ������
SELECT EMP_ID, EMP_NAME 
FROM TEMP;

--ROWNUM �߰� : ����غ��� EMP_ID �� ���ĵǾ� ���� �ʴ�
SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
FROM TEMP;

--ORDER BY EMP_ID : EMP_ID ������ ���ĵǰ� ROWNUM �� ������� �ٽ� �Ű�����
SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
FROM TEMP
ORDER BY EMP_ID;

/* �츮�� ���ϴ� ������� ���ĵǾ����� Ȯ���Ͽ���
   ���� ����� FROM ���� �ζ��κ�� �Ͽ� CEIL �Լ�, MOD �Լ�, ���ID, ����� �߰�  */
--5���� �� �࿡ ��� : CEIL(NO/5) , MOD(NO,5) �� �ȴ�
SELECT CEIL(NO/5) AS RNO, 
       MOD(NO,5) AS CNO, 
       EMP_ID AS ���ID, 
       EMP_NAME AS �����
FROM 
( SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
  FROM TEMP
  ORDER BY EMP_ID );

--å�� �ٸ��� Ǯ�� : ���� ����� �ζ��κ�� ���� �� RNO, CASE �Լ� �߰�
--(�߿�!!) �ζ��κ並 ���� ���, �ٱ��� SELECT ���忡�� ��Ī�� ����!!
SELECT RNO, 
       ( CASE CNO WHEN 1 THEN ���ID END ) AS ID1,
       ( CASE CNO WHEN 1 THEN ����� END ) AS NAME1,
       ( CASE CNO WHEN 2 THEN ���ID END ) AS ID2,
       ( CASE CNO WHEN 2 THEN ����� END ) AS NAME2,
       ( CASE CNO WHEN 3 THEN ���ID END ) AS ID3,
       ( CASE CNO WHEN 3 THEN ����� END ) AS NAME3,
       ( CASE CNO WHEN 4 THEN ���ID END ) AS ID4,
       ( CASE CNO WHEN 4 THEN ����� END ) AS NAME4,
       ( CASE CNO WHEN 0 THEN ���ID END ) AS ID5,
       ( CASE CNO WHEN 0 THEN ����� END ) AS NAME5 
FROM
( SELECT CEIL(NO/5) AS RNO, MOD(NO,5) AS CNO, 
         EMP_ID AS ���ID, EMP_NAME AS �����
  FROM 
  ( SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
    FROM TEMP
    ORDER BY EMP_ID ) );
    
/* ���� ����� RNO �� GROUP BY �ϰ� �׷��Լ��� �߰��ϰ� RNO ������ �����Ѵ�
    ID1 , ID2 .. �� ������� ������ �̷�������� �� �� �ִ�  */
SELECT RNO, 
       MAX( ( CASE CNO WHEN 1 THEN ���ID END ) ) AS ID1,
       MAX( ( CASE CNO WHEN 1 THEN ����� END ) ) AS NAME1,
       MAX( ( CASE CNO WHEN 2 THEN ���ID END ) ) AS ID2,
       MAX( ( CASE CNO WHEN 2 THEN ����� END ) ) AS NAME2,
       MAX( ( CASE CNO WHEN 3 THEN ���ID END ) ) AS ID3,
       MAX( ( CASE CNO WHEN 3 THEN ����� END ) ) AS NAME3,
       MAX( ( CASE CNO WHEN 4 THEN ���ID END ) ) AS ID4,
       MAX( ( CASE CNO WHEN 4 THEN ����� END ) ) AS NAME4,
       MAX( ( CASE CNO WHEN 0 THEN ���ID END ) ) AS ID5,
       MAX( ( CASE CNO WHEN 0 THEN ����� END ) ) AS NAME5 
FROM
( SELECT CEIL(NO/5) AS RNO, MOD(NO,5) AS CNO, EMP_ID AS ���ID, EMP_NAME AS �����
  FROM 
  ( SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
    FROM TEMP
    ORDER BY EMP_ID ) )
GROUP BY RNO
ORDER BY RNO;

/* �ƴϸ� GROUP BY ������ ������ �ٽ� �ζ��κ�� ���� �Ŀ� �׷�ȭ�� ���� �ִ� 
   �ζ��κ� �ȿ����� ��Ī�� �ٱ� SELECT ���� ��Ī�� �����ϰ� �Ͽ���  
   �׷��Լ��� MIN, MAX ��� ���� ����ص� ����� ����  */
SELECT RNO, MIN(ID1) AS ID1, MIN(NAME1) AS NAME1, 
       MIN(ID2) AS ID2, MIN(NAME2) AS NAME2, 
       MIN(ID3) AS ID3, MIN(NAME3) AS NAME3, 
          MIN(ID4) AS ID4, MIN(NAME4) AS NAME4
FROM
( SELECT RNO, 
         ( CASE CNO WHEN 1 THEN ���ID END ) AS ID1,
         ( CASE CNO WHEN 1 THEN ����� END ) AS NAME1,
         ( CASE CNO WHEN 2 THEN ���ID END ) AS ID2,
         ( CASE CNO WHEN 2 THEN ����� END ) AS NAME2,
         ( CASE CNO WHEN 3 THEN ���ID END ) AS ID3,
         ( CASE CNO WHEN 3 THEN ����� END ) AS NAME3,
         ( CASE CNO WHEN 4 THEN ���ID END ) AS ID4,
         ( CASE CNO WHEN 4 THEN ����� END ) AS NAME4,
         ( CASE CNO WHEN 0 THEN ���ID END ) AS ID5,
         ( CASE CNO WHEN 0 THEN ����� END ) AS NAME5 
FROM
( SELECT CEIL(NO/5) AS RNO, MOD(NO,5) AS CNO, 
         EMP_ID AS ���ID, EMP_NAME AS �����
  FROM 
  ( SELECT ROWNUM AS NO, EMP_ID, EMP_NAME 
    FROM TEMP
    ORDER BY EMP_ID ) ) )  -- �ζ��κ� => SELECT ~ FROM ( GROUP BY ������ ���� ) ...
GROUP BY RNO
ORDER BY RNO;

----------------------------------------------------------------
--p228 �����ϱ� : ���� Ǯ��

--ROWNUM �� CNT �÷��� 1 ~ 4 ����ϴ� ���� : x4 ������ ���
SELECT ROWNUM AS CNT 
FROM DUAL 
CONNECT BY LEVEL <= 4;   --DUAL ���̺� / ������ ���� �̿�

SELECT ROWNUM AS CNT 
FROM USER_TABLES 
WHERE ROWNUM <=4;  --USER_TABLES ���̺� ���

SELECT ROWNUM AS CNT 
FROM TEST01 
WHERE ROWNUM <=4;  --PR ��Ű���� TEST01 ��� : ���ڵ� 1000��

SELECT ROWNUM AS CNT 
FROM TEST11 
WHERE ROWNUM <=4;  --�ǽ��� ����� TEST11 ���̺� �ڽ��� ���


--Cartesian Product : TEST11 ���̺��� ��� ���ڵ带 x4 ����
SELECT * 
FROM TEST11, 
    ( SELECT ROWNUM AS CNT 
      FROM USER_TABLES 
      WHERE ROWNUM < 5);  --DEPT �� ������ ���� x4 ������ ���� �� �� �ִ�

/* CNT 1 : '1�г�' , 1�г� �л��� (FRE) �� ���
   CNT 2 : '2�г�' , 2�г� �л��� (SUP)
   ... �̷� ������ ó���Ѵ�

   CASE �Լ��� �߰��Ͽ� ������ ���ڵ忡�� �г�� �л����� ��µǵ��� �Ѵ�  
   �������� COLL (����), DEPT (�а�) KEY3 (�г�) ������ ���� �߰�*/

/* '�г�' �÷��� KEY3 �� ����� ������, 
   �⺻������ ���̺��� ������ ���ڵ�� �ڱ� �ڽ��� �ǹ��ϴ� 
   Unique �� ��, �� KEY �� ������ �Ѵ�.

   ������ ���̺� TEST11 ������ COLL �� DEPT �� �����ϴ� ���� �����ߴ�
     ex) '��������' , '�װ����ְ��а�' => ���� 1���� ���ڵ常 ����

   �׷��� ������ ���̺����� ������ COLL �� DEPT ���� 4�� �����ϰ� �ȴ�

   ������ COLL (KEY1), DEPT (KEY2) �� �г� (KEY3) �� �߰��ϸ� 
   ������ ���ڵ尡 Ȯ���� ���еȴ�.  */ 

SELECT COLL AS ����, DEPT AS �а�,
       ( CASE CNT WHEN 1 THEN '1�г�' 
                  WHEN 2 THEN '2�г�'
                  WHEN 3 THEN '3�г�'
                  WHEN 4 THEN '4�г�' END ) AS KEY3,
       ( CASE CNT WHEN 1 THEN FRE 
                  WHEN 2 THEN SUP
                  WHEN 3 THEN JUN
                  WHEN 4 THEN SEN END ) AS �л���          
FROM TEST11, 
    ( SELECT ROWNUM AS CNT 
      FROM USER_TABLES 
      WHERE ROWNUM < 5)
ORDER BY ����, �а�, KEY3;

----------------------------------------------------------------
--p230 ���� 06-2 : ROW ������ COLUMN ������

/* ������ ���ڵ带 x2 ���� : CNT1 �� '1, 2�г�' ,
                           CNT2 �� '3, 4�г�' ��¿� ���ȴ� 
   CNT1 => KEY3 �� '1, 2�г�', 
           C1 �� 1�г� �л��� (FRE)
           C2 �� 2�г� �л��� (SUP)    
   CNT3 => KEY3 �� '3, 4�г�', 
           C1 �� 3�г� �л��� (JUN)
           C2 �� 4�г� �л��� (SEN)    
��������� C1 �÷��� 1 or 3�г� �л�����,
          C2 �÷��� 2 or 4�г� �л����� ����ϰ� �ȴ�  */         

--���� ������� x2 ���� / CASE �Լ� ����
SELECT COLL AS ����, DEPT AS �а�,
       ( CASE CNT WHEN 1 THEN '1, 2�г�' 
                  WHEN 2 THEN '3, 4�г�' END ) AS KEY3,
       ( CASE CNT WHEN 1 THEN FRE 
                  WHEN 2 THEN JUN END ) AS "C1 (1 or 3�г� �л���)",     
       ( CASE CNT WHEN 1 THEN SUP 
                  WHEN 2 THEN SEN END ) AS "C2 (2 or 4�г� �л���)"               
FROM TEST11, 
    ( SELECT ROWNUM AS CNT 
      FROM USER_TABLES 
      WHERE ROWNUM < 3 )
ORDER BY ����, �а�, KEY3;
