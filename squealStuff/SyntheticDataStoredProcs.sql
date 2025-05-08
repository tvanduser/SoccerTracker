#stored proc to insert a country
DELIMITER $$

CREATE PROCEDURE InsertCountry(IN country_name VARCHAR(100))
BEGIN
    INSERT INTO Country (Country_Name)
    VALUES (country_name);
END$$

DELIMITER ;

#sotred proc to insert leagues
DELIMITER $$

CREATE PROCEDURE InsertLeague(IN league_name VARCHAR(100), IN country_id INT)
BEGIN
    INSERT INTO League (League_Name, Country_ID)
    VALUES (league_name, country_id);
END$$

DELIMITER ;

#stored proc to insert teams
DELIMITER $$

CREATE PROCEDURE InsertClub(
    IN club_name VARCHAR(100),
    IN league_id INT,
    IN country_id INT
)
BEGIN
    INSERT INTO Club (Club_Name, League_ID, Country_ID)
    VALUES (club_name, league_id, country_id);
END$$

DELIMITER ;


#stored proc to insert players
DELIMITER $$

CREATE PROCEDURE InsertPlayer(
    IN player_name VARCHAR(100),
    IN date_of_birth DATE,
    IN nationality_id INT,
    IN club_id INT
)
BEGIN
    INSERT INTO player (Player_Name, Date_of_Birth, Nationality_ID, Club_ID)
    VALUES (player_name, date_of_birth, nationality_id, club_id);
END$$

DELIMITER ;

DELIMITER //

CREATE PROCEDURE getPlayerProfile(IN playerName VARCHAR(100))
BEGIN
    SELECT 
        p.Player_Name,
        p.Date_of_Birth,
        pos.Position_Name,
        nat.Country_Name AS Nationality,
        c.Club_Name,
        l.League_Name,
        club_country.Country_Name AS Club_Country
    FROM Player p
    JOIN Country nat ON p.Nationality_ID = nat.Country_ID
    JOIN Club c ON p.Club_ID = c.Club_ID
    JOIN League l ON c.League_ID = l.League_ID
    JOIN Country club_country ON c.Country_ID = club_country.Country_ID
    JOIN Position pos ON p.Position_ID = pos.Position_ID
    WHERE p.Player_Name = playerName;
END //

DELIMITER ;

call getPlayerProfile("Lionel Messi")


