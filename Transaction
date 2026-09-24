[Transaction.sql](https://github.com/user-attachments/files/32599579/Transaction.sql)
--24/09/69
--เริ่มสร้าง Order
--Step1---------------------------------------------------------------

Select customerID, companyname from Customers
where CustomerID = 'ALFKI'
BEGIN TRANSACTION;

INSERT INTO Orders(CustomerID, EmployeeID,OrderDate, RequiredDate, Freight)
VALUES('ALFKI', 1, GETDATE(),DATEADD(DAY,7,GETDATE()), 50.00);
--สำรวจ OrderID ที่เพิ่มใหม่
Select SCOPE_IDENTITY() as NewOrderID  --11078
--เพิ่ม Order Details 
INSERT INTO [Order Details](OrderID, ProductID,UnitPrice, Quantity, Discount)
SELECT 11078, ProductID,UnitPrice, 2, 0 FROM Products WHERE ProductID = 1;

INSERT INTO [Order Details](OrderID, ProductID,UnitPrice, Quantity, Discount)
SELECT 11078, ProductID,UnitPrice, 3, 0 FROM Products WHERE ProductID = 2;

--ตรวจสอบข้อมูลที่เพิ่งเพิ่มเข้าไป
SELECT *FROM Orders WHERE OrderID = 11078;
--ตรวจสอบก่อน Commit ใน Orders Details
SELECT *FROM Orders WHERE OrderID = 11078;
--บันทึกข้อมูล
Commit
--ตรวจสอบข้อมูลหลัง Commit
SELECT *FROM Orders WHERE OrderID = 11078;
--Step2-----------------------------------------------------------------
Select CustomerID, companyname from Customers
where CustomerID = 'ALFKI'
--เริ่มการทำ
BEGIN TRANSACTION;
INSERT INTO Orders(CustomerID, EmployeeID, OrderDate, RequiredDate, Freight)
VALUES('ALFKI', 1, GETDATE(),DATEADD(DAY,7,GETDATE()), 75.00);
--ตรวจสอบเลข Order
Select SCOPE_IDENTITY() as NewOrderID
--ตรวจสอบภายหลัง
SELECT SCOPE_IDENTITY()AS RollbackOrderID; --11079
--เพิ่มสินค้า
INSERT INTO [Order Details](OrderID, ProductID,UnitPrice, Quantity, Discount)
SELECT 11079, ProductID,UnitPrice, 1, 0 FROM Products WHERE ProductID = 1;
--เพิ่มสินค้าที่สอง
INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11079, ProductID, UnitPrice, 2, 0 FROM Products WHERE ProductID = 2;
--ตรวจสอบก่อน Rollback ใน Orders
SELECT *FROM Orders WHERE OrderID = 11079;
--ตรวจสอบก่อน Rollback ใน Orders Details
SELECT *FROM Orders Details WHERE OrderID = 11079;
--ทำการ Rollback
Rollback
--ตรวจสอบหลัง Rollback
SELECT *FROM Orders WHERE OrderID = 11079;
