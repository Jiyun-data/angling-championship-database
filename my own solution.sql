USE `my solution`;

-- Drop all tables first (safe order)
DROP TABLE IF EXISTS Fish_Catch;
DROP TABLE IF EXISTS Boat_Allocation;
DROP TABLE IF EXISTS Qualifier;
DROP TABLE IF EXISTS Entrant_Boat_Person;
DROP TABLE IF EXISTS Report;
DROP TABLE IF EXISTS Entrant;
DROP TABLE IF EXISTS Boat_Person;
DROP TABLE IF EXISTS Boat;
DROP TABLE IF EXISTS Competition_Day;
DROP TABLE IF EXISTS Competition_Section;
DROP TABLE IF EXISTS County;
DROP TABLE IF EXISTS Province;

-- Province (no dependencies)
CREATE TABLE Province (
    Province_ID INT PRIMARY KEY,
    Province_Name VARCHAR(255) NOT NULL
);

-- County (depends on Province)
CREATE TABLE County (
    County_ID INT PRIMARY KEY,
    County_Name VARCHAR(255) NOT NULL,
    Province_ID INT,
    FOREIGN KEY (Province_ID) REFERENCES Province(Province_ID)
);

-- Competition_Section lookup table (no dependencies)
CREATE TABLE Competition_Section (
    Section_ID INT PRIMARY KEY,
    Section_Name VARCHAR(50) NOT NULL  -- Changed from ENUM to VARCHAR for flexibility
);

-- Insert default sections
INSERT INTO Competition_Section (Section_ID, Section_Name) VALUES 
(1, 'Senior'), (2, 'Junior'), (3, 'Ladies');

-- Entrant table (now depends on County, Province, Competition_Section)
CREATE TABLE Entrant (
    Entrant_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    County_ID INT,
    Province_ID INT,
    Telephone_Number VARCHAR(15),
    Email_Address VARCHAR(255),
    Competition_Section_ID INT,  -- FIXED: INT referencing Section_ID (not ENUM)
    Entry_Status ENUM('Entrant', 'Qualifier', 'Lottery', 'Withdrawn'),
    Fee_Paid DECIMAL(10, 2) CHECK (Fee_Paid >= 0),
    Additional_Notes TEXT,
    FOREIGN KEY (County_ID) REFERENCES County(County_ID),
    FOREIGN KEY (Province_ID) REFERENCES Province(Province_ID),
    FOREIGN KEY (Competition_Section_ID) REFERENCES Competition_Section(Section_ID)
);

-- Boat_Person table
CREATE TABLE Boat_Person (
    Boat_Person_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Contact_Details TEXT,
    Additional_Information TEXT,
    Declaration_Signed BOOLEAN,
    Availability_Status ENUM('Available', 'Unavailable', 'Reserve', 'Boating', 'Fishing') NOT NULL
);

-- Boat table
CREATE TABLE Boat (
    Boat_ID INT PRIMARY KEY,
    Boat_Number INT UNIQUE
);

-- Competition_Day table
CREATE TABLE Competition_Day (
    Competition_Day_ID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Day_Number INT NOT NULL,
    Qualifying BOOLEAN
);

-- Boat_Allocation table
CREATE TABLE Boat_Allocation (
    Boat_ID INT,
    Competition_Day_ID INT,
    Entrant_1_ID INT,
    Entrant_2_ID INT,
    Boat_Person_ID INT,
    PRIMARY KEY (Boat_ID, Competition_Day_ID),
    FOREIGN KEY (Boat_ID) REFERENCES Boat(Boat_ID),
    FOREIGN KEY (Competition_Day_ID) REFERENCES Competition_Day(Competition_Day_ID),
    FOREIGN KEY (Entrant_1_ID) REFERENCES Entrant(Entrant_ID),
    FOREIGN KEY (Entrant_2_ID) REFERENCES Entrant(Entrant_ID),
    FOREIGN KEY (Boat_Person_ID) REFERENCES Boat_Person(Boat_Person_ID)
);

-- Fish_Catch table
CREATE TABLE Fish_Catch (
    Entrant_ID INT,
    Boat_ID INT,
    Competition_Day_ID INT,
    Number_of_Fish INT,
    Total_Weight DECIMAL(10, 2),
    Heaviest_Fish DECIMAL(10, 2),
    Boat_Person_Signature VARCHAR(255),
    PRIMARY KEY (Entrant_ID, Boat_ID, Competition_Day_ID),
    FOREIGN KEY (Entrant_ID) REFERENCES Entrant(Entrant_ID),
    FOREIGN KEY (Boat_ID) REFERENCES Boat(Boat_ID),
    FOREIGN KEY (Competition_Day_ID) REFERENCES Competition_Day(Competition_Day_ID)
);

-- Qualifier table
CREATE TABLE Qualifier (
    Entrant_ID INT,
    Competition_Day_ID INT,
    Qualified_By ENUM('Merit', 'Lottery') NOT NULL,
    PRIMARY KEY (Entrant_ID, Competition_Day_ID),
    FOREIGN KEY (Entrant_ID) REFERENCES Entrant(Entrant_ID),
    FOREIGN KEY (Competition_Day_ID) REFERENCES Competition_Day(Competition_Day_ID)
);

-- Report table
CREATE TABLE Report (
    Report_ID INT PRIMARY KEY,
    Competition_Day_ID INT,
    Report_Type ENUM('Qualifying_Anglers', 'Heaviest_Fish', 'Finishing_Order') NOT NULL,
    Generated_On DATE NOT NULL,
    FOREIGN KEY (Competition_Day_ID) REFERENCES Competition_Day(Competition_Day_ID)
);

-- Entrant_Boat_Person
CREATE TABLE Entrant_Boat_Person (
    Entrant_Boat_Person_ID INT PRIMARY KEY,
    Entrant_ID INT,
    Boat_Person_ID INT,
    Day DATE NOT NULL,
    Role VARCHAR(255) NOT NULL,
    FOREIGN KEY (Entrant_ID) REFERENCES Entrant(Entrant_ID),
    FOREIGN KEY (Boat_Person_ID) REFERENCES Boat_Person(Boat_Person_ID)
);
