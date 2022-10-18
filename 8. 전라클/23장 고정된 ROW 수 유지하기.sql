-- p466 �����ϱ�

SELECT * FROM TEST01;
SELECT * FROM TEMP;

SELECT T1.EMP_ID, T1.EMP_NAME
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME,DEPT_CODE
       FROM TEMP 
       WHERE DEPT_CODE = 'AA0001' ) T1 , 
       TEST01 T2 
WHERE T2.B=T1.R_CNT (+) AND T2.B <= 10 ;

/* WHERE DEPT_CODE = 'AA0001' �� ��ġ�� �߿�!
   ROWNUM �� WHERE ���� ���� �Ŀ� �Ű�����. 

SELECT T1.EMP_ID, T1.EMP_NAME
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME,DEPT_CODE
       FROM TEMP ) T1 , 
     TEST01 T2 
WHERE T2.B=T1.R_CNT (+) AND WHERE DEPT_CODE = 'AA0001' ;

�� ������ ����� ������� �ʴ´�. 
T1 �ζ��κ� �ȿ��� WHERE ���� ���� ��� �˻��� ���
�μ���ȣ 'AA0001' �� 2�� �� 
�� ���� ROWNUM �� 10���� ũ�� �Ű����� ����..

SELECT T1.EMP_ID, T1.EMP_NAME
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME,DEPT_CODE
       FROM TEMP 
       WHERE DEPT_CODE = 'AA0001' ) T1 , 
      ( SELECT B FROM TEST01 WHERE B <=10 ) T2 
WHERE T2.B=T1.R_CNT (+) ;

WHERE B <= 10 �� ��ġ�� T2 �ζ��κ� ������ ���� ������ ������� �� ����ȴ�. 

*/

--p469 ���� 23-1 : ������ ROW �� ����
SELECT T1.R_CNT, T1.EMP_ID, T1.EMP_NAME, T2.B
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME
          FROM TEMP 
          WHERE DEPT_CODE = 'AA0001' ) T1 , 
         ( SELECT B FROM TEST01 ) T2 
WHERE T2.B=T1.R_CNT (+) 
AND T2.B <= ( CASE WHEN T1.R_CNT > 10 THEN T1.R_CNT
                   ELSE 10 END );
-- T1�� ����� 10�ຸ�� ���� ���, �������� T1.R_CNT ���� NULL �� ����
-- �׷� ���, CASE �� WHEN ������ FALSE => ELSE ���� �����
-- �� WHERE T2.B <= 10 �� �ȴ� 

/*
���� ������ ������ Case ������ ������ �ٲ� ���ε�, T1 �� ����� 10�� �̸��� ���
����� ��µ��� �ʴ´�. (2�ุ ���)

SELECT T1.R_CNT, T1.EMP_ID, T1.EMP_NAME, T2.B
FROM ( SELECT ROWNUM AS R_CNT, EMP_ID, EMP_NAME
          FROM TEMP 
          WHERE DEPT_CODE = 'AA0001' ) T1 , 
         ( SELECT B FROM TEST01 ) T2 
WHERE T2.B=T1.R_CNT (+)                -- ��������� �����غ��� ������� R_CNT �� NULL �� ���� �߿�!
AND T2.B <= ( CASE WHEN T1.R_CNT <= 10 THEN 10
                           ELSE T1.R_CNT END );

T1.R_CNT �� NULL ���� �� �ڵ������� CASE �� ELSE ����, ���⼭�� T1.R_CNT ���� �Ѿ
�׷��� �� T1.R_CNT �� NULL �� : �ᱹ �׳� ����Ǵ� ����� �����´�.

*/