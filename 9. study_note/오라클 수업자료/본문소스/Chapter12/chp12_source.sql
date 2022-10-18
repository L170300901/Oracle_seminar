
-- �ý��� ��
SELECT owner, object_name, object_type, object_id
  FROM all_objects;


SELECT owner, object_name, object_type, object_id
  FROM all_objects
 WHERE owner = 'HR' 
 ORDER BY object_type;

SELECT DISTINCT object_type
  FROM all_objects;
  
  
SELECT owner, object_name, object_type, object_id
  FROM all_objects
 WHERE owner = 'HR' 
   AND object_type = 'TABLE';

  
 SELECT owner, table_name, tablespace_name                
  FROM all_tables
 WHERE owner = 'HR';
 

SELECT owner, object_name, object_id, object_type
  FROM all_objects
 WHERE object_name LIKE 'ALL%';


CREATE USER test_user INDENTIFIED BY test;

GRANT CREATE SESSION TO test_user;

CONNECT test_user/test;

SELECT COUNT(*)
  FROM all_objects;


SELECT owner, object_name, object_id, object_type
  FROM all_objects
 WHERE object_name LIKE 'ALL%'
   AND object_type = 'SYNONYM';


CONNECT test_user/test;

SELECT COUNT(*)
  FROM dba_objects;


SELECT role, owner, table_name, privilege
  FROM role_tab_privs
 WHERE table_name = 'DBA_OBJECTS';


SELECT *
  FROM role_role_privs
 WHERE granted_role = 'SELECT_CATALOG_ROLE';


SELECT *
  FROM all_col_comments
 WHERE table_name = 'ROLE_ROLE_PRIVS';


GRANT SELECT_CATALOG_ROLE TO test_user;

CONNECT test_user/test;

SELECT COUNT(*)
  FROM dba_objects;


SELECT table_name, tablespace_name, status
  FROM user_tables;

DESC departments;


SELECT a.column_name, a.data_type || '(' || a.data_length || ')' datatypes,
       DECODE(a.nullable, 'Y', 'null', 'not null') null_yn,
	     b.comments
  FROM user_tab_cols a,
       user_col_comments b
 WHERE a.table_name = 'DEPARTMENTS'
   AND a.table_name = b.table_name
   AND a.column_name = b.column_name
 ORDER BY a.column_id;


-- �ý��� ��Ű��
SELECT  COUNT(*)
  FROM dba_objects
 WHERE object_name LIKE 'DBMS%'
   AND object_type = 'PACKAGE';

-- DBMS_OUTPUT
BEGIN
   DBMS_OUTPUT.PUT('ABCD');
   DBMS_OUTPUT.PUT('EFG');
   DBMS_OUTPUT.NEW_LINE();
END;      


BEGIN
   DBMS_OUTPUT.PUT_LINE('ABCD');
   DBMS_OUTPUT.PUT_LINE('EFG');
END;      


DECLARE
  v_line VARCHAR2(50);
  v_status INTEGER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Oracle is my favorite DBMS System!');
  DBMS_OUTPUT.GET_LINE(v_line, v_status);
  
  DBMS_OUTPUT.PUT_LINE('v_line is ' || v_line);
  DBMS_OUTPUT.PUT_LINE('v_status is ' || v_status);   

END;


DECLARE
  v_line DBMS_OUTPUT.CHARARR;
  v_numlines INTEGER;
BEGIN
  v_line(1) := 'The hills are alive with the sound of music!';
  v_line(2) := 'Kiss and Say good-bye!';
  v_line(3) := 'You are so beautiful to me!';
  v_line(4) := 'How deep is your love!';
  v_line(5) := 'Yesterday!';
  DBMS_OUTPUT.PUT_LINE('A: ' || v_line(1));
  DBMS_OUTPUT.PUT_LINE('A: ' || v_line(2));  
  DBMS_OUTPUT.PUT_LINE('A: ' || v_line(3));
  DBMS_OUTPUT.PUT_LINE('A: ' || v_line(5));  
  
  v_numlines := 2;
  DBMS_OUTPUT.GET_LINES(v_line, v_numlines);

  FOR i IN 1 .. v_numlines LOOP
      DBMS_OUTPUT.PUT_LINE('B: ' || v_line(i));
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('v_numlines is ' || v_numlines);   

END;
  

-- DBMS_JOB 
CREATE TABLE job_test ( job_result VARCHAR2(100));

CREATE OR REPLACE PROCEDURE my_job_test 
IS
   V_JOB_RESULT JOB_TEST.JOB_RESULT%TYPE;
BEGIN
  SELECT SYSDATE
    INTO V_JOB_RESULT
    FROM DUAL;
    
  V_JOB_RESULT := 'JOB TEST IS ' || V_JOB_RESULT;

  INSERT INTO JOB_TEST VALUES (V_JOB_RESULT);
  
  COMMIT;

END;


DECLARE
   V_JOB BINARY_INTEGER := 100;
BEGIN
   DBMS_JOB.SUBMIT (V_JOB, 'my_job_test;', SYSDATE, 'SYSDATE + 1/24/60' );
   COMMIT;   
END;


SELECT *
  FROM job_test;


SELECT JOB, LOG_USER, LAST_DATE, LAST_SEC, INTERVAL
  FROM USER_JOBS;


BEGIN
  DBMS_JOB.REMOVE(24);
END;


SELECT JOB, LOG_USER, LAST_DATE, LAST_SEC, INTERVAL
  FROM USER_JOBS;


-- UTL_FILE 
CREATE OR REPLACE PROCEDURE MY_UTL_FILE (
                   file_path VARCHAR2,
                   file_name VARCHAR2,
                   line_1 VARCHAR2,
                   line_2 VARCHAR2)
IS
    new_file UTL_FILE.FILE_TYPE;
BEGIN
    --������ ��ο� ���ϸ����� ���� ���� ������ ����.
    new_file := UTL_FILE.FOPEN( file_path, file_name, 'w');

    -- �� ��°�� �׹�° �Ķ���ͷ� ���� ������ ���Ͽ� ����.
    UTL_FILE.PUT_LINE(new_file, line_1);
    UTL_FILE.PUT_LINE(new_file, line_2);
    -- ������ �ݴ´�.
    UTL_FILE.FCLOSE(new_file);

END;


EXEC MY_UTL_FILE('C:\', 'MYFIRST.TXT', 'Never say never goodbye', 'Welcome to My World!');


CREATE OR REPLACE DIRECTORY UTL_TEST AS 'C:\';

EXEC MY_UTL_FILE('UTL_TEST', 'MYFIRST.TXT', 'Never say never goodbye', 'Welcome to My World!');


-- UTL_TCP 
DECLARE
  c utl_tcp.connection; -- �� ������ ������ TCP/IP ���ؼ�
  ret_val pls_integer;
BEGIN
  -- ���⼭�� ����Ŭ�� �� ������ ���ؼ��� �δ´�.
  c := utl_tcp.open_connection(remote_host => 'www.oracle.com',
                               remote_port => 80,
                               charset => 'US7ASCII'); 
  -- HTTP Request ����
  ret_val := utl_tcp.write_line(c, 'GET / HTTP/1.0'); 
  ret_val := utl_tcp.write_line(c);
  
BEGIN
     LOOP
        -- ������ ���� Request�� ���� Response ���� ����Ѵ�. 
        dbms_output.put_line(utl_tcp.get_line(c, TRUE)); -- read result
     END LOOP;
    
EXCEPTION
    WHEN utl_tcp.end_of_input THEN
         NULL; 
END;
-- ������ �����Ѵ�. 
    utl_tcp.close_connection(c);
END;

