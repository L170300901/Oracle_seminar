rem
rem Header: hr_schema_data.sql 09-jan-01
rem
rem Copyright (c) 2001, 2002, Oracle Corporation.  All rights reserved.  
rem
rem Owner  : ahunold
rem
rem NAME
rem   hr_schema_data.sql - update script from english to korean for HR schema
rem
rem DESCRIPTON
rem
rem
rem
rem CREATED
rem   Hyung-Kyung Hong - 2007/03/30
rem
rem MODIFIED   (YYYY/MM/DD)


SET VERIFY OFF
/*
ALTER SESSION SET NLS_LANGUAGE=American; 
*/

CONNECT hr/hr;

REM ***************************update data into the REGIONS table

Prompt ******  Populating REGIONS table ....

UPDATE regions 
SET region_name = '����'
WHERE region_id = 1;

UPDATE regions 
SET region_name = '�Ƹ޸�ī'
WHERE region_id = 2;

UPDATE regions 
SET region_name = '�ƽþ�'
WHERE region_id = 3;

UPDATE regions 
SET region_name = '�ߵ� �� ������ī'
WHERE region_id = 4;


REM ***************************update data into the COUNTRIES table

Prompt ******  Populating COUNTIRES table ....


UPDATE countries 
  SET country_name = '��Ż����'
where country_id = 'IT';

UPDATE countries 
  SET country_name = '�Ϻ�'
where country_id = 'JP';

UPDATE countries 
  SET country_name = '�̱�'
where country_id = 'US';

UPDATE countries 
  SET country_name = 'ĳ����'
where country_id = 'CA';

UPDATE countries 
  SET country_name = '�߱�'
where country_id = 'CN';

UPDATE countries 
  SET country_name = '�ε��'
where country_id = 'IN';

UPDATE countries 
  SET country_name = 'ȣ��'
where country_id = 'AU';

UPDATE countries 
  SET country_name = '���ٺ��'
where country_id = 'ZW';

UPDATE countries 
  SET country_name = '�̰���'
where country_id = 'SG';

UPDATE countries 
  SET country_name = '����'
where country_id = 'UK';

UPDATE countries 
  SET country_name = '������'
where country_id = 'FR';

UPDATE countries 
  SET country_name = '����'
where country_id = 'DE';

UPDATE countries 
  SET country_name = '����'
where country_id = 'ZM';

UPDATE countries 
  SET country_name = '����Ʈ'
where country_id = 'EG';

UPDATE countries 
  SET country_name = '�����'
where country_id = 'BR';

UPDATE countries 
  SET country_name = '������'
where country_id = 'CH';

UPDATE countries 
  SET country_name = '�׵�����'
where country_id = 'NL';

UPDATE countries 
  SET country_name = '�߽���'
where country_id = 'MX';

UPDATE countries 
  SET country_name = '�����Ʈ'
where country_id = 'KW';

UPDATE countries 
  SET country_name = '�̽���'
where country_id = 'IL';

UPDATE countries 
  SET country_name = '����ũ'
where country_id = 'DK';

UPDATE countries 
  SET country_name = 'ȫ��'
where country_id = 'HK';

UPDATE countries 
  SET country_name = '����������'
where country_id = 'NG';

UPDATE countries 
  SET country_name = '�Ƹ���Ƽ��'
where country_id = 'AR';

UPDATE countries 
  SET country_name = '���⿡'
where country_id = 'BE';


REM ***************************update data into the LOCATIONS table

Prompt ******  Populating LOCATIONS table ....
delete locations;

UPDATE locations 
   SET city = '�θ�'
 where location_id = 1000;

UPDATE locations 
   SET city = '���Ͻ�'
 where location_id = 1100;

UPDATE locations 
   SET city = '����'
 where location_id = 1200;

UPDATE locations 
   SET city = '���νø�'
 where location_id = 1300;

UPDATE locations 
   SET city = '��콺����ũ',
       state_province = '�ػ罺'
 where location_id = 1400;

UPDATE locations 
   SET city = '��콺 �������ý���',
       state_province = 'Ķ�����Ͼ�'
 where location_id = 1500;

UPDATE locations 
   SET state_province = '������'
 where location_id = 1600;

UPDATE locations 
   SET city = '�þ�Ʋ',
       state_province = '������'
 where location_id = 1700;

UPDATE locations 
   SET city = '�����'
 where location_id = 1800;

UPDATE locations 
   SET city = 'ȭ��Ʈȣ��',
       state_province = '����'
 where location_id = 1900;

UPDATE locations 
   SET city = '�ϰ�'
 where location_id = 2000;

UPDATE locations 
   SET city = '������'
 where location_id = 2100;

UPDATE locations 
   SET city = '�õ��',
       state_province = '����콺������'
 where location_id = 2200;

UPDATE locations 
   SET city = '�̰���'
 where location_id = 2300;

UPDATE locations 
   SET city = '����'
 where location_id = 2400;

UPDATE locations 
   SET city = '��������',
       state_province = '��������'
 where location_id = 2500;

UPDATE locations 
   SET state_province = '��ü����'
 where location_id = 2600;

UPDATE locations 
   SET city = '����'
 where location_id = 2700;

UPDATE locations 
   SET city = '���Ŀ��',
       state_province = '���Ŀ��'
 where location_id = 2800;

UPDATE locations 
   SET city = '���׹�',
       state_province = '���׹�'
 where location_id = 2900;

UPDATE locations 
   SET city = '����'
 where location_id = 3000;

UPDATE locations 
   SET city = '�߽��ڽ�Ƽ'
 where location_id = 3200;


REM ****************************update data into the DEPARTMENTS table

Prompt ******  Populating DEPARTMENTS table ....
/*
REM disable integrity constraint to EMPLOYEES to load data

ALTER TABLE departments 
  DISABLE CONSTRAINT dept_mgr_fk;
*/

UPDATE departments 
   SET department_name = '�濵����(Administration)'
 where department_id = 10;

UPDATE departments 
   SET department_name = '������'
 where department_id = 20;

UPDATE departments 
   SET department_name = '���ź�'
 where department_id = 30;                                

 UPDATE departments 
   SET department_name = '�λ��'
 where department_id = 40;                 

 UPDATE departments 
   SET department_name = '����(Shipping)'
 where department_id = 50; 

 UPDATE departments 
   SET department_name = 'ȫ����(Public Relations)'
 where department_id = 70;                 
   
 UPDATE departments 
   SET department_name = '�Ǹ�(Sales)'
 where department_id = 80;                   

 UPDATE departments 
   SET department_name = '�濵(Executive)'
 where department_id = 90;                   

 UPDATE departments 
   SET department_name = 'ȸ��(Finance)'
 where department_id = 100;     

 UPDATE departments 
   SET department_name = '�渮(Accounting)'
 where department_id = 110;                    

 UPDATE departments 
   SET department_name = '�繫(Treasury)'
 where department_id = 120; 
 

 UPDATE departments 
   SET department_name = '���μ����(Corporate Tax)'
 where department_id = 130; 

 UPDATE departments 
   SET department_name = '����(Benefits)'
 where department_id = 160;

UPDATE departments 
   SET department_name = '����(Manufacturing)'
 where department_id = 170;

UPDATE departments 
   SET department_name = '�Ǽ�(Construction)'
 where department_id = 180;
 
UPDATE departments 
   SET department_name = '�Ǽ�(Construction)'
 where department_id = 180;

UPDATE departments 
   SET department_name = '���(Contracting)'
 where department_id = 190;

UPDATE departments 
   SET department_name = '�(Operations)'
 where department_id = 200;
 
UPDATE departments 
   SET department_name = 'IT ����'
 where department_id = 210;

UPDATE departments 
   SET department_name = 'IT ��������ũ'
 where department_id = 230;

UPDATE departments 
   SET department_name = '��������Ǹ�(Government Sales)'
 where department_id = 240;

UPDATE departments 
   SET department_name = '�Ҹ�(Retail Sales)'
 where department_id = 250;

UPDATE departments 
   SET department_name = 'ä��(Recruiting)'
 where department_id = 260;

UPDATE departments 
   SET department_name = '�޿�(Payroll)'
 where department_id = 270;


REM ***************************update data into the JOBS table

Prompt ******  Populating JOBS table ....

UPDATE jobs 
   SET job_title = '����'
 where job_id = 'AD_PRES';

UPDATE jobs 
   SET job_title = '�λ���(Administration Vice President)'
 where job_id = 'AD_VP';

UPDATE jobs 
   SET job_title = '�濵����(Administration Assistant)'
 where job_id = 'AD_ASST';

UPDATE jobs 
   SET job_title = 'ȸ�����(Finance Manager'
 where job_id = 'FI_MGR';

UPDATE jobs 
   SET job_title = '�渮����'
 where job_id = 'FI_ACCOUNT';

UPDATE jobs 
   SET job_title = '�渮����'
 where job_id = 'AC_MGR';

UPDATE jobs 
   SET job_title = 'ȸ���(Public Accountant)'
 where job_id = 'AC_ACCOUNT';

UPDATE jobs 
   SET job_title = '�Ǹ� ����'
 where job_id = 'SA_MAN';

UPDATE jobs 
   SET job_title = '�Ǹ� ��ǥ'
 where job_id = 'SA_REP';

UPDATE jobs 
   SET job_title = '���� ����'
 where job_id = 'PU_MAN';

UPDATE jobs 
   SET job_title = '���� ����'
 where job_id = 'PU_CLERK';


UPDATE jobs 
   SET job_title = '��� ����'
 where job_id = 'SH_CLERK';

UPDATE jobs 
   SET job_title = '���α׷���'
 where job_id = 'IT_PROG';

UPDATE jobs 
   SET job_title = '������ ����'
 where job_id = 'MK_MAN';

UPDATE jobs 
   SET job_title = '������ ��ǥ'
 where job_id = 'MK_REP';

UPDATE jobs 
   SET job_title = '�λ�� ��ǥ'
 where job_id = 'HR_REP';

UPDATE jobs 
   SET job_title = 'ȫ���� ��ǥ'
 where job_id = 'PR_REP';

REM ***************************update data into the EMPLOYEES table

Prompt ******  Populating EMPLOYEES table ....

UPDATE employees 
   SET first_name = '��Ƽ��',
       last_name = 'ŷ'
 where employee_id = 100;      

UPDATE employees 
   SET first_name = '�ϳ�',
       last_name = 'Kochhar'
 where employee_id = 101;          

UPDATE employees 
   SET first_name = '����',
       last_name = 'De Haan'
 where employee_id = 102; 

UPDATE employees 
   SET first_name = '�˷����'
 where employee_id = 103; 

UPDATE employees 
   SET first_name = '��罺',
       last_name = '��Ʈ'
 where employee_id = 104; 

UPDATE employees 
   SET first_name = '���̺�',
       last_name = '����ƾ'
 where employee_id = 105; 

UPDATE employees 
   SET first_name = '�븮',
       last_name = '��Ÿ�߶�'
 where employee_id = 106; 

UPDATE employees 
   SET first_name = '���̾Ƴ�',
       last_name = '�η���'
 where employee_id = 107;

UPDATE employees 
   SET first_name = '����',
       last_name = '�׸�����'
 where employee_id = 108;

UPDATE employees 
   SET first_name = '�ٴϿ�',
       last_name = '�к��'
 where employee_id = 109;

UPDATE employees 
   SET first_name = '��',
       last_name = 'þ'
 where employee_id = 110;

UPDATE employees 
   SET first_name = '�̽�����',
       last_name = '����'
 where employee_id = 111;

UPDATE employees 
   SET first_name = 'ȣ�� ������',
       last_name = '���'
 where employee_id = 112;

UPDATE employees 
   SET first_name = '���̽�',
       last_name = '��'
 where employee_id = 113;

UPDATE employees 
   SET first_name = '��',
       last_name = '���丮'
 where employee_id = 114;

UPDATE employees 
   SET first_name = '�˷����',
       last_name = '��'
 where employee_id = 115;

UPDATE employees 
   SET first_name = '�и�',
       last_name = '���̴�'
 where employee_id = 116;

UPDATE employees 
   SET first_name = '�ð�',
       last_name = '���߽�'
 where employee_id = 117;

UPDATE employees 
   SET first_name = '����',
       last_name = '������'
 where employee_id = 118;

UPDATE employees 
   SET first_name = 'ĳ��',
       last_name = '�ݸӶ�׽�'
 where employee_id = 119;

UPDATE employees 
   SET first_name = '��Ʃ',
       last_name = '������'
 where employee_id = 120;

UPDATE employees 
   SET first_name = '�ƴ�',
       last_name = '������'
 where employee_id = 121;

UPDATE employees 
   SET first_name = '���̾�',
       last_name = 'ī��Ǯ��'
 where employee_id = 122;

UPDATE employees 
   SET first_name = '��Ÿ',
       last_name = '����'
 where employee_id = 123;

UPDATE employees 
   SET first_name = '�ɺ�',
       last_name = '��Ž�'
 where employee_id = 124;

UPDATE employees 
   SET first_name = '�ٸ���',
       last_name = '���̾�'
 where employee_id = 125;

UPDATE employees 
   SET first_name = '���̷�',
       last_name = 'Mikkilineni'
 where employee_id = 126;

UPDATE employees 
   SET first_name = '���ӽ�',
       last_name = '������'
 where employee_id = 127;

UPDATE employees 
   SET first_name = '��Ƽ��',
       last_name = '��Ŭ'
 where employee_id = 128;

UPDATE employees 
   SET first_name = '�ζ�',
       last_name = '���'
 where employee_id = 129;

UPDATE employees 
   SET first_name = '����',
       last_name = '��Ų��'
 where employee_id = 130;

UPDATE employees 
   SET first_name = '���ӽ�',
       last_name = '���ο�'
 where employee_id = 131;

UPDATE employees 
   SET first_name = 'TJ',
       last_name = '�ý�'
 where employee_id = 132;

UPDATE employees 
   SET first_name = '���̽�',
       last_name = '����'
 where employee_id = 133;

UPDATE employees 
   SET first_name = '����Ŭ',
       last_name = '������'
 where employee_id = 134;

UPDATE employees 
   SET first_name = 'Ű',
       last_name = '����'
 where employee_id = 135;

UPDATE employees 
   SET first_name = '������',
       last_name = '����Ŀ'
 where employee_id = 136;

UPDATE employees 
   SET first_name = '������',
       last_name = '��������'
 where employee_id = 137;

UPDATE employees 
   SET first_name = '������',
       last_name = '��ƿ��'
 where employee_id = 138;

UPDATE employees 
   SET first_name = '��',
       last_name = '��'
 where employee_id = 139;

UPDATE employees 
   SET first_name = '������',
       last_name = '������'
 where employee_id = 140;

UPDATE employees 
   SET first_name = 'Ʈ����',
       last_name = '������'
 where employee_id = 141;

UPDATE employees 
   SET first_name = 'ĿƼ��',
       last_name = '���̺�'
 where employee_id = 142;

UPDATE employees 
   SET first_name = '����',
       last_name = '���佺'
 where employee_id = 143;

UPDATE employees 
   SET first_name = '����',
       last_name = '������'
 where employee_id = 144;

UPDATE employees 
   SET first_name = '��',
       last_name = '����'
 where employee_id = 145;

UPDATE employees 
   SET first_name = 'ī��',
       last_name = '��Ʈ�ʽ�'
 where employee_id = 146;

UPDATE employees 
   SET first_name = '�˺�����',
       last_name = '�����޸���'
 where employee_id = 147;
 
UPDATE employees 
   SET first_name = '������',
       last_name = 'ķ���Ʈ'
 where employee_id = 148;

UPDATE employees 
   SET first_name = '������',
       last_name = '���Ű'
 where employee_id = 149;

UPDATE employees 
   SET first_name = '����',
       last_name = '��Ŀ'
 where employee_id = 150;

UPDATE employees 
   SET first_name = '���̺�',
       last_name = '����Ÿ��'
 where employee_id = 151;

UPDATE employees 
   SET first_name = '����',
       last_name = 'Ȧ'
 where employee_id = 152;

UPDATE employees 
   SET first_name = 'ũ��������',
       last_name = '�ý�'
 where employee_id = 153;

UPDATE employees 
   SET first_name = '����Ʈ',
       last_name = 'ķ���Ʈ'
 where employee_id = 154;

UPDATE employees 
   SET first_name = '�ø���',
       last_name = 'Ʈ��Ʈ'
 where employee_id = 155;

UPDATE employees 
   SET first_name = '�ڳ�',
       last_name = 'ŷ'
 where employee_id = 156;

UPDATE employees 
   SET first_name = '��Ʈ��',
       last_name = '�ȸ�'
 where employee_id = 157;

UPDATE employees 
   SET first_name = '�˷�',
       last_name = '����'
 where employee_id = 158;

UPDATE employees 
   SET first_name = '������',
       last_name = '���̽�'
 where employee_id = 159;

UPDATE employees 
   SET first_name = '���̽�',
       last_name = '���'
 where employee_id = 160;

UPDATE employees 
   SET first_name = '���',
       last_name = '����'
 where employee_id = 161;

UPDATE employees 
   SET first_name = 'Ŭ���',
       last_name = '�񽬴�'
 where employee_id = 162;

UPDATE employees 
   SET first_name = '�ٴϿ�',
       last_name = '�׸�'
 where employee_id = 163;

UPDATE employees 
   SET first_name = '����',
       last_name = '����'
 where employee_id = 164;

UPDATE employees 
   SET first_name = '���̺�',
       last_name = '��'
 where employee_id = 165;

UPDATE employees 
   SET first_name = '����',
       last_name = '����'
 where employee_id = 166;

UPDATE employees 
   SET first_name = '���',
       last_name = '�ݴ�'
 where employee_id = 167;

UPDATE employees 
   SET first_name = '����',
       last_name = '����'
 where employee_id = 168;

UPDATE employees 
   SET first_name = '�ظ���',
       last_name = '���'
 where employee_id = 169;

UPDATE employees 
   SET first_name = '���Ϸ�',
       last_name = '����'
 where employee_id = 170;

UPDATE employees 
   SET first_name = '������',
       last_name = '���̽�'
 where employee_id = 171;

UPDATE employees 
   SET first_name = '�����ں���',
       last_name = '������'
 where employee_id = 172;

UPDATE employees 
   SET first_name = '����Ÿ',
       last_name = '��'
 where employee_id = 173;

UPDATE employees 
   SET first_name = '����',
       last_name = '�ƺ�'
 where employee_id = 174;

UPDATE employees 
   SET first_name = '�˸���',
       last_name = '��ư'
 where employee_id = 175;

UPDATE employees 
   SET first_name = '������',
       last_name = '���Ϸ�'
 where employee_id = 176;

UPDATE employees 
   SET first_name = '��',
       last_name = '��������'
 where employee_id = 177;

UPDATE employees 
   SET first_name = 'Ŵ����',
       last_name = '�׷�Ʈ'
 where employee_id = 178;

UPDATE employees 
   SET first_name = 'ð��',
       last_name = '����'
 where employee_id = 179;

UPDATE employees 
   SET first_name = '������',
       last_name = '���Ϸ�'
 where employee_id = 180;

UPDATE employees 
   SET first_name = '��',
       last_name = '�÷ξ�'
 where employee_id = 181;

UPDATE employees 
   SET first_name = '����',
       last_name = '������'
 where employee_id = 182;

UPDATE employees 
   SET first_name = '������',
       last_name = '����'
 where employee_id = 183;

UPDATE employees 
   SET first_name = '����Ÿ',
       last_name = '������'
 where employee_id = 184;

UPDATE employees 
   SET first_name = '�˷��ý�',
       last_name = '��'
 where employee_id = 185;

UPDATE employees 
   SET first_name = '�ٸ���',
       last_name = '������'
 where employee_id = 186;

UPDATE employees 
   SET first_name = '�ؼҴ�',
       last_name = 'ī�긮��'
 where employee_id = 187;

UPDATE employees 
   SET first_name = '�̸�',
       last_name = 'û'
 where employee_id = 188;

UPDATE employees 
   SET first_name = '������',
       last_name = '����'
 where employee_id = 189;

UPDATE employees 
   SET first_name = 'Ƽ���',
       last_name = '������'
 where employee_id = 190;

UPDATE employees 
   SET first_name = '����',
       last_name = '��Ų��'
 where employee_id = 191;

UPDATE employees 
   SET first_name = '���',
       last_name = '��'
 where employee_id = 192;

UPDATE employees 
   SET first_name = '�긮Ʈ��',
       last_name = '����Ʈ'
 where employee_id = 193;

UPDATE employees 
   SET first_name = '�繫��',
       last_name = '������'
 where employee_id = 194;

UPDATE employees 
   SET first_name = '�ݽ�',
       last_name = '����'
 where employee_id = 195;

UPDATE employees 
   SET first_name = '������',
       last_name = '����'
 where employee_id = 196;

UPDATE employees 
   SET first_name = '�ɺ�',
       last_name = '�Ǵ�'
 where employee_id = 197;
 
UPDATE employees 
   SET first_name = '������',
       last_name = '���ڳ�'
 where employee_id = 198;

UPDATE employees 
   SET first_name = '���۶�',
       last_name = '�׷�Ʈ'
 where employee_id = 199;

UPDATE employees 
   SET first_name = '������',
       last_name = '�з�'
 where employee_id = 200;
 
UPDATE employees 
   SET first_name = '����Ŭ',
       last_name = '��Ʈ��Ÿ��'
 where employee_id = 201;

UPDATE employees 
   SET first_name = '��',
       last_name = '����'
 where employee_id = 202;

UPDATE employees 
   SET first_name = '����',
       last_name = '�ź긮��'
 where employee_id = 203;

UPDATE employees 
   SET first_name = '�츣��',
       last_name = '����'
 where employee_id = 204;

UPDATE employees 
   SET first_name = '�ȸ�',
       last_name = '���佺'
 where employee_id = 205;

UPDATE employees 
   SET first_name = '������',
       last_name = '����'
 where employee_id = 206;

/*
REM enable integrity constraint to DEPARTMENTS

ALTER TABLE departments 
  ENABLE CONSTRAINT dept_mgr_fk;
*/

COMMIT;


COMMENT ON TABLE EMPLOYEES IS 'employees table. Contains 107 rows. References with departments,jobs, job_history tables. Contains a self reference.';

COMMENT ON COLUMN EMPLOYEES.EMPLOYEE_ID IS 'employees ���̺��� Primary key';

COMMENT ON COLUMN EMPLOYEES.FIRST_NAME IS 'First name of the employee. A not null column.';

COMMENT ON COLUMN EMPLOYEES.LAST_NAME IS 'Last name of the employee. A not null column.';

COMMENT ON COLUMN EMPLOYEES.EMAIL IS 'Email id of the employee';

COMMENT ON COLUMN EMPLOYEES.PHONE_NUMBER IS 'Phone number of the employee; includes country code and area code';

COMMENT ON COLUMN EMPLOYEES.HIRE_DATE IS 'Date when the employee started on this job. A not null column.';

COMMENT ON COLUMN EMPLOYEES.JOB_ID IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.';

COMMENT ON COLUMN EMPLOYEES.SALARY IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)';

COMMENT ON COLUMN EMPLOYEES.COMMISSION_PCT IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage';

COMMENT ON COLUMN EMPLOYEES.MANAGER_ID IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';

COMMENT ON COLUMN EMPLOYEES.DEPARTMENT_ID IS 'Department id where employee works; foreign key to department_id
column of the departments table';



COMMENT ON TABLE DEPARTMENTS IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';

COMMENT ON COLUMN DEPARTMENTS.DEPARTMENT_ID IS 'Primary key column of departments table.';

COMMENT ON COLUMN DEPARTMENTS.DEPARTMENT_NAME IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. ';

COMMENT ON COLUMN DEPARTMENTS.MANAGER_ID IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';

COMMENT ON COLUMN DEPARTMENTS.LOCATION_ID IS 'Location id where a department is located. Foreign key to location_id column of locations table.';



COMMENT ON TABLE COUNTRIES IS 'country table. Contains 25 rows. References with locations table.';

COMMENT ON COLUMN COUNTRIES.COUNTRY_ID IS 'Primary key of countries table.';

COMMENT ON COLUMN COUNTRIES.COUNTRY_NAME IS 'Country name';

COMMENT ON COLUMN COUNTRIES.REGION_ID IS 'Region ID for the country. Foreign key to region_id column in the departments table.';



COMMENT ON TABLE JOBS IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';

COMMENT ON COLUMN JOBS.JOB_ID IS 'Primary key of jobs table.';

COMMENT ON COLUMN JOBS.JOB_TITLE IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';

COMMENT ON COLUMN JOBS.MIN_SALARY IS 'Minimum salary for a job title.';

COMMENT ON COLUMN JOBS.MAX_SALARY IS 'Maximum salary for a job title';


COMMENT ON TABLE JOB_HISTORY IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';

COMMENT ON COLUMN JOB_HISTORY.EMPLOYEE_ID IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';

COMMENT ON COLUMN JOB_HISTORY.START_DATE IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';

COMMENT ON COLUMN JOB_HISTORY.END_DATE IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';

COMMENT ON COLUMN JOB_HISTORY.JOB_ID IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';

COMMENT ON COLUMN JOB_HISTORY.DEPARTMENT_ID IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';



COMMENT ON TABLE LOCATIONS IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';

COMMENT ON COLUMN LOCATIONS.LOCATION_ID IS 'Primary key of locations table';

COMMENT ON COLUMN LOCATIONS.STREET_ADDRESS IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';

COMMENT ON COLUMN LOCATIONS.POSTAL_CODE IS 'Postal code of the location of an office, warehouse, or production site
of a company. ';

COMMENT ON COLUMN LOCATIONS.CITY IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. ';

COMMENT ON COLUMN LOCATIONS.STATE_PROVINCE IS 'State or Province where an office, warehouse, or production site of a
company is located.';

COMMENT ON COLUMN LOCATIONS.COUNTRY_ID IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';


