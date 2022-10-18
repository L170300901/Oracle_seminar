
-- LOB

CREATE TABLE test_lob (
    id  NUMBER
  , xml_file CLOB
  , image    BLOB
  , log_file BFILE
);


INSERT INTO test_lob (id) VALUES(1);

INSERT INTO test_lob (id, xml_file) VALUES(2, EMPTY_CLOB());

SELECT id, xml_file
  FROM test_lob
WHERE xml_file is null;


UPDATE test_lob
   SET xml_file = EMPTY_CLOB(),
       image  = EMPTY_BLOB(),
       log_file = BFILENAME();


CREATE OR REPLACE DIRECTORY LOB_TEST AS 'C:\LOB_TEST';

UPDATE test_lob
   SET xml_file = EMPTY_CLOB(),
       image  = EMPTY_BLOB(),
       log_file  = BFILENAME('LOB_TEST', 'MYFIRST.TXT');

SELECT *
  FROM TEST_LOB;

DELETE TEST_LOB;

COMMIT;

CREATE OR REPLACE PROCEDURE My_Load_lob
IS
    dest_clob   CLOB;
    src_clob    BFILE  := BFILENAME('LOB_TEST', 'rss_network.xml');
    dst_offset  number := 1 ;
    src_offset  number := 1 ;
    lang_ctx    number := DBMS_LOB.DEFAULT_LANG_CTX;
    warning     number;

BEGIN

    -- set serveroutput on 을 실행한 것과 동일한 효과를 준다. 
    DBMS_OUTPUT.ENABLE(100000);

    INSERT INTO test_lob(id, xml_file) 
        VALUES(1, 'rss_network.xml')
        RETURNING xml_file INTO dest_clob;

    -- 입력할 내용이 파일이므로, 해당 파일을 읽기전용으로 연다.
    DBMS_LOB.OPEN(src_clob, DBMS_LOB.LOB_READONLY);

    -- 오픈된 파일을 xml_file 컬럼에 저장한다.
    DBMS_LOB.LoadCLOBFromFile(
                dest_clob,
                src_clob,
                DBMS_LOB.GETLENGTH(src_clob),
                dst_offset,
                src_offset,
                DBMS_LOB.DEFAULT_CSID,
                lang_ctx,
                warning   );

    -- 파일을 닫는다. 
    DBMS_LOB.CLOSE(src_clob);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('XML File save is succeed!');

EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('XML File save is Failed!');

END;


DECLARE
   V_EMAIL VARCHAR2(30);
BEGIN

  UPDATE employees
     SET email = 'Taejoyoung'
   WHERE employee_id = 210
   RETURNING email INTO V_EMAIL;
  
  DBMS_OUTPUT.PUT_LINE(V_EMAIL);
END;


EXEC My_Load_lob;

SELECT id, xml_file
  FROM test_lob;


CREATE OR REPLACE PROCEDURE My_upd_image
IS

    dest_blob   BLOB;
    src_blob    BFILE  := BFILENAME('LOB_TEST', 'changsha3.jpg');
    dst_offset  number := 1 ;
    src_offset  number := 1 ;

BEGIN

    DBMS_OUTPUT.ENABLE(100000);

	UPDATE test_lob
	   SET image = EMPTY_BLOB()
        RETURNING image INTO dest_blob;   

    -- 파일을 연다
    DBMS_LOB.OPEN(src_blob, DBMS_LOB.LOB_READONLY);
				
   DBMS_LOB.LOADBLOBFROMFILE (
            dest_blob,
            src_blob,
            DBMS_LOB.GETLENGTH(src_blob),
            dst_offset,
            src_offset);				
    -- 파일을 닫는다.
    DBMS_LOB.CLOSE(src_blob);
    
    COMMIT;
   
    DBMS_OUTPUT.PUT_LINE('Image File save is succeed!');
    
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Image File save is Failed!');

END;



EXEC My_upd_image; 


SELECT id, image
  FROM test_lob;

SELECT id, LENGTHB(image)
  FROM test_lob;

CREATE OR REPLACE PROCEDURE My_upd_bfile
IS

BEGIN

	--  UPDATE 문장에서 바로 초기화를 수행한다. 
	UPDATE test_lob
	  SET log_file = BFILENAME('LOB_TEST', 'develop of choice.mp3');

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('BFile save is succeed!');
    
EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('BFile save is Failed!');
			DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;


exec my_upd_bfile;

SELECT log_file
  FROM test_lob;

CREATE OR REPLACE PROCEDURE Get_My_Bfile
IS

    dest_bfile  BFILE;  -- BFILE 변수
	file_name   VARCHAR2(30);
	dir_name    VARCHAR2(30);

BEGIN

    DBMS_OUTPUT.ENABLE(100000);

	-- 저장된 BFILE 데이터를 가져온다. 
    SELECT log_file
	  INTO dest_bfile
	  FROM test_lob;
        

	--  dest_bfile 변수에 담긴 파일의 디렉토리와 이름을 
  -- dir_name, file_name OUT 변수에 담는다. 
    DBMS_LOB.FILEGETNAME(
                dest_bfile,
                dir_name,
                file_name );
				
    DBMS_OUTPUT.PUT_LINE('BFile name is ' || dir_name || '\' || file_name );
    
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('I don''t know where my bfile is');

END;


exec Get_My_Bfile;

-- Materialized View

GRANT CREATE MATERIALIZED VIEW TO HR;

GRANT QUERY REWRITE TO HR;

CREATE TABLE my_master_table AS
SELECT owner, table_name, data_type, data_length
  FROM dba_tab_columns
 UNION ALL
SELECT owner, table_name, data_type, data_length
  FROM dba_tab_columns
 UNION ALL
SELECT owner, table_name, data_type, data_length
  FROM dba_tab_columns;

SELECT COUNT(*)
  FROM my_master_table;


SELECT owner, COUNT(*) cnt, SUM(data_length) data_len
  FROM my_master_table
 GROUP BY owner
 ORDER BY owner;


CREATE MATERIALIZED VIEW my_test_mv
  BUILD IMMEDIATE
  REFRESH ON COMMIT
  ENABLE QUERY REWRITE 
AS 
SELECT owner, COUNT(*) cnt, SUM(data_length) data_len
  FROM my_master_table
GROUP BY owner
ORDER BY owner;


SELECT *
   FROM my_test_mv;

SQL> SET TIMING ON;
SQL> SELECT owner, COUNT(*) cnt, SUM(data_length) data_len
       FROM my_master_table
      GROUP BY owner
      ORDER BY owner;
      

SQL> SELECT owner, COUNT(*) cnt, SUM(data_len) data_len
       FROM my_test_mv
      GROUP BY owner
      ORDER BY owner;


-- 오라클 OBJECT 타입

CREATE OR REPLACE TYPE emp_typ AS OBJECT (
   employee_id       NUMBER(6), 
   first_name        VARCHAR2(20),
   last_name         VARCHAR2(25),
   email             VARCHAR2(25),
   phone_number      VARCHAR2(20),
   MEMBER FUNCTION get_phone  RETURN VARCHAR2
   );

CREATE OR REPLACE TYPE BODY emp_typ AS
  MEMBER FUNCTION get_phone RETURN VARCHAR2 IS
  BEGIN
    RETURN phone_number;
  END;
END;

CREATE TABLE emp1 (
         emp_info EMP_TYP,
         create_date DATE DEFAULT SYSDATE);


SELECT *
  FROM emp1;

INSERT INTO emp1 (emp_info)
SELECT employee_id, first_name, last_name, email, phone_number
 FROM employees;

INSERT INTO emp1 (emp_info)
SELECT EMP_TYP(employee_id, first_name, last_name, email, phone_number)
 FROM employees;


COMMIT;

SELECT emp_info
  FROM emp1;


SELECT emp_info.first_name, emp_info.last_name
  FROM emp1;


SELECT emps.emp_info.first_name, emps.emp_info.last_name
  FROM emp1 emps


SELECT emp1.emp_info.first_name, emp1.emp_info.last_name
  FROM emp1;


SELECT emps.emp_info.first_name, emps.emp_info.get_phone()
  FROM emp1 emps;


CREATE OR REPLACE TYPE emp_typ2 AS OBJECT (
        employee_id       NUMBER(6), 
        first_name        VARCHAR2(20),
        salary             NUMBER(8,2),
        up_salary          NUMBER(8,2),
    MEMBER PROCEDURE up_sal( amt IN NUMBER)
);


CREATE OR REPLACE TYPE BODY emp_typ2 AS 
    MEMBER PROCEDURE up_sal( amt IN NUMBER) IS
    v_emp emp_typ2 := SELF;
  BEGIN
    v_emp.up_salary := v_emp.salary + amt;
  END;
END;


CREATE TABLE emp2 (
       emp emp_typ2,
       creat_date date default sysdate);


INSERT INTO emp2 (emp)
SELECT EMP_TYP2(employee_id, first_name, salary, 0)
  FROM employees;


SELECT emps.emp.first_name, emps.emp.salary, emps.emp.up_salary
  FROM emp2 emps;


DECLARE
  test1 emp_typ2;  -- EMP_TYP2 OBJECT 변수 선언
BEGIN
  -- EMP2 테이블에서 사번이 200인 사원의 정보를 TEST1 변수에 넣는다.
  select emp
    into test1
    from emp2 emps
  where emps.emp.employee_id = 200;
  
  -- 월급을 1000원 올린다.
test1.up_sal(1000);

  DBMS_OUTPUT.PUT_LINE(test1.employee_id);
  DBMS_OUTPUT.PUT_LINE(test1.salary);  --현재 월급
  DBMS_OUTPUT.PUT_LINE(test1.up_salary); --1000원 인상된 월급
  
END;




