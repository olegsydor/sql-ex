/*Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей. */



SELECT COUNT(X.result) FROM 
(
SELECT O.result
FROM outcomes AS O
LEFT JOIN ships AS S
ON S.name = O.ship
AND O.result = 'sunk'
RIGHT JOIN classes AS C
ON C.class = S.class

UNION

SELECT O.result
FROM outcomes AS O
RIGHT JOIN classes AS C
ON C.class = O.ship
AND O.result = 'sunk'
) AS X



-------------------
SELECT C.class, COUNT(O.ship), 0 FROM classes AS C
LEFT JOIN outcomes AS O
ON O.ship = C.class
AND O.result = 'sunk'
GROUP BY C.class, O.result

UNION

SELECT S.class, 0, COUNT(O.ship) FROM ships AS S
LEFT JOIN outcomes AS O
ON O.ship = S.class
AND O.result = 'sunk'
GROUP BY S.class, O.result



SELECT C.class, COUNT(S.class) FROM classes AS C
LEFT JOIN outcomes AS O
ON O.ship = C.class
AND O.result = 'sunk'
LEFT JOIN ships AS S
ON S.class = O.ship
AND O.result = 'sunk'
GROUP BY C.class, O.result


SELECT X.class, sum(X.one+X.two) FROM 
(
SELECT C.class, 0 as 'one', CASE O.result WHEN 'sunk' THEN count(O.result) ELSE 0 END as 'two'
FROM outcomes AS O
LEFT JOIN ships AS S
ON S.name = O.ship
--AND O.result = 'sunk'
RIGHT JOIN classes AS C
ON C.class = S.class
GROUP BY C.class, O.result

UNION

SELECT C.class, CASE O.result WHEN 'sunk' THEN COUNT(O.result) ELSE 0 END as 'one', 0 as 'two'
FROM outcomes AS O
RIGHT JOIN classes AS C
ON C.class = O.ship
--AND O.result = 'sunk'
GROUP BY C.class, O.result
) AS X
GROUP BY X.class--, X.result
---------------------------------------------------------------------------
SELECT [class]
      ,[type]
      ,[country]
      ,[numGuns]
      ,[bore]
      ,[displacement]
  FROM [dbo].[classes]
GO
--INSERT INTO [classes] ([class], [type], [country], [numGuns], [bore],[displacement]) 
--VALUES ('Eternity', 'bb', 'Japan', 7, 15, 40000)
--GO

USE [labor_sql]
GO
SELECT CLF.CLASS, iif(sum(x.result) is null, 0, sum(x.result))
FROM
(
SELECT S.[class]
	  ,count(O.result) as result
  FROM [dbo].[ships] AS S
  JOIN [dbo].[classes] AS C
  ON C.class = S.class
  JOIN [dbo].[outcomes] AS O
  ON O.ship = S.name
  AND O.result = 'sunk'
  group by s.class

  UNION ALL
  SELECT C.[class]
	  ,count(O.result) as result
  FROM [dbo].[classes] AS C
  JOIN [dbo].[outcomes] AS O
  ON O.ship = C.class
  AND O.result = 'sunk'
  group by c.class

 ) AS X 

 right JOIN 
classes as clf
 ON CLF.class = X.class
 GROUP BY CLF.class

    UNION all
  SELECT NULL as 'class', COUNT(O.ship) as result
  FROM outcomes AS O
  WHERE O.result = 'sunk'
  AND O.ship NOT in (
  SELECT S1.name
  FROM [dbo].[ships] AS S1
  WHERE S1.name = O.ship)


 -----
 SELECT class, COUNT(result) AS sunk 
FROM (SELECT class, result, name 
 FROM Ships LEFT JOIN 
 Outcomes ON ship=name AND 
 --class IS NOT NULL AND 
 result = 'sunk'
 ) T 
GROUP BY class 

