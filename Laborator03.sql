USE ProiectBazeLaborator;
GO

SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Clients;
SELECT * FROM Orders;
SELECT * FROM Order_Product;

--Selecteam produsele care apartin din categoria 'Books' 'si Clothing'
select P.product_id,P.name from Products P
inner join Categories C on P.category_id=C.category_id
where C.name='Books'
union
select P.product_id,P.name from Products P
inner join Categories C ON P.category_id = C.category_id
where C.name = 'Clothing';


--Selectam doar o singura data clintii care locuiesc in Cluj-Napoca si au suma comenzii>150 si numele lor nu este Andrei.
select distinct C.client_id,C.name as client_name, C.adress
from Clients C
inner join Orders O ON C.client_id = O.client_id
where  (C.adress='Cluj-Napoca' or O.total_price>150) and not C.name like 'Andrei%'



--Selectam numele produsului si al categoriei acestuia si cantitaea de produse din comanda 
select P.product_id, P.name as product_name, C.name as category_name, 
       SUM(OP.quantity) as total_quantity_ordered from Products P
left join Categories C on P.category_id = C.category_id
left join Order_Product OP on P.product_id = OP.product_id
group by P.product_id, P.name, C.name;



--Selectam numarul de produse din fiecare categorie
select C.name as category_name, COUNT(P.product_id) as product_count
from Categories C
inner join Products P ON C.category_id = P.category_id
group by C.name;



--Selectam clientul care a cheltuit suma totala a comenzii cea mai mare
select CL.name as client_name, SUM(O.total_price) as total_spent
from Clients CL
inner join Orders O on CL.client_id = O.client_id
group by CL.name
having Max(O.total_price)>150;


--selecteaza clinetii cu comenzi ce includ produse din categoria books
select C.name as client_name from Clients C
where C.client_id in (
    select O.client_id
    from Orders O
    inner join Order_Product OP ON O.order_id = OP.order_id
    inner join Products P ON OP.product_id = P.product_id
    where P.category_id = (
        select category_id
        from Categories
        where name = 'Books'
    )
);


-- Validate Category Name Function
CREATE FUNCTION dbo.ValidateCategoryName(@name NVARCHAR(100))
RETURNS BIT
AS
BEGIN
    IF @name IS NULL OR LEN(@name) < 3
        RETURN 0 -- Invalid name
    RETURN 1 -- Valid name
END;

-- Insert Category Procedure
CREATE PROCEDURE dbo.InsertCategory
    @name NVARCHAR(100),
    @description NVARCHAR(MAX)
AS
BEGIN
    -- Validate category name
    IF dbo.ValidateCategoryName(@name) = 0
    BEGIN
        PRINT 'Category name is invalid (must be at least 3 characters long).';
        RETURN;
    END

    -- Insert category
    INSERT INTO Categories (name, description)
    VALUES (@name, @description);
END;

-- Validate Product Price Function
CREATE FUNCTION dbo.ValidateProductPrice(@price DECIMAL(10, 1))
RETURNS BIT
AS
BEGIN
    IF @price <= 0
        RETURN 0 -- Invalid price
    RETURN 1 -- Valid price
END;

-- Insert Product Procedure
CREATE PROCEDURE dbo.InsertProduct
    @name NVARCHAR(100),
    @price DECIMAL(10, 1),
    @category_id INT
AS
BEGIN
    -- Validate product price
    IF dbo.ValidateProductPrice(@price) = 0
    BEGIN
        PRINT 'Product price must be greater than zero.';
        RETURN;
    END

    -- Insert product
    INSERT INTO Products (name, price, category_id)
    VALUES (@name, @price, @category_id);
END;

-- Validate Quantity Function
CREATE FUNCTION dbo.ValidateQuantity(@quantity INT)
RETURNS BIT
AS
BEGIN
    IF @quantity <= 0
        RETURN 0 -- Invalid quantity
    RETURN 1 -- Valid quantity
END;

-- Insert OrderProduct Procedure
CREATE PROCEDURE dbo.InsertOrderProduct
    @order_id INT,
    @product_id INT,
    @quantity INT,
    @price_at_purchase DECIMAL(10, 1)
AS
BEGIN
    -- Validate quantity
    IF dbo.ValidateQuantity(@quantity) = 0
    BEGIN
        PRINT 'Quantity must be greater than zero.';
        RETURN;
    END

    -- Insert order product
    INSERT INTO Order_Product (order_id, product_id, quantity, price_at_purchase)
    VALUES (@order_id, @product_id, @quantity, @price_at_purchase);
END;

-- Create OrderDetails View
CREATE VIEW dbo.OrderDetails AS
SELECT O.order_id, O.order_date, O.total_price, 
       C.name AS client_name, COALESCE(C.adress, 'Address Not Provided') AS client_address,
       P.name AS product_name, OP.quantity, OP.price_at_purchase
FROM Orders O
INNER JOIN Clients C ON O.client_id = C.client_id
INNER JOIN Order_Product OP ON O.order_id = OP.order_id
INNER JOIN Products P ON OP.product_id = P.product_id;

-- Order Insert Trigger with RAISEERROR
CREATE TRIGGER dbo.OrderInsertTrigger
ON Orders
FOR INSERT
AS
BEGIN
    DECLARE @current_date DATETIME = GETDATE();
    RAISERROR('INSERT operation performed on Orders table at %s.', 0, 1, @current_date);
END;

-- Order Delete Trigger with RAISEERROR
CREATE TRIGGER dbo.OrderDeleteTrigger
ON Orders
FOR DELETE
AS
BEGIN
    DECLARE @current_date DATETIME = GETDATE();
    RAISERROR('DELETE operation performed on Orders table at %s.', 0, 1, @current_date);
END;

-- Product Insert Trigger with RAISEERROR
CREATE TRIGGER dbo.ProductInsertTrigger
ON Products
FOR INSERT
AS
BEGIN
    DECLARE @current_date DATETIME = GETDATE();
    RAISERROR('INSERT operation performed on Products table at %s.', 0, 1, @current_date);
END;

-- Product Delete Trigger with RAISEERROR
CREATE TRIGGER dbo.ProductDeleteTrigger
ON Products
FOR DELETE
AS
BEGIN
    DECLARE @current_date DATETIME = GETDATE();
    RAISERROR('DELETE operation performed on Products table at %s.', 0, 1, @current_date);
END;
