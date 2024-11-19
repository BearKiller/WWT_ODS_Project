CREATE TABLE [dbo].[stg_Customer] (
    [Store_Source_ID]         TINYINT       DEFAULT ((0)) NULL,
    [Customer_Source_ID]      VARCHAR (50)  NULL,
    [CustomerName]            VARCHAR (100) NOT NULL,
    [PhoneNumber]             VARCHAR (50)  NULL,
    [Fax]                     VARCHAR (50)  NULL,
    [ContactName]             VARCHAR (50)  NULL,
    [ContactTitle]            VARCHAR (30)  NULL,
    [CustomerKeyStandardized] CHAR (5)      NULL,
    [AddressLine1]            VARCHAR (60)  NULL,
    [AddressLine2]            VARCHAR (60)  NULL,
    [City]                    VARCHAR (50)  NULL,
    [State]                   CHAR (2)      NULL,
    [ZipCode]                 VARCHAR (50)  NULL,
    [Region]                  VARCHAR (15)  NULL,
    [Country]                 VARCHAR (15)  NULL,
    [Created_Date]            DATETIME      NULL,
    [Last_Update]             DATETIME      NULL
);

