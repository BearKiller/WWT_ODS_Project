--==============================================================
-- Stored Procedure: ODS_Bleach
-- Author: Kenny Byrkett
-- Created Date: 9/12/2024
--
-- This procedure deletes all ODS tables along with all records
-- within and recreates them. 
--
--= Changelog =--
-- 
--==============================================================

CREATE   PROCEDURE ODS_Bleach
AS
BEGIN

	DROP TABLE [OrderDetail]
	DROP TABLE [Order]
	DROP TABLE [Customer_Lookup]
	DROP TABLE [Customer]
	DROP TABLE [EmployeeTerritory]
	DROP TABLE [TerritoryRegion]
	DROP TABLE [Employee]
	DROP TABLE [Product]
	DROP TABLE [Supplier]

	CREATE TABLE [Supplier] (
	  [ODS_Supplier_ID] smallint IDENTITY(1,1) NOT NULL,
	  [Supplier_Source_ID] varchar(100) NOT NULL,
	  [SupplierName] varchar(100) NOT NULL,
	  [ContactName] varchar(50),
	  [ContactTitle] varchar(30),
	  [PhoneNumber] varchar(50),
	  [Fax] varchar(20),
	  [Website] varchar(256),
	  [AddressLine1] varchar(60),
	  [AddressLine2] varchar(60),
	  [City] varchar(50),
	  [StateOrRegion] varchar(50),
	  [Country] varchar(50),
	  [ZipCode] varchar(50),
	  [Store_Source_ID] tinyint,
	  [Created_Date] datetime,
	  [Last_Update] datetime,
	  PRIMARY KEY ([ODS_Supplier_ID])
	);

	CREATE TABLE [Product] (
	  [ODS_Product_ID] int IDENTITY(1,1) NOT NULL,
	  [Product_Source_ID] int NOT NULL,
	  [ProductName] varchar(100) NOT NULL,
	  [ODS_Supplier_ID] smallint,
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
	  [Last_Update] datetime,
	  PRIMARY KEY ([ODS_Product_ID]),
	  CONSTRAINT [FK_Product.ODS_Supplier_ID]
		FOREIGN KEY ([ODS_Supplier_ID])
		  REFERENCES [Supplier]([ODS_Supplier_ID])
	);

	CREATE TABLE [Employee] (
	  [ODS_Employee_ID] smallint IDENTITY(1,1) NOT NULL,
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
	  [Last_Update] datetime,
	  PRIMARY KEY ([ODS_Employee_ID])
	);

	CREATE TABLE [TerritoryRegion] (
	  [TerritoryID] char(5) NOT NULL,
	  [TerritoryDescription] varchar(50) NOT NULL,
	  [RegionDescription] varchar(50),
	  [Created_Date] datetime,
	  PRIMARY KEY ([TerritoryID])
	);

	CREATE TABLE [EmployeeTerritory] (
	  [ODS_Employee_ID] smallint NOT NULL,
	  [TerritoryID] char(5) NOT NULL,
	  [Created_Date] datetime,
	  PRIMARY KEY ([ODS_Employee_ID], [TerritoryID]),
	  CONSTRAINT [FK_EmployeeTerritories.ODS_Employee_ID]
		FOREIGN KEY ([ODS_Employee_ID])
		  REFERENCES [Employee]([ODS_Employee_ID]),
	  CONSTRAINT [FK_EmployeeTerritories.TerritoryID]
		FOREIGN KEY ([TerritoryID])
		  REFERENCES [TerritoryRegion]([TerritoryID])
	);

	CREATE TABLE [Customer] (
	  [ODS_Customer_ID] int IDENTITY(1,1) NOT NULL,
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
	  [Last_Update] datetime,
	  PRIMARY KEY ([ODS_Customer_ID])
	);

	CREATE TABLE [Customer_Lookup] (
	  [ODS_Customer_ID] int NOT NULL,
	  [Store_Source_ID] tinyint NOT NULL,
	  [Customer_Source_ID] varchar(50),
	  PRIMARY KEY ([ODS_Customer_ID], [Store_Source_ID]),
	  CONSTRAINT [FK_Customer_Lookup.ODS_Customer_ID]
		FOREIGN KEY ([ODS_Customer_ID])
		  REFERENCES [Customer]([ODS_Customer_ID])
	);

	CREATE TABLE [Order] (
	  [ODS_Order_ID] int IDENTITY(1,1) NOT NULL,
	  [Order_Source_ID] int NOT NULL,
	  [ODS_Customer_ID] int NOT NULL,
	  [ODS_Employee_ID] smallint NOT NULL,
	  [OrderDate] date NOT NULL,
	  [ShipDate] date,
	  [RequiredDate] date,
	  [Freight] money,
	  [CustomerPurchaseOrderNumber] varchar(40),
	  [ShipName] varchar(40),
	  [ShipAddressLine1] varchar(60),
	  [ShipAddressLine2] varchar(60),
	  [ShipCity] varchar(50),
	  [ShipStateOrRegion] varchar(50),
	  [ShipZipCode] varchar(50),
	  [ShipCountry] varchar(15),
	  [Store_Source_ID] tinyint,
	  [Created_Date] datetime,
	  [Last_Update] datetime,
	  PRIMARY KEY ([ODS_Order_ID]),
	  CONSTRAINT [FK_Order.ODS_Employee_ID]
		FOREIGN KEY ([ODS_Employee_ID])
		  REFERENCES [Employee]([ODS_Employee_ID]),
	  CONSTRAINT [FK_Order.ODS_Customer_ID]
		FOREIGN KEY ([ODS_Customer_ID])
		  REFERENCES [Customer]([ODS_Customer_ID])
	);

	CREATE TABLE [OrderDetail] (
	  [OrderLine_Source_ID] int,
	  [ODS_Order_ID] int NOT NULL,
	  [ODS_Product_ID] int NOT NULL,
	  [Quantity] int NOT NULL,
	  [UnitPrice] decimal(12,4),
	  [Discount] decimal(12,4),
	  [TaxRate] decimal(12,4),
	  [ItemPickedDate] date,
	  [Store_Source_ID] tinyint,
	  [Created_Date] datetime,
	  [Last_Update] datetime,
	  PRIMARY KEY ([ODS_Order_ID], [ODS_Product_ID]),
	  CONSTRAINT [FK_OrderDetail.ODS_Order_ID]
		FOREIGN KEY ([ODS_Order_Id])
		  REFERENCES [Order]([ODS_Order_ID]),
	  CONSTRAINT [FK_OrderDetail.ODS_Product_ID]
		FOREIGN KEY ([ODS_Product_ID])
		  REFERENCES [Product]([ODS_Product_ID])
	);

END