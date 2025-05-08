#----------Countries-------------
CALL InsertCountry('Germany');
CALL InsertCountry('France');
CALL InsertCountry('Italy');
CALL InsertCountry('Portugal');
CALL InsertCountry('Netherlands');
CALL InsertCountry('Brazil');
CALL InsertCountry('Argentina');
CALL InsertCountry('United States');
CALL InsertCountry('Saudi Arabia');
CALL InsertCountry('Norway');
CALL InsertCountry('England');
CALL InsertCountry('Egypt');
CALL InsertCountry('Poland');
CALL InsertCountry('Croatia');
CALL InsertCountry('Spain');
CALL InsertCountry('Algeria');
CALL InsertCountry('Canada');
CALL InsertCountry('Venezuela');
CALL InsertCountry('Scotland');
CALL InsertCountry('Nigeria');

select * from Country;

#----------Leagues-----------------
CALL InsertLeague('Premier League', (SELECT Country_ID FROM Country WHERE Country_Name = 'England'));
CALL InsertLeague('La Liga', (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'));
CALL InsertLeague('Bundesliga', (SELECT Country_ID FROM Country WHERE Country_Name = 'Germany'));
CALL InsertLeague('Serie A', (SELECT Country_ID FROM Country WHERE Country_Name = 'Italy'));
CALL InsertLeague('Ligue 1', (SELECT Country_ID FROM Country WHERE Country_Name = 'France'));
CALL InsertLeague('Saudi Pro League', (SELECT Country_ID FROM Country WHERE Country_Name = 'Saudi Arabia'));
CALL InsertLeague('MLS', (SELECT Country_ID FROM Country WHERE Country_Name = 'United States'));

select * from league;

#---------Positiions---------------
INSERT INTO `position`(Position_Name)
VALUES
	('Forward'),
    ('Midfielder'),
    ('Defender'),
    ('Goalie');
    
select * from position;

#-----------teams-----------------------
-- Premier League (England)
CALL InsertClub('Manchester United', (SELECT League_ID FROM League WHERE League_Name = 'Premier League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'England'));
CALL InsertClub('Liverpool', (SELECT League_ID FROM League WHERE League_Name = 'Premier League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'England'));
CALL InsertClub('Chelsea', (SELECT League_ID FROM League WHERE League_Name = 'Premier League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'England'));
CALL InsertClub('Manchester City', (SELECT League_ID FROM League WHERE League_Name = 'Premier League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'England'));
CALL InsertClub('Arsenal', (SELECT League_ID FROM League WHERE League_Name = 'Premier League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'England'));

-- La Liga (Spain)
CALL InsertClub('FC Barcelona', (SELECT League_ID FROM League WHERE League_Name = 'La Liga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'));
CALL InsertClub('Real Madrid', (SELECT League_ID FROM League WHERE League_Name = 'La Liga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'));
CALL InsertClub('Atletico Madrid', (SELECT League_ID FROM League WHERE League_Name = 'La Liga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'));
CALL InsertClub('Sevilla FC', (SELECT League_ID FROM League WHERE League_Name = 'La Liga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'));
CALL InsertClub('Valencia CF', (SELECT League_ID FROM League WHERE League_Name = 'La Liga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'));

-- Bundesliga (Germany)
CALL InsertClub('Bayern Munich', (SELECT League_ID FROM League WHERE League_Name = 'Bundesliga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Germany'));
CALL InsertClub('Borussia Dortmund', (SELECT League_ID FROM League WHERE League_Name = 'Bundesliga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Germany'));
CALL InsertClub('RB Leipzig', (SELECT League_ID FROM League WHERE League_Name = 'Bundesliga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Germany'));
CALL InsertClub('Bayer Leverkusen', (SELECT League_ID FROM League WHERE League_Name = 'Bundesliga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Germany'));
CALL InsertClub('Wolfsburg', (SELECT League_ID FROM League WHERE League_Name = 'Bundesliga'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Germany'));

-- Serie A (Italy)
CALL InsertClub('Juventus', (SELECT League_ID FROM League WHERE League_Name = 'Serie A'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Italy'));
CALL InsertClub('AC Milan', (SELECT League_ID FROM League WHERE League_Name = 'Serie A'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Italy'));
CALL InsertClub('Inter Milan', (SELECT League_ID FROM League WHERE League_Name = 'Serie A'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Italy'));
CALL InsertClub('AS Roma', (SELECT League_ID FROM League WHERE League_Name = 'Serie A'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Italy'));
CALL InsertClub('Napoli', (SELECT League_ID FROM League WHERE League_Name = 'Serie A'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Italy'));

-- Ligue 1 (France)
CALL InsertClub('Paris Saint-Germain', (SELECT League_ID FROM League WHERE League_Name = 'Ligue 1'), (SELECT Country_ID FROM Country WHERE Country_Name = 'France'));
CALL InsertClub('Olympique Lyonnais', (SELECT League_ID FROM League WHERE League_Name = 'Ligue 1'), (SELECT Country_ID FROM Country WHERE Country_Name = 'France'));
CALL InsertClub('Olympique de Marseille', (SELECT League_ID FROM League WHERE League_Name = 'Ligue 1'), (SELECT Country_ID FROM Country WHERE Country_Name = 'France'));
CALL InsertClub('AS Monaco', (SELECT League_ID FROM League WHERE League_Name = 'Ligue 1'), (SELECT Country_ID FROM Country WHERE Country_Name = 'France'));
CALL InsertClub('Lille OSC', (SELECT League_ID FROM League WHERE League_Name = 'Ligue 1'), (SELECT Country_ID FROM Country WHERE Country_Name = 'France'));

-- MLS (United States)
CALL InsertClub('LA Galaxy', (SELECT League_ID FROM League WHERE League_Name = 'MLS'), (SELECT Country_ID FROM Country WHERE Country_Name = 'United States'));
CALL InsertClub('New York Red Bulls', (SELECT League_ID FROM League WHERE League_Name = 'MLS'), (SELECT Country_ID FROM Country WHERE Country_Name = 'United States'));
CALL InsertClub('Seattle Sounders', (SELECT League_ID FROM League WHERE League_Name = 'MLS'), (SELECT Country_ID FROM Country WHERE Country_Name = 'United States'));
CALL InsertClub('Atlanta United', (SELECT League_ID FROM League WHERE League_Name = 'MLS'), (SELECT Country_ID FROM Country WHERE Country_Name = 'United States'));
CALL InsertClub('Orlando City SC', (SELECT League_ID FROM League WHERE League_Name = 'MLS'), (SELECT Country_ID FROM Country WHERE Country_Name = 'United States'));

-- Saudi Pro League (Saudi Arabia)
CALL InsertClub('Al Nassr', (SELECT League_ID FROM League WHERE League_Name = 'Saudi Pro League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Saudi Arabia')); 
CALL InsertClub('Al Hilal', (SELECT League_ID FROM League WHERE League_Name = 'Saudi Pro League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Saudi Arabia'));  
CALL InsertClub('Al Ahli', (SELECT League_ID FROM League WHERE League_Name = 'Saudi Pro League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Saudi Arabia'));
CALL InsertClub('Al Ittihad', (SELECT League_ID FROM League WHERE League_Name = 'Saudi Pro League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Saudi Arabia'));
CALL InsertClub('Al Fateh', (SELECT League_ID FROM League WHERE League_Name = 'Saudi Pro League'), (SELECT Country_ID FROM Country WHERE Country_Name = 'Saudi Arabia'));

select * from club;


#------------Players------------
CALL InsertPlayer('Erling Haaland', '2000-07-21', (SELECT Country_ID FROM Country WHERE Country_Name = 'Norway'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Manchester City'));
CALL InsertPlayer('Bukayo Saka', '2001-09-05', (SELECT Country_ID FROM Country WHERE Country_Name = 'England'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Arsenal'));
CALL InsertPlayer('Mohamed Salah', '1992-06-15', (SELECT Country_ID FROM Country WHERE Country_Name = 'Egypt'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Liverpool'));
CALL InsertPlayer('Marcus Rashford', '1997-10-31', (SELECT Country_ID FROM Country WHERE Country_Name = 'England'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Manchester United'));
CALL InsertPlayer('Raheem Sterling', '1994-12-08', (SELECT Country_ID FROM Country WHERE Country_Name = 'England'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Chelsea'));
CALL InsertPlayer('Jude Bellingham', '2003-06-29', (SELECT Country_ID FROM Country WHERE Country_Name = 'England'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Real Madrid'));
CALL InsertPlayer('Robert Lewandowski', '1988-08-21', (SELECT Country_ID FROM Country WHERE Country_Name = 'Poland'), (SELECT Club_ID FROM Club WHERE Club_Name = 'FC Barcelona'));
CALL InsertPlayer('Antoine Griezmann', '1991-03-21', (SELECT Country_ID FROM Country WHERE Country_Name = 'France'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Atletico Madrid'));
CALL InsertPlayer('Ivan Rakitic', '1988-03-10', (SELECT Country_ID FROM Country WHERE Country_Name = 'Croatia'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Sevilla FC'));
CALL InsertPlayer('José Gayà', '1995-05-25', (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Valencia CF'));
CALL InsertPlayer('Harry Kane', '1993-07-28', (SELECT Country_ID FROM Country WHERE Country_Name = 'England'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Bayern Munich'));
CALL InsertPlayer('Marco Reus', '1989-05-31', (SELECT Country_ID FROM Country WHERE Country_Name = 'Germany'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Borussia Dortmund'));
CALL InsertPlayer('Dani Olmo', '1998-05-07', (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'), (SELECT Club_ID FROM Club WHERE Club_Name = 'RB Leipzig'));
CALL InsertPlayer('Florian Wirtz', '2003-05-03', (SELECT Country_ID FROM Country WHERE Country_Name = 'Germany'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Bayer Leverkusen'));
CALL InsertPlayer('Maximilian Arnold', '1994-05-27', (SELECT Country_ID FROM Country WHERE Country_Name = 'Germany'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Wolfsburg'));
CALL InsertPlayer('Federico Chiesa', '1997-10-25', (SELECT Country_ID FROM Country WHERE Country_Name = 'Italy'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Juventus'));
CALL InsertPlayer('Rafael Leão', '1999-06-10', (SELECT Country_ID FROM Country WHERE Country_Name = 'Portugal'), (SELECT Club_ID FROM Club WHERE Club_Name = 'AC Milan'));
CALL InsertPlayer('Lautaro Martínez', '1997-08-22', (SELECT Country_ID FROM Country WHERE Country_Name = 'Argentina'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Inter Milan'));
CALL InsertPlayer('Paulo Dybala', '1993-11-15', (SELECT Country_ID FROM Country WHERE Country_Name = 'Argentina'), (SELECT Club_ID FROM Club WHERE Club_Name = 'AS Roma'));
CALL InsertPlayer('Victor Osimhen', '1998-12-29', (SELECT Country_ID FROM Country WHERE Country_Name = 'Nigeria'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Napoli'));
CALL InsertPlayer('Kylian Mbappé', '1998-12-20', (SELECT Country_ID FROM Country WHERE Country_Name = 'France'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Paris Saint-Germain'));
CALL InsertPlayer('Alexandre Lacazette', '1991-05-28', (SELECT Country_ID FROM Country WHERE Country_Name = 'France'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Olympique Lyonnais'));
CALL InsertPlayer('Jonathan Clauss', '1992-09-25', (SELECT Country_ID FROM Country WHERE Country_Name = 'France'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Olympique de Marseille'));
CALL InsertPlayer('Wissam Ben Yedder', '1990-08-12', (SELECT Country_ID FROM Country WHERE Country_Name = 'France'), (SELECT Club_ID FROM Club WHERE Club_Name = 'AS Monaco'));
CALL InsertPlayer('Jonathan David', '2000-01-14', (SELECT Country_ID FROM Country WHERE Country_Name = 'Canada'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Lille OSC'));
CALL InsertPlayer('Lionel Messi', '1987-06-24', (SELECT Country_ID FROM Country WHERE Country_Name = 'Argentina'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Orlando City SC'));
CALL InsertPlayer('Jordan Morris', '1994-10-26', (SELECT Country_ID FROM Country WHERE Country_Name = 'United States'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Seattle Sounders'));
CALL InsertPlayer('Josef Martínez', '1993-05-19', (SELECT Country_ID FROM Country WHERE Country_Name = 'Venezuela'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Atlanta United'));
CALL InsertPlayer('Riqui Puig', '1999-08-13', (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'), (SELECT Club_ID FROM Club WHERE Club_Name = 'LA Galaxy'));
CALL InsertPlayer('Lewis Morgan', '1996-09-30', (SELECT Country_ID FROM Country WHERE Country_Name = 'Scotland'), (SELECT Club_ID FROM Club WHERE Club_Name = 'New York Red Bulls'));
CALL InsertPlayer('Cristiano Ronaldo', '1985-02-05', (SELECT Country_ID FROM Country WHERE Country_Name = 'Portugal'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Al Nassr'));
CALL InsertPlayer('Neymar Jr', '1992-02-05', (SELECT Country_ID FROM Country WHERE Country_Name = 'Brazil'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Al Hilal'));
CALL InsertPlayer('Riyad Mahrez', '1991-02-21', (SELECT Country_ID FROM Country WHERE Country_Name = 'Algeria'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Al Ahli'));
CALL InsertPlayer('Karim Benzema', '1987-12-19', (SELECT Country_ID FROM Country WHERE Country_Name = 'France'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Al Ittihad'));
CALL InsertPlayer('Cristian Tello', '1991-08-19', (SELECT Country_ID FROM Country WHERE Country_Name = 'Spain'), (SELECT Club_ID FROM Club WHERE Club_Name = 'Al Fateh'));

select * from player;
