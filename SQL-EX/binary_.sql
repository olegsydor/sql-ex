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
/*
SELECT [code]
      ,[speed]
      ,[ram]
	  ,[speed]|[ram]
  FROM [dbo].[pc]
GO
*/