SELECT * FROM TEST100; 
SELECT * FROM T100; 
SELECT * FROM TEST101; 

--������ ������� ���� ���� ���ϱ�
SELECT T1.C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
FROM TEST100 T1 ,
    ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2;

/* ���� ����� x 2 ���� ,
   �� RCNT �� 2 �� ��� C1 �� NULL �� ��µǵ��� �Ѵ�
   RCNT �� 2�� ���� ���� �������� ��ü ������ ������ ����� �� ���δ�  */ 
SELECT D2.RCNT, 
      ( CASE D2.RCNT WHEN 2 THEN NULL 
                     ELSE D1.C1 END ) C1, 
       D1.C2_RATIO
FROM
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2;

/* ���� �������� D2.RCNT �� �� ����
   ( CASE D2.RCNT WHEN 2 THEN NULL ELSE D1.C1 END ) ���� GROUP BY   */
/* C1 �� NULL �� ���� C2_RATIO ���� ��ü ������ �����̴�.
   ���⼭�� 1.001 �� ��� : ROUND �Լ��� ���� �ݿø����� ���� 0.001 �� �����. 
   ���� 0.001 �� ���� ū �������� ���������� ����ϴ� ���� �����̴�   */
SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                      ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  --RCNT 1 �� ���� �״�� ���    
FROM                                            --RCNT 2 �� ��� ������ ���� ���
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END );

/*  ���� ���忡 ORDER BY C2_RATIO �� �߰��Ѵ�
    ���� �Ʒ��� ��ü ������ ����, �� ���� ��ü ���� �� �ִ��� �´�  
    ����Ŭ 8i �̻� �����ϴٰ� å�� ����  */
SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                      ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  
FROM                                         
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END )
ORDER BY C2_RATIO;  -- �� ���� �߰���

/* ��ü ������ �� ( RNUM 4, C1 �� NULL �� �� ) �� 
   ��ü ������ �ִ� ( RNUM 3 ) �� 
   ���� �׷��� �ǵ��� CASE �Լ��� �߰��Ѵ�.  */
/* CASE �Լ��� ������ ���� ���� �ȵȴ�
      CASE C1 WHEN NULL THEN ~ 
   ���� ������ C1 = NULL �� �ǹ� => �ݵ�� FALSE ��ȯ, 
                                   RNUM �� �ٲ��� �ʴ´�  */
SELECT ( CASE WHEN C1 IS NULL THEN RNUM-1 
              ELSE RNUM END ) AS RNUM ,
          C1, C2_RATIO
FROM 
( SELECT ROWNUM AS RNUM, C1, C2_RATIO
FROM 
( SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  
FROM                                         
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END )
ORDER BY C2_RATIO ) ); --�ٷ� ���� ������ �ζ��κ�� �߰���


/* ���� ������ GROUP BY ( CASE WHEN C1 IS NULL THEN RNUM-1 
                              ELSE RNUM END )  �� �߰��Ѵ�
   �� �� ( ��ü ������ �� ) + ( ��ü ���� �� �ִ� ), �� 1.517 �� RNUM 3 �� ��µȴ�         */
SELECT ( CASE WHEN C1 IS NULL THEN RNUM-1 
              ELSE RNUM END ) AS RNUM ,
          MAX(C1), -- RNUM 3 �� �� C1 �� A �� NULL , �� �� A �� ��µȴ�
          SUM(C2_RATIO)
FROM 
( SELECT ROWNUM AS RNUM, C1, C2_RATIO
  FROM 
( SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  
  FROM                                         
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
  GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                          ELSE D1.C1 END )
  ORDER BY C2_RATIO ) ) 
GROUP BY ( CASE WHEN C1 IS NULL THEN RNUM-1 
                ELSE RNUM END ) ;

/* ���� ��� : SUM(C2_RATIO) ���� C1 �� NULL �� �� C2_RATIO ���� 1 - C2_RATIO, 
   �� - 0.001 �� �ǵ��� �� �� ��ü ������ �ִ� 0.516 �� ���������� �����Ѵ�   
   ��ü ������ ���� 1�̿��� �ϴµ� �� �ʰ�/�����и�ŭ 
   ��ü ���� �� �ִ񰪿� �ݿ��ǵ��� �ϴ� ���̴�. */ 

SELECT ( CASE WHEN C1 IS NULL THEN RNUM-1 
              ELSE RNUM END ) AS RNUM ,
       MAX(C1), 
       SUM( ( CASE WHEN C1 IS NULL THEN 1-C2_RATIO
                   ELSE C2_RATIO END ) ) AS RATIO     -- �� �κ��� �� ������ �ٸ� ���̴�.     
FROM 
( SELECT ROWNUM AS RNUM, C1, C2_RATIO
  FROM 
( SELECT ( CASE D2.RCNT WHEN 2 THEN NULL 
                        ELSE D1.C1 END ) C1, 
       SUM(D1.C2_RATIO) AS C2_RATIO  
  FROM                                         
  ( SELECT T1.C1 AS C1, ROUND(T1.C2/TOT,3) AS C2_RATIO
    FROM TEST100 T1 ,
  ( SELECT SUM(C2) AS TOT FROM TEST100 ) T2 ) D1 ,
  ( SELECT ROWNUM AS RCNT 
    FROM USER_TABLES 
    WHERE ROWNUM < 3 ) D2
  GROUP BY ( CASE D2.RCNT WHEN 2 THEN NULL 
                          ELSE D1.C1 END )
  ORDER BY C2_RATIO ) ) 
GROUP BY ( CASE WHEN C1 IS NULL THEN RNUM-1 
                ELSE RNUM END ) ;

---------------------------------------------------------------------

--p555 �����ϱ� : �ѹ� ���� ���̺�� ����� ���ϱ�

SELECT * FROM T100;

/* T100 ���̺��� x2 ����   */
SELECT B.NO, A.C1, A.C2 
FROM T100 A, 
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B ;
/*  ���� �ܰ迡�� C1 �÷��� NO = 1 �� ���� C1 �ڽ��� ��, 
    NO = 2 �� ���� NULL �� ��µǵ��� CASE �Լ��� ����.
    C1 �ķ��� ��°��� A , B , C , D , E , NULL
    �� �� C1 �� NULL �� �� T100 ���̺��� ��ü ���ڵ尡 �ϳ��� �������ٴ� ���̴� 

    �׸��� ( CASE WHEN B.NO =1 THEN A.C1 END ) �� GROUP BY �Ѵ�
    1, 2, 3, 4, 5, NULL �� 6���� �׷����� ��������
    �� �� NULL �׷쿡��  T100 ���̺��� ��ü ���ڵ尡 ����ִ� */   
    
/* ( CASE WHEN B.NO =1 THEN A.C1 END ) �� 
   ( CASE WHEN B.NO =1 THEN A.C1 ELSE NULL END ) �� ���� �ǹ��̴�
   NO �� 1�̸� C1 ����, �ƴϸ� NULL �� ����Ѵ�.  */

/* å������ ( CASE WHEN B.NO =1 THEN A.C1 END ) �� DECODE �Լ��� ������ �� 
   MIN �Լ��� �� ������� => �� �׷����� ���ذ� �Ȱ��� �̤� 
   GROUP BY �� �ߺ��� �ڷᰡ ��� ���ŵǾ��µ� �׷� �ʿ䰡 �ֳ�? */

/* å������ WHERE B.NO <=2 ������ �� �ִ� => �̰� �� �ִ°ɱ�?  */    

SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, -- 6�� �׷� ������ ���ڵ� ��
         SUM(C2) AS C2    -- 6�� �׷� ������ C2�� ��
FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ; --������ ���� �߰���



/* ���� ������ X ��������, ���ο� ROWNUM ���̺��� Y ���������� �ΰ�
  ������ ���ڵ尡 CNT �� ������ŭ �����ǵ��� WHERE ������ �߰��Ѵ� */
SELECT *
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO;

/* ���� ������ SELECT ���� ROWNUM �� �߰�, �� �� �ʿ��� �÷��� �ְ�
   ROWNUM ���� �����Ѵ�.

  ����� ���� �ϳ� : ROWNUM �� �Ű����� ������ ���ĵ� ����� å�� �ٸ��� ���´�  */
SELECT Y.NO, ROWNUM, X.CNT, X.C1, X.C2
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY ROWNUM;

--p557�� ������ �Ȱ��� ���� : �׷��� ROWNUM �� �Ű����� ������ ���ĵ� ����� å�� �ٸ��� ���´�
SELECT NO, ROWNUM, CNT, C1, C2
FROM ( SELECT COUNT(B.NO) CNT ,
              MIN(DECODE(B.NO, 1, A.C1 ) ) C1,
              SUM(A.C2) C2
       FROM T100 A, 
            ( SELECT ROWNUM NO
              FROM USER_TABLES WHERE ROWNUM < 3 ) B
       WHERE B.NO <= 2
       GROUP BY DECODE(B.NO, 1, A.C1 ) ) X ,
       ( SELECT ROWNUM NO FROM USER_TABLES ) Y
WHERE Y.NO <= X.CNT;

/* ROWNUM �� �Ű����� ������ �ٸ��� ������ ���� ������ åó�� ������ �� ���� �̤� 
  å���� ROWNUM �÷��� ������ ����� ������ ������ �� ��� , 
  �� ����� �ζ��κ�� �Ͽ� �ٽ� ROWNUM �� �ű��  */

--p557���� ROWNUM �� �����ϰ� ������ ����� ��µǵ��� ���� ����
SELECT Y.NO, X.CNT, X.C1, X.C2
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY C1, NO;   -- ROWNUM �� ���� �������� å�� �Ȱ��� ��µ�


--���� ����� FROM ���� �ζ��κ�� �Ͽ� ���� ROWNUM �߰�
SELECT NO, ROWNUM, CNT, C1, C2
FROM
( SELECT Y.NO, X.CNT, X.C1, X.C2
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY C1, NO )   -- ���� å�� �Ȱ��� ��µ�!! �̤�
 
/* ������ �� �ܰ� : ���� T100 ���̺��� ���ڵ尡 ���� 5��, 
                   �հ谪�� ���� ���ڵ尡 ���� 5�� �ִ�
  ������ 1�� ���ڵ�� �հ谪�� ���� ���� ���ڵ� 1���� �׷����� ���������� 
  �� ������ SELECT ���� �����Ѵ�   */
/* ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) 
   CNT �� 1 �� �� ( T100 ���̺��� �ڷ� ) �� ROWNUM �� ��� ( 1, 2, 3, 4, 5 )
   �ƴϸ� NO ( ���� 1, 2, 3, 4, 5 ) �� ����Ѵ� */

SELECT ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) AS GRP_UNIT, 
       C1, C2
FROM
( SELECT Y.NO, X.CNT, X.C1, X.C2
FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY C1, NO );

/* ���� �ܰ� : �� ������ ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) �� 
   �׷�ȭ�ϰ� MIN, MAX �Լ��� ����  */
/* MIN(C1) AS C1 �� ��� 
  => 1�� �׷�ȭ : A, null �� A ��� ,   
     2�� �׷�ȭ : B, null �� B ��� , ....   */
/* MIN(C2) AS C2 �� ���
  => 1�� �׷�ȭ : 10, 150 �� 10 ���,   
     2�� �׷�ȭ : 20, 150 �� 20 ��� , ....  */
--MAX(C2) : ��ü ���� 150 �ǹ�
SELECT MIN(C1) AS C1 , 
       MIN(C2) AS C2 ,  
       ROUND( MIN(C2) / MAX(C2) * 100, 2) AS C2_RT  --���� ���
FROM
( SELECT Y.NO, X.CNT, X.C1, X.C2
  FROM 
( SELECT ( CASE WHEN B.NO = 1 THEN A.C1 END ) C1,
         COUNT(*) AS CNT, 
         SUM(C2) AS C2    
  FROM T100 A,          
   ( SELECT ROWNUM AS NO 
     FROM USER_TABLES 
     WHERE ROWNUM < 3 ) B 
GROUP BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) 
ORDER BY ( CASE WHEN B.NO = 1 THEN A.C1 END ) ) X,
( SELECT ROWNUM AS NO FROM USER_TABLES ) Y
WHERE X.CNT >= Y.NO
ORDER BY C1, NO )
GROUP BY ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END );

----------------------------------------------------------------
--p555 �����ϱ� : �ѹ� ���� ���̺�� ����� ���ϱ�

SELECT * FROM TEST100;

--T100 ���̺��� x2 ����
SELECT B.NO, A.C1, A.C2 
FROM TEST100 A, 
     ( SELECT ROWNUM AS NO 
       FROM USER_TABLES 
       WHERE ROWNUM < 3 ) B ;

-- C1 �÷��� CASE �Լ� ���� : C1 �� A, B, C, null ���
SELECT B.NO, ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , C2
FROM TEST100 A, 
     ( SELECT ROWNUM AS NO 
       FROM USER_TABLES 
       WHERE ROWNUM < 3 ) B;      

--GROUP BY ����
SELECT COUNT(*) AS CNT, 
       ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
       SUM(C2) AS C2
FROM TEST100 A, 
     ( SELECT ROWNUM AS NO 
       FROM USER_TABLES 
       WHERE ROWNUM < 3 ) B
GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END );

/* ���� ����� �ζ��κ�� �ϰ� ���ο� ROWNUM ���̺�� ���ν��Ѽ�
   ������ ���ڵ带 CNT ����ŭ �����Ѵ�.     */
SELECT *
FROM
( SELECT COUNT(*) AS CNT, 
         ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
         SUM(C2) AS C2
  FROM TEST100 A, 
       ( SELECT ROWNUM AS NO 
         FROM USER_TABLES 
         WHERE ROWNUM < 3 ) B
  GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
( SELECT ROWNUM AS NO FROM USER_TABLES ) B
WHERE A.CNT >= B.NO;

/* ���� ����� �ζ��κ�� �Ͽ� �ٷ� ROWNUM �� ���̸�
   �츮�� ���ϴ� ����� �޶��� �� �ִ�  
   �׷��Ƿ� ���� ���� ����� ���� ���� => ORDER BY CNT1, C1 �߰�  */
SELECT *
FROM
( SELECT COUNT(*) AS CNT, 
        ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
        SUM(C2) AS C2
  FROM TEST100 A, 
     ( SELECT ROWNUM AS NO 
       FROM USER_TABLES 
       WHERE ROWNUM < 3 ) B
       GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
( SELECT ROWNUM AS NO FROM USER_TABLES ) B
WHERE A.CNT >= B.NO
ORDER BY CNT, C1;   

/* ���� ����� �ٽ� FROM ���� �ζ��κ�� �Ͽ� ROWNUM �߰�  */
SELECT ROWNUM, CNT, C1, C2, NO
FROM
( SELECT *
  FROM
  ( SELECT COUNT(*) AS CNT, 
           ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
           SUM(C2) AS C2
    FROM TEST100 A, 
         ( SELECT ROWNUM AS NO 
           FROM USER_TABLES 
           WHERE ROWNUM < 3 ) B
    GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
  ( SELECT ROWNUM AS NO FROM USER_TABLES ) B
  WHERE A.CNT >= B.NO
  ORDER BY CNT, C1 );

/* ������ ���ܰ� :���� 3���� 1�� ���ڵ�� �հ谪�� ���� ���� ���ڵ� 1���� 
   �׷����� ���������� �� ������ SELECT ���� �����Ѵ�   */
/* ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) 
   CNT �� 1 �� �� ( TEST100 ���̺��� �ڷ� ) �� ROWNUM �� ��� ( 1, 2, 3 )
   �ƴϸ� NO ( ���� 1, 2, 3 ) �� ����Ѵ� */
SELECT ( CASE WHEN CNT = 1 THEN ROWNUM ELSE NO END ) GRP_UNIT, 
       C1, C2
FROM
( SELECT *
  FROM
  ( SELECT COUNT(*) AS CNT, 
          ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
          SUM(C2) AS C2
    FROM TEST100 A, 
         ( SELECT ROWNUM AS NO 
           FROM USER_TABLES 
           WHERE ROWNUM < 3 ) B
    GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
  ( SELECT ROWNUM AS NO FROM USER_TABLES ) B
  WHERE A.CNT >= B.NO
  ORDER BY CNT, C1 );

/* ���� �ܰ� : �� ������ ( CASE WHEN CNT=1 THEN ROWNUM ELSE NO END ) �� 
   �׷�ȭ�ϰ� MIN, MAX �Լ��� ����  */
/* MIN(C1) AS C1 �� ��� 
  => 1�� �׷�ȭ : A, null �� A ��� ,   
     2�� �׷�ȭ : B, null �� B ��� ,
     3���� �׷�ȭ : C, null �� C ���   */
/* MIN(C2) AS C2 �� ���
  => 1�� �׷�ȭ : 33, 64 �� 33 ���,   
     2�� �׷�ȭ : 20, 64 �� 20 ���,
     3���� �׷�ȭ : 11, 64 �� 11 ���   */
--MAX(C2) : ��ü ���� 64 �ǹ�

SELECT MIN(C1) AS C1 ,
       MIN(C2) AS C2 ,
       ROUND( MIN(C2) / MAX(C2) * 100, 2) AS C2_RT  -- ����� ���
FROM
( SELECT *
  FROM
  ( SELECT COUNT(*) AS CNT, 
           ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) AS C1 , 
           SUM(C2) AS C2
    FROM TEST100 A, 
         ( SELECT ROWNUM AS NO 
           FROM USER_TABLES 
           WHERE ROWNUM < 3 ) B
    GROUP BY ( CASE WHEN NO = 2 THEN NULL ELSE C1 END ) ) A ,
  ( SELECT ROWNUM AS NO FROM USER_TABLES ) B
  WHERE A.CNT >= B.NO
  ORDER BY CNT, C1 )
GROUP BY  ( CASE WHEN CNT = 1 THEN ROWNUM ELSE NO END );
