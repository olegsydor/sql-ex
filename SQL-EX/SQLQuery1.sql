/* Задание: 88 (Serge I: 2003-04-29)

Среди тех, кто пользуется услугами только одной компании, определить имена разных пассажиров, летавших чаще других. 
Вывести: имя пассажира, число полетов и название компании.
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

SELECT G.[id_psg]
      ,G.[name]
  FROM [passenger] AS G
GO

SELECT TOP (1) WITH TIES COUNT(P.date), P.id_psg FROM [pass_in_trip] AS P
JOIN [trip] AS T
ON T.trip_no = P.trip_no
GROUP BY P.id_psg
HAVING P.id_psg IN
(
SELECT P.id_psg FROM [pass_in_trip] AS P
JOIN [trip] AS T
ON T.trip_no = P.trip_no
GROUP BY P.id_psg
HAVING COUNT(DISTINCT T.id_comp) = 1
)
ORDER BY COUNT(P.date) DESC
-------------------------
SELECT * FROM [pass_in_trip] AS P
JOIN [trip] AS T
ON T.trip_no = P.trip_no
ORDER BY P.id_psg
---------------------
SELECT TOP (1) WITH TIES PAS, D, CMP FROM
(
SELECT COUNT(P.date) AS D, P.id_psg AS ID FROM [pass_in_trip] AS P
JOIN [trip] AS T
ON T.trip_no = P.trip_no
GROUP BY P.id_psg
) AS X
CROSS APPLY
(
SELECT P.id_psg AS ID_P, MIN(P1.name) AS PAS, MIN(C.name) AS CMP FROM [pass_in_trip] AS P
JOIN [trip] AS T
ON T.trip_no = P.trip_no
JOIN [company] AS C
ON C.id_comp = T.id_comp
JOIN [passenger] AS P1
ON P1.id_psg = P.id_psg
GROUP BY P.id_psg
HAVING COUNT(DISTINCT T.id_comp) = 1
) AS Y
WHERE X.ID = Y.ID_P
ORDER BY X.D DESC