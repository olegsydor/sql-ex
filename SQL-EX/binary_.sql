

/*Задание: 98 (qwrqwr: 2010-04-26)
Вывести список ПК, для каждого из которых результат побитовой операции ИЛИ, примененной к двоичным представлениям 
скорости процессора и объема памяти, содержит последовательность из не менее четырех идущих подряд единичных битов.
Вывод: код модели, скорость процессора, объем памяти.*/
/*
SELECT [code]
      ,[speed]
      ,[ram]
	  ,[speed]|[ram]
	  ,dbo.[DecimalToBinary]([speed]|[ram])
  FROM [dbo].[pc]
GO
*/
;WITH BIN_CTE (numb, N1, N2, N4, N8, N16, N32, N64, N128, N256, N512, N1024, N2048, N4096) AS
(SELECT 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
UNION ALL
SELECT numb+1 AS numb
     ,numb%2 AS N1
	 ,numb/2%2 AS N2
	 ,numb/4%2 AS N4
	 ,numb/8%2 AS N8
	 ,numb/16%2 AS N16
	 ,numb/32%2 AS N32
	 ,numb/64%2 AS N64
	 ,numb/128%2 AS N128
	 ,numb/256%2 AS N256
	 ,numb/512%2 AS N512
	 ,numb/1024%2 AS N1024
	 ,numb/2048%2 AS N2048
	 ,numb/4096%2 AS N4096
from BIN_CTE AS FULL_CTE
WHERE FULL_CTE.numb < 2400
)
, CHR_CTE AS
(
SELECT NUMB-1 AS N1
      ,CONCAT(
       CAST(N1    AS nchar(1))
      ,CAST(N2    AS nchar(1))
      ,CAST(N4    AS nchar(1))
      ,CAST(N8    AS nchar(1))
      ,CAST(N16   AS nchar(1))
      ,CAST(N32   AS nchar(1))
      ,CAST(N64   AS nchar(1))
      ,CAST(N128  AS nchar(1))
      ,CAST(N256  AS nchar(1))
      ,CAST(N512  AS nchar(1))
      ,CAST(N1024 AS nchar(1))
	  ,CAST(N2048 AS nchar(1))
	  ,CAST(N4096 AS nchar(1))

	  ) AS Concat_string

FROM BIN_CTE
)
SELECT P.[code]
      ,P.[speed]
      ,P.[ram]
	  --,P.[speed]|P.[ram]
	  --,c.Concat_string
	  FROM [pc] AS P
	  JOIN CHR_CTE AS C
	  ON P.[speed]|P.[ram] = C.N1
      WHERE C.Concat_string LIKE '%1111%'	  
OPTION (MAXRECURSION 4500)

/*Задание: 98 (qwrqwr: 2010-04-26)
Вывести список ПК, для каждого из которых результат побитовой операции ИЛИ, примененной к двоичным представлениям 
скорости процессора и объема памяти, содержит последовательность из не менее четырех идущих подряд единичных битов.
Вывод: код модели, скорость процессора, объем памяти.*/

select pp.code, pp.speed1, pp.ram from
(
SELECT [code] as code
      ,[speed] as speed1
      ,[ram] as ram
	  ,[speed]|[ram] as speed
from PC
)  as pp
where concat(
      cast(speed%2 as nchar(1))
	 ,cast(speed/2%2 as nchar(1))
	 ,cast(speed/4%2 as nchar(1))
	 ,cast(speed/8%2 as nchar(1))
	 ,cast(speed/16%2 as nchar(1))
	 ,cast(speed/32%2 as nchar(1))
	 ,cast(speed/64%2 as nchar(1))
	 ,cast(speed/128%2 as nchar(1))
	 ,cast(speed/256%2 as nchar(1))
	 ,cast(speed/512%2 as nchar(1))
	 ,cast(speed/1024%2 as nchar(1))
	 ,cast(speed/2048%2 as nchar(1))
	 ,cast(speed/4096%2 as nchar(1))
	 ,cast(speed/8192%2 as nchar(1))
     ,cast(speed/16384%2 as nchar(1))
     ,cast(speed/32768%2 as nchar(1))
     ,cast(speed/65536%2 as nchar(1))
     ,cast(speed/131072%2 as nchar(1))

	 ) like '%1111%'


-- Прекрасно --
;with cte as (
    select cast(15 as bigint) as cnt
    union all
    select cnt*2 from cte
    where cnt <= CAST(0x4FFFFFFFFFFFFFFF AS bigint)
)
select distinct code, speed, ram 
from pc join cte on ((speed | ram) & cnt) = cnt

-- Прекрасно 2 --
WITH
masks AS (
  SELECT m=15
  UNION ALL
  SELECT m*2
  FROM masks
  WHERE m<=15*2048
)
SELECT DISTINCT code, speed, ram
FROM pc JOIN masks ON (speed | ram) & m = m