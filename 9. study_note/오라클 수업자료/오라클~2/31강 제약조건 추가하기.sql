drop table test_table20;

create table test_table20(
data1 number,
data2 number,
data3 number,
data4 number,
data5 number,
data6 number
);

-- null 제약조건 추가
alter table test_table20
modify data1 not null;

insert into test_table20 (data1)
values (null);

-- primary key 제약 조건 추가
alter table test_table20
add constraint TEST_TABLE20_DATA2_PK primary key(data2);

insert into test_table20 (data1, data2)
values (1, 10);

insert into test_table20 (data1, data2)
values (2, 10);

insert into test_table20 (data1, data2)
values (3, null);

-- 외래키 제약조건 추가
alter table test_table20
add constraint TEST_TABLE20_DATA3_FK foreign key(data3)
               references emp(empno);

insert into test_table20 (data1, data2, data3)
values (10, 100, 7369);

insert into test_table20 (data1, data2, data3)
values (11, 101, 100);

-- unique 제약 조건 추가
alter table test_table20
add constraint TEST_TABLE20_DATA4_UK unique(data4);

insert into test_table20 (data1, data2, data4)
values (12, 102, 100);

insert into test_table20 (data1, data2, data4)
values (13, 103, 100);

-- check 제약 조건
alter table test_table20
add constraint TEST_TABLE20_DATA5_CK check(data5 between 1 and 10);

insert into test_table20 (data1, data2, data5)
values (14, 104, 5);

insert into test_table20 (data1, data2, data5)
values (15, 105, 20);

alter table test_table20
add constraint TEST_TABLE20_DATA6_CK check(data6 in(10, 20, 30));

insert into test_table20 (data1, data2, data6)
values (16, 106, 20);

insert into test_table20 (data1, data2, data6)
values (17, 107, 50);

select * from test_table20;

create table test_table30(
data1 number not null,
data2 number constraint TEST_TABLE30_DATA2_PK primary key,
data3 number constraint TEST_TABLE30_DATA3_FK
             references emp(empno),
data4 number constraint TEST_TABLE30_DATA4_UK unique,
data5 number constraint TEST_TABLE30_DATA5_CK
             check (data5 between 1 and 10),
data6 number constraint TEST_TABLE30_DATA6_CK
             check (data6 in (10, 20, 30))
);
-- not null 제약 조건 제거
alter table test_table30
modify data1 null;

insert into test_table30 (data1, data2)
values (null, 100);

-- primary key 제약 조건 제거
alter table test_table30
drop constraint TEST_TABLE30_DATA2_PK;

insert into test_table30 (data2)
values (null);

-- 외래키 제약 조건 제거
alter table test_table30
drop constraint TEST_TABLE30_DATA3_FK;

insert into test_table30 (data3)
values (1000);

-- unique 제약 조건 제거
alter table test_table30
drop constraint TEST_TABLE30_DATA4_UK;

insert into test_table30 (data4)
values (100);

insert into test_table30 (data4)
values (100);

-- 체크 제약조건 제거
alter table test_table30
drop constraint TEST_TABLE30_DATA5_CK;

alter table test_table30
drop constraint TEST_TABLE30_DATA6_CK;

insert into test_table30 (data5, data6)
values (20, 100);

select * from test_table30;

create table test_table40(
data1 number constraint TEST_TABLE40_DATA1_PK primary key
);

insert into test_table40 (data1)
values (100);

insert into test_table40 (data1)
values (100);

alter table test_table40 
disable constraint TEST_TABLE40_DATA1_PK;

insert into test_table40 (data1)
values (100);

select * from test_table40;

alter table test_table40
enable constraint TEST_TABLE40_DATA1_PK;

delete from test_table40;

insert into test_table40 (data1)
values (100);

insert into test_table40 (data1)
values (200);

select * from test_table40;

alter table test_table40
enable constraint TEST_TABLE40_DATA1_PK;

insert into test_table40 (data1)
values (100);




















