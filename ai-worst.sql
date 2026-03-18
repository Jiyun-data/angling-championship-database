USE master;
GO

-- Create database if not exists
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'AnglingChampionship')
    CREATE DATABASE AnglingChampionship;
GO

USE AnglingChampionship;
GO

-- 1. ENTRANT TABLE
CREATE TABLE Entrant (
    EntrantID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    County VARCHAR(100),
    TelephoneNumber VARCHAR(15),
    EmailAddress VARCHAR(100) UNIQUE,
    Province VARCHAR(20) NOT NULL CHECK (Province IN ('Connacht', 'Ulster', 'Leinster', 'Munster', 'Outside Ireland')),
    CompetitionSection VARCHAR(10) NOT NULL CHECK (CompetitionSection IN ('Senior', 'Junior', 'Ladies')),
    EntryStatus VARCHAR(10) DEFAULT 'Entrant' CHECK (EntryStatus IN ('Entrant', 'Qualifier', 'Lottery', 'Withdrawn')),
    FeePaid DECIMAL(10, 2),
    AdditionalNotes TEXT
);

-- 2. BOATPERSON TABLE (connects to Entrant)
CREATE TABLE BoatPerson (
    BoatPersonID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    ContactDetails VARCHAR(255),
    AdditionalInformation TEXT,
    DeclarationSigned BIT NOT NULL DEFAULT 0,
    AvailabilityStatus VARCHAR(10) NOT NULL DEFAULT 'Available' CHECK (AvailabilityStatus IN ('Available', 'Unavailable', 'Reserve', 'Boating', 'Fishing')),
    EntrantID INT NULL,  -- Nullable FK to Entrant
    FOREIGN KEY (EntrantID) REFERENCES Entrant(EntrantID) ON DELETE SET NULL
);

-- 3. BOAT TABLE
CREATE TABLE Boat (
    BoatID INT PRIMARY KEY IDENTITY(1,1),
    BoatNumber VARCHAR(10) UNIQUE NOT NULL
);

-- 4. COMPETITIONDAY TABLE
CREATE TABLE CompetitionDay (
    CompetitionDayID INT PRIMARY KEY IDENTITY(1,1),
    DayNumber INT NOT NULL,
    Date DATE NOT NULL
);

-- 5. FISH CATCH TABLE (connects ALL tables together)
CREATE TABLE FishCatch (
    FishCatchID INT PRIMARY KEY IDENTITY(1,1),
    CompetitionDayID INT NOT NULL,
    EntrantID INT NOT NULL,
    BoatID INT NOT NULL,
    BoatPersonID INT NOT NULL,
    NumberOfFish INT NOT NULL,
    TotalWeight DECIMAL(10, 2) NOT NULL,
    HeaviestFishWeight DECIMAL(10, 2),
    BoatPersonSignature VARCHAR(100),
    
    -- FOREIGN KEY CONNECTIONS (This is the key!)
    FOREIGN KEY (CompetitionDayID) REFERENCES CompetitionDay(CompetitionDayID) ON DELETE CASCADE,
    FOREIGN KEY (EntrantID) REFERENCES Entrant(EntrantID) ON DELETE CASCADE,
    FOREIGN KEY (BoatID) REFERENCES Boat(BoatID) ON DELETE CASCADE,
    FOREIGN KEY (BoatPersonID) REFERENCES BoatPerson(BoatPersonID) ON DELETE CASCADE
);

-- 6. FINALS TABLE (connects to Entrant, BoatPerson, Boat)
CREATE TABLE Finals (
    FinalsID INT PRIMARY KEY IDENTITY(1,1),
    EntrantID INT NOT NULL,
    BoatPersonID INT NOT NULL,
    BoatID INT NOT NULL,
    FinalPosition INT,
    
    FOREIGN KEY (EntrantID) REFERENCES Entrant(EntrantID) ON DELETE CASCADE,
    FOREIGN KEY (BoatPersonID) REFERENCES BoatPerson(BoatPersonID) ON DELETE CASCADE,
    FOREIGN KEY (BoatID) REFERENCES Boat(BoatID) ON DELETE CASCADE
);

-- 7. EXPENSE TABLE (connects to BoatPerson)
CREATE TABLE Expense (
    ExpenseID INT PRIMARY KEY IDENTITY(1,1),
    BoatPersonID INT NOT NULL,
    Date DATE NOT NULL,
    AmountPaid DECIMAL(10, 2) NOT NULL CHECK (AmountPaid >= 0),
    
    FOREIGN KEY (BoatPersonID) REFERENCES BoatPerson(BoatPersonID) ON DELETE CASCADE
);

-- 8. PAST EVENT TABLE (connects to Entrant)
CREATE TABLE PastEvent (
    PastEventID INT PRIMARY KEY IDENTITY(1,1),
    Year INT NOT NULL,
    EntrantID INT NOT NULL,
    Position INT NOT NULL,
    Section VARCHAR(10) NOT NULL CHECK (Section IN ('Senior', 'Junior', 'Ladies')),
    Prize VARCHAR(100),
    
    FOREIGN KEY (EntrantID) REFERENCES Entrant(EntrantID) ON DELETE CASCADE
);

