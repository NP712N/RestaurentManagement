Create Database QuanLyCafe
Go

Use QuanlyCafe
Go

--Food
--Table
--FoodCategory
--Account
--Bill
--BillInfor


Create table TableFood
(
	id Int identity Primary key, 
	name Nvarchar(100) not null,
	status Nvarchar(100) not null default N'Empty'
)
 Go

Create table Account
(
	UserName Nvarchar(100) primary key,
	Displayname Nvarchar(100) not null,
	Password Nvarchar(1000) not null default 0,
	Type Int not null default 0 -- 1-admin, 0-staff
)
Go

Create table FoodCategory
(
	id int identity Primary key,
	name Nvarchar(100) not null
) 
Go

Create table Food
(
	id int identity Primary key,
	name Nvarchar(100) not null,
	idCategory Int not null,
	price float not null default 0,
	foreign key (idCategory) references FoodCategory(id)
) 
Go

Create table Bill
(
	id int identity Primary key,
	DateCheckIn Date not null default Getdate(),
	DateCheckOut Date,
	idTable Int not null,
	status Int not null default 0, --1: đã thanh toán

	foreign key (idTable) references TableFood(id)
) 
Go

Create table BillInfor
(
	id int identity Primary key,
	idBill Int not null,
	idFood int not null,
	count int  not null Default 0,

	foreign key (idBill) references Bill(id),
	foreign key (idFood) references Food(id)
)


Insert Into Account (UserName,Displayname,Password,Type) 
Values (
		N'npn',
		N'Phát Nghị',
		N'abc',
		1
) 

Insert Into Account (UserName,Displayname,Password,Type) 
Values (
		N'nhanvien',
		N'Nhân viên 1',
		N'abcd',
		0
) 

go

Create Proc USP_GetAccountByUserName -- stored procedure
@userName nVarchar(100)
as
Begin
	Select * from Account where UserName=@userName
End
Go

exec USP_GetAccountByUserName @userName = N'NPN' 
go

create proc USP_Login -- stored procedure
@userName nvarchar(100), @passWord nvarchar(100)
as
begin
	select * from Account where UserName = @userName and Password = @passWord
end
go

Declare @i int = 1 --dùng vòng lặp insert dữ liệu 
while @i <= 10
begin
	Insert TableFood (name)	Values (N'Bàn '+Cast(@i as nvarchar(100)))
	Set @i = @i + 1
end
go

Create Proc USP_GetTableList
As Select * from TableFood
go

Exec USP_GetTableList

-- thêm category
INSERT FoodCategory
        ( name )
VALUES  ( N'Espresso'  -- name - nvarchar(100)
          )
INSERT FoodCategory
        ( name )
VALUES  ( N'Coffee' )
INSERT FoodCategory
        ( name )
VALUES  ( N'Specialty drinks' )
INSERT FoodCategory
        ( name )
VALUES  ( N'Extras' )
INSERT FoodCategory
        ( name )
VALUES  ( N'Bakery' )

-- thêm món ăn
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Espresso/Americano', -- name - nvarchar(100)
          1, -- idCategory - int
          2.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Macchiato', 1, 2.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Lattle', 1, 3.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Cappuccino', 1, 3.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Mocha', 1, 4.00)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Extra Shot', 1, 1.00)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Drip', 2, 2.00)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'French Press', 2, 3.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Vacuum Pot', 2, 5.00)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Premium Loose-LeafTea', 3, 2.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Tea Latte', 3, 3.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Chai Latte', 3, 3.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Tiger Eye', 3, 4.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'White Chocolate Mocha', 3, 4.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Flavored Syrup', 4, 1.00)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Steamed Milk', 4, 0.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Almond/Coconut Milk', 4, 1.00)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'1lb Beans', 4, 14.00)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Bagels', 5, 3.25)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Pastries', 5, 3.25)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Muffins', 5, 2.50)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Biscotto', 5, 1.75)
INSERT Food
        ( name, idCategory, price )
VALUES  ( N'Hot Oatmeal', 5, 3.00)

-- thêm bill
INSERT	Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          3 , -- idTable - int
          0  -- status - int
        )
        
INSERT	Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          4, -- idTable - int
          0  -- status - int
        )
INSERT	Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status
        )
VALUES  ( GETDATE() , -- DateCheckIn - date
          GETDATE() , -- DateCheckOut - date
          5 , -- idTable - int
          1  -- status - int
        )

-- thêm bill info
INSERT	BillInfor
        ( idBill, idFood, count )
VALUES  ( 1, -- idBill - int
          1, -- idFood - int
          2  -- count - int
          )
INSERT	BillInfor
        ( idBill, idFood, count )
VALUES  ( 2, -- idBill - int
          3, -- idFood - int
          4  -- count - int
          )
INSERT	BillInfor
        ( idBill, idFood, count )
VALUES  ( 3, -- idBill - int
          5, -- idFood - int
          1  -- count - int
          )
INSERT	BillInfor
        ( idBill, idFood, count )
VALUES  ( 2, -- idBill - int
          1, -- idFood - int
          2  -- count - int
          )
INSERT	BillInfor
        ( idBill, idFood, count )
VALUES  ( 1, -- idBill - int
          6, -- idFood - int
          2  -- count - int
          )

GO

create Proc USP_InsertBill
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
Go

Create Proc USP_InsertBillInfor
@idBill INT,@idFood INT, @count INT
AS
BEGIN
	Insert BillInfor
		(
		idBill,
		idFood,
		count
		)
	Values (
		@idBill,
		@idFood,
		@count
			)
END		
Go

create Proc USP_InsertBillInfor
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
Go

create  TRIGGER UTG_UpdateBillInfo
ON BillInfor FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @idBill INT	
	SELECT @idBill = idBill FROM Inserted	
	DECLARE @idTable INT	
	SELECT @idTable = idTable FROM Bill WHERE id = @idBill AND status = 0
	Declare @count int
	Select @count = Count(*) from  BillInfor where idBill = @idBill
	if(@count>0)
		UPDATE TableFood SET status = N'Có người' WHERE id = @idTable
	else
		UPDATE TableFood SET status = N'Trống' WHERE id = @idTable
END
GO



CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT	
	SELECT @idBill = id FROM Inserted		
	DECLARE @idTable INT	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill	
	DECLARE @count int = 0	
	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0	
	IF (@count = 0)
		UPDATE TableFood SET status = N'Trống' WHERE id = @idTable
END
GO

alter table Bill
add discount int 
go 
update Bill set discount =0 
 go 


create proc USP_SwitchTable
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
Go

exec USP_SwitchTable @idTable1 = 8, @idTable2 = 11
update TableFood set status = N'Trống'

alter table Bill add totalPrice float
go
delete BillInfor go
delete Bill go

create proc USP_GetListBillByDate
@checkIn date, @checkOut date
As
BEGIN
	SELECT t.name as [Tên bàn], b.totalPrice as [Tổng tiền], DateCheckIn as [Ngày vào],DateCheckOut as [Ngày ra],discount as [Giảm giá]
	From Bill b, TableFood t
	where DateCheckIn>=@checkIn and DateCheckOut <=@checkOut and b.status =1
	and t.id =	b.idTable
END
go

create proc USP_UpdateAccount
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
go

CREATE TRIGGER UTG_DeleteBillInfo
ON BillInfor FOR DELETE
AS 
BEGIN
	DECLARE @idBillInfo INT
	DECLARE @idBill INT
	SELECT @idBillInfo = id, @idBill = Deleted.idBill FROM Deleted
	
	DECLARE @idTable INT
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill
	
	DECLARE @count INT = 0
	
	SELECT @count = COUNT(*) FROM BillInfor AS bi, dbo.Bill AS b WHERE b.id = bi.idBill AND b.id = @idBill AND b.status = 0
	
	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO

--hàm thay thế kí tự có dấu thành khônng dấu
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
 go 

SELECT * FROM Food WHERE dbo.fuConvertToUnsign1(name) LIKE N'%' + dbo.fuConvertToUnsign1(N'{0}') + '%'