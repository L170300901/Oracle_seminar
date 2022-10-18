/* ���� ���ظ� ���� ���� WHERE ����, ORDER ������ �߰��Ͽ���. 
   ������ A.YMD ���� ���εǴ� ���� B.YMD �� �ִ�, 
   ���⼭�� ���ĵǾ��� �� ��µǴ� ������ ���� ���ڿ� �ش��ϴ� 
   ȯ�� (EXC_RATE) �� �ʿ��ϴ�.  */

SELECT * FROM TEST04 A, TEST05 B;

--���� ���ظ� ���� ���� ����
SELECT * FROM TEST04 A, TEST05 B
WHERE A.YMD > B.YMD  -- ���� ���ظ� ���� WHERE ���� �߰�
order by A.ymd, B.ymd;  --A.YMD �� ���� ���ĵ� �� �� ������ B.YMD, B.EXC_RATE �� �ʿ� 



--(��� 1) p272 ������ �ִ� �������� ���

/*  Cartesian Product �� �����Ѵ�. 
   A.us_amount * B.exc_rate , �� �Ѿ׵� ����Ѵ�  */
SELECT A.YMD AS ����, A.us_amount AS �޷��Ѿ�, 
       B.ymd AS ȯ������, B.exc_rate AS ȯ��, 
       A.us_amount * B.exc_rate AS �Ѿ�
FROM TEST04 A, TEST05 B   -- �ϴ� �� ���̺��� Cartesian Product
order by A.ymd, B.ymd;    -- Data Ȯ���� ���� �ӽ÷� �߰�

/* �� ������ ������ �ִ� ���������� �ٱ� ���� or ���� �⺻�� �Ǵ� ������ �ȴ� 
   
   �� ���忡,
   WHERE B.YMD = ( SELECT MAX(C.YMD) 
                  FROM TEST05 C 
                  WHERE A.YMD > C.YMD )  �� �߰��ϸ� ���ϴ� ����� ��µȴ�.
   
   A.YMD, �� ���ڸ� �������� ������ ����ϱ� ���� TEST05, ��Ī C ���̺��� 
   ���ο� �������� �ϴ� ������ �ִ� ���������� ���� ���� �߰��Ѵ�.

  ����Ǵ� ������ ������ ����

  (1) SELECT ~~
      FROM TEST04 A, TEST05 B;  
      => ������� Cartesian Product ����, SELECT ���� ���߿� ����ʿ� ����!
  
  (2) ó�� ���ڵ��� A.YMD �� '19980102'�� ���� ������ �ִ� �������� ����
      ��, �������� ������ A.YMD �� '19980102' �� �ٲ�� 
      ���⼭�� MAX(C.YMD) �� '19971231' �� ��µȴ�   */

      SELECT MAX(C.YMD) 
      FROM TEST05 C 
      WHERE '19980102' > C.YMD ;   --'19971231' �� ��µ�

/* (3) �ٽ� Cartesian Product �� ���ư��� ù��° ���� B.YMD ����
       ���������� ������ '19971231' �� ������ �˻��Ѵ�.
       ù��° ���� B.YMD ���� '19961231' => �ٸ���
       => �� ���� WHERE ������ �������� �����Ƿ� ��µ��� �ʴ´�.

   (4) �� ��° ���ڵ忡 ���� ���� (1) ~ (3) ���� => 
       ���������� ���� ����� ����('19971231'), 
       �ι�° ���� B.YMD ���� '19970630' => �ٸ��� => ��µ��� ����

   (5) �� ��° ���ڵ嵵 �Ȱ��� ���� => WHERE ���� ���� => ���

   (6) �� ��° ���ڵ嵵 �Ȱ��� ���� => WHERE ���� �Ҹ��� => ��µ��� ����

   ....  Cartesian Product �� ������ ���ڵ���� �ݺ�
        => �׸��� SELECT ���� ���� ��µ� �ʵ� ����
        => ���������� ORDEY BY ���� ���� ��� ����            */


-- B.YMD �� C.YMD �� ��ü �����ʹ� �����ϹǷ� '=', ���� ������ �����ϴ�
SELECT A.YMD AS ����, A.us_amount AS �޷��Ѿ�, 
       B.ymd AS ȯ������, B.exc_rate AS ȯ��,
       A.us_amount * B.exc_rate AS �Ѿ�
FROM TEST04 A, TEST05 B
WHERE B.YMD = ( SELECT MAX(C.YMD) 
                FROM TEST05 C 
                WHERE A.YMD > C.YMD );   

-----------------------------------------------------------------------
--(�߰� ���1) EXISTS ���

/* �ϴ� Cartesian Product �� �����Ѵ� : ���⼭�� ��� ȯ���� ���� �Ѿ��� ��µȴ�
   �� ������ �ٱ� ���� or ���� �⺻�� �Ǵ� ������ �ȴ�. */
SELECT A.YMD AS ����, A.us_amount AS �޷��Ѿ�, 
       B.ymd AS ȯ������, B.exc_rate AS ȯ��, 
       A.us_amount * B.exc_rate AS �Ѿ�
FROM TEST04 A, TEST05 B;

/* �� ���忡 WHERE EXISTS ~ ������ �߰��ϴ� ���� �����̴�  
   ���� WHERE ������ �׳� ����ϰ� §�ٸ� ������ ���� ������ �� ���̴�

   WHERE A.YMD = ( ( �ٸ� ���������� ) ���� )  
     AND B.YMD = ( ���ں� �ڽź��� ���� ���� �� �ִ� )  => ���⼭ max() �Լ��� �ʿ�!

   ������ WHERE ���� MAX() �Լ��� �ٷ� ���� ���� ���ٴ� ��, 
   �ʿ��� ������, �� (����) + (�ڽź��� ���� ���� �� �ִ�) �� �ִ� 
   �ζ��κ並 ��� �Ѵ�  */

--���ں��� �ڽź��� ���� ���� �� �ִ�, �� ȯ�����ڸ� ���Ѵ� 
SELECT C.YMD AS ����, MAX(D.YMD) AS ȯ������
FROM TEST04 C, TEST05 D
WHERE C.YMD > D.YMD
GROUP BY C.YMD;


--(����) ���� ������ WHERE EXISTS ~ ���� �ζ��κ��� �ζ��κ�(..) �� �ȴ�
SELECT A.YMD AS ����, A.us_amount AS �޷��Ѿ�, 
       B.ymd AS ȯ������, B.exc_rate AS ȯ��, 
       A.us_amount * B.exc_rate AS �Ѿ�
FROM TEST04 A, TEST05 B
WHERE EXISTS ( SELECT NULL  -- ���⿡ ���� �־�� ��!!
               FROM ( SELECT C.YMD AS ����, MAX(D.YMD) AS ȯ������
                      FROM TEST04 C, TEST05 D
                      WHERE C.YMD > D.YMD
                      GROUP BY C.YMD; ) T1    
               WHERE A.YMD = T1.���� AND B.YMD = T1.ȯ������ );


/* ���� EXISTS �ȿ��� �ζ��κ並 ������� �ʾҴٸ� ������ ���� ���°� �� ���̴�.
   ������ "�׷� �Լ��� �㰡���� �ʽ��ϴ�" ���� : ������� �ʴ´�  */
SELECT A.YMD AS ����, A.us_amount AS �޷��Ѿ�, 
       B.ymd AS ȯ������, B.exc_rate AS ȯ��, 
       A.us_amount * B.exc_rate AS �Ѿ�
FROM TEST04 A, TEST05 B
WHERE EXISTS ( SELECT C.YMD AS ����, MAX(D.YMD) AS ȯ������
               FROM TEST04 C, TEST05 D
               WHERE C.YMD > D.YMD
                 AND A.YMD = C.YMD AND B.YMD = MAX(D.YMD)
               GROUP BY C.YMD  );  --�� ������ "�׷� �Լ��� �㰡���� �ʽ��ϴ�" ����

-----------------------------------------------------------------------

--(��� 2) p273 �ζ��� �� ���
SELECT * FROM TEST04;
SELECT * FROM TEST05;

/* A.YMD, �� ���ں��� ������ Data �� �ʿ�����Ƿ� 
   WHERE �������� �ɷ��ֱ� */
SELECT *
FROM TEST04 A, TEST05 B
WHERE A.YMD > B.YMD
order by A.YMD, B.YMD; -- ��� Ȯ�� �� GROUP BY �ϱ� ���� ���� ��


/* ���� ������ A.YMD, A.us_amount �� �׷�ȭ�ϰ� ��Ī�� �߰��Ѵ�
   ������ �׷캰 ���� ���� ȯ�����ڰ� MAX(B.YMD) �� �ȴ�  */

SELECT A.YMD AS ����, A.US_AMOUNT AS �޷��Ѿ�, 
       MAX(B.YMD) AS ȯ������
FROM TEST04 A, TEST05 B
WHERE A.YMD > B.YMD
GROUP BY A.YMD, A.US_AMOUNT;


/* ���� ������ �ζ��κ� T1, TEST05 ���̺����� T2 �� ���� �����Ѵ�  
   T1 �� ȯ�����ڿ� T2.YMD, �� ���ڰ� ������ WHERE ���� �߰�   */
SELECT *
FROM ( SELECT A.YMD AS ����, A.us_amount AS �޷��Ѿ�, 
       MAX(B.YMD) AS ȯ������
       FROM TEST04 A, TEST05 B
       WHERE A.YMD > B.YMD
       GROUP BY A.YMD,  A.us_amount ) T1, 
       TEST05 T2
WHERE T1.ȯ������ = t2.YMD;


/* SELECT �� ���� : T1.�޷��Ѿ� * t2.exc_rate �� ���ϰ��� �ϴ� �Ѿ��� �ȴ�.
   ��� Ȯ���� ���� �ϱ� ���� ORDER BY ���� �߰��Ѵ�   */

SELECT T1.����, T1.�޷��Ѿ�, t2.ymd as ȯ������, t2.exc_rate AS ����ȯ��, 
       T1.�޷��Ѿ� * t2.exc_rate AS �Ѿ�
FROM ( SELECT A.YMD AS ����, A.us_amount AS �޷��Ѿ�, 
       MAX(B.YMD) AS ȯ������
       FROM TEST04 A, TEST05 B
       WHERE A.YMD > B.YMD
       GROUP BY A.YMD,  A.us_amount ) T1, 
       TEST05 T2
WHERE T1.ȯ������ = t2.YMD
ORDER BY T1.����;

--------------------------------------------------------------------------

--(��� 3) HINTS ���
SELECT A.YMD AS ����, A.us_amount AS �޷��Ѿ�, 
       B.ymd AS ȯ������, B.exc_rate AS ȯ��,
       A.us_amount * B.exc_rate AS �Ѿ�
FROM TEST04 A, TEST05 B
WHERE B.YMD = ( SELECT /*+ INDEX_DESC(TEST05 TEST05_PK) */ YMD 
                FROM TEST05    --��Ī ���� �� ��!!
                WHERE A.YMD > YMD
                AND ROWNUM=1);   
                -- ���� TEST05 ���̺� ��Ī ���� �� ��!

--P276 ���� 09-1 : INDEX_DESC Hints �� ���
SELECT INDEX_NAME
FROM USER_INDEXES
WHERE TABLE_NAME = 'TEMP';  --���⼭�� SYS_C005752

SELECT * FROM TEMP;  
SELECT * FROM TEMP A, TEMP B;

SELECT A.EMP_ID, A.EMP_NAME, 
       B.EMP_ID AS "�ٷ��� ���ID", B.EMP_NAME AS "�ٷ� �� ����̸�"
FROM TEMP A, TEMP B
WHERE B.EMP_ID = ( SELECT /*+ INDEX_DESC(TEMP SYS_C005752) */ EMP_ID 
                            FROM TEMP
                            WHERE A.EMP_ID > EMP_ID AND ROWNUM=1 )
ORDER BY A.EMP_ID; 

--�ٷ� ���� ��� �˻� : ROWNUM = 2 �� �˻��� �� �����Ƿ� 
--ROWNUM �� ��Ī�� �� ���� �ζ��κ�� �ѹ� �� ����
SELECT A.EMP_ID, A.EMP_NAME, 
       B.EMP_ID AS "�ٷ����� ���ID", B.EMP_NAME AS "�ٷ����� ����̸�"
FROM TEMP A, TEMP B
WHERE B.EMP_ID = 
    ( SELECT EMP_ID 
    FROM ( SELECT /*+ INDEX_DESC(TEMP SYS_C005752) */ EMP_ID , 
                  ROWNUM AS NO
           FROM TEMP  WHERE A.EMP_ID > EMP_ID ) 
           WHERE NO = 2 )
ORDER BY A.EMP_ID;                         