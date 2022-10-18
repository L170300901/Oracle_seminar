--p364 �����ϱ� ù ��° ���
SELECT * FROM TEST20;

-- Cartesian Product �� �ڽź��� ū ����Ʈ�� ���εǵ��� �ε�ȣ ���� �߰�
-- 56 point �� 1�� : �ڽź��� ū ����Ʈ�� ������ NULL �� ��µǵ��� Outer Join �߰�
SELECT *
FROM TEST20 A, TEST20 B
WHERE A.POINT < B.POINT (+) ; 


--EMPID �� POINT �� Group By / �ڽź��� ū ����Ʈ�� ������ ������ Count �Լ� �߰�
--(�ڽź��� ū ����Ʈ�� ����) + 1 �� ���(Rank) 
--56 point �� (0 + 1) �� , 24 point �� ���� 10��, �� ���� 23 point �� 12��
SELECT A.EMPID, A.POINT, 
       COUNT(B.POINT) +1 AS RANK  
FROM TEST20 A, TEST20 B
WHERE A.POINT < B.POINT (+)
GROUP BY A.EMPID, A.POINT
ORDER BY RANK;

---------------------------------------------------------------
--p364 �����ϱ� �� ��° ��� (HARD��)
SELECT * FROM TEST20;

SELECT 1/POINT AS POINT_D
FROM TEST20
GROUP BY 1/POINT;
/* �� �ִ� ������ A ��������
   POINT �� Ŀ������ POINT_D �� �۾�����.
   POINT_D 0.04166.. ( POINT 24 ) �� 2���� ���ڵ尡 �ְ� 
   �������� ��� �ٸ� ��, �� �Ѱ��� �ִ�.

   SELECT DISTINCT 1/POINT AS POINT_D FROM TEST20; ����
   �ٲ㵵 ������� 
*/


SELECT 1/POINT AS POINT_D, COUNT(*)-1 AS CNT
FROM TEST20
GROUP BY 1/POINT;
/* �� �ִ� ������ B �������� : A ������������ COUNT(*)-1 �� �߰�
   COUNT(*)-1 => ( ����Ʈ�� ���� ) -1 => ��, �ڽ� �ܿ� �߰��� �����ϴ� �ߺ� ����Ʈ�� ����  */

--���⼭�� POINT_D 0.04166.. ( POINT 24 ) �� CNT �� 1, �������� ��� 0 ���

SELECT *
FROM 
 ( SELECT 1/POINT AS POINT_D
   FROM TEST20
   GROUP BY 1/POINT ) A ,
 ( SELECT 1/POINT AS POINT_D, COUNT(*)-1 AS CNT
   FROM TEST20
   GROUP BY 1/POINT ) B
WHERE A.POINT_D > B.POINT_D (+); -- ������ �� : ���� ����Ʈ�� A < B, �� �ڽ��� �������� ���� �͸� ����
/* 
  A ������������ POINT_D �� 0.1 ( POINT �� 10 ) �̸� 
  B ������������ POINT_D �� 0.1 ���� ���� 
  ( POINT �� 10 ���� ū ) ���鸸 ���εȴ�
  �׷��� POINT_D �� �����̹Ƿ�, 
  �����δ� A �� POINT 10 ���� ū ������ ����� ���̴�
  �� �� B ���������� CNT �� �ڽŰ� ���� �ٸ� ���ڵ��� ��,
  �� POINT_D 0.04166.. �� CNT �� 1�̶�� ���� 
  ��ü �߿��� 0.04166.. ���� �� 2�� �ִ� OR
  �ڽŰ� ���� ���� 1�� �� �ִٴ� �ǹ�

  �ڽź��� POINT �� ū (POINT_D �� ����) ���� 
  B ���������� ��� ��µǾ�� �ϹǷ� �ƿ��� ������ �ߴ� */

SELECT A.POINT_D, SUM(B.CNT) AS ADV
FROM 
 ( SELECT 1/POINT AS POINT_D
   FROM TEST20 
   GROUP BY 1/POINT ) A ,
 ( SELECT 1/POINT AS POINT_D, COUNT(*)-1 AS CNT
   FROM TEST20
   GROUP BY 1/POINT ) B
WHERE A.POINT_D > B.POINT_D (+)
GROUP BY A.POINT_D
ORDER BY A.POINT_D
/* 
  SUM(B.CNT) AS ADV : �ڽź��� ū ���� �� �ߺ��Ǵ� ������ ����

  POINT_D 0.017857.. ( POINT 56, �ִ�) �� ADV �� NULL �� ������
  �ڽź��� ���� ���� �����Ƿ� B ���������� �����ϴ� �� ���� / 
  �׷��� �ƿ��� �����̹Ƿ� A.POINT_D �� ��� ���� ��µǾ�� �� / 
  => �ٷ� �̷� ��� NULL ǥ�õ�

  POINT_D 0.0434782.. ( POINT 23 ) ���� ADV �� 1 ��µǴ� ������
  �ڽ��� POINT ���� ���� �������� 
  POINT_D 0.04166.. ( POINT 24 ) �� 2�� �ֱ� ����..
  COUNT(*)-1 �̹Ƿ� 2 �� �ƴ϶� 1�� ��µȴ�.
  
  ��, �ڽź��� ���� POINT �� �ߺ� ������ 1�� �� �����Ƿ�
  �ڽź��� ���� POINT �� �ߺ��� ���� 9���� �ִٸ� 
  ���� 10���� �ƴ� 11���� �ȴٴ� ���̴�
  
  POINT_D �������� �׷�ȭ�� �������Ƿ� 
  ��� POINT_D �� �ߺ��� ���� ��µȴ�.
  ���� ���Ŀ� �����Ѵٸ� ROWNUM �� ���� ������ ���ʴ�� 
  1, 2, 3 .. ������ �Ű��� ���̴�

  ���� �ڽ��� ������ 
  ROWNUM + ( �ڽź��� ū ���� �� �ߺ��Ǵ� ������ ���� , �� ADV )
  �� �ȴ�.
*/

/* POINT �� �ƴ� 1/POINT �� �����ؾ� �ϴ� ���� (�Ǵ� �����ؾ� ���� ����)
  ROWNUM �� ���� ������ ������� 1, 2, 3 ������ �Ű�������
  ������ ( ū ����Ʈ ) => ( ���� ����Ʈ ) ������ �Ű�����.

  POINT ��� 1/POINT �� ���� ROWNUM �̳� 1/POINT ��
  �Ȱ��� ���� ������ �Ű����� �Ǹ� 
  ROWNUM �� (�ڽź��� ū �� �� �� �ߺ� ������ ����) �� ���ϸ�
  �ڽ��� ������ �ȴ� 
*/

SELECT POINT_D, ROWNUM AS GRAD, ADV
FROM
( SELECT A.POINT_D, SUM(B.CNT) AS ADV
  FROM
  ( SELECT 1/POINT AS POINT_D
    FROM TEST20
    GROUP BY 1/POINT ) A, 
  ( SELECT 1/POINT AS POINT_D, COUNT(*)-1 CNT
    FROM TEST20
    GROUP BY 1/POINT ) B
  WHERE A.POINT_D > B.POINT_D (+)  
  GROUP BY A.POINT_D
  ORDER BY A.POINT_D );
--������ ���忡�� POINT_D, ROWNUM �� GRAD, ADV �� �о�´�
--�� ������ ���� ���̺��� TEST20 �� �ٽ� �����Ѵ�.

SELECT A1.EMPID, 
    ( CASE WHEN GRAD+ADV IS NULL THEN 1 ELSE GRAD+ADV END ) AS ����
FROM TEST20 A1 ,
  ( SELECT POINT_D, ROWNUM AS GRAD, ADV
    FROM
    ( SELECT A.POINT_D, SUM(B.CNT) AS ADV
      FROM
      ( SELECT 1/POINT AS POINT_D
        FROM TEST20
        GROUP BY 1/POINT ) A, 
      ( SELECT 1/POINT AS POINT_D, COUNT(*)-1 CNT
        FROM TEST20
        GROUP BY 1/POINT ) B
      WHERE A.POINT_D > B.POINT_D (+)  -- ������ �� : ���� ����Ʈ�� A < B, �� �ڽ��� �������� ���� �͸� ����
    GROUP BY A.POINT_D
    ORDER BY A.POINT_D ) ) B1 
WHERE 1/A1.POINT = B1.POINT_D -- A1.POINT = B1.POINT_D �� �ƴ�
ORDER BY ����;

/*  B1 ������������ POINT_D �� ���� ������ ���� 
    => POINT �� ū ������ �����ϴ� �Ͱ� ���� �ǹ��̴�

 �ڽ��� ������ ROWNUM �̾��� GRAD + 
 �ڽź��� ū �� �� �ߺ� ������ ���� ADV �� �ȴ�

 SELECT ������ 
 ( ~ GRAD+ADV WHEN NULL ~ ) �ϸ�  
 GRAD + ADV = NULL �� ���� ���ǽ��̴�
 �׷��� NULL �� ������ ��Ģ������ �ϸ� TRUE/FALSE �� �ƴ� NULL ��ȯ,   
 �� ��쿡�� ���� ū ���� ��� 1 �� ǥ�õǾ�� �ϳ� 
 �����δ� NULL �� ǥ�õ�    */

--------------------------------------------------------------------
--���� 1/POINT ���� POINT �� Ǭ�ٸ� ������ ���� Ǯ�� �ȴ�
SELECT * FROM TEST20;

SELECT POINT 
FROM TEST20
GROUP BY POINT;  -- A ��������

SELECT POINT , COUNT(*)-1 
FROM TEST20
GROUP BY POINT;  --B �������� : ( ����Ʈ�� ���� ) -1 �� �߰��� 
                 --          => �ڽ� �ܿ� �߰��� �����ϴ� �ߺ� ����Ʈ�� ����

/*  A, B ���������� ���� �� �׷�ȭ�Ѵ�. 
    1/POINT �� Ǯ ���� ������ ��
    WHERE ������ �ε�ȣ ������ �ٲ�� �������� ������ �߰��ȴ� */  
-- SUM(B.CNT) AS ADV : �ڽź��� ū ���� �� �ߺ��Ǵ� ������ ���� 

SELECT A.POINT, SUM(B.CNT) AS ADV   
FROM
( SELECT POINT 
  FROM TEST20
  GROUP BY POINT) A,
( SELECT POINT , COUNT(*)-1 AS CNT
  FROM TEST20 
  GROUP BY POINT ) B
WHERE A.POINT < B.POINT (+)  -- å�� ������ �ε�ȣ�� ������ �ݴ���
GROUP BY A.POINT 
ORDER BY A.POINT DESC;  --�ݵ�� �������� ������ �ؾ� ū ����Ʈ���� ROWNUM �� �Ű�����

--ROWNUM �� �ű�� ���� ���� ������ FROM ���� �ζ��� ��� �ְ� �ٽ� SELECT �Ѵ�
SELECT ROWNUM AS GRAD, POINT, ADV  
FROM 
( SELECT A.POINT, SUM(B.CNT) AS ADV
  FROM
  ( SELECT POINT 
    FROM TEST20 
    GROUP BY POINT ) A,
  ( SELECT POINT , COUNT(*)-1 AS CNT
    FROM TEST20 
    GROUP BY POINT ) B
  WHERE A.POINT < B.POINT (+)  
  GROUP BY A.POINT 
  ORDER BY A.POINT DESC ); 

/* EMPID �� ����ϱ� ���� ���� ����� T1, TEST20 ���̺��� T2 �� ���� ����  */
SELECT *
FROM
( SELECT ROWNUM AS GRAD, POINT, ADV  
  FROM 
  ( SELECT A.POINT, SUM(B.CNT) AS ADV
    FROM
    ( SELECT POINT 
      FROM TEST20 
      GROUP BY POINT ) A,
    ( SELECT POINT , COUNT(*)-1 AS CNT
      FROM TEST20 
      GROUP BY POINT ) B
    WHERE A.POINT < B.POINT (+)  
    GROUP BY A.POINT 
    ORDER BY A.POINT DESC ) ) T1,
  TEST20 T2 
WHERE T1.POINT = T2.POINT;  -- 1/POINT �� Ǯ ���� �ٸ� ��

/* ���� ������� SELECT �� ���� : ���ID, ����Ʈ, ����  
   ������ ( CASE WHEN ADV IS NULL THEN 1 ELSE GRAD+ADV END ) �� ó���Ѵ�  */
SELECT T2.EMPID, T2.POINT, 
       ( CASE WHEN ADV IS NULL THEN 1 ELSE GRAD+ADV END ) AS ����
FROM
( SELECT ROWNUM AS GRAD, POINT, ADV  
  FROM 
  ( SELECT A.POINT, SUM(B.CNT) AS ADV
    FROM
    ( SELECT POINT 
      FROM TEST20 
      GROUP BY POINT ) A,
    ( SELECT POINT , COUNT(*)-1 AS CNT
      FROM TEST20 
      GROUP BY POINT ) B
    WHERE A.POINT < B.POINT (+)  
    GROUP BY A.POINT 
    ORDER BY A.POINT DESC ) ) T1,
  TEST20 T2 
WHERE T1.POINT = T2.POINT
ORDER BY ����;

-------------------------------------------------------------------

--p370 ���� 15-1 : ���� ���ϱ�

SELECT * FROM TEMP;

SELECT 1/SALARY FROM TEMP GROUP BY 1/SALARY;

SELECT 1/SALARY, COUNT(*)-1 FROM TEMP GROUP BY 1/SALARY;

SELECT B.EMP_ID, B.SALARY, 
      ( CASE WHEN ADV IS NULL THEN 1 ELSE GRAD+ADV END ) AS ����
FROM
( SELECT ROWNUM AS GRAD, SALARY_D, ADV
  FROM 
 ( SELECT A.SALARY_D, SUM(B.CNT) AS ADV
   FROM 
   ( SELECT 1/SALARY AS SALARY_D 
     FROM TEMP
     GROUP BY 1/SALARY) A ,
   ( SELECT 1/SALARY AS SALARY_D, COUNT(*)-1 AS CNT 
     FROM TEMP 
     GROUP BY 1/SALARY ) B
   WHERE A.SALARY_D > B.SALARY_D (+)
   GROUP BY A.SALARY_D
   ORDER BY A.SALARY_D ) ) A, TEMP B
WHERE 1/B.SALARY = A.SALARY_D
ORDER BY  ����;

-------------------------------------------------------------------
--p374 �����ϱ� : �׷� ������ ���� �ο�


--�׳� TEST12 �� �ƴ϶� ���ĵ� TEST12 �� ����Ѵ�. ������ �������� ���´�
SELECT * FROM TEST12 ORDER BY PRESS, BOOK_TYPE;  

/* ���� ����� PRESS, BOOK_TYPE ���� �׷�ȭ�Ѵ� 
   �� �׷��� ���ڵ� ���� CNT �� �ȴ�.    
   ���⼭�� CNT ���� (���� ���ǻ�) �Ҽ� 4, ���� 4, �� 4, 
                    (�ѱ�����) ������ 7, ���� 5 �� ��µȴ� */
SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
FROM ( SELECT * FROM TEST12 ORDER BY PRESS, BOOK_TYPE )
GROUP BY PRESS, BOOK_TYPE;  

/* ���̺� ���� 1�ܰ� : ���� �����  ROWNUM �� �ִ� TEST12 ���̺�� Cartesian Product */
SELECT * 
FROM
( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
  FROM ( SELECT * FROM TEST12 ORDER BY PRESS, BOOK_TYPE )
  GROUP BY PRESS, BOOK_TYPE ) A ,
( SELECT ROWNUM AS RCNT FROM TEST12 ) B;

/* ���̺� ���� 2�ܰ� : �츮�� ���ϴ� ���� ������ �׷��� CNT ����ŭ ������ �̷������ ��
   ���� ����� �ʹ� ���� ���ڵ尡 ��µȴ�. 
   �ʿ��� ����� ������ ���� WHERE ������ �߰��Ѵ�   */

/*  <�߿�!> ���߿� ���� Data �� 1:1 �� ������ �� ������ ��Ȯ�� ���߱� ���ؼ�
            �������� ORDER BY PRESS, BOOK_TYPE, RCNT �� �߰��Ѵ�      */
SELECT * 
FROM
( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
  FROM TEST12
  GROUP BY PRESS, BOOK_TYPE ) A ,
( SELECT ROWNUM AS RCNT FROM TEST12 ) B   --RCNT �� �׷캰 �Ϸù�ȣ ������ �Ѵ�
WHERE A.CNT >= B.RCNT  
ORDER BY PRESS, BOOK_TYPE, RCNT;


/* �� ������ FROM ���� �ζ��κ�� �Ͽ� 
   ROWNUM �� RNUM �� �׷캰 �Ϸù�ȣ�� RCNT �� �߷�����  
   RCNT �� (���� ���ǻ�) �Ҽ� 1~4, ���� 1~4, �� 1~4, 
           (�ѱ�����) ������ 1~7, ���� 1~5 ������ ��µǾ�� �Ѵ�   */

SELECT ROWNUM AS RNUM, RCNT
FROM
( SELECT * 
  FROM
  ( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
    FROM TEST12
    GROUP BY PRESS, BOOK_TYPE ) A ,
  ( SELECT ROWNUM AS RCNT FROM TEST12 ) B
  WHERE A.CNT >= B.RCNT 
  ORDER BY PRESS, BOOK_TYPE, RCNT );



/* ���� ���, �� �׷캰 �Ϸù�ȣ�� �ִ� ���� �������� T1, 
   ���� Data �� �ִ� ( SELECT * FROM TEST12 ORDER BY PRESS, BOOK_TYPE ) �� 
   �������� T2 �� ���� 1:1 �� �����Ͽ� ��ġ�� ��.
   
   ������ �� ������������ ���ν� ����� Unique �� ���� ROWNUM �� RNUM �ۿ� ���ٴ� ��.

   A, B ��� ������ ��Ȯ�� �����ߴٸ� �� ����� ���ڵ� ������ ��ġ�� �� �ۿ� ����.
   �������� �ʾҴٸ� �̻��� ���ڵ忡 �Ϸù�ȣ�� �Ű��� �� �ִ�.   */

SELECT *
FROM
( SELECT ROWNUM AS RNUM, RCNT 
  FROM
  ( SELECT * 
    FROM
    ( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
      FROM TEST12
      GROUP BY PRESS, BOOK_TYPE ) A ,
    ( SELECT ROWNUM AS RCNT FROM TEST12 ) B
    WHERE A.CNT >= B.RCNT 
    ORDER BY PRESS, BOOK_TYPE, RCNT ) ) T1,  -- ROWNUM �� �Ϸù�ȣ ����
( SELECT ROWNUM AS RNUM, PRESS, BOOK_TYPE, BOOK_NAME, PRICE 
  FROM TEST12 
  ORDER BY PRESS, BOOK_TYPE ) T2  -- ROWNUM �� ���� Data ����
WHERE T1.RNUM = T2.RNUM;

--���� : ���� SELECT ���� ��µ� �÷��� ������ �ָ� ��.
SELECT T1.RNUM AS ��ü��ȣ, T1.RCNT AS �Ϸù�ȣ, PRESS AS ���ǻ�, BOOK_TYPE AS ����,
          BOOK_NAME AS å��, PRICE AS ���� 
FROM
( SELECT ROWNUM AS RNUM, RCNT 
FROM
( SELECT * 
  FROM
  ( SELECT PRESS, BOOK_TYPE, COUNT(*) AS CNT
    FROM TEST12
    GROUP BY PRESS, BOOK_TYPE ) A ,
  ( SELECT ROWNUM AS RCNT FROM TEST12 ) B
  WHERE A.CNT >= B.RCNT 
  ORDER BY PRESS, BOOK_TYPE, RCNT ) ) T1,
( SELECT ROWNUM AS RNUM, PRESS, BOOK_TYPE, BOOK_NAME, PRICE 
  FROM TEST12 
  ORDER BY PRESS, BOOK_TYPE ) T2
WHERE T1.RNUM = T2.RNUM;