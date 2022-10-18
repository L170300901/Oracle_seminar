
SELECT * FROM TEST09;
/* LINE (공정) , SPEC (제품사양) , ITEM (단위품목), QTY (수량)
특정 공정에서 특정 사양의 제품을 만들기 위해 어떤 부품이 몇개 들어가는가
하는 정보를 담고 있다  */
SELECT * FROM TEST10;
/* IDATE (투입일자), IN_SEQ (투입순서), LINE (공정), SPEC (제품사양)
  특정 일자의 투입순서별, 공정, 제품사양 정보를 관리한다 */



--p342 따라하기 : 부품 정보 읽기

/* 1999년 2월 3일에 쓰이는 부품의 List 읽어오기, 개수는 제외함
   TEST10 테이블의 LINE (공정) , SPEC (제품사양) 을 이용하여
   TEST09 테이블에서 사용한 부품의 ITEM (단위품목) 을 읽어오면 된다  */

SELECT * FROM TEST09;  -- LINE (공정) , SPEC (제품사양) , ITEM (단위품목), QTY (수량)
SELECT * FROM TEST10;  -- IDATE (투입일자), IN_SEQ (투입순서), LINE (공정), SPEC (제품사양)

--1번 방법 : 두 테이블을 LINE, SPEC 으로 심플조인 => 14개 출력
SELECT DISTINCT A.ITEM
FROM TEST09 A, TEST10 B
WHERE A.LINE = B. LINE
   AND A.SPEC = B.SPEC
   AND B.IDATE = '19990203' ;

--2번 방법 : 서브쿼리 이용, LINE 과 SPEC 을 따로따로 검색 => 15개 출력
SELECT DISTINCT A.ITEM
FROM TEST09 A
WHERE A.LINE IN ( SELECT LINE
                         FROM TEST10
                         WHERE IDATE = '19990203' )
   AND A.SPEC IN ( SELECT SPEC
                         FROM TEST10
                         WHERE IDATE = '19990203' );

--3번 방법 :  ( A.LINE, A.SPEC ) 한 쌍으로 검색 => 14개 출력
SELECT DISTINCT A.ITEM
FROM TEST09 A
WHERE ( A.LINE, A.SPEC ) IN ( SELECT LINE, SPEC
                                     FROM TEST10
                                     WHERE IDATE = '19990203' );

/* 위의 2번 방법이 잘못된 결과를 출력한다.
   정확히는 P16 부품 (ITEM) 이 하나 더 출력된다.
   TEST09 테이블에서 P16 부품은 " LINE 03, SPEC A002 " 에 사용된다고 나와있다
   그러나 TEST10 테이블에는 " LINE 03, SPEC A002 " 이 없다

   그럼에도 P16 부품이 출력되는 이유는
   A.LINE IN ( SELECT LINE
                      FROM TEST10
                      WHERE IDATE = '19990203' )  에서
    => A.LINE IN (01, 02, 03)
    => P16 부품 (ITEM) 이 해당됨 ( LINE 03 )

    A.SPEC IN ( SELECT SPEC
                      FROM TEST10
                      WHERE IDATE = '19990203' )  에서
    => A.SPEC IN (A001, A002, A003)
    => P16 부품 (ITEM) 이 해당됨 ( SPEC A002 )  */

-- 따라서 LINE과 SPEC 이 마치 하나의 COLIMN 인 것과 같이 조건이 걸려야 한다.



-- p346 문제 13-1 : Pairwise 와 Nonpairwise
/*
 1999년 2월 3일에 필요한 부품을 제외한 공정, 사양, 부품을 찾는 쿼리.
 TEST09 에 등록된 제품은 총 30개, 그중 필요한 부품은 14개
 따라서 필요하지 않는 부품은 총 16개가 출력되어야 한다 */

 --1번 방법 : JOIN => 60행 출력
SELECT DISTINCT A.LINE, A.SPEC, A.ITEM
FROM TEST09 A, TEST10 B
WHERE A.LINE <> B. LINE
   AND A.SPEC <> B.SPEC
   AND B.IDATE = '19990203' ;

--2번 방법 : Nonpairwise => 0행 출력
SELECT DISTINCT A.LINE, A.SPEC, A.ITEM
FROM TEST09 A
WHERE A.LINE NOT IN ( SELECT LINE
                               FROM TEST10
                               WHERE IDATE = '19990203' )
   AND A.SPEC NOT IN ( SELECT SPEC
                              FROM TEST10
                              WHERE IDATE = '19990203' );

--3번 방법 :  Pairwise  \=> 30행 출력
SELECT DISTINCT A.LINE, A.SPEC, A.ITEM
FROM TEST09 A
WHERE ( A.LINE, A.SPEC ) NOT IN ( SELECT LINE, SPEC
                                            FROM TEST10
                                            WHERE IDATE = '19990203' );


