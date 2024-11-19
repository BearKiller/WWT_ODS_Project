CREATE TABLE [dbo].[Supplier] (
    [ODS_Supplier_ID]    SMALLINT      IDENTITY (1, 1) NOT NULL,
    [Supplier_Source_ID] VARCHAR (100) NOT NULL,
    [SupplierName]       VARCHAR (100) NOT NULL,
    [ContactName]        VARCHAR (50)  NULL,
    [ContactTitle]       VARCHAR (30)  NULL,
    [PhoneNumber]        VARCHAR (50)  NULL,
    [Fax]                VARCHAR (20)  NULL,
    [Website]            VARCHAR (256) NULL,
    [AddressLine1]       VARCHAR (60)  NULL,
    [AddressLine2]       VARCHAR (60)  NULL,
    [City]               VARCHAR (50)  NULL,
    [StateOrRegion]      VARCHAR (50)  NULL,
    [Country]            VARCHAR (50)  NULL,
    [ZipCode]            VARCHAR (50)  NULL,
    [Store_Source_ID]    TINYINT       NULL,
    [Created_Date]       DATETIME      NULL,
    [Last_Update]        DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([ODS_Supplier_ID] ASC)
);

