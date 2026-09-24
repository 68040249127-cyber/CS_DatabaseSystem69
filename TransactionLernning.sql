--สำรวจข้อมูล Receipts, Details, Employees, Products
Select * from Receipts
Select * from Details
Select * from Employees
Select * from Products
--เป้าหมาย ต้แงการสร้างรายการจำหน่ายสินค้า ผู้ขายคือ วุฒิศักดิ์
--สินค้าที่ขาย ได้แก่ ดินสอ 5 แท่ง และ ยางลบ 4 ก้อน
---เริ่มต้น Transaction
Begin Transaction
--1. เพิ่มใบเสร็จใหม่ Receipts ยังไม่มียอด TotalCash
Insert into Receipts(ReceiptDate,EmployeeID,TotalCash)
	Values(getdate(), 4, 0)
--2. เพิ่มรายการสินค้าใน Details 2 รายการ (ก่อนทำ เปิดดูรหัสใบเสร็จล่าสุด) --21
Insert into Details(ReceiptID, ProductID, UnitPrice,Quantity)
	Values(21,1,25,5) --ดินสอ
Insert into Details(ReceiptID,ProductID, UnitPrice,Quantity)
	Values(21,2,17,4) --ยางลบ
--3. ปรังปรุงยอดขาย TotalCash
update Receipts set TotalCash =
	(select sum(unitprice*quantity) from Details
	where ReceiptID = 21)
	where ReceiptID = 21
--4. ปรับปรุงจำนวนสินค้า ดินสอ -5 ยางลบ -4
update Products set UnitsInStock = UnitsInStock - 5 where productID = 1 --ดินสอ
update Products set UnitsInStock = UnitsInStock - 4 where productID = 2 --ดินสอ
--จบการทำงาน
Commit
--ทดสอบ Rollback----------------------------------------------
--เริ่มต้น Transaction
Begin Transaction
--1. เพิ่มใบเสร็จใหม่ Receipts ยังไม่มียอด TotalCash
Insert into Receipts(ReceiptDate,EmployeeID,TotalCash)
	Values(getdate(), 4, 0)
--2. เพิ่มรายการสินค้าใน Details 2 รายการ (ก่อนทำ เปิดดูรหัสใบเสร็จล่าสุด) --21
Insert into Details(ReceiptID, ProductID, UnitPrice,Quantity)
	Values(22,1,25,5) --ดินสอ
Insert into Details(ReceiptID,ProductID, UnitPrice,Quantity)
	Values(22,2,17,4) --ยางลบ
	--ตรวจสอบข้อมูลที่เกิดขึ้น------------------------------
	Select * from Receipts where ReceiptID = 22
	Select * from Details where ReceiptID = 22

	--หากระบบผิดพลาด เราจะ Rollback--------------------
	Rollback

