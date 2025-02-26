USE ProiectBazeLaborator;
GO

-- Inserting 10 records into Categories
INSERT INTO Categories VALUES('Books', 'Books for all ages');
INSERT INTO Categories VALUES('Toys', 'Toys for kids');
INSERT INTO Categories VALUES('Clothing', 'Clothing for everyone');
INSERT INTO Categories VALUES('Electronics', 'Electronics and gadgets');
INSERT INTO Categories VALUES('Home', 'Home appliances');
INSERT INTO Categories VALUES('Sports', 'Sports equipment');
INSERT INTO Categories VALUES('Beauty', 'Beauty products');
INSERT INTO Categories VALUES('Groceries', 'Everyday groceries');
INSERT INTO Categories VALUES('Health', 'Health and wellness products');
INSERT INTO Categories VALUES('Stationery', 'Office and school supplies');

-- Inserting 10 records into Products
INSERT INTO Products VALUES('Harry Potter', 25.5, 1);
INSERT INTO Products VALUES('LEGO Set', 40.0, 2);
INSERT INTO Products VALUES('T-Shirt', 15.0, 3);
INSERT INTO Products VALUES('Smartphone', 500.0, 4);
INSERT INTO Products VALUES('Vacuum Cleaner', 120.0, 5);
INSERT INTO Products VALUES('Football', 20.0, 6);
INSERT INTO Products VALUES('Lipstick', 12.5, 7);
INSERT INTO Products VALUES('Rice Bag', 30.0, 8);
INSERT INTO Products VALUES('Vitamin C', 15.0, 9);
INSERT INTO Products VALUES('Notebook', 5.0, 10);

-- Inserting 10 records into Clients
INSERT INTO Clients VALUES('Alexandra Popescu', 'Cluj-Napoca');
INSERT INTO Clients VALUES('Ion Popescu', 'Bucuresti');
INSERT INTO Clients VALUES('Maria Ionescu', 'Timisoara');
INSERT INTO Clients VALUES('Andrei Pop', 'Constanta');
INSERT INTO Clients VALUES('Ioana Vasilescu', 'Sibiu');
INSERT INTO Clients VALUES('Cristian Dumitrescu', 'Iasi');
INSERT INTO Clients VALUES('Elena Georgescu', 'Brasov');
INSERT INTO Clients VALUES('Mihai Marin', 'Bacau');
INSERT INTO Clients VALUES('Alina Roman', 'Oradea');
INSERT INTO Clients VALUES('George Vasile', 'Arad');

-- Inserting 10 records into Orders (without specifying order_id)
INSERT INTO Orders (total_price, client_id) VALUES(100.0, 1);
INSERT INTO Orders (total_price, client_id) VALUES(50.0, 2);
INSERT INTO Orders (total_price, client_id) VALUES(75.0, 3);
INSERT INTO Orders (total_price, client_id) VALUES(200.0, 4);
INSERT INTO Orders (total_price, client_id) VALUES(150.0, 5);
INSERT INTO Orders (total_price, client_id) VALUES(80.0, 6);
INSERT INTO Orders (total_price, client_id) VALUES(40.0, 7);
INSERT INTO Orders (total_price, client_id) VALUES(60.0, 8);
INSERT INTO Orders (total_price, client_id) VALUES(90.0, 9);
INSERT INTO Orders (total_price, client_id) VALUES(120.0, 10);

-- Inserting 10 records into Order_Product
INSERT INTO Order_Product VALUES(1, 1, 2, 40.0);
INSERT INTO Order_Product VALUES(1, 2, 3, 15.0);
INSERT INTO Order_Product VALUES(2, 1, 5, 120.0);
INSERT INTO Order_Product VALUES(2, 2, 1, 25.5);
INSERT INTO Order_Product VALUES(3, 1, 6, 20.0);
INSERT INTO Order_Product VALUES(3, 2, 8, 30.0);
INSERT INTO Order_Product VALUES(4, 1, 4, 500.0);
INSERT INTO Order_Product VALUES(4, 2, 7, 12.5);
INSERT INTO Order_Product VALUES(5, 1, 10, 5.0);
INSERT INTO Order_Product VALUES(5, 2, 9, 15.0);


SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Clients;
SELECT * FROM Orders;
SELECT * FROM Order_Product;


UPDATE Categories
SET description='UPDATED'
WHERE name='Clothing' and category_id=3

DELETE Order_Product
WHERE price_at_purchase	IS NULL

DELETE Categories
WHERE category_id >=4
DELETE FROM Products
WHERE category_id >= 4;


