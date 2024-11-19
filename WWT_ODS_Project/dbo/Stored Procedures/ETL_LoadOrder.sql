
--==============================================================
-- Stored Procedure: ETL_LoadOrder
-- Author: Kenny Byrkett
-- Created Date: 10/7/2024
--
-- This procedure loads records from the Order staging table
-- to the ODS. Allows for updating shipping information and 
-- required dates.
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE ETL_LoadOrder
AS
BEGIN

	UPDATE [dbo].[Order]
		SET [RequiredDate] = [src_ord].[RequiredDate]
		,[ShipName] = [src_ord].[ShipName]
		,[ShipAddressLine1] = [src_ord].[ShipAddressLine1]
		,[ShipAddressLine2] = [src_ord].[ShipAddressLine2]
		,[ShipCity] = [src_ord].[ShipCity]
		,[ShipStateOrRegion] = [src_ord].[ShipStateOrRegion]
		,[ShipZipCode] = [src_ord].[ShipZipCode]
		,[ShipCountry] = [src_ord].[ShipCountry]
		,[Last_Update] = GETDATE()
		FROM [dbo].[stg_Order] AS src_ord
		JOIN [dbo].[Order] AS tgt_ord
			ON [src_ord].[Order_Source_ID] = [tgt_ord].[Order_Source_ID]
			AND [src_ord].[Store_Source_ID] = [tgt_ord].[Store_Source_ID]
		WHERE NOT (ISNULL([src_ord].[RequiredDate], '1111-01-01') = ISNULL([tgt_ord].[RequiredDate], '1111-01-01')
			AND ISNULL([src_ord].[ShipName], '') = ISNULL([tgt_ord].[ShipName], '')
			AND ISNULL([src_ord].[ShipAddressLine1], '') = ISNULL([tgt_ord].[ShipAddressLine1], '')
			AND ISNULL([src_ord].[ShipAddressLine2], '') = ISNULL([tgt_ord].[ShipAddressLine2], '')
			AND ISNULL([src_ord].[ShipCity], '') = ISNULL([tgt_ord].[ShipCity], '')
			AND ISNULL([src_ord].[ShipStateOrRegion], '') = ISNULL([tgt_ord].[ShipStateOrRegion], '')
			AND ISNULL([src_ord].[ShipZipCode], '') = ISNULL([tgt_ord].[ShipZipCode], '')
			AND ISNULL([src_ord].[ShipCountry], '') = ISNULL([tgt_ord].[ShipCountry], '')
			)

	INSERT INTO [dbo].[Order]
			   ([Order_Source_ID]
			   ,[ODS_Customer_ID]
			   ,[ODS_Employee_ID]
			   ,[OrderDate]
			   ,[ShipDate]
			   ,[RequiredDate]
			   ,[Freight]
			   ,[CustomerPurchaseOrderNumber]
			   ,[ShipName]
			   ,[ShipAddressLine1]
			   ,[ShipAddressLine2]
			   ,[ShipCity]
			   ,[ShipStateOrRegion]
			   ,[ShipZipCode]
			   ,[ShipCountry]
			   ,[Store_Source_ID]
			   ,[Created_Date]
			   ,[Last_Update])
		 SELECT [stg_ord].[Order_Source_ID]
			,[ods_cus].[ODS_Customer_ID]
			,[ods_emp].[ODS_Employee_ID]
			,[stg_ord].[OrderDate]
			,[stg_ord].[ShipDate]
			,[stg_ord].[RequiredDate]
			,[stg_ord].[Freight]
			,[stg_ord].[CustomerPurchaseOrderNumber]
			,[stg_ord].[ShipName]
			,[stg_ord].[ShipAddressLine1]
			,[stg_ord].[ShipAddressLine2]
			,[stg_ord].[ShipCity]
			,[stg_ord].[ShipStateOrRegion]
			,[stg_ord].[ShipZipCode]
			,[stg_ord].[ShipCountry]
			,[stg_ord].[Store_Source_ID]
			,GETDATE() AS [Created_Date]
			,GETDATE() AS [Last_Update]
		FROM [dbo].[stg_Order] AS stg_ord
		LEFT JOIN [dbo].[Order] AS ods_ord
			ON [stg_ord].[Order_Source_ID] = [ods_ord].[Order_Source_ID]
			AND [stg_ord].[Store_Source_ID] = [ods_ord].[Store_Source_ID]
		JOIN [dbo].[Customer_Lookup] AS ods_cus
			ON [ods_cus].[Customer_Source_ID] = [stg_ord].[Customer_Source_ID]
			AND [ods_cus].[Store_Source_ID] = [stg_ord].[Store_Source_ID]
		JOIN [dbo].[Employee] AS ods_emp
			ON [ods_emp].[Employee_Source_ID] = [stg_ord].[Employee_Source_ID]
			AND [ods_emp].[Store_Source_ID] = [stg_ord].[Store_Source_ID]
		WHERE [ods_ord].[ODS_Order_ID] IS NULL

END
