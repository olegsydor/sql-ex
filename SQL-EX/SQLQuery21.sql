;WITH A_CTE (na, cl) AS
(
SELECT S.[name]
      ,S.[class]
  FROM [Ships] AS S
UNION
SELECT O.[ship]
      ,CASE 
	  WHEN EXISTS (
	  SELECT X1.[name] 
	  FROM [Ships] AS X1 
	  WHERE X1.name = O.ship
	  ) 
	  THEN (
	  SELECT [class] 
	  FROM [Ships] AS X1 
	  WHERE X1.[name] = O.ship
	  ) 
	  ELSE 
	  O.ship
	  END
  FROM [Outcomes] AS O
)
, B_CTE AS
(
SELECT A_CTE.na AS na, C.country AS ct FROM A_CTE
JOIN Classes AS C
ON C.class = A_CTE.cl
)
, C_CTE (na, ct) AS
(
SELECT B_CTE.na, B_CTE.ct FROM B_CTE
JOIN Outcomes AS O
ON O.ship = B_CTE.na
AND O.result = 'sunk'
)
/*
SELECT C.na, C.ct, 'C' FROM C_CTE AS C
UNION ALL
SELECT B.na, B.ct, 'B' FROM B_CTE AS B
UNION ALL
SELECT A.na, A.cl, 'A' FROM A_CTE AS A
*/
SELECT country FROM Classes
EXCEPT
SELECT X2.ct FROM 
(
SELECT B.na, B.ct FROM B_CTE AS B
EXCEPT
SELECT C.na, C.ct FROM C_CTE AS C
) AS X2