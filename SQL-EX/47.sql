USE [sql-ex]
GO

SELECT S.[name]
      ,S.[class]
      ,S.[launched]
  FROM [Ships] AS S
GO


SELECT O.[ship]
      ,O.[battle]
      ,O.[result]
  FROM [Outcomes] AS O
GO


SELECT C.[class]
      ,C.[type]
      ,C.[country]
      ,C.[numGuns]
      ,C.[bore]
      ,C.[displacement]
  FROM [Classes] AS C
GO

SELECT B.[name]
      ,B.[date]
  FROM [Battles] AS B
GO

------------

SELECT S.*, C.*
  FROM [Ships] AS S
JOIN [Classes] AS C
ON C.class = S.class

SELECT O.[ship]
      ,O.[battle]
      ,O.[result]
  FROM [Outcomes] AS O
GO



SELECT COUNTRY FROM [Classes]
EXCEPT
SELECT D.COUNTRY FROM
(
SELECT C.[country], COUNT(*) AS D
FROM [Classes] AS C
GROUP BY C.country
EXCEPT
SELECT C2.country, COUNT(O2.result) FROM
(
SELECT O.ship FROM Outcomes AS O
UNION
SELECT S.[name] FROM [Ships] AS S
) AS S0
LEFT JOIN [Ships] AS S1
ON S1.name = S0.ship
JOIN ClassES AS C2
ON C2.class = COALESCE(S1.[Class], S0.[Ship])
LEFT JOIN [Outcomes] AS O2
ON O2.ship = S0.ship
GROUP BY C2.country, O2.result
HAVING O2.result = 'sunk'
) AS D



SELECT * FROM
(
SELECT O.ship FROM Outcomes AS O
UNION
SELECT S.[name] FROM [Ships] AS S
) AS S0
LEFT JOIN [Ships] AS S1
ON S1.name = S0.ship
JOIN ClassES AS C2
ON C2.class = COALESCE(S1.[Class], S0.[Ship])
LEFT JOIN [Outcomes] AS O2
ON O2.ship = S0.ship
WHERE O2.result = 'sunk'