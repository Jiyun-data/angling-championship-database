-- Delete everything and start over
DROP SCHEMA IF EXISTS `angling championship`;

-- Create fresh database
CREATE SCHEMA `angling championship`;
USE `angling championship`;

CREATE TABLE Province (
    Province_ID INT AUTO_INCREMENT PRIMARY KEY,
    Province_Name ENUM('Connacht', 'Ulster', 'Leinster', 'Munster', 'Outside Ireland') NOT NULL
);

CREATE TABLE County (
    County_ID INT AUTO_INCREMENT PRIMARY KEY,
    County_Name VARCHAR(100) NOT NULL,
    Province_ID INT,
    FOREIGN KEY (Province_ID) REFERENCES Province(Province_ID)
);

CREATE TABLE Competition_Section (
    Competition_Section_ID INT AUTO_INCREMENT PRIMARY KEY,
    Section_Name ENUM('Senior', 'Junior', 'Ladies') NOT NULL
);

CREATE TABLE Entrant (
    Entrant_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Telephone VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Entry_Status ENUM('entrant', 'qualifier', 'lottery', 'withdrawn') DEFAULT 'entrant',
    Fee_Paid DECIMAL(10, 2) NOT NULL,
    Additional_Notes TEXT,
    County_ID INT,
    Province_ID INT,
    Competition_Section_ID INT,
    UNIQUE (Email),
    FOREIGN KEY (County_ID) REFERENCES County(County_ID),
    FOREIGN KEY (Province_ID) REFERENCES Province(Province_ID),
    FOREIGN KEY (Competition_Section_ID) REFERENCES Competition_Section(Competition_Section_ID)
);

CREATE TABLE Boat (
    Boat_ID INT AUTO_INCREMENT PRIMARY KEY,
    Boat_Number VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE Boat_Person (
    Boat_Person_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact_Details VARCHAR(255) NOT NULL,
    Additional_Info TEXT,
    Declaration_Signed BOOLEAN DEFAULT FALSE,
    Boat_Person_Status ENUM('Available', 'Unavailable', 'Boating', 'Reserve') NOT NULL,
    Entrant_ID INT,
    FOREIGN KEY (Entrant_ID) REFERENCES Entrant(Entrant_ID) ON DELETE SET NULL
);

CREATE TABLE Competition_Day (
    Day INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE NOT NULL,
    Day_Sequence ENUM('Qualifying Day', 'Final Day') NOT NULL,
    Competition_Type ENUM('Senior', 'Junior', 'Ladies') NOT NULL
);

CREATE TABLE Fish_Catch (
    Fish_Catch_ID INT AUTO_INCREMENT PRIMARY KEY,
    Day INT NOT NULL,
    Entrant_ID INT,
    Boat_Person_ID INT,
    Number_of_Fish INT NOT NULL,
    Cumulative_Weight DECIMAL(10, 2) NOT NULL,
    Heaviest_Fish_Weight DECIMAL(10, 2),
    Boat_ID INT,
    Boat_Person_Signature BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (Entrant_ID) REFERENCES Entrant(Entrant_ID),
    FOREIGN KEY (Boat_Person_ID) REFERENCES Boat_Person(Boat_Person_ID),
    FOREIGN KEY (Boat_ID) REFERENCES Boat(Boat_ID)
);

CREATE TABLE Boat_Person_Availability (
    Boat_Person_Availability_ID INT AUTO_INCREMENT PRIMARY KEY,
    Boat_Person_ID INT,
    Day INT NOT NULL,
    Availability_Status ENUM('Available', 'Unavailable', 'Reserve', 'Boating', 'Fishing') NOT NULL,
    FOREIGN KEY (Boat_Person_ID) REFERENCES Boat_Person(Boat_Person_ID)
);

CREATE TABLE Boat_Allocation (
    Boat_Allocation_ID INT AUTO_INCREMENT PRIMARY KEY,
    Day INT NOT NULL,
    Date DATE NOT NULL,
    Boat_ID INT,
    Boat_Person_ID INT,
    Entrant_1_ID INT,
    Entrant_2_ID INT,
    FOREIGN KEY (Boat_ID) REFERENCES Boat(Boat_ID),
    FOREIGN KEY (Boat_Person_ID) REFERENCES Boat_Person(Boat_Person_ID),
    FOREIGN KEY (Entrant_1_ID) REFERENCES Entrant(Entrant_ID),
    FOREIGN KEY (Entrant_2_ID) REFERENCES Entrant(Entrant_ID)
);

CREATE TABLE Qualifier (
    Qualifier_ID INT AUTO_INCREMENT PRIMARY KEY,
    Entrant_ID INT,
    Day INT NOT NULL,
    Qualification_Type ENUM('Qualifier', 'Lottery') NOT NULL,
    Fish_Catch_ID INT,
    FOREIGN KEY (Entrant_ID) REFERENCES Entrant(Entrant_ID),
    FOREIGN KEY (Fish_Catch_ID) REFERENCES Fish_Catch(Fish_Catch_ID)
);

CREATE TABLE Report (
    Report_ID INT AUTO_INCREMENT PRIMARY KEY,
    Report_Type ENUM('Today\'s Qualifying Anglers', 'Today\'s Heaviest Fish', 'Today\'s Finishing Order') NOT NULL,
    Report_Data TEXT
);

CREATE TABLE Entrant_Boat_Person (
    Entrant_Boat_Person_ID INT AUTO_INCREMENT PRIMARY KEY,
    Entrant_ID INT,
    Boat_Person_ID INT,
    Day INT NOT NULL,
    Role ENUM('Entrant', 'Boat_Person') NOT NULL,
    FOREIGN KEY (Entrant_ID) REFERENCES Entrant(Entrant_ID),
    FOREIGN KEY (Boat_Person_ID) REFERENCES Boat_Person(Boat_Person_ID),
    FOREIGN KEY (Day) REFERENCES Competition_Day(Day)
);
