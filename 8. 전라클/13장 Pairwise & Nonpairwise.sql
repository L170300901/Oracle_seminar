
SELECT * FROM TEST09;
/* LINE (����) , SPEC (��ǰ���) , ITEM (����ǰ��), QTY (����)
Ư�� �������� Ư�� ����� ��ǰ�� ����� ���� � ��ǰ�� � ���°�
�ϴ� ������ ��� �ִ�  */
SELECT * FROM TEST10;
/* IDATE (��������), IN_SEQ (���Լ���), LINE (����), SPEC (��ǰ���)
  Ư�� ������ ���Լ�����, ����, ��ǰ��� ������ �����Ѵ� */



--p342 �����ϱ� : ��ǰ ���� �б�

/* 1999�� 2�� 3�Ͽ� ���̴� ��ǰ�� List �о����, ������ ������
   TEST10 ���̺��� LINE (����) , SPEC (��ǰ���) �� �̿��Ͽ�
   TEST09 ���̺��� ����� ��ǰ�� ITEM (����ǰ��) �� �о���� �ȴ�  */

SELECT * FROM TEST09;  -- LINE (����) , SPEC (��ǰ���) , ITEM (����ǰ��), QTY (����)
SELECT * FROM TEST10;  -- IDATE (��������), IN_SEQ (���Լ���), LINE (����), SPEC (��ǰ���)

--1�� ��� : �� ���̺��� LINE, SPEC ���� �������� => 14�� ���
SELECT DISTINCT A.ITEM
FROM TEST09 A, TEST10 B
WHERE A.LINE = B. LINE
   AND A.SPEC = B.SPEC
   AND B.IDATE = '19990203' ;

--2�� ��� : �������� �̿�, LINE �� SPEC �� ���ε��� �˻� => 15�� ���
SELECT DISTINCT A.ITEM
FROM TEST09 A
WHERE A.LINE IN ( SELECT LINE
                         FROM TEST10
                         WHERE IDATE = '19990203' )
   AND A.SPEC IN ( SELECT SPEC
                         FROM TEST10
                         WHERE IDATE = '19990203' );

--3�� ��� :  ( A.LINE, A.SPEC ) �� ������ �˻� => 14�� ���
SELECT DISTINCT A.ITEM
FROM TEST09 A
WHERE ( A.LINE, A.SPEC ) IN ( SELECT LINE, SPEC
                                     FROM TEST10
                                     WHERE IDATE = '19990203' );

/* ���� 2�� ����� �߸��� ����� ����Ѵ�.
   ��Ȯ���� P16 ��ǰ (ITEM) �� �ϳ� �� ��µȴ�.
   TEST09 ���̺��� P16 ��ǰ�� " LINE 03, SPEC A002 " �� ���ȴٰ� �����ִ�
   �׷��� TEST10 ���̺��� " LINE 03, SPEC A002 " �� ����

   �׷����� P16 ��ǰ�� ��µǴ� ������
   A.LINE IN ( SELECT LINE
                      FROM TEST10
                      WHERE IDATE = '19990203' )  ����
    => A.LINE IN (01, 02, 03)
    => P16 ��ǰ (ITEM) �� �ش�� ( LINE 03 )

    A.SPEC IN ( SELECT SPEC
                      FROM TEST10
                      WHERE IDATE = '19990203' )  ����
    => A.SPEC IN (A001, A002, A003)
    => P16 ��ǰ (ITEM) �� �ش�� ( SPEC A002 )  */

-- ���� LINE�� SPEC �� ��ġ �ϳ��� COLIMN �� �Ͱ� ���� ������ �ɷ��� �Ѵ�.



-- p346 ���� 13-1 : Pairwise �� Nonpairwise
/*
 1999�� 2�� 3�Ͽ� �ʿ��� ��ǰ�� ������ ����, ���, ��ǰ�� ã�� ����.
 TEST09 �� ��ϵ� ��ǰ�� �� 30��, ���� �ʿ��� ��ǰ�� 14��
 ���� �ʿ����� �ʴ� ��ǰ�� �� 16���� ��µǾ�� �Ѵ� */

 --1�� ��� : JOIN => 60�� ���
SELECT DISTINCT A.LINE, A.SPEC, A.ITEM
FROM TEST09 A, TEST10 B
WHERE A.LINE <> B. LINE
   AND A.SPEC <> B.SPEC
   AND B.IDATE = '19990203' ;

--2�� ��� : Nonpairwise => 0�� ���
SELECT DISTINCT A.LINE, A.SPEC, A.ITEM
FROM TEST09 A
WHERE A.LINE NOT IN ( SELECT LINE
                               FROM TEST10
                               WHERE IDATE = '19990203' )
   AND A.SPEC NOT IN ( SELECT SPEC
                              FROM TEST10
                              WHERE IDATE = '19990203' );

--3�� ��� :  Pairwise  \=> 30�� ���
SELECT DISTINCT A.LINE, A.SPEC, A.ITEM
FROM TEST09 A
WHERE ( A.LINE, A.SPEC ) NOT IN ( SELECT LINE, SPEC
                                            FROM TEST10
                                            WHERE IDATE = '19990203' );


