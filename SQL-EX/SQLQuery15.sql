USE [labor_sql]
GO

SELECT [class]
      ,[type]
      ,[country]
      ,[numGuns]
      ,[bore]
      ,[displacement]
  FROM [dbo].[classes]
GO

USE [labor_sql]
GO


;WITH ship_CTE (name)
AS
(
SELECT [name]
  FROM [dbo].[ships]
UNION
SELECT [ship]
  FROM [dbo].[outcomes]
)
SELECT ship_CTE.[name], Y.[launched]
FROM ship_CTE
LEFT JOIN [ships] AS Y
ON Y.name = ship_CTE.name

	
DROP TABLE ##tempShips

CREATE TABLE ##tempShips
    (  
        Ship VARCHAR(50),  
        Class VARCHAR(50),
		Launched INT,
		Launched_ INT,
		Country VARCHAR(20)
    );  
INSERT INTO ##tempShips (Ship) 
(SELECT [name]
  FROM [dbo].[ships]
UNION
SELECT [ship]
  FROM [dbo].[outcomes])


SELECT * FROM ##tempShips


UPDATE ##tempShips
SET Launched = Y.launched
   ,Class = Y.class
FROM [ships] AS Y
WHERE Y.name = ##tempShips.Ship

UPDATE ##tempShips
SET Class = Y.Class
FROM [classes] AS Y
WHERE Y.class = ##tempShips.Ship
AND ##tempShips.Class IS NULL

UPDATE ##tempShips
SET Country = C.Country
FROM [classes] AS C
WHERE C.class = ##tempShips.Class


UPDATE ##tempShips
SET Launched = X.date
FROM
(SELECT O.[ship]
      --,O.[battle]
      --,O.[result]
	  ,MIN(DATEPART(YEAR,B.date)) AS date
  FROM [dbo].[outcomes] AS O
JOIN [dbo].[battles] AS B
ON B.name = O.battle
GROUP BY O.ship) AS X
WHERE Launched IS NULL


SELECT A1.Ship, A1.Class, A1.Launched, A2.L FROM ##tempShips AS A1
LEFT JOIN 
(SELECT Class, MIN(Launched) AS L FROM ##tempShips
GROUP BY Class) AS A2
ON A2.Class = A1.Class

##tempShips AS A2
--SELECT 
SELECT Class, MIN(Launched) FROM ##tempShips
GROUP BY Class

--WHERE Ship = Class