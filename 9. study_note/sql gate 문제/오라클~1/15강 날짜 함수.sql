-- ���� ��¥ ���ϱ�
select sysdate from dual;

-- ��¥ ������ ����
select sysdate, sysdate - 10000, sysdate + 10000
from dual;

-- �� ����� �Ի��� ��¥�� ���� 1000�� �İ� �Ǵ� ��¥�� �����´�.
select hiredate, hiredate + 1000
from emp;

-- ������ SALESMAN�� ����� �Ի��� 100���� ��¥�� �����´�.
select hiredate, hiredate - 100
from emp
where job = 'SALESMAN';

-- �� ����� �ٹ� ���� �����´�.
select trunc(sysdate - hiredate)
from emp;

-- �ݿø�
select sysdate, round(sysdate, 'CC') as "�⵵���ڸ�", round(sysdate, 'YYYY') as "������",
       round(sysdate, 'DDD') as "�ñ���", round(sysdate, 'HH') as "�б���",
       round(sysdate, 'MM') as "�ϱ���", round(sysdate, 'DAY') as "�ֱ���",
       round(sysdate, 'MI') as "�ʱ���"
from dual;

-- �� ����� �Ի����� �� �������� �ݿø��Ѵ�.
select hiredate, round(hiredate, 'YYYY')
from emp;

-- ����
select sysdate, trunc(sysdate, 'CC') as "�⵵���ڸ�", trunc(sysdate, 'YYYY') as "��",
       trunc(sysdate, 'DDD') as "��", trunc(sysdate, 'HH') as "��",
       trunc(sysdate, 'MM') as "��", trunc(sysdate, 'DAY') as "��",
       trunc(sysdate, 'MI') as "��"
from dual;

-- 1981�⿡ �Ի��� ������� �����ȣ, ����̸�, �޿�, �Ի����� �����´�.
select empno, ename, sal, hiredate
from emp
where hiredate >= '1981/01/01' and hiredate <= '1981/12/31';

select empno, ename, sal, hiredate
from emp
where hiredate between '1981/01/01' and '1981/12/31';

select empno, ename, sal, hiredate
from emp
where trunc(hiredate, 'YYYY') = '1981/01/01';

-- �� ��¥ ������ �ϼ��� ���Ѵ�.
select sysdate - hiredate
from emp;

-- ��� ����� �ٹ��� ���� ���� ���Ѵ�.
select trunc(months_between(sysdate, hiredate))
from emp;

-- �������� ���Ѵ�.
select sysdate + 100, add_months(sysdate, 100)
from dual;

-- �� ������� �Ի��� �� 100���� �Ǵ� ��¥�� ���Ѵ�.
select hiredate, add_months(hiredate, 100)
from emp;

-- ������ ���ڸ� �������� ������ ������ ��������...
select sysdate, next_day(sysdate, '������') from dual;

-- ������ ��¥�� ���� ������ ��¥�� ���Ѵ�.
select sysdate, last_day(sysdate) from dual;

-- to_char : ����Ŭ -> ���α׷�
select sysdate, to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
select sysdate, to_char(sysdate, 'YYYY�� MM�� DD�� HH�� MI�� SS�� AM') from dual;

-- to_date : ���α׷� -> ����Ŭ
select to_date('2018-03-20 01:58:20 ����', 'YYYY-MM-DD HH:MI:SS AM') from dual;

-- ������� �Ի����� ������ ���� ������� �����´�.
-- 1900-10-10

select hiredate, to_char(hiredate, 'YYYY-MM-DD') from emp;

























