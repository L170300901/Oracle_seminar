drop table test_table1;

-- NOT NULL : �ش� �÷����� NULL�� ������ �� ����.
create table test_table1(
data1 number,
data2 number not null
);

insert into test_table1(data1, data2)
values (100, 101);

select * from test_table1;

insert into test_table1(data1) 
values (200);

insert into test_table1(data2)
values (201);

select * from test_table1;

-- unique : �ߺ��� ���� ������� �ʰ� null�� ���Ѵ�� ����Ѵ�.
drop table test_table2;

create table test_table2(
data1 number,
data2 number constraint TEST_TABLE2_DATA2_UK unique
);

insert into test_table2(data1, data2)
values (100, 101);

select * from test_table2;

insert into test_table2(data1, data2)
values (200, 201);

select * from test_table2;

insert into test_table2(data1, data2)
values (300, 201);

insert into test_table2(data1, data2)
values (200, null);

insert into test_table2(data1)
values (200);

select * from test_table2;

-- primary key : �ߺ��� ������� �ʰ� null�� ������� �ʴ´�.
drop table test_table3;

create table test_table3(
data1 number,
data2 number constraint TEST_TABLE3_DATA2_PK primary key
);

insert into test_table3 (data1, data2)
values (100, 101);

select * from test_table3;

insert into test_table3 (data1, data2)
values (100, 101);

insert into test_table3 (data1)
values (100);

-- �ܷ�Ű : Ư�� ���̺��� �÷��� �����ϴ� ��������
drop table test_table4;
drop table test_table5;

create table test_table4(
data1 number constraint TEST_TABLE4_PK primary key,
data2 number not null
);

insert into test_table4 (data1, data2)
values (100, 101);

insert into test_table4 (data1, data2)
values (200, 201);

select * from test_table4;

create table test_table5(
data3 number not null,
data4 number constraint TEST_TABLE5_DATA4_FK
             references test_table4(data1)
);

insert into test_table5 (data3, data4)
values (1, 100);

insert into test_table5 (data3, data4)
values (2, 100);

insert into test_table5 (data3, data4)
values (3, 200);

insert into test_table5 (data3, data4)
values (4, 200);

select * from test_table5;

insert into test_table5 (data3, data4)
values (5, null);

insert into test_table5 (data3)
values (6);

select * from test_table5;

insert into test_table5 (data3, data4)
values (7, 300);

-- check �������� : �÷��� ����� ���� �����Ѵ�.
drop table test_table6;

create table test_table6(
data1 number constraint TEST_TABLE6_DATA1_CK
             check (data1 between 1 and 10),
data2 number constraint TEST_TABLE6_DATA2_CK
             check (data2 in(10, 20, 30))
);

insert into test_table6 (data1, data2)
values (1, 10);

insert into test_table6 (data1, data2)
values (2, 20);

select * from test_table6;

insert into test_table6 (data1, data2)
values (20, 10);

insert into test_table6 (data1, data2)
values (5, 100);











