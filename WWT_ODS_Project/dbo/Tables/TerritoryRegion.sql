CREATE TABLE [dbo].[TerritoryRegion] (
    [TerritoryID]          CHAR (5)     NOT NULL,
    [TerritoryDescription] VARCHAR (50) NOT NULL,
    [RegionDescription]    VARCHAR (50) NULL,
    [Created_Date]         DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([TerritoryID] ASC)
);

