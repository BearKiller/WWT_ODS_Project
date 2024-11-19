CREATE TABLE [dbo].[OrderDetail] (
    [OrderLine_Source_ID] INT             NULL,
    [ODS_Order_ID]        INT             NOT NULL,
    [ODS_Product_ID]      INT             NOT NULL,
    [Quantity]            INT             NOT NULL,
    [UnitPrice]           DECIMAL (12, 4) NULL,
    [Discount]            DECIMAL (12, 4) NULL,
    [TaxRate]             DECIMAL (12, 4) NULL,
    [ItemPickedDate]      DATE            NULL,
    [Store_Source_ID]     TINYINT         NULL,
    [Created_Date]        DATETIME        NULL,
    [Last_Update]         DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([ODS_Order_ID] ASC, [ODS_Product_ID] ASC),
    CONSTRAINT [FK_OrderDetail.ODS_Order_ID] FOREIGN KEY ([ODS_Order_ID]) REFERENCES [dbo].[Order] ([ODS_Order_ID]),
    CONSTRAINT [FK_OrderDetail.ODS_Product_ID] FOREIGN KEY ([ODS_Product_ID]) REFERENCES [dbo].[Product] ([ODS_Product_ID])
);

