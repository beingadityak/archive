CREATE TABLE [dbo].[voter_reg] (
    [V_Id]      INT           IDENTITY (1, 1) NOT NULL,
    [name]      VARCHAR (20)  NOT NULL,
    [city]      VARCHAR (20)  NOT NULL,
    [username]  VARCHAR (20)  NOT NULL,
    [password]  VARCHAR (MAX) NOT NULL,
    [image_url] VARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([V_Id] ASC)
);

