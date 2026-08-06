--Lab ในชั้นเรียนวันที่  6 สิงหาคม 2569
--ใช้ ฐานข้อมูล Northwind เพื่อ Query ข้อมูลต่อไปนี้
--1.ต้องการ คำนำหน้า ชื่อ นามสกุล พนักงาน ที่อยู่ในเมือง London
SELECT * from Employees 
select TitleOfCourtesy , firstname , lastname from Employees 
where City = 'london';
--2.ข้อมูล รหัสสินค้า ชื่อสินค้า ราคา จำนวน ของสินค้าที่มีจำนวนน้อยกว่า 30
Select * from Products
select ProductID , Productname , UnitPrice from Products
where UnitsInStock < 30 ;
--3.รหัสลูกค้า ชื่อบริษัท เบอร์โทรศัพท์ ของลูกค้าที่อยู่ในประเทศต่อไปนี้
--    Sweden, Germany, France, Spain, UK
select * from Customers
SELECT CustomerID, CompanyName, Phone
FROM Customers
WHERE Country IN ('Sweden', 'Germany', 'France', 'Spain', 'UK');
--4.ข้อมูลลูกค้าที่ไม่มีหมายเลขโทรสาร (Fax)
SELECT * FROM Customers
WHERE Fax IS NULL;
--5.ข้อมูลสินค้าที่มีจำนวนสินค้าต่ำกว่าจุดสั่งซื้อ และ มีจำนวนที่สั่งซื้อแล้ว
Select * from Products
SELECT *
FROM Products
WHERE UnitsInStock < ReorderLevel AND UnitsOnOrder > 0;
--6.ชื่อ นามสกุล พนักงานที่เข้าทำงานในปี 1992
SELECT * from Employees 
select Firstname , Lastname 
from Employees
where Year(HireDate) = '1992';
--7.ต้องการข้อมูลสินค้าที่มีราคาตั้งแต่ 20-70
Select * from Products
SELECT *
FROM Products
WHERE UnitPrice BETWEEN 20 AND 70;
--8.ข้อมูลลูกค้าที่มีชื่อบริษัทขึ้นต้นด้วย S และอยู่ประเทศ Mexico
SELECT *
FROM Customers
WHERE CompanyName LIKE 'S%' AND Country = 'Mexico';
-- 9. ข้อมูลจากลูกค้าที่มีตำแหน่งผู้ประสานงาน manager
SELECT *
FROM Customers
WHERE ContactTitle LIKE '%Manager%';
Select top(5) * from Products
SELECT COUNT(*) as จำนวนชนิด,MAX(UnitPrice) as ราคาสูงสุด,  
      MIN(UnitPrice)ราคาต่ำสุด,  AVG(UnitPrice)ราคาเฉลี่ย, Sum(UnitsInStock) จำนวนสินค้าทั้งหมด
FROM Products;
--ต้องการทราบว่าสินค้าแต่ละหมวดหมู่(CatgoryID) มีสินค้ากี่ชนิด แต่ละชนิดมีค่าเฉลี่ย มีราคาสูงสุด และต่ำสุด
Select CategoryID, count(*)จำนวนชนิด, Avg(UnitPrice)ราคาเฉลี่ย, Max(UnitPrice)ราคาสูงสุด, Min(UnitPrice) ราคาต่ำสุด
from Products
Group by CategoryID
--ต้องการทราบข้อมูลว่าในแต่ละประเทศ(Country) มีลูกค้ากี่ราย (ถ้าทำได้แล้วลองเพิ่ม city เข้าไปด้วย)
Select Country, Count(*) จำนวนลูกค้า, City
from Customers 
group by Country , City
order by country asc , count(*) DESC
--order by  Count(*) DESC
--order by  3 DESC
--ต้องการทราบข้อมูลว่าในแต่ละประเทศ(Country) แสดงเฉพาะที่มีจำนวนลูกค้า 10 รายขึ้นไป
Select Country, Count(*) จำนวนลูกค้า
from Customers 
group by Country 
having count(*) >=10
--ต้องการทราบว่าสินค้าที่มีมูลค่าสูง (ราคาตั้งแต่ 75 ขึ้นไป) แต่ละหมวดหมู่จำนวนกี่ขนิด มีราคาเฉลี่ยเท่าใด
--ใหเแสดงเฉพาะสินค้าที่มีราคาสูงกว่าราคาเฉลี่ย
select categoryID, count(*) จำนวนชนิด, Avg(UnitPrice) ราคาเฉลี่ย
from products
where UnitPrice >=75
group by CategoryID
having avg(UnitPrice) > 200
--จากตาราง [Order Details] ให้รวบรวมว่าในแต่ละการสั่งซื้อ มียอดเงินเท่าใด
Select orderID, UnitPrice, Quantity,Discount, 
       UnitPrice * Quantity as ราคาเต็ม, 
       UnitPrice * Quantity*Discount as ส่วนลด,
       (UnitPrice * Quantity) - (UnitPrice * Quantity*Discount) as ราคาหักส่วนลดแล้ว,
       (UnitPrice * Quantity * (1- Discount)) as หักส่วนลดสูตรย่อ
       --หักส่วนลดใช้อันไหนก็ได้ แล้วแต่เรา
from [Order Details]
--ต้องการเฉพาะใบสั่งซื้อที่มียอดเงินรวมมากกว่า 1000
Select orderID, count(*) จำนวนรายการ,
   sum(UnitPrice * Quantity * (1- Discount)) as ยอดเงินรวม
from [Order Details]
group by orderID
having sum(UnitPrice * Quantity * (1- Discount)) >2000
order by 3 desc

