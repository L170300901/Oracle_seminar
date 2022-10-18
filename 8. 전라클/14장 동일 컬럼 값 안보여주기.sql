--p351 �����ϱ� : ���� �� �Ⱥ����ֱ�
* 
SELECT * FROM TEST09;

SELECT ROWNUM AS CNT1, LINE, SPEC, ITEM, QTY FROM TEST09;
SELECT ROWNUM AS CNT2, LINE, SPEC, ITEM, QTY FROM TEST09;

/* �Ʒ� �������� WHERE A.CNT1-1 = B.CNT2 (���� ����) �� �ϰ� �Ǹ� 
   �ζ��κ� A�� ù��° ���ڵ�� ��µ��� �ʴ´�.
   ������ �ڽ��� ���� ���ڵ尡 ���� ���� : ���������� ���� ��ġ�ϴ� ���ڵ常 ����Ѵ�
   �ζ��κ� A�� ù��° ���ڵ嵵 ��µǵ��� ( OR �ζ��κ� A�� ��� ���ڵ尡 ��µǵ��� )
   �ϱ� ���� �ƿ��� ������ �Ǵ�.
   �� �� ù ��° ���ڵ��� ���� ���ڵ�� �����Ƿ� NULL �� ǥ�õȴ�.  */
SELECT *
FROM 
( SELECT ROWNUM AS CNT1, LINE, SPEC, ITEM, QTY FROM TEST09 ) A,
( SELECT ROWNUM AS CNT2, LINE, SPEC, ITEM, QTY FROM TEST09 ) B
WHERE A.CNT1-1 = B.CNT2 (+)  -- �ζ��κ� A�� ��� ���ڵ尡 ��µǵ��� �ƿ�������
ORDER BY A.CNT1;



/* CASE �Լ��� IF ���� ���� ������ �Ѵ�. ���ǿ� ���� ��µǴ� ����� �޶�����.
   �ζ��κ� A �� LINE ���� B �� LINE ���� ���ٴ� ���� �ڽ��� ���� ���ڵ�� ���� ���ٴ� ���̴�.
   ��, ���� �ߺ��ȴٴ� �ǹ� : �̷� ��� LINE �ʵ��� ���� NULL 
   ���� ���� �ʴٸ� (ELSE) ���� �ڽ��� �� (A.LINE) �� ����Ѵ�.
   SPEC �÷������� CASE �Լ��� ���� �ǹ��̴�.  */

-- CASE �Լ� �� �� �ݵ�� �������� ~ END ���� ��!
SELECT ( CASE WHEN A.LINE = B.LINE THEN NULL 
              ELSE A.LINE END ) AS LINE,   --LINE �÷������� CASE �Լ� : 
       ( CASE WHEN A.LINE || A.SPEC = B.LINE || B. SPEC THEN NULL 
              ELSE A.SPEC END ) AS SPEC,   --SPEC �÷������� CASE �Լ�
          A.ITEM, A.QTY
FROM 
( SELECT ROWNUM AS CNT1, LINE, SPEC, ITEM, QTY FROM TEST09 ) A,
( SELECT ROWNUM AS CNT2, LINE, SPEC, ITEM, QTY FROM TEST09 ) B
WHERE A.CNT1 - 1 = B.CNT2 (+)
ORDER BY A.CNT1;

/* ���� CASE ���� �پ��ϰ� ������ �� �ִ�. WHEN �� ��ġ�� �ָ��� ��!
 (1) CASE A.LINE WHEN B.LINE THEN NULL 
                 ELSE A.LINE END
 (2) CASE WHEN A.LINE <> B.LINE THEN A.LINE 
          WHEN A.LINE = B.LINE THEN NULL END */

----------------------------------------------------------------------

--p355 ���� 14-1 : ������ �÷��� �Ⱥ��̰� �ϱ�  => ������ ���� ������ ����
SELECT ROWNUM AS CNT1, PRESS, BOOK_TYPE, BOOK_NAME, PRICE FROM TEST12;
SELECT ROWNUM AS CNT2, PRESS, BOOK_TYPE, BOOK_NAME, PRICE FROM TEST12;

SELECT ( CASE WHEN A.PRESS = B.PRESS THEN NULL 
              ELSE A.PRESS END ) AS PRESS ,
       ( CASE WHEN A.PRESS || A.BOOK_TYPE = B.PRESS || B.BOOK_TYPE THEN NULL 
              ELSE A.BOOK_TYPE END ) AS BOOK_TYPE , 
        A.BOOK_NAME, A.PRICE
FROM 
( SELECT ROWNUM AS CNT1, PRESS, BOOK_TYPE, BOOK_NAME, PRICE 
  FROM TEST12 ) A ,
( SELECT ROWNUM AS CNT2, PRESS, BOOK_TYPE, BOOK_NAME, PRICE 
  FROM TEST12 ) B
WHERE A.CNT1 -1 = B.CNT2 (+)
ORDER BY A.CNT1;