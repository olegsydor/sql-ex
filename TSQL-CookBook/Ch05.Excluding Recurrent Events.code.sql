-- Excluding Recurrent Events
--
-- Chapter 5 - Temporal Data
-- Type of content: objects 
-- Date: 2002-1-22
-- Version: 1.0
--
-- Authors: Ales Spetic, Jonathan Gennick


SELECT  
   COUNT(*) No_working_days, 
   DATEDIFF(day,'2002-1-1','2002-3-1') No_days
FROM Pivot
WHERE 
   DATEADD(day,i,'2002-1-1') BETWEEN '2002-1-1' AND '2002-3-1' AND 
   DATEPART(weekday, DATEADD(d,i,'2002-1-1')) BETWEEN 2 AND 6
