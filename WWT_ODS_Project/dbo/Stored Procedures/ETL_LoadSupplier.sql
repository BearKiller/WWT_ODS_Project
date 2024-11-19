
--==============================================================
-- Stored Procedure: ETL_LoadSupplier
-- Author: Kenny Byrkett
-- Created Date: 9/27/2024
--
-- This procedure loads and updates records from the Supplier
-- staging table to the ODS. 
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE ETL_LoadSupplier
AS
BEGIN

	UPDATE [dbo].[Supplier]
		SET [SupplierName] = [src_sup].[SupplierName]
           ,[PhoneNumber] = [src_sup].[PhoneNumber]
           ,[Fax] = [src_sup].[Fax]
		   ,[ContactName] = [src_sup].[ContactName]
		   ,[ContactTitle] = [src_sup].[ContactTitle]
           ,[AddressLine1] = [src_sup].[AddressLine1]
		   ,[AddressLine2] = [src_sup].[AddressLine2]
           ,[City] = [src_sup].[City]
           ,[StateOrRegion] = [src_sup].[StateOrRegion]
           ,[ZipCode] = [src_sup].[ZipCode]
           ,[Country] = [src_sup].[Country]
		   ,[Last_Update] = GETDATE()
		FROM [stg_Supplier] AS src_sup
		JOIN [dbo].[Supplier] AS tgt_sup
			ON [src_sup].[Store_Source_ID] = [tgt_sup].[Store_Source_ID]
			AND [src_sup].[Supplier_Source_ID] = [tgt_sup].[Supplier_Source_ID]
		WHERE NOT (ISNULL([src_sup].[SupplierName], '') = ISNULL([tgt_sup].[SupplierName], '')
			AND ISNULL([src_sup].[PhoneNumber], '') = ISNULL([tgt_sup].[PhoneNumber], '')
			AND ISNULL([src_sup].[Fax], '') = ISNULL([tgt_sup].[Fax], '')
			AND ISNULL([src_sup].[ContactName], '') = ISNULL([tgt_sup].[ContactName], '')
			AND ISNULL([src_sup].[ContactTitle], '') = ISNULL([tgt_sup].[ContactTitle], '')
			AND ISNULL([src_sup].[AddressLine1], '') = ISNULL([tgt_sup].[AddressLine1], '')
			AND ISNULL([src_sup].[AddressLine2], '') = ISNULL([tgt_sup].[AddressLine2], '')
			AND ISNULL([src_sup].[City], '') = ISNULL([tgt_sup].[City], '')
			AND ISNULL([src_sup].[StateOrRegion], '') = ISNULL([tgt_sup].[StateOrRegion], '')
			AND ISNULL([src_sup].[ZipCode], '') = ISNULL([tgt_sup].[ZipCode], '')
			AND ISNULL([src_sup].[Country], '') = ISNULL([tgt_sup].[Country], '')
			)

	INSERT INTO [dbo].[Supplier]
           ([Supplier_Source_ID]
           ,[SupplierName]
           ,[ContactName]
           ,[ContactTitle]
           ,[PhoneNumber]
           ,[Fax]
           ,[Website]
           ,[AddressLine1]
           ,[AddressLine2]
           ,[City]
           ,[StateOrRegion]
		   ,[Country]
           ,[ZipCode]
           ,[Store_Source_ID]
           ,[Created_Date]
           ,[Last_Update])
	
	SELECT DISTINCT [stg_sup].[Supplier_Source_ID]
		,[stg_sup].[SupplierName]
		,[stg_sup].[ContactName]
		,[stg_sup].[ContactTitle]
		,[stg_sup].[PhoneNumber]
		,[stg_sup].[Fax]
		,[stg_sup].[Website]
		,[stg_sup].[AddressLine1]
		,[stg_sup].[AddressLine2]
		,[stg_sup].[City]
		,[stg_sup].[StateOrRegion]
		,[stg_sup].[Country]
		,[stg_sup].[ZipCode]
		,[stg_sup].[Store_Source_ID]
		,GETDATE() AS [Created_Date]
		,GETDATE() AS [Last_Update]
	FROM [dbo].[stg_Supplier] AS stg_sup
	LEFT JOIN [dbo].[Supplier] AS ods_sup
		ON [stg_sup].[Supplier_Source_ID] = [ods_sup].[Supplier_Source_ID]
		AND [stg_sup].[Store_Source_ID] = [ods_sup].[Store_Source_ID]
	WHERE [ods_sup].[ODS_Supplier_ID] IS NULL

END
