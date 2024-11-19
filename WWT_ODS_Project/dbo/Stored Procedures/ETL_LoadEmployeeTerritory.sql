


--==============================================================
-- Stored Procedure: ETL_LoadEmployeeTerritory
-- Author: Kenny Byrkett
-- Created Date: 9/21/2024
--
-- This procedure loads records from the EmployeeTerritory
-- staging table to the ODS. Deletes records. No updates.
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE ETL_LoadEmployeeTerritory
AS
BEGIN

	INSERT INTO [dbo].[EmployeeTerritory](
		[ODS_Employee_ID]
		,[TerritoryID]
		,[Created_Date])

	SELECT DISTINCT [ods_emp].[ODS_Employee_ID]
		,[ods_ter].[TerritoryID]
		,GETDATE() AS Created_Date
	FROM [dbo].[stg_TerritoryRegion] AS stg_ter
	JOIN [TerritoryRegion] AS ods_ter
		ON [stg_ter].[TerritoryDescription] = [ods_ter].[TerritoryDescription]
		AND [stg_ter].[RegionDescription] = [ods_ter].[RegionDescription]
	JOIN [Employee] AS ods_emp
		ON [stg_ter].[Employee_Source_ID] = [ods_emp].[Employee_Source_ID]
	LEFT JOIN [EmployeeTerritory] AS ods_empty
		ON [ods_emp].[ODS_Employee_ID] = [ods_empty].[ODS_Employee_ID]
		AND [ods_ter].[TerritoryID] = [ods_empty].[TerritoryID]
	WHERE [ods_empty].[ODS_Employee_ID] IS NULL

	DELETE FROM [dbo].[EmployeeTerritory]
		FROM [EmployeeTerritory] et
		LEFT JOIN(
			SELECT DISTINCT [ods_emp].[ODS_Employee_ID]
				,[ods_ter].[TerritoryID]
			FROM [dbo].[stg_TerritoryRegion] AS stg_ter
			JOIN [TerritoryRegion] AS ods_ter
				ON [stg_ter].[TerritoryDescription] = [ods_ter].[TerritoryDescription]
				AND [stg_ter].[RegionDescription] = [ods_ter].[RegionDescription]
			JOIN [Employee] AS ods_emp
				ON [stg_ter].[Employee_Source_ID] = [ods_emp].[Employee_Source_ID]
		) AS stg
		ON [et].[ODS_Employee_ID] = [stg].[ODS_Employee_ID]
		AND [et].[TerritoryID] = [et].[TerritoryID]
		WHERE [stg].[ODS_Employee_ID] IS NULL

END
