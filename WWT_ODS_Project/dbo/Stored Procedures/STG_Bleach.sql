--==============================================================
-- Stored Procedure: STG_Bleach
-- Author: Kenny Byrkett
-- Created Date: 9/21/2024
--
-- This procedure deletes all staging tables along with all records
-- within and recreates them. 
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE STG_Bleach
AS
BEGIN

	DROP TABLE [stg_OrderDetail]
	DROP TABLE [stg_Order]
	DROP TABLE [stg_Customer]
	DROP TABLE [stg_TerritoryRegion]
	DROP TABLE [stg_Employee]
	DROP TABLE [stg_Product]
	DROP TABLE [stg_Supplier]

	CREATE TABLE [stg_Supplier] (
	  [Supplier_Source_ID] varchar(100) NOT NULL,
	  [SupplierName] varchar(100) NOT NULL,
	  [ContactName] varchar(50),
	  [ContactTitle] varchar(30),
	  [PhoneNumber] varchar(50),
	  [Fax] varchar(24),
	  [Website] varchar(256),
	  [AddressLine1] varchar(60),
	  [AddressLine2] varchar(60),
	  [City] varchar(50),
	  [StateOrRegion] varchar(50),
	  [Country] varchar(50),
	  [ZipCode] varchar(50),
	  [Store_Source_ID] tinyint,
	  [Created_Date] datetime,
	  [Last_Update] datetime
	);

	CREATE TABLE [stg_Product] (
	  [Product_Source_ID] int NOT NULL,
	  [ProductName] varchar(100) NOT NULL,
	  [Supplier_Source_ID] varchar(50),
	  [Color] varchar(50),
	  [Size] varchar(50),
	  [QuantityPerUnit] varchar(20),
	  [WholesalePrice] decimal(12,4),
	  [UnitPrice] decimal(12,4),
	  [UnitsInStock] int,
	  [UnitsOnOrder] int,
	  [Discontinued] bit,
	  [Category] varchar(30),
	  [CategoryDescription] varchar(MAX),
	  [ReorderLevel] int,
	  [BinLocation] varchar(50),
	  [Store_Source_ID] tinyint,
	  [Created_Date] datetime,
	  [Last_Update] datetime
	);

	CREATE TABLE [stg_Employee] (
	  [Employee_Source_ID] varchar(50) NOT NULL,
	  [FirstName] varchar(50) NOT NULL,
	  [LastName] varchar(50) NOT NULL,
	  [Title] varchar(25),
	  [IsActive] bit,
	  [Email] varchar(100),
	  [PhoneNumber] varchar(50),
	  [Extension] varchar(4),
	  [JobTitle] varchar(30),
	  [BirthDate] date,
	  [HireDate] date,
	  [TerminationDate] date,
	  [Address] varchar(60),
	  [City] varchar(15),
	  [StateOrRegion] varchar(15),
	  [ZipCode] varchar(10),
	  [Country] varchar(15),
	  [Notes] varchar(MAX),
	  [ReportsTo] int,
	  [Store_Source_ID] tinyint,
	  [Created_Date] datetime,
	  [Last_Update] datetime
	);

	CREATE TABLE [stg_TerritoryRegion] (
	  [TerritoryID] char(5) NOT NULL,
	  [Employee_Source_ID] smallint,
	  [TerritoryDescription] varchar(50),
	  [RegionDescription] varchar(50),
	  [Created_Date] datetime,
	  PRIMARY KEY ([TerritoryID])
	);

	CREATE TABLE [stg_Customer] (
	  [Store_Source_ID] tinyint DEFAULT 0,
	  [Customer_Source_ID] varchar(50),
	  [CustomerName] varchar(100) NOT NULL,
	  [PhoneNumber] varchar(50),
	  [Fax] varchar(50),
	  [ContactName] varchar(50),
	  [ContactTitle] varchar(30),
	  [CustomerKeyStandardized] char(5),
	  [AddressLine1] varchar(60),
	  [AddressLine2] varchar(60),
	  [City] varchar(50),
	  [State] char(2),
	  [ZipCode] varchar(50),
	  [Region] varchar(15),
	  [Country] varchar(15),
	  [Created_Date] datetime,
	  [Last_Update] datetime
	);

	CREATE TABLE [stg_Order] (
	  [Order_Source_ID] int NOT NULL,
	  [Customer_Source_ID] varchar(50) NOT NULL,
	  [Employee_Source_ID] varchar(50) NOT NULL,
	  [OrderDate] date NOT NULL,
	  [ShipDate] date,
	  [RequiredDate] date,
	  [Freight] money,
	  [CustomerPurchaseOrderNumber] varchar(50),
	  [ShipCompany] varchar(40),
	  [ShipName] varchar(40),
	  [ShipAddressLine1] varchar(60),
	  [ShipAddressLine2] varchar(60),
	  [ShipCity] varchar(50),
	  [ShipStateOrRegion] varchar(50),
	  [ShipZipCode] varchar(50),
	  [ShipCountry] varchar(15),
	  [Store_Source_ID] tinyint,
	  [Created_Date] datetime,
	  [Last_Update] datetime
	);

	CREATE TABLE [stg_OrderDetail] (
	  [OrderLine_Source_ID] int,
	  [Order_Source_ID] int,
	  [Product_Source_ID] int,
	  [Quantity] int,
	  [UnitPrice] decimal(12,4),
	  [Discount] decimal(12,4),
	  [TaxRate] decimal(12,4),
	  [ItemPickedDate] date,
	  [Store_Source_ID] tinyint,
	  [Created_Date] datetime,
	  [Last_Update] datetime,
	  PRIMARY KEY ([Order_Source_ID], [Product_Source_ID]),
	);

END