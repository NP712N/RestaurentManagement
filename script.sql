USE [master]
GO
/****** Object:  Database [QuanLyCafe]    Script Date: 12/24/2017 5:44:51 PM ******/
CREATE DATABASE [QuanLyCafe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyCafe', FILENAME = N'E:\Microsoft SQL Sever\MSSQL13.NP712N\MSSQL\DATA\QuanLyCafe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyCafe_log', FILENAME = N'E:\Microsoft SQL Sever\MSSQL13.NP712N\MSSQL\DATA\QuanLyCafe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [QuanLyCafe] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyCafe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyCafe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyCafe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyCafe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyCafe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyCafe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyCafe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyCafe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyCafe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyCafe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyCafe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyCafe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyCafe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyCafe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyCafe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyCafe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyCafe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyCafe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyCafe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyCafe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyCafe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyCafe] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyCafe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyCafe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyCafe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyCafe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyCafe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyCafe] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyCafe', N'ON'
GO
ALTER DATABASE [QuanLyCafe] SET QUERY_STORE = OFF
GO
USE [QuanLyCafe]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [QuanLyCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[Displayname] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfor]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [Displayname], [Password], [Type]) VALUES (N'nhanvien', N'Nhân viên', N'abcd', 0)
INSERT [dbo].[Account] ([UserName], [Displayname], [Password], [Type]) VALUES (N'npn', N'Phát Nghị', N'abc', 1)
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (25, CAST(N'2017-12-24' AS Date), CAST(N'2017-12-24' AS Date), 9, 1, 0, 7.35)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (26, CAST(N'2017-12-24' AS Date), CAST(N'2017-12-24' AS Date), 3, 1, 0, 6.375)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (27, CAST(N'2017-12-24' AS Date), CAST(N'2017-12-24' AS Date), 5, 1, 0, 3.395)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (28, CAST(N'2017-12-24' AS Date), CAST(N'2017-12-24' AS Date), 7, 1, 0, 7.5)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (29, CAST(N'2017-12-24' AS Date), NULL, 3, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (30, CAST(N'2017-12-24' AS Date), NULL, 4, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (31, CAST(N'2017-12-24' AS Date), CAST(N'2017-12-24' AS Date), 5, 1, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (32, CAST(N'2017-12-24' AS Date), NULL, 8, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Bill] OFF
SET IDENTITY_INSERT [dbo].[BillInfor] ON 

INSERT [dbo].[BillInfor] ([id], [idBill], [idFood], [count]) VALUES (50, 27, 4, 1)
SET IDENTITY_INSERT [dbo].[BillInfor] OFF
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Macchiato', 1, 2.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Lattle', 1, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'Cappuccino', 1, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Mocha', 1, 4)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'Extra Shot', 1, 1)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Drip', 2, 2)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (8, N'French Press', 2, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (9, N'Vacuum Pot', 2, 5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (10, N'Premium Loose-LeafTea', 3, 2.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (11, N'Tea Latte', 3, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (12, N'Chai Latte', 3, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (13, N'Tiger Eye', 3, 4.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (14, N'White Chocolate Mocha', 3, 4.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (15, N'Flavored Syrup', 4, 1)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (16, N'Steamed Milk', 4, 0.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (17, N'Almond/Coconut Milk', 4, 1)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (18, N'1lb Beans', 4, 14)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (19, N'Bagels', 5, 3.25)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (20, N'Pastries', 5, 3.25)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (21, N'Muffins', 5, 2.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (22, N'Biscotto', 5, 1.75)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (23, N'Hot Oatmeal', 5, 3)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (24, N'Espresso/Americano', 1, 2.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (25, N'Macchiato', 1, 2.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (26, N'Lattle', 1, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (27, N'Cappuccino', 1, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (28, N'Mocha', 1, 4)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (29, N'Extra Shot', 1, 1)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (30, N'Drip', 2, 2)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (31, N'French Press', 2, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (32, N'Vacuum Pot', 2, 5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (33, N'Premium Loose-LeafTea', 3, 2.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (34, N'Tea Latte', 3, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (35, N'Chai Latte', 3, 3.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (36, N'Tiger Eye', 3, 4.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (37, N'White Chocolate Mocha', 3, 4.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (38, N'Flavored Syrup', 4, 1)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (39, N'Steamed Milk', 4, 0.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (40, N'Almond/Coconut Milk', 4, 1)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (41, N'1lb Beans', 4, 14)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (42, N'Bagels', 5, 3.25)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (43, N'Pastries', 5, 3.25)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (44, N'Muffins', 5, 2.5)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (45, N'Biscotto', 5, 1.75)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (46, N'Hot Oatmeal', 5, 3)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (47, N'Espresso/Americano', 1, 2.5)
SET IDENTITY_INSERT [dbo].[Food] OFF
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Espresso')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Coffee')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Specialty drinks')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Extras')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (5, N'Bakery')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (6, N'Espresso')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (7, N'Coffee')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (8, N'Specialty drinks')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (9, N'Extras')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (10, N'Bakery')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 10', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (15, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (16, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (17, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (18, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (19, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (20, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (21, N'Bàn 10', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Password]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[BillInfor] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Empty') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfor]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfor]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[USP_GetAccountByUserName]
@userName nVarchar(100)
as
Begin
	Select * from Account where UserName=@userName
End
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
As
BEGIN
	SELECT t.name as [Tên bàn], b.totalPrice as [Tổng tiền], DateCheckIn as [Ngày vào],DateCheckOut as [Ngày ra],discount as [Giảm giá]
	From Bill b, TableFood t
	where DateCheckIn>=@checkIn and DateCheckOut <=@checkOut and b.status =1
	and t.id =	b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[USP_GetTableList]
As Select * from TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_InsertBill]
@idTable INT
AS
BEGIN
	Insert Bill
		(
		DateCheckIn,
		DateCheckOut,
		idTable,
		status,
		discount
		)
	Values (GETDATE(),
			Null,
			@idTable,
			0,
			0)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfor]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_InsertBillInfor]
@idBill INT,@idFood INT, @count INT
AS
BEGIN
	
	Declare @isExitsBillInfor INT
	declare @foodCount int =1

	Select @isExitsBillInfor = id, @foodCount=b.count
	from BillInfor b
	where idBill = @idBill and idFood = @idFood

	if(@isExitsBillInfor > 0)
	BEGIN
		Declare @newCount int  = @foodCount + @count
		if(@newCount>0)
			UPDATE BillInfor set count = @foodCount + @count where idFood = @idFood
		else 
			delete BillInfor where idBill = @idBill and idFood=@idFood
	END
	Else 
		BEGIN
	Insert BillInfor
		(idBill,idFood,count)
	Values (@idBill,@idFood,@count)
		END	
END	
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_Login] -- stored procedure
@userName nvarchar(100), @passWord nvarchar(100)
as
begin
	select * from Account where UserName = @userName and Password = @passWord
end
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_SwitchTable]
@idTable1 int, @idTable2 int
As
BEGIN
	Declare @idFirstBill int
	declare @idSecondBill int 
	declare @isFirstTableEmpty int = 1
	declare @isSecondTableEmpty int = 1

	select @idSecondBill = id from  Bill where idTable  = @idTable2 and status = 0
	select @idFirstBill = id from  Bill where idTable  = @idTable1 and status = 0	

	if(@idFirstBill is null)
	BEGIN
		INSERT	Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          null , -- DateCheckOut - date
          @idTable1 , -- idTable - int
          0  -- status - int
        )
		select @idFirstBill = Max(id) from Bill where idTable  = @idTable1 and status = 0
		
	END 
	 
	select @isFirstTableEmpty = Count(*) from BillInfor where idBill = @idFirstBill
	 
	if(@idSecondBill is null)
	BEGIN
		INSERT	Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          null , -- DateCheckOut - date
          @idTable2 , -- idTable - int
          0  -- status - int
        )
		select @idSecondBill = Max(id) from Bill where idTable  = @idTable2 and status = 0
		
	END 
	select @isSecondTableEmpty = Count(*) from BillInfor where idBill = @idSecondBill

	Select id Into IDBillInforTable from BillInfor where idBill =@idSecondBill
	Update BillInfor set idBill =@idSecondBill where idBill = @idFirstBill
	Update BillInfor set idBill = @idFirstBill where id in (select * from IDBillInforTable)
	Drop table IDBillInforTable

	if(@isFirstTableEmpty = 0)
		update TableFood set status  = N'Trống' where id = @idTable2
	if(@isSecondTableEmpty = 0)
		update TableFood set status  = N'Trống' where id = @idTable1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 12/24/2017 5:44:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_UpdateAccount]
@userName nvarchar(100), @displayName nvarchar(100), @password nvarchar(100), @newPassword nvarchar(100)
as
begin
	DECLARE @isRightPass INT = 0	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
end
GO
USE [master]
GO
ALTER DATABASE [QuanLyCafe] SET  READ_WRITE 
GO
