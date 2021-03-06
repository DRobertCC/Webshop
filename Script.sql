USE [Garage]
GO
DROP TABLE IF EXISTS [dbo].[Cart]
GO
DROP TABLE IF EXISTS [dbo].[UserInformation]
GO
DROP TABLE IF EXISTS [dbo].[Product]
GO
DROP TABLE IF EXISTS [dbo].[ProductType]
GO
/****** Object:  Table [dbo].[UserInformation]    Script Date: 26-Mar-20 2:54:24 PM ******/
CREATE TABLE [dbo].[UserInformation]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [GUID] NVARCHAR(50) NOT NULL, 
    [FirstName] NVARCHAR(50) NOT NULL, 
    [LastName] NVARCHAR(50) NOT NULL, 
    [Address] NVARCHAR(150) NOT NULL, 
    [PostalCode] INT NOT NULL
)
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 26-Mar-20 2:54:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [nvarchar](255) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[DatePurchased] [datetime] NULL,
	[IsInCart] [bit] NOT NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 26-Mar-20 2:54:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeID] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Price] [float] NOT NULL,
	[Description] [varchar](max) NULL,
	[Image] [nvarchar](255) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 26-Mar-20 2:54:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_ProductTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--GO
--SET IDENTITY_INSERT [dbo].[Cart] ON 

--GO
--INSERT [dbo].[Cart] ([ID], [ClientID], [ProductID], [Amount], [DatePurchased], [IsInCart]) VALUES (1, N'1', 11, 1, CAST(0x0000A3B2001055B1 AS DateTime), 1)
--GO
--INSERT [dbo].[Cart] ([ID], [ClientID], [ProductID], [Amount], [DatePurchased], [IsInCart]) VALUES (2, N'1', 12, 5, CAST(0x0000A3B200E9BDF0 AS DateTime), 1)
--GO
--SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

GO
INSERT [dbo].[Product] ([ID], [TypeID], [Name], [Price], [Description], [Image]) VALUES (11, 10, N'Brake Discs', 100, N'A major component of your cars braking system', N'BrakeDiscs.jpg')
GO
INSERT [dbo].[Product] ([ID], [TypeID], [Name], [Price], [Description], [Image]) VALUES (12, 4, N'Cylinder Heads', 150, N'The cylinder head is the metal casing which covers the engine. It seals the main cylinders of the engine and prevents oil and other substances from finding their way inside. It also contains a number of valves vital to the engine. Internally the cylinder head has passages called ports for the fuel / air mixture to travel to the inlet valves from the intake manifold, for exhaust gases to travel from the exhaust valves to the exhaust manifold and for antifreeze to cool the head and engine.', N'Cylinder Heads.jpg')
GO
INSERT [dbo].[Product] ([ID], [TypeID], [Name], [Price], [Description], [Image]) VALUES (13, 5, N'Shock Absorbers', 100, N'The shock absorber is a vital part of the vehicle suspension, its prime function is to keep your wheels in contact with the ground at all times by absorbing the energy from the coil spring.', N'Shock Absorbers.jpg')
GO
INSERT [dbo].[Product] ([ID], [TypeID], [Name], [Price], [Description], [Image]) VALUES (15, 6, N'Clutch kits', 100, N'Your engine is constantly on the go, constantly spinning. The clutch is the system by which the engine is engaged and the car drives. It is the job of the clutch to create a smooth engagement between the engine and a non-spinning transmission.', N'Clutch kits.jpg')
GO
INSERT [dbo].[Product] ([ID], [TypeID], [Name], [Price], [Description], [Image]) VALUES (16, 7, N'Fans & Parts', 25, N'Car Fans help to maintain the comfortable temperature inside the car. Their maintenance requires various car fan parts like car fan coupling, fan blade, car fan switches and many more. ', N'Fans.jpg')
GO
INSERT [dbo].[Product] ([ID], [TypeID], [Name], [Price], [Description], [Image]) VALUES (17, 8, N'Car Battery', 100, N'The main function of a car battery is to supply electricity to various car systems. It powers the starting system through the starter motor and the ignition system. It also provides energy for the lights. In older cars, leaving car lights on was a sure way to run down the energy in car battery, but in modern cars an alarm system prevents you from doing this. If you keep your car long enough, you will probably have to replace the battery at some point.', N'Car Battery.jpg')
GO
INSERT [dbo].[Product] ([ID], [TypeID], [Name], [Price], [Description], [Image]) VALUES (18, 9, N'Body Panels', 100, N'A body panel refers to a part of the car body such as a rear wing, a front wing or a bonnet. ', N'Body Panels.jpg')
GO
INSERT [dbo].[Product] ([ID], [TypeID], [Name], [Price], [Description], [Image]) VALUES (19, 2, N'Engine Oil', 50, N'Engine oil is the life blood of your car. It is a vital component of the engine system, lubricating moving parts and ensuring your car has a long and happy life. The grade and type of oil you use can also impact your car economy and emissions, so it is essential that you use the correct grade of oil.', N'Engine Oil.jpg')
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductType] ON 

GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (1, N'Brakes')
GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (2, N'Lubricants & Fluids')
GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (3, N'Cleaning')
GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (4, N'Engine Parts')
GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (5, N'Suspension')
GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (6, N'Transmission')
GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (7, N'Cooling & Heating')
GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (8, N'Electrical')
GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (9, N'Body & Exhaust')
GO
INSERT [dbo].[ProductType] ([ID], [Name]) VALUES (10, N'Accessories')
GO
SET IDENTITY_INSERT [dbo].[ProductType] OFF
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductTypes] FOREIGN KEY([TypeID])
REFERENCES [dbo].[ProductType] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductTypes]
GO
