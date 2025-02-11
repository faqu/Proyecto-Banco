USE [master]
GO
/****** Object:  Database [ApiCuentasContables]    Script Date: 12/3/2023 12:47:47 PM ******/
CREATE DATABASE [ApiCuentasContables]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ApiCuentasContables', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ApiCuentasContables.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ApiCuentasContables_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ApiCuentasContables_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ApiCuentasContables] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ApiCuentasContables].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ApiCuentasContables] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET ARITHABORT OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ApiCuentasContables] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ApiCuentasContables] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ApiCuentasContables] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ApiCuentasContables] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET RECOVERY FULL 
GO
ALTER DATABASE [ApiCuentasContables] SET  MULTI_USER 
GO
ALTER DATABASE [ApiCuentasContables] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ApiCuentasContables] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ApiCuentasContables] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ApiCuentasContables] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ApiCuentasContables] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ApiCuentasContables] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ApiCuentasContables', N'ON'
GO
ALTER DATABASE [ApiCuentasContables] SET QUERY_STORE = ON
GO
ALTER DATABASE [ApiCuentasContables] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ApiCuentasContables]
GO
/****** Object:  User [Fabi]    Script Date: 12/3/2023 12:47:47 PM ******/
CREATE USER [Fabi] FOR LOGIN [Fabi] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Fabi]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [Fabi]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [Fabi]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [Fabi]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [Fabi]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Fabi]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Fabi]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [Fabi]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [Fabi]
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 12/3/2023 12:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[OperationType] [varchar](10) NULL,
	[id] [int] NULL,
	[numero_cuenta] [varchar](50) NULL,
	[tipo_cuenta] [varchar](50) NULL,
	[saldo] [decimal](18, 2) NULL,
	[propietario_nombre] [varchar](100) NULL,
	[fecha_apertura] [date] NULL,
	[estadocuenta] [varchar](50) NULL,
	[ChangeDateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaBancaria]    Script Date: 12/3/2023 12:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaBancaria](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[numero_cuenta] [varchar](20) NOT NULL,
	[tipo_cuenta] [int] NULL,
	[saldo] [decimal](10, 2) NOT NULL,
	[propietario_nombre] [varchar](100) NOT NULL,
	[fecha_apertura] [date] NOT NULL,
	[estadocuenta] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadoCuenta]    Script Date: 12/3/2023 12:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoCuenta](
	[IdEstadoCuenta] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_EstadoCuenta] [nvarchar](75) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEstadoCuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_Cuenta]    Script Date: 12/3/2023 12:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Cuenta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_De_Transaccion]    Script Date: 12/3/2023 12:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_De_Transaccion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tipo_trasaccion] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transacciones]    Script Date: 12/3/2023 12:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transacciones](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [int] NOT NULL,
	[monto] [decimal](10, 2) NOT NULL,
	[fecha_transaccion] [date] NOT NULL,
	[cuenta_origen_id] [int] NOT NULL,
	[cuenta_destino_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AuditLog] ON 

INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (1, N'INSERT', 1002, N'ABC123', N'1', CAST(1000.00 AS Decimal(18, 2)), N'John Doe', CAST(N'2023-01-01' AS Date), N'1', CAST(N'2023-11-19T14:05:22.660' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (2, N'INSERT', 1003, N'DEF456', N'3', CAST(500.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:05:22.673' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (3, N'INSERT', 1004, N'GHI789', N'1', CAST(7500.25 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:05:22.673' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (4, N'INSERT', 1005, N'JKL012', N'1002', CAST(12000.75 AS Decimal(18, 2)), N'Bob Williams', CAST(N'2023-04-20' AS Date), N'2', CAST(N'2023-11-19T14:05:22.677' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (5, N'INSERT', 1006, N'MNO345', N'1', CAST(300.50 AS Decimal(18, 2)), N'Eva Davis', CAST(N'2023-05-05' AS Date), N'1', CAST(N'2023-11-19T14:05:22.677' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (6, N'INSERT', 1007, N'PQR678', N'3', CAST(8000.00 AS Decimal(18, 2)), N'Charlie Brown', CAST(N'2023-06-15' AS Date), N'2', CAST(N'2023-11-19T14:05:22.680' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (7, N'INSERT', 1008, N'STU901', N'2', CAST(150.75 AS Decimal(18, 2)), N'Grace Taylor', CAST(N'2023-07-01' AS Date), N'1', CAST(N'2023-11-19T14:05:22.680' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (8, N'INSERT', 1009, N'VWX234', N'1002', CAST(950.00 AS Decimal(18, 2)), N'David Jones', CAST(N'2023-08-12' AS Date), N'2', CAST(N'2023-11-19T14:05:22.683' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (9, N'INSERT', 1010, N'YZA567', N'1', CAST(600.25 AS Decimal(18, 2)), N'Sophie Miller', CAST(N'2023-09-25' AS Date), N'1', CAST(N'2023-11-19T14:05:22.687' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (10, N'INSERT', 1011, N'BCD890', N'1002', CAST(2000.50 AS Decimal(18, 2)), N'Michael Davis', CAST(N'2023-10-05' AS Date), N'2', CAST(N'2023-11-19T14:05:22.687' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (11, N'INSERT', 1012, N'EFG123', N'2', CAST(1200.75 AS Decimal(18, 2)), N'Linda Garcia', CAST(N'2023-11-15' AS Date), N'1', CAST(N'2023-11-19T14:05:22.687' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (12, N'INSERT', 1013, N'HIJ456', N'3', CAST(500.00 AS Decimal(18, 2)), N'Peter Smith', CAST(N'2023-12-01' AS Date), N'2', CAST(N'2023-11-19T14:05:22.687' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (13, N'UPDATE', 1004, N'GHI789', N'1', CAST(6999.75 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:33:48.757' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (14, N'UPDATE', 1004, N'GHI789', N'1', CAST(6499.25 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:03.917' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (15, N'UPDATE', 1003, N'DEF456', N'3', CAST(1001.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:03.920' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (16, N'UPDATE', 1004, N'GHI789', N'1', CAST(5998.75 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:16.377' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (17, N'UPDATE', 1003, N'DEF456', N'3', CAST(1501.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:16.377' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (18, N'UPDATE', 1004, N'GHI789', N'1', CAST(5498.25 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:19.230' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (19, N'UPDATE', 1003, N'DEF456', N'3', CAST(2002.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:19.230' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (20, N'UPDATE', 1004, N'GHI789', N'1', CAST(4997.75 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:21.133' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (21, N'UPDATE', 1003, N'DEF456', N'3', CAST(2502.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:21.133' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (22, N'UPDATE', 1004, N'GHI789', N'1', CAST(4497.25 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:21.787' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (23, N'UPDATE', 1003, N'DEF456', N'3', CAST(3003.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:21.787' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (24, N'UPDATE', 1004, N'GHI789', N'1', CAST(3996.75 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:22.953' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (25, N'UPDATE', 1003, N'DEF456', N'3', CAST(3503.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:22.953' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (26, N'UPDATE', 1004, N'GHI789', N'1', CAST(3496.25 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:23.463' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (27, N'UPDATE', 1003, N'DEF456', N'3', CAST(4004.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:23.463' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (28, N'UPDATE', 1004, N'GHI789', N'1', CAST(2995.75 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:23.880' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (29, N'UPDATE', 1003, N'DEF456', N'3', CAST(4504.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:23.880' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (30, N'UPDATE', 1004, N'GHI789', N'1', CAST(2495.25 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:24.237' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (31, N'UPDATE', 1003, N'DEF456', N'3', CAST(5005.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:24.237' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (32, N'UPDATE', 1004, N'GHI789', N'1', CAST(1994.75 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:24.643' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (33, N'UPDATE', 1003, N'DEF456', N'3', CAST(5505.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:24.643' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (34, N'UPDATE', 1004, N'GHI789', N'1', CAST(1494.25 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:25.007' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (35, N'UPDATE', 1003, N'DEF456', N'3', CAST(6006.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:25.007' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (36, N'UPDATE', 1004, N'GHI789', N'1', CAST(993.75 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:25.390' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (37, N'UPDATE', 1003, N'DEF456', N'3', CAST(6506.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:25.390' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (38, N'UPDATE', 1004, N'GHI789', N'1', CAST(493.25 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-19T14:34:25.797' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (39, N'UPDATE', 1003, N'DEF456', N'3', CAST(7007.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:25.797' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (40, N'UPDATE', 1003, N'DEF456', N'3', CAST(7507.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:26.330' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (41, N'UPDATE', 1003, N'DEF456', N'3', CAST(8008.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:26.710' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (42, N'UPDATE', 1003, N'DEF456', N'3', CAST(8508.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:27.100' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (43, N'UPDATE', 1003, N'DEF456', N'3', CAST(9009.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:34:27.500' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (44, N'UPDATE', 1003, N'DEF456', N'3', CAST(9509.50 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:35:06.550' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (45, N'UPDATE', 1003, N'DEF456', N'3', CAST(10010.00 AS Decimal(18, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), N'2', CAST(N'2023-11-19T14:35:14.957' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (46, N'UPDATE', 1004, N'GHI789', N'1', CAST(593.25 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-26T13:50:13.000' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (47, N'UPDATE', 1004, N'GHI789', N'1', CAST(69138.75 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-11-26T13:50:59.527' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (48, N'INSERT', 1014, N'FAQ778', N'1', CAST(250.96 AS Decimal(18, 2)), N'FaQuGe', CAST(N'2023-11-27' AS Date), N'1', CAST(N'2023-11-26T18:58:36.147' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (49, N'UPDATE', 1014, N'FAQ778', N'1', CAST(4460.96 AS Decimal(18, 2)), N'FaQuGe', CAST(N'2023-11-27' AS Date), N'1', CAST(N'2023-12-03T10:43:05.233' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (50, N'UPDATE', 1002, N'ABC123', N'1', CAST(1041.20 AS Decimal(18, 2)), N'John Doe', CAST(N'2023-01-01' AS Date), N'1', CAST(N'2023-12-03T10:44:10.313' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (51, N'UPDATE', 1002, N'ABC123', N'1', CAST(1082.40 AS Decimal(18, 2)), N'John Doe', CAST(N'2023-01-01' AS Date), N'1', CAST(N'2023-12-03T11:02:20.050' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (52, N'UPDATE', 1002, N'ABC123', N'1', CAST(1000.40 AS Decimal(18, 2)), N'John Doe', CAST(N'2023-01-01' AS Date), N'1', CAST(N'2023-12-03T11:03:54.643' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (53, N'UPDATE', 1004, N'GHI789', N'1', CAST(69000.75 AS Decimal(18, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), N'1', CAST(N'2023-12-03T11:05:58.173' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (54, N'UPDATE', 1014, N'FAQ778', N'1', CAST(4400.96 AS Decimal(18, 2)), N'FaQuGe', CAST(N'2023-11-27' AS Date), N'1', CAST(N'2023-12-03T11:06:33.717' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (55, N'UPDATE', 1002, N'ABC123', N'1', CAST(900.40 AS Decimal(18, 2)), N'John Doe', CAST(N'2023-01-01' AS Date), N'1', CAST(N'2023-12-03T11:08:56.610' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (56, N'UPDATE', 1002, N'ABC123', N'1', CAST(1100.40 AS Decimal(18, 2)), N'John Doe', CAST(N'2023-01-01' AS Date), N'1', CAST(N'2023-12-03T11:17:04.333' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (57, N'UPDATE', 1002, N'ABC123', N'1', CAST(1000.40 AS Decimal(18, 2)), N'John Doe', CAST(N'2023-01-01' AS Date), N'1', CAST(N'2023-12-03T11:17:47.287' AS DateTime))
INSERT [dbo].[AuditLog] ([LogID], [OperationType], [id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta], [ChangeDateTime]) VALUES (58, N'INSERT', 1015, N'FAQ2112', N'1', CAST(122.00 AS Decimal(18, 2)), N'Fabian', CAST(N'2023-12-03' AS Date), N'1', CAST(N'2023-12-03T12:45:33.473' AS DateTime))
SET IDENTITY_INSERT [dbo].[AuditLog] OFF
GO
SET IDENTITY_INSERT [dbo].[CuentaBancaria] ON 

INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1002, N'ABC123', 1, CAST(1000.40 AS Decimal(10, 2)), N'John Doe', CAST(N'2023-01-01' AS Date), 1)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1003, N'DEF456', 3, CAST(10010.00 AS Decimal(10, 2)), N'Jane Smith', CAST(N'2023-02-15' AS Date), 2)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1004, N'GHI789', 1, CAST(69000.75 AS Decimal(10, 2)), N'Alice Johnson', CAST(N'2023-03-10' AS Date), 1)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1005, N'JKL012', 1002, CAST(12000.75 AS Decimal(10, 2)), N'Bob Williams', CAST(N'2023-04-20' AS Date), 2)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1006, N'MNO345', 1, CAST(300.50 AS Decimal(10, 2)), N'Eva Davis', CAST(N'2023-05-05' AS Date), 1)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1007, N'PQR678', 3, CAST(8000.00 AS Decimal(10, 2)), N'Charlie Brown', CAST(N'2023-06-15' AS Date), 2)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1008, N'STU901', 2, CAST(150.75 AS Decimal(10, 2)), N'Grace Taylor', CAST(N'2023-07-01' AS Date), 1)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1009, N'VWX234', 1002, CAST(950.00 AS Decimal(10, 2)), N'David Jones', CAST(N'2023-08-12' AS Date), 2)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1010, N'YZA567', 1, CAST(600.25 AS Decimal(10, 2)), N'Sophie Miller', CAST(N'2023-09-25' AS Date), 1)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1011, N'BCD890', 1002, CAST(2000.50 AS Decimal(10, 2)), N'Michael Davis', CAST(N'2023-10-05' AS Date), 2)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1012, N'EFG123', 2, CAST(1200.75 AS Decimal(10, 2)), N'Linda Garcia', CAST(N'2023-11-15' AS Date), 1)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1013, N'HIJ456', 3, CAST(500.00 AS Decimal(10, 2)), N'Peter Smith', CAST(N'2023-12-01' AS Date), 2)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1014, N'FAQ778', 1, CAST(4400.96 AS Decimal(10, 2)), N'FaQuGe', CAST(N'2023-11-27' AS Date), 1)
INSERT [dbo].[CuentaBancaria] ([id], [numero_cuenta], [tipo_cuenta], [saldo], [propietario_nombre], [fecha_apertura], [estadocuenta]) VALUES (1015, N'FAQ2112', 1, CAST(122.00 AS Decimal(10, 2)), N'Fabian', CAST(N'2023-12-03' AS Date), 1)
SET IDENTITY_INSERT [dbo].[CuentaBancaria] OFF
GO
SET IDENTITY_INSERT [dbo].[EstadoCuenta] ON 

INSERT [dbo].[EstadoCuenta] ([IdEstadoCuenta], [Tipo_EstadoCuenta]) VALUES (1, N'Activa')
INSERT [dbo].[EstadoCuenta] ([IdEstadoCuenta], [Tipo_EstadoCuenta]) VALUES (2, N'Inactiva')
INSERT [dbo].[EstadoCuenta] ([IdEstadoCuenta], [Tipo_EstadoCuenta]) VALUES (13, N'string')
INSERT [dbo].[EstadoCuenta] ([IdEstadoCuenta], [Tipo_EstadoCuenta]) VALUES (14, N't')
INSERT [dbo].[EstadoCuenta] ([IdEstadoCuenta], [Tipo_EstadoCuenta]) VALUES (12, N'Try')
SET IDENTITY_INSERT [dbo].[EstadoCuenta] OFF
GO
SET IDENTITY_INSERT [dbo].[Tipo_Cuenta] ON 

INSERT [dbo].[Tipo_Cuenta] ([id], [nombre]) VALUES (1, N'Ahorro')
INSERT [dbo].[Tipo_Cuenta] ([id], [nombre]) VALUES (3, N'Cheques')
INSERT [dbo].[Tipo_Cuenta] ([id], [nombre]) VALUES (1002, N'Corriente')
INSERT [dbo].[Tipo_Cuenta] ([id], [nombre]) VALUES (2, N'Empresarial')
INSERT [dbo].[Tipo_Cuenta] ([id], [nombre]) VALUES (1004, N'Test')
INSERT [dbo].[Tipo_Cuenta] ([id], [nombre]) VALUES (1003, N'Transaccional')
SET IDENTITY_INSERT [dbo].[Tipo_Cuenta] OFF
GO
SET IDENTITY_INSERT [dbo].[Tipo_De_Transaccion] ON 

INSERT [dbo].[Tipo_De_Transaccion] ([id], [tipo_trasaccion]) VALUES (1, N'Retiro')
INSERT [dbo].[Tipo_De_Transaccion] ([id], [tipo_trasaccion]) VALUES (2, N'Deposito')
INSERT [dbo].[Tipo_De_Transaccion] ([id], [tipo_trasaccion]) VALUES (3, N'Transferencia')
INSERT [dbo].[Tipo_De_Transaccion] ([id], [tipo_trasaccion]) VALUES (1002, N'SINPE')
INSERT [dbo].[Tipo_De_Transaccion] ([id], [tipo_trasaccion]) VALUES (1003, N'test')
SET IDENTITY_INSERT [dbo].[Tipo_De_Transaccion] OFF
GO
SET IDENTITY_INSERT [dbo].[Transacciones] ON 

INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1006, 1, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1007, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1008, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1009, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1010, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1011, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1012, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1013, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1014, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1015, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1016, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1017, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1018, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1019, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1020, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1021, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1022, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1023, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1024, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1025, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1026, 3, CAST(500.50 AS Decimal(10, 2)), CAST(N'2023-02-15' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1030, 3, CAST(500.20 AS Decimal(10, 2)), CAST(N'2020-11-10' AS Date), 1003, 1004)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1031, 3, CAST(500.20 AS Decimal(10, 2)), CAST(N'2020-11-10' AS Date), 1004, 1003)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1033, 2, CAST(6413815.45 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1034, 2, CAST(500.65 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1035, 2, CAST(417.20 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1036, 2, CAST(100.53 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1038, 2, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1039, 2, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1040, 2, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1003, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1041, 2, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1005, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1042, 2, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1005, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1043, 2, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1044, 2, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1045, 2, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1047, 2, CAST(68545.50 AS Decimal(10, 2)), CAST(N'2023-11-26' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1048, 2, CAST(4210.00 AS Decimal(10, 2)), CAST(N'2023-12-03' AS Date), 1014, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1049, 2, CAST(41.20 AS Decimal(10, 2)), CAST(N'2023-12-03' AS Date), 1002, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1050, 2, CAST(41.20 AS Decimal(10, 2)), CAST(N'2023-12-03' AS Date), 1002, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1051, 3, CAST(82.00 AS Decimal(10, 2)), CAST(N'2023-12-03' AS Date), 1002, 1006)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1052, 1, CAST(138.00 AS Decimal(10, 2)), CAST(N'2023-12-03' AS Date), 1004, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1053, 3, CAST(60.00 AS Decimal(10, 2)), CAST(N'2023-12-03' AS Date), 1014, 1010)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1054, 3, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-12-03' AS Date), 1002, 1014)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1055, 2, CAST(200.00 AS Decimal(10, 2)), CAST(N'2023-12-03' AS Date), 1002, NULL)
INSERT [dbo].[Transacciones] ([id], [tipo], [monto], [fecha_transaccion], [cuenta_origen_id], [cuenta_destino_id]) VALUES (1056, 3, CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-12-03' AS Date), 1002, 1010)
SET IDENTITY_INSERT [dbo].[Transacciones] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CuentaBa__C6B74B88C4D1EB66]    Script Date: 12/3/2023 12:47:47 PM ******/
ALTER TABLE [dbo].[CuentaBancaria] ADD UNIQUE NONCLUSTERED 
(
	[numero_cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_EstadoCuenta]    Script Date: 12/3/2023 12:47:47 PM ******/
ALTER TABLE [dbo].[EstadoCuenta] ADD  CONSTRAINT [UQ_EstadoCuenta] UNIQUE NONCLUSTERED 
(
	[Tipo_EstadoCuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Tipo_Cue__72AFBCC65F4ECF8D]    Script Date: 12/3/2023 12:47:47 PM ******/
ALTER TABLE [dbo].[Tipo_Cuenta] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditLog]  WITH CHECK ADD  CONSTRAINT [FK_AuditLog_CuentaBancaria] FOREIGN KEY([id])
REFERENCES [dbo].[CuentaBancaria] ([id])
GO
ALTER TABLE [dbo].[AuditLog] CHECK CONSTRAINT [FK_AuditLog_CuentaBancaria]
GO
ALTER TABLE [dbo].[CuentaBancaria]  WITH CHECK ADD FOREIGN KEY([tipo_cuenta])
REFERENCES [dbo].[Tipo_Cuenta] ([id])
GO
ALTER TABLE [dbo].[CuentaBancaria]  WITH CHECK ADD FOREIGN KEY([tipo_cuenta])
REFERENCES [dbo].[Tipo_Cuenta] ([id])
GO
ALTER TABLE [dbo].[CuentaBancaria]  WITH CHECK ADD  CONSTRAINT [FK_CuentaBancaria_EstadoCuenta] FOREIGN KEY([estadocuenta])
REFERENCES [dbo].[EstadoCuenta] ([IdEstadoCuenta])
GO
ALTER TABLE [dbo].[CuentaBancaria] CHECK CONSTRAINT [FK_CuentaBancaria_EstadoCuenta]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD FOREIGN KEY([cuenta_origen_id])
REFERENCES [dbo].[CuentaBancaria] ([id])
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD FOREIGN KEY([cuenta_destino_id])
REFERENCES [dbo].[CuentaBancaria] ([id])
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD FOREIGN KEY([cuenta_origen_id])
REFERENCES [dbo].[CuentaBancaria] ([id])
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD FOREIGN KEY([cuenta_destino_id])
REFERENCES [dbo].[CuentaBancaria] ([id])
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD FOREIGN KEY([tipo])
REFERENCES [dbo].[Tipo_De_Transaccion] ([id])
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD FOREIGN KEY([tipo])
REFERENCES [dbo].[Tipo_De_Transaccion] ([id])
GO
/****** Object:  StoredProcedure [dbo].[DepositoProcedure]    Script Date: 12/3/2023 12:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DepositoProcedure]
    @cuenta_id INT,
    @monto DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE CuentaBancaria
    SET saldo = saldo + @monto
    WHERE id = @cuenta_id;

    PRINT 'Se realizo el Deposito Adecuada mente';
END;
GO
/****** Object:  StoredProcedure [dbo].[RetiroProcedure]    Script Date: 12/3/2023 12:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RetiroProcedure]
    @cuenta_id INT,
    @monto DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @saldo DECIMAL(10, 2);

    -- Get the current saldo for the account
    SELECT @saldo = saldo FROM CuentaBancaria WHERE id = @cuenta_id;

    -- Check if the withdrawal is allowed (e.g., minimum balance requirement)
    IF @saldo - @monto >= 0
    BEGIN
        -- If allowed, update the saldo
        UPDATE CuentaBancaria
        SET saldo = @saldo - @monto
        WHERE id = @cuenta_id;

        PRINT 'Se realizo correctamente el retiro.';
    END
    ELSE
    BEGIN
        -- If not allowed, raise an error
        PRINT('No tiene el dinero suficiente.');
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[TransferenciaProcedure]    Script Date: 12/3/2023 12:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ... (previous code)

CREATE PROCEDURE [dbo].[TransferenciaProcedure]
    @cuenta_origen_id INT,
    @cuenta_destino_id INT,
    @monto DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @retiroResult varchar(70);  -- Change the data type based on the actual return type of RetiroProcedure

    -- Withdraw from source account
    EXEC @retiroResult = RetiroProcedure @cuenta_origen_id, @monto;

    -- Check the result of RetiroProcedure
    IF @retiroResult = 'No tiene el dinero suficiente.'
    BEGIN
        -- The RetiroProcedure completed successfully, proceed with the deposit
        EXEC DepositoProcedure @cuenta_destino_id, @monto;
        PRINT 'Transferencia completada.';
    END
    ELSE
    BEGIN
        -- The RetiroProcedure encountered an error (insufficient funds)
        PRINT 'Transferencia cancelada. No tiene el dinero suficiente en la cuenta origen.';
    END
END;
GO
USE [master]
GO
ALTER DATABASE [ApiCuentasContables] SET  READ_WRITE 
GO
