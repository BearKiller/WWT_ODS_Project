CREATE TABLE [dbo].[stg_OrderDetail] (
    [OrderLine_Source_ID] INT             NULL,
    [Order_Source_ID]     INT             NOT NULL,
    [Product_Source_ID]   INT             NOT NULL,
    [Quantity]            INT             NULL,
    [UnitPrice]           DECIMAL (12, 4) NULL,
    [Discount]            DECIMAL (12, 4) NULL,
    [TaxRate]             DECIMAL (12, 4) NULL,
    [ItemPickedDate]      DATE            NULL,
    [Store_Source_ID]     TINYINT         NULL,
    [Created_Date]        DATETIME        NULL,
    [Last_Update]         DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([Order_Source_ID] ASC, [Product_Source_ID] ASC)
);

