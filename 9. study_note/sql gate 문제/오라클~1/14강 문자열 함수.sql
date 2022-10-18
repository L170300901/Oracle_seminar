-- �빮�� -> �ҹ���
select 'ABcdEF', lower('ABcdEF') from dual;

-- ������� �̸��� �ҹ��ڷ� �����´�.
select ename, lower(ename)
from emp;

-- �ҹ��� --> �빮��
select 'ABcdEF', upper('ABcdEF') from dual;

-- ������� �̸��� �����´�. �빮�� -> �ҹ��� -> �빮��
select ename, lower(ename), upper(lower(ename))
from emp;

-- ù ���ڸ� �빮�ڷ�, �������� �ҹ��ڷ�
select 'aBCDEF', initcap('aBCDEF') from dual;

-- ����̸��� ù ���ڴ� �빮�ڷ� �������� �ҹ��ڷ� �����´�.
select ename, initcap(ename)
from emp;

-- ���ڿ� ����

select concat(concat('kkk', concat('abc', 'def')), 'zzz')
from dual;

-- ������� �̸��� ������ ������ ���� �����´�.
-- ����� �̸��� 000 �̰�, ������ 000�Դϴ�

select concat(concat(concat(concat('����� �̸��� ', ename), ' �̰�, ������ '), job), '�Դϴ�')
from emp;

select '������� �̸��� ' || ename || '�̰�, ������ ' || job || '�Դϴ�'
from emp;

-- ���ڿ��� ����
select length('abcd'), lengthb('abcd'), length('�ȳ��ϼ���'), lengthb('�ȳ��ϼ���') from dual;

-- ���ڿ� �߶󳻱�
select substr('abcd', 3), substrb('abcd', 3),
       substr('�ȳ��ϼ���', 3), substrb('�ȳ��ϼ���', 3)       
from dual;

select substr('abcdefghi', 3, 4), substr('���ع��� ��λ���', 3, 4) from dual;

-- ���ڿ� ã��***
select instr('abcdabcdabcd', 'bc'), instr('abcdabcdabcd', 'bc', 3),
       instr('abcdabcdabcd', 'bc', 3, 2)
from dual;

select instr('abcdefg', 'aaa') from dual;

-- ����� �̸� �߿� A��� ���ڰ� �ι�° ���Ŀ� ��Ÿ���� ����� �̸��� �����´�.***
select ename
from emp
where instr(ename, 'A') > 1;

-- Ư�� ���ڿ��� ä���
select '���ڿ�', lpad('���ڿ�', 20), rpad('���ڿ�', 20), 
       lpad('���ڿ�', 20, '_'), rpad('���ڿ�', 20, '_') from dual;
       
-- ���� ����
select '       ���ڿ�       ', ltrim('       ���ڿ�       '), rtrim('       ���ڿ�       '),
       trim('       ���ڿ�       ')
from dual;

-- ���ڿ� ����
select 'abcdefg', replace('abcdefg', 'abc', 'kkkkkkk') from dual;













