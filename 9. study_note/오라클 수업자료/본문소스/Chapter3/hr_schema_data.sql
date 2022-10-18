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
SET region_name = '유럽'
WHERE region_id = 1;

UPDATE regions 
SET region_name = '아메리카'
WHERE region_id = 2;

UPDATE regions 
SET region_name = '아시아'
WHERE region_id = 3;

UPDATE regions 
SET region_name = '중동 및 아프리카'
WHERE region_id = 4;


REM ***************************update data into the COUNTRIES table

Prompt ******  Populating COUNTIRES table ....


UPDATE countries 
  SET country_name = '이탈리아'
where country_id = 'IT';

UPDATE countries 
  SET country_name = '일본'
where country_id = 'JP';

UPDATE countries 
  SET country_name = '미국'
where country_id = 'US';

UPDATE countries 
  SET country_name = '캐나다'
where country_id = 'CA';

UPDATE countries 
  SET country_name = '중국'
where country_id = 'CN';

UPDATE countries 
  SET country_name = '인디아'
where country_id = 'IN';

UPDATE countries 
  SET country_name = '호주'
where country_id = 'AU';

UPDATE countries 
  SET country_name = '짐바브웨'
where country_id = 'ZW';

UPDATE countries 
  SET country_name = '싱가폴'
where country_id = 'SG';

UPDATE countries 
  SET country_name = '영국'
where country_id = 'UK';

UPDATE countries 
  SET country_name = '프랑스'
where country_id = 'FR';

UPDATE countries 
  SET country_name = '독일'
where country_id = 'DE';

UPDATE countries 
  SET country_name = '잠비아'
where country_id = 'ZM';

UPDATE countries 
  SET country_name = '이집트'
where country_id = 'EG';

UPDATE countries 
  SET country_name = '브라질'
where country_id = 'BR';

UPDATE countries 
  SET country_name = '스위스'
where country_id = 'CH';

UPDATE countries 
  SET country_name = '네델란드'
where country_id = 'NL';

UPDATE countries 
  SET country_name = '멕시코'
where country_id = 'MX';

UPDATE countries 
  SET country_name = '쿠웨이트'
where country_id = 'KW';

UPDATE countries 
  SET country_name = '이스라엘'
where country_id = 'IL';

UPDATE countries 
  SET country_name = '덴마크'
where country_id = 'DK';

UPDATE countries 
  SET country_name = '홍콩'
where country_id = 'HK';

UPDATE countries 
  SET country_name = '나이지리아'
where country_id = 'NG';

UPDATE countries 
  SET country_name = '아르헨티나'
where country_id = 'AR';

UPDATE countries 
  SET country_name = '벨기에'
where country_id = 'BE';


REM ***************************update data into the LOCATIONS table

Prompt ******  Populating LOCATIONS table ....
delete locations;

UPDATE locations 
   SET city = '로마'
 where location_id = 1000;

UPDATE locations 
   SET city = '베니스'
 where location_id = 1100;

UPDATE locations 
   SET city = '동경'
 where location_id = 1200;

UPDATE locations 
   SET city = '히로시마'
 where location_id = 1300;

UPDATE locations 
   SET city = '사우스레이크',
       state_province = '텍사스'
 where location_id = 1400;

UPDATE locations 
   SET city = '사우스 샌프란시스코',
       state_province = '캘리포니아'
 where location_id = 1500;

UPDATE locations 
   SET state_province = '뉴저지'
 where location_id = 1600;

UPDATE locations 
   SET city = '시애틀',
       state_province = '워싱턴'
 where location_id = 1700;

UPDATE locations 
   SET city = '토론토'
 where location_id = 1800;

UPDATE locations 
   SET city = '화이트호스',
       state_province = '유콘'
 where location_id = 1900;

UPDATE locations 
   SET city = '북경'
 where location_id = 2000;

UPDATE locations 
   SET city = '봄베이'
 where location_id = 2100;

UPDATE locations 
   SET city = '시드니',
       state_province = '뉴사우스웨일즈'
 where location_id = 2200;

UPDATE locations 
   SET city = '싱가폴'
 where location_id = 2300;

UPDATE locations 
   SET city = '런던'
 where location_id = 2400;

UPDATE locations 
   SET city = '옥스포드',
       state_province = '옥스포드'
 where location_id = 2500;

UPDATE locations 
   SET state_province = '멘체스터'
 where location_id = 2600;

UPDATE locations 
   SET city = '뮌헨'
 where location_id = 2700;

UPDATE locations 
   SET city = '상파울로',
       state_province = '상파울로'
 where location_id = 2800;

UPDATE locations 
   SET city = '제네바',
       state_province = '제네바'
 where location_id = 2900;

UPDATE locations 
   SET city = '베른'
 where location_id = 3000;

UPDATE locations 
   SET city = '멕시코시티'
 where location_id = 3200;


REM ****************************update data into the DEPARTMENTS table

Prompt ******  Populating DEPARTMENTS table ....
/*
REM disable integrity constraint to EMPLOYEES to load data

ALTER TABLE departments 
  DISABLE CONSTRAINT dept_mgr_fk;
*/

UPDATE departments 
   SET department_name = '경영지원(Administration)'
 where department_id = 10;

UPDATE departments 
   SET department_name = '마케팅'
 where department_id = 20;

UPDATE departments 
   SET department_name = '구매부'
 where department_id = 30;                                

 UPDATE departments 
   SET department_name = '인사부'
 where department_id = 40;                 

 UPDATE departments 
   SET department_name = '물류(Shipping)'
 where department_id = 50; 

 UPDATE departments 
   SET department_name = '홍보부(Public Relations)'
 where department_id = 70;                 
   
 UPDATE departments 
   SET department_name = '판매(Sales)'
 where department_id = 80;                   

 UPDATE departments 
   SET department_name = '경영(Executive)'
 where department_id = 90;                   

 UPDATE departments 
   SET department_name = '회계(Finance)'
 where department_id = 100;     

 UPDATE departments 
   SET department_name = '경리(Accounting)'
 where department_id = 110;                    

 UPDATE departments 
   SET department_name = '재무(Treasury)'
 where department_id = 120; 
 

 UPDATE departments 
   SET department_name = '법인세담당(Corporate Tax)'
 where department_id = 130; 

 UPDATE departments 
   SET department_name = '복지(Benefits)'
 where department_id = 160;

UPDATE departments 
   SET department_name = '생산(Manufacturing)'
 where department_id = 170;

UPDATE departments 
   SET department_name = '건설(Construction)'
 where department_id = 180;
 
UPDATE departments 
   SET department_name = '건설(Construction)'
 where department_id = 180;

UPDATE departments 
   SET department_name = '계약(Contracting)'
 where department_id = 190;

UPDATE departments 
   SET department_name = '운영(Operations)'
 where department_id = 200;
 
UPDATE departments 
   SET department_name = 'IT 지원'
 where department_id = 210;

UPDATE departments 
   SET department_name = 'IT 헬프데스크'
 where department_id = 230;

UPDATE departments 
   SET department_name = '공공기관판매(Government Sales)'
 where department_id = 240;

UPDATE departments 
   SET department_name = '소매(Retail Sales)'
 where department_id = 250;

UPDATE departments 
   SET department_name = '채용(Recruiting)'
 where department_id = 260;

UPDATE departments 
   SET department_name = '급여(Payroll)'
 where department_id = 270;


REM ***************************update data into the JOBS table

Prompt ******  Populating JOBS table ....

UPDATE jobs 
   SET job_title = '사장'
 where job_id = 'AD_PRES';

UPDATE jobs 
   SET job_title = '부사장(Administration Vice President)'
 where job_id = 'AD_VP';

UPDATE jobs 
   SET job_title = '경영부장(Administration Assistant)'
 where job_id = 'AD_ASST';

UPDATE jobs 
   SET job_title = '회계과장(Finance Manager'
 where job_id = 'FI_MGR';

UPDATE jobs 
   SET job_title = '경리직원'
 where job_id = 'FI_ACCOUNT';

UPDATE jobs 
   SET job_title = '경리과장'
 where job_id = 'AC_MGR';

UPDATE jobs 
   SET job_title = '회계사(Public Accountant)'
 where job_id = 'AC_ACCOUNT';

UPDATE jobs 
   SET job_title = '판매 과장'
 where job_id = 'SA_MAN';

UPDATE jobs 
   SET job_title = '판매 대표'
 where job_id = 'SA_REP';

UPDATE jobs 
   SET job_title = '구매 과장'
 where job_id = 'PU_MAN';

UPDATE jobs 
   SET job_title = '구매 직원'
 where job_id = 'PU_CLERK';


UPDATE jobs 
   SET job_title = '운송 직원'
 where job_id = 'SH_CLERK';

UPDATE jobs 
   SET job_title = '프로그래머'
 where job_id = 'IT_PROG';

UPDATE jobs 
   SET job_title = '마케팅 과장'
 where job_id = 'MK_MAN';

UPDATE jobs 
   SET job_title = '마케팅 대표'
 where job_id = 'MK_REP';

UPDATE jobs 
   SET job_title = '인사부 대표'
 where job_id = 'HR_REP';

UPDATE jobs 
   SET job_title = '홍보부 대표'
 where job_id = 'PR_REP';

REM ***************************update data into the EMPLOYEES table

Prompt ******  Populating EMPLOYEES table ....

UPDATE employees 
   SET first_name = '스티븐',
       last_name = '킹'
 where employee_id = 100;      

UPDATE employees 
   SET first_name = '니나',
       last_name = 'Kochhar'
 where employee_id = 101;          

UPDATE employees 
   SET first_name = '렉스',
       last_name = 'De Haan'
 where employee_id = 102; 

UPDATE employees 
   SET first_name = '알렉산더'
 where employee_id = 103; 

UPDATE employees 
   SET first_name = '브루스',
       last_name = '언스트'
 where employee_id = 104; 

UPDATE employees 
   SET first_name = '데이빗',
       last_name = '오스틴'
 where employee_id = 105; 

UPDATE employees 
   SET first_name = '밸리',
       last_name = '패타발라'
 where employee_id = 106; 

UPDATE employees 
   SET first_name = '다이아나',
       last_name = '로렌츠'
 where employee_id = 107;

UPDATE employees 
   SET first_name = '낸시',
       last_name = '그린버그'
 where employee_id = 108;

UPDATE employees 
   SET first_name = '다니엘',
       last_name = '패비엇'
 where employee_id = 109;

UPDATE employees 
   SET first_name = '존',
       last_name = '첸'
 where employee_id = 110;

UPDATE employees 
   SET first_name = '이스마엘',
       last_name = '샤라'
 where employee_id = 111;

UPDATE employees 
   SET first_name = '호세 마누엘',
       last_name = '얼먼'
 where employee_id = 112;

UPDATE employees 
   SET first_name = '루이스',
       last_name = '팝'
 where employee_id = 113;

UPDATE employees 
   SET first_name = '덴',
       last_name = '라페리'
 where employee_id = 114;

UPDATE employees 
   SET first_name = '알렉산더',
       last_name = '쿠'
 where employee_id = 115;

UPDATE employees 
   SET first_name = '셸리',
       last_name = '베이다'
 where employee_id = 116;

UPDATE employees 
   SET first_name = '시걸',
       last_name = '토비야스'
 where employee_id = 117;

UPDATE employees 
   SET first_name = '가이',
       last_name = '히무로'
 where employee_id = 118;

UPDATE employees 
   SET first_name = '캐런',
       last_name = '콜머라네스'
 where employee_id = 119;

UPDATE employees 
   SET first_name = '메튜',
       last_name = '와이즈'
 where employee_id = 120;

UPDATE employees 
   SET first_name = '아담',
       last_name = '프리프'
 where employee_id = 121;

UPDATE employees 
   SET first_name = '페이얌',
       last_name = '카우풀링'
 where employee_id = 122;

UPDATE employees 
   SET first_name = '산타',
       last_name = '볼먼'
 where employee_id = 123;

UPDATE employees 
   SET first_name = '케빈',
       last_name = '모거스'
 where employee_id = 124;

UPDATE employees 
   SET first_name = '줄리아',
       last_name = '네이어'
 where employee_id = 125;

UPDATE employees 
   SET first_name = '아이런',
       last_name = 'Mikkilineni'
 where employee_id = 126;

UPDATE employees 
   SET first_name = '제임스',
       last_name = '랜더리'
 where employee_id = 127;

UPDATE employees 
   SET first_name = '스티븐',
       last_name = '마클'
 where employee_id = 128;

UPDATE employees 
   SET first_name = '로라',
       last_name = '비숍'
 where employee_id = 129;

UPDATE employees 
   SET first_name = '모즈',
       last_name = '앳킨슨'
 where employee_id = 130;

UPDATE employees 
   SET first_name = '제임스',
       last_name = '말로우'
 where employee_id = 131;

UPDATE employees 
   SET first_name = 'TJ',
       last_name = '올슨'
 where employee_id = 132;

UPDATE employees 
   SET first_name = '제이슨',
       last_name = '말린'
 where employee_id = 133;

UPDATE employees 
   SET first_name = '마이클',
       last_name = '로저스'
 where employee_id = 134;

UPDATE employees 
   SET first_name = '키',
       last_name = '지이'
 where employee_id = 135;

UPDATE employees 
   SET first_name = '헤이즐',
       last_name = '필탱커'
 where employee_id = 136;

UPDATE employees 
   SET first_name = '린스케',
       last_name = '래드위그'
 where employee_id = 137;

UPDATE employees 
   SET first_name = '스테판',
       last_name = '스틸스'
 where employee_id = 138;

UPDATE employees 
   SET first_name = '존',
       last_name = '서'
 where employee_id = 139;

UPDATE employees 
   SET first_name = '조슈아',
       last_name = '페이텔'
 where employee_id = 140;

UPDATE employees 
   SET first_name = '트레나',
       last_name = '레이즈'
 where employee_id = 141;

UPDATE employees 
   SET first_name = '커티스',
       last_name = '데이비스'
 where employee_id = 142;

UPDATE employees 
   SET first_name = '랜달',
       last_name = '마토스'
 where employee_id = 143;

UPDATE employees 
   SET first_name = '피터',
       last_name = '베가스'
 where employee_id = 144;

UPDATE employees 
   SET first_name = '존',
       last_name = '러셀'
 where employee_id = 145;

UPDATE employees 
   SET first_name = '카렌',
       last_name = '파트너스'
 where employee_id = 146;

UPDATE employees 
   SET first_name = '알베르토',
       last_name = '에르쭈리히'
 where employee_id = 147;
 
UPDATE employees 
   SET first_name = '제랄드',
       last_name = '캠브롤트'
 where employee_id = 148;

UPDATE employees 
   SET first_name = '엘레나',
       last_name = '즐로키'
 where employee_id = 149;

UPDATE employees 
   SET first_name = '피터',
       last_name = '터커'
 where employee_id = 150;

UPDATE employees 
   SET first_name = '데이빗',
       last_name = '번쉬타인'
 where employee_id = 151;

UPDATE employees 
   SET first_name = '피터',
       last_name = '홀'
 where employee_id = 152;

UPDATE employees 
   SET first_name = '크리스토퍼',
       last_name = '올슨'
 where employee_id = 153;

UPDATE employees 
   SET first_name = '나네트',
       last_name = '캠브롤트'
 where employee_id = 154;

UPDATE employees 
   SET first_name = '올리버',
       last_name = '트볼트'
 where employee_id = 155;

UPDATE employees 
   SET first_name = '자넷',
       last_name = '킹'
 where employee_id = 156;

UPDATE employees 
   SET first_name = '패트릭',
       last_name = '셜리'
 where employee_id = 157;

UPDATE employees 
   SET first_name = '알렌',
       last_name = '맥웬'
 where employee_id = 158;

UPDATE employees 
   SET first_name = '린제이',
       last_name = '스미스'
 where employee_id = 159;

UPDATE employees 
   SET first_name = '루이스',
       last_name = '듀란'
 where employee_id = 160;

UPDATE employees 
   SET first_name = '사라',
       last_name = '씨월'
 where employee_id = 161;

UPDATE employees 
   SET first_name = '클라라',
       last_name = '비쉬니'
 where employee_id = 162;

UPDATE employees 
   SET first_name = '다니엘',
       last_name = '그린'
 where employee_id = 163;

UPDATE employees 
   SET first_name = '마샤',
       last_name = '마빈스'
 where employee_id = 164;

UPDATE employees 
   SET first_name = '데이빗',
       last_name = '리'
 where employee_id = 165;

UPDATE employees 
   SET first_name = '선더',
       last_name = '엔드'
 where employee_id = 166;

UPDATE employees 
   SET first_name = '어밋',
       last_name = '반다'
 where employee_id = 167;

UPDATE employees 
   SET first_name = '리사',
       last_name = '오저'
 where employee_id = 168;

UPDATE employees 
   SET first_name = '해리슨',
       last_name = '블룸'
 where employee_id = 169;

UPDATE employees 
   SET first_name = '테일러',
       last_name = '폭스'
 where employee_id = 170;

UPDATE employees 
   SET first_name = '윌리엄',
       last_name = '스미스'
 where employee_id = 171;

UPDATE employees 
   SET first_name = '엘리자베스',
       last_name = '베이츠'
 where employee_id = 172;

UPDATE employees 
   SET first_name = '선디타',
       last_name = '쿠마'
 where employee_id = 173;

UPDATE employees 
   SET first_name = '엘렌',
       last_name = '아벨'
 where employee_id = 174;

UPDATE employees 
   SET first_name = '알리샤',
       last_name = '허튼'
 where employee_id = 175;

UPDATE employees 
   SET first_name = '조나단',
       last_name = '테일러'
 where employee_id = 176;

UPDATE employees 
   SET first_name = '잭',
       last_name = '리빙스턴'
 where employee_id = 177;

UPDATE employees 
   SET first_name = '킴벌리',
       last_name = '그랜트'
 where employee_id = 178;

UPDATE employees 
   SET first_name = '챨스',
       last_name = '존슨'
 where employee_id = 179;

UPDATE employees 
   SET first_name = '윈스턴',
       last_name = '테일러'
 where employee_id = 180;

UPDATE employees 
   SET first_name = '진',
       last_name = '플로어'
 where employee_id = 181;

UPDATE employees 
   SET first_name = '마샤',
       last_name = '설리반'
 where employee_id = 182;

UPDATE employees 
   SET first_name = '제랄드',
       last_name = '조니'
 where employee_id = 183;

UPDATE employees 
   SET first_name = '난디타',
       last_name = '사찬드'
 where employee_id = 184;

UPDATE employees 
   SET first_name = '알렉시스',
       last_name = '벌'
 where employee_id = 185;

UPDATE employees 
   SET first_name = '줄리아',
       last_name = '델링거'
 where employee_id = 186;

UPDATE employees 
   SET first_name = '앤소니',
       last_name = '카브리오'
 where employee_id = 187;

UPDATE employees 
   SET first_name = '켈리',
       last_name = '청'
 where employee_id = 188;

UPDATE employees 
   SET first_name = '제니퍼',
       last_name = '딜리'
 where employee_id = 189;

UPDATE employees 
   SET first_name = '티모시',
       last_name = '게이츠'
 where employee_id = 190;

UPDATE employees 
   SET first_name = '랜달',
       last_name = '퍼킨스'
 where employee_id = 191;

UPDATE employees 
   SET first_name = '사라',
       last_name = '벨'
 where employee_id = 192;

UPDATE employees 
   SET first_name = '브리트니',
       last_name = '에버트'
 where employee_id = 193;

UPDATE employees 
   SET first_name = '사무엘',
       last_name = '맥케인'
 where employee_id = 194;

UPDATE employees 
   SET first_name = '반스',
       last_name = '존스'
 where employee_id = 195;

UPDATE employees 
   SET first_name = '엘레나',
       last_name = '월셔'
 where employee_id = 196;

UPDATE employees 
   SET first_name = '케빈',
       last_name = '피니'
 where employee_id = 197;
 
UPDATE employees 
   SET first_name = '도날드',
       last_name = '오코넬'
 where employee_id = 198;

UPDATE employees 
   SET first_name = '더글라스',
       last_name = '그랜트'
 where employee_id = 199;

UPDATE employees 
   SET first_name = '제니퍼',
       last_name = '왈렌'
 where employee_id = 200;
 
UPDATE employees 
   SET first_name = '마이클',
       last_name = '하트쉬타인'
 where employee_id = 201;

UPDATE employees 
   SET first_name = '팻',
       last_name = '페이'
 where employee_id = 202;

UPDATE employees 
   SET first_name = '수잔',
       last_name = '매브리스'
 where employee_id = 203;

UPDATE employees 
   SET first_name = '헤르만',
       last_name = '베어'
 where employee_id = 204;

UPDATE employees 
   SET first_name = '셜리',
       last_name = '히긴스'
 where employee_id = 205;

UPDATE employees 
   SET first_name = '윌리암',
       last_name = '기츠'
 where employee_id = 206;

/*
REM enable integrity constraint to DEPARTMENTS

ALTER TABLE departments 
  ENABLE CONSTRAINT dept_mgr_fk;
*/

COMMIT;


COMMENT ON TABLE EMPLOYEES IS 'employees table. Contains 107 rows. References with departments,jobs, job_history tables. Contains a self reference.';

COMMENT ON COLUMN EMPLOYEES.EMPLOYEE_ID IS 'employees 테이블의 Primary key';

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


