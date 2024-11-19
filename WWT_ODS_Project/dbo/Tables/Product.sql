CREATE TABLE [dbo].[Product] (
    [ODS_Product_ID]      INT             IDENTITY (1, 1) NOT NULL,
    [Product_Source_ID]   INT             NOT NULL,
    [ProductName]         VARCHAR (100)   NOT NULL,
    [ODS_Supplier_ID]     SMALLINT        NULL,
    [Color]               VARCHAR (50)    NULL,
    [Size]                VARCHAR (50)    NULL,
    [QuantityPerUnit]     VARCHAR (20)    NULL,
    [WholesalePrice]      DECIMAL (12, 4) NULL,
    [UnitPrice]           DECIMAL (12, 4) NULL,
    [UnitsInStock]        INT             NULL,
    [UnitsOnOrder]        INT             NULL,
    [Discontinued]        BIT             NULL,
    [Category]            VARCHAR (30)    NULL,
    [CategoryDescription] VARCHAR (MAX)   NULL,
    [ReorderLevel]        INT             NULL,
    [BinLocation]         VARCHAR (50)    NULL,
    [Store_Source_ID]     TINYINT         NULL,
    [Created_Date]        DATETIME        NULL,
    [Last_Update]         DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([ODS_Product_ID] ASC),
    CONSTRAINT [FK_Product.ODS_Supplier_ID] FOREIGN KEY ([ODS_Supplier_ID]) REFERENCES [dbo].[Supplier] ([ODS_Supplier_ID])
);

