CREATE TABLE [dbo].[Candidate_Reg] (
    [C_Id]        INT          NOT NULL,
    [Name]        VARCHAR (20) NOT NULL,
    [Address]     VARCHAR (20) NOT NULL,
    [Contact_No]  NUMERIC (18) NOT NULL,
    [Image]       VARCHAR (50) NOT NULL,
    [Description] VARCHAR (50) NOT NULL,
    [Votes]       INT          NULL,
    [Password]    VARCHAR (50) NOT NULL,
    [O_id]        INT          NOT NULL,
    [Give_Vote]   VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([C_Id] ASC)
);

