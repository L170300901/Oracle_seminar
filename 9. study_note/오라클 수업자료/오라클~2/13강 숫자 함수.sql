-- ���밪 ���ϱ�
select -10, abs(-10) from dual;

-- �������� �޿��� 2000 �谨�ϰ� �谨�� �޿����� ���밪�� ���Ѵ�.
select sal, sal - 2000, abs(sal - 2000)
from emp;

-- �Ҽ��� ���� ����
select 12.3456, floor(12.3456) from dual;

-- �޿��� 1500 �̻��� ����� �޿��� 15% �谨�Ѵ�. �� �Ҽ��� ���ϴ� ������.
select sal, sal * 0.85, floor(sal * 0.85)
from emp
where sal >= 1500;

-- �ݿø�
select 12.3456, round(12.3456) from dual;

select 12.8888, round(12.8888) from dual;

select 888.8888, round(888.8888), round(888.8888, 2), round(888.8888, -2) from dual;

-- �޿��� 2õ ������ ������� �޿��� 20%�� �λ��Ѵ�. �� 10�� �ڸ��� �������� �ݿø��Ѵ�.
select sal, sal * 1.2, round(sal * 1.2, -2)
from emp
where sal <= 2000;

-- ����. �ڸ����� ���� �� �ִ�.
select 1112.3456, trunc(1112.3456), trunc(1112.3456, 2), trunc(1112.3456, -2) from dual;

-- �� ������ �޿��� 10�ڸ� ���ϸ� �谨�Ѵ�
select sal, trunc(sal, -2)
from emp;


-- ������ ���ϱ�
select mod(10, 3), mod(10, 4)
from dual;














