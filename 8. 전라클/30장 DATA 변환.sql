--�ǽ� �� ȯ�溯�� ��ȸ
SELECT * FROM v$nls_parameters;
/* nls_character �� AL32UTF8 �� ��� : �ѱ� �� ���ڴ� 3byte
   nls_character �� AL16UTF16 �Ǵ� KO16MSWIN949 �� ��� : �ѱ� �� ���ڴ� 2byte  */

SELECT * FROM TEST36;
SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
FROM TEST36; 
SELECT ROWNUM AS RNUM FROM USER_TABLES WHERE ROWNUM < 13;

/* INSTRB(A.PLANMM, '��', 1, B.RNUM) 
  : PLANMM ���ڿ����� '��' �� ù ��° ����Ʈ���� �˻��Ͽ� 
    n ��° '��' �� ��ġ ����Ʈ�� ��ȯ  */
SELECT A.PLANYY AS PLAN, A.KEY1, A.SEQ, A.AMT, A.PLANMM, B.n, 
          INSTRB(A.PLANMM, '��', 1, B.n)       
FROM 
  ( SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
    FROM TEST36 ) A,  
  ( SELECT ROWNUM AS n FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE INSTRB(A.PLANMM, '��', 1, B.n) > 0;   -- n ��° '��' �� ���� ��� ����

/* SUBSTRB ( PLANMM, INSTRB(A.PLANMM, '��', 1, B.n )-2 , 2) 
  : PLANMM ���ڿ����� ( n ��° '��' �� ��ġ ����Ʈ ) -2 ���� �˻��Ͽ�
    2 ����Ʈ ������ ���ڿ��� ��ȯ   
    =>  ��, n��° '��' ���� 2����Ʈ ���ڿ��� ��ȯ�϶�� �ǹ�    */
SELECT A.PLANYY AS PLAN, A.KEY1, A.SEQ, A.AMT, A.PLANMM, B.n, 
          SUBSTRB( A.PLANMM, INSTRB(A.PLANMM, '��', 1, B.n )-2 , 2)    
FROM 
  ( SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
    FROM TEST36 ) A,  
  ( SELECT ROWNUM AS n FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE INSTRB(A.PLANMM, '��', 1, B.n) > 0; 

/* ���� ������� REPLACE ( ~ , ' ' , NULL ) : ���� (' ') �� NULL �� ġȯ ,
   �ٽ� LPAD(  ~ , 2 ,'0' ) : ������ �� 2�ڸ��� �ǵ��� '0'�� ä�� ,
   ���������� MON ��Ī�� ���δ� */
/* ����Ŭ p275 : LPAD ( ~ , n, ~ ) ���� n �� ���ڼ¿� ���� 
   �ڸ����� ���� ����Ʈ ���� ���� �ִ�    */
SELECT A.PLANYY AS PLAN, A.KEY1, A.SEQ, A.AMT, A.PLANMM, B.n, 
       LPAD(REPLACE(SUBSTRB( A.PLANMM, INSTRB(A.PLANMM, '��', 1, B.n )-2 , 2),' ', NULL),2,'0') AS MON
FROM 
  ( SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
    FROM TEST36 ) A,  
  ( SELECT ROWNUM AS n FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE INSTRB(A.PLANMM, '��', 1, B.n) > 0;


/* ���� ����� �ζ��� �� ( FROM ���� �������� ) �� Ȱ���Ѵ�
 (1)  ( CASE WHEN SUBSTR(MON,1,1) = '1' THEN '1' ELSE '0' END ) || SUBSTR(MON,2,1)  
   =>  ( ù��° ����Ʈ�� ���ڰ� '1' �̸� '1' ,�ƴϸ� '0' ) + ( 2��° ����Ʈ ���� ) ��ȯ
 (2) ���� �Լ��� REPLACE( MON , ',' , '0' ) => �׳� , �� 0 ���� ġȯ�ص� ����� ����
 (3) � ��쿡�� '0', '1' ��� ���ڿ��� ���� ������ ��츦 ��Ȯ�� �����ؾ� �Ѵ� 
*/

SELECT PLAN, KEY1, 
       ( CASE WHEN SUBSTR(MON,1,1) = '1' THEN '1' ELSE '0' END ) || SUBSTR(MON,2,1) AS MON,
       SEQ, AMT
FROM          
( SELECT A.PLANYY AS PLAN, A.KEY1, A.SEQ, A.AMT, A.PLANMM, B.n, 
         LPAD(REPLACE(SUBSTRB( A.PLANMM, INSTRB(A.PLANMM, '��', 1, B.n )-2 , 2),' ', NULL),2,'0') AS MON
FROM 
  ( SELECT PLANYY, KEY1, SEQ, PLANMM, AMT
    FROM TEST36 ) A,  
  ( SELECT ROWNUM AS n FROM USER_TABLES WHERE ROWNUM < 13 ) B
WHERE INSTRB(A.PLANMM, '��', 1, B.n) > 0 )
ORDER  BY PLAN, KEY1, ( CASE WHEN SUBSTR(MON,1,1) = '1' THEN '1' ELSE '0' END ) || SUBSTR(MON,2,1);