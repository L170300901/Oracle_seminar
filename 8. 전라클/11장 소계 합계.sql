--p307 �����ϱ�
SELECT * FROM TEST12;

--TEST12 �� ��� ���ڵ带 x 4 ����
SELECT *
FROM TEST12 A, 
     ( SELECT ROWNUM AS RCNT FROM TEST12 WHERE ROWNUM < 5 ) B;


/* RCNT 1 : �׳� DATA ���

  RCNT  2 : BOOK_TYPE (����) �� �Ұ踦 ����Ѵ�

            BOOK_TYPE �� '�Ҽ� ��' , '������ ��' .. �������� ��µǰ�
            BOOK_NAME �� �ʿ�����Ƿ� null �� ���

  RCNT  3 : PRESS (���ǻ�) �� �Ұ� ���

            PRESS �� '���� ���ǻ� ��' .. �������� ��µǰ�
            BOOK_TYPE , BOOK_NAME �� �ʿ�����Ƿ� null ���

  RCNT  4 : ��ü �հ� ���   

            PRESS �� '��ü �հ�' �� ��µǰ�
            BOOK_TYPE , BOOK_NAME �� �ʿ�����Ƿ� null ��� 
            
  RCNT 1~4  ��� PRICE �� ��µǾ�� �Ѵ�  => ���߿� SUM(PRICE)     */

SELECT RCNT,   -- ��� Ȯ�� �� ���� ��!
       ( CASE WHEN RCNT=1 OR RCNT=2 THEN PRESS
              WHEN RCNT=3 THEN PRESS || ' ��'
              WHEN RCNT=4 THEN '��ü �հ�' END )  AS ���ǻ�, 
       ( CASE WHEN RCNT=1 THEN BOOK_TYPE
              WHEN RCNT=2 THEN BOOK_TYPE || ' ��' 
              WHEN RCNT=3 OR RCNT=4 THEN NULL END ) AS ����, 
       ( CASE RCNT WHEN 1 THEN A.BOOK_NAME 
                   WHEN 2 THEN NULL
                   WHEN 3 THEN NULL
                   WHEN 4 THEN NULL END ) AS å��, 
       PRICE AS ����                
FROM TEST12 A, 
     ( SELECT ROWNUM AS RCNT FROM TEST12 WHERE ROWNUM < 5 ) B;



/* ���� ���̺��� ���ǻ�, ����, å������ �׷�ȭ�ϰ�
   SUM(PRICE) �Ѵ� */
SELECT ( CASE WHEN RCNT=1 OR RCNT=2 THEN PRESS
              WHEN RCNT=3 THEN PRESS || ' ��'
              WHEN RCNT=4 THEN '��ü �հ�' END )  AS ���ǻ�, 
       ( CASE WHEN RCNT=1 THEN BOOK_TYPE
              WHEN RCNT=2 THEN BOOK_TYPE || ' ��' 
              WHEN RCNT=3 OR RCNT=4 THEN NULL END ) AS ����, 
       ( CASE RCNT WHEN 1 THEN A.BOOK_NAME 
                   WHEN 2 THEN NULL
                   WHEN 3 THEN NULL
                   WHEN 4 THEN NULL END ) AS å��, 
        SUM(PRICE) AS ����                
FROM TEST12 A, 
     ( SELECT ROWNUM AS RCNT FROM TEST12 WHERE ROWNUM < 5 ) B
GROUP BY ( CASE WHEN RCNT=1 OR RCNT=2 THEN PRESS
                WHEN RCNT=3 THEN PRESS || ' ��'
                WHEN RCNT=4 THEN '��ü �հ�' END ) , 
         ( CASE WHEN RCNT=1 THEN BOOK_TYPE
                WHEN RCNT=2 THEN BOOK_TYPE || ' ��' 
                WHEN RCNT=3 OR RCNT=4 THEN NULL END ) , 
         ( CASE RCNT WHEN 1 THEN A.BOOK_NAME 
                     WHEN 2 THEN NULL
                     WHEN 3 THEN NULL
                     WHEN 4 THEN NULL END );



/* ���� ���忡�� ������ �Ұ�� �� ��µ����� ������ �����̴�

  ��ü �հ� ( RCNT = 4 ) �� �� �ڷ� ������ 
  
  GROUP BY ( CASE RCNT WHEN 4 THEN 1 ELSE 0 END ) 
            , ...
  ORDER BY ( CASE RCNT WHEN 4 THEN 1 ELSE 0 END );  �� �߰��Ѵ�   
  
  RCNT �� 1~3 �� ���� 0 �� , RCNT �� 4 �� ���� 1 �� ����ϴ�
  �÷��� �߰��ϰ� �� �÷��� ���� ���ĵǵ��� �Ѵ�. */
  
SELECT ( CASE WHEN RCNT=1 OR RCNT=2 THEN PRESS
              WHEN RCNT=3 THEN PRESS || ' ��'
              WHEN RCNT=4 THEN '��ü �հ�' END )  AS ���ǻ�, 
       ( CASE WHEN RCNT=1 THEN BOOK_TYPE
              WHEN RCNT=2 THEN BOOK_TYPE || ' ��' 
              WHEN RCNT=3 OR RCNT=4 THEN NULL END ) AS ����, 
       ( CASE RCNT WHEN 1 THEN A.BOOK_NAME 
                   WHEN 2 THEN NULL
                   WHEN 3 THEN NULL
                   WHEN 4 THEN NULL END ) AS å��, 
        SUM(PRICE) AS ����                
FROM TEST12 A, 
     ( SELECT ROWNUM AS RCNT FROM TEST12 WHERE ROWNUM < 5 ) B
GROUP BY ( CASE RCNT WHEN 4 THEN 1   -- �߰��� GROUP  
                     ELSE 0 END) ,   -- RCNT = 4, �� ��ü �հ�� 1, �������� 0 
                                     -- => ���Ľ� ���� �հ踦 �� �ڷ�
          ( CASE WHEN RCNT=1 OR RCNT=2 THEN PRESS
                 WHEN RCNT=3 THEN PRESS || ' ��'
                 WHEN RCNT=4 THEN '��ü �հ�' END ) , 
          ( CASE WHEN RCNT=1 THEN BOOK_TYPE
                 WHEN RCNT=2 THEN BOOK_TYPE || ' ��' 
                 WHEN RCNT=3 OR RCNT=4 THEN NULL END ) , 
          ( CASE RCNT WHEN 1 THEN A.BOOK_NAME 
                      WHEN 2 THEN NULL
                      WHEN 3 THEN NULL
                      WHEN 4 THEN NULL END )
ORDER BY ( CASE RCNT WHEN 4 THEN 1
                     ELSE 0 END );                       

--å�� Ǯ�� : RCNT �� �ű�� ������ ���� �ٸ�!
/* RCNT 4 : �׳� DATA ���
  RCNT  1 : BOOK_TYPE (����) �� �Ұ� ���
  RCNT  3 : PRESS (���ǻ�) �� �Ұ� ���
  RCNT  2 : ��ü �հ� ���   */
SELECT  DECODE(RCNT,2,'�հ�',3,PRESS || ' ��', PRESS) "���ǻ�", 
        DECODE(RCNT,1,BOOK_TYPE || ' ��',4,BOOK_TYPE) "����", 
        DECODE(RCNT,4,BOOK_NAME) "å��",
        SUM(PRICE) "����"
FROM TEST12 A, 
     ( SELECT ROWNUM AS RCNT FROM TEST12 WHERE ROWNUM < 5 ) B
GROUP BY DECODE(RCNT,2,1,0),   -- �� ���� �հ踦 �� �ڷ� ���� ��
         DECODE(RCNT,2,'�հ�',3,PRESS || ' ��', PRESS), 
         DECODE(RCNT,1,BOOK_TYPE || ' ��',4,BOOK_TYPE),
         DECODE(RCNT,4,BOOK_NAME)
ORDER BY "���ǻ�", "����";  

--------------------------------------------------------------------------

--p311 ���� 11-1 : �Ұ�� �հ� => å�� �ڵ�� ���ذ� �Ȱ��� ��ü Ǯ����

SELECT * FROM SUB_SUM;

/* ��� ����� �ִ��� ����� Ʋ�� ���� ��,
   ���ϴ� DATA �� CASE / DECODE �Լ��� �̿��Ͽ� ��µǰ� �ϰų�
   ���� Data �� �ִ� ���̺�� ���ν��Ѽ� 
   ���ǿ� �´� ���� �������� �ϴ� ����̴�   */

/* å�� ����� ���� ��µǵ��� �ϱ� ���� RCNT �� UNCASH_DATE �� �̿��Ͽ� 
   ������ ���� KEY �÷��� �߰��Ѵ�. 

 RCNT       ����               KEY (���ϴ� ����� �������� ���� ����)   
  1  : �׳� DATA ���               UNCASH_DATE _1 
  2  : ( ��¥ + 1 ) ��              UNCASH_DATE _2 
  3  : ( ��¥ + 2 ) ��              UNCASH_DATE _3
  4  : ��¥�� �հ�                   UNCASH_DATE _4
  5  : �� 1 ��                      '1_TOTAL'
  6  : �� 2 ��                      '2_TOTAL'
  7  : ��ü �հ�                     'TOTAL'       
  
RCNT 2 : SO_GUBUN ���� 1�� ���� BILL_AMT �� ��µǵ���
         CASE �Լ��� THEN ����  DECODE(SO_GUBUN,1,BILL_AMT,NULL) �߰�

RCNT 3 : SO_GUBUN ���� 2�� ���� BILL_AMT �� ��µǵ���
         CASE �Լ��� THEN ����  DECODE(SO_GUBUN,2,BILL_AMT,NULL) �߰�

RCNT 5 �� 6�� ���� ���� �������� DECODE �Լ��� �߰��Ѵ�  */

SELECT RCNT, ( CASE WHEN RCNT = 1 THEN UNCASH_DATE || '_' || RCNT
                    WHEN RCNT = 2 THEN UNCASH_DATE || '_' || RCNT 
                    WHEN RCNT = 3 THEN UNCASH_DATE || '_' || RCNT 
                    WHEN RCNT = 4 THEN UNCASH_DATE || '_' || RCNT
                    WHEN RCNT = 5 THEN '1_TOTAL'
                    WHEN RCNT = 6 THEN '2_TOTAL'
                    WHEN RCNT = 7 THEN 'TOTAL' END ) AS KEY,
       ( CASE RCNT WHEN 1 THEN UNCASH_DATE
                   WHEN 2 THEN '1 ��' 
                   WHEN 3 THEN '2 ��'
                   WHEN 4 THEN '1 2 �հ�'
                   WHEN 5 THEN '�� 1 ��'
                   WHEN 6 THEN '�� 2 ��'
                   WHEN 7 THEN '�� �հ�' END ) AS KEY1 ,
        SO_GUBUN,
        ( CASE WHEN RCNT=1 THEN SO_GUBUN END ) K,  
        ( CASE WHEN RCNT=1 THEN CUST_NAME END ) CUST, 
        ( CASE WHEN RCNT=2 THEN DECODE(SO_GUBUN,1,BILL_AMT,NULL)
               WHEN RCNT=3 THEN DECODE(SO_GUBUN,2,BILL_AMT,NULL)
               WHEN RCNT=5 THEN DECODE(SO_GUBUN,1,BILL_AMT,NULL)
               WHEN RCNT=6 THEN DECODE(SO_GUBUN,2,BILL_AMT,NULL)
               ELSE BILL_AMT END) AMT
FROM SUB_SUM , 
( SELECT ROWNUM AS RCNT FROM USER_TABLES WHERE ROWNUM < 8 )  -- ROWNUM 1~7
ORDER BY KEY;  -- ����� ���� �ϱ� ���� ���� �߰�, �Ʒ� �ܰ�� �Ѿ �� ���� ��


/* ���� : ���� ����� FROM ���� �ζ��κ�� �Ͽ� 
          KEY, KEY1, K, CUST �� GROUP BY �� ��
          SUM(AMT) �߰��ϰ� KEY, CUST �� ����     */
SELECT KEY1, K, SUM(AMT), CUST
FROM
( SELECT RCNT, ( CASE WHEN RCNT = 1 THEN UNCASH_DATE || '_' || RCNT
                      WHEN RCNT = 2 THEN UNCASH_DATE || '_' || RCNT 
                      WHEN RCNT = 3 THEN UNCASH_DATE || '_' || RCNT 
                      WHEN RCNT = 4 THEN UNCASH_DATE || '_' || RCNT
                      WHEN RCNT = 5 THEN '1_TOTAL'
                      WHEN RCNT = 6 THEN '2_TOTAL'
                      WHEN RCNT = 7 THEN 'TOTAL' END ) AS KEY,
       ( CASE RCNT WHEN 1 THEN UNCASH_DATE
                   WHEN 2 THEN '1 ��' 
                   WHEN 3 THEN '2 ��'
                   WHEN 4 THEN '1 2 �հ�'
                   WHEN 5 THEN '�� 1 ��'
                   WHEN 6 THEN '�� 2 ��'
                   WHEN 7 THEN '�� �հ�' END ) AS KEY1 ,
        SO_GUBUN,
        ( CASE WHEN RCNT=1 THEN SO_GUBUN END ) K,
        ( CASE WHEN RCNT=1 THEN CUST_NAME END ) CUST, 
        ( CASE WHEN RCNT=2 THEN DECODE(SO_GUBUN,1,BILL_AMT,NULL)
               WHEN RCNT=3 THEN DECODE(SO_GUBUN,2,BILL_AMT,NULL)
               WHEN RCNT=5 THEN DECODE(SO_GUBUN,1,BILL_AMT,NULL)
               WHEN RCNT=6 THEN DECODE(SO_GUBUN,2,BILL_AMT,NULL)
               ELSE BILL_AMT END) AMT
  FROM SUB_SUM , 
  ( SELECT ROWNUM AS RCNT FROM USER_TABLES WHERE ROWNUM < 8 ) )
GROUP BY KEY, KEY1, K, CUST
ORDER BY KEY, CUST;  -- KEY �θ� �����ϸ� CUST ���� 
                     --TEST1, TEST2 .. ������ ���ĵ��� ����
