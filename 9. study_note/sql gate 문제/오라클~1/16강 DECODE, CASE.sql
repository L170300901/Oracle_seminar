-- �� ����� �μ� �̸��� �����´�.
-- 10 : �λ��, 20 : ���ߺ�, 30 : ���������,   
-- 40 : �����

select empno, ename, 
       decode(deptno, 10, '�λ��', 
                      20, '���ߺ�', 
                      30, '�濵������', 
                      40, '�����')
from emp;

-- ���޿� ���� �λ�� �޿����� �����´�.
-- CLERK : 10% 
-- SALESMAN : 15%
-- PRESIDENT : 200%
-- MANAGER : 5%
-- ANALYST : 20%
select empno, ename, job,
       decode(job, 'CLERK', sal * 1.1,
                   'SALESMAN', sal * 1.15,
                   'PRESIDENT', sal * 3,
                   'MANAGER', sal * 1.05,
                   'ANALYST', sal * 1.2)
from emp;

-- �޿��� �� ����� �����´�.
-- 1000 �̸� : C���
-- 1000 �̻� 2000�̸� : B���
-- 2000 �̻� : A���
select empno, ename,
       case when sal < 1000 then 'C���'
            when sal >= 1000 and sal < 2000 then 'B���'
            when sal >= 2000 then 'A���'
       end
from emp;

-- �������� �޿��� ������ ���� �λ��Ѵ�.
-- 1000 ���� : 100%
-- 1000 �ʰ� 2000�̸� : 50%
-- 2000 �̻� : 200%
select empno, ename, 
       case when sal <= 1000 then sal * 2
            when sal > 1000 and sal <= 2000 then sal * 1.5
            when sal >= 2000 then sal * 3
       end
from emp;