CREATE TABLE [dbo].[UserInformation]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [GUID] NVARCHAR(50) NOT NULL, 
    [FirstName] NVARCHAR(50) NOT NULL, 
    [LastName] NVARCHAR(50) NOT NULL, 
    [Address] NVARCHAR(150) NOT NULL, 
    [PostalCode] INT NOT NULL
)
