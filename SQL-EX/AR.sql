/* 47 */

;WITH A_CTE AS
(
SELECT C.[class] AS NA
      ,C.[class] AS CL
      ,C.[country]
  FROM [Classes] AS C
UNION ALL
SELECT S.[name]
      ,S.[class]
	  ,C.[country]
  FROM [Ships] AS S
JOIN [Classes] AS C
ON C.class = S.class
)
SELECT country FROM A_CTE
EXCEPT
SELECT X.country FROM
(
SELECT country, NA FROM A_CTE
EXCEPT
SELECT A.country, A.NA FROM A_CTE AS A
JOIN Outcomes AS O
ON A.NA = O.ship
AND O.result = 'sunk'
) AS X


---------------

SELECT C.country FROM Classes AS C

SELECT * FROM 
(
SELECT S.name FROM [Ships] AS S
UNION ALL
SELECT O.ship FROM [Outcomes] AS O
EXCEPT
SELECT O.ship FROM Outcomes AS O
WHERE O.result = 'sunk'
) AS X
JOIN [Classes] AS C
;

;WITH A_CTE AS
(-- All ships
SELECT C.[class] AS NA
--      ,C.[class] AS CL
      ,C.[country]
  FROM [Classes] AS C
UNION ALL
SELECT S.[name]
--      ,S.[class]
	  ,C.[country]
  FROM [Ships] AS S
JOIN [Classes] AS C
ON C.class = S.class
)
,
S_CTE AS
(
-- All sunk ships
SELECT O.ship, C.country FROM Outcomes AS O
JOIN [Ships] AS S
ON S.name = O.ship
JOIN [Classes] AS C
ON C.class = S.class
WHERE O.result = 'sunk'
UNION
SELECT O.ship, C.country FROM Outcomes AS O
JOIN [Classes] AS C
ON C.class = O.ship
WHERE O.result = 'sunk'
)
SELECT DISTINCT country FROM A_CTE
EXCEPT
SELECT X.country FROM
(
SELECT * FROM A_CTE
EXCEPT
SELECT * FROM S_CTE) AS X