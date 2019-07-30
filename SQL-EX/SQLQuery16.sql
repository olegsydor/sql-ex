;WITH s_CTE (ship, TT)
AS 
(
SELECT [name], 'ship' 
FROM [dbo].[ships]
UNION
SELECT [class], 'class'
  FROM [dbo].[classes]
UNION
SELECT [ship], 'outcomes'
  FROM [dbo].[outcomes]
)
,
sc_CTE (ship, TT, class, launched)
AS
(
SELECT ship,
      TT,
      COALESCE(CIN.class, CL.[class]),
	  launched
FROM s_CTE
LEFT JOIN [ships] AS CIN
ON CIN.name = s_CTE.ship
LEFT JOIN [classes] AS CL
ON CL.class = s_CTE.ship
)
,
all_cte (ship, what, class, launched, yee) as
(
SELECT DISTINCT sc_CTE.ship
      ,sc_CTE.TT
	  ,c.class
	  ,sc_CTE.launched
      ,COALESCE(sc_CTE.launched,DATEPART(YEAR,B.date))
	  --,O.*
	  --,B.*
	  --,DATEPART(YEAR,B.date)
FROM sc_CTE
LEFT JOIN [classes] AS C
ON C.class = sc_CTE.class
LEFT JOIN [outcomes] AS O
ON O.ship = sc_CTE.ship
LEFT JOIN [battles] AS B
ON B.name = O.battle
)
select distinct all_cte.*, a.launched
from all_cte
left join sc_CTE as a
on all_cte.ship = a.class
and all_cte.launched is null
and all_cte.yee is null
where (all_cte.launched < 1941 or all_cte.yee < 1941 or a.launched < 1941)