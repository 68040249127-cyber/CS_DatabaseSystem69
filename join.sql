--lab ในชั้นเรียน 13/08/69
--ใช้ฐานข้อมูล Northwind
--1. ต้องการข้อมูล รหัสใบสั่งซื้อ ยอดเงินรวมหักส่วนลดแล้ว จากแต่ละใบสั่งซื้อทั้งหมด เรียงลำดับตามยอดเงินจากมากไปหาน้อย
Select * from [Order Details]
Select OrderID , Format(sum(UnitPrice * quantity *(1-discount)), 'N2') TotalCash
from [Order Details]
group by OrderID 
order by sum(UnitPrice * quantity *(1-discount)) desc
--ใช้ได้ทั้งข้างบนทั้งข้างล่าง
Select OrderID , Format(sum(UnitPrice * quantity *(1-discount)), 'N2') TotalCash
from [Order Details]
group by OrderID 
order by 2 desc

--2. ต้องการ ชื่อประเทศของผู้แทนจำหน่าย(Suppliers) และจำนวนผู้แทนจำหน่ายในแต่ละประเทศ แสดงมาเฉพาะรายการที่ผู้แทนจำหน่ายมีมากกว่า 1 ราย
Select country, count(*) TotalSuppliers
from Suppliers
group by country
having count(*) > 1


--3.รหัสสินค้า จำนวนรวมทั้งหมดที่ขายได้ ราคาสูงสุดที่ขายได้ ราคาต่ำสุดที่ขายได้ แสดงเฉพาะสินค้าที่ขายได้รวมมากกว่า 1500 ชิ้น (Detail)
Select * from Products
Select ProductID , sum(Quantity) TotalQuantity
from [Order Details]
group by ProductID 
having sum(quantity)> 1500
order by ProductID desc
--เพิ่มเติมข้อ3 ต้องการเฉพาะจำนวนสินค้าที่ไม่มีส่วนลด
Select * from Products
Select ProductID , sum(Quantity) TotalQuantity
from [Order Details]
where discount >0
group by ProductID 
having sum(quantity)> 500
order by ProductID desc
-- การ Query ข้อมูล จากตาราง (Join Table)
Select * from Products
Select * from Categories
--Inner join
Select *
from Products inner join Categories
     on products.categoryID = Categories.CategoryID
--ต้องการรหัสหมวดหมู่ ชื่อหมวดหมู่สินค้า รหัสสินค้า ชื่อสินค้า ราคา โดยเรียงลำดับตามหมวดหมู่สินค้า และราคาสูงไปต่ำ
Select Products.CategoryID, CategoryName, ProductID , ProductName , UnitPrice
from Products inner join Categories
     on products.categoryID = Categories.CategoryID
Order by CategoryID asc , UnitPrice desc
--asc น้อยไปมาก desc มากไปน้อย
--วิธีย่อคำสั่ง
Select p.CategoryID, CategoryName, ProductID , ProductName , UnitPrice
from Products as p inner join Categories as c
--from Products  p inner join Categories  c ไม่ใส่ as ก็ได้
     on p.categoryID = c.CategoryID
Order by CategoryID asc , UnitPrice desc

--ต้องการชื่อผู้รับผิดชอบการสั่งซื้อแต่ละรายการ
select * from orders
select * from Employees
--รหัสใบสั่งซื้อ วันที่สั่งซื้อ วันที่รับสินค้า ประเทศปลายทาง ชื่อ-นามสกุลพนักงานผู้รับผิดชอบ
Select o.OrderID, format(o.OrderDate, 'd','en-gb') as [order date],
                  format(o.ShippedDate,'d','en-gb') as [shipped date],
                  o.ShipCountry, 
e.FirstName + space(2) + e.LastName saleMan
from Orders o inner join Employees e on o.EmployeeID = e.EmployeeID

--ต้องการรหัสหมวดหมู่ ชื่อหมวดหมู่สินค้า รหัสสินค้า ชื่อสินค้า ราคา ประเทศที่มา
--โดยเรียงลำดับตามหมวดหมู่สินค้า และราคาสูงไปต่ำ และสินค้ามาจากประเทศ USA , Maxico , canada
select c.CategoryID , c.CategoryName,
       p.ProductID, p.ProductName, p.UnitPrice, s.Country
from Products p inner join Categories c on p.CategoryID = c.CategoryID
                inner join Suppliers s on p.SupplierID = s.SupplierID
where s.Country in ('USA' , 'Mexico' , 'Canada')
order by Country

--แบบฝึกหัดการ Join ตาราง
--1. ต้องการ รหัสบริษัทขนส่ง, ชื่อบริษัทขนส่ง, จำนวนใบสั่งซื้อที่เกี่ยวข้อง, ยอดรวมค่าขนส่ง (ShipperID,companyName,Quantity,Freight)
select s.ShipperID, CompanyName,
       count(*) TotalOrders, sum(o.Freight) sumFreight
from Shippers s join Orders o on s.ShipperID = o.ShipVia
group by s.ShipperID, CompanyName

--2. รหัสใบสั่งซื้อ วันที่สั่งซื้อ ชื่อบริษัทลูกค้า ให้แสดงเฉพาะ ลูกค้าที่อาศัยอยู่ในประเทศ USA  (orderID, orderdate, CompanyName in usa)
select OrderID, format(o.OrderDate,'d','en-gb') as [order date], c.CompanyName
from orders o join customers c on o.CustomerID = c.CustomerID
where c.Country = 'USA'

--3. รหัสพนักงาน ชื่อนามสกุล จำนวนใบสั่งซื้อที่เกี่ยวข้อง
Select e.EmployeeID , firstName + space(2) + LastName EmployeeName ,
       count(*) TotalOrders
from Employees e join Orders o on e.EmployeeID = o.EmployeeID
group by e.EmployeeID , FirstName + space(2) + LastName

--4. รหัสใบสั่งซื้อ วันที่สั่งซื้อ ชื่อพนักงาน ชื่อบริษัทลูกค้า ชื่อบริษัทขนส่ง ยอดรวมในใบสั่งซื้อ เฉพาะรายการในปี 1997 เรียงตาม ยอดเงินจากมากไปน้อย
select o.OrderID, FORMAT(o.OrderDate, 'd','en-gb') as [Order details],
       FirstName EmployeesName, c.CompanyName CustomerCompany,
       s.CompanyName ShipperCompany
--       sum(od.unitprice*od.quantity*(1-discount)) totalcash
from orders o join Employees e on o.EmployeeID = e.EmployeeID
              join Customers c on o.CustomerID = c.CustomerID
              join [Order Details] od on o.OrderID = od.OrderID
              join Shippers s on o.ShipVia = s.ShipperID
where year(orderdate) =1997
group by o.OrderID, format(o.OrderDate,'d','en-gb'),
firstName, c.CompanyName , s.CompanyName

--ต้องการ รหัสสินค้า ชื่อสินค้า จำนวนที่ขายได้ เฉพาะสินค้าที่ขายดีที่สุด 5 อันดับแรก ในปี 1997
select  p.ProductID, p.ProductName,sum(quantity) TotalQuantity
from Products p join [Order Details] od on p.ProductID = od.ProductID
                join Orders o on o.orderID = od.orderiD
where year(orderdate) = 1997
group by p.ProductID, p.ProductName
order by 3 desc

--ข้อมูล ชื่อบริษัทลูกค้า และประเทศลูกค้า ที่ซื้อสินค้ามาจาก Exotic Liquids
select s.CompanyName, c.Country 
from Customers c join Orders o on c.CustomerID = o.CustomerID
                 join [Order Details] od on o.OrderID = od.OrderID
                 join Products p on od.ProductID = p.ProductID
                 join Suppliers s on p.SupplierID = s.SupplierID
where s.CompanyName = 'Exotic Liquids'

--ชื่อบริษัทลูกค้าที่ซื้อสินค้าหมวดหมู่ Seafood
select Distinct c.CompanyName
from Customers c join Orders o on c.CustomerID = o.CustomerID
                 join [Order Details] od on o.OrderID = od.OrderID
                 join Products p on od.ProductID = p.ProductID
                 join Categories cg on p.CategoryID = cg.CategoryID
where cg.categoryname = 'Seafood'
--sub Query (Query ซ้อนกัน)
--ชื่อพนักงานที่มีตำแหน่งเดียวกัน Nancy (nancy ตำแหน่งอะไร)
Select Firstname
from Employees
where title = (select title from Employees where FirstName = 'nancy') --ตำแหน่งงาน

--ชื่อพนักงานที่อายุน้อยกว่า Robert (Robert เกิดเมื่อใด)
Select Firstname
from Employees
where BirthDate > (select BirthDate from Employees where FirstName = 'robert') 
--รหัสสินค้า ชื่อสินค้า ที่มีราคาสูงกว่าค่าเฉลี่ยทั้งหมดของราคาสินค้า (ค่าเฉลี่ยของราคาสินค้าคืออะไร)
select ProductID, Productname, UnitPrice
from Products
where UnitPrice > (Select Avg(Unitprice) from Products) --ราคาเฉลี่ยของสินค้าทั้งหมด
--ชื่อ นามสกุล พนักงานที่ อายุมากที่สุด
SELECT FirstName
FROM Employees
WHERE BirthDate >= ALL (SELECT BirthDate FROM Employees)
--ชื่อ-นามสกุล พนักงานที่ เข้าทำงานหลังสุด
SELECT FirstName
FROM Employees
WHERE HireDate <= ALL (SELECT HireDate FROM Employees)

