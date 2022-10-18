
-- 컬럼 레벨
drop table test_table10;

create table test_table10(
data1 number constraint TEST_TABLE10_DATA1_PK primary key,
data2 number not null constraint TEST_TABLE10_DATA2_UK unique,
data3 number not null constraint TEST_TABLE10_DATA3_FK
                      references emp(empno),
data4 number not null constraint TEST_TABLE10_DATA4_CK
                      check(data4 between 1 and 10),
data5 number not null constraint TEST_TABLE10_DATA5_CK
                      check(data5 in(10, 20, 30))
);
-- 테이블 레벨 제약조건
drop table test_table11;

create table test_table11(
data1 number,
data2 number not null,
data3 number not null,
data4 number not null,
data5 number not null,

constraint TEST_TABLE11_DATA1_PK primary key(data1),
constraint TEST_TABLE11_DATA2_UK unique(data2),
constraint TEST_TABLE11_DATA3_FK foreign key(data3)
                                 references emp(empno),
constraint TEST_TABLE11_DATA4_CK check(data4 between 1 and 10),
constraint TEST_TABLE12_DATA5_CK check(data5 in(10, 20, 30))
);

-- 복합키
drop table test_table12;

create table test_table12(
data1 number,
data2 number,
constraint TEST_TABLE12_COMBO_PK primary key(data1, data2)
);

insert into test_table12 (data1, data2)
values (100, 200);

insert into test_table12 (data1, data2)
values (100, 300);

insert into test_table12 (data1, data2)
values (400, 200);

select * from test_table12;

insert into test_table12 (data1, data2)
values (100, 200);

insert into test_table12 (data1, data2)
values (null, null);











