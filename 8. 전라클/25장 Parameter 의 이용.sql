SELECT * FROM SAM_TAB01;  

--P_var1 �Ķ���� ���
/*  '1' : ��� ��� (EMP_ID)�� ���� (LEV) �� �޿� (SALARY) ���
 '2' : ���� (LEV) �� '01' �� ��� (EMP_ID) �� �޿� (SALARY) ���
 '3' : ���� (LEV) �� '02' �� ��� (EMP_ID) �� �޿� (SALARY) ���
 '4' : ���� (LEV) �� '03 �� ��� (EMP_ID) �� �޿� (SALARY) ���
 '5' : ���� (LEV) �� '04' '05 �� ��� (EMP_ID) �� �޿� (SALARY) ���
*/

SELECT LEV, AVG(SALARY) FROM SAM_TAB01 GROUP BY LEV;
SELECT LEV, AVG(SALARY) FROM SAM_TAB01 WHERE LEV = '01' GROUP BY LEV;
SELECT LEV, AVG(SALARY) FROM SAM_TAB01 WHERE LEV = '02' GROUP BY LEV;
SELECT LEV, AVG(SALARY) FROM SAM_TAB01 WHERE LEV = '03' GROUP BY LEV;
SELECT LEV, AVG(SALARY) FROM SAM_TAB01 WHERE LEV = '04' OR LEV = '05' GROUP BY LEV;

SELECT LEV, AVG(SALARY) 
FROM SAM_TAB01 
WHERE LEV = ( CASE P_var1 WHEN 1 THEN LEV
                          WHEN 2 THEN '01'
                          WHEN 3 THEN '02'
                          WHEN 4  THEN '03'
                          WHEN 5 THEN '04' END )
         OR LEV = ( CASE P_var1 WHEN 5 THEN '05' END )                            
GROUP BY LEV;

--p494 ���� 25-1 Ǯ�� : ������ ������ ��� �޶���
SELECT LEV, AVG(SALARY) 
FROM SAM_TAB01 
WHERE LEV = ( CASE MOD(TO_CHAR(SYSDATE,'SS'),5)+1 
                                    WHEN 1 THEN LEV
                                    WHEN 2 THEN '01'
                                    WHEN 3 THEN '02'
                                    WHEN 4  THEN '03'
                                    WHEN 5 THEN '04' END )
         OR LEV = ( CASE MOD(TO_CHAR(SYSDATE,'SS'),5) WHEN 5 THEN '05' END )                            
GROUP BY LEV;

--p499 �����ϱ� : å�� ����� �ٸ� ��? 
--ó�� ���̺� ������ �� NO_EMP �ʵ忡 DECODE(MOD(ROWNUM,2),0,2,1) �� �Է�
--�Ƹ� ROWNUM �ű�� ������ �޶� �׷� �� ����

SELECT * FROM TEST08;

SELECT DECODE(PARAM1 , 'SITE', SITE,
                       'DEPT', DEPT,
                       'LEV', LEV,
                       'LOCAL', LOCAL ) GR1,
       DECODE(PARAM2 , 'SITE', SITE,
                       'DEPT', DEPT,
                       'LEV', LEV ,
                       'LOCAL', LOCAL ) GR2, 
       DECODE(PARAM3 , 'SITE', SITE,
                       'DEPT', DEPT,
                       'LEV', LEV ,
                       'LOCAL', LOCAL ) GR3 , SUM(NO_EMP)                     
FROM TEST08
GROUP BY DECODE(PARAM1 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV,
                                 'LOCAL', LOCAL ) ,
          DECODE(PARAM2 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) , 
          DECODE(PARAM3 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL );

--Parameter �� 'SITE', 'LEV', 'LOCAL' ����                               
SELECT DECODE('SITE' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR1,
          DECODE('LEV' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR2, 
          DECODE('LOCAL' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR3 , SUM(NO_EMP) AS "��������"
FROM TEST08
GROUP BY DECODE('SITE' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ,
          DECODE('LEV' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) , 
          DECODE('LOCAL' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ;     

--Parameter �� 'SITE', 'LOCAL', '' ���� ( '' ��� NULL �� ���� )                               
SELECT DECODE('SITE' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR1,
          DECODE('LOCAL' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR2, 
          DECODE('' , 'SITE', SITE,                  
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR3 , SUM(NO_EMP) AS "��������"
FROM TEST08
GROUP BY DECODE('SITE' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ,
          DECODE('LOCAL' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) , 
          DECODE('' , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ;                                    

--p502 ���� 25-2
--ù��° Ǯ�� : PARAM �� �ٷ� MOD(TO_CHAR(SYSDATE,'SS'),4)+1 ����
SELECT DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, SITE,
                                 2, DEPT,
                                 3, DEPT,
                                 4, DEPT ) GR1,
          DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, DEPT,
                                 2, SITE,
                                 3, SITE ,
                                 4, '' ) GR2, 
          DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, LEV,
                                 2, 'LEV',
                                 3, '' ,
                                 4, '' ) GR3 , SUM(NO_EMP)                     
FROM TEST08
GROUP BY DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, SITE,
                                 2, DEPT,
                                 3, DEPT,
                                 4, DEPT ) ,
          DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, DEPT,
                                 2, SITE,
                                 3, SITE ,
                                 4, '' ) , 
          DECODE(MOD(TO_CHAR(SYSDATE,'SS'),4)+1 , 1, LEV,
                                 2, 'LEV',
                                 3, '' ,
                                 4, '' ) ;    

--GROUP BY ���� �� : GR1, GR2, GR3 �� ���� ������ �ٲ�
SELECT DECODE(PARAM1 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV,
                                 'LOCAL', LOCAL ) GR1,
          DECODE(PARAM2 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR2, 
          DECODE(PARAM3 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR3                     
FROM TEST08 ,
        ( SELECT DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'SITE' ,
                                2, 'DEPT' ,
                                3, 'DEPT' ,
                                4, 'DEPT' ) AS PARAM1 ,
            DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'DEPT' ,
                                2, 'SITE'  , 
                                3, 'SITE'  ,
                                4, ''       ) AS PARAM2 ,
             DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1,  'LEV' , 
                                2, 'LEV' , 
                                3, '' ,    
                                4, ''      ) AS PARAM3  FROM dual );

--GROUP BY ���� ��
SELECT DECODE(PARAM1 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV,
                                 'LOCAL', LOCAL ) GR1,
          DECODE(PARAM2 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR2, 
          DECODE(PARAM3 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) GR3 , SUM(NO_EMP) AS ��������        
FROM TEST08 ,
        ( SELECT DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'SITE' ,
                                2, 'DEPT' ,
                                3, 'DEPT' ,
                                4, 'DEPT' ) AS PARAM1 ,
            DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'DEPT' ,
                                2, 'SITE'  , 
                                3, 'SITE'  ,
                                4, ''       ) AS PARAM2 ,
             DECODE( MOD(TO_CHAR(SYSDATE,'SS'),4)+1, 
                                1, 'LEV' , 
                                2, 'LEV' , 
                                3, '' ,    
                                4, ''      ) AS PARAM3  FROM dual )
GROUP BY DECODE(PARAM1 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV,
                                 'LOCAL', LOCAL ) ,
          DECODE(PARAM2 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) , 
          DECODE(PARAM3 , 'SITE', SITE,
                                 'DEPT', DEPT,
                                 'LEV', LEV ,
                                 'LOCAL', LOCAL ) ;




