-- Printing Calendars
--
-- Chapter 5 - Temporal Data
-- Type of content: code
-- Date: 2002-1-22
-- Version: 1.0
--
-- Authors: Ales Spetic, Jonathan Gennick


SELECT  
   STR(YEAR(CAST('2001-1-1' AS DATETIME)+i-6))+ SPACE(1)+
      SUBSTRING('JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC',
      MONTH(CAST('2001-1-1' AS DATETIME)+i)*3-2,3) Month,
   DAY(CAST('2001-1-1' AS DATETIME)+i-6) AS S,
   DAY(CAST('2001-1-1' AS DATETIME)+i-5) AS M,
   DAY(CAST('2001-1-1' AS DATETIME)+i-4) AS T,
   DAY(CAST('2001-1-1' AS DATETIME)+i-3) AS W,
   DAY(CAST('2001-1-1' AS DATETIME)+i-2) AS T,
   DAY(CAST('2001-1-1' AS DATETIME)+i-1) AS F,
   DAY(CAST('2001-1-1' AS DATETIME)+i) AS S 
FROM Pivot
WHERE  DATEPART(dw,CAST('2001-1-1' AS DATETIME)+i)%7=0
ORDER BY i


SELECT  
   STR(YEAR(CAST('2001-1-1' AS DATETIME)+i-6))+ SPACE(1)+
   DATENAME(month, CAST('2001-1-1' AS DATETIME)+i) Month,
   DAY(CAST('2001-1-1' AS DATETIME)+i-6) AS S,
   DAY(CAST('2001-1-1' AS DATETIME)+i-5) AS M,
   DAY(CAST('2001-1-1' AS DATETIME)+i-4) AS T,
   DAY(CAST('2001-1-1' AS DATETIME)+i-3) AS W,
   DAY(CAST('2001-1-1' AS DATETIME)+i-2) AS T,
   DAY(CAST('2001-1-1' AS DATETIME)+i-1) AS F,
   DAY(CAST('2001-1-1' AS DATETIME)+i) AS S 
FROM Pivot
WHERE  DATEPART(dw,CAST('2001-1-1' AS DATETIME)+i)%7=0
ORDER BY i

