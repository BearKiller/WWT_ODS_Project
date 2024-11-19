
--==============================================================
-- Stored Procedure: ETL_ControlFlow
-- Author: Kenny Byrkett
-- Created Date: 9/23/2024
--
-- This procedure executes a series of stored procedures in the
-- correct order to load records from the staging tables to the
-- ODS tables.
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE ETL_ControlFlow
AS
BEGIN
	
	SET NOCOUNT ON

	EXECUTE ETL_LoadEmployee
	EXECUTE ETL_LoadTerritoryRegion
	EXECUTE ETL_LoadEmployeeTerritory
	EXECUTE ETL_LoadCustomer
	EXECUTE ETL_LoadSupplier
	EXECUTE ETL_LoadProduct
	EXECUTE ETL_LoadOrder
	EXECUTE ETL_LoadOrderDetail

END
