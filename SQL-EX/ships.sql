USE [sql-ex]
GO

SELECT S.[name]
      ,S.[class]
      ,S.[launched]
  FROM [Ships] AS S
GO


SELECT O.[ship]
      ,O.[battle]
      ,O.[result]
  FROM [Outcomes] AS O
GO


SELECT C.[class]
      ,C.[type]
      ,C.[country]
      ,C.[numGuns]
      ,C.[bore]
      ,C.[displacement]
  FROM [Classes] AS C
GO

SELECT B.[name]
      ,B.[date]
  FROM [Battles] AS B
GO

