/*
«адание: 94 (Serge I: 2003-04-09)

ƒл€ семи последовательных дней, начина€ от минимальной даты, когда из –остова было совершено максимальное число рейсов, определить число рейсов из –остова. 
¬ывод: дата, количество рейсов
*/

SELECT T.[trip_no]
      ,T.[id_comp]
      ,T.[plane]
      ,T.[town_from]
      ,T.[town_to]
      ,T.[time_out]
      ,T.[time_in]
  FROM [trip] AS T
GO

SELECT P.[trip_no]
      ,P.[date]
      ,P.[id_psg]
      ,P.[place]
  FROM [pass_in_trip] AS P
GO


SELECT DATEADD(DAY, -1, MIN(P.date)), 0 FROM [trip] AS T
JOIN [pass_in_trip] AS P
ON P.trip_no = T.trip_no
WHERE T.town_from = 'Rostov'

;WITH A_CTE AS
(
SELECT 0 AS NUM1, MIN(B.Fdate) AS Fdate
FROM  
(
SELECT TOP (1) WITH TIES
       P.date AS Fdate
	   ,COUNT(DISTINCT T.trip_no) AS C
FROM [trip] AS T
JOIN [pass_in_trip] AS P
ON P.trip_no = T.trip_no
GROUP BY P.date, T.town_from
HAVING T.town_from = 'Rostov'
ORDER BY C DESC
) AS B

UNION ALL
SELECT NUM1+1, 
       DATEADD(DAY, 1, Fdate) 
FROM A_CTE AS B_CTE
WHERE NUM1 < 6
)
SELECT A.Fdate, CASE WHEN X.CC IS NULL THEN 0 ELSE X.CC END FROM A_CTE AS A
LEFT JOIN
(
SELECT P.date, COUNT(DISTINCT P.trip_no) AS CC FROM [trip] AS T
JOIN [pass_in_trip] AS P
ON P.trip_no = T.trip_no
GROUP BY T.town_from, P.date
HAVING T.town_from = 'Rostov'
) AS X
ON X.date = A.Fdate

SELECT P.date, COUNT(DISTINCT P.date) AS CC FROM [trip] AS T
JOIN [pass_in_trip] AS P
ON P.trip_no = T.trip_no
GROUP BY T.town_from, P.date
HAVING T.town_from = 'Rostov'

SELECT * FROM [trip] AS T
FULL OUTER JOIN pass_in_trip AS P
ON P.trip_no = T.trip_no
WHERE T.town_from = 'Rostov'
ORDER BY P.date


SELECT 0, MIN(B.Fdate)
FROM  
(
SELECT TOP (1) WITH TIES 
       0 AS NUM1, 
       P.date AS Fdate
	   ,COUNT(*) AS C
FROM [trip] AS T
JOIN [pass_in_trip] AS P
ON P.trip_no = T.trip_no
GROUP BY P.date, T.town_from
HAVING T.town_from = 'Rostov'
ORDER BY C DESC
) AS B