
--==============================================================
-- Stored Procedure: ETL_LoadOrderDetail
-- Author: Kenny Byrkett
-- Created Date: 10/7/2024
--
-- This procedure loads records from the OrderDetail staging table
-- to the ODS.
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE ETL_LoadOrderDetail
AS
BEGIN

	UPDATE [dbo].[OrderDetail]
		SET [Quantity] = [src_ord].[Quantity]
			,[UnitPrice] = [src_ord].[UnitPrice]
			,[Discount] = [src_ord].[Discount]
			,[TaxRate] = [src_ord].[TaxRate]
			,[Last_Update] = GETDATE()
		FROM [dbo].[stg_OrderDetail] AS src_ord
		JOIN [dbo].[OrderDetail] AS tgt_ord
			ON [src_ord].[OrderLine_Source_ID] = [tgt_ord].[OrderLine_Source_ID]
			AND [src_ord].[Store_Source_ID] = [tgt_ord].[Store_Source_ID]
		WHERE NOT (ISNULL([src_ord].[Quantity], -1.0000) = ISNULL([tgt_ord].[Quantity], -1.0000)
			AND ISNULL([src_ord].[UnitPrice], -1.0000) = ISNULL([tgt_ord].[UnitPrice], -1.0000)
			AND ISNULL([src_ord].[Discount], -1.0000) = ISNULL([tgt_ord].[Discount], -1.0000)
			AND ISNULL([src_ord].[TaxRate], -1.0000) = ISNULL([tgt_ord].[TaxRate], -1.0000)
			)

	INSERT INTO [dbo].[OrderDetail]
           ([OrderLine_Source_ID]
           ,[ODS_Order_ID]
           ,[ODS_Product_ID]
           ,[Quantity]
           ,[UnitPrice]
           ,[Discount]
           ,[TaxRate]
           ,[ItemPickedDate]
           ,[Store_Source_ID]
           ,[Created_Date]
           ,[Last_Update])
		SELECT [stg_ord].[OrderLine_Source_ID]
			,[ods_or].[ODS_Order_ID]
			,[ods_prod].[ODS_Product_ID]
			,[stg_ord].[Quantity]
			,ISNULL([stg_ord].[UnitPrice], 0.0000)
			,ISNULL([stg_ord].[Discount], 0.0000)
			,ISNULL([stg_ord].[TaxRate], 0.0000)
			,[stg_ord].[ItemPickedDate]
			,[stg_ord].[Store_Source_ID]
			,GETDATE() AS [Created_Date]
			,GETDATE() AS [Last_Update]
		FROM [dbo].[stg_OrderDetail] AS stg_ord
		LEFT JOIN [dbo].[OrderDetail] AS ods_ord
			ON [stg_ord].[OrderLine_Source_ID] = [ods_ord].[OrderLine_Source_ID]
			AND [stg_ord].[Store_Source_ID] = [ods_ord].[Store_Source_ID]
		JOIN [dbo].[Product] AS ods_prod
			ON [ods_prod].[Product_Source_ID] = [stg_ord].[Product_Source_ID]
			AND [ods_prod].[Store_Source_ID] = [stg_ord].[Store_Source_ID]
		JOIN [dbo].[Order] AS ods_or
			ON [ods_or].[Order_Source_ID] = [stg_ord].[Order_Source_ID]
			AND [ods_or].[Store_Source_ID] = [stg_ord].[Store_Source_ID]
		WHERE NOT EXISTS (
			SELECT 1
			FROM [dbo].[OrderDetail] AS od
			WHERE [od].[ODS_Product_ID] = [ods_prod].[ODS_Product_ID]
			  AND [od].[ODS_Order_ID] = [ods_or].[ODS_Order_ID]
			)

END
