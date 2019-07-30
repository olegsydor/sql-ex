/*USE [labor_sql]
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

SELECT [name]
      ,[class]
      ,[launched]
  FROM [dbo].[ships]
GO


USE [labor_sql]
GO

SELECT [ship]
      ,[battle]
      ,[result]
  FROM [dbo].[outcomes]
GO
*/

;WITH s_CTE (ship)
AS 
(
SELECT [name]
FROM [ships]
UNION
SELECT [ship]
FROM [outcomes]

)
,sc_CTE (ship, class)
AS 
(
SELECT s_CTE.ship
      --,IIF(S.class IS NULL, s_CTE.ship, S.class)
	  ,COALESCE(S.class, s_CTE.ship)
FROM s_CTE
LEFT JOIN [ships] AS S
ON S.name = s_CTE.ship
LEFT JOIN [classes] AS C
ON C.class = S.name

)
SELECT * 
--SELECT C0.ship
      --,C0.class
      --,C1.numGuns
	  --,C1.displacement
 FROM sc_CTE AS C0
JOIN [classes] AS C1
ON C1.class = C0.class
WHERE C1.numGuns = (
	SELECT MAX(numGuns) FROM [classes] AS CCC 
	WHERE  CCC.displacement = C1.displacement
)

ORDER BY C1.displacement DESC, C1.numGuns DESC


SELECT DISTINCT CASE 
 WHEN sh.name IS NOT NULL 
 THEN sh.name 
 ELSE ou.ship
 END name
FROM Ships sh FULL JOIN
 Outcomes ou ON ou.ship = sh.name LEFT OUTER JOIN
 Classes cl ON ou.ship = cl.class OR 
 sh.class = cl.class LEFT OUTER JOIN
 Classes cl2 ON cl.displacement = cl2.displacement AND
 cl.numGuns < cl2.numGuns
WHERE cl.class IS NOT NULL AND 
 cl2.class IS NULL;