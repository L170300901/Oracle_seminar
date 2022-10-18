ALTER SESSION SET nls_date_format='RR/MM/DD';
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT * FROM S_ORD;
SELECT * FROM S_PRODUCT;
SELECT * FROM S_ITEM;             ----�߰����̺�(��)�� �������� ��ƾ� �Ѵ�

�ֹ����̵�, �����̵�, �ֹ���¥, ��ǰ���̵�, ����, ����
SELECT i.ord_id
					, o.CUSTOMER_ID
          , o.DATE_ORDERED
          ,o.SALES_REP_ID
          , i.PRODUCT_ID                    ------ ���������� ������ ���� ����� �������� ���δ�
          ,P.NAME
          ,e.FIRST_NAME
				  , i.QUANTITY
          , i.PRICE
FROM S_ITEM i    ------ ���� �߽��� �Ǵ� ���̺� '��'
				, S_ORD o
        , S_PRODUCT p
        , S_CUSTOMER c
        , S_EMP e
WHERE i.ORD_ID=o.ID
AND i.PRODUCT_ID=p.ID
AND o.CUSTOMER_ID=c.ID
AND o.SALES_REP_ID=e.ID
AND o.DATE_ORDERED BETWEEN '92/08/01' AND '92/08/31'  -- 92�� 8���� �ֹ��� ��ǰ�鸸 ���
SELECT * FROM S_CUSTOMER;
SELECT * FROM S_ORD;

SELECT * FROM v$nls_parameters;

-----Non-Equi Join-----------
SELECT*FROM EMP;
SELECT*FROM SALGRADE;
SELECT empno, ename, sal, grade
FROM EMP e, SALGRADE s
WHERE e.sal BETWEEN s.losal AND s.hisal

------ �� �����ϱ� ------
SELECT * FROM EMP;
INSERT INTO EMP
VALUES (
						7977
            , 'daeyu'
            , 'sales'
            , 7902
            , SYSDATE
            , 3100
            ,200
            , NULL
            )
COMMIT;       ----��ǻ�Ͱ� �������� �ϵ忡 Ȯ���� �����϶�


--------Outer Join----------
SELECT*FROM EMP;
SELECT*FROM DEPT;

SELECT *
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO (+) ;  -----null�� �߰��϶�� �ǹ�

------------self join------------------
SELECT*
FROM  EMP e , EMP m
WHERE e.mgr = m.empno(+);

----------------------------------------
1992�� 8���� �Ǹŵ� ��ǰ����
�ֹ����̵�, �����̵�, ����, ����������̵�, ���������,
��������������, ��ǰ���̵�, ��ǰ��, ����,������ ����Ͻÿ�.
�̶� ��ǥ�̻絵 ������ �� �� �ִ�.
SELECT i.ORD_ID
					, o.CUSTOMER_ID
          ,c.NAME
          , o.SALES_REP_ID
          , e.FIRST_NAME
          , m.FIRST_NAME mgrN
          , i.PRODUCT_ID
          , p.NAME
          , i.PRICE
          , i.QUANTITY
FROM S_ITEM i
				, S_ORD o
        , S_CUSTOMER c
        , S_EMP e
        , S_EMP m
        ,S_PRODUCT p
WHERE i.ORD_ID=o.ID
AND o.CUSTOMER_ID=c.ID
AND o.SALES_REP_ID=e.ID
AND e.MANAGER_ID=m.id(+)   ------ID�� first_name ���κҰ�
AND i.PRODUCT_ID=p.ID
AND o.DATE_ORDERED BETWEEN '92/08/01' AND '92/08/31'


