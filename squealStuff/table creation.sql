-- Table for Countries
CREATE TABLE Country (
    Country_ID INT AUTO_INCREMENT PRIMARY KEY,
    Country_Name VARCHAR(100) NOT NULL UNIQUE
);

-- Table for Leagues
CREATE TABLE League (
    League_ID INT AUTO_INCREMENT PRIMARY KEY,
    League_Name VARCHAR(100) NOT NULL,
    Country_ID INT NOT NULL,
    FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
);

-- Table for Clubs
CREATE TABLE Club (
    Club_ID INT AUTO_INCREMENT PRIMARY KEY,
    Club_Name VARCHAR(100) NOT NULL,
    League_ID INT NOT NULL,
    Country_ID INT NOT NULL,
    FOREIGN KEY (League_ID) REFERENCES League(League_ID),
    FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
);

-- Table for Players
CREATE TABLE Player (
    Player_ID INT AUTO_INCREMENT PRIMARY KEY,
    Player_Name VARCHAR(100) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Nationality_ID INT NOT NULL,
    Club_ID INT NOT NULL,
    FOREIGN KEY (Nationality_ID) REFERENCES Country(Country_ID),
    FOREIGN KEY (Club_ID) REFERENCES Club(Club_ID)
);

-- Table for Positions
CREATE TABLE Position (
    Position_ID INT AUTO_INCREMENT PRIMARY KEY,
    Position_Name VARCHAR(50) NOT NULL UNIQUE
);

-- Table to handle Player -> Positions (many-to-many relationship)
CREATE TABLE Player_Position (
    Player_ID INT NOT NULL,
    Position_ID INT NOT NULL,
    PRIMARY KEY (Player_ID, Position_ID),
    FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID),
    FOREIGN KEY (Position_ID) REFERENCES `Position`(Position_ID)
);

-- Table for Player Stats (per season)
CREATE TABLE Player_Stats (
    Stats_ID INT AUTO_INCREMENT PRIMARY KEY,
    Player_ID INT NOT NULL,
    Season YEAR NOT NULL,
    Appearances INT DEFAULT 0,
    Goals INT DEFAULT 0,
    Assists INT DEFAULT 0,
    Yellow_Cards INT DEFAULT 0,
    Red_Cards INT DEFAULT 0,
    FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID)
);

-- random stuff I am tweaking with

ALTER TABLE Player
ADD COLUMN Position_ID INT,
ADD CONSTRAINT fk_position
FOREIGN KEY (Position_ID) REFERENCES `Position`(Position_ID);


select * from player;
select * from position


