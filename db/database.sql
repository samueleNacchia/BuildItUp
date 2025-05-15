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
  image1 blob,
  image2 blob,
  image3 blob
);

CREATE TABLE Orders (	
  ID int primary key auto_increment,
  date date,
  ID_user int not null,
  status enum('In elaborazione', 'Elaborato', 'Spedito', 'Consegnato', 'Annullato'),
  foreign key(ID_user) references Users(ID)
);

CREATE TABLE Reviews (	
  ID int primary key auto_increment,
  text char(100),
  vote int unsigned,
  ID_user int not null,
  ID_product int not null,
  foreign key(ID_user) references Users(ID),
  foreign key(ID_product) references Products(ID)
);


CREATE TABLE Bills (	
  total decimal(10,2) unsigned,
  ID_order int primary key not null,
  data date,
  foreign key(ID_order) references Orders(ID)
);


CREATE TABLE ProductOrder (	
  price decimal(10,2) unsigned,
  ID_product int not null,
  ID_order int not null,
  quantity int unsigned not null,
  primary key (ID_product, ID_order),
  foreign key(ID_product) references Products(ID),
  foreign key(ID_order) references Orders(ID)
);


CREATE TABLE NewsLetters (	
  email char(100) primary key
);

INSERT INTO Admin (username, password) VALUES 
("root","1234"), 
("root2","123");

INSERT INTO Products (name, category, description, price, discount, isOnSale, stocks) VALUES 
("Samsung F8000","CPU","TV 48 pollici",549.99,0.1,true, 10),
("Corsair RAM 4GB","RAM","Random Access Memory",49.99,0.1,false, 10),
("Corsair RAM 8GB","RAM","Random Access Memory",99.99,0.15,true, 5);

INSERT INTO Users (email, password, name, surname, via, roadNum, postalCode, tel) VALUES 
("r.mario@gmail.com","gsgsgggfvv","Marco","Rossi","Via taurano",22,"02134","3500224315"),
("samuele@gmail.com","safaagddsa","Samuele","Nacchia","Via taurano",13,"02134","3500201233");
