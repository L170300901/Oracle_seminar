drop table test_table100;

create table test_table100(
data1 number constraint TEST_TABLE100_PK primary key,
data2 number not null
);

select index_name, table_name, column_name
from user_ind_columns;

drop table emp01;

create table emp01
as
select * from emp;

select * from emp01;

insert into emp01
select * from emp01;

select count(*) from emp01;

insert into emp01 (ename)
values ('ȫ�浿');

select * from emp01
where ename = 'ȫ�浿';

create index emp01_idx
on emp01(ename);













