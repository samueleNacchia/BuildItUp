DROP DATABASE IF EXISTS storage;
CREATE DATABASE storage;
USE storage;

DROP TABLE IF EXISTS ProductOrder;
DROP TABLE IF EXISTS Bills;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS UsersInfo;
DROP TABLE IF EXISTS Users;


CREATE TABLE Users (	
  ID int primary key AUTO_INCREMENT,
  email char(100) not null,
  password char(100) not null,
  isAdmin bool
);

CREATE TABLE UsersInfo (	
  ID int primary key,
  name char(50),
  surname char(50),
  via char(100),
  num int,
  postalCode char(5),
  tel char(16),
  foreign key(ID) references Users(ID) 
);


CREATE TABLE Products(	
  ID int primary key auto_increment,
  name char(50),
  description char(50),
  discount float unsigned,
  isOnSale boolean,
  stocks int unsigned,
  image1 blob,
  image2 blob,
  image3 blob
);

CREATE TABLE Orders (	
  ID int primary key auto_increment,
  date date,
  ID_user int not null,
  foreign key(ID_user) references Users(ID)
);

CREATE TABLE Reviews (	
  ID int primary key auto_increment,
  text char(100),
  upvote int,
  rating int,
  ID_user int not null,
  ID_product int not null,
  foreign key(ID_user) references Users(ID),
  foreign key(ID_product) references Products(ID)
);


CREATE TABLE Bills (	
  total decimal(10,2) unsigned,
  ID_order int not null,
  primary key (ID_order),
  foreign key(ID_order) references Orders(ID)
);


CREATE TABLE ProductOrder (	
  price decimal(10,2) unsigned,
  ID_product int not null,
  ID_order int not null,
  primary key (ID_product, ID_order),
  foreign key(ID_product) references Products(ID),
  foreign key(ID_order) references Orders(ID),
  quantity int unsigned not null
);


INSERT INTO Products (name, description, price, discount, isOnSale, stocks) VALUES 
("Samsung F8000","TV 48 pollici",549.99,0.1,true, 10),
("Corsair RAM 4GB","Random Access Memory",49.99,0.1,false, 10);










