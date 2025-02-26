CREATE DATABASE ProiectBazeLaborator;
GO

USE ProiectBazeLaborator;
GO

CREATE TABLE Categories(
	category_id INT PRIMARY KEY IDENTITY,
	name NVARCHAR(100) NOT NULL,
	description TEXT NOT NULL
);

CREATE TABLE Products(
	product_id INT PRIMARY KEY IDENTITY,
	name NVARCHAR(100) NOT NULL,
	price DECIMAL(10, 1) NOT NULL,
	category_id INT NOT NULL,
	FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Clients(
	client_id INT PRIMARY KEY IDENTITY,
	name VARCHAR(100),
	adress VARCHAR(200)
);

CREATE TABLE Orders(
	order_id INT PRIMARY KEY IDENTITY,
	order_date DATETIME NOT NULL DEFAULT GETDATE(),
	total_price DECIMAL(10,1),
	client_id INT,
	FOREIGN KEY(client_id)REFERENCES Clients(client_id)
);

Create TABLE Order_Product(
	order_item_id INT PRIMARY KEY IDENTITY,  
    order_id INT,                                  
    product_id INT,                                
    quantity INT NOT NULL,                         
    price_at_purchase DECIMAL(10, 1) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
)