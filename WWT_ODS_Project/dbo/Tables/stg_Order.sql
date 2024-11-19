CREATE TABLE [dbo].[stg_Order] (
    [Order_Source_ID]             INT          NOT NULL,
    [Customer_Source_ID]          VARCHAR (50) NOT NULL,
    [Employee_Source_ID]          VARCHAR (50) NOT NULL,
    [OrderDate]                   DATE         NOT NULL,
    [ShipDate]                    DATE         NULL,
    [RequiredDate]                DATE         NULL,
    [Freight]                     MONEY        NULL,
    [CustomerPurchaseOrderNumber] VARCHAR (50) NULL,
    [ShipCompany]                 VARCHAR (40) NULL,
    [ShipName]                    VARCHAR (40) NULL,
    [ShipAddressLine1]            VARCHAR (60) NULL,
    [ShipAddressLine2]            VARCHAR (60) NULL,
    [ShipCity]                    VARCHAR (50) NULL,
    [ShipStateOrRegion]           VARCHAR (50) NULL,
    [ShipZipCode]                 VARCHAR (50) NULL,
    [ShipCountry]                 VARCHAR (15) NULL,
    [Store_Source_ID]             TINYINT      NULL,
    [Created_Date]                DATETIME     NULL,
    [Last_Update]                 DATETIME     NULL
);

