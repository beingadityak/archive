CREATE TABLE [dbo].[Result] (
    [R_Id]       INT IDENTITY (1, 1) NOT NULL,
    [Total_Vote] INT NOT NULL,
    [O_Id]       INT NOT NULL,
    [C_Id]       INT NOT NULL,
    PRIMARY KEY CLUSTERED ([R_Id] ASC)
);

