-- ������ ����
 CREATE TABLE BOM (
            ITEM_ID     INTEGER NOT NULL,
            PARENT_ID   INTEGER,
            ITEM_NAME   VARCHAR2(20)  NOT NULL,
            ITEM_QTY    INTEGER, 
            PRIMARY KEY (ITEM_ID));


INSERT INTO BOM VALUES ( 1001, NULL, '��ǻ��', 1);
INSERT INTO BOM VALUES ( 1002, 1001, '��ü', 1);
INSERT INTO BOM VALUES ( 1003, 1001, '�����', 1);
INSERT INTO BOM VALUES ( 1004, 1001, '������', 1);

INSERT INTO BOM VALUES ( 1005, 1002, 'Mother Board', 1);
INSERT INTO BOM VALUES ( 1006, 1002, '��ī��', 1);
INSERT INTO BOM VALUES ( 1007, 1002, 'Power Supply', 1);
INSERT INTO BOM VALUES ( 1008, 1005, 'RAM', 1);
INSERT INTO BOM VALUES ( 1009, 1005, 'CPU', 1);
INSERT INTO BOM VALUES ( 1010, 1005, '�׷�����ġ', 1);
INSERT INTO BOM VALUES ( 1011, 1005, '��Ÿ��ġ', 1);


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


-- ������ ������ ����
SELECT LEVEL, 
        LPAD(' ', 4*(LEVEL -1)) || first_name || ' ' || last_name "����"
  FROM employees
 START WITH MANAGER_ID IS NULL
 CONNECT BY manager_id = PRIOR employee_id;


SELECT  b.job_title "����",
        LPAD(' ', 4*(LEVEL -1)) || a.first_name || ' ' || a.last_name "����"        
  FROM employees a, jobs b
 WHERE a.job_id = b.job_id
 START WITH a.manager_id IS NULL
 CONNECT BY a.manager_id = PRIOR a.employee_id;


SELECT b.job_title "����",
       LPAD(' ', 4*(LEVEL -1)) || a.first_name || ' ' || a.last_name "����",
       c.department_name "�μ�",
       d.city || ', ' || d.state_province || ', ' || e.country_name "�μ���ġ"
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


SELECT b.job_title "����",
       LPAD(' ', 4*(LEVEL -1)) || a.first_name || ' ' || a.last_name "����",
       c.department_name "�μ�", a.salary
  FROM employees a, jobs b, departments c
 WHERE a.job_id = b.job_id
   AND a.salary > 10000
   AND a.department_id = c.department_id
 START WITH a.manager_id IS NULL
 CONNECT BY a.manager_id = PRIOR a.employee_id;


SELECT LPAD(' ', 4*(LEVEL -1)) || a.first_name || ' ' || a.last_name "����",
       c.department_name "�μ�", 
       a.salary "�޿�"
  FROM employees a, departments c
 WHERE a.employee_id = c.manager_id
   AND a.salary > 10000
 START WITH a.manager_id IS NULL
 CONNECT BY a.manager_id = PRIOR a.employee_id;

-- ������ ������ Ȯ��
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


-- ������ ������ ����
CREATE TABLE test_boards (
     id          NUMBER(5)     NOT NULL,    -- ID         
	   p_id        NUMBER(5)     NULL,        -- ���� ID ��  
	   subject     VARCHAR2(30)  NOT NULL,    -- �Խ��� ���� 
	   content     VARCHAR2(100) NULL,        -- ����        
	   create_date DATE default sysdate);     -- ��������    


INSERT INTO test_boards VALUES (1, NULL, '����Ŭ å ��õ��..', '����Ŭ�� �����Ϸ��µ�, å �� ��õ�� �ּ���', SYSDATE);

INSERT INTO test_boards VALUES (2, NULL, '������..', '����Ŭ �ʺ��Դϴ�..� å�� ���� �������?', SYSDATE);

INSERT INTO test_boards VALUES (3, 1, '�� å�� �����...', '�Ѻ��̵��� ���� ���ڱ� �ø�� �����ϴ�..', SYSDATE);

INSERT INTO test_boards VALUES (4, 3, '����..', '�½��ϴ�..�°��...���� �������ϴ�...', SYSDATE);

INSERT INTO test_boards VALUES (5, 1, '�ʺ��ڶ�� �� å��...', 'HEAD FIRST SQL .. ���� �ѱ����� ������ ������ ������..�� å ������ ������ ���մϴ�. ', SYSDATE);

INSERT INTO test_boards VALUES (6, 2, '�̰� ������', '�׳� �޴��� ������..���� ', SYSDATE);


SELECT rownum, 
       LPAD(' ', 2*(LEVEL-1)) || subject
  FROM test_boards
 START WITH p_id IS NULL
 CONNECT BY PRIOR id = p_id;


SELECT DECODE(CONNECT_BY_ISLEAF, 1, '  ' || CONTENT,
                              '[������] ' || CONTENT || CHR(13)) CONTESTS
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
     

-- �޷� �����
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


SELECT DECODE( TO_CHAR(dates,'D'), 1, TO_CHAR(dates, 'DD')) ��,
       DECODE( TO_CHAR(dates,'D'), 2, TO_CHAR(dates, 'DD')) ��,
       DECODE( TO_CHAR(dates,'D'), 3, TO_CHAR(dates, 'DD')) ȭ,
       DECODE( TO_CHAR(dates,'D'), 4, TO_CHAR(dates, 'DD')) ��,
       DECODE( TO_CHAR(dates,'D'), 5, TO_CHAR(dates, 'DD')) ��,
       DECODE( TO_CHAR(dates,'D'), 6, TO_CHAR(dates, 'DD')) ��,
       DECODE( TO_CHAR(dates,'D'), 7, TO_CHAR(dates, 'DD')) ��
 FROM (
        SELECT (make_dates + LEVEL - 1) dates
          FROM ( SELECT TO_DATE('200701', 'YYYYMM') make_dates
                   FROM DUAL )
       CONNECT BY LEVEL <= 31
     );

SELECT TO_CHAR(DATES, 'W'),
       MIN(DECODE( TO_CHAR(dates,'D'), 1, TO_CHAR(dates, 'DD'))) ��,
       MIN(DECODE( TO_CHAR(dates,'D'), 2, TO_CHAR(dates, 'DD'))) ��,
	     MIN(DECODE( TO_CHAR(dates,'D'), 3, TO_CHAR(dates, 'DD'))) ȭ,
	     MIN(DECODE( TO_CHAR(dates,'D'), 4, TO_CHAR(dates, 'DD'))) ��,
	     MIN(DECODE( TO_CHAR(dates,'D'), 5, TO_CHAR(dates, 'DD'))) ��,
	     MIN(DECODE( TO_CHAR(dates,'D'), 6, TO_CHAR(dates, 'DD'))) ��,
	     MIN(DECODE( TO_CHAR(dates,'D'), 7, TO_CHAR(dates, 'DD'))) �� 
 FROM (
           SELECT (make_dates + LEVEL - 1) dates
             FROM ( SELECT TO_DATE('200701', 'YYYYMM') make_dates
                      FROM DUAL )
          CONNECT BY LEVEL <= 31
      )
GROUP BY TO_CHAR(DATES, 'W');


SELECT MIN(DECODE( TO_CHAR(dates,'D'), 1, TO_CHAR(dates, 'DD'))) ��,
       MIN(DECODE( TO_CHAR(dates,'D'), 2, TO_CHAR(dates, 'DD'))) ��,
	     MIN(DECODE( TO_CHAR(dates,'D'), 3, TO_CHAR(dates, 'DD'))) ȭ,
	     MIN(DECODE( TO_CHAR(dates,'D'), 4, TO_CHAR(dates, 'DD'))) ��,
	     MIN(DECODE( TO_CHAR(dates,'D'), 5, TO_CHAR(dates, 'DD'))) ��,
	     MIN(DECODE( TO_CHAR(dates,'D'), 6, TO_CHAR(dates, 'DD'))) ��,
	     MIN(DECODE( TO_CHAR(dates,'D'), 7, TO_CHAR(dates, 'DD'))) �� 
 FROM (
        SELECT (make_dates + LEVEL - 1) dates
          FROM ( SELECT TO_DATE('200701', 'YYYYMM') make_dates
                   FROM DUAL )
        CONNECT BY (make_dates + LEVEL - 1)  <= LAST_DAY(make_dates)
      )
GROUP BY DECODE(TO_CHAR(DATES, 'D'), 1, TO_CHAR(DATES, 'W') + 1, TO_CHAR(DATES, 'W'))
ORDER BY DECODE(TO_CHAR(DATES, 'D'), 1, TO_CHAR(DATES, 'W') + 1, TO_CHAR(DATES, 'W'));
