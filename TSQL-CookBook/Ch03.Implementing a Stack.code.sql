-- Implementing a Stack 
--
-- Chapter 3 - Data Structures
-- Type of content: code
-- Date: 2002-1-17
-- Version: 1.0
--
-- Authors: Ales Spetic, Jonathan Gennick


SELECT TOP 1 * FROM ProductionLine ORDER BY ContainerId DESC

DROP PROCEDURE TopProduction
GO
CREATE PROCEDURE TopProduction
AS
SELECT TOP 1 * FROM ProductionLine ORDER BY ContainerId DESC
GO

DROP PROCEDURE Pop
GO
CREATE PROCEDURE Pop 
AS 
DECLARE @id INTEGER

SELECT TOP 1 @id=ContainerId FROM ProductionLine 
   ORDER BY ContainerId DESC
SELECT * FROM ProductionLine WHERE @id=ContainerId
DELETE FROM ProductionLine WHERE @id=ContainerId
GO

DROP PROCEDURE Push
GO
CREATE PROCEDURE Push @Purity INTEGER 
AS 
DECLARE @id INTEGER

SELECT TOP 1 @id=ContainerId FROM ProductionLine 
   ORDER BY ContainerId DESC
INSERT INTO ProductionLine(ContainerId,Purity) VALUES(@id+1, @Purity)
SELECT * FROM ProductionLine WHERE ContainerId=@id+1
GO
