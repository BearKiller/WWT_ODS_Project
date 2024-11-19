
--==============================================================
-- Stored Procedure: ETL_LoadCustomer
-- Author: Kenny Byrkett
-- Created Date: 9/20/2024
--
-- This procedure loads records from the Customer
-- staging table to load and update to the Customer ODS and
-- load and delete records to the Customer_Lookup ODS.
--
--= Changelog =--
-- 9/27/2024 KDB - Loads records into the Customer_Lookup table
--==============================================================


CREATE   PROCEDURE ETL_LoadCustomer
AS
BEGIN
	
	UPDATE [dbo].[Customer]
		SET [CustomerName] = [src_cus].[CustomerName]
           ,[PhoneNumber] = [src_cus].[PhoneNumber]
           ,[Fax] = [src_cus].[Fax]
		   ,[ContactName] = [src_cus].[ContactName]
		   ,[ContactTitle] = [src_cus].[ContactTitle]
           ,[AddressLine1] = [src_cus].[AddressLine1]
		   ,[AddressLine2] = [src_cus].[AddressLine2]
           ,[City] = [src_cus].[City]
           ,[State] = [src_cus].[State]
           ,[ZipCode] = [src_cus].[ZipCode]
		   ,[Region] = [src_cus].[Region]
           ,[Country] = [src_cus].[Country]
		   ,[Last_Update] = GETDATE()
		FROM [stg_Customer] AS src_cus
		JOIN [dbo].[Customer] AS tgt_cus
			ON [src_cus].[CustomerName] = [tgt_cus].[CustomerName]
		WHERE NOT (ISNULL([src_cus].[CustomerName], '') = ISNULL([tgt_cus].[CustomerName], '')
			AND ISNULL([src_cus].[PhoneNumber], '') = ISNULL([tgt_cus].[PhoneNumber], '')
			AND ISNULL([src_cus].[Fax], '') = ISNULL([tgt_cus].[Fax], '')
			AND ISNULL([src_cus].[ContactName], '') = ISNULL([tgt_cus].[ContactName], '')
			AND ISNULL([src_cus].[ContactTitle], '') = ISNULL([tgt_cus].[ContactTitle], '')
			AND ISNULL([src_cus].[AddressLine1], '') = ISNULL([tgt_cus].[AddressLine1], '')
			AND ISNULL([src_cus].[AddressLine2], '') = ISNULL([tgt_cus].[AddressLine2], '')
			AND ISNULL([src_cus].[City], '') = ISNULL([tgt_cus].[City], '')
			AND ISNULL([src_cus].[State], '') = ISNULL([tgt_cus].[State], '')
			AND ISNULL([src_cus].[ZipCode], '') = ISNULL([tgt_cus].[ZipCode], '')
			AND ISNULL([src_cus].[Region], '') = ISNULL([tgt_cus].[Region], '')
			AND ISNULL([src_cus].[Country], '') = ISNULL([tgt_cus].[Country], '')
			)

	INSERT INTO [dbo].[Customer]
			   ([CustomerName]
			   ,[PhoneNumber]
			   ,[Fax]
			   ,[ContactName]
			   ,[ContactTitle]
			   ,[CustomerKeyStandardized]
			   ,[AddressLine1]
			   ,[AddressLine2]
			   ,[City]
			   ,[State]
			   ,[ZipCode]
			   ,[Region]
			   ,[Country]
			   ,[Created_Date]
			   ,[Last_Update])
     SELECT DISTINCT [src_cus].[CustomerName]
	 ,[src_cus].[PhoneNumber]
	 ,[src_cus].[Fax]
	 ,[src_cus].[ContactName]
	 ,[src_cus].[ContactTitle]
	 ,[src_cus].[CustomerKeyStandardized]
	 ,[src_cus].[AddressLine1]
	 ,[src_cus].[AddressLine2]
	 ,[src_cus].[City]
	 ,[src_cus].[State]
	 ,[src_cus].[ZipCode]
	 ,[src_cus].[Region]
	 ,[src_cus].[Country]
	 ,GETDATE() AS [Created_Date]
	 ,GETDATE() AS [Last_Update]
	FROM [stg_Customer] AS src_cus
	LEFT JOIN [dbo].[Customer] AS tgt_cus
		ON [src_cus].[CustomerName] = [tgt_cus].[CustomerName]
	WHERE [tgt_cus].[ODS_Customer_ID] IS NULL
	
	INSERT INTO [dbo].[Customer_Lookup]
				([ODS_Customer_ID]
				,[Store_Source_ID]
				,[Customer_Source_ID])
	SELECT DISTINCT [cus].[ODS_Customer_ID]
	,[stg_cus].[Store_Source_ID]
	,[stg_cus].[Customer_Source_ID]
	FROM [Customer] AS cus
	JOIN [dbo].[stg_Customer] AS stg_cus
		ON [cus].[CustomerName] = [stg_cus].[CustomerName]
	LEFT JOIN [dbo].[Customer_Lookup] AS cus_lup
		ON [stg_cus].[Customer_Source_ID] = [cus_lup].[Customer_Source_ID]
		AND [stg_cus].[Store_Source_ID] = [cus_lup].[Store_Source_ID]
	WHERE [cus_lup].[ODS_Customer_ID] IS NULL

	DELETE FROM [dbo].[Customer_Lookup]
		FROM [dbo].[Customer_Lookup] AS cus_lup
		LEFT JOIN (
			SELECT DISTINCT [cus].[ODS_Customer_ID]
				,[stg_cus].[Store_Source_ID]
				,[stg_cus].[Customer_Source_ID]
				FROM [dbo].[stg_Customer] AS stg_cus
				JOIN [dbo].[Customer] AS cus
					ON [stg_cus].[CustomerName] = [cus].[CustomerName]) stg
			ON [cus_lup].[ODS_Customer_ID] = [stg].[ODS_Customer_ID]
			AND [cus_lup].[Store_Source_ID] = [stg].[Store_Source_ID]
		WHERE [stg].[ODS_Customer_ID] IS NULL

END
