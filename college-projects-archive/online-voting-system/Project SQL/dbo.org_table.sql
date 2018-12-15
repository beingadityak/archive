CREATE TABLE [dbo].[org_table] (
    [O_Id]      INT           IDENTITY (1, 1) NOT NULL,
    [Name]      VARCHAR (100) NOT NULL,
    [Address]   VARCHAR (255) NOT NULL,
    [City]      VARCHAR (100) NOT NULL,
    [Email]     VARCHAR (255) NOT NULL,
    [User_Name] VARCHAR (20)  NOT NULL,
    [Password]  VARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([O_Id] ASC)
);

