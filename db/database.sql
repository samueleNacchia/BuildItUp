DROP DATABASE IF EXISTS storage;
CREATE DATABASE storage;
USE storage;

DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS ProductOrder;
DROP TABLE IF EXISTS Bills;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Users;

CREATE TABLE Admin (	
  username char(50) not null,
  password char(128) not null,
  primary key(username, password)
);

CREATE TABLE Users (	
  ID int primary key AUTO_INCREMENT,
  email char(100) not null,
  password char(100) not null,
  name char(50),
  surname char(50),
  via char(100),
  roadNum int unsigned,
  postalCode char(5),
  tel char(16)
);


CREATE TABLE Products(	
  ID int primary key auto_increment,
  name char(50),
  category enum('CPU', 'GPU', 'MOBO', 'CASE', 'COOLING', 'RAM', 'MEM', 'PSU'),
  description char(50),
  price decimal(10,2) unsigned,
  discount decimal(5,4) unsigned,
  isOnSale boolean,
  stocks int unsigned,
  image1 mediumblob,
  image2 mediumblob,
  image3 mediumblob
);

CREATE TABLE Orders (	
  ID int primary key auto_increment,
  ID_user int not null,
  orderDate date,
  status enum('In_elaborazione', 'Elaborato', 'Spedito', 'Consegnato', 'Annullato'),
  foreign key(ID_user) references Users(ID)
);

CREATE TABLE Reviews (	
  ID_user int not null,
  ID_product int not null,
  text char(100),
  vote int unsigned,
  reviewDate date,
  primary key (ID_user, ID_product), 
  foreign key(ID_user) references Users(ID),
  foreign key(ID_product) references Products(ID)
);


CREATE TABLE Bills (	
  ID_order int primary key not null,
  total decimal(10,2) unsigned,
  billDate date,
  foreign key(ID_order) references Orders(ID)
);


CREATE TABLE ProductOrder (	
  ID_product int not null,
  ID_order int not null,
  price decimal(10,2) unsigned,
  quantity int default 1 check (quantity > 0),
  primary key (ID_product, ID_order),
  foreign key(ID_product) references Products(ID),
  foreign key(ID_order) references Orders(ID)
);


CREATE TABLE Lists (
    ID int primary key auto_increment,
    ID_user int, -- NULL per utenti anonimi
    type enum('cart', 'wishlist') not null,
    CONSTRAINT unique_user_type UNIQUE (ID_user, type),
    lastAccess timestamp default CURRENT_TIMESTAMP
);

CREATE TABLE ItemList (
    ID_list int not null,
    ID_product int not null,
    quantity int check (quantity > 0), -- NULL per liste di tipo "cart"
    foreign key (ID_list) references Lists(ID) on delete cascade,
    foreign key (ID_product) references Products(ID), 
    primary key (ID_list, ID_product)
);    


CREATE TABLE Newsletters (
	email char(100) primary key not null
);

-- Admins
INSERT INTO Admin (username, password) VALUES
  ('admin1', '5f4dcc3b5aa765d61d8327deb882cf99'),
  ('admin2', '202cb962ac59075b964b07152d234b70'),
  ('superuser', '098f6bcd4621d373cade4e832627b4f6');

-- Users
INSERT INTO Users (email, password, name, surname, via, roadNum, postalCode, tel) VALUES
  ('mario.rossi@example.com', 'pass1234', 'Mario', 'Rossi', 'Via Roma', 10, '00100', '1234567890'),
  ('luca.verdi@example.com', 'password', 'Luca', 'Verdi', 'Via Milano', 5, '20100', '0987654321'),
  ('anna.bianchi@example.com', 'ciao1234', 'Anna', 'Bianchi', 'Corso Italia', 20, '10100', '1122334455');

-- Products
INSERT INTO Products (name, category, description, price, discount, isOnSale, stocks) VALUES
  ('Intel i7 13700K', 'CPU', '13th gen 16-core processor', 429.99, 0.1000, TRUE, 25),
  ('NVIDIA RTX 4070', 'GPU', '8GB GDDR6X ray tracing card', 599.99, 0.0500, TRUE, 10),
  ('MSI B650 Tomahawk', 'MOBO', 'AM5 socket ATX motherboard', 199.90, 0.0000, FALSE, 8),
  ('Corsair 4000D', 'CASE', 'Mid tower case with airflow', 89.99, 0.1500, TRUE, 20);

-- Orders
INSERT INTO Orders (ID_user, orderDate, status) VALUES
  (1, '2025-05-10' , 'Consegnato'),
  (2, '2025-05-12' , 'Spedito'),
  (3, '2025-05-13' , 'In_elaborazione');

-- Reviews
INSERT INTO Reviews (ID_user, ID_product, text, vote, reviewDate) VALUES
  (1, 1, 'Ottimo processore, molto veloce!', 5, '2025-05-11'),
  (2, 2, 'Prestazioni eccezionali in 1440p!', 4, '2025-05-13'),
  (3, 4, 'Case ben ventilato ma un pò rumoroso.', 3, '2025-05-14');

-- Bills
INSERT INTO Bills (ID_order, total, billDate) VALUES
  (1, 516.98, '2025-05-10'),
  (2, 629.99, '2025-05-12');

-- ProductOrder
INSERT INTO ProductOrder (ID_product, ID_order, price, quantity) VALUES
  (1, 1, 429.99, 1),
  (4, 1, 89.99, 1),
  (2, 2, 599.99, 1),
  (3, 3, 199.90, 1);
  
-- Lists
INSERT INTO Lists (ID_user, type, lastAccess) VALUES
(10, 'cart', CURRENT_TIMESTAMP),
(10, 'wishlist', CURRENT_TIMESTAMP),
(20, 'cart', CURRENT_TIMESTAMP),
(NULL, 'cart', CURRENT_TIMESTAMP);

-- ItemList
INSERT INTO ItemList (ID_list, ID_product, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, NULL),
(3, 1, 1),
(4, 2, 4);

-- Newsletters
INSERT INTO Newsletters (email) VALUES
('mario.rossi@example.com'),
('giulia.bianchi@example.com'),
('andrea.verdi@example.com');
  

SELECT * FROM Admin;

SELECT * FROM Users;

SELECT * FROM Products;

SELECT * FROM Orders;

SELECT * FROM Reviews;

SELECT * FROM Bills;

SELECT * FROM ProductOrder;

SELECT * FROM Newsletters;

SELECT * FROM Lists;

SELECT * FROM ItemList;