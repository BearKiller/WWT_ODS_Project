CREATE TABLE [dbo].[EmployeeTerritory] (
    [ODS_Employee_ID] SMALLINT NOT NULL,
    [TerritoryID]     CHAR (5) NOT NULL,
    [Created_Date]    DATETIME NULL,
    PRIMARY KEY CLUSTERED ([ODS_Employee_ID] ASC, [TerritoryID] ASC),
    CONSTRAINT [FK_EmployeeTerritories.ODS_Employee_ID] FOREIGN KEY ([ODS_Employee_ID]) REFERENCES [dbo].[Employee] ([ODS_Employee_ID]),
    CONSTRAINT [FK_EmployeeTerritories.TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [dbo].[TerritoryRegion] ([TerritoryID])
);

