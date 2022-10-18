-- PL/SQL�̶�?
DECLARE
   counter INTEGER;
BEGIN
   counter := counter + 1;
   IF counter IS NULL THEN
      dbms_output.put_line('Result : COUNTER IS Null');
   END IF;
END;


DECLARE
   counter INTEGER;
   i  INTEGER;
BEGIN
   FOR i IN 1..10 LOOP
       counter := (2 * i);
       dbms_output.put_line(' 2 * ' || i || ' = ' || counter );
   END LOOP;
END;


DECLARE
   counter INTEGER;
BEGIN
   counter := 10;
   counter := counter / 0;
   dbms_output.put_line(counter);
END;


DECLARE
   counter INTEGER;
BEGIN
   counter := 10;
   counter := counter / 0;
   dbms_output.put_line(counter);
EXCEPTION WHEN OTHERS THEN
   dbms_output.put_line('ERRORS');
END;


DECLARE
   counter INTEGER;
BEGIN
   counter := 10;
   counter := counter / 0;
   dbms_output.put_line(counter);
EXCEPTION WHEN ZERO_DIVIDE THEN
   dbms_output.put_line('ERRORS');
END;


DECLARE
   counter INTEGER;
BEGIN
   counter := 10;
   counter := counter / 0;
   dbms_output.put_line(counter);
EXCEPTION WHEN ZERO_DIVIDE THEN
   counter := counter / 1;
   dbms_output.put_line(counter);
END;


-- PL/SQL�� ������ҵ� 
DECLARE
  TYPE varray_test IS VARRAY(3) OF INTEGER;  
  -- INTEGER �� ��� 3���� ������ varray Ÿ�� ����
  TYPE nested_test IS TABLE OF VARCHAR2(10); 
  -- VARCHAR2(10)�� ��ҷ� ������ nested table Ÿ�� ����(�ִ밪�� ����)
  TYPE assoc_array_num_type IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  -- Ű�� PLS_INTEGER ���̸�, ���� NUMBER���� ��ҵ��
  -- ������ associative arry Ÿ��1
  TYPE assoc_array_str_type IS TABLE OF VARCHAR2(32) INDEX BY PLS_INTEGER;
  -- Ű�� PLS_INTEGER ���̸�, ���� VARCHAR2(32)���� ��ҵ�� ������ 
  -- associative arry Ÿ��2
  TYPE assoc_array_str_type2 IS TABLE OF VARCHAR2(32) INDEX BY VARCHAR2(64);
  -- Ű�� VARCHAR2(64) ���̸�, ���� VARCHAR2(32)���� ��ҵ��
  -- ������ associative arry Ÿ��3
       
  varray1 varray_test;   -- ������ ������ varray_test Ÿ�� ����
  nested1 nested_test;   -- ������ ������ nested_test Ÿ�� ����
  
  assoc1 assoc_array_num_type;   -- ������ ������ assoc_array_num_type Ÿ�� ����
  assoc2 assoc_array_str_type;   -- ������ ������ assoc_array_str_type Ÿ�� ����
  assoc3 assoc_array_str_type2;  -- ������ ������ assoc_array_str_type2 Ÿ�� ����
BEGIN
 varray1 := varray_test(1,2,3);    -- varray_test�� ��� ũ�Ⱑ 3�̹Ƿ� 
-- 3���� ��Ҹ� varray1 ������ �ִ´�.
 nested1 := nested_test('A','B','C','D');   --nested_test�� ��� ũ�������� ����
 
 assoc1(3) := 33;                   -- assoc_array_num_type�� Ű�� 3, ���� 33�� �ִ´�.
 assoc2(2) := 'TT';                 -- assoc_array_str_type Ű�� 2, ���� TT�� �ִ´�. 
 assoc3('O') := 'ORACLE';           -- assoc_array_str_type2 Ű�� O, ���� ORACLE�� �ִ´�.  
 assoc3('K') := 'KOREA';            -- assoc_array_str_type2 Ű�� K, ���� KOREA�� �ִ´�.  
 
 dbms_output.put_line(varray1(1));  --varray_test�� ù��° ��Ұ��� ���, ����� 1
 dbms_output.put_line(nested1(2));  --nested_test �ι�° ��Ұ��� ���, ����� B
 
 dbms_output.put_line(assoc1(3));   --assoc_array_num_type�� Ű���� 3�� ��Ұ��� ���, ����� 33
 dbms_output.put_line(assoc2(2));   --assoc_array_str_type�� Ű���� 2�� ��Ұ��� ���, ����� TT
 dbms_output.put_line(assoc3('O'));  --assoc_array_str_type2�� Ű���� O�� ��Ұ��� ���, ����� ORACLE
 dbms_output.put_line(assoc3('K'));  --assoc_array_str_type2�� Ű���� K�� ��Ұ��� ���, ����� KOREA
END;



CREATE TYPE alphabet_typ AS VARRAY(26) OF VARCHAR2(2);


DECLARE
  test_alph alphabet_typ;
BEGIN
  test_alph := alphabet_typ('A','B','C','D');
  
  DBMS_OUTPUT.PUT_LINE(test_alph(2));

END;


DECLARE
   -- TYPE���� ������ ���ڵ�
   TYPE record1 IS RECORD ( dep_id NUMBER NOT NULL := 300, dep_name VARCHAR2(30),
                            man_id NUMBER, loc_id NUMBER );
                            
   -- ������ ������ record1�� �޴� ���� ����
   rec1 record1; 
   
   -- ���̺��%ROWTYPE�� �̿��� ���ڵ� ����
   rec2 departments%ROWTYPE;
   
   CURSOR C1 IS 
          SELECT department_id, department_name, location_id
            FROM departments
           WHERE location_id = 1700;
           
   -- Ŀ����%ROWTYPE �� �̿��� ���ڵ� ����        
   rec3 C1%ROWTYPE;        

BEGIN
   -- record1 ���ڵ� ���� rec1�� dep_name �ʵ忡 �� �Ҵ�.
   rec1.dep_name := '���ڵ�μ�1';
   
   -- rec2 ������ �� �Ҵ�
   rec2.department_id := 400;
   rec2.department_name := '���ڵ�μ�2';
   rec2.location_id := 2700;
   
   -- rec1 ���ڵ� ���� departments ���̺� INSERT
   INSERT INTO departments  VALUES rec1;
   
   -- rec2 ���ڵ� ���� departments ���̺� INSERT
   INSERT INTO departments VALUES rec2;
   
   -- Ŀ�� ����
   OPEN C1;
   
   LOOP
     -- Ŀ�� ���� rec3�� �Ҵ��Ѵ�. ���� ���� �ƴ� department_id, department_name, 
     -- location_id ���� ���ڵ� ������ �Ҵ�ȴ�.
     FETCH C1 INTO rec3;
     dbms_output.put_line(rec3.department_id);
     EXIT WHEN C1%NOTFOUND;
   END LOOP;

   COMMIT;
EXCEPTION WHEN OTHERS THEN
               ROLLBACK;
END;     


-- PL/SQL ����� Ŀ��
DECLARE
  grade CHAR(1);
BEGIN
  grade := 'B';
  
  IF grade = 'A' THEN
     dbms_output.put_line('Excellent');
  ELSIF grade = 'B'  THEN
     dbms_output.put_line('Good');
  ELSIF grade = 'C'  THEN
     dbms_output.put_line('Fair');
  ELSIF grade = 'D'  THEN
     dbms_output.put_line('Poor');         
  END IF;
END;



DECLARE
  grade CHAR(1);
BEGIN
  grade := 'B';
  
  CASE grade
     WHEN 'A' THEN
          dbms_output.put_line('Excellent');
     WHEN 'B' THEN
          dbms_output.put_line('Good');
     WHEN 'C' THEN
          dbms_output.put_line('Fair');
     WHEN 'D' THEN
          dbms_output.put_line('Poor');  
     ELSE 
          dbms_output.put_line('Not Found');  
  END CASE;
     
END;



DECLARE
  test_number INTEGER;
  result_num  INTEGER;
BEGIN
  test_number := 1;
  
  LOOP
    result_num := 2 * test_number;
    IF result_num > 20 THEN
       EXIT;
    ELSE
       dbms_output.put_line(result_num);
    END IF;  
    test_number := test_number + 1;
  END LOOP;

END;


DECLARE
  test_number INTEGER;
  result_num  INTEGER;
BEGIN
  test_number := 1;
  
  LOOP
    result_num := 2 * test_number;

    EXIT WHEN result_num > 20;

    dbms_output.put_line(result_num);
    test_number := test_number + 1;
  END LOOP;

END;


DECLARE
  test_number INTEGER;
  result_num  INTEGER;
BEGIN
  test_number := 1;
  
  WHILE result_num <= 20 LOOP

    result_num := 2 * test_number;
    dbms_output.put_line(result_num);
    test_number := test_number + 1;

  END LOOP;

END;


DECLARE
  test_number INTEGER;
  result_num  INTEGER;
BEGIN
  test_number := 1;
  result_num := 0;
  
  WHILE result_num <= 20 LOOP

    result_num := 2 * test_number;
    dbms_output.put_line(result_num);
    test_number := test_number + 1;

  END LOOP;

END;


DECLARE
  test_number INTEGER;
  result_num  INTEGER;
BEGIN
  test_number := 1;
  result_num := 0;
  
  dbms_output.put_line('<<first>>');
  <<first>>
  FOR test_number IN 1..10 LOOP

    result_num := 2 * test_number;
    dbms_output.put_line(result_num);
  END LOOP;

  dbms_output.put_line('<<second>>');
  
  result_num := 0;
  <<second>>
  FOR test_number IN REVERSE 1..10 LOOP

    result_num := 2 * test_number;
    dbms_output.put_line(result_num);
  END LOOP;
    
END;


DECLARE
  test_number INTEGER;
  result_num  INTEGER;
BEGIN
  test_number := 1;
  result_num := 0;
  
  GOTO second;
  dbms_output.put_line('<<first>>');
  <<first>>
  FOR test_number IN 1..10 LOOP

    result_num := 2 * test_number;
    dbms_output.put_line(result_num);
  END LOOP;

    <<second>>
  result_num := 0;
  dbms_output.put_line('<<second>>');
  FOR test_number IN REVERSE 1..10 LOOP

    result_num := 2 * test_number;
    dbms_output.put_line(result_num);
  END LOOP;
    
END;


DECLARE
   CURSOR emp_csr IS                          -- Ŀ�� �����
      SELECT employee_id
        FROM employees
       WHERE department_id = 100;
       
   emp_id employees.employee_id%TYPE;
BEGIN
   OPEN emp_csr;                                --Ŀ�� ����
   
   LOOP
     FETCH emp_csr INTO emp_id;               -- Ŀ�� ��ġ
     EXIT WHEN emp_csr%NOTFOUND;          
     dbms_output.put_line(emp_id);
   END LOOP;
   
   CLOSE emp_csr;                               -- Ŀ�� �ݱ�
END;


DECLARE
  count1 NUMBER;
  count2 NUMBER;
BEGIN
  SELECT count(*)
    INTO count1
    FROM employees
   WHERE department_id = 100;
  
  count2 := SQL%ROWCOUNT; 
  dbms_output.put_line('SELECT COUNT IS ' || count1 );  
  dbms_output.put_line('ROW COUNT IS ' || count2 );
  
END;



-- PL/SQL �������α׷�
-- �Լ�
CREATE OR REPLACE FUNCTION emp_salaries ( emp_id number )
          RETURN NUMBER IS
    nSalaries NUMBER(9);	 	  
BEGIN

  nSalaries := 0;
  SELECT salary
    INTO nSalaries
    FROM employees
   WHERE employee_id = emp_id;
   
  RETURN nSalaries;
END;


SELECT emp_salaries(100)
  FROM DUAL;


SELECT employee_id, first_name, emp_salaries(employee_id)
  FROM employees
 WHERE department_id = 100;


CREATE OR REPLACE FUNCTION get_dep_name ( dep_id NUMBER )
       RETURN VARCHAR2 IS
       
     sDepName VARCHAR2(30);
BEGIN
    SELECT department_name
      INTO sDepName
      FROM departments
     WHERE department_id = dep_id;

    RETURN sDepName;
END;     

SELECT a.employee_id, a.first_name || ' ' || a.last_name names,
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id ) dep_names
  FROM employees a
 WHERE a.department_id = 100;

SELECT a.employee_id, a.first_name || ' ' || a.last_name names,
       get_dep_name(a.department_id) dep_names
  FROM employees a
 WHERE a.department_id = 100; 


-- ���ν���
CREATE OR REPLACE PROCEDURE register_emp ( 
           f_name VARCHAR2,
           l_name VARCHAR2,
           e_acct VARCHAR2,
			     j_id   VARCHAR2)  IS 

BEGIN
  INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id )
  VALUES ( EMPLOYEES_SEQ.NEXTVAL, f_name, l_name, e_acct, sysdate, j_id );
  
COMMIT;

EXCEPTION WHEN OTHERS THEN  
  DBMS_OUTPUT.PUT_LINE( f_name || ' ' || l_name || ' register is failed!');
  ROLLBACK;
END;


EXECUTE register_emp('����', '��', 'djoyoung', 'IT_PROG');

SELECT first_name, last_name, email, job_id, hire_date
  FROM employees
 WHERE last_name = '��'; 


CREATE OR REPLACE PROCEDURE emp_setting ( emp_id NUMBER,
                                          dep_id NUMBER,
                                          phone VARCHAR2,
                                          salaries NUMBER )
IS
   sManager_id employees.manager_id%type; 
BEGIN
  -- �ش� �μ��� �޴��� id���� �޾ƿ´�..
  SELECT manager_id
    INTO sManager_id
    FROM departments
   WHERE department_id = dep_id;

  -- employees ���̺� �μ���ȣ, ��ȭ��ȣ, �޿�, �޴��� ID�� update �Ѵ�. 
  UPDATE employees
     SET department_id = dep_id,
         phone_number  = phone,
         salary        = salaries,
         manager_id    = sManager_id
   WHERE employee_id = emp_id;

COMMIT;

EXCEPTION WHEN OTHERS THEN  
  DBMS_OUTPUT.PUT_LINE( 'employees update is failed!');
  ROLLBACK;
END;


EXEC emp_setting (210, 60, '590.423.1234', 4500);

SELECT last_name || first_name names, phone_number, salary, department_id
  FROM employees
 WHERE employee_id = 210;


CREATE OR REPLACE PROCEDURE emp_transfer (
 emp_id NUMBER,
                               trans_dept_id NUMBER,
                               trans_job_id VARCHAR2,
                               up_salary NUMBER)
IS 
  new_dept_id employees.department_id%TYPE; -- �̵��� �μ���ȣ ����
  new_job_id employees.job_id%TYPE;          -- ���ο� ���޹�ȣ ����
  max_salaries jobs.max_salary%TYPE;         -- ���޿� ���� �ִ�޿��� ����
  min_salaries jobs.max_salary%TYPE;          -- ���޿� ���� �ּұ޿��� ����
  
  salary_too_high EXCEPTION;           -- �޿��� �ʹ� ���� ��� ó���� exception
  salary_too_low  EXCEPTION;          -- �޿��� �ʹ� ���� ��� ó���� exception
BEGIN
   
   -- �μ��̵��� �ִ� ���...
   IF trans_dept_id IS NOT NULL THEN
      new_dept_id := trans_dept_id; 
   END IF;

   -- �����̵� �ִ� ���...
   IF trans_dept_id IS NOT NULL THEN
      --  ���ο� ����ID, �ִ�޿���, �ּұ޿����� �����´�.
      SELECT job_id, max_salary, min_salary
        INTO new_job_id, max_salaries, min_salaries
        FROM JOBS
       WHERE job_id = trans_job_id;
        
	--�Է��� �޿����� �ִ�޿��׺��� Ŭ ���...
	IF up_salary > max_salaries THEN
	   RAISE salary_too_high;  -- ����� ���� ����(EXCEPTION)�� �߻���Ų��. 
	--�Է��� �޿����� �ּұ޿��׺��� ���� ���... 
	ELSIF up_salary < min_salaries THEN
	   RAISE salary_too_low;   -- ����� ���� ����(EXCEPTION)�� �߻���Ų��. 
	END IF;
	      
   END IF;
   
   -- �μ�, ����, �޿� ������ �����Ѵ�. 
   UPDATE employees
      SET department_id = NVL(new_dept_id, department_id),
	           job_id = NVL(new_job_id, job_id),
		   salary = NVL(up_salary, salary)
	WHERE employee_id = emp_id;

   COMMIT;
EXCEPTION WHEN salary_too_high THEN
                -- ������ RAISE salary_too_high�� �߻��Ǹ� ���⼭ ó���Ѵ�.
                DBMS_OUTPUT.PUT_LINE('Salary is exceed maximum salary!');
	        ROLLBACK;
WHEN salary_too_low THEN
		-- ������ RAISE salary_too_low�� �߻��Ǹ� ���⼭ ó���Ѵ�.
		DBMS_OUTPUT.PUT_LINE('Salary is lower than minimum salary');
		ROLLBACK;
	    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
		ROLLBACK;
		  
END;

EXEC emp_transfer(198, 60, 'IT_PROG', 3200);

SELECT last_name || first_name names, job_id, salary, department_id
  FROM employees
 WHERE employee_id = 198;


--��Ű��

CREATE OR REPLACE PACKAGE employee_process AS
   -- Ÿ��, Ŀ��, exception ����.
   TYPE EmpRecord  IS RECORD (emp_id INT, salary REAL);
   TYPE DeptRecord IS RECORD (dept_id INT, loc_id INT);
   
   -- ������ ������ EmpRecord�� ��ȯ�ϴ� Ŀ�� ����
   CURSOR salaries RETURN EmpRecord;
   -- �޿��� ���� ���� ��� ����ó���� ���� exception ����
   invalid_salary EXCEPTION;
   -- 
   PROCEDURE hire_employee (
                first_name VARCHAR2,
                last_name VARCHAR2,
                emails VARCHAR2,
                job_id VARCHAR2,
                mgr_id REAL,
                salary REAL,
                commission REAL,
                dept_id REAL); 

  PROCEDURE fire_employee (emp_id INT);
  PROCEDURE raise_salary (emp_id INT, j_id VARCHAR2, amount REAL);
  FUNCTION nth_highest_salary (n INT) RETURN EmpRecord;
  FUNCTION sal_ok (j_id VARCHAR2, salary REAL) RETURN BOOLEAN;
END employee_process;


CREATE OR REPLACE PACKAGE BODY employee_process  AS
   -- �� ������ �����ο� ����Ǿ������� PRIVATE �Ӽ��� ������. 
   number_hired INT; 
   
   -- ��úο��� ������ Ŀ���� �����Ѵ�. 
   CURSOR salaries RETURN EmpRecord IS
      SELECT employee_id, salary 
        FROM employees
	   ORDER BY salary DESC;
	 
   -- �űԻ���� ����Ѵ�. 
   PROCEDURE hire_employee (
                first_name VARCHAR2,
		            last_name VARCHAR2,
		            emails VARCHAR2,
                job_id VARCHAR2,
                mgr_id REAL,
                salary REAL,
                commission REAL,
                dept_id REAL) IS  
	     new_employee_id INT;
   BEGIN
      -- �űԻ�� ����� ����, employee_id ���� ��������ȣ�� �����´�.  
      SELECT employees_seq.NEXTVAL 
        INTO new_employee_id 
	    FROM dual;

  -- �űԻ�� ���ó��.
      INSERT INTO employees ( employee_id, first_name, last_name, email, job_id,
	                            manager_id, hire_date, salary, commission_pct, department_id )
	    VALUES (new_employee_id, first_name, last_name, emails, job_id, mgr_id, SYSDATE, 
              salary, commission, dept_id);
	  
      number_hired := number_hired + 1;

      
   END hire_employee;
   
   -- ���ó���� �Ѵ�. 
   PROCEDURE fire_employee (emp_id INT) IS
   BEGIN
      -- ���ó���� ����� employees ���̺��� �����Ѵ�. 
      DELETE employees
	  WHERE employee_id = emp_id;
	  
	  COMMIT;
	  
	  EXCEPTION WHEN OTHERS THEN
	            DBMS_OUTPUT.PUT_LINE('DELETE ERRORS');
		    ROLLBACK;
   END fire_employee;
   

   -- ���޿� ���� �޿��� ������ ���ԵǴ����� �˻��Ͽ� �� ����� ��ȯ�ϴ� �Լ� 
   FUNCTION sal_ok (j_id VARCHAR2, salary REAL) 
      RETURN BOOLEAN IS
         min_sal REAL;
         max_sal REAL;
   BEGIN
     -- �ش� ������ �ּ�, �ִ�޿����� �����´�. 
     SELECT min_salary, max_salary 
	   INTO min_sal, max_sal 
	   FROM jobs
      WHERE job_id = j_id;

	 -- �Ķ���ͷ� ������ salary �ݾ��� �ش� ������ �ּҿ� �ִ�ݾ� ���̿� ���� ���
-- ���� TRUE��, �׷��� ������ FALSE�� ��ȯ�Ѵ�. 
	 -- (AND �����̹Ƿ� �� ���� ��� �����ؾ� TRUE�� ��ȯ�Ѵ�)
     RETURN (salary >= min_sal) AND (salary <= max_sal);
   END sal_ok;

   -- �޿��� �ø��� ���ν�����, �ø����� �ϴ� �ݾ��� amout�� �ִ´�. 
   PROCEDURE raise_salary (emp_id INT, j_id VARCHAR2, amount REAL) IS
         current_sal REAL;
   BEGIN
     -- ���� �޿��� ����, current_sal ���� �Ҵ��Ѵ�. 
     SELECT salary 
	   INTO current_sal 
	   FROM employees 
	  WHERE employee_id = emp_id;

	 -- sal_ok �Լ��� ȣ���Ͽ� �ش� ����� ���޿� ���� �ּ� �� �ִ�޿��� ������ 
-- ��ٸ�, ����޿�+�λ�޿� ���� employees ���̺� �����Ѵ�. 
     IF sal_ok(j_id, current_sal + amount) THEN
        UPDATE employees 
		   SET salary = current_sal + amount 
		 WHERE employee_id = emp_id;
     ELSE -- ���� ���� ������ �޿��׿� ���Ե��� ���� ���, ���ܸ� �߻���Ų��. 
       RAISE invalid_salary;
     END IF;
	 
	 COMMIT;
	 
	 DBMS_OUTPUT.PUT_LINE('Upgrade OK!!');
	 EXCEPTION WHEN invalid_salary THEN
	                DBMS_OUTPUT.PUT_LINE('Salaries Too High');
			   WHEN OTHERS THEN
			        DBMS_OUTPUT.PUT_LINE(SQLERRM);
					ROLLBACK;
   END raise_salary;

   -- 
   FUNCTION nth_highest_salary (n INT) 
            RETURN EmpRecord IS
       emp_rec EmpRecord;
   BEGIN
     -- Ŀ���� �����Ѵ�. 
     OPEN salaries;

     FOR i IN 1..n LOOP
         FETCH salaries INTO emp_rec;
     END LOOP;

     CLOSE salaries;

     RETURN emp_rec;
   END nth_highest_salary;

BEGIN 
   number_hired := 0;
END employee_process;



EXEC employee_process.hire_employee ( '����','��', 'blackstone', 'IT_PROG', 210, 5000, 0, 60);

COMMIT;

SELECT first_name, last_name
FROM employees
 WHERE first_name = '����';


EXEC employee_process.raise_salary(210, 'IT_PROG', 6000);

EXEC employee_process.raise_salary(210, 'IT_PROG', 5000);

SELECT salary
  FROM employees
 WHERE employee_id = 210;


SELECT employee_process.sal_ok('IT_PROG', 5000)
    FROM DUAL;


EXEC employee_process.fire_employee(214);


SELECT last_name, first_name
  FROM employees
 WHERE employee_id = 214;



DECLARE
  -- employee_process ��Ű������ ����� EmpRecord ���ڵ� Ÿ���� ������ �����Ѵ�.
  test_emp employee_process.EmpRecord;
BEGIN
  -- ���� ���� �θ��� ��ȸ�ؼ�, �� ����� test_emp ���ڵ� ������ �ִ´�.
  test_emp := employee_process.nth_highest_salary(1);
  -- �ش� ��� ������ ����Ѵ�. 
  dbms_output.put_line('employee_id is : ' || test_emp.emp_id);
  dbms_output.put_line('salary is : ' || test_emp.salary);
END;
