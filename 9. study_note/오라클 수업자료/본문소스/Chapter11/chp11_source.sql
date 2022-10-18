-- PL/SQL이란?
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


-- PL/SQL의 구성요소들 
DECLARE
  TYPE varray_test IS VARRAY(3) OF INTEGER;  
  -- INTEGER 형 요소 3개로 구성된 varray 타입 선언
  TYPE nested_test IS TABLE OF VARCHAR2(10); 
  -- VARCHAR2(10)형 요소로 구성된 nested table 타입 선언(최대값이 없다)
  TYPE assoc_array_num_type IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  -- 키는 PLS_INTEGER 형이며, 값은 NUMBER형인 요소들로
  -- 구성된 associative arry 타입1
  TYPE assoc_array_str_type IS TABLE OF VARCHAR2(32) INDEX BY PLS_INTEGER;
  -- 키는 PLS_INTEGER 형이며, 값은 VARCHAR2(32)형인 요소들로 구성된 
  -- associative arry 타입2
  TYPE assoc_array_str_type2 IS TABLE OF VARCHAR2(32) INDEX BY VARCHAR2(64);
  -- 키는 VARCHAR2(64) 형이며, 값은 VARCHAR2(32)형인 요소들로
  -- 구성된 associative arry 타입3
       
  varray1 varray_test;   -- 위에서 선언한 varray_test 타입 변수
  nested1 nested_test;   -- 위에서 선언한 nested_test 타입 변수
  
  assoc1 assoc_array_num_type;   -- 위에서 선언한 assoc_array_num_type 타입 변수
  assoc2 assoc_array_str_type;   -- 위에서 선언한 assoc_array_str_type 타입 변수
  assoc3 assoc_array_str_type2;  -- 위에서 선언한 assoc_array_str_type2 타입 변수
BEGIN
 varray1 := varray_test(1,2,3);    -- varray_test의 경우 크기가 3이므로 
-- 3개의 요소를 varray1 변수에 넣는다.
 nested1 := nested_test('A','B','C','D');   --nested_test의 경우 크기제한이 없다
 
 assoc1(3) := 33;                   -- assoc_array_num_type의 키는 3, 값은 33을 넣는다.
 assoc2(2) := 'TT';                 -- assoc_array_str_type 키는 2, 값은 TT를 넣는다. 
 assoc3('O') := 'ORACLE';           -- assoc_array_str_type2 키는 O, 값은 ORACLE을 넣는다.  
 assoc3('K') := 'KOREA';            -- assoc_array_str_type2 키는 K, 값은 KOREA를 넣는다.  
 
 dbms_output.put_line(varray1(1));  --varray_test의 첫번째 요소값을 출력, 결과는 1
 dbms_output.put_line(nested1(2));  --nested_test 두번째 요소값을 출력, 결과는 B
 
 dbms_output.put_line(assoc1(3));   --assoc_array_num_type의 키값이 3인 요소값을 출력, 결과는 33
 dbms_output.put_line(assoc2(2));   --assoc_array_str_type의 키값이 2인 요소값을 출력, 결과는 TT
 dbms_output.put_line(assoc3('O'));  --assoc_array_str_type2의 키값이 O인 요소값을 출력, 결과는 ORACLE
 dbms_output.put_line(assoc3('K'));  --assoc_array_str_type2의 키값이 K인 요소값을 출력, 결과는 KOREA
END;



CREATE TYPE alphabet_typ AS VARRAY(26) OF VARCHAR2(2);


DECLARE
  test_alph alphabet_typ;
BEGIN
  test_alph := alphabet_typ('A','B','C','D');
  
  DBMS_OUTPUT.PUT_LINE(test_alph(2));

END;


DECLARE
   -- TYPE으로 선언한 레코드
   TYPE record1 IS RECORD ( dep_id NUMBER NOT NULL := 300, dep_name VARCHAR2(30),
                            man_id NUMBER, loc_id NUMBER );
                            
   -- 위에서 선언한 record1을 받는 변수 선언
   rec1 record1; 
   
   -- 테이블명%ROWTYPE을 이용한 레코드 선언
   rec2 departments%ROWTYPE;
   
   CURSOR C1 IS 
          SELECT department_id, department_name, location_id
            FROM departments
           WHERE location_id = 1700;
           
   -- 커서명%ROWTYPE 을 이용한 레코드 선언        
   rec3 C1%ROWTYPE;        

BEGIN
   -- record1 레코드 변수 rec1의 dep_name 필드에 값 할당.
   rec1.dep_name := '레코드부서1';
   
   -- rec2 변수에 값 할당
   rec2.department_id := 400;
   rec2.department_name := '레코드부서2';
   rec2.location_id := 2700;
   
   -- rec1 레코드 값을 departments 테이블에 INSERT
   INSERT INTO departments  VALUES rec1;
   
   -- rec2 레코드 값을 departments 테이블에 INSERT
   INSERT INTO departments VALUES rec2;
   
   -- 커서 오픈
   OPEN C1;
   
   LOOP
     -- 커서 값을 rec3에 할당한다. 개별 값이 아닌 department_id, department_name, 
     -- location_id 값이 레코드 단위로 할당된다.
     FETCH C1 INTO rec3;
     dbms_output.put_line(rec3.department_id);
     EXIT WHEN C1%NOTFOUND;
   END LOOP;

   COMMIT;
EXCEPTION WHEN OTHERS THEN
               ROLLBACK;
END;     


-- PL/SQL 문장과 커서
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
   CURSOR emp_csr IS                          -- 커서 선언부
      SELECT employee_id
        FROM employees
       WHERE department_id = 100;
       
   emp_id employees.employee_id%TYPE;
BEGIN
   OPEN emp_csr;                                --커서 오픈
   
   LOOP
     FETCH emp_csr INTO emp_id;               -- 커서 패치
     EXIT WHEN emp_csr%NOTFOUND;          
     dbms_output.put_line(emp_id);
   END LOOP;
   
   CLOSE emp_csr;                               -- 커서 닫기
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



-- PL/SQL 서브프로그램
-- 함수
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


-- 프로시져
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


EXECUTE register_emp('조영', '대', 'djoyoung', 'IT_PROG');

SELECT first_name, last_name, email, job_id, hire_date
  FROM employees
 WHERE last_name = '대'; 


CREATE OR REPLACE PROCEDURE emp_setting ( emp_id NUMBER,
                                          dep_id NUMBER,
                                          phone VARCHAR2,
                                          salaries NUMBER )
IS
   sManager_id employees.manager_id%type; 
BEGIN
  -- 해당 부서의 메니저 id값을 받아온다..
  SELECT manager_id
    INTO sManager_id
    FROM departments
   WHERE department_id = dep_id;

  -- employees 테이블에 부서번호, 전화번호, 급여, 메니저 ID를 update 한다. 
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
  new_dept_id employees.department_id%TYPE; -- 이동할 부서번호 변수
  new_job_id employees.job_id%TYPE;          -- 새로운 직급번호 변수
  max_salaries jobs.max_salary%TYPE;         -- 직급에 따른 최대급여액 변수
  min_salaries jobs.max_salary%TYPE;          -- 직급에 따른 최소급여액 변수
  
  salary_too_high EXCEPTION;           -- 급여가 너무 높을 경우 처리할 exception
  salary_too_low  EXCEPTION;          -- 급여가 너무 낮을 경우 처리할 exception
BEGIN
   
   -- 부서이동이 있는 경우...
   IF trans_dept_id IS NOT NULL THEN
      new_dept_id := trans_dept_id; 
   END IF;

   -- 직급이동 있는 경우...
   IF trans_dept_id IS NOT NULL THEN
      --  새로운 직급ID, 최대급여액, 최소급여액을 가져온다.
      SELECT job_id, max_salary, min_salary
        INTO new_job_id, max_salaries, min_salaries
        FROM JOBS
       WHERE job_id = trans_job_id;
        
	--입력한 급여액이 최대급여액보다 클 경우...
	IF up_salary > max_salaries THEN
	   RAISE salary_too_high;  -- 사용자 정의 예외(EXCEPTION)를 발생시킨다. 
	--입력한 급여액이 최소급여액보다 작을 경우... 
	ELSIF up_salary < min_salaries THEN
	   RAISE salary_too_low;   -- 사용자 정의 예외(EXCEPTION)를 발생시킨다. 
	END IF;
	      
   END IF;
   
   -- 부서, 직급, 급여 내역을 갱신한다. 
   UPDATE employees
      SET department_id = NVL(new_dept_id, department_id),
	           job_id = NVL(new_job_id, job_id),
		   salary = NVL(up_salary, salary)
	WHERE employee_id = emp_id;

   COMMIT;
EXCEPTION WHEN salary_too_high THEN
                -- 위에서 RAISE salary_too_high가 발생되면 여기서 처리한다.
                DBMS_OUTPUT.PUT_LINE('Salary is exceed maximum salary!');
	        ROLLBACK;
WHEN salary_too_low THEN
		-- 위에서 RAISE salary_too_low가 발생되면 여기서 처리한다.
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


--패키지

CREATE OR REPLACE PACKAGE employee_process AS
   -- 타입, 커서, exception 선언.
   TYPE EmpRecord  IS RECORD (emp_id INT, salary REAL);
   TYPE DeptRecord IS RECORD (dept_id INT, loc_id INT);
   
   -- 위에서 선언한 EmpRecord를 반환하는 커서 선언
   CURSOR salaries RETURN EmpRecord;
   -- 급여가 맞지 않을 경우 예외처리를 위한 exception 선언
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
   -- 이 변수는 구현부에 선언되었음으로 PRIVATE 속성을 가진다. 
   number_hired INT; 
   
   -- 명시부에서 선언한 커서를 정의한다. 
   CURSOR salaries RETURN EmpRecord IS
      SELECT employee_id, salary 
        FROM employees
	   ORDER BY salary DESC;
	 
   -- 신규사원을 등록한다. 
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
      -- 신규사원 등록을 위한, employee_id 값의 시퀀스번호를 가져온다.  
      SELECT employees_seq.NEXTVAL 
        INTO new_employee_id 
	    FROM dual;

  -- 신규사원 등록처리.
      INSERT INTO employees ( employee_id, first_name, last_name, email, job_id,
	                            manager_id, hire_date, salary, commission_pct, department_id )
	    VALUES (new_employee_id, first_name, last_name, emails, job_id, mgr_id, SYSDATE, 
              salary, commission, dept_id);
	  
      number_hired := number_hired + 1;

      
   END hire_employee;
   
   -- 퇴사처리를 한다. 
   PROCEDURE fire_employee (emp_id INT) IS
   BEGIN
      -- 퇴사처리할 사원을 employees 테이블에서 삭제한다. 
      DELETE employees
	  WHERE employee_id = emp_id;
	  
	  COMMIT;
	  
	  EXCEPTION WHEN OTHERS THEN
	            DBMS_OUTPUT.PUT_LINE('DELETE ERRORS');
		    ROLLBACK;
   END fire_employee;
   

   -- 직급에 따른 급여액 범위에 포함되는지를 검사하여 그 결과를 반환하는 함수 
   FUNCTION sal_ok (j_id VARCHAR2, salary REAL) 
      RETURN BOOLEAN IS
         min_sal REAL;
         max_sal REAL;
   BEGIN
     -- 해당 직급의 최소, 최대급여액을 가져온다. 
     SELECT min_salary, max_salary 
	   INTO min_sal, max_sal 
	   FROM jobs
      WHERE job_id = j_id;

	 -- 파라미터로 들어오는 salary 금액이 해당 직급의 최소와 최대금액 사이에 있을 경우
-- 에는 TRUE를, 그렇지 않으면 FALSE를 반환한다. 
	 -- (AND 조건이므로 두 조건 모두 만족해야 TRUE를 반환한다)
     RETURN (salary >= min_sal) AND (salary <= max_sal);
   END sal_ok;

   -- 급여를 올리는 프로시져로, 올리고자 하는 금액을 amout에 넣는다. 
   PROCEDURE raise_salary (emp_id INT, j_id VARCHAR2, amount REAL) IS
         current_sal REAL;
   BEGIN
     -- 현재 급여를 구해, current_sal 값에 할당한다. 
     SELECT salary 
	   INTO current_sal 
	   FROM employees 
	  WHERE employee_id = emp_id;

	 -- sal_ok 함수를 호출하여 해당 사원의 직급에 따른 최소 및 최대급여액 범위에 
-- 든다면, 현재급여+인상급여 액을 employees 테이블에 갱신한다. 
     IF sal_ok(j_id, current_sal + amount) THEN
        UPDATE employees 
		   SET salary = current_sal + amount 
		 WHERE employee_id = emp_id;
     ELSE -- 현재 직급 범위의 급여액에 포함되지 않을 경우, 예외를 발생시킨다. 
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
     -- 커서를 오픈한다. 
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



EXEC employee_process.hire_employee ( '수돌','흑', 'blackstone', 'IT_PROG', 210, 5000, 0, 60);

COMMIT;

SELECT first_name, last_name
FROM employees
 WHERE first_name = '수돌';


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
  -- employee_process 패키지에서 선언된 EmpRecord 레코드 타입의 변수를 선언한다.
  test_emp employee_process.EmpRecord;
BEGIN
  -- 월급 상위 두명을 조회해서, 그 결과를 test_emp 레코드 변수에 넣는다.
  test_emp := employee_process.nth_highest_salary(1);
  -- 해당 사원 정보를 출력한다. 
  dbms_output.put_line('employee_id is : ' || test_emp.emp_id);
  dbms_output.put_line('salary is : ' || test_emp.salary);
END;
