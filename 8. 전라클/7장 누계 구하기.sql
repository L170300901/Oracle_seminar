-- p238~p249 (2) IN-LINE VIEW �̿� => �н���

---------------------------------------------------------------

--p235 �����ϱ� : �ε�ȣ ���� �̿�

SELECT * FROM TEST01;  -- A �÷� : 00001 ~ 01000, B�÷� : 1 ~ 1000 

/* TEST01 ���� ���� �� WHERE ���� �߰� 
  => T2 ���� T1 �� B ������ �۰ų� ���� ���� ��� 
  
   ��, T1.B �� 1  :  T2.B �� 1 ��   
                 2  :  1, 2   
                 3  :  1, 2, 3
                 4  :  1, 2, 3, 4  
                 ... �̷� ������ ��µȴ�.
                 
   ��� Ȯ���� ���� T1.A �� �����Ͽ���         */

SELECT *
FROM TEST01 T1 , TEST01 T2
WHERE T1.B >= T2.B  
ORDER BY T1.A;


/* ���� ����� T1.A, T1.B �� GROUP BY / SUM(T2.B) �߰��Ѵ� */
SELECT T1.A, T1.B, SUM(T2.B) AS ����
FROM TEST01 T1 , TEST01 T2
WHERE T1.B >= T2.B
GROUP BY T1.A, T1.B
ORDER BY T1.A;

/* �� ����� ����� ���ڵ��� ���� �����Ҽ��� ó�� �ð��� �ް��ϰ� �����Ѵ�
   �Ʒ� ������ 1���� 10000 ���� ���踦 ���Ѵ�. ���� �ɸ�   */
SELECT T1.A, T1.B, SUM(T2.B) AS ����
FROM ( SELECT LPAD(ROWNUM,6,'0') A, ROWNUM B 
       FROM DUAL 
       CONNECT BY LEVEL <=10000 ) T1 , 
     ( SELECT LPAD(ROWNUM,6,'0') A, ROWNUM B 
       FROM DUAL 
       CONNECT BY LEVEL <=10000 ) T2
WHERE T1.B >= T2.B
GROUP BY T1.A, T1.B
ORDER BY T1.A;


-------------------------------------------------------------

--p251 �����ϱ� : ���� Ǯ��

SELECT  * FROM A_TB;


SELECT  * FROM A_TB;

/* '200101' ~ '200112' 12���� �� �� �ϳ��� �Ű������� �Է¹����� 
    2001���� 1������ �Է¹��� �ޱ����� �������� ����ϴ� ���� �����̴�
    ���ǻ� �Ű����� ��� '200112' �� ����Ѵ�.
    '200101' �� �Ű������� �ٲٸ� ���ϴ� ��Ĵ�� ����� */

/* V_MON �� ������ ���� �Ű������� �Է¹޴� ���� ��ġ�Ѵ�.
   ���߿� V_MON ���� �׷�ȭ�Ͽ� A_OUT �� ���� ������ ����Ѵ�   */
    
 /* SUBSTR(Char, Position, Length) : Char ���ڿ��� Position ��ġ�κ��� 
                                     Length ���� ���ڸ� ����� ��ȯ

    LPAD(expr1, n, [expr2]) : expr1 �� n �ڸ���ŭ �÷��� ���ʿ� expr2 �� �ٿ� ��ȯ 
                              expr2 �� ���� ��� ���鹮�ڸ� ����           */   
                              
SELECT SUBSTR('200112',1,4) ||  -- '200112' �� 1��° �ڸ����� 4����, �� '2001' �� �о��
       LPAD(ROWNUM,2,'0')  -- ROWNUM �� 2�ڸ��� ���� ��, �� �ڸ��� '0'���� ä���
       AS V_MON            
FROM A_TB
WHERE ROWNUM < 
      TO_NUMBER(SUBSTR('200112',5,2)) + 1;  -- '200112' �� 5��° �ڸ����� 2����, 
                                            -- �� 12 �� �о ��
                                            -- ���ڷ� ��ȯ�ϰ� 1�� ���Ѵ�.

/* ���� ���忡�� �Ű������� ���� �������ں��� Ŭ ���, 
   ��µǴ� ����� ������ WHERE ������ �����Ѵ�. ( => WHERE ROWNUM < 0 )  
   �Ʒ� ������ �ζ��κ� A�� �ȴ�    */
--LEAST �Լ� : ���ڷ� �޴� ���� �� �ּڰ��� ��ȯ
SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON  --V_MON : ROWNUM ���� ����
FROM A_TB
WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  -- �Ű������� �������� �� �ؽ�Ʈ ������
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1  -- ���� �����ϴ� ���� ��ȯ
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END );


/* �Ű������� �Է¹޴� ���� ������ �о ��, 
   �ش翬���� ���� �� ��, 1������ 12�������� 
   A_TB ���̺��� �о���� ���� : �ζ��κ� B�� �ȴ�  */
SELECT * 
FROM A_TB
WHERE A_MON > SUBSTR('200112',1,4)   -- �ؽ�Ʈ ������� �������� �� '2001' �������� ���� ������
  AND A_MON <= SUBSTR('200112',1,4) || '12';  --�ش翬���� 12������ ������ ����� ���    

/* �ζ��κ� A, B �� Cartesian Product �Ѵ� */
SELECT *
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B


--���⼭ ���� ������ ����ϴ� ����� 2������ ����


--��� 1 (����) : Cartesian Product �� �ε�ȣ ���� �̿� 

/* ���� ���忡 1������ �Ű������� �ش� ������ ������ V_MON �� 
   A_TB ���̺��� A_MON ���� ũ�ų� ������ WHERE ������ �߰��Ѵ� */

SELECT *
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B
WHERE A.V_MON >= B.A_MON;


/* (���1) ���� : �� ������ A.V_MON ���� �׷�ȭ�ϰ� ���� &
                  A.V_MON �� SUM(B.A_OUT) �� �߰��Ѵ�  */
SELECT A.V_MON AS ��, SUM(B.A_OUT) AS ����
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B
WHERE A.V_MON >= B.A_MON
GROUP BY A.V_MON
ORDER BY ��;



/* ��� 2 : A_TB ���̺��� A_MON �� V_MON ���� �۰ų� ���� ��츸 A_OUT �� ��µ��� 
           CASE �Լ��� �߰��Ѵ�.  */
/* LEAST �Լ��� ����Ͽ� CASE �Լ���
  ( CASE LEAST( A.V_MON, B.A_MON ) WHEN B.A_MON THEN A_OUT END )  ���� 
  �� ���� �ִ�    */

SELECT A.V_MON , 
       B.A_MON ,  -- ��� Ȯ�� �� B.A_MON �� ���� ��
       ( CASE WHEN B.A_MON <= A.V_MON THEN A_OUT END) AS A_OUT
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B
ORDER BY A.V_MON, B.A_MON;     -- ��� Ȯ���� ���� ���� �߰�


/* (���2) ���� : �� ������ A.V_MON ���� �׷�ȭ�ϰ� ���� & 
                 SUM ( CASE �Լ� ) �������� �׷� �Լ��� �߰��Ѵ�  */
SELECT A.V_MON AS ��,
       SUM ( ( CASE WHEN B.A_MON <= A.V_MON THEN A_OUT END) ) AS ����
FROM                                              
( SELECT SUBSTR('200112',1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( '200112' , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN '200112' THEN TO_NUMBER(SUBSTR('200112',5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR('200112',1,4)   
  AND A_MON <= SUBSTR('200112',1,4) || '12' ) B
GROUP BY A.V_MON
ORDER BY ��;



/* ���� '200112' �� �Ű����� :mon ���� �ٲ� �� �����غ��� */
--��� 1
SELECT A.V_MON AS ��, SUM(B.A_OUT) AS ����
FROM                                              
( SELECT SUBSTR(:MON,1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( :MON , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN :MON THEN TO_NUMBER(SUBSTR(:MON,5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR(:MON,1,4)   
  AND A_MON <= SUBSTR(:MON,1,4) || '12' ) B
WHERE A.V_MON >= B.A_MON
GROUP BY A.V_MON
ORDER BY ��;


--��� 2
SELECT A.V_MON AS ��,
       SUM ( ( CASE WHEN B.A_MON <= A.V_MON THEN A_OUT END) ) AS ����
FROM                                              
( SELECT SUBSTR(:MON,1,4) || LPAD(ROWNUM,2,'0') AS V_MON
  FROM A_TB
  WHERE ROWNUM < 
    ( CASE LEAST( :MON , TO_CHAR(SYSDATE, 'RRRRMM') )  
      WHEN :MON THEN TO_NUMBER(SUBSTR(:MON,5,2)) + 1 
      WHEN TO_CHAR(SYSDATE, 'RRRRMM') THEN 0 END ) ) A,
( SELECT * 
  FROM A_TB
  WHERE A_MON > SUBSTR(:MON,1,4)   
  AND A_MON <= SUBSTR(:MON,1,4) || '12' ) B
GROUP BY A.V_MON
ORDER BY ��;


---------------------------------------------------------------------------------

--p255 ���� 07-1 : ���� ���ϱ�

SELECT T1.A , T1.B, SUM(T2.B)
FROM TEST01 T1 , TEST01 T2
WHERE T1.B >= T2.B AND T1.B BETWEEN 901 AND 1000
GROUP BY T1.A , T1.B
ORDER BY T1.A , T1.B;
