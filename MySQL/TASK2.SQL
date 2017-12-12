CREATE DATABASE IF NOT EXISTS qatask2;
USE qatask2;

-- Create a ‘person’ table. The minimum fields within this should be a primary key of personID, full name, favourite colour (choose from: blue, red, yellow, green, orange, purple, black, white), birthday, favourite number between 1 and 10, and catchphrase
CREATE TABLE person(
person_id int UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
f_name varchar(255) NOT NULL,
l_name varchar(255) NOT NULL,
-- fullname varchar,
age int UNSIGNED NOT NULL,
gender ENUM('male','female','other','undisclosed') NOT NULL DEFAULT 'undisclosed',
fav_colour ENUM('white','red','yellow','green','blue','purple','black') NOT NULL,
fav_number int CHECK((fav_number >= 1) OR (fav_number <= 10)),
birthday date NOT NULL,
catchphrase varchar(255),
PRIMARY KEY (person_id));

--Create a ‘pet’ table. The minimum fields within this should be a primary key of petID and foreign primary key of personID, name, age, gender, type (dog, cat, fish, etc), and breed (shorthair, bulldog, betta). Consider how you will implement referential integrity.
CREATE TABLE pet(
pet_id int UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT,
person_id int UNSIGNED NOT NULL,
name varchar(255) NOT NULL,
age int UNSIGNED NOT NULL,
gender ENUM('male','female','other','undisclosed') NOT NULL DEFAULT 'undisclosed',
pet_type ENUM('bird','cat','dog','fish','lizard','snake') NOT NULL,
breed varchar(255),
PRIMARY KEY (pet_id),
FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE);

INSERT INTO person(f_name,l_name,age,gender,fav_colour,fav_number,birthday,catchphrase) VALUES ('Harambe','NeverForget',17,'male','green',5,'2000-11-20','Never Forget');
INSERT INTO person(f_name,l_name,age,gender,fav_colour,fav_number,birthday,catchphrase) VALUES ('Chrisjen','Avasarala',70,'female','blue',10,'1947-10-20','Earth must come first');
INSERT INTO person(f_name,l_name,age,gender,fav_colour,fav_number,birthday,catchphrase) VALUES ('Melody','Henesley',22,'female','black',1,'1995-11-13','#Triggered');
INSERT INTO person(f_name,l_name,age,gender,fav_colour,fav_number,birthday,catchphrase) VALUES ('Leeroy','Jenkins',35,'male','red',5,'1982-01-11','Leerooooooooy Jennkiins!');
INSERT INTO person(f_name,l_name,age,gender,fav_colour,fav_number,birthday,catchphrase) VALUES ('Rama','Acosta',21,'male','purple',8,'1996-09-27','Do your homework');
INSERT INTO person(f_name,l_name,age,gender,fav_colour,fav_number,birthday,catchphrase) VALUES ('Tim','Luu',17,'male','yellow',9,'2000-04-20','GG Noobs');
INSERT INTO person(f_name,l_name,age,gender,fav_colour,fav_number,birthday,catchphrase) VALUES ('Tim','Woodbridge',32,'male','white',1,'1984-07-20','No Steak');
INSERT INTO person(f_name,l_name,age,gender,fav_colour,fav_number,birthday,catchphrase) VALUES ('Sam','Mellors',25,'male','white',7,'1992-08-22','Wreeeeeeeee');

INSERT INTO pet(person_id,name,age,gender,pet_type,breed) VALUES (1,'Blektova','3','female','dog','samoyed');
INSERT INTO pet(person_id,name,age,gender,pet_type,breed) VALUES (1,'Tomoslav','3','male','dog','samoyed');
INSERT INTO pet(person_id,name,age,gender,pet_type,breed) VALUES (1,'Hans','7','male','dog','alsatian');
INSERT INTO pet(person_id,name,age,gender,pet_type,breed) VALUES (2,'Tiddles','5','female','cat','maine coon');
INSERT INTO pet(person_id,name,age,gender,pet_type,breed) VALUES (3,'TRIGGERED','10','female','snake','intensifies');
INSERT INTO pet(person_id,name,age,gender,pet_type,breed) VALUES (5,'Nemo','2','male','fish','clownfish');
INSERT INTO pet(person_id,name,age,gender,pet_type,breed) VALUES (6,'Renekton','3','female','lizard','caiman');
INSERT INTO pet(person_id,name,age,gender,pet_type,breed) VALUES (7,'Tracer','2','female','bird','budgie');
INSERT INTO pet(person_id,name,age,gender,pet_type,breed) VALUES (8,'Freedom','6','male','bird','bald eagle');

--Delete a single record of your choice from the person table
DELETE FROM person WHERE person_id=3;

-- Update a single record to change a favourite number in the person table
UPDATE person SET fav_number=6 WHERE person_id=1;

-- Return all names and favourite colours from the person table
SELECT person_id, CONCAT(f_name, ' ' , l_name) AS fullname, fav_colour FROM person;

-- Return all unique pet breeds from the pet table
SELECT DISTINCT breed FROM pet;

-- Return full records of anyone whose favourite number if between 3 and 7
SELECT * FROM person WHERE fav_number BETWEEN 3 AND 7;

-- Return the full records of anyone whose name begins with a ‘c’
SELECT * FROM person WHERE f_name LIKE 'c%';

-- Return the name and value of their favourite number + 1 from the person table with the returned columns called newName and newNo
SELECT person_id, CONCAT(f_name, ' ' , l_name) AS newName, fav_number + 1 AS newNo FROM person;

-- Return the full record of the 5 people with the highest favourite numbers
SELECT * FROM person ORDER BY fav_number DESC LIMIT 5;

-- Return the name and the first 3 letters of everyone’s favourite colour. The first 3 letters of the colour should be capitalised.
SELECT person_id, CONCAT(f_name, ' ' , l_name) AS fullname, CONCAT(UCASE(SUBSTR(fav_colour FROM 1 FOR 1)),SUBSTR(fav_colour FROM 2 FOR 2)) FROM person;

-- Return everyone’s name and catchphrase returned as a single output separated by a ‘/’ character.
SELECT GROUP_CONCAT((CONCAT((CONCAT(f_name, ' ' , l_name)),' ', catchphrase)) SEPARATOR '/') FROM person;

-- Return the average of the favourite number column
SELECT AVG(fav_number) FROM person;

-- Return all details on the oldest pet
SELECT MAX(age) from pet;

-- Return all details on the youngest pet
SELECT MIN(age) from pet;

-- Return how many pets you have records for
SELECT COUNT(*) from pet;

-- Return the total sum of the favourite number column
SELECT SUM(fav_number) FROM person;

-- Return the average favourite number of everyone whose favourite colour is blue
SELECT AVG(fav_number) FROM person WHERE fav_colour='blue';

-- Return the average age for each pet type
SELECT pet_type, AVG(age) FROM pet GROUP BY pet_type;

-- Return the people name and pet name of everyone who has a pet
SELECT CONCAT(x.f_name, ' ' , x.l_name) AS personName, y.name FROM person x JOIN pet y ON x.person_id = y.person_id;

-- Return the people name of everyone who does not have a pet
SELECT CONCAT(x.f_name, ' ' , x.l_name) AS personName FROM person x LEFT OUTER JOIN pet y ON x.person_id = y.person_id WHERE y.person_id IS NULL;

-- Return a single output that contains the personID, name, and
SELECT person_id, CONCAT(f_name, ' ' , l_name) AS fullName, fav_number FROM person UNION SELECT pet_id, name, age FROM pet;

-- Create view
CREATE VIEW dogview AS SELECT * FROM pet WHERE pet_type='dog' AND age >= 5;

SELECT * FROM dogview;

-- Create a new user called Vet who can read, update, and create records in the pet table, but not delete
CREATE USER 'vet'@'localhost' IDENTIFIED BY 'S0m3P4s5w0rd';
CREATE USER 'vet'@'%' IDENTIFIED BY 'S0m3P4s5w0rd';
GRANT INSERT, SELECT, UPDATE ON  qatask2.pet TO 'vet'@'localhost';
GRANT INSERT, SELECT, UPDATE ON  qatask2.pet TO 'vet'@'%';




