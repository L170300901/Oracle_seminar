-- 6. �޿��� 1500 �̻��� ����� �޿��� 15% �谨�Ѵ�. �� �Ҽ��� ���ϴ� ������.
SELECT TRUNC(sal*0.85) NewSal
FROM EMP
WHERE sal>=1500
ORDER BY 1;
