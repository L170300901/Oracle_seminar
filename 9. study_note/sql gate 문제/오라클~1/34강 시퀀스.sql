drop table test_table1;

create table test_table1(
idx number constraint TEST_TABLE1_IDX_PK primary key,
number_data number not null
);

create sequence test_seq1
start with 0
increment by 1
minvalue 0;

select test_seq1.currval from dual;

insert into test_table1(idx, number_data)
values (test_seq1.nextval, 100);

insert into test_table1(idx, number_data)
values (test_seq1.nextval, 200);

select * from test_table1;

select test_seq1.currval from dual;

drop sequence test_seq1;












