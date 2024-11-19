
--==============================================================
-- Stored Procedure: ETL_LoadProduct
-- Author: Kenny Byrkett
-- Created Date: 9/27/2024
--
-- This procedure loads and updates records from the Product
-- staging table to the ODS. 
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE ETL_LoadProduct
AS
BEGIN

	UPDATE [dbo].[Product]
		SET [ProductName] = [src_prod].[ProductName]
			,[Color] = [src_prod].[Color]
			,[Size] = [src_prod].[Size]
			,[QuantityPerUnit] = [src_prod].[QuantityPerUnit]
			,[WholesalePrice] = [src_prod].[WholesalePrice]
			,[UnitPrice] = [src_prod].[UnitPrice]
			,[UnitsInStock] = [src_prod].[UnitsInStock]
			,[UnitsOnOrder] = [src_prod].[UnitsOnOrder]
			,[Discontinued] = [src_prod].[Discontinued]
			,[Category] = [src_prod].[Category]
			,[CategoryDescription] = [src_prod].[CategoryDescription]
			,[ReorderLevel] = [src_prod].[ReorderLevel]
			,[BinLocation] = [src_prod].[BinLocation]
			,[Last_Update] = GETDATE()
		FROM [stg_Product] AS src_prod
		JOIN [dbo].[Product] AS tgt_prod
			ON [src_prod].[Product_Source_ID] = [tgt_prod].[Product_Source_ID]
			AND [src_prod].[Store_Source_ID] = [tgt_prod].[Store_Source_ID]
		WHERE NOT (ISNULL([src_prod].[ProductName], '') = ISNULL([tgt_prod].[ProductName], '')
			AND ISNULL([src_prod].[Color], '') = ISNULL([tgt_prod].[Color], '')
			AND ISNULL([src_prod].[Size], '') = ISNULL([tgt_prod].[Size], '')
			AND ISNULL([src_prod].[QuantityPerUnit], '') = ISNULL([tgt_prod].[QuantityPerUnit], '')
			AND ISNULL([src_prod].[WholesalePrice], 0) = ISNULL([tgt_prod].[WholesalePrice], 0)
			AND ISNULL([src_prod].[UnitPrice], 0) = ISNULL([tgt_prod].[UnitPrice], 0)
			AND ISNULL([src_prod].[UnitsInStock], -1) = ISNULL([tgt_prod].[UnitsInStock], -1)
			AND ISNULL([src_prod].[UnitsOnOrder], -1) = ISNULL([tgt_prod].[UnitsOnOrder], -1)
			AND ISNULL([src_prod].[Discontinued], 0) = ISNULL([tgt_prod].[Discontinued], 0)
			AND ISNULL([src_prod].[Category], '') = ISNULL([tgt_prod].[Category], '')
			AND ISNULL([src_prod].[CategoryDescription], '') = ISNULL([tgt_prod].[CategoryDescription], '')
			AND ISNULL([src_prod].[ReorderLevel], -1) = ISNULL([tgt_prod].[ReorderLevel], -1)
			AND ISNULL([src_prod].[BinLocation], '') = ISNULL([tgt_prod].[BinLocation], '')
			)

	INSERT INTO [dbo].[Product]
           ([Product_Source_ID]
           ,[ProductName]
           ,[ODS_Supplier_ID]
           ,[Color]
           ,[Size]
           ,[QuantityPerUnit]
           ,[WholesalePrice]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsOnOrder]
           ,[Discontinued]
           ,[Category]
           ,[CategoryDescription]
           ,[ReorderLevel]
           ,[BinLocation]
           ,[Store_Source_ID]
           ,[Created_Date]
           ,[Last_Update])

	SELECT DISTINCT [stg_prod].[Product_Source_ID]
			,[stg_prod].[ProductName]
			,[ods_sup].[ODS_Supplier_ID]
			,[stg_prod].[Color]
			,[stg_prod].[Size]
			,[stg_prod].[QuantityPerUnit]
			,[stg_prod].[WholesalePrice]
			,[stg_prod].[UnitPrice]
			,ISNULL([stg_prod].[UnitsInStock], 0)
			,[stg_prod].[UnitsOnOrder]
			,[stg_prod].[Discontinued]
			,[stg_prod].[Category]
			,[stg_prod].[CategoryDescription]
			,[stg_prod].[ReorderLevel]
			,[stg_prod].[BinLocation]
			,[stg_prod].[Store_Source_ID]
			,GETDATE() AS [Created_Date]
			,GETDATE() AS [Last_Update]
	FROM [dbo].[stg_Product] AS stg_prod
	LEFT JOIN [dbo].[Product] AS ods_prod
		ON [ods_prod].[Product_Source_ID] = [stg_prod].[Product_Source_ID]
		AND [ods_prod].[Store_Source_ID] = [stg_prod].[Store_Source_ID]
	JOIN [dbo].[Supplier] AS ods_sup
		ON [stg_prod].[Supplier_Source_ID] = [ods_sup].[Supplier_Source_ID]
		AND [stg_prod].[Store_Source_ID] = [ods_sup].[Store_Source_ID]
	WHERE [ods_prod].[ODS_Product_ID] IS NULL

END
