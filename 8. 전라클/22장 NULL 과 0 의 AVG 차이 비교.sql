SELECT * FROM TEST26;

SELECT YYMMDD, AVG(VAL1), AVG(VAL2), AVG(VAL3)
FROM TEST26
GROUP BY YYMMDD;
/*  19990601 ���ظ� �����ϸ� �ȴ�
   AVG(VAL1) : 10, NULL, NULL, NULL �� ��� => 10
   AVG(VAL2) : 10, 0, 0 , 0 �� ��� => 2.5
   AVG(VAL3) : 10, 10, 10, 10 �� ��� => 10
*/
-- AVG �Լ��� NULL �� 0 ���� ġȯ�ؼ� ����� ���, ����� �޶�����

SELECT KEY1, AVG(VAL1), AVG(VAL2), AVG(VAL3)
FROM TEST26
GROUP BY KEY1;
--���� ���� ����

SELECT YYMMDD, SUM(VAL1), SUM(VAL2), SUM(VAL3)
FROM TEST26
GROUP BY YYMMDD;
-- NULL�� �ƿ� �����ϰų� 0 ���� ���� ����� ����
-- ��Ȯ���� SUM �Լ��� NULL �� �����ϰ� ������ �����Ѵ�
-- SUM �Լ������� NULL �� 0 ���� ġȯ�ϰų� ���ϰų� ����� ����


SELECT YYMMDD, SUM(VAL1) + SUM(VAL2), SUM(VAL1 + VAL2)
FROM TEST26
GROUP BY YYMMDD;
/* 19990603 �� �����ϸ� �ȴ�
  SUM(VAL1) = 10 �� 10�� SUM : 20 , 
  SUM(VAL2) = NULL �� 10�� SUM : 10  =>  ��� 30  

  SUM(VAL1 + VAL2) �� ���  (1) 10 + NULL = NULL , (2) 10+10 = 20
                                     NULL �� 20 �� SUM ��� : 20   
*/

-- (Poin) 20 + NULL = NULL  , 20 �� NULL �� SUM : 20  

SELECT KEY1, MAX(VAL1), MIN(VAL2), COUNT(VAL3)
FROM TEST26
GROUP BY KEY1;
-- NULL �� �ִ� ��� MAX, MIN �Լ��� ����� NULL
-- AVG, MAX, MIN, COUNT, SUM �� ��� �׷� �Լ��� ��� NULL �� �����ϰ� ������ �����Ѵ�
-- SUM �Լ��� �����Ѵٸ� NULL �� 0���� ġȯ�� �ʿ䰡 ����
-- AVG, MAX, MIN, COUNT �� NULL �� 0���� ġȯ�� ��� ����� �޶�����

