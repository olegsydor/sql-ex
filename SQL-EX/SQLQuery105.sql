/*
Задание: 107 (VIG: 2003-09-01)
Для пятого по счету пассажира из числа вылетевших из Ростова в апреле 2003 года определить компанию, номер рейса и дату вылета.
Замечание. Считать, что два рейса одновременно вылететь из Ростова не могут.
*/

USE [sql-ex]
GO

SELECT T.[trip_no]
      ,T.[id_comp]
      ,T.[plane]
      ,T.[town_from]
      ,T.[town_to]
      ,T.[time_out]
      ,T.[time_in]
  FROM [trip] AS T
GO

SELECT C.[name]
      ,P.[trip_no]
      ,P.[date]
  FROM [pass_in_trip] AS P
JOIN [trip] AS T
ON T.trip_no = P.trip_no
JOIN [company] AS C
ON C.ID_comp = T.ID_comp
WHERE T.town_from = 'Rostov'
AND DATEPART(YEAR, P.date) = 2003
AND DATEPART(MONTH, P.date) = 4
ORDER BY P.date
OFFSET 5 ROWS FETCH FIRST 1 ROW ONLY


SELECT T.[trip_no]
      ,T.[id_comp]
      ,T.[plane]
      ,T.[town_from]
      ,T.[town_to]
      ,T.[time_out]
      ,T.[time_in]
  FROM [trip] AS T
GO

SELECT A1.name, A1.trip_no, A1.date
FROM
(
SELECT RANK() OVER (ORDER BY P.[date], P.[id_psg]) AS NUMB
      ,P.[trip_no]
      ,P.[date]
      ,P.[id_psg]
      ,P.[place]
	  ,C.name
  FROM [pass_in_trip] AS P
JOIN [Trip] AS T
ON T.trip_no = P.trip_no
AND T.town_from = 'Rostov'
AND DATEPART(YEAR, P.date) = 2003
AND DATEPART(MONTH, P.date) = 4
JOIN [Company] AS C
ON C.ID_comp = T.ID_comp
) AS A1
WHERE A1.NUMB = 5

SELECT P.[trip_no]
      ,P.[date]
      ,P.[id_psg]
      ,P.[place]
  FROM [pass_in_trip] AS P
JOIN [Trip] AS T
ON T.trip_no = P.trip_no
--AND T.town_from = 'Rostov'
--AND DATEPART(YEAR, P.date) = 2003
--AND DATEPART(MONTH, P.date) = 4
ORDER BY P.[date]


SELECT TOP (1) D.name, D.trip_no, D.date FROM
(
SELECT DENSE_RANK() OVER (ORDER BY P.[id_psg]) AS NUMB2
      ,RANK() OVER (ORDER BY P.[date]) AS NUMB
      ,P.[trip_no]
      ,P.[date]
      ,P.[id_psg]
      ,P.[place]
	  ,C.name
  FROM [pass_in_trip] AS P
JOIN [Trip] AS T
ON T.trip_no = P.trip_no
AND T.town_from = 'Rostov'
AND DATEPART(YEAR, P.date) = 2003
AND DATEPART(MONTH, P.date) = 4
JOIN [Company] AS C
ON C.ID_comp = T.ID_comp
) AS D
WHERE D.NUMB = 5
ORDER BY NUMB2 DESC


SELECT DISTINCT P0.ID_psg, P.trip_no, T.town_from FROM [Pass_in_trip] AS P0
JOIN Pass_in_trip AS P
ON P.ID_psg = P0.ID_psg
JOIN [Trip] AS T
ON T.trip_no = P.trip_no
AND T.town_from = 'Rostov'
AND DATEPART(YEAR, P.date) = 2003
AND DATEPART(MONTH, P.date) = 4
JOIN [Company] AS C
ON C.ID_comp = T.ID_comp