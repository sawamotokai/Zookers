DROP DATABASE zookeeper;
CREATE DATABASE zookeeper;
USE zookeeper;

CREATE TABLE Staff (
		ID INTEGER PRIMARY KEY auto_increment,
		Name CHAR(255)
);

CREATE TABLE Cage (
	ID INT PRIMARY KEY auto_increment,
	Size INTEGER ,
	Location CHAR(255)
);

CREATE TABLE Animal (
	ID INT Primary Key auto_increment,
	Cage_ID INTEGER,
	Vet_ID INTEGER,
	Zookeeper_ID INTEGER,
	Species CHAR(255),
	Gender CHAR(1),
	Name CHAR(255),
	Age INTEGER,
	CONSTRAINT fk_vet FOREIGN KEY (Vet_ID) REFERENCES Staff(ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
    CONSTRAINT fk_zookeeper FOREIGN KEY (Zookeeper_ID) REFERENCES Staff(ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT fk_cage FOREIGN KEY (Cage_ID) REFERENCES Cage(ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);


CREATE TABLE Animal_Meal (
	Animal_ID INT,
	ID VARCHAR(255),
	Amount INT,
	Time DATETIME DEFAULT NOW(),
	Zookeeper_ID INTEGER, 
	Type CHAR(255),
	PRIMARY KEY (Animal_ID, ID),
	CONSTRAINT fk_feedee FOREIGN KEY (Animal_ID) REFERENCES Animal(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT fk_feeder FOREIGN KEY (Zookeeper_ID) REFERENCES Staff(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE Guest (
	Entry_Number INT UNSIGNED PRIMARY KEY auto_increment,
	Age INT,
	Payment_Method varchar(100)
);

CREATE TABLE Shows (
	show_name CHAR(255),
	show_time DATETIME DEFAULT NOW(),
	show_location CHAR(255),
	PRIMARY KEY (show_name, show_time)
);

CREATE TABLE Performs (
	Show_Name CHAR(255),
	Show_Time DATETIME,
	Staff_ID INTEGER ,
	Animal_ID INT,
	PRIMARY KEY (Show_Name, Show_Time, Staff_ID, Animal_ID),
	CONSTRAINT FK_show FOREIGN KEY (Show_Name, Show_Time) REFERENCES Shows(show_name, show_time)
	ON DELETE CASCADE
	ON UPDATE CASCADE ,
	CONSTRAINT FK_perfomingStaff FOREIGN KEY (Staff_ID) REFERENCES Staff(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE ,
	CONSTRAINT FK_performingAnimal FOREIGN KEY (Animal_ID) REFERENCES Animal(ID)
	ON DELETE CASCADE
	ON UPDATE CASCADE 
);

CREATE TABLE Charity (
	charity_name VARCHAR(255) PRIMARY KEY
);


CREATE TABLE Donates (
	ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Guest_Entry_Number INTEGER UNSIGNED NOT NULL,
	Charity_Name VARCHAR(255) NOT NULL,
	Amount INTEGER DEFAULT 0.0,
	CONSTRAINT FK_donator FOREIGN KEY (Guest_Entry_Number) REFERENCES Guest(Entry_Number),
	CONSTRAINT FK_donatee FOREIGN KEY (Charity_Name) REFERENCES Charity(charity_name)
);

CREATE TABLE Shop (
	Location CHAR(255),
	Name CHAR(255),
	Hours VARCHAR(255),
	PRIMARY KEY(Location, Name)
);

CREATE TABLE Product (
	Product_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
	Product_name CHAR(255)
);

CREATE TABLE Ticket_Price (
	Age_Range VARCHAR(20) PRIMARY KEY,
	Current_Rate INTEGER NOT NULL
);

CREATE TABLE Ticket (
	Product_ID INTEGER,
	Age_Range varchar(20),
	Number INTEGER,
	Current_Rate INTEGER,
	PRIMARY KEY(Product_ID, Number),
	CONSTRAINT FK_ticketId FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_price FOREIGN KEY(Age_Range) REFERENCES Ticket_Price(Age_Range) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Gift_Shop_Item (
	Product_ID INTEGER,
	ID INTEGER,
	Name CHAR(255),
	Price INTEGER,
	PRIMARY KEY(Product_ID, ID),
	CONSTRAINT FK_giftId FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID)
);


CREATE TABLE Buys (
	Purchase_Number INTEGER PRIMARY KEY AUTO_INCREMENT,
	Guest_Entry_Number INTEGER UNSIGNED NOT NULL,
	Product_ID INTEGER NOT NULL,
	Time DATETIME DEFAULT NOW(),
	Payment_Method varchar(100),
	CONSTRAINT FK_buyee FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID),
	CONSTRAINT FK_buyer FOREIGN KEY(Guest_Entry_Number) REFERENCES Guest(Entry_Number)
);


CREATE TABLE Works_At (
	Sales_Person_ID INTEGER,
	Location CHAR(255),
	Name CHAR(255),
	PRIMARY KEY (Sales_Person_ID, Location, Name),
	CONSTRAINT FK_worker FOREIGN KEY (Sales_Person_ID) REFERENCES Staff(ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT FK_workplace FOREIGN KEY(Location, Name) REFERENCES Shop(Location, Name)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE Watches (
	Guest_ID INTEGER UNSIGNED,
	Show_Name CHAR(255),
	Date_Time DATETIME DEFAULT NOW(),
	PRIMARY KEY(Guest_ID, Show_Name, Date_Time),
	CONSTRAINT FK_watcher FOREIGN KEY(Guest_ID) REFERENCES Guest(Entry_Number)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT FK_showToWatch FOREIGN KEY(Show_Name, Date_Time) REFERENCES Shows(show_name, show_time)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE Cleans (
	Zookeeper_ID INTEGER,
	Cage_ID  INT NOT NULL,
	Date_Time DATETIME DEFAULT NOW(),
	PRIMARY KEY(Zookeeper_ID, Cage_ID),
	CONSTRAINT FK_cleaningStaff FOREIGN KEY(Zookeeper_ID) REFERENCES Staff(ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT FK_cageToBeCleaned FOREIGN KEY(Cage_ID) REFERENCES Cage(ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE Item_Availability (
	Location CHAR(255),
	Name  CHAR(255),
	Product_ID INTEGER,
	PRIMARY KEY(Location, Name, Product_ID),
	CONSTRAINT FK_itemID FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT FK_shopLocation FOREIGN KEY(Location, Name) REFERENCES Shop(Location,Name)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

CREATE TABLE Trains (
	Zookeeper_ID INTEGER,
	Animal_ID  INT,
	PRIMARY KEY (Zookeeper_ID, Animal_ID),
	CONSTRAINT FK_trainer FOREIGN KEY(Zookeeper_ID) REFERENCES Staff(ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT FK_trainee FOREIGN KEY(Animal_ID) REFERENCES Animal(ID)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

#POPULATE THE DATABASE

#Staff
INSERT INTO staff(name)
VALUES("Bob Lamar"),
("Joe Pole"),
("Rosemary Thyme"),
("Benedict Cucumber"),
("Raymond Li"),
("James Shook"),
("Mario Lui"),
("Jessica Wang"),
("Kendrick Lemont"),
("William Po"),
("Edward Chen"),
("Henry Pizaz"),
("Loki Lawrence");

#Cage
INSERT INTO cage(location)
VALUES ("Ocean"), ("Forest"), ("Desert"), ("Tropics"), ("Snow");

#Animal
INSERT INTO animal(Cage_ID, Vet_ID, Zookeeper_ID, Species, Gender, Name, Age)
VALUES(2, 1, 3, "Bear", "M", "Bob", 20),
(2, 1, 3, "Bear", "F", "Bobina", 23),
(2, 1, 3, "Bear", "M", "Little Jimmy", 5),
(1, 3, 3, "Dolphin", "M", "Helen", 17),
(1, 3, 3, "Beluga", "M", "Booga", 38),
(3, 4, 3, "Camel", "F", "Brenda", 27),
(4, 5, 3, "Parrot", "M", "Cosmo", 34),
(4, 5, 3, "Sloth", "M", "Perry", 27),
(5, 6, 3, "Polar Bear", "M", "Blake", 28),
(5, 6, 3, "Penguin", "M", "Joe", 24),
(5, 6, 3, "Penguin", "M", "Suika", 22),
(5, 6, 3, "Penguin", "F", "Georgina", 8);

#Animal_Meal
INSERT INTO animal_meal
VALUES (1, 1, 20, adddate(NOW(), INTERVAL -13 HOUR), 5, "Fish"),
(2, 1, 30, adddate(NOW(), INTERVAL -13 HOUR), 5, "Fish"),
(3, 1, 5, now(), 5, "Fish"),
(3, 4, 10, adddate(NOW(), INTERVAL -13 HOUR), 9, "Pork"),
(5, 5, 16, now(), 7, "Pork"),
(6, 6, 17, adddate(NOW(), INTERVAL -13 HOUR), 8, "Lettuce"),
(7, 7, 18, adddate(NOW(), INTERVAL -13 HOUR), 10, "Banana"),
(9, 8, 29, now(), 12, "Pork"),
(12, 9, 30, adddate(NOW(), INTERVAL -13 HOUR), 11, "Fish");

#Product
INSERT INTO product(Product_name)
VALUES ("Bear plushie"),
("Dolphin mask"),
("Honey jar"),
("Sloth plushie"),
("Chocolate bar"),
("Admission coupons");

#Guest
INSERT INTO guest(Age, Payment_Method)
VALUES (20, "Cash"),
(21, "Credit"),
(22, "Credit"),
(23, "Cash"),
(5, "Cash"),
(6, "Cash"),
(2, "Credit"),
(13, "Credit"),
(67, "Coupon"),
(89, "Cash"),
(89, "Cash"),
(68, "Cash");

#Shop
INSERT INTO shop
VALUES ("1010 Zoo Road", "Bear Lovers", "09:00 - 17:00"),
("1020 Zoo Road", "Ice Ice Baby", "09:00 - 17:00"),
("2324 Grapevine Street", "The Wildlife", "10:00 - 15:00"),
("896 Ocean Road", "Ocean Eyes", "10:00 - 15:00"),
("1010 Sahara Street", "Desserts at the Desert", "09:00 - 17:00");

#Cleans
INSERT INTO cleans
VALUES 
(1, 1, adddate(NOW(), INTERVAL -13 HOUR)),
(1, 2, adddate(NOW(), INTERVAL -14 HOUR)),
(1, 3, adddate(NOW(), INTERVAL -19 HOUR)),
(1, 4, adddate(NOW(), INTERVAL -12 HOUR)),
(2, 4, adddate(NOW(), INTERVAL -14 HOUR)),
(2, 5, adddate(NOW(), INTERVAL -18 HOUR));


#Buys
INSERT INTO buys(guest_entry_number, product_ID, time, payment_method)
VALUES (1, 003, adddate(NOW(), INTERVAL -5 HOUR), "Cash"),
(2, 003, adddate(NOW(), INTERVAL -5 HOUR), "Cash"),
(3, 003, adddate(NOW(), INTERVAL -4 HOUR), "Credit"),
(1, 003, adddate(NOW(), INTERVAL -3 HOUR), "Cash"),
(1, 001, adddate(NOW(), INTERVAL -2 HOUR), "Cash");

#Charity
INSERT INTO charity(Charity_Name)
VALUES ("World Wildlife"), ("Bees Forever"), ("Fish Friends"), ("Tree Huggers"), ("SPCA");

#Donates    
INSERT INTO donates(Guest_Entry_Number, Charity_Name, Amount)
VALUES (001, "World Wildlife", 20),
(001, "Bees Forever", 20),
(001, "Fish Friends", 20),
(001, "Tree Huggers", 20),
(001, "SPCA", 20),
(010, "Bees Forever", 100),
(009, "Bees Forever", 20),
(004, "Tree Huggers", 15);

#Item_Availability
INSERT INTO item_availability
VALUES ("1010 Zoo Road", "Bear Lovers", 001),
("1020 Zoo Road", "Ice Ice Baby", 004),
("2324 Grapevine Street", "The Wildlife", 002),
("896 Ocean Road", "Ocean Eyes", 004),
("1010 Sahara Street", "Desserts at the Desert", 002);

#Works_At
INSERT INTO works_at
VALUES	 (10, "1010 Zoo Road", "Bear Lovers"),
(11, "1020 Zoo Road", "Ice Ice Baby"),
(12, "896 Ocean Road", "Ocean Eyes"),
(13, "896 Ocean Road", "Ocean Eyes");


#Ticket_Price
INSERT INTO ticket_price
VALUES ("0-5", 10),
("6-17", 15),
("18-65", 25),
("65+", 20);

#Ticket
INSERT INTO ticket
VALUES (001, "0-5", 1, 10),
(002, "6-17", 2, 15),
(003, "18-65", 3, 25),
(004, "65+", 4, 20);

#Shows
INSERT INTO shows
VALUES ("Bear Feed", adddate(NOW(), INTERVAL -5 HOUR), "Forest"),
("Sloth Nap", adddate(NOW(), INTERVAL -3 HOUR), "Forest"),
("Camel Training", adddate(NOW(), INTERVAL -1 HOUR), "Desert"),
("Penguin Dive", adddate(NOW(), INTERVAL +1 HOUR), "Snow"),
("Penguin Feed", adddate(NOW(), INTERVAL +1 HOUR), "Snow"),
("Polar Bears", adddate(NOW(), INTERVAL +2 HOUR), "Snow"),
("Parrot Talk", adddate(NOW(), INTERVAL +2 HOUR), "Tropics");

#Performs
INSERT INTO performs
VALUES ("Bear Feed", adddate(NOW(), INTERVAL -5 HOUR), 1, 1),
("Bear Feed", adddate(NOW(), INTERVAL -5 HOUR), 1, 2),
("Bear Feed", adddate(NOW(), INTERVAL -5 HOUR), 1, 3),
("Penguin Dive", adddate(NOW(), INTERVAL +1 HOUR), 2, 4),
("Penguin Feed", adddate(NOW(), INTERVAL +1 HOUR), 2, 4),
("Parrot Talk", adddate(NOW(), INTERVAL +2 HOUR), 4, 5);

#Watches
INSERT INTO watches
VALUES (1, "Bear Feed", adddate(NOW(), INTERVAL -5 HOUR)),
(2, "Bear Feed", adddate(NOW(), INTERVAL -5 HOUR)),
(3, "Penguin Dive", adddate(NOW(), INTERVAL +1 HOUR)),
(4, "Sloth Nap", adddate(NOW(), INTERVAL -3 HOUR)),
(5, "Camel Training", adddate(NOW(), INTERVAL -1 HOUR)),
(6, "Camel Training", adddate(NOW(), INTERVAL -1 HOUR)),
(7, "Sloth Nap", adddate(NOW(), INTERVAL -3 HOUR)),
(8, "Camel Training", adddate(NOW(), INTERVAL -1 HOUR));

#Trains
INSERT INTO trains
VALUES (1, 1),
(1, 2),
(1, 3),
(2, 4),
(3, 5),
(4, 7),
(4, 8),
(3, 9),
(4, 5);

#Gift_Shop_Item
INSERT INTO gift_shop_item
VALUES (1, 1, "Bear plushie", 10),
(1, 2, "Bear plushie", 10),
(1, 3, "Bear plushie", 10),
(2, 4, "Dolphin mask", 15),
(3, 5, "Honey jar", 5);
