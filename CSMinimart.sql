--สร้างฐานข้อมูล
Create Database CsMinimart 
--ปรับให้เพิ่มภาษาไทยได้
Alter database CSMinimart Collate Thai_CI_AS;
--เปลี่ยนบนเมนู
--สร้างตาราง Employees
Create Table Employees(
EmployeesID Int Identity (1,1) Primary Key,
title varchar(20) null,
firstname varchar(50) not null,
lastname varchar(50) null,
position varchar(50) null,
username varchar(50) Unique,
passwordhash varchar(255) not null,
IsActive bit not null default 1
)

--****กรณีแก้คำสั่งต้องลบตารางโดยคำสั่ง drop table " ชื่อตาราง " รันคำสั่งนี้แล้วไปแก้ แล้วค่อยรันคำสั่งใหม่****
--เพิ่มข้อมูลพนักงาน
insert into Employees
    (Title, FirstName, LastName, Position, UserName, PasswordHash)
VALUES
    ('นางสาว', 'เชาวณี', 'ศรีอุดม','Sale Manager', 'user2', 'hashed1');
--เช็คข้อมูลตาราง
SELECT * FROM Employees;
--สร้างตาราง categories
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(200)
);

--เพิ่มข้อมูลหมวดหมู่สินค้า
INSERT INTO Categories(CategoryName, Description)
VALUES('เครื่องปรุง','กะปิ น้ำปลา น้ำตาล ผงปรุงรส ');
INSERT INTO Categories(CategoryName, Description)
VALUES('เครื่องดื่มเย็น','เป๊ปซี่ น้ำเปล่า น้ำส้ม นมช็อกโกแลต ');
INSERT INTO Categories(CategoryName, Description)
VALUES('อาหารสำเร็จรูป','บะหมี่กึ่งสำเร็จรูป เงาะกระป๋อง น้ำพริก ปลากระป๋อง ');
INSERT INTO Categories(CategoryName, Description)
VALUES('เครื่องสำอาง','ลิปมัน อายไลน์เนอร์ บลัชออน คุชชั่น ');
INSERT INTO Categories(CategoryName, Description)
VALUES('เวชภัณฑ์','ยาลดน้ำมูก ยาแก้ปวด ยาแก้เจ็บคอ เจลลดไข้ ');
--ดูข้อมูลในตาราง
SELECT * FROM Categories;

--สร้างตาราง products ให้อ้างถึง catgories ได้
CREATE TABLE Products (
    ProductID VARCHAR(13) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL DEFAULT 0,
    UnitsInStock INT NOT NULL DEFAULT 0,
    CategoryID INT NOT NULL,
    Discontinued BIT NOT NULL DEFAULT 0,

    CONSTRAINT CK_Products_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Products_UnitsInStock
        CHECK (UnitsInStock >= 0),

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);
--ทดสอบข้อมูลในตาราง Products 
INSERT INTO Products(ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID)
VALUES('8858757001948', 'เป๊ปซี่',15.00, 290, 1);
 SELECT * FROM Products
INSERT INTO Products(ProductID, ProductName, UnitPrice,UnitsInStock, CategoryID)
VALUES('8858757009999', 'นมช็อกโกแลต',12.00, 20, 1);
INSERT INTO Products(ProductID, ProductName, UnitPrice,UnitsInStock, CategoryID)
VALUES('8858998586257', 'น้ำเปล่า',7.00, 20, 1);
INSERT INTO Products(ProductID, ProductName, UnitPrice,UnitsInStock, CategoryID)
VALUES('8858998589326', 'บะหมี่กึ่งสำเร็จ',7.00, 20, 1);
INSERT INTO Products(ProductID, ProductName, UnitPrice,UnitsInStock, CategoryID)
VALUES('8858757006654', 'น้ำตาล',12.00, 20, 1);
Select * from Products
--สร้างตารางใบเสร็จ
CREATE TABLE Receipts (
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,
    ReceiptDate DATETIME NOT NULL
        DEFAULT GETDATE(),
    EmployeeID INT NOT NULL,
    TotalCash DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT CK_Receipts_TotalCash
        CHECK (TotalCash >= 0),

    CONSTRAINT FK_Receipts_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeesID)
);
-- select getdate() 

--สร้างใบเสร็จ
CREATE TABLE Receipts (
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,
    ReceiptDate DATETIME NOT NULL
        DEFAULT GETDATE(),
    EmployeeID INT NOT NULL,
    TotalCash DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT CK_Receipts_TotalCash
        CHECK (TotalCash >= 0),

    CONSTRAINT FK_Receipts_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeesID)
);
--เพิ่มข้อมูลตารางใบเสร็จ
INSERT INTO Receipts(EmployeeID, TotalCash)
VALUES(1, 115);

SELECT *FROM Receipts;
--สร้างตาราง Details
CREATE TABLE Details (
    ReceiptID INT NOT NULL,
    ProductID VARCHAR(13) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_Details
        PRIMARY KEY (ReceiptID, ProductID),
    CONSTRAINT CK_Details_UnitPrice
        CHECK (UnitPrice >= 0),
    CONSTRAINT CK_Details_Quantity
        CHECK (Quantity > 0),
    CONSTRAINT FK_Details_Receipts
        FOREIGN KEY (ReceiptID)
        REFERENCES Receipts(ReceiptID),
    CONSTRAINT FK_Details_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
--ทดสอบข้อมูล
INSERT INTO Details(ReceiptID, ProductID, UnitPrice, Quantity)
VALUES(1, '8858757001948', 15.00, 3);
select * from Details
