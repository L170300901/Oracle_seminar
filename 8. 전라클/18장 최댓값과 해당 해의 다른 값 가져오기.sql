
--p404 �����ϱ� : �ִ񰪰� �ش� ���� �ٸ� �� ��������

/* �Ŵ� (YYMM_YM) , ��ǰ(ITEM_CD)���� 
   BUDGET_CD '62099011' �׸����� ������� , 
   BUDGET_CD '62099101' �׸����� �ѿ��� 
   Data �� �ݾ� (PROD_AM) �÷��� ����ȴ�  */

SELECT * FROM TEST17;



/* p403 ���Ŀ� ���� ��ǰ�� ������ ���������� ���������� ���ϱ� ���ؼ���,
  �ش� �Ⱓ, ���⼭�� '199703' ~ '199802' 12���� ����
  �ְ��Ǹŷ��� �ٷ� �� ���� ����, ( ��ü �Ⱓ �� �ְ� ������ �ƴ�! )
  �����Ǹŷ��� �ٷ� �� ���� ���� Data �� �ʿ��ϴ�.*/ 

/* ���� 1998�� 3������ ������ 1��ġ Data �� �о�´� ('199703' ~ '199802') 
   '62099011' (�������) �׸��� "Q_�Ǹŷ�" ,
   '62099101' (�ѿ���) �׸��� "C_�ѿ���" �� ��µǵ��� CASE �Լ��� �߰��Ѵ� */

/* �ܼ��� WHERE ����
     
     WHERE YYMM_YM BETWEEN '199703' AND '199802' 
   
   �ص� ������ ���߿� '199803' �� �Ű������� �ٲ㵵 ����� �� �ֵ��� �Ͽ���.  */

SELECT YYMM_YM AS ���, ITEM_CD AS ��ǰ, 
    ROUND(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END )) AS Q_�Ǹŷ�,
    ROUND(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END )) AS C_�ѿ���
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803';  --å���� �޸� ADD_MONTH �Լ� ���


/* �� ������ ���(YYMM_YM), ��ǰ(ITEM_CD) ���� GROUP BY �Ѵ�
   ������ ��ǰ�� �������, �ѿ��� Data �� ���� �ѹ��� ����Ǿ�  
   �� ���忡�� 2���� ���ڵ徿 �� �׷����� ��������.   */
--�� ��� �׷��Լ��� SUM, MAX, MIN, AVG �ƹ� �ų� �ᵵ �������.

SELECT YYMM_YM AS ���, ITEM_CD AS ��ǰ, 
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_�Ǹŷ�,
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_�ѿ���
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD;

/* �� ������ �ζ��κ�� �Ͽ� ��ǰ���� GROUP BY �ϰ�
   12���� �� �� ��ǰ�� �ּ� / �ִ� �Ǹŷ��� �� ���� ������ ã�ƾ� �Ѵ�. */

-------------------------------------------------------------------------

--������ �߸��� Ǯ�� �����      
--(�߸��� Ǯ��)  
SELECT ��ǰ , 
       MIN(Q_�Ǹŷ�) AS �ּ��Ǹŷ�, 
       MIN(C_�ѿ���) AS "�ּ� �ѿ���", --12���� �� ���� ���� �ѿ��� ��
       MAX(Q_�Ǹŷ�) AS �ִ��Ǹŷ�, 
       MIN(C_�ѿ���) AS "�ִ� �ѿ���"  --12���� �� ���� ū �ѿ��� ��
FROM 
( SELECT YYMM_YM AS ���, ITEM_CD AS ��ǰ, 
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_�Ǹŷ�,
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_�ѿ���
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD )
GROUP BY ��ǰ;

/* <�� ������ �߸��� ���� >
   ��ǰID MC4 : �ּ��Ǹŷ� / �ּ��Ǹŷ��� �ѿ����� ��� 1997�� 12���� ������
                ���� �ڵ�� ��µǴ� �ִ��Ǹŷ� 334920377 �� 1997�� 11��, 
                �ִ��Ǹŷ��� �ѿ��� 383730696 �� 1997�� 12�� DATA �� ���� �ʴ�
   ��ǰID C2- : �ִ��Ǹŷ� 197557081 �� 1998�� 02��,
               �ִ��Ǹŷ��� �ѿ��� 118509480 �� 1997�� 12���� ���� ���� �ʴ� 
  
  <���> 
   �ܼ��� ��ü �Ⱓ ���� �ּ�, �ִ밡 �ƴ϶�
   ��ǰ�� �Ǹŷ��� �ּ�, �ִ��� ���� �ѿ����� ��µǵ��� �ؾ� �Ѵ�  */

---------------------------------------------------------------------------

SELECT YYMM_YM AS ���, ITEM_CD AS ��ǰ, 
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_�Ǹŷ�,
    SUM( ROUND(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_�ѿ���
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD;

/* �� ������ �ζ��κ�� �Ͽ� ��ǰ���� GROUP BY �ϰ�, 
   ��ǰ�� �Ǹŷ��� �ּ�, �ִ��� ���� �ѿ����� ��µǵ��� �����Ѵ�.  */
   
/* C_�ѿ����� ����� ū �� (1�� ����.. ) �� ������ �ſ� ���� ���� ���´�.
   �� �ſ� ���� ���� Q_�Ǹŷ��� ���� �� MIN / MAX �Լ��� �ᵵ 
   ��ü ������ �ٲ��� ���� ���̰�, �ᱹ ���� ���ڵ带 ��ȯ�� ���̴�.
   �� ���� �ٽ� MIN(Q_�Ǹŷ�) �Ǵ� MAX(Q_�Ǹŷ�) ���� �� ��,
   �ٽ� ó���� �������� ����� ū ���� ���ϸ� �ȴ�  */

SELECT ��ǰ , 
    MIN( Q_�Ǹŷ� ) AS "1����_�ּ��Ǹŷ�", 
    ( MIN( Q_�Ǹŷ� + C_�ѿ���/1000000000000 ) - MIN(Q_�Ǹŷ�) ) * 1000000000000   
    AS "�ּ��Ǹſ�_�ѿ���", 
    MAX( Q_�Ǹŷ� ) AS "1����_�ִ��Ǹŷ�", 
    ( MAX(Q_�Ǹŷ� + C_�ѿ���/1000000000000) - MAX(Q_�Ǹŷ�) )  * 1000000000000 
    AS "�ִ��Ǹſ�_�ѿ���"     --  �Է� ������ ����� ū �ѿ��� : 1�� ( 1000000000000 )
FROM 
( SELECT YYMM_YM AS ���, ITEM_CD AS ��ǰ, 
    ROUND( SUM(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_�Ǹŷ� ,
    ROUND( SUM(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_�ѿ���
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD )
GROUP BY ��ǰ;

/*
<����>   
��ǰ  �Ǹŷ�  ����  �Ǹŷ� + ����/(100000: ����� ū��)  �Ǹŷ� + ����/(100000: ����� ū��) - �Ǹŷ�
 m1     1     30         1.00030                             0.00030
 m1     2     20         2.00020                             0.00020
 m2     3     10         3.00010                             0.00010

��ǰ m1 �� �ּ��Ǹŷ��� 1, �׶��� ���� 30 �� �������� �ʹ�.
MIN(�Ǹŷ�) ���� ���ϴ� ���� �ƴϴ�. �׷��� ������ ������ ����� ����ġ �ʴ�.
�ٽ��� �������� ���� ���� ����� ū ������ ������ �ּ�/�ִ� �����Ϳ� ���ϴ� ��
(1) MIN(�Ǹŷ� + ����/100000) ���� �ּڰ��� ���ϰ�  => ���� �����Ϳ����� 1.000030
(2) ���⿡ �ٽ� MIN(�Ǹŷ�) �� �� ��  => MIN(�Ǹŷ� + ����/100000) - MIN(�Ǹŷ�) = 0.00030
(3) * (����� ū ��) �Ѵ�        => �ּ��Ǹŷ��� ���� ���� 30 
*/


/* ���� ������ �ζ��κ�� �Ͽ� ������ ���������� ���������� ����ؾ� �Ѵ�
   �ѱ� ��Ī�� �� �ν��� �ȵǹǷ� ���� ��Ī���� �����Ͽ���  */
SELECT ��ǰ , 
    MIN( Q_�Ǹŷ� ) AS YEARLY_MIN_SALES, 
    ( MIN( Q_�Ǹŷ� + C_�ѿ���/1000000000000 ) - MIN(Q_�Ǹŷ�) ) * 1000000000000   
    AS MIN_TOTALCOST, 
    MAX( Q_�Ǹŷ� ) AS YEARLY_MAX_SALES, 
    ( MAX(Q_�Ǹŷ� + C_�ѿ���/1000000000000) - MAX(Q_�Ǹŷ�) )  * 1000000000000 
    AS MAX_TOTALCOST     --  �Է� ������ ����� ū �ѿ��� : 1�� ( 1000000000000 )
FROM 
( SELECT YYMM_YM AS ���, ITEM_CD AS ��ǰ, 
    ROUND( SUM(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_�Ǹŷ� ,
    ROUND( SUM(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_�ѿ���
FROM TEST17
WHERE YYMM_YM >= TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
      AND YYMM_YM < '199803'
GROUP BY YYMM_YM, ITEM_CD )
GROUP BY ��ǰ;


/* (����) 
   �� ������ �ζ��κ�� �Ͽ� ������ ���������� ���������� ����Ѵ�
   1���� �ִ��Ǹŷ��� �ּ��Ǹŷ��� ���� ��쿡�� ���������� �����Ƿ�
   NULL �� ��µǵ��� CASE �Լ��� �߰��Ͽ���  */
SELECT ��ǰ, 
   ( CASE WHEN YEARLY_MAX_SALES = YEARLY_MIN_SALES THEN NULL
          ELSE ROUND( (MAX_TOTALCOST - MIN_TOTALCOST) / 
                      (YEARLY_MAX_SALES - YEARLY_MIN_SALES) )
          END ) AS �����纯������ ,
  ( CASE WHEN YEARLY_MAX_SALES = YEARLY_MIN_SALES THEN NULL
         ELSE ROUND( MAX_TOTALCOST - (MAX_TOTALCOST - MIN_TOTALCOST) /
                     (YEARLY_MAX_SALES - YEARLY_MIN_SALES) * YEARLY_MAX_SALES )
         END ) AS ��������
FROM 
( SELECT ��ǰ , 
        MIN( Q_�Ǹŷ� ) AS "YEARLY_MIN_SALES", 
        ( MIN( Q_�Ǹŷ� + C_�ѿ���/1000000000000 ) - MIN(Q_�Ǹŷ�) ) * 1000000000000   
        AS "MIN_TOTALCOST", 
        MAX( Q_�Ǹŷ� ) AS "YEARLY_MAX_SALES", 
        ( MAX(Q_�Ǹŷ� + C_�ѿ���/1000000000000) - MAX(Q_�Ǹŷ�) )  * 1000000000000 
        AS "MAX_TOTALCOST"     --  �Է� ������ ����� ū �ѿ��� : 1�� ( 1000000000000 )
FROM 
( SELECT YYMM_YM AS ���, ITEM_CD AS ��ǰ, 
      ROUND( SUM(( CASE BUDGET_CD WHEN '62099011' THEN PROD_AM END ))) AS Q_�Ǹŷ� ,
      ROUND( SUM(( CASE BUDGET_CD WHEN '62099101' THEN PROD_AM END ))) AS C_�ѿ���
FROM TEST17
WHERE YYMM_YM < '199803' AND 
          YYMM_YM >= 
          TO_CHAR(ADD_MONTHS(TO_DATE('199803','RRRRMM'),-12),'RRRRMM')
GROUP BY YYMM_YM, ITEM_CD )
GROUP BY ��ǰ )

---------------------------------------------------------------------------

--p409 ���� 18-1 : �ִ��� �ٸ� ��
SELECT * FROM TEST02;

--�ִ� CRATE 1390 �� ������ ���� : 20100904 => �� ���� AMT 10900
--�ּ� CRATE 1290 �� ������ ���� : 20010911  => �� ���� AMT 12000
SELECT ( MAX( CRATE + AMT/100000 ) - MAX( CRATE ) ) * 100000  AS MAX_CRATE ,
       ( MIN( CRATE + AMT/100000 ) - MIN( CRATE ) ) * 100000  AS MIN_CRATE
FROM TEST02;
-- GROUP BY �ʿ���� : ��ü ���ڵ尡 �ϳ��� �׷����� ���ֵȴ�