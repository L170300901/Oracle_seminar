



--p257 ���� 07-2
SELECT * FROM A_TB;

SELECT A_MON, A_OUT, SUM(A_OUT) OVER 
          ( Partition by TO_CHAR(TO_DATE(A_MON,'RRRRMM'),'Q') 
            ORDER BY TO_DATE(A_MON,'RRRRMM')
            RANGE INTERVAL '2' MONTH PRECEDING) AS "�б⺰����"
FROM A_TB;