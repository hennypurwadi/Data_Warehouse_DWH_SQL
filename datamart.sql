DROP DATABASE IF EXISTS datamart;
CREATE DATABASE IF NOT EXISTS datamart; 
USE datamart;

DROP TABLE IF EXISTS	
city, country, property_commission, facility, property_type,
neighborhood, amenities, room_type, property_host, property, room,
property_review, guest_review, guest_commission, guest,
booking, payment, voucher, cancelation, payment_status;


CREATE TABLE country (
    countryID INTEGER AUTO_INCREMENT,
    country_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (countryID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE city (
    cityID INTEGER AUTO_INCREMENT,
    countryID INTEGER,
    city_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (cityID),
    FOREIGN KEY (countryID)
        REFERENCES country (countryID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE property_commission (
    property_commissionID INTEGER AUTO_INCREMENT,
    property_commission DECIMAL(3 , 2 ) NOT NULL,
    PRIMARY KEY (property_commissionID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE property_type (
    property_typeID INTEGER AUTO_INCREMENT,
    property_type VARCHAR(50),
    PRIMARY KEY (property_typeID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE neighborhood (
    neighborhoodID INTEGER AUTO_INCREMENT,
    cityID INTEGER,
    neighborhood_name VARCHAR(50),
    PRIMARY KEY (neighborhoodID),
    FOREIGN KEY (cityID)
        REFERENCES city (cityID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE property_host (
    hostID INTEGER AUTO_INCREMENT,
    host_firstname VARCHAR(50),
    host_lastname VARCHAR(50),
    host_address VARCHAR(200),
    host_email VARCHAR(50),
    host_password CHAR(8),
    host_phone VARCHAR(20),
    host_join_date DATETIME,
    host_active BOOLEAN,
    PRIMARY KEY (hostID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE property (
    propertyID INTEGER AUTO_INCREMENT,
    hostID INTEGER,
    property_typeID INTEGER,
    neighborhoodID INTEGER,
    property_commissionID INTEGER,
    property_name VARCHAR(50),
    property_address VARCHAR(200),
    property_size DECIMAL(10 , 2 ),
    property_rating INTEGER,
    qty_room INTEGER,
    PRIMARY KEY (propertyID),
    FOREIGN KEY (property_commissionID)
        REFERENCES property_commission (property_commissionID),
    FOREIGN KEY (hostID)
        REFERENCES property_host (hostID),
    FOREIGN KEY (property_typeID)
        REFERENCES property_type (property_typeID),
    FOREIGN KEY (neighborhoodID)
        REFERENCES neighborhood (neighborhoodID),
    last_update TIMESTAMP DEFAULT now() 
);


CREATE TABLE facility (
    facilityID INTEGER AUTO_INCREMENT,
    propertyID INTEGER,
    internet BOOLEAN,
    parking BOOLEAN,
    swimmingpool BOOLEAN,
    PRIMARY KEY (facilityID),
    FOREIGN KEY (propertyID)
        REFERENCES property (propertyID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE room_type (
    room_typeID INTEGER AUTO_INCREMENT,
    room_type INTEGER,
    PRIMARY KEY (room_typeID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE room (
    roomID INTEGER AUTO_INCREMENT,
    room_typeID INTEGER,
    propertyID INTEGER,
    room_name VARCHAR(50),
    room_number INTEGER,
    room_size INTEGER,
    room_rate DECIMAL,
    room_availability BOOLEAN,
    PRIMARY KEY (roomID),
    FOREIGN KEY (room_typeID)
        REFERENCES room_type (room_typeID),
    FOREIGN KEY (propertyID)
        REFERENCES property (propertyID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE amenities (
    amenitiesID INTEGER AUTO_INCREMENT,
    roomID INTEGER,
    internet BOOLEAN,
    aircon BOOLEAN,
    heating BOOLEAN,
    washer BOOLEAN,
    television BOOLEAN,
    kettle BOOLEAN,
    refrigerator BOOLEAN,
    PRIMARY KEY (amenitiesID),
    FOREIGN KEY (roomID)
        REFERENCES room (roomID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE guest_commission(
guest_commissionID INTEGER AUTO_INCREMENT,
guest_commission DECIMAL(3,2), 
PRIMARY KEY (guest_commissionID), 
last_update TIMESTAMP DEFAULT now() 
); 

CREATE TABLE guest (
    guestID INTEGER AUTO_INCREMENT,
    guest_commissionID INTEGER,
    guest_rating INTEGER,
    guest_firstname VARCHAR(50),
    guest_lastname VARCHAR(50),
    guest_address VARCHAR(50),
    guest_email VARCHAR(50),
    guest_password CHAR(8),
    guest_phone VARCHAR(20),
    guest_create_date DATETIME,
    guest_active BOOLEAN,
    guest_level INTEGER,
    PRIMARY KEY (guestID),
    FOREIGN KEY (guest_commissionID) REFERENCES guest_commission(guest_commissionID), 
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE property_review (
    property_reviewID INTEGER AUTO_INCREMENT,
    propertyID INTEGER,
    guestID INTEGER,
    cleanliness INTEGER,
    communication INTEGER,
    pvalue INTEGER,
    location INTEGER,
    amenities INTEGER,
    internet INTEGER,
    service INTEGER,
    PRIMARY KEY (property_reviewID),
    FOREIGN KEY (guestID)
        REFERENCES guest(guestID),
    FOREIGN KEY (propertyID)
        REFERENCES property (propertyID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE guest_review (
    guest_reviewID INTEGER AUTO_INCREMENT,
    guestID INTEGER,
    hostID INTEGER,
    guest_rate INTEGER,
    guest_review TEXT,
    PRIMARY KEY (guest_reviewID),
    FOREIGN KEY (guestID)
        REFERENCES guest (guestID),
    FOREIGN KEY (hostID)
        REFERENCES property_host (hostID),
    last_update TIMESTAMP DEFAULT now() 
);

CREATE TABLE cancelation (
cancelationID INTEGER AUTO_INCREMENT,
cancel_charge DECIMAL(10,2),
PRIMARY KEY (cancelationID), 
last_update TIMESTAMP DEFAULT now() 
); 

CREATE TABLE booking (
bookingID INTEGER AUTO_INCREMENT,
roomID INTEGER, 
guestID INTEGER,
hostID INTEGER, 
booking_date TIMESTAMP,
checkin_date DATE,
checkout_date DATE,
cancelationID INTEGER,
free_cancel_date DATETIME,
PRIMARY KEY (bookingID), 
FOREIGN KEY (roomID) REFERENCES room(roomID),
FOREIGN KEY (guestID) REFERENCES guest(guestID),
FOREIGN KEY (hostID) REFERENCES property_host(hostID),
FOREIGN KEY (cancelationID) REFERENCES cancelation(cancelationID),
CHECK (booking_date <= free_cancel_date <= checkin_date < checkout_date),
last_update TIMESTAMP DEFAULT now() ); 

CREATE TABLE voucher (
voucherID INTEGER AUTO_INCREMENT,
voucher VARCHAR(20), discount DECIMAL(10,2), 
PRIMARY KEY (voucherID), 
last_update TIMESTAMP DEFAULT now() 
); 

CREATE TABLE payment_status (
payment_statusID INTEGER AUTO_INCREMENT,
payment_status VARCHAR(50),
PRIMARY KEY (payment_statusID), 
last_update TIMESTAMP DEFAULT now() 
); 

CREATE TABLE payment (
paymentID INTEGER AUTO_INCREMENT,
payment_statusID INTEGER,
bookingID INTEGER, 
voucherID INTEGER,
amount DECIMAL(10,2),
payment_date TIMESTAMP,
PRIMARY KEY (paymentID), 
FOREIGN KEY (payment_statusID) REFERENCES payment_status(payment_statusID),
FOREIGN KEY (bookingID) REFERENCES booking(bookingID),
FOREIGN KEY (voucherID) REFERENCES voucher(voucherID),
last_update TIMESTAMP DEFAULT now() 
); 

INSERT INTO country(country_name) VALUES ('Indonesia'),('Malaysia'),('Singapore'),('Thailand'),
('Vietnam'),('Japan'),('Germany'),('Ireland'),('Netherlands'),('Italy'),('Switzerland'),('USA'),
('Canada'),('Mexico'),('Brazil'),('Egypt'),('Nigeria'),('Algeria'),('Kenya'),('Australia');

INSERT INTO city(countryID, city_name) VALUES (1,'Denpasar'),(1,'Jakarta'),(1,'Yogyakarta'),(2,'KualaLumpur'),
(2,'JohorBahru'),(4,'Bangkok'),(4,'Phuket'),(5,'Hanoi'),(6,'Tokyo'),(6,'Kyoto'),(6,'Osaka'),(6,'Yokohama'),
(6,'Nagoya'),(7,'Berlin'),(7,'Munich'),(7,'Dusseldorf'),(8,'Dublin'),(9,'Amsterdam'),(13,'Vancouver'),(13,'Toronto');

INSERT INTO property_commission(property_commission) VALUES (0.01),(0.02),(0.03),(0.04),(0.05),(0.06),(0.07),
(0.08),(0.09),(0.1),(0.11),(0.12),(0.13),(0.14),(0.15),(0.16),(0.17),(0.18),(0.19),(0.2);

INSERT INTO property_type(property_type) VALUES ('Hotel'),('Guesthouse'),('Vacationhome'),('Homestay'),
('Apartment'),('Hostel'),('Villa'),('BedAndbreakfast'),('ResortVillage'),('Resort'),('Lodge'),('Capsule'),
('Motel'),('CountryHouse'),('LuxuryTent'),('Boat'),('Camper'),('Hut'),('Bus'),('Cave');

INSERT INTO neighborhood (cityID, neighborhood_name) VALUES (1,'Renon'),(2,'Gambir'),(3,'Malioboro'),(4,'Ampang'),
(5,'BukitIndah'),(6,'Laksi'),(7,'OldTown'),(8,'OldQuarter'),(9,'Taito'),(10,'Sanjo'),(11,'Minami'),(12,'Kannai'),
(13,'Osu'),(14,'Mitte'),(15,'Laim'),(6,'Rath'),(17,'Clontarf'),(18,'Oost'),(19,'Dunbar'),(20,'Scarborough');

INSERT INTO property_host (
host_firstname, host_lastname, host_address, host_password, host_email, 
host_phone, host_join_date, host_active) 
VALUES 
('Putu','Ayu','NgurahRai','***','payu@gmail.com','6281281533666','2021-07-01', TRUE),
('Eka','Bagus','Matraman','***','ebagus@gmail.com','628222778457','2021-07-02', TRUE),
('Kusumo','Cakil','Timoho','***','kcakil@gmail.com','628445556679','2021-07-03', TRUE),
('Afia','Devia','Jalan Ampang','***','adevia@gmail.com','606734529','2021-07-04', TRUE),
('Zikri','Eko','Jalan Indah','***','zeko@gmail.com','605432617','2021-07-05', TRUE),
('Fa','Ying','Sukhumvit Road','***','fying@gmail.com','6655662239','2021-07-06', FALSE),
('Mae','Noi','Bangla Road','***','mnoi@gmail.com','6636679566','2021-07-07', TRUE),
('Nguyen','Ngok','Hang Trong Street','***','nngok@gmail.com','847679566','2021-07-08', TRUE),
('Toru','Hanada','Matsugaya','***','thanada@gmail.com','815687066','2021-07-09', TRUE),
('Sachiko','Ryu','Shijo Street','***','sryu@gmail.com','817764223','2021-07-10', TRUE),
('Eiko','Hikari','Midosuji','***','ehikari@gmail.com','815422375','2021-07-11', FALSE),
('Inori','Rin','Kitasaiwai','***','irin@gmail.com','814456788','2021-07-12', TRUE),
('oda','Nobu','Wakamiya','***','onobu@gmail.com','813334568','2021-07-13', TRUE),
('Karl','Leon','Tower Street','***','kleon@gmail.com','4965324976','2021-07-14', FALSE),
('Hans','Lucas','Bundesautobahn','***','hlucas@gmail.com','496678946','2021-07-15', TRUE),
('Mark','Luis','Strom','***','mluis@gmail.com','496678906','2021-07-16', TRUE),
('Ryan','Owen','Vernon Avenue','***','rowen@gmail.com','3536673906','2021-07-17', TRUE),
('Jan','Pieter','BloedStraat','***','jpieter@gmail.com','31627002527','2021-07-18', TRUE),
('Bert','Smith','Dunbar Street','***','bsmith@gmail.com','1647562527','2021-07-19', TRUE),
('Sofie','Wise','Victoria park Avenue','***','swise@gmail.com','164727001235','2021-07-20', TRUE)
;

INSERT INTO property (
hostID, property_commissionID, property_typeID, neighborhoodID, property_name, property_address, 
property_size, property_rating, qty_room) 
VALUES 
(1,3,1,1,'Ayu Hotel','NgurahRai',1000,5,50),
(2,3,1,2,'Metropolitan','Sudirman',1500,5,60),
(3,3,2,3,'Melati','Monjali',500,5,30),
(4,3,1,6,'Poptel','Ampang',1400,4,70),
(5,3,4,5,'Unique','Jalan Indah',600,3,12),
(6,3,4,6,'Yellow','Sukhumvit Road',500,5,14),
(7,3,4,7,'Star','Bangla Road',600,3,50),
(8,5,2,8,'Blue','Hang Tong',400,1,15),
(9,5,2,9,'Pisces','Matsugaya',500,1,10),
(10,5,3,10,'Golden','Shijo Street',50,1,50),
(11,4,4,11,'Pink','Midosuji',500,2,10),
(12,3,2,12,'Lucid','Kitasaiwai',400,5,50),
(13,3,4,13,'Peak','Wakamiya',1400,4,45),
(14,5,5,14,'Lucky','Tower Street',70,2,3),
(15,3,2,15,'Moon','Bundesautobahn',400,3,20),
(16,3,1,16,'Sunrise','Strom',1400,4,70),
(17,3,2,17,'Pretty','Vernon Avenue',700,4,30),
(18,3,1,18,'RedStar','BloedStraat',1000,4,30),
(19,3,4,19,'Cute','Dunbar Street',600,5,25),
(20,3,1,20,'Heart','Victoria park',1100,4,30)
;

INSERT INTO facility (
propertyID, internet, parking, swimmingpool) 
VALUES 
(1,TRUE, TRUE, TRUE),
(2,TRUE, TRUE, TRUE),
(3,TRUE, TRUE, TRUE),
(4,TRUE, TRUE, FALSE),
(5,TRUE, TRUE, FALSE),
(6,TRUE, TRUE, FALSE),
(7,TRUE, TRUE, FALSE),
(8,TRUE, FALSE, FALSE),
(9,TRUE, FALSE, FALSE),
(10,TRUE, FALSE, FALSE),
(11,TRUE, FALSE, FALSE),
(12,TRUE, FALSE, FALSE),
(13,TRUE, FALSE, FALSE),
(14,FALSE, FALSE, FALSE),
(15,TRUE, FALSE, FALSE),
(16,TRUE, TRUE, TRUE),
(17,TRUE, FALSE, FALSE),
(18,TRUE, TRUE, FALSE),
(19,TRUE, FALSE, FALSE),
(20,TRUE, TRUE, FALSE)
;

INSERT INTO room_type(room_type) VALUES (1),(2),(3),(4),(5),(6),(7),
(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);

INSERT INTO room (
propertyID, room_typeID, room_name, room_number, room_size, room_rate, room_availability) 
VALUES 
(1,1,'Rose',101,25,40,TRUE), (2,3,'Medium',203,30,50,TRUE),
(3,1,'Barong',143,20,30,TRUE), (4,2,'Venus',107,24,40,TRUE),
(5,3,'Violet',106,26,25,TRUE), (6,2,'Pink',200,32,30,TRUE),
(7,3,'Rabbit',112,20,40,TRUE), (8,2,'Purple',123,23,45,TRUE),
(9,1,'Moon',223,20,55,TRUE), (10,2,'Shiva',114,32,34,TRUE),
(11,2,'Shiva',114,32,34,TRUE),(12,1,'Delta',104,25,25,FALSE), 
(13,2,'Iota',251,20,36,TRUE), (14,1,'Lux',201,26,27,TRUE), 
(15,2,'Blue',100,280,30,FALSE),(16,3,'Scalar',117,24,60,TRUE), 
(17,4,'Alpha',313,30,58,TRUE), (18,5,'Ilona',113,34,60,TRUE), 
(19,3,'Medium',222,20,70,FALSE), (20,2,'Everest',112,20,70,FALSE);

INSERT INTO amenities (
roomID, internet, aircon, heating, washer, television, kettle, refrigerator) 
VALUES 
(1,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE), (2,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE),
(3,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE), (4,TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE),
(5,TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE), (6,TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE),
(7,TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE), (8,TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE),
(9,TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE), (10,TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE),
(11,TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE), (12,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE),
(13,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE), (14,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE),
(15,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE), (16,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE),
(17,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE), (18,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE),
(19,TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE), (20,TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE)
;

INSERT INTO guest_commission(guest_commission) VALUES (0.01),(0.02),(0.03),(0.04),(0.05),(0.06),(0.07),
(0.08),(0.09),(0.1),(0.11),(0.12),(0.13),(0.14),(0.15),(0.16),(0.17),(0.18),(0.19),(0.2);

INSERT INTO guest (
guest_commissionID, guest_rating, guest_firstname, guest_lastname, guest_address, guest_password, guest_email, 
guest_phone, guest_create_date, guest_level, guest_active) 
VALUES 
(10,3,'Miya','Maureen','Bandung','***','mmaureen@gmail.com','628165488966','2021-08-01',1, TRUE),
(6,4,'Rita','Henry','Jakarta','***','rhenry@gmail.com','62812207453','2021-08-02',2, TRUE),
(6,5,'Kyle','Johnson','UK','***','kjohsnson@gmail.com','445433966','2021-08-03',3, TRUE),
(12,1,'Tun','Abdul','KL','***','tabdul@gmail.com','6055676554','2021-08-04',1, FALSE),
(6,5,'Jason','Kurt','Ontario','***','jkurt@gmail.com','1647556954','2021-08-05',1, TRUE),
(12,2,'James','Dwight','Virgin Island','***','jdwight@gmail.com','13405676554','2021-08-06',1, FALSE),
(6,3,'Lee','Ling','China','***','lling@gmail.com','86456676554','2021-08-07',1, TRUE),
(6,4,'Fan','Bing','Jurong East','***','fbing@gmail.com','6564676554','2021-08-08',1, TRUE),
(12,2,'Martin','Leong','Toa Payoh','***','mleong@gmail.com','6544432109','2021-08-09',1, FALSE),
(6,5,'Sheena','Chen','Dover','***','schen@gmail.com','6557893452','2021-08-10',2, TRUE),
(6,5,'Rini','Mulia','Ngampilan','***','rmulia@gmail.com','628153343452','2021-08-11',3, TRUE),
(6,4,'Chelsea','Nana','BuahBatu','***','cnana@gmail.com','628128824552','2021-07-12',2, TRUE),
(12,1,'Tony','Shawn','Soest','***','tshawn@gmail.com','316119546','2021-07-13',1, FALSE),
(10,3,'Sheena','Chen','Dover','***','schen@gmail.com','317754352','2021-07-14',2, TRUE),
(6,5,'Sheena','Chen','Dover','***','schen@gmail.com','319778934','2021-07-15',3, TRUE),
(6,4,'Matsu','Kido','Yakushima','***','mkido@gmail.com','814445552','2021-07-16',2, TRUE),
(10,3,'Li','Mei','Dover','***','lmei@gmail.com','8694357893452','2021-07-17',2, TRUE),
(6,5,'Andrew','Smith','Melbourn','***','asmith@gmail.com','612006452','2021-07-18',3, TRUE),
(12,2,'Paul','Black','Sidney','***','pblack@gmail.com','6157893452','2021-07-19',1, FALSE),
(12,1,'Agnes','Mae','Hongkong','***','amae@gmail.com','8524456787','2021-07-20',1, FALSE)
;

INSERT INTO property_review (
propertyID, guestID, cleanliness, communication, pvalue, location, amenities, internet, service) 
VALUES 
(1,4,9,9,9,8,9,8,8), (2,3,9,7,8,8,9,9,8), (3,2,8,9,8,8,8,7,8), (4,1,8,8,7,8,8,7,8),
(5,5,7,7,7,8,6,7,8), (6,8,9,9,8,8,9,7,8), (7,6,7,7,7,8,6,7,8), (8,9,5,4,3,3,5,5,4),
(9,10,4,4,5,3,4,6,5), (10,11,5,6,4,5,5,6,4), (11,13,6,5,6,7,6,7,5), (12,12,9,9,9,8,9,9,8),
(13,14,8,7,7,8,9,7,8), (14,16,6,7,6,7,6,7,6), (15,15,7,7,7,8,6,7,8), (16,17,9,7,7,8,8,7,8),
(17,20,7,9,7,8,8,7,8), (18,19,7,9,8,8,7,7,8), (19,8,9,7,9,8,9,7,8), (20,18,7,9,7,8,8,7,8)
; 

INSERT INTO guest_review (
guestID, hostID, guest_rate, guest_review) 
VALUES 
(1,20,3,'so-so'), (2,19,4,'normal guest'), (3,18,5,'excellent!'), (4,17,1,'terrible guest'),
(5,16,5,'good!'), (6,15,1,'bad guest'), (7,12,3,'no comment'),(8,13,4,'okay'),
(9,12,1,'weird guest'),(10,1,5,'cool!'),(11,10,5,'friendly'), (12,9,4,'nice'),
(13,8,1,'very bad guest'),(14,7,3,'common'), (15,3,5,'Good one!'), (16,5,4,'friendly'),
(17,4,3,'is okay'), (18,3,5,'nice person!'),(19,2,3,'no comment'),(20,1,3,' i thought okay')
;

INSERT INTO cancelation (cancel_charge) 
VALUES 
(0),(0.1),(0.15),(0.2),(0.25),(0.3),(0.35),(0.4),(0.45),(0.5),
(0.55),(0.6),(0.65),(0.7),(0.75),(0.8),(0.85),(0.9),(0.95),(1); 

INSERT INTO booking(roomID, guestID, hostID, booking_date, checkin_date, 
checkout_date, free_cancel_date, cancelationID) 
VALUES 
(1,1,1,'2021-08-14', '2021-09-15', '2021-09-19', '2021-09-14',1),
(2,4,4,'2021-08-13', '2021-09-14', '2021-09-20', '2021-09-13',1),
(3,5,3,'2021-08-12', '2021-09-12', '2021-09-15', '2021-09-11',1),
(4,3,5,'2021-08-14', '2021-09-15', '2021-09-16', '2021-09-14',1),
(5,2,2,'2021-08-13', '2021-09-15', '2021-09-17', '2021-09-14',1),
(6,10,6,'2021-08-14', '2021-09-15', '2021-09-19', '2021-09-14',1),
(7,9,8,'2021-08-16', '2021-09-14', '2021-09-20', '2021-09-13',1),
(8,8,7,'2021-08-15', '2021-09-16', '2021-09-18', '2021-09-15',5),
(9,7,9,'2021-08-14', '2021-09-13', '2021-09-16', '2021-09-12',5),
(10,6,10,'2021-08-13', '2021-09-16', '2021-09-17', '2021-09-15',5),
(11,13,11,'2021-08-14', '2021-09-15', '2021-09-19', '2021-09-14',5),
(12,11,13,'2021-08-13', '2021-09-14', '2021-09-20', '2021-09-13',5),
(13,12,12,'2021-08-12', '2021-09-12', '2021-09-15', '2021-09-11',10),
(14,20,15,'2021-08-14', '2021-09-15', '2021-09-19', '2021-09-14',10),
(15,16,14,'2021-08-16', '2021-09-14', '2021-09-20', '2021-09-13',10),
(16,15,17,'2021-08-15', '2021-09-16', '2021-09-18', '2021-09-15',15),
(17,17,19,'2021-08-14', '2021-09-13', '2021-09-16', '2021-09-12',15),
(18,18,18,'2021-08-13', '2021-09-16', '2021-09-17', '2021-09-16',15),
(19,10,20,'2021-08-13', '2021-09-15', '2021-09-17', '2021-09-14',20),
(20,19,16,'2021-08-14', '2021-09-15', '2021-09-19', '2021-09-15',20)
;

INSERT INTO voucher (voucher, discount) 
VALUES
('XMTRW!', 0), ('EJNVH!', 0.1),('WEFCT!', 0.15),('SBFTYM!', 0.2),('THYJYG!', 0.25),
('VAGRTB!', 0.3), ('HAYTERX!', 0.35),('GRETEWT!', 0.4),('WOTREW!', 0.45),('GFXBN!', 0.5),
('WXYTHR!', 0.55), ('BVXXSE!', 0.6),('ERRQWR!', 0.65),('CCTU!', 0.7),('VBNY!', 0.75),
('XYYXE!', 0.8), ('JJKYR!', 0.85),('HGFDT!', 0.9),('BHGFE!', 0.95),('ZZZTR!', 0.99)
; 

INSERT INTO payment_status (payment_status)
VALUES
('ENTRY'),('PROBLEM IN ENTRY'),('ON HOLD'),('CREDIT CARD PROBLEM'),('PROCESS TO MARKETPLACE'),
('PROBLEM IN MARKETPLACE'),('PAID TO MARKETPLACE'),('ON HOLD TO HOST'),('PROCESS TO HOST'),('PROBLEM WITH HOST'),
('PAID TO HOST'),('NO PROBLEM'),('DONE'),('SUSPICIOUS'),('PROBLEM WITH GOVERNMENT'),
('FRAUD'),('GOT COMPLAIN FROM HOST'),('WRONG PAYMENT'),('DOUBLE PAYMENT'),('NEED RETUR TO GUEST')
; 

INSERT INTO payment (payment_statusID, bookingID, voucherID, amount, payment_date)
VALUES
(1,1,10,160,'2021-08-14'),(1,2,10,300,'2021-08-13'),(1,3,1,90,'2021-08-12'),(1,4,1,40,'2021-08-14'),
(1,5,1,50,'2021-08-13'), (1,6,1,120,'2021-08-14'),(1,7,1,240,'2021-08-16'),(1,8,1,90,'2021-08-15'),
(1,9,1,166,'2021-08-14'),(1,10,1,34,'2021-08-13'),(1,11,1,136,'2021-08-14'),(1,12,1,40,'2021-08-13'),
(1,13,1,108,'2021-08-12'), (5,14,1,108,'2021-08-14'),(5,15,1,180,'2021-08-16'),(11,16,1,120,'2021-08-15'),
(1,17,1,174,'2021-08-14'), (5,18,1,60,'2021-08-13'),(3,19,1,140,'2021-08-13'),(4,20,1,280,'2021-08-14')
; 