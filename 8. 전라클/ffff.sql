--[6�� ����]
--94����� �⵵ ���� �Ի��� ����� �߿��� �Ի�⵵ ���� ���帹�� �޿��� �޴� ����� ����ϼ���
--�� �⵵�� Ǯ���Ӱ� ���ʽ����� ��ģ �ѱ޿��� ����ϼ���
--(94�⵵�� �� �� ��µǴ°� �����Դϴ�)

SELECT * FROM EMPLOYEES
ALTER SESSION SET nls_date_format = 'rr/mm/dd'



SELECT DISTINCT *
  FROM EMPLOYEES b
 WHERE (b.salary)
       IN
       (SELECT
            MAX(e.SALARY) ms
         FROM EMPLOYEES e
        WHERE e.HIRE_DATE < '940101'
        GROUP BY e.HIRE_DATE
       )
       AND b.HIRE_DATE < '940101'
