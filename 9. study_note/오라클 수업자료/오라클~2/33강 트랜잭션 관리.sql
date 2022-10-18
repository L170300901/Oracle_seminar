drop table test_table1;

create table test_table1(
data1 number not null,
data2 number not null
);

drop table test_table1;

create table test_table1(
data1 number not null,
data2 number not null
);



insert into test_table1 (data1, data2)
values (100, 200);


insert into test_table1 (data1, data2)
values (101, 201);

select * from test_table1;

insert into test_table1 (data1, data2)
values (102, 202);

select * from test_table1;

commit;

select * from test_table1;

insert into test_table1 (data1, data2)
values (103, 203);

update test_table1
set data2=2000
where data1=100;

select * from test_table1;

delete from test_table1;

select * from test_table1;

rollback;

select * from test_table1;

insert into test_table1

savepoint p1;

insert into test_table1 (data1, data2)
values (104, 204);

rollback to p1;

select * from test_table1;

rollback;

select * from test_table1;
