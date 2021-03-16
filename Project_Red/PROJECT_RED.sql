-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- ----------------------------------------------------
-- Schema Project
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project` DEFAULT CHARACTER SET utf8 ;
USE `Project` ;
-- -----------------------------------------------------
-- Table `Project`.`Blood Donor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Blood_Donor` (
  `d_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Blood_group` VARCHAR(5) NOT NULL,
  `Age` INT NULL,
  `Gender` VARCHAR(6) NULL,
  `Weight` INT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Postal_code` INT NOT NULL,
  `Contact` VARCHAR(11) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `last_donated` DATE NULL,
  `Valid_day` INT NULL,
  `d_status` VARCHAR(20) NULL,
  PRIMARY KEY (`d_ID`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `Project`.`Blood_Recipient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Blood_Recipient` (
  `r_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Blood_group` VARCHAR(5) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Postal_code` INT NOT NULL,
  `Venue` VARCHAR(100) NULL,
  `Accident_case` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`r_ID`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `Project`.`Ambulances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Ambulances` (
  `Amb_id` VARCHAR(5) NOT NULL,
  `No_plate` VARCHAR(10) NOT NULL,
  `Hospital_name` VARCHAR(100) NOT NULL,
  `Current_status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Amb_id`))
ENGINE = InnoDB;
-- ----------------------
-- Table A-service --
-- ----------------------
CREATE TABLE IF NOT EXISTS `Project`.`A_service` (
  `Case_no` INT NOT NULL AUTO_INCREMENT,
  `Ambulance_id` VARCHAR(5) NOT NULL,
  `person_ID` INT NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Case_no`),
  INDEX `person_id_idx` (`person_ID` ASC) VISIBLE,
  INDEX `Ambulance_id_idx` (`Ambulance_id` ASC) VISIBLE,
  CONSTRAINT `person1_id`
    FOREIGN KEY (`person_ID`)
    REFERENCES `Project`.`Blood_Recipient` (`r_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Ambulance_id`
    FOREIGN KEY (`Ambulance_id`)
    REFERENCES `Project`.`Ambulances` (`Amb_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;
-- --------------------------
-- table Blood_donation
-- --------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Blood_Donation` (
  `Donation_id` INT NOT NULL AUTO_INCREMENT,
  `Donor_id` INT NOT NULL,
  `Recipient_id` INT NOT NULL,
  `Blood_group` VARCHAR(5) NOT NULL,
  `Donation_date` DATE NOT NULL,
  `Venue` VARCHAR(100) NOT NULL,
  `Accident_case` VARCHAR(5) NULL,
  `Accident_describtion` VARCHAR(45) NULL,
  INDEX `Donor_id_idx` (`Donor_id` ASC) VISIBLE,
  INDEX `Recipient_id_idx` (`Recipient_id` ASC) VISIBLE,
  PRIMARY KEY (`Donation_id`),
  CONSTRAINT `Donor_id`
    FOREIGN KEY (`Donor_id`)
    REFERENCES `Project`.`Blood_Donor` (`d_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Recipient_id`
    FOREIGN KEY (`Recipient_id`)
    REFERENCES `Project`.`Blood_Recipient` (`r_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- TRIGGER TABLE --
CREATE TABLE DONOR_audit (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    d_Number INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Contact varchar(15) not null,
    Email varchar (20) not null,
    L_date date NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);
CREATE TRIGGER before_donor_update 
    BEFORE UPDATE ON blood_donor
    FOR EACH ROW 
    INSERT INTO donor_audit
    SET action = 'update',
    d_number=old.d_ID,
	Name = OLD.Name,
	Contact=old.Contact,
	Email=old.Email,
	L_date=old.last_donated,
	changedat = NOW();

-- Blood_Donor Data --

INSERT INTO blood_donor(d_ID,Name,Blood_group,Age,Gender,Weight,Address,Postal_code,Contact,Email,last_donated,Valid_day,d_status) VALUES
(1,'Abdullah Amin','A+',22,'Male',52,'Farmgate,Dhaka',1205,'01856565678','abdula01@gmail.com','2020-05-03',167,'Available'),
(2,'Sohag Hossain','O+',24,'Male',73,'Hatirpool,Dhaka',1205,'01822112212','sohag01@gmail.com','2020-02-22',238,'Available'),
(3,'Imran Rahman','B+',21,'Male',56,'Green Road,Dhaka',1205,'01820103040','imran01@gmail.com','2019-11-12',340,'Available'),
(4,'Mehrab Islam','B-',19,'Male',55,'Mirpur,Dhaka',1216,'01920103040','mehrab01@gmail.com','2020-08-17',61,'Available'),
(5,'Ayman Hossain','O+',27,'Male',70,'Mirpur,Dhaka',1216,'01620103040','ayman01@gmail.com','2019-12-08',314,'Available'),
(6,'Jion Mahmud','O-',20,'Male',76,'Dhanmondi,Dhaka',1209,'01720103040','jiono1@gmail.com','2020-04-18',182,'Available'),
(7,'Shahib Anwar','O+',21,'Male',76,'Bakshi bazar',1200,'01791929191','shahib01@gmail.com','2019-10-10',373,'Available'),
(8,'Abdul Karim','AB-',25,'Male',76,'Dhanmondi,Dhaka',1209,'01630303030','abdul01@gmail.com','2020-10-01',16,'Unavailable'),
(9,'Israk Ali','O-',25,'Male',53,'Mohammadpur,Dhaka',1207,'01650607080','israk01@gmail.com','2020-08-22',56,'Available'),
(10,'Anupama Saha','AB-',23,'Female',72,'Ajimpur, Dhaka',1205,'01930405060','anupama01@gmail.com','2020-09-03',44,'Unavailable'),
(11,'Khalled Hossain','B-',25,'Male',59,'Mohammadpur,Dhaka',1207,'01909876542','khaled02@gmail.com','2019-11-02',350,'Available'),
(12,'Nishat Akter','O-',21,'Female',68,'Dhanmondi,Dhaka',1209,'01709876235','nishat01@gmail.com','2020-01-04',287,'Available'),
(13,'Tipu Mahbub','O+',19,'Male',70,'Ajimpur, Dhaka',1205,'01701678490','tipu01@gmail.com','2020-09-20',27,'Unavailable'),
(14,'Mahbuba Sumi','A+',20,'Female',51,"Bakshi bazar,Dhaka",1200,'01765437890','mahbuba01@gmail.com','2020-06-14',125,'Available'),
(15,'Jannat Eva','A-',24,'Female',57,"Mohammadpur,Dhaka",1207,'01634909325','jannatul01@gmail.com','2020-07-04',105,'Available'),
(16,'Homaira Adiba','B+',24,'Female',56,"Dhanmondi,Dhaka",1209,'01964539201','homaira01@gmail.com','2020-04-01',199,'Available'),
(17,'Tareq Hasan','B-',21,'Male',55,"Elephant Road, Dhaka",1205,'01794020942','tareq01@gmail.com','2020-02-14',246,'Available'),
(18,'Tumpa Saha','AB+',23,'Female',70,"Bakshi bazar,Dhaka",'1200','01603728918','tumpa01@gmail.com','2020-03-16',215,'Available'),
(19,'Saqib Sizan','AB-',25,'Male',63,"Elephant Road, Dhaka",1205,'01900077002','saqib01@gmail.com','2020-05-03',167,'Available'),
(20,'Shafin Hasan','O+',19,'Male',69,"Kalabagan,Dhaka",1205,'01700000345','shafin01@gmail.com','2020-09-05',42,'Unavailable'),
(21,'Sumia Afroz','O+',26,'Female',64,"Tejgaon,Dhaka",1208,'01500003458','sumia01@gmail.com','2020-03-30',201,'Available'),
(22,'Sumaiya Ali','B+',27,'Female',78,"Kalabagan,Dhaka",1205,'01504325668','sumaiya01@gmail.com','2019-11-28',324,'Available'),
(23,'Fahim Rahman','B-',35,'Male',78,"Elephant Road, Dhaka",1205,'01907484853','fahim34@gmail.com','2020-09-15',32,'Unavailable'),
(24,'Anika Akter','B+',34,'Female',60,"Mohammadpur,Dhaka",1207,'01602743593','anika01@gmail.com','2020-06-22',117,'Available'),
(25,'Azim Uddin','A+',50,'Male',61,"Mohammadpur,Dhaka",1207,'01637327990','azim01@gmail.com','2020-04-12',188,'Available'),
(26,'Khalled Mahir','A-',61,'Male',72,"Panthopath,Dhaka",1205,'01903647321','khalled012@gmail.com','2020-02-21',239,'Available'),
(27,'Anowar Hossain','AB-',45,'Male',75,"Tejgaon,Dhaka",1208,'01824353443','anowar01@gmail.com','2020-10-03',14,'Unavailable'),
(28,'Fahim Haque','O+',32,'Male',65,"Mirpur,Dhaka",1205,'01950434563','fahim012@gmail.com','2020-03-21',210,'Available'),
(29,'Sumaiya Akter','O+',30,'Female',76,"Panthopath,Dhaka",1205,'01922222223','sumaiya023@gmail.com','2020-03-08',223,'Available'),
(30,'Kabila Rahman','AB-',41,'Male',70,"Tejgaon,Dhaka",1208,'01823333333','kabila01@gamil.com','2019-12-11',311,'Available'),
(31,'Shuvo Hossain','B+',37,'Male',69,"Panthopath,Dhaka",1205,'01733333333','shuvo012@gmail.com','2020-10-13',4,'Unavailable'),
(32,'Mehrab hossain','B-',54,'Male',68,"Dhanmondi,Dhaka",'1209','01655555555','mehrab02@gmail.com','2020-01-02',289,'Available'),
(33,'Kamal Hossain','AB+',21,'Male',59,"Mirpur,Dhaka",1216,'01677777777','kamal01@gmail.com','2019-12-10',312,'Available'),
(34,'Fahim Abrar','O+',26,'Male',52,"Tejgaon,Dhaka",1208,'01900003333','fahim01@gmail.com','2019-10-14',369,'Available'),
(35,'Zakir Hossain','O+',24,'Male',61,"Mirpur,Dhaka",1216,'01730000004','zakir01@gmail.com','2020-10-02',15,'Unavailable'),
(36,'Sumaiya Shumi','AB+',23,'Female',64,"Farmgate,Dhaka",1205,'01793334333','sumaiya02@gmail.com','2019-12-17',305,'Available'),
(37,'Rokeya Begum','AB-',21,'Female',56,"Bakshi bazar,Dhaka",1200,'01754545453','rokeya0@gmail.com','2020-05-19',151,'Available'),
(38,'Riya Sultana','A+',21,'Female',50,"Zigatola,Dhaka",1205,'01745456767','riya01@gmail.com','2020-03-27',204,'Available'),
(39,'Raihan Sobhan','A-',34,'Male',72,"Mirpur,Dhaka",1216,'01923848385','raihan01@gmail.com','2019-11-15',337,'Available'),
(40,'Khalled Rahim','B+',45,'Male',56,"Farmgate,Dhaka",1205,'01637382932','khaled01@gmail.com','2019-12-18',304,'Available');
  insert into Blood_donor values (41, 'Rajiul Islam','A+',26, 'Male', 85, 'Tejgaon,Dhaka', 1208, '01980021441','Rajiul33@gmail.com', '2020-10-9',8,'Unavailable');
  insert into Blood_donor values (42, 'Tanjina Beg','B-',27, 'Female', 59, 'Mirpur,Dhaka', 1216,'01977721441','Beg03@gmail.com', '2020-05-9',161,'Available');
  insert into Blood_donor values (43, 'Tanjm Haque','O+',30, 'Male', 84, 'Dhanmondi,Dhaka', 1209,'01977728888','Haque099@gmail.com', '2020-10-16',1,'Unavailable');
  insert into Blood_donor values (44, 'Amrin Khaled','B+',25, 'Female', 65, 'Bakshi Bazar,Dhaka', 1200,'01970028888','Amrin099@gmail.com', '2020-09-25',22,'Unavailable');
  insert into Blood_donor values (45, 'Fahrin Zannat','B+',29, 'Female', 60, 'Mirpur,Dhaka', 1216,'01730967234','ZannatBD@gmail.com', '2020-06-25',114,'Available');
  insert into Blood_donor values (46, 'Nahiyan Uddin','O+',29, 'Male', 87, 'Mohammadpur,Dhaka', 1207,'01933967234','Nahiyan76@gmail.com', '2020-06-26',115,'Available');
  insert into Blood_donor values (47, 'Moushan Beg','B-',26, 'Male', 84, 'Panthopath,Dhaka', 1205,'01864967234','Moushan74@gmail.com', '2020-04-19',181,'Available');

 -- Blood_Recipient Data --
 insert into Blood_recipient(r_ID,Name,Blood_group,Address,Postal_code,Venue,Accident_case)values
(1,'Masum Hossain','O+','Farmgate,Dhaka',1205,'Green Life Hospital','NO'),
(2,"Maruf Hasan",'A+',"Tejgaon,Dhaka",1208,"MH Samorita Hospital",'NO'),
(3,"Kadir Rahman",'A-',"Green Road,Dhaka",1205,"Central Hospital",'YES'),
(4,"Sakib Khan",'B+',"Hatirpool,Dhaka",1205,"Central Hospital",'NO'),
(5,"Tanjila jannat",'B-',"Mirpur,Dhaka",1216,"Shaheed suhrawardi medical college",'YES'),
(6,"Imran Rahman",'AB+',"Panthopath,Dhaka",1205,"Green Life Hospital",'NO'),
(7,"Jannatul jannat",'AB-',"Tejgaon,Dhaka",1208,"MH Samorita Hospital",'YES'),
(8,"Adiba Afroz",'O+',"Dhanmondi,Dhaka",1209,"Ibn Sina Hospital",'NO'),
(9,"Sadir Ahmed",'O+',"Mirpur,Dhaka",1216,"National institute of cardio varsular disease",'YES'),
(10,"Kibria Rahman",'B+',"Zigatola,Dhaka",1205,"Labaid Hospital",'NO'),
(11,"Mim Begum",'B-',"Elephant Road, Dhaka",1205,"Central Hospital",'YES'),
(12,"Shuvo Rahman",'B+',"Bakshi bazar,Dhaka",1200,"Dhaka Medical College Hospital",'NO'),
(13,"Aminul Islam",'A+',"Hatirpool,Dhaka",1205,"Central Hospital",'YES'),
(14,"Mafuz Rahman",'A-',"Green Road,Dhaka",1205,"Green Life Hospital",'NO'),
(15,"Sadman Rahman",'AB-',"Green Road,Dhaka",1205,"Labaid Hospital",'NO'),
(16,"Sumaiya akter",'O-',"Dhanmondi,Dhaka",1209,"Medinova Hospital",'YES'),
(17,"Nipa Sultana",'O+',"Farmgate,Dhaka",1205,"Labaid Hospital",'NO'),
(18,"Sadiya Begum",'AB-',"Panthopath,Dhaka",1205,"Green Life Hospital",'YES'),
(19,"Suraiya Akter",'B+',"Mirpur,Dhaka",1216,"Shaheed suhrawardi medical college",'NO'),
(20,"Rifat Uddin",'B-',"Zigatola,Dhaka",1205,"Labaid Hospital",'YES'),
(21,"Tahmid Alom",'O+',"Panthopath,Dhaka",1205,"Labaid Hospital",'NO'),
(22,"Borhan Uddin",'A+',"Hatirpool,Dhaka",1205,"Central Hospital",'YES'),
(23,"Dipu Moni",'A-',"Panthopath,Dhaka",1205,"Central Hospital",'NO'),
(24,"Sadia Afroz",'B+',"Mohammadpur,Dhaka",1207,"Care Medical College & Hospital",'NO'),
(25,"Rehana Begum",'B-',"Elephant Road,Dhaka",1205,"Square Hospital",'NO');

-- AMBULANCES DATA --

insert into Ambulances values ( 'ch100','1020-40','Central Hospital','Available'); 
insert into Ambulances values ( 'ch101','1020-41','Central Hospital','Available'); 
insert into Ambulances values ( 'ch103','1020-43','Central Hospital','Available'); 
insert into Ambulances values ( 'ch104','1020-44','Central Hospital','Unavailable'); 
insert into Ambulances values ( 'lb200','1111-40','Labaid Hospital','Available'); 
insert into Ambulances values ( 'lb204','1111-42','Labaid Hospital','Available'); 
insert into Ambulances values ( 'lb209','1111-47','Labaid Hospital','Available'); 
insert into Ambulances values ( 'lb210','1111-30','Labaid Hospital','Available');
insert into Ambulances values ( 'gl300','2000-40','Green Life Hospital','Available');  
insert into Ambulances values ( 'gl301','2001-40','Green Life Hospital','Available');
insert into Ambulances values ( 'gl307','2000-48','Green Life Hospital','Unvailable');  
insert into Ambulances values ( 'sq400','5555-40','Square Hospital','Available'); 
insert into Ambulances values ( 'sq409','5555-44','Square Hospital','Available'); 
insert into Ambulances values ( 'sq402','5555-10','Square Hospital','Available');
insert into Ambulances values ( 'dm111','1040-88','Dhaka Medical College Hospital','Available');  
insert into Ambulances values ( 'dm120','1040-89','Dhaka Medical College Hospital','Available'); 
insert into Ambulances values ( 'dm100','1040-80','Dhaka Medical College Hospital','Unavailable'); 
insert into Ambulances values ( 'dm400','1040-44','Dhaka Medical College Hospital','Available');  
insert into Ambulances values ( 'aa101','9999-34','Asgar Ali Hospital','Available');
insert into Ambulances values ( 'aa111','1040-88','Asgar Ali Hospital','Available');
insert into Ambulances values ( 'ss555','1999-68','Shaheed Suhrawardi Hospital','Available');
insert into Ambulances values ( 'ss500','1999-69','Shaheed Suhrawardi Hospital','Available');
insert into Ambulances values ( 'ss800','1999-00','Shaheed Suhrawardi Hospital','Unavailable');
insert into Ambulances values ( 'ni100','7777-90','National Institute of Cardio Vascular Disease','Available');
insert into Ambulances values ( 'ni102','7777-00','National Institute of Cardio Vascular Disease','Available');
insert into Ambulances values ( 'Ib300','7555-90','Ibn Sina Hospital','Available');
insert into Ambulances values ( 'Ib309','7055-90','Ibn Sina Hospital','Unavailable');
insert into Ambulances values ( 'mn700','8000-55','Medinova Hospital','Available');
insert into Ambulances values ( 'mn706','8000-05','Medinova Hospital','Available');
insert into Ambulances values ( 'mn790','8999-55','Medinova Hospital','Available');
insert into Ambulances values ( 'al200','6666-00','Al Manar Hospital','Available');
insert into Ambulances values ( 'al299','6666-99','Al Manar Hospital','Available');
insert into Ambulances values ( 'cm800','5444-00','Care Medical College & Hospital','Available');
insert into Ambulances values ( 'cm877','5444-99','Care Medical College & Hospital','Unavailable');
insert into Ambulances values ( 'cm850','5884-00','Care Medical College & Hospital','Available');
insert into Ambulances values ( 'mh100','3404-00','MH Samorita Hospital','Available');
insert into Ambulances values ( 'mh109','3404-55','MH Samorita Hospital','Available');
insert into Ambulances values ( 'mh106','3404-88','MH Samorita Hospital','Unavailable');
insert into Ambulances values ( 'im000','3334-90','Impulse Hospital','Available');
insert into Ambulances values ( 'im002','3777-90','Impulse Hospital','Available');
insert into Ambulances values ( 'im110','3509-90','Impulse Hospital','Unavailable');

-- A_service table DATA--

insert into A_service values( 1,'ch100',3,'Green Road,Dhaka,1205');   
insert into A_service values( 2,'ss500',5,'Mirpur,Dhaka,1216');
insert into A_service values( 3,'mh100',7,'Tejgaon,Dhaka,1208');
insert into A_service values( 4,'ni102',9,'Mirpur,Dhaka,1216');
insert into A_service values( 5,'ch103',11,'Elephant Road,Dhaka,1205');
insert into A_service values( 6,'gl301',13,'Hatirpool,Dhaka,1205');
insert into A_service values( 7,'mn700',16,'Dhanmondi,Dhaka,1209');
insert into A_service values( 8,'gl300',18,'Panthopath,Dhaka,1205');
insert into A_service values( 9,'lb210',20,'Zigatola,Dhaka,1205');
insert into A_service values( 10,'ch104',22,'Hatirpool,Dhaka,1205');

-- Blood_donation Table DATA --


     insert into Blood_donation values (1,2,1 ,'O+','2020-02-22','Green Life Hospital,Dhaka,1205','NO','NULL');
     insert into Blood_donation values (2,41 ,2 ,'A+','2020-10-9','MH Samorita Hospital,Dhaka,1208','NO','NULL');
     insert into Blood_donation values (3,26, 3 ,'A-','2020-02-21','Central Hospital,Dhaka,1205','YES','BIKE ACCIDENT');
     insert into Blood_donation values (4, 3, 4 ,'B+','2019-11-12','Central Hospital,Dhaka,1205','NO','NULL');
     insert into Blood_donation values (5, 42, 5 ,'B-','2020-05-9','Shaheed suhrawardi medical college,Dhaka,1216','YES','ROAD ACCIDENT');
     insert into Blood_donation values (6, 36, 6 ,'AB+','2019-12-17','Green Life Hospital,Dhaka,1205','NO','NULL');
     insert into Blood_donation values (7, 27, 7 ,'AB-','2020-10-03','MH Samorita Hospital,Dhaka,1208','YES','MISCARRIAGE');
     insert into Blood_donation values (8, 43, 8 ,'O+','2020-10-16','Ibn Sina Hospital,1209','NO','NULL');
     insert into Blood_donation values (9, 5, 9 ,'O+','2019-12-08','National institute of cardio varsular disease,1216','YES','CARDIAC ARREST & SURGERY');
     insert into Blood_donation values (10, 13, 10 ,'O+','2020-09-20','Labaid Hospital,1205','NO','NULL');
     insert into Blood_donation values (11, 17, 11 ,'B-','2020-02-14','Central Hospital,1205','YES','CAR CRASH');
     insert into Blood_donation values (12, 44, 12 ,'B+','2020-09-25','Dhaka Medical College Hospital,1200','NO','NULL');
     insert into Blood_donation values (13, 1, 13 ,'A+','2020-05-03','Central Hospital,1205','YES','ROAD ACCIDENT');
     insert into Blood_donation values (14, 26, 14 ,'A-','2019-09-25','Green Life Hospital,Dhaka,1205','NO','NULL');
     insert into Blood_donation values (15, 19, 15 ,'AB-','2020-05-03','Labaid Hospital,1205','NO','NULL');
     insert into Blood_donation values (16, 12, 16 ,'O-','2020-01-04','Medinova Hospital,Dhaka,1209','YES','ROAD ACCIDENT');
     insert into Blood_donation values (17, 29, 17 ,'O+','2020-03-08','Labaid Hospital,1205','NO','NULL');
     insert into Blood_donation values (18, 10, 18 ,'AB-','2020-09-03','Green Life Hospital,Dhaka,1205','YES','CAR CRASH');
     insert into Blood_donation values (19, 45, 19 ,'B+','2020-03-08','Shaheed suhrawardi medical college,1216','NO','NULL');
     insert into Blood_donation values (20, 23, 20 ,'B-','2020-09-15','Labaid Hospital,1205','YES','BIKE ACCIDENT');
     insert into Blood_donation values (21, 28, 21 ,'O+','2020-03-21','Labaid Hospital,1205','NO','NULL');
     insert into Blood_donation values (22, 38, 22 ,'A+','2020-03-27','Central Hospital,1205','YES','BURN INJURY');
     insert into Blood_donation values (23, 26, 23 ,'A-','2019-03-27','Central Hospital,1205','NO','NULL');
     insert into Blood_donation values (24, 24, 24 ,'B+','2020-06-22','Care medical college & hospital,1207','NO','NULL');
     insert into Blood_donation values (25, 47, 25 ,'B-','2020-04-19','Square hospital,1205','NO','NULL');
     
     
 UPDATE Blood_Donor SET Contact = '01731023017' WHERE d_ID = 47;
 UPDATE Blood_Donor SET Email = 'Tanjina33@gmail.com' WHERE d_ID = 42;
 
Alter table Ambulances add column Area_code INT after Hospital_name;
Update Ambulances SET Area_code = 1200 Where Hospital_name IN( 'Asgar Ali Hospital','Dhaka Medical College Hospital');
Update Ambulances SET Area_code = 1205 Where Hospital_name IN ('Central Hospital','Green Life Hospital','Labaid Hospital','Square Hospital');
Update Ambulances SET Area_code = 1209 Where Hospital_name IN ('Medinova Hospital','Ibn Sina Hospital');
Update Ambulances SET Area_code = 1208 Where Hospital_name IN ('MH Samorita Hospital','Impulse Hospital');
Update Ambulances SET Area_code = 1207 Where Hospital_name IN ('Care Medical College & Hospital','Al Manar Hospital');
Update Ambulances SET Area_code = 1216 Where Hospital_name IN ('Shaheed Suhrawardi Hospital','National Institute of Cardio Vascular Disease');

