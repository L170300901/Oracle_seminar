
-- 오라클에서 XML 다루기
SELECT comp_name 
  FROM dba_registry 
 WHERE comp_name LIKE '%XML%';


CREATE TABLE xml_clob (
        id        INTEGER,
        xmlclob  XMLType );


INSERT INTO xml_clob VALUES ( 1, XMLType('<?xml version="1.0" encoding="euc-kr" ?>
<book>
  <name>뇌를 자극하는 오라클SQL 프로그래밍</name>
  <authors>홍형경</authors>
  <publisher>한빛 미디어</publisher>    
  <year>2007</year>
</book>'));


SELECT *
  FROM xml_clob;

CREATE OR REPLACE DIRECTORY XML_TEST AS 'C:\XML_TEST';


CREATE OR REPLACE PROCEDURE XML_LOAD IS
    dest_clob   CLOB := NULL;
    src_clob    BFILE  := BFILENAME('XML_TEST', 'rss_network.xml');
    dst_offset  number := 1 ;
    src_offset  number := 1 ;
    lang_ctx    number := DBMS_LOB.DEFAULT_LANG_CTX;
    warning     number;

BEGIN
    
    -- 임시로 CLOB 데이터와 인덱스를 생성한다.
    DBMS_LOB.createTemporary(dest_clob, true, DBMS_LOB.SESSION); 
    
    -- 입력할 내용이 파일이므로, 해당 파일을 읽기전용으로 연다.
    DBMS_LOB.OPEN(src_clob, DBMS_LOB.LOB_READONLY);

    -- 오픈된 파일을 xml_file 컬럼에 저장한다.
    DBMS_LOB.LoadCLOBFromFile(
                dest_clob,
                src_clob,
                DBMS_LOB.GETLENGTH(src_clob),
                dst_offset,
                src_offset,
                nls_charset_id('KO16MSWIN949'), -- 캐릭터셋을 한국어로 명시.      
                lang_ctx,
                warning   );

    -- CLOB로 변환된 dest_clob를 입력한다. 
    INSERT INTO xml_clob (id, xmlclob) 
        VALUES(2, XMLType(dest_clob));
        
    -- 파일을 닫는다. 
    DBMS_LOB.CLOSE(src_clob);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('XML File save is succeed!');

EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;


EXECUTE XML_LOAD;

SELECT *
  FROM xml_clob
 WHERE id = 2;



CREATE TABLE xml_data (
        id        INTEGER,
        xmldata  XMLType );


INSERT INTO xml_data 
VALUES ( 1, XMLType( BFILENAME('XML_TEST','rss_network.xml')) );                      


INSERT INTO xml_data 
VALUES ( 1, XMLType( BFILENAME('XML_TEST','rss_network.xml'),
            NLS_CHARSET_ID('KO16MSWIN949')) );       
            
SELECT *
  FROM xml_data;
                           

CREATE TABLE xmltable OF XMLType;

DESC xmltable;

INSERT INTO xmltable 
VALUES ( XMLType( BFILENAME('XML_TEST','rss_network.xml'),
          NLS_CHARSET_ID('KO16MSWIN949')) );                      


SELECT *
  FROM xmltable;

-- XML 데이터의 조회
SELECT OBJECT_VALUE
  FROM xmltable;


SELECT OBJECT_VALUE
  FROM xml_data;


SELECT existsNode(XMLDATA, '/rss/channel/title="한빛미디어(주) | 한빛 네트워크"') exist
  FROM xml_data;


SELECT extract(XMLDATA, '/rss/channel/title') ext1
  FROM xml_data;


SELECT extract(XMLDATA, '/rss/channel/item/title') ext1
  FROM xml_data;


SELECT extract(XMLDATA, '/rss/channel/item[1]') ext1
  FROM xml_data;


SELECT extract(XMLDATA, '/rss/channel/item[1]/title')ext1,
       extractValue(XMLDATA, '/rss/channel/item[1]/title') ext2
  FROM xml_data;


-- XML 데이터의 갱신
UPDATE xml_clob
   SET xmlclob = XMLTYPE( BFILENAME('XML_TEST','PurchaseOrder.xml'),
                          NLS_CHARSET_ID('KO16MSWIN949') )
 WHERE id = 2;


SELECT *
  FROM xml_clob
 WHERE id = 2;


UPDATE xml_data
   SET XMLDATA = updateXML( XMLDATA, 
                     '/rss/channel/item[1]/title/text()', '[프로그래밍] JavaFX 소개');


SELECT extractValue(XMLDATA, '/rss/channel/item[1]/title') ext
  FROM xml_data;


UPDATE xml_data
   SET XMLDATA = updateXML( XMLDATA, 
                      '/rss/channel/item[100]/title/text()', '[프로그래밍] JavaFX 소개 ');


SELECT extractValue(XMLDATA, '/rss/channel/item[100]/title') ext
  FROM xml_data;


UPDATE xml_data
   SET XMLDATA = updateXML( XMLDATA, 
                      '/rss/channel/item[100]/title/text()', '[프로그래밍] JavaFX 소개')
 WHERE existsNode(XMLDATA,'/rss/channel/item[100]/title') = 1;



UPDATE xml_data
   SET XMLDATA = updateXML( XMLDATA, 
                      '/rss/channel/item[1]/title/text()', NULL)
 WHERE existsNode(XMLDATA,'/rss/channel/item[1]/title') = 1;


SELECT NVL(extractValue(XMLDATA, '/rss/channel/item[1]/title'), 'NULL') ext1,
       extract(XMLDATA, '/rss/channel/item[1]') ext2
  FROM xml_data;


UPDATE xml_data
   SET XMLDATA = updateXML( XMLDATA, 
                      '/rss/channel/item[1]', NULL)
 WHERE existsNode(XMLDATA,'/rss/channel/item[1]') = 1;


SELECT xmldata
  FROM xml_data;


--XML 문서의 생성

SELECT XMLElement("empid", employee_id) element1
  FROM employees;


SELECT XMLElement("employees", 
                   XMLElement("employee_id", employee_id),
                   XMLElement("first_name", first_name),
                   XMLElement("last_name", last_name),
                   XMLElement("email", email),
                   XMLElement("phone_number", phone_number),
                   XMLElement("hire_date", hire_date),
                   XMLElement("job_id", job_id),      
                   XMLElement("salary", salary),
                   XMLElement("commission_pct", commission_pct),  
                   XMLElement("manager_id", manager_id),
                   XMLElement("department_id", department_id)) emp
 FROM employees
WHERE employee_id = 210;


SELECT XMLElement("emp", 
                  XMLAttributes(employee_id as "id",
                                last_name || ' ' || first_name as "names")) emp
  FROM employees
 WHERE employee_id > 200;


SELECT XMLAttributes(employee_id as "id",
                       last_name || ' ' || first_name as "names") emp
  FROM employees
 WHERE employee_id > 200;


SELECT XMLForest(hire_date hire, salary salaries) forest
  FROM employees
 WHERE employee_id > 200;

SELECT XMLElement("emp", 
                  XMLAttributes(employee_id as "id"),
                  XMLForest(hire_date hire, salary salaries)) emp
  FROM employees
 WHERE employee_id = 200;
 
 
SELECT XMLConcat(  XMLElement("employee_id", employee_id),
                   XMLElement("first_name", first_name),
                   XMLElement("last_name", last_name)) emp
 FROM employees
WHERE employee_id = 210;


SELECT XMLELEMENT("Department", 
                  XMLAttributes(department_id AS "dept_id"),
                  XMLAgg(XMLElement("Employee", last_name||' '||first_name))) emp
  FROM employees
 GROUP BY department_id;


SELECT XMLELEMENT("Department", XMLAgg(XMLElement("Employee", last_name||' '||first_name))) emp
  FROM employees
 WHERE department_id = 20;


SELECT XMLSequence(XMLElement("Employee", last_name||' '||first_name)) emp
  FROM employees
 WHERE employee_id > 200;



SELECT SYS_XMLGEN(employee_id)
  FROM employees
 WHERE employee_id > 200;


SELECT SYS_XMLGEN('성명: ' || last_name || ' ' || first_name,
                      xmlformat.createformat('names')) emp
  FROM employees
 WHERE employee_id > 203;


SELECT XMLELEMENT("Department", 
                    XMLAttributes(department_id AS "dept_id"),
       SYS_XMLAgg(XMLElement("Employee", '성명: ' || last_name||' '||first_name))) emp
  FROM employees
 WHERE department_id IN ( 10, 30)
 GROUP BY department_id;


-- XQUERY 소개

SELECT id,
       XMLQUERY(
          'for $i in /rss/channel/item
          where $i /title = "[리눅스/유닉스] 리눅스 커널의 시간 보정"
          return <titles name= "{$i/title}" />
          ' PASSING xmldata RETURNING CONTENT) TESTS
 FROM xml_data;
 
 
 SELECT id,
       XMLQUERY(
          'for $i in /PurchaseOrder/ShippingInstructions
          where $i /name = "Sarah J. Bell"
          return <phone num= "{$i/telephone}" />' PASSING xmlclob RETURNING CONTENT) TEST
  FROM xml_clob
 WHERE id = 2;


SELECT id,
       data1."title", data1."author"
  FROM xml_data,
       XMLTABLE('/rss/channel/item' PASSING xml_data.xmldata
          COLUMNS
            "title" varchar2(100) PATH '/item/title',
            "author" varchar2(50) PATH '/item/author') data1;



SELECT c.*
  FROM regions r, countries c
 WHERE r.region_id = c.region_id
   AND r.region_name = '아시아';


SELECT XMLQuery('for $i in ora:view("REGIONS"), $j in ora:view("COUNTRIES")
                  where $i/ROW/REGION_ID = $j/ROW/REGION_ID
                    and $i/ROW/REGION_NAME = "아시아"
                  return $j'
               RETURNING CONTENT) AS asian_countries
  FROM DUAL;


SELECT  XMLQUERY(
          'for $i in /PurchaseOrder/ShippingInstructions/address, $j in ora:contains($i, "Oracle")
          return $j  ' PASSING xmlclob RETURNING CONTENT) TESTS
 FROM xml_clob
 WHERE id = 2;


SELECT  XMLQUERY(
          'for $i in /PurchaseOrder/ShippingInstructions/address, $j in ora:contains($i, "hong")
          return $j  ' PASSING xmlclob RETURNING CONTENT) TESTS
  FROM xml_clob
 WHERE id = 2;


SELECT  XMLQUERY(
          'for $i in /PurchaseOrder/ShippingInstructions/address, $j in ora:matches($i, "Oracle")
          return $j  ' PASSING xmlclob RETURNING CONTENT) TESTS
  FROM xml_clob
 WHERE id = 2;


SELECT  XMLQUERY(
          'for $i in /PurchaseOrder/ShippingInstructions/address, $j in ora:matches($i, "hong")
          return $j  ' PASSING xmlclob RETURNING CONTENT) TESTS
  FROM xml_clob
 WHERE id = 2;


