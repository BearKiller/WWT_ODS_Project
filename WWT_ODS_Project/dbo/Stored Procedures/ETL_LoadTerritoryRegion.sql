
--==============================================================
-- Stored Procedure: ETL_LoadTerritoryRegion
-- Author: Kenny Byrkett
-- Created Date: 9/20/2024
--
-- This procedure loads records from the TerritoryRegion
-- staging table to the ODS. No updates. No deletes.
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE ETL_LoadTerritoryRegion
AS
BEGIN
	INSERT INTO [dbo].[TerritoryRegion]
           ([TerritoryID]
           ,[TerritoryDescription]
           ,[RegionDescription]
           ,[Created_Date])
	SELECT DISTINCT [src_tr].[TerritoryID]
		,[src_tr].[TerritoryDescription]
		,[src_tr].[RegionDescription]
		,GETDATE() AS Created_Date
	FROM [stg_TerritoryRegion] AS src_tr
	LEFT JOIN [TerritoryRegion] AS tgt_tr
		ON [src_tr].[TerritoryDescription] = [tgt_tr].[TerritoryDescription]
		AND [src_tr].[RegionDescription] = [src_tr].[RegionDescription]
	WHERE [tgt_tr].[TerritoryID] IS NULL
END
