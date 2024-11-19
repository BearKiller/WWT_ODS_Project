CREATE TABLE [dbo].[stg_TerritoryRegion] (
    [TerritoryID]          CHAR (5)     NOT NULL,
    [Employee_Source_ID]   SMALLINT     NULL,
    [TerritoryDescription] VARCHAR (50) NULL,
    [RegionDescription]    VARCHAR (50) NULL,
    [Created_Date]         DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([TerritoryID] ASC)
);

