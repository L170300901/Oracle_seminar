SELECT * FROM TEST30;
SELECT * FROM TEST31;
SELECT * FROM TEST32;
SELECT * FROM TEST33;


--p516 �����ϱ� (1) ��ü Ǯ��
/* TEST31 ~ TEST33 UNION �� AMT1 , AMT2, AMT3 �� ��� AMT1 ���� ��µ�
   ���� ��� ���̺� �־����� �����ϱ� ���� KEY �ʵ� �߰�
*/
SELECT T1.YM, T1.KEY1, T2.AMT,
        SUM( ( CASE WHEN T1.KEY=1 THEN T1.AMT1 END ) ) AMT1, 
        SUM( ( CASE WHEN T1.KEY=2 THEN T1.AMT1 END ) ) AMT2,
        SUM( ( CASE WHEN T1.KEY=3 THEN T1.AMT1 END ) ) AMT3 
FROM
    ( SELECT '1' AS KEY, KEY1, YM, AMT1 FROM TEST31
      UNION ALL
      SELECT '2' AS KEY, KEY1, YM, AMT2 FROM TEST32
      UNION ALL
      SELECT '3' AS KEY , KEY1, YM, AMT3 FROM TEST33 ) T1, 
      TEST30 T2
WHERE T1.KEY1 = T2.KEY1  -- ����� ��µǷ��� ���� OUTER ������ �� �ʿ� ���� ��?
GROUP BY T1.YM, T1.KEY1, T2.AMT
ORDER BY T1.YM, T1.KEY1;
/*  å���� UNION ALL ��� UNION ���� �Ǿ�������
  �ߺ��Ǵ� �ڷ�� ������ GROUP BY ���� �������� �Ǵ� ��..
  UNION �̳� UNION ALL �̳� ����� �����ϰ� ��µȴ�  */


--p516 �����ϱ� (2) : å�� Ǯ��  
SELECT KEY1, YM FROM TEST31
UNION 
SELECT KEY1, YM FROM TEST32
UNION 
SELECT KEY1, YM FROM TEST33;  --�ߺ� �ڷ� ���� ���� �ݵ�� UNION ��� : �� 15�� ���

SELECT A.YM, A.KEY1, B.AMT, C.AMT1, D.AMT2, E.AMT3
FROM 
  ( SELECT KEY1, YM FROM TEST31
    UNION
    SELECT KEY1, YM FROM TEST32
    UNION 
    SELECT KEY1, YM FROM TEST33 ) A, -- �� ���� �ݵ�� UNION �� �Ἥ �ߺ� �����͸� ���� ��
    TEST30 B, TEST31 C, TEST32 D, TEST33 E
WHERE A.KEY1 = B.KEY1 (+)   -- UNION �ڷ�� TEST30 �� AMT �� KEY1 ���� �ƿ��� ����
   AND A.KEY1 = C.KEY1 (+) AND A.YM = C.YM (+)  -- UNION �ڷ�� TEST31 �� AMT1 �� KEY1 �� YM ���� �ƿ��� ����
   AND A.KEY1 = D.KEY1 (+) AND A.YM = D.YM (+)  -- UNION �ڷ�� TEST32 �� AMT2 �� KEY1 �� YM ���� �ƿ��� ����
   AND A.KEY1 = E.KEY1 (+) AND A.YM = E.YM (+)  -- UNION �ڷ�� TEST33 �� AMT3 �� KEY1 �� YM ���� �ƿ��� ����
ORDER BY YM, KEY1;

--p518 ���� 27-1 : ���� ���̺��� OUTER JOIN
SELECT A.KEY1 AS KEY, A.AMT, B.YM AS AMT1_YM, B.AMT1 ,
         C.YM AS AMT2_YM, C.AMT2, D.YM AS AMT3_YM, D.AMT3
FROM TEST30 A, TEST31 B, TEST32 C, TEST33 D
WHERE A.KEY1 = B.KEY1 (+) 
   AND A.KEY1 = C.KEY1 (+) 
   AND A.KEY1 = D.KEY1 (+);


