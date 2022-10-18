SELECT * FROM TEST09;

SELECT line,spec,item,qty,
							Lag(line) OVER (ORDER BY line,spec) AS bline,
              lag(spec) OVER (ORDER BY line,spec) AS bspec
			FROM TEST09
      WHERE item LIKE 'P0%';

SELECT DECODE(line,NVL(bline,' '),NULL,line) AS line,
			 DECODE(spec,NVL(bspec,' '),NULL,spec) AS spec,
       item,qty
FROM (SELECT line,spec,item,qty,Lag(line) OVER (ORDER BY line,spec) AS bline,lag(spec) OVER (ORDER BY line,spec) AS bspec
			FROM TEST09
      WHERE item LIKE 'P0%');
------------------------------------------------------------------------------------------------------------------------
SELECT DECODE(line,bline,NULL,line) AS line,
			 DECODE(spec,bspec,NULL,spec) AS spec,
       item,qty
FROM (SELECT line,spec,item,qty,Lag(line) OVER (ORDER BY line,spec) AS bline,lag(spec) OVER (ORDER BY line,spec) AS bspec
			FROM TEST09
      WHERE item LIKE 'P0%');

