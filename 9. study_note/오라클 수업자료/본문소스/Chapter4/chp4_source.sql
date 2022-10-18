/***********************************/
/* 1. 데이터 저장창고 테이블       */
/***********************************/

-- Char 타입
CREATE TABLE chr_exam1 (
   names1  CHAR(3 BYTE),
   names2  VARCHAR2(3 BYTE));

INSERT INTO chr_exam1 VALUES ( 'AA', 'AA' );

SELECT REPLACE(names1, ' ', 'B') nm1, 
       REPLACE(names2, ' ', 'B') nm2
  FROM chr_exam1;

CREATE TABLE chr_exam2 (
   names3  CHAR(3 BYTE),
   names4  CHAR(3 CHAR),
   names5  CHAR(3));
   
INSERT INTO chr_exam2 ( names3, names4) VALUES ('AAA','AAA');


INSERT INTO chr_exam2 ( names3) VALUES ('홍길동');

INSERT INTO chr_exam2 ( names4) VALUES ('홍길동');

SHOW PARAMETER NLS_LENGTH_SEMANTICS ;

SELECT name, type, value
FROM SYS.V_$PARAMETER
WHERE name = 'nls_length_semantics' ;

-- 숫자형 타입

CREATE TABLE num_temp1 ( 
  n1 NUMBER,
  n2 NUMBER (9),
  n3 NUMBER (9,2),
  n4 NUMBER (9,1),
  n5 NUMBER (7),
  n6 NUMBER (7, -2),
  n7 NUMBER (6),
  n8 NUMBER (3,5));


INSERT INTO num_temp1(n1, n2, n3, n4, n5, n6)
VALUES(1234567.89, 1234567.89, 1234567.89, 1234567.89, 1234567.89, 1234567.89); 

SELECT n1, n2, n3, n4, n5, n6
  FROM num_temp1;


UPDATE num_temp1
   SET n8 = 0.00123;

UPDATE num_temp1
   SET n8 = 0.01234;

CREATE TABLE num_temp2 ( 
  n1 NUMBER,
  n2 BINARY_FLOAT,
  n3 BINARY_DOUBLE );


INSERT INTO num_temp2 ( n1, n2, n3 ) 
VALUES (0.123456789, 0.123456789, 0.123456789);

SELECT *
FROM num_temp2;

SELECT n1 * 0.123456789123456789 num, 
       n2 * 0.123456789123456789 bin_float, 
       n3 * 0.123456789123456789 bin_double
  FROM num_temp2;


-- 날짜형 

CREATE TABLE date_temp1 (
    date1     DATE );

INSERT INTO date_temp1 ( date1 ) VALUES ( SYSDATE );

SELECT *
   FROM date_temp1;


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT *
   FROM date_temp1;
   
   

CREATE TABLE date_temp2 (
    time1     TIMESTAMP,
    time2     TIMESTAMP WITH TIME ZONE,
    time3     TIMESTAMP WITH LOCAL TIME ZONE );

INSERT INTO date_temp2 
VALUES (SYSDATE, SYSDATE, SYSDATE);


ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH:MI:SS.FF';

SELECT *
FROM date_temp2;

-- 기타

CREATE TABLE ansi_oracle (
     tmp_col1 INTEGER );


DESC ansi_oracle;


-- 컬럼 속성, NULL

CREATE TABLE null_test (
   null_col1  VARCHAR2(20) NOT NULL,
   null_col2  VARCHAR2(20) NULL,
   null_col3  VARCHAR2(20) );
   
INSERT INTO null_test ( null_col1, null_col2 )  VALUES ('AA', 'BB');

INSERT INTO null_test ( null_col2, null_col3 )  VALUES ('CC', 'DD');


INSERT INTO null_test ( null_col1, null_col2, null_col3 )  VALUES ('TT', 'SS', NULL);

INSERT INTO null_test ( null_col1, null_col2, null_col3 )  VALUES ('TT', 'SS', '' );


-- 컬럼 속성, UNIQUE 

CREATE TABLE unique_test (
        uni_col1  VARCHAR2(10) UNIQUE NOT NULL,
        uni_col2  VARCHAR2(10) UNIQUE,
        uni_col3  VARCHAR2(10) NOT NULL,
        uni_col4  VARCHAR2(10) NOT NULL,
        CONSTRAINTS uni_tmp_uk  UNIQUE ( uni_col3, uni_col4 ) );


INSERT INTO unique_test ( uni_col1, uni_col2, uni_col3, uni_col4 )
                 VALUES ('A1', 'B1', 'C1', 'D1' );


INSERT INTO unique_test ( uni_col1, uni_col2, uni_col3, uni_col4 )
                 VALUES ('A2', 'B2', 'C2', 'D2' );



UPDATE unique_test
   SET uni_col1 = 'A1'
 WHERE uni_col2 = 'B2';


INSERT INTO unique_test ( uni_col1, uni_col2, uni_col3, uni_col4 )
                 VALUES ('A3', '', 'C3', 'D3' );


INSERT INTO unique_test ( uni_col1, uni_col2, uni_col3, uni_col4 )
                 VALUES ('A4', '', 'C4', 'D4' );
                 
UPDATE unique_test
   SET uni_col2 = ' '; 
   

-- 참조 키   
UPDATE employees
   SET department_id = 280  /*  DEPARTMENTS테이블에 280인 부서가 존재하지 않음 */
WHERE employee_id = 178; 


INSERT INTO EMPLOYEES (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, DEPARTMENT_ID)
VALUES ( 990, 'TEST', 'TEST', SYSDATE, 'IT_PROG', 900);


DELETE DEPARTMENTS
 WHERE DEPARTMENT_ID = 30 ;


-- CHECK 

CREATE TABLE check_test (
   gender  VARCHAR2(10) NOT NULL 
        CONSTRAINT check_gender CHECK ( gender IN ('남성', '여성')));
   

INSERT INTO check_test VALUES('무성');

-- 디폴트
ALTER TABLE check_test
MODIFY gender DEFAULT '남성';

ALTER TABLE check_test
ADD insert_date DATE DEFAULT SYSDATE;

ALTER TABLE check_test
ADD test VARCHAR2(10) NULL;

INSERT INTO check_test (test) VALUES ('AA');

SELECT *
FROM check_test;


-- 테이블의 복사 
CREATE TABLE emp_copy1 AS
SELECT *
FROM EMPLOYEES; 

SELECT *
FROM emp_copy1;


--인덱스

CREATE UNIQUE INDEX "HR"."EMP_EMAIL_UK" ON "HR"."EMPLOYEES" ("EMAIL");
 
CREATE INDEX "HR"."EMP_DEPARTMENT_IX" ON "HR"."EMPLOYEES" ("DEPARTMENT_ID");
 
CREATE INDEX "HR"."EMP_NAME_IX" ON "HR"."EMPLOYEES" ("LAST_NAME", "FIRST_NAME");  



--뷰

SELECT first_name, last_name, email, hire_date
FROM employees
WHERE department_id = 20 ;

CREATE VIEW v_emp1 AS
SELECT first_name, last_name, email, hire_date
FROM employees
WHERE department_id = 20;

SELECT *
FROM v_emp1;

DESC v_emp1;

CREATE OR REPLACE VIEW v_emp1 AS
SELECT first_name, last_name, email, hire_date
FROM employees
WHERE department_id  IN (20,30);

SELECT *
FROM v_emp1;


CREATE OR REPLACE VIEW v_emp_from_table AS
SELECT first_name, last_name, email, hire_date
FROM EMPLOYEES
WHERE department_id IN (20, 30)
   AND hire_date < TO_DATE('1998-01-01');


CREATE OR REPLACE VIEW v_emp_from_view AS
SELECT first_name, last_name, email, hire_date
FROM v_emp1
 WHERE hire_date < TO_DATE('1998-01-01');


CREATE OR REPLACE VIEW v_emp1_read_only AS
SELECT first_name, last_name, email, hire_date
  FROM employees
WHERE department_id IN (20,30)
WITH READ ONLY;


CREATE OR REPLACE VIEW v_emp1_update AS
SELECT first_name, last_name, email, hire_date
  FROM employees
WHERE department_id IN (20,30);


UPDATE v_emp1_update
    SET last_name = '에디슨' 
 WHERE first_name = '마이클' ;


UPDATE v_emp1_read_only
SET last_name = '하트쉬타인'
WHERE last_name = '마이클' ;


INSERT INTO v_emp1_update
VALUES('길동','홍','HGD', SYSDATE);


CREATE OR REPLACE VIEW v_emp1_update AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id, department_id
  FROM employees
WHERE department_id IN (20,30);


INSERT INTO v_emp1_update
VALUES(9999, '길동','홍', 'HHK', SYSDATE, 'IT_PROG', 20);


DELETE v_emp1_update
WHERE employee_id = 9999;

-- 여기서 잠깐....
SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE table_name = 'V_EMP1_UPDATE' ;


INSERT INTO v_emp1_update
VALUES(777, '조영','대', 'DJY', SYSDATE, 'FI_MGR', 40);    


CREATE OR REPLACE VIEW v_emp1_update AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id, department_id
  FROM employees
WHERE department_id IN (20,30)
WITH CHECK OPTION;

INSERT INTO V_EMP1_UPDATE
VALUES(778, '중상','대', 'DJS', SYSDATE, 'FI_MGR', 40);



CREATE OR REPLACE VIEW v_emp1_dual_update AS
SELECT a.employee_id, a.first_name, a.last_name, a.email, a.hire_date, a.job_id, 
a.department_id emp_department,  
         b.department_id, b.department_name
  FROM employees a,
       departments b
 WHERE a.department_id = b.department_id
   AND b.department_id IN (20,30);


INSERT INTO v_emp1_dual_update 
( employee_id, first_name, last_name, email, hire_date, job_id, emp_department )
VALUES(779, '인귀','설', 'SIK', SYSDATE, 'FI_MGR', '30');


UPDATE v_emp1_dual_update
  SET email = 'DaeJoYoung'
WHERE employee_id = 779;


UPDATE v_emp1_dual_update
    SET department_name = '경영지원부2'
 WHERE employee_id = 779;


DELETE v_emp1_dual_update
 WHERE employee_id = 779;


DELETE v_emp1_dual_update
WHERE department_id = 20;

                 
-- 인라인 뷰
SELECT a.employee_id, a.first_name, a.last_name, k.department_name
FROM EMPLOYEES a,
( SELECT b.department_id, 
b.department_name
    FROM departments b
) k
WHERE a.department_id = k.department_id;


-- 시노님
CREATE OR REPLACE PUBLIC SYNONYM pub_emp FOR hr.employees;

SELECT OWNER, SYNONYM_NAME, TABLE_OWNER, TABLE_NAME
  FROM DBA_SYNONYMS
 WHERE SYNONYM_NAME = 'PUB_EMP';


SELECT *
FROM DBA_USERS
WHERE USERNAME = 'PUBLIC';


SELECT owner, object_name, object_type
FROM dba_objects
WHERE object_name = 'DUAL';


-- 시퀀스
SELECT MAX(employee_id)
FROM employees;

CREATE SEQUENCE "HR"."EMPLOYEES_SEQ"
  MINVALUE 1 
MAXVALUE 999999999999999999999999999 
INCREMENT BY 1 
START WITH 207 
NOCACHE  
NOORDER  
NOCYCLE ;

DELETE employees
 WHERE employee_id = 777;

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (EMPLOYEES_SEQ.NEXTVAL, '조영','대', 'DJY', SYSDATE, 'IT_PROG', 30);


SELECT employee_id, first_name, last_name
   FROM employees
WHERE last_name = '대';

SELECT EMPLOYEES_SEQ.CURRVAL
   FROM DUAL;

SELECT EMPLOYEES_SEQ.NEXTVAL
   FROM DUAL;


