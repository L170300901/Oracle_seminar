/****************************/ 
/* 3. SQL 해부              */
/****************************/

SELECT last_name, first_name
  FROM employees
 WHERE hire_date >= '2006-01-01';

ⓐ INSERT INTO temp_emp (id, name) VALUES (1, '홍길동'); 

SELECT name FROM temp_emp
      WHERE id = 1;    

ⓑ COMMIT;

ⓒ UPDATE temp_emp
   SET name = '홍인영'
    WHERE id = 1;

ⓓ INSERT INTO temp_emp (id, name) VALUES(2, '홍판서');

ⓔ COMMIT;  

   SELECT name FROM temp_emp
     WHERE id = 1;   

ⓕ DELETE temp_emp;

ⓖ ROLLBACK;
   
   SELECT name FROM temp_emp
    WHERE id = 1;   
    
/****************************/ 
/* 4. SQL 문장의 구성요소들 */
/****************************/

CREATE TABLE SELECT (id int);

SELECT keyword
  FROM V$RESERVED_WORDS
 ORDER BY keyword;

SELECT employee_id, last_name, ROWNUM
  FROM EMPLOYEES
 WHERE ROWNUM <= 10;

 
/****************************/ 
/* 5. 샘플 스키마 설치      */
/****************************/

-- 사용자 계정 변경
ALTER USER HR IDENTIFIED BY HR ACCOUNT UNLOCK;

ALTER USER PM IDENTIFIED BY PM ACCOUNT UNLOCK;

ALTER USER IX IDENTIFIED BY IX ACCOUNT UNLOCK;

ALTER USER SH IDENTIFIED BY SH ACCOUNT UNLOCK;

ALTER USER BI IDENTIFIED BY BI ACCOUNT UNLOCK;

SQL> @ C:\oracle\product\10.2.0\db_1\demo\schema\mksample.sql;


-- 샘플 스키마 설치 확인
SELECT *
FROM DBA_OBJECTS
WHERE OWNER IN ('HR', 'OE' , 'PM', 'IX', 'SH', 'BI');

--혹은
SELECT *
FROM ALL_OBJECTS
WHERE OWNER IN ('HR', 'OE' , 'PM', 'IX', 'SH', 'BI');

-- 샘플 스키마 한글화
SQL>@ C:\hr_schema_data.sql;

