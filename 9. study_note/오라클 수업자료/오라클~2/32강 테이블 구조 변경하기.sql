drop table test_table1;

create table test_table1(
data1 number not null,
data2 number not null
);

-- �÷� �߰�
alter table test_table1
add (data3 number not null);

-- �÷��� ������ Ÿ�� ����
alter table test_table1
modify (data3 varchar2(100));

-- ���̺� �̸� ����
drop table test_table2;

alter table test_table1
rename to test_table2;

-- �÷� �̸� ����
alter table test_table2
rename column data3 to data4;

-- �÷� ����
alter table test_table2
drop column data4;

-- ���̺� ����
drop table test_table2;








