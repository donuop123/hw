\d # 
-- 表customers 新增
create procedure addC(in name varchar(100), in phone varchar(100),in email varchar(100), 
                        in address varchar(100))
begin
    insert into customers (customerName, phone, email, address) values 
                            (name, phone, email, address);
end #
\d ;

-------------------------------------
\d # 
-- 表customers 刪除
create procedure deleteC(in id int)
begin
    delete from customers where customerID = id;
end #
\d ;

--------------------------------------
\d # 
-- 表customers 修改
create procedure updateC(in id int, in name varchar(100), in phone varchar(100),
                            in email varchar(100), in address varchar(100))
begin
    update customers set customerName = name, phone = phone, email = email, address = address 
    where customerID = id;
end #
\d ;

---------------------------------------
\d # 
-- 表suppliers 新增
create procedure addS(in newName varchar(100), in newPhone varchar(100), in newAddress varchar(100))
begin
    insert into suppliers (supplierName, phone, address) values (newName, newPhone, newAddress);
end #
\d ;

----------------------------------------
\d # 
-- 表suppliers 刪除
create procedure deleteS(in id int)
begin
    delete from suppliers where supplierID = id;
end #
\d ;

----------------------------------------
\d # 
-- 表suppliers 修改
create procedure updateS(in id int, in newName varchar(100), in newPhone varchar(100), 
                            in newAddress varchar(100))
begin
    update suppliers set supplierName = newName, phone = newPhone, address = newAddress 
    where supplierid = id;
end #
\d ;

----------------------------------------
\d # 
-- 表products 新增
create procedure addP(in productNumber varchar(100), in productName varchar(100), in recPrice int, 
                        in supplierID int)
begin
    insert into products (productNumber, productName, recPrice, supplierID) values 
                            (productNumber, productName, recPrice, supplierID);
end #
\d ;

-----------------------------------------
\d # 
-- 表products 刪除
create procedure deleteP(in id int)
begin
    delete from products where productID = id;
end #
\d ;

-------------------------------------------
\d # 
-- 表products 修改
create procedure updateP(in id int, in newNumber varchar(100), in newName varchar(100), 
                            in newPrice int, in newSupplier int)
begin
    update products set productNumber = newNumber, productName = newName, recPrice = newPrice, 
    supplierID = newSupplier  where productID = id;
end #
\d ;

--------------------------------------------
\d # 
-- 表orders 新增
create procedure addO(in number int, in customerName varchar(100), in productID int,
                        in unitPrice int, in quantity int)
begin
    insert into orders (number, customerName) values (number, customerName);
    insert into orderdetails (number, productID, unitPrice, quantity) values (number, productID,
                                 unitPrice, quantity);
end #
\d ;

--------------------------------------------
\d # 
-- 表orders 刪除
create procedure deleteO(in id int)
begin
    delete from orders where number = id;
end #
\d ;

---------------------------------------------
\d # 
-- 表orders 修改
create procedure updateO(in id int, in newNumber int, in newCuctomerName varchar(100))
begin
    update orders set number = newNumber, customerName = newCuctomerName where orderID = id;
end #
\d ;

---------------------------------------------
\d # 
-- 因為外鍵關係，需在刪除orders前，利用trigger先行刪除同編號的訂單細項
create trigger t1 before delete on orders for each row
begin
    delete from orderdetails where number = old.number; -- old.number 進行刪除前的number
end #
\d ;

-------------------------------------------------
\d # 
-- 表orderdetails 新增
create procedure addOD(in number int, in productID int, in unitPrice int, in quantity int)
begin
    insert into orderdetails (number, productID, unitPrice, quantity) values 
    (number, productID, unitPrice, quantity);
end #
\d ;

---------------------------------------------
\d # 
-- 表orderdetails 刪除
create procedure deleteOD(in id int)
begin
    delete from orderdetails where odID = id;
end #
\d ;

----------------------------------------------
\d # 
-- 表orderdetails 修改，僅能修改實際售價及數量
create procedure updateOD(in id int, in newUnitPrice int, in newQuantity int)
begin
    update orderdetails set unitPrice = newUnitPrice, quantity = newQuantity where odID = id;
end #
\d ;

---------------------------------------------
\d # 
-- 輸入客戶姓名查詢此客戶所有資料
create procedure searchCByname(in kw varchar(100))
begin
    select * from customers where customerName like concat("%", kw , "%") COLLATE utf8_unicode_ci;
end #
\d ;

---------------------------------------------
\d # 
-- 輸入客戶電話查詢此客戶所有資料
create procedure searchCByphone(in kw varchar(100))
begin
    select * from customers where phone like concat("%", kw , "%") COLLATE utf8_unicode_ci;
end #
\d ;

-----------------------------------------------
\d # 
-- 輸入供應商名稱查詢此供應商所有資料
create procedure searchSByname(in kw varchar(100))
begin
    select * from suppliers where supplierName like concat("%", kw , "%") COLLATE utf8_unicode_ci;
end #
\d ;

---------------------------------------------
\d # 
-- 輸入供應商電話查詢此供應商所有資料
create procedure searchSByphone(in kw varchar(100))
begin
    select * from suppliers where phone like concat("%", kw , "%") COLLATE utf8_unicode_ci;
end #
\d ;

----------------------------------------------
\d # 
-- 輸入產品名稱查詢此產品詳細資料
create procedure searchP(in kw varchar(100))
begin
    select * from products where productName like concat("%", kw , "%") COLLATE utf8_unicode_ci;
end #
\d ;

--------------------------------------------
\d # 
-- 輸入客戶id查詢此客戶所有訂單及訂單細項
create procedure searchOByC(in id int)
begin
    select o.orderID,o.number,o.customerName,od.productID,od.unitPrice,od.quantity from orders o
    join orderdetails od using(number)
    join customers c using(customerName)
    where c.customerID = id;
end #
\d ;

-------------------------------------------
\d # 
-- 輸入客戶id查詢此客戶各訂單之總價
create procedure searchPriceByC(in id int)
begin
    select *,unitPrice*quantity total from orderdetails where number in
    (select number from orders where customerName = (select customerName from customers 
    where customerID = id));
end #
\d ;

-------------------------------------------
\d # 
-- 輸入商品id查詢購買此產品的客戶及購買數量
create procedure searchCByP(in id int)
begin
    select p.productID,p.productName,o.customerName,od.quantity from orders o
    join orderdetails od using(number)
    join products p using(productID)
    where productID = id;
end #
\d ;

------------------------------------------
\d # 
-- 輸入供應商id查詢訂單中的商品清單
create procedure searchPByS(in id int)
begin
    select s.supplierName,od.number,p.productName from suppliers s
    join products p using(supplierID)
    join orderdetails od using(productID)
    where supplierID = id;
end #
\d ;

-----------------------------------------


