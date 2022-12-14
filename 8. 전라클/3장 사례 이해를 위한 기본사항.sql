

-- p137 따라하기 : ANY 와 ALL
SELECT * FROM TEMP;

SELECT * FROM TEMP 
WHERE SALARY > ANY( SELECT SALARY FROM TEMP WHERE LEV = '과장' );

SELECT * FROM TEMP 
WHERE SALARY > ALL( SELECT SALARY FROM TEMP WHERE LEV = '과장' );

-- p138 따라하기 : EXISTS
SELECT * FROM TEMP;

SELECT * 
FROM TEMP A
WHERE EXISTS ( SELECT B.SALARY FROM TEMP B 
                      WHERE B.LEV = '과장' AND A.SALARY > B.SALARY );

