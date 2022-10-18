--------------Group By----------------
SELECT SUM(total) FROM S_ORD;   ----s_ord�� �ϳ��� �׷����� ���� �Ѿ��� ��

SELECT*FROM S_ORD
ORDER BY customer_id;

SELECT customer_id, SUM(total) FROM S_ORD   -----select������ group by������ ������ Į���� �� �� �ִ�.
                                   --ex) date_orderd���� Į���� ���� ������. ���� ������ Į���� �ֹ� ��¥�� �޶�
GROUP BY customer_id            ----------���� �ֹ� �Ѿ�

-------
SELECT * FROM EMP
ORDER BY deptno;

SELECT deptno, SUM(sal) total, max(sal), min(sal)
FROM EMP
GROUP BY deptno;   -----�׷�� ���྿ ����Ѵ�

--�� job���� �ְ�޿��� ����Ͻÿ�
SELECT job, max(sal)
FROM EMP
GROUP BY job;

SELECT customer_id, SUM( total )
FROM S_ORD
WHERE date_ordered LIKE '92/08%'
GROUP BY customer_id
ORDER BY SUM(total) desc
---1. where  2. group by 3. select �׷��Լ� ����


-----------------having----------------------
81�⵵�� �Ի��� ������� �μ��� �޿��Ѿ��� ����ϵ�
�� �޿��� 7000$�̻��� �μ��� ����϶�
SELECT deptno, SUM(sal) FROM EMP
WHERE hiredate LIKE '81%'
GROUP BY deptno
HAVING SUM(sal)>=7000
ORDER BY SUM(sal)

1. WHERE���� ����� �Ǵ� ���ڵ带 �˻�
2. GROUP BY
3. HAVING ���������� ����Ǿ� �׷��� ����
4. SELECT �׷��Լ� ����
5. ORDER BY ����


81�⵵�� �Ի��� ����鿡 ���ؼ�
�μ��� ������� 3�� �̻��� �μ��� ����
�μ��� �� �޿��� ���Ͽ� ������������ �����Ͻÿ�
SELECT deptno, SUM(sal) FROM EMP
WHERE hiredate LIKE '81%'
GROUP BY deptno
HAVING COUNT(*)>=3   ---having�� �׷��� �����ϴ� ����
ORDER BY SUM(sal)


-------------����----------------
SELECT * FROM S_ORD;
SELECT * FROM S_ITEM;
SELECT * FROM S_PRODUCT;
SELECT product_id, SUM(price*quantity)  ---��ǰ�� �����Ѿ�
FROM S_ITEM
GROUP BY product_id;

92�� 8���� �Ǹŵ� ��ǰ���� ��ǰ�Ǹ��Ѿ��� ���϶�
SELECT product_id, SUM(price * quantity)
FROM S_ITEM i, S_ORD o
WHERE i.ORD_ID=o.ID
AND  o.DATE_ORDERED LIKE  '92/08%'    -----like�� index�� �� �� ��� ���� �ʴ�.
GROUP BY product_id;

2ȸ �̻� �Ǹŵ� ��ǰ���� ��ǰ�� �Ǹ� �Ѿ��� ���϶�
SELECT product_id, SUM(price * quantity)
FROM S_ITEM i, S_ORD o
WHERE i.ORD_ID=o.ID
AND  o.DATE_ORDERED LIKE  '92/08%'
GROUP BY product_id
HAVING COUNT(*)>=2  ----group by�� ������
ORDER BY SUM(price * quantity)

92�� 8���� �Ǹŵ� �� ��ǰ���� �Ǹ��Ѿ��� ����Ͻÿ�
��� ������ ��ǰ���̵�, ��ǰ��, �Ǹ��Ѿ�
�̶� �Ǹ� Ƚ���� 2�� �̻��� ��ǰ�鸸 ����Ͻÿ�
SELECT i.product_id, P.NAME, SUM(price * quantity)
FROM S_ITEM i, S_ORD o, S_PRODUCT p
WHERE i.ORD_ID=o.ID
AND i.PRODUCT_ID=p.ID
AND  o.DATE_ORDERED LIKE  '92/08%'
GROUP BY i.product_id, p.name  -----p.name�� ������ group by������ ���;� ��
HAVING COUNT(*)>=2
ORDER BY SUM(price * quantity)


�ϴ�� : �μ��� ����� ����
�ٴ�� : �ֹ��� ��ǰ�� ���� - - - �� �ֹ��� ���� ��ǰ�� �ֹ��� �� �ְ�
                                            �� ��ǰ�� ���� �ֹ����� �ֹ� �� �� �ִ�.

��ǰ���̵�, ��ǰ��, â����̵�, â���ּ�,
â������ھ��̵�, â��������������
SELECT i.PRODUCT_ID
          , P.NAME
          , i.warehouse_id
          , w.ADDRESS
          , w.MANAGER_ID
          , m.FIRST_NAME
FROM S_INVENTORY i
				, S_PRODUCT p
        , S_WAREHOUSE w
        , S_EMP e
        , S_EMP m
WHERE i.PRODUCT_ID=p.ID
AND i.warehouse_id=w.ID
AND w.MANAGER_ID=e.ID
---AND e.ID=m.MANAGER_ID ( x ) warehouse�� �ִ� manager_id�� â������� id��.
AND e.MANAGER_ID=m.ID(+) --�� â��������� �����縦 ����ؾ���