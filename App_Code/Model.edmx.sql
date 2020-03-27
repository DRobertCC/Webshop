
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 09/26/2014 00:38:03
-- Generated from EDMX file: C:\Users\Michiel\Desktop\GarageManagerAsp - 3\App_Code\Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Garage];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Cart_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Cart] DROP CONSTRAINT [FK_Cart_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_Product_ProductTypes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_ProductTypes];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Cart]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Cart];
GO
IF OBJECT_ID(N'[dbo].[Product]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Product];
GO
IF OBJECT_ID(N'[dbo].[ProductTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductTypes];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Carts'
CREATE TABLE [dbo].[Carts] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [ClientID] nvarchar(255)  NOT NULL,
    [ProductID] int  NOT NULL,
    [Amount] int  NOT NULL,
    [DatePurchased] datetime  NULL,
    [IsInCart] bit  NOT NULL
);
GO

-- Creating table 'Products'
CREATE TABLE [dbo].[Products] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [TypeID] int  NOT NULL,
    [Name] nvarchar(255)  NOT NULL,
    [Price] float  NOT NULL,
    [Description] varchar(max)  NULL,
    [Image] nvarchar(255)  NULL
);
GO

-- Creating table 'ProductTypes'
CREATE TABLE [dbo].[ProductTypes] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(255)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'Carts'
ALTER TABLE [dbo].[Carts]
ADD CONSTRAINT [PK_Carts]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'ProductTypes'
ALTER TABLE [dbo].[ProductTypes]
ADD CONSTRAINT [PK_ProductTypes]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [ProductID] in table 'Carts'
ALTER TABLE [dbo].[Carts]
ADD CONSTRAINT [FK_Cart_Product]
    FOREIGN KEY ([ProductID])
    REFERENCES [dbo].[Products]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Cart_Product'
CREATE INDEX [IX_FK_Cart_Product]
ON [dbo].[Carts]
    ([ProductID]);
GO

-- Creating foreign key on [TypeID] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_Product_ProductTypes]
    FOREIGN KEY ([TypeID])
    REFERENCES [dbo].[ProductTypes]
        ([ID])
    ON DELETE CASCADE ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Product_ProductTypes'
CREATE INDEX [IX_FK_Product_ProductTypes]
ON [dbo].[Products]
    ([TypeID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------