/****************************/ 
/* 3. SQL �غ�              */
/****************************/

SELECT last_name, first_name
  FROM employees
 WHERE hire_date >= '2006-01-01';

�� INSERT INTO temp_emp (id, name) VALUES (1, 'ȫ�浿'); 

SELECT name FROM temp_emp
      WHERE id = 1;    

�� COMMIT;

�� UPDATE temp_emp
   SET name = 'ȫ�ο�'
    WHERE id = 1;

�� INSERT INTO temp_emp (id, name) VALUES(2, 'ȫ�Ǽ�');

�� COMMIT;  

   SELECT name FROM temp_emp
     WHERE id = 1;   

�� DELETE temp_emp;

�� ROLLBACK;
   
   SELECT name FROM temp_emp
    WHERE id = 1;   
    
/****************************/ 
/* 4. SQL ������ ������ҵ� */
/****************************/

CREATE TABLE SELECT (id int);

SELECT keyword
  FROM V$RESERVED_WORDS
 ORDER BY keyword;

SELECT employee_id, last_name, ROWNUM
  FROM EMPLOYEES
 WHERE ROWNUM <= 10;

 
/****************************/ 
/* 5. ���� ��Ű�� ��ġ      */
/****************************/

-- ����� ���� ����
ALTER USER HR IDENTIFIED BY HR ACCOUNT UNLOCK;

ALTER USER PM IDENTIFIED BY PM ACCOUNT UNLOCK;

ALTER USER IX IDENTIFIED BY IX ACCOUNT UNLOCK;

ALTER USER SH IDENTIFIED BY SH ACCOUNT UNLOCK;

ALTER USER BI IDENTIFIED BY BI ACCOUNT UNLOCK;

SQL> @ C:\oracle\product\10.2.0\db_1\demo\schema\mksample.sql;


-- ���� ��Ű�� ��ġ Ȯ��
SELECT *
FROM DBA_OBJECTS
WHERE OWNER IN ('HR', 'OE' , 'PM', 'IX', 'SH', 'BI');

--Ȥ��
SELECT *
FROM ALL_OBJECTS
WHERE OWNER IN ('HR', 'OE' , 'PM', 'IX', 'SH', 'BI');

-- ���� ��Ű�� �ѱ�ȭ
SQL>@ C:\hr_schema_data.sql;

