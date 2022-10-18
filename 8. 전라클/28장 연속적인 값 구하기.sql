--p523 �����ϱ� : ����ִ� �� ã��

SELECT * FROM TEST;

SELECT A, MIN(B) AS MIN, MAX(B) AS MAX
FROM TEST
GROUP BY A;  
/* TEST ���̺��� ���� A ���� �׷�ȭ�Ͽ� ������ �ּ�/�ִ� B���� ���Ѵ�
   �� ������ �Ʒ��� T1 �������� (�ζ��� ��) �� �ȴ�
   �� ������ 1, 2, 3, ... �������� ROWNUM �� �ִ� ���̺�� �����ϰ�
   ROWNUM >= ( �ּڰ� MIN ), ROWNUM <= ( �ִ� MAX ) ������ �ش�   */
  

SELECT *    -- �ϴ� ��� ����ϰ� ���� ���صǸ� T1.A, T2.R_CNT AS B �� ����ϵ��� �ٲٱ�
FROM
( SELECT A,  MIN(B) AS MIN, MAX(B) AS MAX
  FROM TEST
  GROUP BY A ) T1 ,
( SELECT ROWNUM as R_CNT 
  FROM TEST01    -- ����� ���� ���ڵ尡 �ִ� ���̺� : TEST01 ���� 1000��
  WHERE ROWNUM <= 
        ( SELECT MAX(B) FROM TEST ) ) T2   -- TEST �� ��� B �� �ִ񰪺��� ���� ROWNUM �� �о����
WHERE T1.MIN <=T2.R_CNT AND T1.MAX >=T2.R_CNT ;  
/* 19981113 �� �ּڰ� 1 ~ �ִ� 11 ����, 
   19981114 �� �ּڰ� 1 ~ �ִ� 8 ���� ���� �κ��� ���� ��� ����ϴ� �ڵ� */
 

--å��� Ǯ�� : (���� ���� �κ� ���� ����) MINUS ( TEST ) => ���� �κ�
SELECT T1.A, T2.B
FROM
( SELECT A,  MIN(B) AS MIN, MAX(B) AS MAX
  FROM TEST
  GROUP BY A ) T1 ,
( SELECT ROWNUM as R_CNT 
  FROM TEST01    -- ����� ���� ���ڵ尡 �ִ� ���̺� : TEST01 ���� 1000��
  WHERE ROWNUM <= 
        ( SELECT MAX(B) FROM TEST ) ) T2   -- TEST �� ��� B �� �ִ񰪺��� ���� ROWNUM �� �о����
WHERE T1.MIN <=T2.R_CNT AND T1.MAX >=T2.R_CNT
MINUS
SELECT A, B FROM TEST;



--�ٸ� Ǯ�� : �ƿ��� ���� �̿�
/* TEST ���̺��� T3, ���� ���� �κ� ���� ������ �������� T4 �� �ΰ� ���ν�Ų��
  ���� �ڷᰡ ���� ���� T4 : T4 �� ��� ���� ��µǵ��� �ƿ��� ���ν�Ų�� */

SELECT *   -- �ϴ��� ��� ��� : ���� �κи� ������� � �ʵ� / � ������ �ʿ��ұ�?
FROM TEST T3,
( SELECT T1.A, T2.R_CNT
  FROM
  ( SELECT A,  MIN(B) AS MIN, MAX(B) AS MAX
    FROM TEST
    GROUP BY A ) T1 ,
  ( SELECT ROWNUM as R_CNT 
    FROM TEST01    -- ����� ���� ���ڵ尡 �ִ� ���̺� : TEST01 ���� 1000��
    WHERE ROWNUM <= 
            ( SELECT MAX(B) FROM TEST ) ) T2   -- TEST �� ��� B �� �ִ񰪺��� ���� ROWNUM �� �о����
    WHERE T1.MIN <=T2.R_CNT AND T1.MAX >=T2.R_CNT ) T4
WHERE  T3.A (+) = T4.A AND T3.B (+) = T4.R_CNT ;



-- ��ü Ǯ�� ���� : ���� �ڷḸ �����ֱ� ���� T3.A IS NULL ���� �߰�
SELECT T4.A AS A, T4.R_CNT AS B
FROM TEST T3,
( SELECT T1.A, T2.R_CNT
  FROM
  ( SELECT A,  MIN(B) AS MIN, MAX(B) AS MAX
    FROM TEST
    GROUP BY A ) T1 ,
  ( SELECT ROWNUM as R_CNT 
    FROM TEST01    -- ����� ���� ���ڵ尡 �ִ� ���̺� : TEST01 ���� 1000��
    WHERE ROWNUM <= 
          ( SELECT MAX(B) FROM TEST ) ) T2   -- TEST �� ��� B �� �ִ񰪺��� ���� ROWNUM �� �о����
    WHERE T1.MIN <=T2.R_CNT AND T1.MAX >=T2.R_CNT ) T4
WHERE T3.A (+) = T4.A AND T3.B (+) = T4.R_CNT 
   AND T3.A IS NULL;

------------------------------------------------------------------------

--p527 �����ϱ� : �߰��� ���ϱ�

--(1) ��ü Ǯ�� : MONTHS_BETWEEN �Լ� ��� ( ����Ŭ p294 )

SELECT MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , TO_DATE('200106' , 'RRRRMM') ) 
FROM DUAL;   -- 10 ��� : ó�� �� ('200106') �� ���Ե��� �ʾ���, �츮�� ���ϴ� ���� 11

SELECT MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , 
                       ADD_MONTHS( TO_DATE('200106' , 'RRRRMM') ,-1 ) ) 
FROM DUAL;   -- 11 ��� : ó�� �� ('200106') �� �� �� �������� Count


--TEST01 ���� �ʿ��� ��������ŭ ROWNUM ���
SELECT ROWNUM AS n
FROM TEST01
WHERE ROWNUM <= MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , 
                                ADD_MONTHS( TO_DATE('200106' , 'RRRRMM') ,-1 ) ) ;

/* ���� ���忡 TIT �÷� �߰� : '200106' �� ��¥ ��ȯ�� �� ROWNUM-1 ��ŭ ADD_MONTHS 
   �� �� 01/06/01 �������� ��� : ��µǴ� ��¥�� ������ �Ŀ� ���� �ٸ� �� ���� */                  
SELECT ROWNUM AS n, 
       ADD_MONTHS( TO_DATE('200106' , 'RRRRMM'), ROWNUM-1 ) AS TIT
FROM TEST01
WHERE ROWNUM <= MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , 
                                ADD_MONTHS( TO_DATE('200106' , 'RRRRMM') ,-1 ) ) ;

-- TO_CHAR ( ��¥ , 'RRRR.DD') �������� ��¥�� ���ڿ��� ��ȯ 
SELECT ROWNUM AS n, 
       TO_CHAR( ADD_MONTHS( TO_DATE('200106' , 'RRRRMM'), ROWNUM-1 ) ,'RRRR.MM' )  AS TIT 
FROM TEST01
WHERE ROWNUM <= MONTHS_BETWEEN( TO_DATE('200204', 'RRRRMM') , 
                                ADD_MONTHS( TO_DATE('200106' , 'RRRRMM') ,-1 ) ) ;

---------------------------------------------------------------------------------

--p527 �����ϱ� : �߰��� ���ϱ�

--(2) å�� Ǯ�� : TEST01 ���̺��� B �̿� (�Ǵ� ROWNUM �� ���� )
SELECT B FROM TEST01;  -- 1, 2, 3 .. �̷� �����Ͱ� �ʿ��ϴ� => ���� 1000�� ��µ�


/* TIT �ʵ� �߰� : '200106' �� B-1 ��ŭ ADD_MONTHS 
   ù ��° ���ڵ忡�� B �� 1 => '200106' �� (1-1)��, �� 0�� �߰� => '01/06/01' ��µ�   
   �̷� ������ 1000�� �ݺ� => ������ 1000��° ���ڵ�� '84/09/01' ��µ�     */
SELECT B, 
       ADD_MONTHS( TO_DATE('200106','RRRRMM'), B-1 ) AS TIT
FROM TEST01;


-- ��� �����  TO_DATE('200204','RRRRMM') ���� �������� WHERE ���� �߰�
SELECT B, 
       ADD_MONTHS( TO_DATE('200106','RRRRMM'), B-1 )
FROM TEST01
WHERE ADD_MONTHS( TO_DATE('200106','RRRRMM'), B-1 ) <= TO_DATE('200204','RRRRMM');


--'2001.06' �������� ��µǵ��� TO_CHAR �Լ� �߰�
SELECT B, 
       TO_CHAR(ADD_MONTHS ( TO_DATE('200106','RRRRMM'), B-1),'RRRR.MM')
FROM TEST01
WHERE ADD_MONTHS ( TO_DATE('200106','RRRRMM'), B-1) <= TO_DATE('200204','RRRRMM');


---------------------------------------------------------------------------------

--p532 �����ϱ� : ���� �̻� ���ϱ� II
--���� ���ο� ����� �ʿ��� ���� : p531 ~ p532 ���� ����

SELECT * FROM TEST37;

--p532 (1) : �ٷ� ���� ���ڵ� ���� �����ϱ�
SELECT T1.DATA1 , T2.DATA2
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,  --DATA ���� ���ڷ� ġȯ
     ( SELECT ROWNUM as n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2
WHERE T1.n -1 = T2.n (+)  -- DATA1 �� ���� ���ڵ� ���� DATA2 �� �����
ORDER BY T1.n;


--p532 (2) : å����ó�� �ζ��� �並 ������� �ʰ� WHERE ���� �߰��Ͽ� �ذ��Ͽ���
/* �ڽŰ� ���� ���ڵ���� �� ���̰� 1�̶�� �ǹ̴�  ���� �κ��� ���ٴ� �ǹ�, 
   �׷� DATA �� ���⼭�� �ʿ� �����Ƿ� WHERE ������ �߰��Ͽ� ���ܽ��״�  */
SELECT T1.DATA1 , T2.DATA2
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,
     ( SELECT ROWNUM as n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2
WHERE T1.n -1 = T2.n (+) AND T1.DATA1 - nvl(T2.DATA2,0) > 1  --NULL ���� 0���� ġȯ�ؾ� ������ ����
ORDER BY T1.n;            



--p532 (3) : ���ӵ� ROWNUM �� ��� ���̺��� FROM ���� �߰�
/* ���⼭�� SELECT ROWNUM AS n FROM USER_TABLES  => 1~61 ������ ROWNUM �� �ִ� ���̺�
   ���� ��� 4�� ���ڵ� x 61 => �� 244 ���� ���ڵ� ��µȴ� ( Cartesian Product )  */

SELECT T3.n, T1.DATA1 , T2.DATA2
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,
     ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2 ,
     ( SELECT ROWNUM AS n FROM USER_TABLES ) T3  -- 1~61 ������ ROWNUM �� �ִ� ���̺�
WHERE T1.n -1 = T2.n (+) AND T1.DATA1 - nvl(T2.DATA2,0) > 1  -- NULL ���� 0���� ġȯ�ؾ� ������ ����
ORDER BY T1.n;  


/*   DATA1   DATA2        ���� ���ڵ� : rownum �� n �߿��� ���õǵ��� ����!
       3       0      =>     1, 2          
       6       3      =>     4, 5              
      10       6      =>     7, 8, 9
      13      10      =>     11, 12
  where ���ǿ� ~ AND  T3.n < T1.DATA1 - T2.DATA2 �� �߰��Ѵ�.  */   

/* ������ �� Data �� �� ���̺��� ũ�ų� ���� ROWNUM �� �ʿ��ϴٴ� ����
   ���� ����� ���� Ȯ���� �� �ִ�       */
SELECT T3.n, T1.DATA1 , T2.DATA2
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,
     ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2 ,
     ( SELECT ROWNUM AS n FROM USER_TABLES ) T3  -- 1~61 ������ ROWNUM �� �ִ� ���̺�
WHERE T1.n -1 = T2.n (+) AND T1.DATA1 - nvl(T2.DATA2,0) > 1  -- NULL ���� 0���� ġȯ�ؾ� ������ ����
      AND  T3.n < T1.DATA1 - T2.DATA2
ORDER BY T1.n;  



/* ���� : SELECT ���� TO_CHAR( T3.N + T2.DATA2, '0000' ) ���� �����Ѵ�.
   TO_CHAR �Լ��� ���� ����� 4�ڸ� ���ڿ��� ��µȴ�  
   ������ ���� ORDER BY ���� �ٲ��ش�          */

SELECT TO_CHAR( T3.N + T2.DATA2, '0000' ) 
FROM ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA1 FROM TEST37 ) T1 ,
     ( SELECT ROWNUM AS n, TO_NUMBER(DATA) AS DATA2 FROM TEST37 ) T2 ,
     ( SELECT ROWNUM AS n FROM USER_TABLES ) T3  -- 1~61 ������ ROWNUM �� �ִ� ���̺�
WHERE T1.n -1 = T2.n (+) AND T1.DATA1 - nvl(T2.DATA2,0) > 1  -- NULL ���� 0���� ġȯ�ؾ� ������ ����
      AND  T3.n < T1.DATA1 - T2.DATA2
ORDER BY TO_CHAR( T3.N + T2.DATA2, '0000' );  

/* <����Ʈ> �� ����� ���ϱ� ���ؼ���, ROWNUM �� �ִ� ���̺��� ROWNUM ����
   ���� �κ��� ã���� �ϴ� Data �� ������ �� ���� ������ ���̵��� 
   �ִ񰪺��� ũ�ų� ���ƾ� �Ѵ� */ 

------------------------------------------------------------------------------------

--p537 �����ϱ� : ���� �̻� ���ϱ� III
SELECT * FROM TEST38;

--ASCII �Լ��� CHR �Լ�
SELECT ASCII('A'), ASCII('B'), ASCII('C') FROM DUAL;
SELECT CHR(65), CHR(66),CHR(67) FROM DUAL;

--SUBSTR �Լ��� �̿��Ͽ� ó�� �����ڿ� ������ ���ڸ� ���� �и�
SELECT SUBSTR(VAL1,1,1) || ' & ' || SUBSTR(VAL1,2,2) 
FROM TEST38;


/* ( �������� �ƽ�Ű�ڵ� �� - 65 ) * 100  =>  A �� 0, B �� 100, C �� 200 ... ���� ��ȯ��
   SUBSTR(VAL1,2) �� VAL1 ���� �ι�° �ڸ����� �������� ���� ��ȯ�Ѵ�
   �츮�� ã�� ���ڴ� 2�ڸ��̹Ƿ� SUBSTR(VAL1,2,2) �� �ٲ㵵 �������    */ 
SELECT ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 || ' & ' || SUBSTR(VAL1,2) 
FROM TEST38;

--���� �� ���� ���� : A97 �� 97 , B10 �� 110 , B12 �� 112 �� ��ȯ��
SELECT ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) 
FROM TEST38;

------------------------------------------------------------------------------------

--1�ܰ� ��, 2�ܰ� : ����� ROWNUM �� �ִ밪�� ���ϴ� 2���� ���

--(1) ���� ���忡 MAX �Լ��� �߰� : �ִ� 112 ���
SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
FROM TEST38;

--(2) å�� Ǯ�� : VAL1 �� ��� MAX(VAL1) ���� �ٲ۴� : �ִ� 112 ��� 
--å������ SUBSTR(MAX(VAL1),2) �� �ٽ� TO_NUMBER �Լ� ���� : ���ص� ���� ��µȴ� 
SELECT ( ASCII( SUBSTR(MAX(VAL1),1,1) ) -65 ) * 100 + SUBSTR(MAX(VAL1),2)
FROM TEST38;

/* ���� 2������ �ϳ��� WHERE ���ǿ� �ְ� TEST01 ���̺��� B �÷����� ���ӵǴ� ���ڸ� �����Ѵ� 
   �� ��µǴ� B �� ���� 1�� ���ش�. �׷��� 0���� 112 ���� ��µȴ�.
   ���ִ� ������ �� ó�� ���ڿ� A00 �� 0 �� �����ϱ� �����̴�        */
SELECT B-1 NO 
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 );   

------------------------------------------------------------------------------------

--2�ܰ� ��, 3�ܰ� : ���� �������� 0 ~ 112 �� ���ӵǴ� ���ڸ� A00 ~ B12 �� �ٽ� ��ȯ�Ѵ�

-- ��� (1) : B-1 ���� LPAD(), SUBSTR() �Լ� ���
SELECT LPAD(B-1,3,'0')    -- 0 => '000', 12 => '012', 101 => '101' ..3�ڸ� ���ڿ��� �ٲ�
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 );  

-- SUBSTR() �Լ��� ( ���� ���ڸ� ���� + 65 ) �� ���� CHR �Լ��� ���� ��ȯ || ���� 2����
SELECT CHR(SUBSTR(LPAD(B-1,3,'0'), 1,1) + 65 ) || SUBSTR( LPAD(B-1,3,'0'), 2) AS VAL
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 ); 


-- ��� (2) : B-1 ���� FLOOR() �Լ� ����ϰ�
--        => B-1 �� 100 ���� ���� ������ �۰ų� ���� ���� ū ���� ��ȯ
SELECT FLOOR((B-1)/100)     --  �ݵ�� B-1 �� ( ) ó��, B-1/100 �� B �� 0.01 �� ���� ��   
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 );  

--���� FLOOR((B-1)/100) �� 65 ���ϰ� CHR() �Լ��� ���� ��ȯ
--SUBSTR( LPAD(B-1,3,'0'), 2) : B-1 ���� �� 3�ڸ��� ���� �� ���� 2���� ��ȯ
SELECT CHR(FLOOR((B-1)/100)+65) || SUBSTR( LPAD(B-1,3,'0'), 2) AS VAL
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 );  

------------------------------------------------------------------------------------
--4�ܰ� (����) : ���� ������ Data ���� TEST �� ���� (MINUS) �ȴ�
SELECT CHR(FLOOR((B-1)/100)+65) || SUBSTR( LPAD(B-1,3,'0'), 2)
FROM TEST01
WHERE B-1 <= ( SELECT MAX( ( ASCII( SUBSTR(VAL1,1,1) ) - 65 ) * 100 + SUBSTR(VAL1,2) )
               FROM TEST38 )
MINUS
SELECT VAL1 FROM TEST38;