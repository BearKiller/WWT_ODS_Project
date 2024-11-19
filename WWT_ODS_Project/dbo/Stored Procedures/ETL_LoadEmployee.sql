--==============================================================
-- Stored Procedure: ETL_LoadEmployee
-- Author: Kenny Byrkett
-- Created Date: 9/19/2024
--
-- This procedure loads and updates records from the Employee
-- staging table to the ODS. No deletes.
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE ETL_LoadEmployee
AS
BEGIN

	UPDATE [dbo].[Employee]
		SET [FirstName] = [src_emp].[FirstName]
           ,[LastName] = [src_emp].[LastName]
           ,[Title] = [src_emp].[Title]
           ,[Email] = [src_emp].[Email]
           ,[PhoneNumber] = [src_emp].[PhoneNumber]
           ,[Extension] = [src_emp].[Extension]
           ,[JobTitle] = [src_emp].[JobTitle]
           ,[TerminationDate] = [src_emp].[TerminationDate]
           ,[Address] = [src_emp].[Address]
           ,[City] = [src_emp].[City]
           ,[StateOrRegion] = [src_emp].[StateOrRegion]
           ,[ZipCode] = [src_emp].[ZipCode]
           ,[Country] = [src_emp].[Country]
           ,[Notes] = [src_emp].[Notes]
           ,[ReportsTo] = [src_emp].[ReportsTo]
		   ,[Last_Update] = GETDATE()
		FROM [stg_Employee] AS src_emp
		JOIN [dbo].[Employee] AS tgt_emp
			ON [src_emp].[Email] = [tgt_emp].[Email]
		WHERE NOT (ISNULL([src_emp].[FirstName], '') = ISNULL([tgt_emp].[FirstName], '')
			AND ISNULL([src_emp].[LastName], '') = ISNULL([tgt_emp].[LastName], '')
			AND ISNULL([src_emp].[Title], '') = ISNULL([src_emp].[Title], '')
			AND ISNULL([src_emp].[Email], '') = ISNULL([tgt_emp].[Email], '')
			AND ISNULL([src_emp].[PhoneNumber], '') = ISNULL([tgt_emp].[PhoneNumber], '')
			AND ISNULL([src_emp].[Extension], 555) = ISNULL([tgt_emp].[Extension], 555)
			AND ISNULL([src_emp].[JobTitle], '') = ISNULL([tgt_emp].[JobTitle], '')
			AND ISNULL([src_emp].[TerminationDate], '1001-01-01') = ISNULL([tgt_emp].[TerminationDate], '1001-01-01')
			AND ISNULL([src_emp].[Address], '') = ISNULL([tgt_emp].[Address], '')
			AND ISNULL([src_emp].[City], '') = ISNULL([tgt_emp].[City], '')
			AND ISNULL([src_emp].[StateOrRegion], '') = ISNULL([tgt_emp].[StateOrRegion], '')
			AND ISNULL([src_emp].[ZipCode], 99999) = ISNULL([tgt_emp].[ZipCode], 99999)
			AND ISNULL([src_emp].[Country], '') = ISNULL([tgt_emp].[Country], '')
			AND ISNULL([src_emp].[Notes], '') = ISNULL([tgt_emp].[Notes], '')
			AND ISNULL([src_emp].[ReportsTo], '') = ISNULL([tgt_emp].[ReportsTo], '')
			)

		INSERT INTO [dbo].[Employee] ([Employee_Source_ID]
		   ,[FirstName]
           ,[LastName]
           ,[Title]
           ,[IsActive]
           ,[Email]
           ,[PhoneNumber]
           ,[Extension]
           ,[JobTitle]
           ,[BirthDate]
           ,[HireDate]
           ,[TerminationDate]
           ,[Address]
           ,[City]
           ,[StateOrRegion]
           ,[ZipCode]
           ,[Country]
           ,[Notes]
           ,[ReportsTo]
           ,[Store_Source_ID]
           ,[Created_Date]
           ,[Last_Update])
     SELECT DISTINCT [src_emp].[Employee_Source_ID]
	 ,[src_emp].[FirstName]
	 ,[src_emp].[LastName]
	 ,[src_emp].[Title]
	 ,ISNULL([src_emp].[IsActive], IIF([src_emp].[TerminationDate] IS NULL, 1, 0))
	 ,[src_emp].[Email]
	 ,[src_emp].[PhoneNumber]
	 ,[src_emp].[Extension]
	 ,[src_emp].[JobTitle]
	 ,[src_emp].[BirthDate]
	 ,[src_emp].[HireDate]
	 ,[src_emp].[TerminationDate]
	 ,[src_emp].[Address]
	 ,[src_emp].[City]
	 ,[src_emp].[StateOrRegion]
	 ,[src_emp].[ZipCode]
	 ,[src_emp].[Country]
	 ,[src_emp].[Notes]
	 ,[src_emp].[ReportsTo]
	 ,[src_emp].[Store_Source_ID]
	 ,GETDATE() AS Created_Date
	 ,GETDATE() AS Last_Update
	 FROM [stg_Employee] AS src_emp
	 LEFT JOIN [dbo].[Employee] AS tgt_emp
		ON [src_emp].[Email] = [tgt_emp].[Email]
		AND [src_emp].[Store_Source_ID] = [tgt_emp].[Store_Source_ID]
	 WHERE [tgt_emp].[ODS_Employee_ID] IS NULL
END
