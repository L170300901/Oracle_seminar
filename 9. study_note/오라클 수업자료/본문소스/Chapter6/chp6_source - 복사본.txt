--02. 숫자형 함수
SELECT abs(32), abs(-32)
  FROM dual;

SELECT SIGN(32), SIGN(-32), SIGN(0)
  FROM dual;


CREATE TABLE sign_test (
  n1 number,
  n2 BINARY_FLOAT,
  n3 BINARY_DOUBLE );
  
INSERT INTO sign_test ( n1, n2, n3 ) 
VALUES (0.123456789, 0.123456789, 0.123456789);

SELECT  sign(n1 * 0) number_zero,
        sign(n2 * 0) binary_zero, 
        sign(n2 * 0.123456789123456789) bin_plus, 
        sign(n3 * -0.123456789123456789) bin_minus
  FROM sign_test;
  


SELECT ROUND(0.12345678), ROUND(0.12345678, 0) 
  FROM dual;

SELECT ROUND(0.12345678, 3), 
       ROUND(0.12345678, 4) 
  FROM dual;

SELECT ROUND(1234.12345678, -2) left_round, 
       ROUND(1234.12345678, 2) right_round
  FROM dual;


SELECT TRUNC(1234.12345678) zero1, 
       TRUNC(1234.12345678, 0) zero2,
       TRUNC(1234.12345678, -2) left_trunc, 
       TRUNC(1234.12345678, 2) right_trunc,
       TRUNC(1234.12345678, 5) right_trunc2
  FROM dual;


SELECT CEIL(1234.12345678) ceil1,
       CEIL(0.12345) ceil2
  FROM dual;


SELECT FLOOR(1234.12345678) floor1,
       FLOOR(0.12345) floor2
  FROM dual;


SELECT MOD(777, 4) mod1,
       MOD(1234.1234, 12.12) mod2,
       MOD(777, -4) mod3,
       MOD(-777, -4) mod4, 
       MOD(777, 0) mod_zero
  FROM dual


SELECT REMAINDER(777, 4) remainder1,
       REMAINDER(1234.1234, 12.12) remainder2,
       REMAINDER(777, -4) remainder3,
       REMAINDER(-777, -4) remainder4
  FROM dual;


SELECT 1234.1234 - (12.12 * FLOOR(1234.1234 / 12.12)) mod_calc,
       1234.1234 - (12.12 * ROUND(1234.1234 / 12.12)) remainder_calc,
       1234.1234/12.12 quotient 
  FROM dual;     


SELECT REMAINDER(4,0) 
  FROM dual;


SELECT POWER(3,2) p1,
       POWER(3,3) p2,
       POWER(3, 2.1) p3
  FROM dual;

SELECT POWER(-3, 2.1)
  FROM dual;


SELECT SQRT(2),
       SQRT(3)
  FROM dual;


--03. 문자형 함수

SELECT CONCAT('Romeo', 'Juliet'), CONCAT('로미오','줄리엣')
  FROM DUAL;

SELECT CONCAT('로미오', '줄리엣') CONCATS,
       '로미오' || '줄리엣' OPERATORS
  FROM DUAL;


SELECT INITCAP('abCDefGHi')
  FROM DUAL;

SELECT INITCAP('i am a boy')
  FROM DUAL;

SELECT INITCAP('i am a가boy')
  FROM DUAL;     

SELECT LOWER('abcdeFG'), UPPER('abcdeFG')
  FROM DUAL;     

SELECT LPAD('abc', 7)  "LPAD1", 
       LPAD('abc', 7, '#')  "LPAD2",
       LPAD('abc', 7, 'S')  "LPAD3"
  FROM DUAL;


SELECT RPAD('abc', 7)  "RPAD1", 
       RPAD('abc', 7, '#')  "RPAD2",
       RPAD('abc', 7, 'S')  "RPAD3"
  FROM DUAL;

SELECT RPAD('홍길', 7, '#') RPAD1
  FROM DUAL;


SELECT LTRIM(' ABCDEFG') LTRIM1,
       LTRIM(' ABCDEFG',' ') LTRIM2,
       LTRIM('ABCDEFG','AB') LTRIM3,
       LTRIM(' ABCDEFG','BC') LTRIM4
  FROM DUAL;

SELECT RTRIM('ABCDEFG ') RTRIM1,
       RTRIM('ABCDEFG ',' ') RTRIM2,
       RTRIM('ABCDEFG','FG') RTRIM3,
       RTRIM('ABCDEFG ','EF') RTRIM4
  FROM DUAL;

SELECT SUBSTR('You are not alone', 9, 3) substr1
  FROM DUAL;

SELECT SUBSTR('You are not alone', 5) substr1,
       SUBSTR('You are not alone', 0, 5) substr2
  FROM DUAL;

SELECT SUBSTRB('You are not alone', 9, 3) substrb1,
       SUBSTR('You are not alone', 9, 3) substr1,
       SUBSTR('너는 혼자가 아니야', 10, 2) substr2,
       SUBSTRB('너는 혼자가 아니야', 10, 2) substrb2,
       SUBSTRB('너는 혼자가 아니야', 9, 3) substrb3
  FROM DUAL;

SELECT REPLACE('You are not alone', 'You', 'We')
  FROM DUAL;

SELECT REPLACE('You are not alone', 'not') rep1,
       REPLACE('You are not alone', 'not', null) rep2
  FROM DUAL;

SELECT REPLACE('You are not alone', 'You', 'We') REP,
       TRANSLATE('You are not alone','You', 'We') TRAN
  FROM DUAL;


SELECT REPLACE('You are not alone', 'You', null) REP
       TRANSLATE('You are not aloneu','You', null) TRAN
  FROM DUAL;

SELECT TRIM( LEADING FROM ' ABCD ') LTRIM,
       LENGTH(TRIM( LEADING FROM ' ABCD ')) LTRIM_LENGTH,
       TRIM( TRAILING FROM ' ABCD ') RTRIM,
       LENGTH(TRIM( TRAILING FROM ' ABCD ')) RTRIM_LENGTH,       
       TRIM( BOTH FROM ' ABCD ') BOTH_TRIM1,
       LENGTH(TRIM( BOTH FROM ' ABCD ')) BOTH_LENGTH1,
       TRIM(' ABCD ') BOTH_TRIM2,
       LENGTH(TRIM(' ABCD ')) BOTH_LENGTH2
  FROM DUAL;

SELECT TRIM( LEADING 'A' FROM 'AABBCCDD') LT,
       TRIM( TRAILING 'D' FROM 'AABBCCDD') RT,
       TRIM( BOTH 'A' FROM 'AABBCCDD') BOTHT1,
       TRIM('A' FROM 'AABBCCDD') BOTHT2
  FROM DUAL;


--04. 숫자형 데이터를 반환하는 문자형 함수
SELECT ASCII('A') CHAR_A,
       ASCII('a') CHAR_a,
       ASCII('AB') CHAR_AB
  FROM DUAL;

SELECT INSTR('Every Sha-la-la-la Every wo-o-wo-o', 'la') INSTR1,
       INSTR('Every Sha-la-la-la Every wo-o-wo-o', 'la', 1) INSTR2,
       INSTR('Every Sha-la-la-la Every wo-o-wo-o', 'la', 1, 2) INSTR3,
       INSTR('Every Sha-la-la-la Every wo-o-wo-o', 'la', 12, 2) INSTR4
  FROM DUAL;

SELECT LENGTH('무궁화 꽃이 피었습니다') LEN1,
       LENGTHB('무궁화 꽃이 피었습니다') LEN2
  FROM DUAL;



--05. 날짜형 함수

SELECT CURRENT_DATE,
       SYSDATE
  FROM DUAL;

ALTER SESSION SET TIME_ZONE = '-2:0';

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT SYSDATE, CURRENT_DATE 
  FROM DUAL;

ALTER SESSION SET TIME_ZONE = '-2:0';

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';


SELECT SYSTIMESTAMP, 
       CURRENT_TIMESTAMP
  FROM DUAL;


SELECT CURRENT_TIMESTAMP,
       CURRENT_TIMESTAMP(1)
  FROM DUAL;

SELECT CURRENT_TIMESTAMP,
       LOCALTIMESTAMP
  FROM DUAL;

SELECT ADD_MONTHS(TO_DATE('2007-01-01'), 1) ONE_MONTH,
       ADD_MONTHS(TO_DATE('2007-01-01'), 2) TWO_MONTH,
       ADD_MONTHS(TO_DATE('2007-01-01'), 0) ZERO_MONTH,
       ADD_MONTHS(TO_DATE('2007-01-01'), -1) MINUS_MONTH,
       ADD_MONTHS(TO_DATE('2007-01-01'), 1.9) DEC_MONTH
  FROM DUAL;


SELECT MONTHS_BETWEEN ( TO_DATE('2005-10-10'), TO_DATE('2005-01-01')) right_seq,
       MONTHS_BETWEEN ( TO_DATE('2005-01-01'), TO_DATE('2005-10-10')) inverse_seq
  FROM DUAL;     


SELECT NEXT_DAY(TO_DATE('2007-01-01'), '월요일') MON,
       NEXT_DAY(TO_DATE('2007-01-01'), '화요일') TUE,
       NEXT_DAY(TO_DATE('2007-01-01'), '수') WED
  FROM DUAL;

SELECT NEXT_DAY(TO_DATE('2007-01-01'), 'MONDAY') MON
  FROM DUAL;


SELECT LAST_DAY(TO_DATE('2007-01-01')) LAST
  FROM DUAL; 


SELECT ROUND(TO_DATE('2007-08-01'), 'CC') CENTURY,
       ROUND(TO_DATE('2007-08-01'), 'YYYY') YEAR1,
       ROUND(TO_DATE('2007-08-01'), 'YEAR') YEAR2,
       ROUND(TO_DATE('2007-08-01'), 'IYYY') ISO_YEAR,
       ROUND(TO_DATE('2007-08-01'), 'Q') QUARTER,
       ROUND(TO_DATE('2007-08-01'), 'MONTH') MON,
       ROUND(TO_DATE('2007-08-01'), 'DD') DD,
       ROUND(TO_DATE('2007-08-01'), 'DAY') DAYS
  FROM DUAL;


SELECT TRUNC(TO_DATE('2050-08-01'), 'CC') CENTURY,
       TRUNC(TO_DATE('2007-08-01'), 'YYYY') YEARS,
       TRUNC(TO_DATE('2007-08-01'), 'IYYY') ISO_YEAR,
       TRUNC(TO_DATE('2007-08-17'), 'Q') QUARTER,
       TRUNC(TO_DATE('2007-08-01'), 'MONTH') MON,
       TRUNC(TO_DATE('2007-08-01'), 'DD') DD,
       TRUNC(TO_DATE('2007-08-01'), 'DAY') DAYS
  FROM DUAL;


SELECT SYSDATE,
       ROUND(SYSDATE),
       TRUNC(SYSDATE)
  FROM DUAL;


SELECT EXTRACT(YEAR FROM SYSDATE) YEARS,
       EXTRACT(MONTH FROM SYSDATE) MONTHS,
       EXTRACT(DAY FROM SYSDATE) DAYS,
       EXTRACT(HOUR FROM SYSTIMESTAMP) HOURS,
       EXTRACT(MINUTE FROM SYSTIMESTAMP) MINUTES,
       EXTRACT(SECOND FROM SYSTIMESTAMP) SECONDS
  FROM DUAL;


SELECT DBTIMEZONE
  FROM DUAL;


SELECT SESSIONTIMEZONE
 FROM DUAL;



--06. Null 관련 함수

SELECT EMPLOYEE_ID,
       FIRST_NAME,
       SALARY,
       SALARY * COMMISSION_PCT
  FROM EMPLOYEES
 WHERE SALARY * COMMISSION_PCT < 1000;


SELECT EMPLOYEE_ID,
       FIRST_NAME,
       SALARY,
       SALARY * COMMISSION_PCT
  FROM EMPLOYEES
 WHERE SALARY * NVL(COMMISSION_PCT,0) < 1000;


 SELECT EMPLOYEE_ID, FIRST_NAME, SALARY,
        SALARY + SALARY * COMMISSION_PCT TOT_SALARY1,
        NVL2(COMMISSION_PCT, SALARY + (SALARY*COMMISSION_PCT), SALARY) TOT_SALARY2
  FROM EMPLOYEES;
 
 SELECT e.last_name, 
        NULLIF(e.job_id, j.job_id) old_job_id
   FROM employees e, 
        job_history j
  WHERE e.employee_id = j.employee_id
  ORDER BY last_name;


SELECT COALESCE('A', 'B', NULL) first,
       COALESCE(NULL, 'B', 'C', NULL) second,
       COALESCE(NULL, NULL, 'C', NULL) third
  FROM DUAL;

SELECT EMPLOYEE_ID,
       FIRST_NAME,
       SALARY,
       SALARY * COMMISSION_PCT
  FROM EMPLOYEES
 WHERE SALARY * NVL(COMMISSION_PCT,0) < 1000;


 SELECT EMPLOYEE_ID,
        FIRST_NAME,
        SALARY,
        SALARY * COMMISSION_PCT
   FROM EMPLOYEES
  WHERE LNNVL(SALARY * COMMISSION_PCT >= 1000); 




--07. 변환함수

SELECT TO_CHAR('0101010')
  FROM DUAL;

CREATE TABLE DATE_TO_CHAR (
    col_date DATE,
    col_time TIMESTAMP,
    col_timez TIMESTAMP WITH TIME ZONE );


ALTER SESSION SET TIME_ZONE = '-9:00';

INSERT INTO DATE_TO_CHAR VALUES (
 TO_DATE('1945-08-01'), 
TIMESTAMP'1945-08-01 10:00:00', 
TIMESTAMP'1945-08-01 10:00:00');


SELECT TO_CHAR(col_date, 'YYYY-MM-DD') date_fmt1,
       TO_CHAR(col_date, 'YYYY-MON-DD HH24:MI:SS') date_fmt2,
       TO_CHAR(col_time, 'YYYY-MM-DD HH24:MI:SSxFF') tsp_fmt1,
       TO_CHAR(col_timez, 'YYYY-MM-DD HH24:MI:SSxFF TZH:TZM') tsp_fmt2
  FROM date_to_char;


SELECT TO_DATE('2007-01-01 15:12:12', 'YYYY-MM-DD HH24:MI:SS') dates1,
       TO_DATE('2007-01-01 05:12:12', 'YYYY-MM-DD HH:MI:SS') dates2
  FROM DUAL;

SELECT TO_TIMESTAMP('2007-01-01 15:12:12', 'YYYY-MON-DD HH24:MI:SS.FF') 
  FROM DUAL;


SELECT TO_TIMESTAMP_TZ('2007-01-01 11:00:00 -8:00','YYYY-MM-DD HH:MI:SS TZH:TZM') 
  FROM DUAL;


--09. DECODE 와 CASE

SELECT employee_id, 
       first_name || ' ' || last_name names,
       DECODE(ROUND((SYSDATE - hire_date)/365), 5, '5년 근속', 10, '10년 근속', ROUND((SYSDATE - hire_date)/365)) work_years
  FROM employees
 ORDER BY employee_id;
 
 SELECT DECODE( employee_id, hire_date, 1, 0)
   FROM employees;

SELECT DECODE( hire_date, employee_id,  1, 0)
  FROM employees;

SELECT employee_id, first_name, last_name
  FROM employees
 WHERE employee_id = :emp;

SELECT employee_id, first_name, last_name
  FROM employees
 WHERE employee_id = :emp
   AND first_name = :names;

SELECT employee_id, first_name, last_name
  FROM employees
 WHERE employee_id = DECODE(:emp, NULL, employee_id, :emp)
   AND first_name = DECODE(:names, NULL, first_name, :names);

SELECT employee_id, first_name, last_name
  FROM employees
 WHERE employee_id = employee_id
   AND first_name =  first_name;


UPDATE employees
   SET manager_id = DECODE(manager_id, null, employee_id, manager_id);

SELECT *
  FROM employees
 WHERE manager_id IS NULL;

-- CASE 
SELECT user, table_name
  FROM USER_TABLES;


SELECT customer_id, cust_first_name, cust_last_name, 
       date_of_birth, marital_status, gender
  FROM customers;


SELECT customer_id, cust_first_name,
       DECODE(gender, 'M', '남성', 'F', '여성') decode_gender,
       CASE gender WHEN 'M' THEN '남성'
                   WHEN 'F' THEN '여성'
                   ELSE '' END case_gender
  FROM customers;


SELECT customer_id, cust_first_name,
       CASE WHEN ROUND((sysdate - date_of_birth)/365) >= 10 AND ROUND((sysdate - date_of_birth)/365) <= 19 THEN '10대'
            WHEN ROUND((sysdate - date_of_birth)/365) >= 20 AND ROUND((sysdate - date_of_birth)/365) <= 29 THEN '20대'
            WHEN ROUND((sysdate - date_of_birth)/365) >= 30 AND ROUND((sysdate - date_of_birth)/365) <= 39 THEN '30대'
            WHEN ROUND((sysdate - date_of_birth)/365) >= 40 AND ROUND((sysdate - date_of_birth)/365) <= 49 THEN '40대'
            WHEN ROUND((sysdate - date_of_birth)/365) >= 50 AND ROUND((sysdate - date_of_birth)/365) <= 59 THEN '50대'
            WHEN ROUND((sysdate - date_of_birth)/365) >= 60 AND ROUND((sysdate - date_of_birth)/365) <= 69 THEN '60대'
            WHEN ROUND((sysdate - date_of_birth)/365) >= 70 AND ROUND((sysdate - date_of_birth)/365) <= 79 THEN '70대'
            ELSE '기타' 
       END case_years
  FROM customers;  


SELECT customer_id, cust_first_name,
       CASE WHEN ROUND((sysdate - date_of_birth)/365) BETWEEN 10 AND 19 THEN '10대'
            WHEN ROUND((sysdate - date_of_birth)/365) BETWEEN 20 AND 29 THEN '20대'
            WHEN ROUND((sysdate - date_of_birth)/365) BETWEEN 30 AND 39 THEN '30대'
            WHEN ROUND((sysdate - date_of_birth)/365) BETWEEN 40 AND 49 THEN '40대'
            WHEN ROUND((sysdate - date_of_birth)/365) BETWEEN 50 AND 59 THEN '50대'
            WHEN ROUND((sysdate - date_of_birth)/365) BETWEEN 60 AND 69 THEN '60대'
            WHEN ROUND((sysdate - date_of_birth)/365) BETWEEN 70 AND 79 THEN '70대'
            ELSE '기타' 
       END case_years
  FROM customers;  

SELECT COUNT(*)
  FROM employees a, jobs b
 WHERE a.job_id = b.job_id
   AND a.salary BETWEEN b.min_salary 
                    AND b.max_salary;


SELECT COUNT(*)
  FROM employees a, jobs b
 WHERE a.job_id = b.job_id
   AND ( CASE a.commission_pct WHEN NULL THEN a.salary
                               ELSE a.salary + ( a.salary * a.commission_pct ) 
         END ) BETWEEN b.min_salary 
                   AND b.max_salary;
