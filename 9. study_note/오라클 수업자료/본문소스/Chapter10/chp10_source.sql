-- 계층형 쿼리
 CREATE TABLE BOM (
            ITEM_ID     INTEGER NOT NULL,
            PARENT_ID   INTEGER,
            ITEM_NAME   VARCHAR2(20)  NOT NULL,
            ITEM_QTY    INTEGER, 
            PRIMARY KEY (ITEM_ID));


INSERT INTO BOM VALUES ( 1001, NULL, '컴퓨터', 1);
INSERT INTO BOM VALUES ( 1002, 1001, '본체', 1);
INSERT INTO BOM VALUES ( 1003, 1001, '모니터', 1);
INSERT INTO BOM VALUES ( 1004, 1001, '프린터', 1);

INSERT INTO BOM VALUES ( 1005, 1002, 'Mother Board', 1);
INSERT INTO BOM VALUES ( 1006, 1002, '랜카드', 1);
INSERT INTO BOM VALUES ( 1007, 1002, 'Power Supply', 1);
INSERT INTO BOM VALUES ( 1008, 1005, 'RAM', 1);
INSERT INTO BOM VALUES ( 1009, 1005, 'CPU', 1);
INSERT INTO BOM VALUES ( 1010, 1005, '그래픽장치', 1);
INSERT INTO BOM VALUES ( 1011, 1005, '기타장치', 1);


SELECT bom1.item_name,
       bom1.item_id,
       bom2.item_name parent_item
  FROM bom bom1, bom bom2
 WHERE bom1.parent_id = bom2.item_id(+)
 ORDER BY bom1.item_id;


SELECT LPAD(' ', 2*(LEVEL-1)) || item_name item_names
  FROM bom
  START WITH parent_id IS NULL
CONNECT BY PRIOR item_id = parent_id;


SELECT LPAD(' ', 4*(LEVEL-1)) || item_name item_names
  FROM bom
  START WITH parent_id IS NULL
CONNECT BY PRIOR item_id = parent_id
ORDER BY item_id;


-- 계층형 쿼리와 조인
SELECT LEVEL, 
        LPAD(' ', 4*(LEVEL -1)) || first_name || ' ' || last_name "성명"
  FROM employees
 START WITH MANAGER_ID IS NULL
 CONNECT BY manager_id = PRIOR employee_id;


SELECT  b.job_title "직위",
        LPAD(' ', 4*(LEVEL -1)) || a.first_name || ' ' || a.last_name "성명"        
  FROM employees a, jobs b
 WHERE a.job_id = b.job_id
 START WITH a.manager_id IS NULL
 CONNECT BY a.manager_id = PRIOR a.employee_id;


SELECT b.job_title "직위",
       LPAD(' ', 4*(LEVEL -1)) || a.first_name || ' ' || a.last_name "성명",
       c.department_name "부서",
       d.city || ', ' || d.state_province || ', ' || e.country_name "부서위치"
  FROM employees a,
       jobs b, 
       departments c, 
       locations d, 
       countries e
 WHERE a.job_id = b.job_id
   AND a.department_id = c.department_id
   AND c.location_id = d.location_id
   AND d.country_id = e.country_id
 START WITH a.manager_id IS NULL
 CONNECT BY a.manager_id = PRIOR a.employee_id;


SELECT b.job_title "직위",
       LPAD(' ', 4*(LEVEL -1)) || a.first_name || ' ' || a.last_name "성명",
       c.department_name "부서", a.salary
  FROM employees a, jobs b, departments c
 WHERE a.job_id = b.job_id
   AND a.salary > 10000
   AND a.department_id = c.department_id
 START WITH a.manager_id IS NULL
 CONNECT BY a.manager_id = PRIOR a.employee_id;


SELECT LPAD(' ', 4*(LEVEL -1)) || a.first_name || ' ' || a.last_name "성명",
       c.department_name "부서", 
       a.salary "급여"
  FROM employees a, departments c
 WHERE a.employee_id = c.manager_id
   AND a.salary > 10000
 START WITH a.manager_id IS NULL
 CONNECT BY a.manager_id = PRIOR a.employee_id;

-- 계층형 쿼리의 확장
SELECT LPAD(' ', 2*(LEVEL-1)) || item_name item_names
  FROM bom
  WHERE LEVEL >= 2
  START WITH parent_id IS NULL
CONNECT BY PRIOR item_id = parent_id;


SELECT LPAD(' ', 2*(LEVEL-1)) || item_name item_names,
       CONNECT_BY_ROOT item_id root_id,
       CONNECT_BY_ROOT item_name root_name
  FROM bom
 WHERE LEVEL >= 2
 START WITH parent_id IS NULL
 CONNECT BY PRIOR item_id = parent_id;


SELECT LPAD(' ', 2*(LEVEL-1)) || item_name item_names,
       CONNECT_BY_ROOT item_id root_id,
       CONNECT_BY_ROOT item_name root_name
  FROM bom
 START WITH item_id = '1002'
 CONNECT BY PRIOR item_id = parent_id;


SELECT item_id, level,
       LPAD(' ', 2*(LEVEL-1)) || item_name item_names
  FROM bom
  START WITH item_id = 1005
CONNECT BY PRIOR item_id = parent_id;


UPDATE BOM
   SET parent_id = 1010
 WHERE item_id = 1005;

SELECT item_id, level,
       LPAD(' ', 2*(LEVEL-1)) || item_name item_names
  FROM bom
  START WITH item_id = 1005
CONNECT BY PRIOR item_id = parent_id;


SELECT item_id, level,
       LPAD(' ', 2*(LEVEL-1)) || item_name item_names
  FROM bom
  START WITH item_id = 1005
CONNECT BY NOCYCLE PRIOR item_id = parent_id;


SELECT item_id, level,
       LPAD(' ', 2*(LEVEL-1)) || item_name item_names,
       CONNECT_BY_ISCYCLE cycles
  FROM bom
  START WITH item_id = 1005
CONNECT BY NOCYCLE PRIOR item_id = parent_id;


SELECT item_id, level,
       CONNECT_BY_ISLEAF leafs,
       LPAD(' ', 2*(LEVEL-1)) || item_name item_names
  FROM bom
  START WITH parent_id IS NULL
CONNECT BY  PRIOR item_id = parent_id;


SELECT item_id, level,
       SYS_CONNECT_BY_PATH (item_id, '/') id_path,
       SYS_CONNECT_BY_PATH (item_name, '/') name_path
  FROM bom
 START WITH parent_id IS NULL
 CONNECT BY  PRIOR item_id = parent_id;


-- 계층형 쿼리의 응용
CREATE TABLE test_boards (
     id          NUMBER(5)     NOT NULL,    -- ID         
	   p_id        NUMBER(5)     NULL,        -- 상위 ID 값  
	   subject     VARCHAR2(30)  NOT NULL,    -- 게시판 제목 
	   content     VARCHAR2(100) NULL,        -- 내용        
	   create_date DATE default sysdate);     -- 생성일자    


INSERT INTO test_boards VALUES (1, NULL, '오라클 책 추천좀..', '오라클을 공부하려는데, 책 좀 추천해 주세요', SYSDATE);

INSERT INTO test_boards VALUES (2, NULL, '저도요..', '오라클 초보입니다..어떤 책을 보면 좋을까요?', SYSDATE);

INSERT INTO test_boards VALUES (3, 1, '이 책이 어떨련지...', '한빛미디어에서 나온 뇌자극 시리즈가 좋습니다..', SYSDATE);

INSERT INTO test_boards VALUES (4, 3, '동감..', '맞습니다..맞고요...정말 괜찮습니다...', SYSDATE);

INSERT INTO test_boards VALUES (5, 1, '초보자라면 이 책도...', 'HEAD FIRST SQL .. 아직 한글판이 나오지 않은것 같은데..이 책 나오면 괜찮을 듯합니다. ', SYSDATE);

INSERT INTO test_boards VALUES (6, 2, '이거 보세요', '그냥 메뉴얼 보세요..ㅋㅋ ', SYSDATE);


SELECT rownum, 
       LPAD(' ', 2*(LEVEL-1)) || subject
  FROM test_boards
 START WITH p_id IS NULL
 CONNECT BY PRIOR id = p_id;


SELECT DECODE(CONNECT_BY_ISLEAF, 1, '  ' || CONTENT,
                              '[상위글] ' || CONTENT || CHR(13)) CONTESTS
  FROM test_boards
 WHERE CONNECT_BY_ROOT ID = 1   
 START WITH P_ID is null
 CONNECT BY PRIOR id = p_id
     AND id = 3
 ORDER BY LEVEL;


SELECT  id, p_id, subject
  FROM test_boards
 START WITH p_id IS NULL
 CONNECT BY PRIOR id = p_id
     AND id = 3;
     
SELECT id, p_id, subject
  FROM test_boards
 WHERE CONNECT_BY_ROOT id = 1
 START WITH p_id IS NULL
 CONNECT BY PRIOR id = p_id
     AND id = 3;
     

-- 달력 만들기
SELECT TO_DATE('200701', 'YYYYMM')
  FROM DUAL;


SELECT make_dates, LEVEL
   FROM ( SELECT TO_DATE('200701', 'YYYYMM') make_dates
            FROM DUAL )
CONNECT BY LEVEL <= 31;


SELECT (make_dates + LEVEL - 1) dates
   FROM ( SELECT TO_DATE('200701', 'YYYYMM') make_dates
            FROM DUAL )
CONNECT BY LEVEL <= 31;


SELECT DECODE( TO_CHAR(dates,'D'), 1, TO_CHAR(dates, 'DD')) 일,
       DECODE( TO_CHAR(dates,'D'), 2, TO_CHAR(dates, 'DD')) 월,
       DECODE( TO_CHAR(dates,'D'), 3, TO_CHAR(dates, 'DD')) 화,
       DECODE( TO_CHAR(dates,'D'), 4, TO_CHAR(dates, 'DD')) 수,
       DECODE( TO_CHAR(dates,'D'), 5, TO_CHAR(dates, 'DD')) 목,
       DECODE( TO_CHAR(dates,'D'), 6, TO_CHAR(dates, 'DD')) 금,
       DECODE( TO_CHAR(dates,'D'), 7, TO_CHAR(dates, 'DD')) 토
 FROM (
        SELECT (make_dates + LEVEL - 1) dates
          FROM ( SELECT TO_DATE('200701', 'YYYYMM') make_dates
                   FROM DUAL )
       CONNECT BY LEVEL <= 31
     );

SELECT TO_CHAR(DATES, 'W'),
       MIN(DECODE( TO_CHAR(dates,'D'), 1, TO_CHAR(dates, 'DD'))) 일,
       MIN(DECODE( TO_CHAR(dates,'D'), 2, TO_CHAR(dates, 'DD'))) 월,
	     MIN(DECODE( TO_CHAR(dates,'D'), 3, TO_CHAR(dates, 'DD'))) 화,
	     MIN(DECODE( TO_CHAR(dates,'D'), 4, TO_CHAR(dates, 'DD'))) 수,
	     MIN(DECODE( TO_CHAR(dates,'D'), 5, TO_CHAR(dates, 'DD'))) 목,
	     MIN(DECODE( TO_CHAR(dates,'D'), 6, TO_CHAR(dates, 'DD'))) 금,
	     MIN(DECODE( TO_CHAR(dates,'D'), 7, TO_CHAR(dates, 'DD'))) 토 
 FROM (
           SELECT (make_dates + LEVEL - 1) dates
             FROM ( SELECT TO_DATE('200701', 'YYYYMM') make_dates
                      FROM DUAL )
          CONNECT BY LEVEL <= 31
      )
GROUP BY TO_CHAR(DATES, 'W');


SELECT MIN(DECODE( TO_CHAR(dates,'D'), 1, TO_CHAR(dates, 'DD'))) 일,
       MIN(DECODE( TO_CHAR(dates,'D'), 2, TO_CHAR(dates, 'DD'))) 월,
	     MIN(DECODE( TO_CHAR(dates,'D'), 3, TO_CHAR(dates, 'DD'))) 화,
	     MIN(DECODE( TO_CHAR(dates,'D'), 4, TO_CHAR(dates, 'DD'))) 수,
	     MIN(DECODE( TO_CHAR(dates,'D'), 5, TO_CHAR(dates, 'DD'))) 목,
	     MIN(DECODE( TO_CHAR(dates,'D'), 6, TO_CHAR(dates, 'DD'))) 금,
	     MIN(DECODE( TO_CHAR(dates,'D'), 7, TO_CHAR(dates, 'DD'))) 토 
 FROM (
        SELECT (make_dates + LEVEL - 1) dates
          FROM ( SELECT TO_DATE('200701', 'YYYYMM') make_dates
                   FROM DUAL )
        CONNECT BY (make_dates + LEVEL - 1)  <= LAST_DAY(make_dates)
      )
GROUP BY DECODE(TO_CHAR(DATES, 'D'), 1, TO_CHAR(DATES, 'W') + 1, TO_CHAR(DATES, 'W'))
ORDER BY DECODE(TO_CHAR(DATES, 'D'), 1, TO_CHAR(DATES, 'W') + 1, TO_CHAR(DATES, 'W'));
