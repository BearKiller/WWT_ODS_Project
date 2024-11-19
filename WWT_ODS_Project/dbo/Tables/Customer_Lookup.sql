CREATE TABLE [dbo].[Customer_Lookup] (
    [ODS_Customer_ID]    INT          NOT NULL,
    [Store_Source_ID]    TINYINT      NOT NULL,
    [Customer_Source_ID] VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([ODS_Customer_ID] ASC, [Store_Source_ID] ASC),
    CONSTRAINT [FK_Customer_Lookup.ODS_Customer_ID] FOREIGN KEY ([ODS_Customer_ID]) REFERENCES [dbo].[Customer] ([ODS_Customer_ID])
);

