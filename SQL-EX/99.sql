/*
Задание: 99 (qwrqwr: 2013-03-01)
Рассматриваются только таблицы Income_o и Outcome_o. Известно, что прихода/расхода денег в воскресенье не бывает.
Для каждой даты прихода денег на каждом из пунктов определить дату инкассации по следующим правилам:
1. Дата инкассации совпадает с датой прихода, если в таблице Outcome_o нет записи о выдаче денег в эту дату на этом пункте.
2. В противном случае - первая возможная дата после даты прихода денег, которая не является воскресеньем и в Outcome_o не отмечена 
выдача денег сдатчикам вторсырья в эту дату на этом пункте.
Вывод: пункт, дата прихода денег, дата инкассации */

USE [sql-ex]
GO

SELECT [point]
      ,[date]
      ,[inc]
  FROM [dbo].[Income_o]
GO

SELECT [point]
      ,[date]
      ,[out]
  FROM [dbo].[Outcome_o]
GO

/*
Рассматриваются только таблицы Income_o и Outcome_o. Известно, что прихода/расхода денег в воскресенье не бывает.
Для каждой даты прихода денег на каждом из пунктов определить дату инкассации по следующим правилам:
1. Дата инкассации совпадает с датой прихода, если в таблице Outcome_o нет записи о выдаче денег в эту дату на этом пункте.
2. В противном случае - первая возможная дата после даты прихода денег, которая не является воскресеньем и в Outcome_o не отмечена 
выдача денег сдатчикам вторсырья в эту дату на этом пункте.
Вывод: пункт, дата прихода денег, дата инкассации */
SELECT [point]
      ,[date]
      ,[inc]
	  ,[date]
  FROM [Income_o] AS I
  WHERE NOT EXISTS (SELECT * FROM Outcome_o AS O WHERE O.date = I.date AND I.point = O.point)

SELECT [point]
      ,[date]
      ,[inc]
	  ,DATEPART(dw, [date])
	  ,DATEPART(dw, '2001-01-06')
	  
	  ,CASE DATEPART(dw, [date]) - DATEPART(dw, '2001-01-06')
	      WHEN 0 THEN DATEADD(DAY, 1, [date])
		  ELSE [date]
	   END

  FROM [Income_o] AS I
  WHERE EXISTS (SELECT * FROM Outcome_o AS O WHERE O.date = I.date AND I.point = O.point)

  SELECT DATEPART(dW, GETDATE()) - DATEPART(dw, '1900-01-01')
  SELECT DATEPART(dw, GETDATE())
  SELECT DATEPART(dw, '1900-01-07')
  SELECT @@DATEFIRST
  SELECT DATEPART(dw, '1900-01-06') - DATEPART(dw, '2001-01-06') -- BOTH DAYS ARE SUNDAY



  USE [sql-ex]
GO

/*В противном случае - первая возможная дата после даты прихода денег, которая не является воскресеньем и в Outcome_o не отмечена 
выдача денег сдатчикам вторсырья в эту дату на этом пункте.
Вывод: пункт, дата прихода денег, дата инкассации */
SET DATEFIRST 1;

SELECT I.[point] AS P1
      ,I.[date] AS D1
	  --,O.date AS D2
  FROM [Income_o] AS I
JOIN [Outcome_o] AS O
ON O.date = I.date
AND O.point = I.point
ORDER BY P1, D1

SELECT O.point, O.date, DATEADD(DAY, 1, O.date), DATEPART(DW, O.date) FROM Outcome_o AS O
ORDER BY POINT, date

SELECT
    I.point,
    I.date,
    I.inc
FROM
    Income_o AS I
JOIN
    Outcome_o AS O
    ON O.point = I.point
    AND O.date = (SELECT TOP 1 
                     date
                 FROM
                     Outcome_o
                 WHERE
                     point = I.point
                     AND date >= O.date 
                 ORDER BY
                     point,
                     date ASC);


SELECT I.* FROM Income_o AS I
JOIN Outcome_o AS O
ON O.point = I.point

SELECT O.* FROM Outcome_o AS O


SELECT POINT, MIN(DATE) FROM Outcome_o 
GROUP BY point
HAVING DATE > '20010324' AND DATEPART(D, DATE) <> 7
