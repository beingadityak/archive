CREATE TABLE [dbo].[login] (
    [Name]       VARCHAR (50) NULL,
    [Password]   VARCHAR (50) NULL,
    [login_type] VARCHAR (60) NULL,
    [Id]         VARCHAR (10) NULL,
    CHECK ([login_type]='Candidate' OR [login_type]='Voter' OR [login_type]='Organization')
);

