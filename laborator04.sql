use ProiectBazeLaborator
go
---Problema 1


--Subpunct 3-Validare parametrii
create or alter function dbo.validateNameCategory
(@name varchar(100))
returns bit
as
begin
    if @name not like '%[^a-zA-Z .]%' and len(@name) >= 3
        return 1;
    return 0;
end
go

create or alter function dbo.validateProductPrice
(@price decimal(10, 1))
returns bit
as
begin
    if @price > 0
        return 1;
    return 0;
end
go

create or alter function dbo.validateQuantity
(@quantity int)
returns bit
as
begin
    if @quantity > 0
        return 1;
    return 0;
end
go


--Subpunct 1&2
create or alter procedure dbo.addCategory
(@category_name varchar(100), @description varchar(400))
as
begin
    if dbo.ValidateCategoryName(@category_name) = 1
    begin
        insert into Categories(name,description)
        values (@category_name, @description);
    end
    else
    begin
        raiserror('Error: Invalid category name.', 16, 1);
    end
end
go

create or alter procedure dbo.addProduct
(@product_name varchar(100), @price decimal(10, 1), @category_id int)
as
begin
    if dbo.validateProductPrice(@price) = 1
    begin
        insert into Products(name,price,category_id)
        values (@product_name,@price,@category_id);
    end
    else
    begin
        raiserror('Error:Invalid product price', 16, 1);
    end
end
go

create or alter procedure dbo.addOrderProduct
(@order_id int, @product_id int, @quantity int, @price_at_purchase decimal(10, 1))
as
begin
    if dbo.validateQuantity(@quantity) = 1
    begin
        insert into Order_Product(order_id,product_id,quantity,price_at_purchase)
        values (@order_id,@product_id,@quantity,@price_at_purchase);
    end
    else
    begin
        raiserror('Error: Invalid Quantity', 16, 1);
    end
end
go


--Problema 2 ->Order_Product&Clients&Products
create or alter view  dbo.OrderData as
select O.order_id, O.order_date, O.total_price, 
       C.name as client_name, C.adress as client_address,
       P.name as product_name, OP.quantity, OP.price_at_purchase
from Orders O
inner join Clients C on O.client_id = C.client_id
inner join Order_Product OP on O.order_id = OP.order_id
inner join Products P on OP.product_id = P.product_id;


--Problema 3
create or alter trigger dbo.OrderAddTrigger
on Orders
after insert
as
begin
    declare @time datetime = getdate();
    print 'Operation: Insert , Table: Orders ,Date: ' + cast(@time as varchar(50));
end
go

create or alter trigger dbo.OrderDeleteTrigger
on Orders
after delete
as
begin
    declare @time datetime = getdate();
    print 'Operation: Delete , Table: Orders , Date: ' + cast(@time as varchar(50));
end
go


--Problema 1 test
exec dbo.addCategory 'ertfrtrfgf', 'gfgfgfgf';
select * from Categories;

exec dbo.addProduct 'gffgfgfg', -10, 1;
select * from Products;

exec dbo.addOrderProduct 5, 1, 3, 10500;
select * from Order_Product;

--Problema 2 test
SELECT * FROM dbo.OrderData;

--Problema 3 test
insert into Orders(order_date,total_price,client_id)values ('2024-12-19', 5000, 1);
delete from Order_Product where order_id = 1 ;
delete from Orders where order_id = 7;
delete from Order_Product where order_item_id=7;
select * from Order_Product;s
select * from Orders;