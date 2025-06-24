DROP DATABASE IF EXISTS storage;
CREATE DATABASE storage;
USE storage;
SET GLOBAL max_connections = 500;

CREATE TABLE Admin (
  email varchar(100) not null,
  password varchar(128) not null,
  primary key(email, password)
);

CREATE TABLE Users (	
  ID int primary key AUTO_INCREMENT,
  email varchar(100) not null,
  password varchar(128) not null,
  name varchar(50),
  surname varchar(50),
  via varchar(100),
  roadNum int unsigned,
  postalCode varchar(5),
  tel varchar(16),
  prov char(2)
);


CREATE TABLE Products(	
  ID int primary key auto_increment,
  name varchar(50),
  category enum('CPU', 'GPU', 'MOBO', 'CASE', 'COOLING', 'RAM', 'MEM', 'PSU'),
  description varchar(256),
  price decimal(10,2) unsigned,
  discount decimal(5,4) unsigned,
  isOnSale boolean,
  numReview int default 0,
  avgReview decimal(10,1),
  stocks int unsigned
);

CREATE TABLE ProductImages (
  ID int primary key auto_increment,	
  ID_product int not null,
  image mediumblob,
  isCover boolean default false,
  
  -- Colonna generata: contiene product_id solo se is_cover è TRUE
    isCover_flag INT GENERATED ALWAYS AS (
        CASE WHEN isCover THEN ID_product ELSE NULL END
    ) STORED,

    -- Indicizzazione univoca solo per i valori con is_cover = TRUE
    UNIQUE KEY unique_cover_per_product (isCover_flag)
);

CREATE TABLE Orders (	
  ID int primary key auto_increment,
  ID_user int not null,
  orderDate date,
  via varchar(100),
  roadNum int unsigned,
  postalCode varchar(5),
  tel varchar(16),
  prov char(2),
  status enum('In_elaborazione', 'Elaborato', 'Spedito', 'Consegnato', 'Annullato'),
  foreign key(ID_user) references Users(ID)
);

CREATE TABLE Reviews (	
  ID_user int not null,
  ID_product int not null,
  text varchar(100),
  vote int unsigned,
  reviewDate date,
  IsVerified boolean,
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
    token varchar(128) UNIQUE, -- NULL per utenti anonimi
    ID_user int, -- NULL per utenti anonimi
    type enum('cart', 'wishlist') not null,
    CONSTRAINT unique_user_type UNIQUE (ID_user, type),
    lastAccess timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_user) REFERENCES Users(ID)
);

CREATE TABLE ItemList (
    ID_list int not null,
    ID_product int not null,
    quantity int check (quantity > 0), -- NULL per liste di tipo "wishlist"
    foreign key (ID_list) references Lists(ID) on delete cascade,
    foreign key (ID_product) references Products(ID), 
    primary key (ID_list, ID_product)
);    


CREATE TABLE Newsletters (
	email varchar(100) primary key not null
);

-- Admins pass: 123123
INSERT INTO Admin (email, password) VALUES
  ('admin@gmail.com', 
  '263fec58861449aacc1c328a4aff64aff4c62df4a2d50b3f207fa89b6e242c9aa778e7a8baeffef85b6ca6d2e7dc16ff0a760d59c13c238f6bcdc32f8ce9cc62');

-- Products
INSERT INTO Products (name, category, description, price, discount, isOnSale, stocks) VALUES
  ('Intel i7 13700K', 'CPU', '13th gen 16-core processor', 429.99, 0.1000, TRUE, 25),
  ('NVIDIA RTX 4070', 'GPU', '8GB GDDR6X ray tracing card', 569.99, 0.0500, TRUE, 10),
  ('MSI B650 Tomahawk', 'MOBO', 'AM5 socket ATX motherboard', 199.90, 0.0000, FALSE, 8),
  ('AMD Ryzen 9 7950X', 'CPU', '16-core high-performance processor', 529.00, 0.1500, TRUE, 20),
  ('ASUS ROG Strix RTX 4080', 'GPU', '16GB GDDR6X ray tracing card', 1199.99, 0.1000, TRUE, 12),
  ('Gigabyte X670 AORUS Elite', 'MOBO', 'AM5 socket ATX motherboard', 269.90, 0.0500, TRUE, 15),
  ('Corsair Vengeance LPX 16GB', 'RAM', 'DDR4 3200MHz memory kit', 49.99, 0.0000, FALSE, 40),
  ('Samsung 970 EVO Plus 1TB', 'MEM', 'NVMe M.2 internal SSD', 129.99, 0.1000, TRUE, 30),
  ('Seagate Barracuda 2TB', 'MEM', '7200 RPM desktop hard drive', 59.99, 0.0000, FALSE, 25),
  ('Cooler Master Hyper 212', 'COOLING', 'Air CPU cooler with RGB', 39.99, 0.2000, TRUE, 50),
  ('NZXT H510 Elite', 'CASE', 'Mid-tower PC case with tempered glass', 149.99, 0.0000, FALSE, 10),
  ('EVGA SuperNOVA 750W', 'PSU', 'Modular power supply unit', 99.99, 0.1000, TRUE, 22),
  ('Thermaltake Toughpower 850W', 'PSU', '80+ Gold modular power supply', 109.99, 0.0000, FALSE, 15),
  ('AMD Radeon RX 7900 XT', 'GPU', '24GB GDDR6 gaming card', 699.99, 0.0800, TRUE, 10),
  ('Kingston Fury Beast 32GB', 'RAM', 'DDR5 5200MHz memory kit', 249.99, 0.1000, TRUE, 20),
  ('Intel i5 13600KF', 'CPU', '14-core processor, unlocked for overclocking', 199.99, 0.0800, TRUE, 18),
  ('NVIDIA RTX 4060 Ti', 'GPU', '8GB GDDR6 mid-range GPU', 399.99, 0.0600, TRUE, 15),
  ('ASRock B650M Pro RS', 'MOBO', 'AM5 mATX motherboard with DDR5 support', 149.90, 0.0000, FALSE, 10),
  ('Be Quiet! Pure Power 11 650W', 'PSU', '80+ Gold quiet power supply', 94.99, 0.0000, FALSE, 18),
  ('Noctua NH-D15', 'COOLING', 'Premium dual tower CPU cooler', 99.95, 0.1500, TRUE, 12),
  ('G.Skill Trident Z5 32GB', 'RAM', 'DDR5 6000MHz memory kit', 159.99, 0.1200, TRUE, 16),
  ('Crucial P3 Plus 2TB', 'MEM', 'PCIe 4.0 NVMe M.2 SSD', 144.99, 0.1000, TRUE, 25),
  ('Fractal Design Meshify C', 'CASE', 'Compact ATX case with mesh front panel', 99.99, 0.0000, TRUE, 8),
  ('NVIDIA RTX 4080', 'GPU', '16GB GDDR6X ray tracing card', 699.99, 0.0500, TRUE, 10),
  ('NVIDIA RTX 3070 ti', 'GPU', '8GB GDDR6X ray tracing card', 399.99, 0.0500, TRUE, 10);