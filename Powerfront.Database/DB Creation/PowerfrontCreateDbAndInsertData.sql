USE [master]
GO

/****** Object:  Database [Powerfront]    Script Date: 08/09/2016 10:48:30 ******/
DROP DATABASE [Powerfront]
GO

/****** Object:  Database [Powerfront]    Script Date: 08/09/2016 10:48:30 ******/
CREATE DATABASE [Powerfront]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Powerfront', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Powerfront.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Powerfront_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Powerfront_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [Powerfront] SET COMPATIBILITY_LEVEL = 110
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Powerfront].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Powerfront] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Powerfront] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Powerfront] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Powerfront] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Powerfront] SET ARITHABORT OFF 
GO

ALTER DATABASE [Powerfront] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Powerfront] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [Powerfront] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Powerfront] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Powerfront] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Powerfront] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Powerfront] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Powerfront] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Powerfront] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Powerfront] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Powerfront] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Powerfront] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Powerfront] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Powerfront] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Powerfront] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Powerfront] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Powerfront] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Powerfront] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Powerfront] SET RECOVERY FULL 
GO

ALTER DATABASE [Powerfront] SET  MULTI_USER 
GO

ALTER DATABASE [Powerfront] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Powerfront] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Powerfront] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Powerfront] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [Powerfront] SET  READ_WRITE 
GO




USE [Powerfront]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 09/09/2016 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[TypeId] [varchar](255) NOT NULL,
	[PropertyId] [varchar](255) NOT NULL,
	[Value] [varchar](255) NOT NULL,
	[CustomerId] [varchar](255) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Property]    Script Date: 09/09/2016 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Property](
	[PropertyId] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_AttributeId] PRIMARY KEY CLUSTERED 
(
	[PropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Type]    Script Date: 09/09/2016 14:42:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Type](
	[TypeId] [varchar](255) NOT NULL,
	[Name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_EntityId] PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customers] ([TypeId], [PropertyId], [Value], [CustomerId]) VALUES (N'1', N'1', N'Hadar', N'1')
INSERT [dbo].[Customers] ([TypeId], [PropertyId], [Value], [CustomerId]) VALUES (N'1', N'2', N'47', N'1')
INSERT [dbo].[Customers] ([TypeId], [PropertyId], [Value], [CustomerId]) VALUES (N'1', N'1', N'Greg', N'2')
INSERT [dbo].[Customers] ([TypeId], [PropertyId], [Value], [CustomerId]) VALUES (N'1', N'2', N'38', N'2')
INSERT [dbo].[Customers] ([TypeId], [PropertyId], [Value], [CustomerId]) VALUES (N'1', N'1', N'Michael', N'3')
INSERT [dbo].[Customers] ([TypeId], [PropertyId], [Value], [CustomerId]) VALUES (N'1', N'2', N'45', N'3')
INSERT [dbo].[Property] ([PropertyId], [Name]) VALUES (N'1', N'Name')
INSERT [dbo].[Property] ([PropertyId], [Name]) VALUES (N'2', N'Age')
INSERT [dbo].[Type] ([TypeId], [Name]) VALUES (N'1', N'Customer')
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_PropertyId] FOREIGN KEY([PropertyId])
REFERENCES [dbo].[Property] ([PropertyId])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_PropertyId]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_TypeId] FOREIGN KEY([TypeId])
REFERENCES [dbo].[Type] ([TypeId])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_TypeId]
GO
