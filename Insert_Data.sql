--------- Country --------- (David)
INSERT INTO Country (CountryName)
SELECT DISTINCT SUBSTR(City, INSTR(City, ',') + 2) AS CountryName
FROM ds1_players
WHERE INSTR(City, ',') > 0     --Verifiquem que té coma el camp
AND SUBSTR(City, INSTR(City, ',') + 2) NOT IN (SELECT CountryName FROM Country);

-- Inserim totes els països de la taula ds1_match en el cas que no estigui
INSERT INTO Country (CountryName)
SELECT DISTINCT SUBSTR(city, INSTR(city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(city, ',') > 0
AND SUBSTR(city, INSTR(city, ',') + 2) NOT IN (SELECT CountryName FROM Country);

INSERT INTO Country (CountryName)
SELECT DISTINCT SUBSTR(home_manager_city, INSTR(home_manager_city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(home_manager_city, ',') > 0
AND SUBSTR(home_manager_city, INSTR(home_manager_city, ',') + 2) NOT IN (SELECT CountryName FROM Country);

INSERT INTO Country (CountryName)
SELECT DISTINCT SUBSTR(away_manager_city, INSTR(away_manager_city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(away_manager_city, ',') > 0
AND SUBSTR(away_manager_city, INSTR(away_manager_city, ',') + 2) NOT IN (SELECT CountryName FROM Country);

INSERT INTO Country (CountryName)
SELECT DISTINCT SUBSTR(home_city, INSTR(home_city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(home_city, ',') > 0
AND SUBSTR(home_city, INSTR(home_city, ',') + 2) NOT IN (SELECT CountryName FROM Country);

INSERT INTO Country (CountryName)
SELECT DISTINCT SUBSTR(away_city, INSTR(away_city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(away_city, ',') > 0
AND SUBSTR(away_city, INSTR(away_city, ',') + 2) NOT IN (SELECT CountryName FROM Country);


--------- Country (user_db) --------- (Marina)

INSERT INTO Country (CountryName)
SELECT DISTINCT SUBSTR(localization, INSTR(localization, ',') + 2) AS CountryName
FROM ds3_posts
WHERE INSTR(localization, ',') > 0
AND SUBSTR(localization, INSTR(localization, ',') + 2) NOT IN (SELECT CountryName FROM Country);


--------- Country (product_sales) --------- (Pol)
INSERT INTO Country (CountryName)   --> Inserim tots els països que poden faltar de scripts anteriors
SELECT DISTINCT SUBSTR(City, INSTR(City, ',') + 2) AS CountryName
FROM ds2_product_sales p
WHERE INSTR(City, ',') > 0          --> Verifiquem que té coma el camp
  AND NOT EXISTS (
    SELECT 1
    FROM Country c
    WHERE c.CountryName = SUBSTR(City, INSTR(City, ',') + 2)
);


--------- City --------- (David)

INSERT INTO City (CityName, CountryName)
SELECT DISTINCT SUBSTR(City, 1, INSTR(City, ',') - 1) AS CityName, SUBSTR(City, INSTR(City, ',') + 2) AS CountryName
FROM ds1_players
WHERE INSTR(City, ',') > 0
AND (SUBSTR(City, 1, INSTR(City, ',') - 1), SUBSTR(City, INSTR(City, ',') + 2)) NOT IN (SELECT CityName, CountryName FROM City);

-- Inserim totes els països de la taula ds1_match en el cas que no estigui
INSERT INTO City (CityName, CountryName)
SELECT DISTINCT SUBSTR(city, 1, INSTR(city, ',') - 1) AS CityName, SUBSTR(city, INSTR(city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(city, ',') > 0
AND (SUBSTR(city, 1, INSTR(city, ',') - 1), SUBSTR(city, INSTR(city, ',') + 2)) NOT IN (SELECT CityName, CountryName FROM City);

INSERT INTO City (CityName, CountryName)
SELECT DISTINCT SUBSTR(home_manager_city, 1, INSTR(home_manager_city, ',') - 1) AS CityName, SUBSTR(home_manager_city, INSTR(home_manager_city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(home_manager_city, ',') > 0
AND (SUBSTR(home_manager_city, 1, INSTR(home_manager_city, ',') - 1), SUBSTR(home_manager_city, INSTR(home_manager_city, ',') + 2)) NOT IN (SELECT CityName, CountryName FROM City);

INSERT INTO City (CityName, CountryName)
SELECT DISTINCT SUBSTR(away_manager_city, 1, INSTR(away_manager_city, ',') - 1) AS CityName, SUBSTR(away_manager_city, INSTR(away_manager_city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(away_manager_city, ',') > 0
AND (SUBSTR(away_manager_city, 1, INSTR(away_manager_city, ',') - 1), SUBSTR(away_manager_city, INSTR(away_manager_city, ',') + 2)) NOT IN (SELECT CityName, CountryName FROM City);

INSERT INTO City (CityName, CountryName)
SELECT DISTINCT SUBSTR(home_city, 1, INSTR(home_city, ',') - 1) AS CityName, SUBSTR(home_city, INSTR(home_city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(home_city, ',') > 0
AND (SUBSTR(home_city, 1, INSTR(home_city, ',') - 1), SUBSTR(home_city, INSTR(home_city, ',') + 2)) NOT IN (SELECT CityName, CountryName FROM City);

INSERT INTO City (CityName, CountryName)
SELECT DISTINCT SUBSTR(away_city, 1, INSTR(away_city, ',') - 1) AS CityName, SUBSTR(away_city, INSTR(away_city, ',') + 2) AS CountryName
FROM ds1_match
WHERE INSTR(away_city, ',') > 0
AND (SUBSTR(away_city, 1, INSTR(away_city, ',') - 1), SUBSTR(away_city, INSTR(away_city, ',') + 2)) NOT IN (SELECT CityName, CountryName FROM City);


----------City (user_db) ------ (Marina)

INSERT INTO City (CityName, CountryName)
SELECT DISTINCT SUBSTR(localization, 1, INSTR(localization, ',') - 1) AS CityName, SUBSTR(localization, INSTR(localization, ',') + 2) AS CountryName
FROM ds3_posts
WHERE INSTR(localization, ',') > 0
AND (SUBSTR(localization, 1, INSTR(localization, ',') - 1), SUBSTR(localization, INSTR(localization, ',') + 2)) NOT IN (SELECT CityName, CountryName FROM City);


--------- City  (product_sales) --------- (Pol)
INSERT INTO City (CityName, CountryName) --> Inserim totes les ciutats que poden faltar de scripts anteriors
SELECT DISTINCT
    SUBSTR(City, 1, INSTR(City, ',') - 1) AS CityName,
    SUBSTR(City, INSTR(City, ',') + 2) AS CountryName
FROM ds2_product_sales p
WHERE INSTR(City, ',') > 0          --> Verifiquem que té coma el camp
  AND NOT EXISTS (
    SELECT 1
    FROM City c
    WHERE c.CountryName = SUBSTR(City, INSTR(City, ',') + 2)
      AND c.CityName = SUBSTR(City, 1, INSTR(City, ',') - 1)
);

--------- Club --------- (David)

INSERT INTO Club (ClubName, IdCity)
SELECT DISTINCT dsm.home,
    (SELECT IdCity FROM City WHERE SUBSTR(dsm.home_city, 1, INSTR(dsm.home_city, ',') - 1) = CityName
        AND SUBSTR(dsm.home_city, INSTR(dsm.home_city, ',') + 2) = CountryName) AS IdCity
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1 FROM Club c
    WHERE c.ClubName = dsm.home
    AND c.IdCity = (SELECT IdCity FROM City WHERE SUBSTR(dsm.home_city, 1, INSTR(dsm.home_city, ',') - 1) = CityName
                AND SUBSTR(dsm.home_city, INSTR(dsm.home_city, ',') + 2) = CountryName)
);


INSERT INTO Club (ClubName, IdCity)
SELECT DISTINCT dsm.away, 
    (SELECT IdCity FROM City WHERE SUBSTR(dsm.away_city, 1, INSTR(dsm.away_city, ',') - 1) = CityName
        AND SUBSTR(dsm.away_city, INSTR(dsm.away_city, ',') + 2) = CountryName) AS IdCity
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1 FROM Club c 
    WHERE c.ClubName = dsm.away 
    AND c.IdCity = (SELECT IdCity FROM City WHERE SUBSTR(dsm.away_city, 1, INSTR(dsm.away_city, ',') - 1) = CityName
                AND SUBSTR(dsm.away_city, INSTR(dsm.away_city, ',') + 2) = CountryName)
);


--------- Stadium --------- (David)

INSERT INTO Stadium (StadiumName, IdCity)
SELECT DISTINCT venue AS StadiumName, 
        (SELECT IdCity FROM City WHERE 
        SUBSTR(dsm.city, 1, INSTR(dsm.city, ',') - 1) = CityName
        AND SUBSTR(dsm.city, INSTR(dsm.city, ',') + 2) = CountryName) AS IdCity
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1 FROM Stadium s
    WHERE dsm.venue = s.StadiumName
    AND s.IdCity = (SELECT IdCity FROM City WHERE 
                SUBSTR(dsm.city, 1, INSTR(dsm.city, ',') - 1) = CityName
                AND SUBSTR(dsm.city, INSTR(dsm.city, ',') + 2) = CountryName)
);


---------ClubStadium---------- (David)  

INSERT INTO ClubStadium (ClubName, StadiumName) 
SELECT DISTINCT dsm.home AS ClubName, dsm.venue AS StadiumName
FROM ds1_match dsm
WHERE NOT EXISTS
    (SELECT 1 FROM ClubStadium cs
    WHERE cs.ClubName = dsm.home
    AND cs.StadiumName = dsm.venue);


--------- Competition --------- (David)

INSERT INTO Competition (League, Season)
SELECT DISTINCT dsm.league, dsm.season
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1 FROM Competition c 
    WHERE c.League = dsm.league AND c.Season = dsm.season);

 
--------- Match --------- (Mada) 

INSERT INTO Match (
    MatchId, MatchDate, MatchHour, Attendance, StadiumName, IdCompetition, HomeClubName, AwayClubName, 
    HomePossession, AwayPossession, HomeGoals, AwayGoals, HomePoints, AwayPoints, IdCity)
SELECT DISTINCT 
    m.match_id AS MatchId, 
    m.match_date AS MatchDate, 
    NULL AS MatchHour,
    m.attendance AS Attendance, 
    m.venue AS StadiumName, 
    c.IdCompetition AS IdCompetition,
    m.home AS HomeClubName,
    m.away AS AwayClubName,
    m.home_poss AS HomePossession,
    m.away_poss AS AwayPossession,
    CASE 
        WHEN homeInfo.HomeGoals IS NULL THEN 0
        ELSE homeInfo.HomeGoals
    END AS HomeGoals,
    CASE 
        WHEN awayInfo.AwayGoals IS NULL THEN 0
        ELSE awayInfo.AwayGoals
    END AS AwayGoals,
    CASE
        WHEN (CASE WHEN homeInfo.HomeGoals IS NULL THEN 0 ELSE homeInfo.HomeGoals END) > 
             (CASE WHEN awayInfo.AwayGoals IS NULL THEN 0 ELSE awayInfo.AwayGoals END) THEN 3
        WHEN (CASE WHEN homeInfo.HomeGoals IS NULL THEN 0 ELSE homeInfo.HomeGoals END) < 
             (CASE WHEN awayInfo.AwayGoals IS NULL THEN 0 ELSE awayInfo.AwayGoals END) THEN 0
        ELSE 1
    END AS HomePoints,
    CASE
        WHEN (CASE WHEN homeInfo.HomeGoals IS NULL THEN 0 ELSE homeInfo.HomeGoals END) > 
             (CASE WHEN awayInfo.AwayGoals IS NULL THEN 0 ELSE awayInfo.AwayGoals END) THEN 0
        WHEN (CASE WHEN homeInfo.HomeGoals IS NULL THEN 0 ELSE homeInfo.HomeGoals END) < 
             (CASE WHEN awayInfo.AwayGoals IS NULL THEN 0 ELSE awayInfo.AwayGoals END) THEN 3
        ELSE 1
    END AS AwayPoints,
    (SELECT IdCity FROM City c WHERE SUBSTR(m.city, 1, INSTR(m.city, ',') - 1) = c.CityName
                    AND SUBSTR(m.city, INSTR(m.city, ',') + 2) = c.CountryName) AS IdCity
FROM ds1_match m
JOIN Competition c ON m.league = c.League AND m.season = c.Season
LEFT JOIN (SELECT match_id, club, SUM(goals) AS HomeGoals FROM ds1_players GROUP BY match_id, club
) homeInfo ON m.match_id = homeInfo.match_id AND m.home = homeInfo.club
LEFT JOIN (SELECT match_id, club, SUM(goals) AS AwayGoals FROM ds1_players GROUP BY match_id, club
) awayInfo ON m.match_id = awayInfo.match_id AND m.away = awayInfo.club
WHERE NOT EXISTS (
    SELECT 1 FROM Match m2 WHERE m2.MatchId = m.match_id);



-------- Person --------- (David)

INSERT INTO Person (Name, Surname, BirthDate, Gender, IdCity)
SELECT DISTINCT
    SUBSTR(dsp.name, 1, INSTR(dsp.name, ' ') - 1) AS Name, 
    SUBSTR(dsp.name, INSTR(dsp.name, ' ') + 1) AS Surname,    
    dsp.BirthDate,
    dsm.gender,
    (SELECT IdCity FROM City c
        WHERE   
        SUBSTR(dsp.City, 1, INSTR(dsp.City, ',') - 1) = c.CityName
        AND SUBSTR(dsp.City, INSTR(dsp.City, ',') + 2) = c.CountryName
        AND INSTR(dsp.City, ',') > 0
    ) AS IdCity
FROM ds1_players dsp
JOIN ds1_match dsm ON dsp.match_id = dsm.match_id
WHERE NOT EXISTS (
    SELECT 1
    FROM Person pp
    WHERE pp.Name = SUBSTR(dsp.name, 1, INSTR(dsp.name, ' ') - 1)
    AND pp.Surname = SUBSTR(dsp.name, INSTR(dsp.name, ' ') + 1)
    AND ((pp.BirthDate IS NULL AND dsp.BirthDate IS NULL) OR pp.BirthDate = dsp.BirthDate)
    AND pp.Gender = dsm.gender
);



INSERT INTO Person (Name, Surname, BirthDate, Gender, IdCity)
SELECT DISTINCT
    SUBSTR(dsm.home_manager, 1, INSTR(dsm.home_manager, ' ') - 1) AS Name, 
    SUBSTR(dsm.home_manager, INSTR(dsm.home_manager, ' ') + 1) AS Surname,     
    dsm.home_date, dsm.home_gender,
    (SELECT IdCity FROM City c
        WHERE SUBSTR(dsm.home_manager_city, 1, INSTR(dsm.home_manager_city, ',') - 1) = c.CityName
        AND SUBSTR(dsm.home_manager_city, INSTR(dsm.home_manager_city, ',') + 2) = c.CountryName
        AND INSTR(dsm.home_manager_city, ',') > 0
    ) AS IdCity
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1
    FROM Person pp
    WHERE pp.Name = SUBSTR(dsm.home_manager, 1, INSTR(dsm.home_manager, ' ') - 1)
    AND pp.Surname = SUBSTR(dsm.home_manager, INSTR(dsm.home_manager, ' ') + 1)
    AND pp.BirthDate = dsm.home_date
    AND pp.Gender = dsm.home_gender
);



INSERT INTO Person (Name, Surname, BirthDate, Gender, IdCity)
SELECT DISTINCT
    SUBSTR(dsm.away_manager, 1, INSTR(dsm.away_manager, ' ') - 1) AS Name, 
    SUBSTR(dsm.away_manager, INSTR(dsm.away_manager, ' ') + 1) AS Surname,     
    dsm.away_date, dsm.away_gender,
    (SELECT IdCity FROM City c
        WHERE SUBSTR(dsm.away_manager_city, 1, INSTR(dsm.away_manager_city, ',') - 1) = c.CityName
        AND SUBSTR(dsm.away_manager_city, INSTR(dsm.away_manager_city, ',') + 2) = c.CountryName
        AND INSTR(dsm.away_manager_city, ',') > 0
    ) AS IdCity
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1
    FROM Person pp
    WHERE pp.Name = SUBSTR(dsm.away_manager, 1, INSTR(dsm.away_manager, ' ') - 1) 
    AND pp.Surname = SUBSTR(dsm.away_manager, INSTR(dsm.away_manager, ' ') + 1)
    AND pp.BirthDate = dsm.away_date
    AND pp.Gender = dsm.away_gender
);



INSERT INTO Person (Name, Surname)
SELECT 
    CASE 
        WHEN INSTR(full_name, ' ') > 0 THEN SUBSTR(full_name, 1, INSTR(full_name, ' ') - 1) 
        ELSE full_name 
    END AS Name,
    CASE 
        WHEN INSTR(full_name, ' ') > 0 THEN SUBSTR(full_name, INSTR(full_name, ' ') + 1) 
        ELSE NULL 
    END AS Surname
FROM (
    SELECT DISTINCT referee AS full_name FROM ds1_match
    UNION
    SELECT DISTINCT ar1 AS full_name FROM ds1_match
    UNION
    SELECT DISTINCT ar2 AS full_name FROM ds1_match
    UNION
    SELECT DISTINCT fourth AS full_name FROM ds1_match
    UNION
    SELECT DISTINCT var AS full_name FROM ds1_match
) t
WHERE NOT EXISTS (
    SELECT 1 FROM Person p
    WHERE 
    (p.Name =   CASE 
                    WHEN INSTR(t.full_name, ' ') > 0 THEN SUBSTR(t.full_name, 1, INSTR(t.full_name, ' ') - 1) 
                    ELSE t.full_name 
                END
    AND (p.Surname = CASE 
                        WHEN INSTR(t.full_name, ' ') > 0 THEN SUBSTR(t.full_name, INSTR(t.full_name, ' ') + 1) 
                        ELSE NULL 
                    END
        OR (p.Surname IS NULL AND INSTR(t.full_name, ' ') = 0)))
    OR (t.full_name IS NULL)
);


---------- Person (Communicator)--------- (Marina)

INSERT INTO Person (Name, Surname, BirthDate, Gender)
SELECT DISTINCT FirstName, LastName, BirthDate, Gender
FROM ds3_radios dsr
WHERE NOT EXISTS (
    SELECT 1
    FROM Person p
    WHERE p.Name = dsr.FirstName
    AND p.Surname = dsr.LastName
    AND p.BirthDate = dsr.BirthDate
    AND p.Gender = dsr.Gender
);


INSERT INTO Person (Name, Surname, BirthDate, Gender)
SELECT DISTINCT FirstName, LastName, BirthDate, Gender
FROM ds3_tvs dst
WHERE NOT EXISTS (
    SELECT 1
    FROM Person p
    WHERE p.Name = dst.FirstName
    AND p.Surname = dst.LastName
    AND p.BirthDate = dst.BirthDate
    AND p.Gender = dst.Gender
);


--------- Referee --------- (David)

INSERT INTO Referee (IdReferee)
SELECT p.IdPerson AS IdReferee
FROM (
    SELECT DISTINCT
        SUBSTR(referee, 1, INSTR(referee, ' ') - 1) AS Name, 
        SUBSTR(referee, INSTR(referee, ' ') + 1) AS Surname   
    FROM ds1_match
    UNION
    SELECT DISTINCT
        SUBSTR(ar1, 1, INSTR(ar1, ' ') - 1) AS Name, 
        SUBSTR(ar1, INSTR(ar1, ' ') + 1) AS Surname   
    FROM ds1_match
    UNION
    SELECT DISTINCT
        SUBSTR(ar2, 1, INSTR(ar2, ' ') - 1) AS Name, 
        SUBSTR(ar2, INSTR(ar2, ' ') + 1) AS Surname   
    FROM ds1_match
    UNION
    SELECT DISTINCT
        SUBSTR(fourth, 1, INSTR(fourth, ' ') - 1) AS Name, 
        SUBSTR(fourth, INSTR(fourth, ' ') + 1) AS Surname   
    FROM ds1_match
    UNION
    SELECT DISTINCT
        SUBSTR(var, 1, INSTR(var, ' ') - 1) AS Name, 
        SUBSTR(var, INSTR(var, ' ') + 1) AS Surname   
    FROM ds1_match
) names
INNER JOIN Person p ON names.Name = p.Name AND names.Surname = p.Surname
WHERE NOT EXISTS (
    SELECT 1 FROM Referee r WHERE r.IdReferee = p.IdPerson);


--------- Manager --------- (David)

INSERT INTO Manager (IdManager, Tactics, Style)
SELECT DISTINCT 
    (SELECT IdPerson p
     FROM Person 
     WHERE SUBSTR(dsm.home_manager, 1, INSTR(dsm.home_manager, ' ') - 1) = Name
       AND SUBSTR(dsm.home_manager, INSTR(dsm.home_manager, ' ') + 1) = Surname
       AND dsm.home_date = BirthDate
       ANd dsm.home_gender = Gender
    ) AS IdManager,
    dsm.home_tactics AS Tactics,
    dsm.home_style AS Style
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1
    FROM Manager m
    WHERE m.IdManager = (SELECT IdPerson p FROM Person 
                    WHERE SUBSTR(dsm.home_manager, 1, INSTR(dsm.home_manager, ' ') - 1) = Name
                    AND SUBSTR(dsm.home_manager, INSTR(dsm.home_manager, ' ') + 1) = Surname
                    AND dsm.home_date = BirthDate
                    ANd dsm.home_gender = Gender)
    AND m.Tactics = dsm.home_tactics
    AND m.Style = dsm.home_style
);


INSERT INTO Manager (IdManager, Tactics, Style)
SELECT DISTINCT 
    (SELECT IdPerson p
     FROM Person 
     WHERE SUBSTR(dsm.away_manager, 1, INSTR(dsm.away_manager, ' ') - 1) = Name
       AND SUBSTR(dsm.away_manager, INSTR(dsm.away_manager, ' ') + 1) = Surname
       AND dsm.away_date = BirthDate
       ANd dsm.away_gender = Gender
    ) AS IdManager,
    dsm.away_tactics AS Tactics,
    dsm.away_style AS Style
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1
    FROM Manager m
    WHERE m.IdManager = (SELECT IdPerson p FROM Person 
                    WHERE SUBSTR(dsm.away_manager, 1, INSTR(dsm.away_manager, ' ') - 1) = Name
                    AND SUBSTR(dsm.away_manager, INSTR(dsm.away_manager, ' ') + 1) = Surname
                    AND dsm.away_date = BirthDate
                    ANd dsm.away_gender = Gender)
    AND m.Tactics = dsm.away_tactics
    AND m.Style = dsm.away_style
);


--------- Player --------- (Mada)  Agafem la primera posició com a la preferida

INSERT INTO Player (IdPlayer, Height, Weight, Footed, PreferredPosition)
SELECT DISTINCT p.IdPerson AS IdPlayer, dsp.Height, dsp.Weight, dsp.Footed, 
    (SELECT position FROM ds1_players dsp2 WHERE dsp.name = dsp2.name AND dsp.BirthDate = dsp2.BirthDate
    ORDER BY position FETCH FIRST 1 ROW ONLY) AS PreferredPosition
FROM ds1_players dsp
JOIN Person p ON SUBSTR(dsp.name, 1, INSTR(dsp.name, ' ') - 1) = p.Name 
              AND SUBSTR(dsp.name, INSTR(dsp.name, ' ') + 1) = p.Surname
              AND dsp.BirthDate = p.BirthDate
WHERE NOT EXISTS (
    SELECT 1 
    FROM Player pp
    WHERE pp.IdPlayer = p.IdPerson
);


--------- ManagerClub --------- (Mada)

INSERT INTO ManagerClub (ClubName, IdManager, StartDate, EndDate)
SELECT DISTINCT ds1.home AS ClubName, p.IdPerson AS IdManager,
    (SELECT MatchDate FROM (SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.home = ds1.home 
                            UNION SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.away = ds1.home) 
    ORDER BY MatchDate ASC FETCH FIRST 1 ROW ONLY) AS StartDate,

    (SELECT MatchDate FROM (SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.home = ds1.home  
                            UNION SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.away = ds1.home) 
    ORDER BY MatchDate DESC FETCH FIRST 1 ROW ONLY) AS EndDate
FROM ds1_match ds1
JOIN Person p ON p.Name = SUBSTR(ds1.home_manager, 1, INSTR(ds1.home_manager, ' ') - 1)
              AND p.Surname = SUBSTR(ds1.home_manager, INSTR(ds1.home_manager, ' ') + 1)
              AND p.BirthDate = ds1.home_date
              AND p.Gender = ds1.home_gender
WHERE NOT EXISTS (
    SELECT 1
    FROM ManagerClub mc
    WHERE mc.ClubName = ds1.home
    AND mc.IdManager = p.IdPerson
);


INSERT INTO ManagerClub (ClubName, IdManager, StartDate, EndDate)
SELECT DISTINCT ds1.away AS ClubName, p.IdPerson AS IdManager,
    (SELECT MatchDate FROM (SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.home = ds1.away 
                            UNION SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.away = ds1.away) 
    ORDER BY MatchDate ASC FETCH FIRST 1 ROW ONLY) AS StartDate,

    (SELECT MatchDate FROM (SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.home = ds1.away  
                            UNION SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.away = ds1.away) 
    ORDER BY MatchDate DESC FETCH FIRST 1 ROW ONLY) AS EndDate
FROM ds1_match ds1
JOIN Person p ON p.Name = SUBSTR(ds1.away_manager, 1, INSTR(ds1.away_manager, ' ') - 1)
              AND p.Surname = SUBSTR(ds1.away_manager, INSTR(ds1.away_manager, ' ') + 1)
              AND p.BirthDate = ds1.away_date
              AND p.Gender = ds1.away_gender
WHERE NOT EXISTS (
    SELECT 1
    FROM ManagerClub mc
    WHERE mc.ClubName = ds1.away
    AND mc.IdManager = p.IdPerson
);


--------- RefereeMatch --------- (David) 

INSERT INTO RefereeMatch (MatchId, IdReferee, Role, CertRefereeCertification)
SELECT DISTINCT
    m.MatchId AS MatchId, 
    p.IdPerson AS IdReferee, 
    'referee' AS Role, 
    referee_cert AS CertRefereeCertification
FROM ds1_match
JOIN Person p ON p.Name = SUBSTR(referee, 1, INSTR(referee, ' ') - 1)
             AND p.Surname = SUBSTR(referee, INSTR(referee, ' ') + 1)
JOIN  Match m ON match_id = m.MatchId
WHERE NOT EXISTS 
    (SELECT 1 FROM RefereeMatch rm
    WHERE rm.MatchId = m.MatchId
    AND rm.IdReferee = p.IdPerson);



INSERT INTO RefereeMatch (MatchId, IdReferee, Role, CertRefereeCertification)
SELECT DISTINCT
    m.MatchId AS MatchId, 
    p.IdPerson AS IdReferee, 
    'ar1' AS Role, 
    ar1_cert AS CertRefereeCertification
FROM ds1_match
JOIN Person p ON p.Name = SUBSTR(ar1, 1, INSTR(ar1, ' ') - 1)
             AND p.Surname = SUBSTR(ar1, INSTR(ar1, ' ') + 1)
JOIN Match m ON match_id = m.MatchId
WHERE NOT EXISTS 
    (SELECT 1 FROM RefereeMatch rm
    WHERE rm.MatchId = m.MatchId
    AND rm.IdReferee = p.IdPerson);



INSERT INTO RefereeMatch (MatchId, IdReferee, Role, CertRefereeCertification)
SELECT DISTINCT
    m.MatchId AS MatchId, 
    p.IdPerson AS IdReferee, 
    'ar2' AS Role, 
    ar2_cert AS CertRefereeCertification
FROM ds1_match
JOIN Person p ON p.Name = SUBSTR(ar2, 1, INSTR(ar2, ' ') - 1)
             AND p.Surname = SUBSTR(ar2, INSTR(ar2, ' ') + 1)
JOIN Match m ON match_id = m.MatchId
WHERE NOT EXISTS 
    (SELECT 1 FROM RefereeMatch rm
    WHERE rm.MatchId = m.MatchId
    AND rm.IdReferee = p.IdPerson);



INSERT INTO RefereeMatch (MatchId, IdReferee, Role, CertRefereeCertification)
SELECT DISTINCT
    m.MatchId AS MatchId, 
    p.IdPerson AS IdReferee, 
    'fourth' AS Role, 
    fourth_cert AS CertRefereeCertification
FROM ds1_match
JOIN Person p ON p.Name = SUBSTR(fourth, 1, INSTR(fourth, ' ') - 1)
             AND p.Surname = SUBSTR(fourth, INSTR(fourth, ' ') + 1)
JOIN Match m ON match_id = m.MatchId
WHERE NOT EXISTS 
    (SELECT 1 FROM RefereeMatch rm
    WHERE rm.MatchId = m.MatchId
    AND rm.IdReferee = p.IdPerson);



INSERT INTO RefereeMatch (MatchId, IdReferee, Role, CertRefereeCertification)
SELECT DISTINCT
    m.MatchId AS MatchId, 
    p.IdPerson AS IdReferee, 
    'var' AS Role, 
    var_cert AS CertRefereeCertification
FROM ds1_match
JOIN Person p ON p.Name = SUBSTR(var, 1, INSTR(var, ' ') - 1)
             AND p.Surname = SUBSTR(var, INSTR(var, ' ') + 1)
JOIN Match m ON match_id = m.MatchId
WHERE NOT EXISTS 
    (SELECT 1 FROM RefereeMatch rm
    WHERE rm.MatchId = m.MatchId
    AND rm.IdReferee = p.IdPerson);    


--------- PlayerClub  --------- (Mada)

INSERT INTO PlayerClub(ClubName, IdPlayer, StartDate, EndDate)
SELECT DISTINCT
    dsp.club AS ClubName, 
    p.IdPerson AS IdPlayer,

    (SELECT MatchDate FROM (SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.home = dsp.club 
                            UNION SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.away = dsp.club) 
    ORDER BY MatchDate ASC FETCH FIRST 1 ROW ONLY) AS StartDate,

    (SELECT MatchDate FROM (SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.home = dsp.club 
                            UNION SELECT match_date AS MatchDate FROM ds1_match dsm2 WHERE dsm2.away = dsp.club) 
    ORDER BY MatchDate DESC FETCH FIRST 1 ROW ONLY) AS EndDate

FROM ds1_players dsp
JOIN ds1_match dsm ON dsm.match_id = dsp.match_id
JOIN Person p ON p.Name = SUBSTR(dsp.name, 1, INSTR(dsp.name, ' ') - 1)
             AND p.Surname = SUBSTR(dsp.name, INSTR(dsp.name, ' ') + 1)
             AND p.BirthDate = dsp.BirthDate
             AND p.Gender = dsm.gender
WHERE NOT EXISTS (
    SELECT 1
    FROM PlayerClub pc
    WHERE pc.ClubName = dsp.club
    AND pc.IdPlayer = p.IdPerson
);


--------- Affiliates --------- (Marina)

INSERT INTO Affiliates (ClubName1, ClubName2)
SELECT DISTINCT c1.ClubName AS ClubName1, c2.ClubName AS ClubName2
FROM Club c1 JOIN Club c2 ON c1.ClubName <> c2.ClubName AND 
    c1.ClubName = SUBSTR(c2.ClubName, 1, INSTR(c2.ClubName, ' ', -1) - 1) AND
    SUBSTR(c2.ClubName, INSTR(c2.ClubName, ' ', -1) + 1) like 'B'
WHERE INSTR(c2.ClubName, ' ', -1) > 0 
AND NOT EXISTS (
    SELECT 1 FROM Affiliates a
    WHERE a.ClubName1 = c1.ClubName AND a.ClubName2 = c2.ClubName
);


--------- CompetitionClub --------- (Marina) 

INSERT INTO CompetitionClub (ClubName, IdCompetition, TotalPoints)
SELECT DISTINCT dsm.home AS ClubName, 
    (SELECT IdCompetition FROM Competition c
    WHERE c.League = dsm.league
    AND c.Season = dsm.season) AS IdCompetition, 
    (
        SELECT 
            SUM(CASE WHEN m.HomePoints IS NULL THEN 0 ELSE m.HomePoints END) 
            + SUM(CASE WHEN m.AwayPoints IS NULL THEN 0 ELSE m.AwayPoints END)
        FROM Match m 
        WHERE (m.HomeClubName = dsm.home OR m.AwayClubName = dsm.home)
          AND m.IdCompetition = (SELECT IdCompetition FROM Competition c
                                  WHERE c.League = dsm.league AND c.Season = dsm.season)
    ) AS TotalPoints
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1 FROM CompetitionClub cc 
    WHERE cc.ClubName = dsm.home 
    AND cc.IdCompetition = (SELECT IdCompetition FROM Competition c 
                            WHERE c.League = dsm.league AND c.Season = dsm.season)
);



INSERT INTO CompetitionClub (ClubName, IdCompetition, TotalPoints)
SELECT DISTINCT dsm.away AS ClubName, 
    (SELECT IdCompetition FROM Competition c
    WHERE c.League = dsm.league
    AND c.Season = dsm.season) AS IdCompetition, 
    (
        SELECT 
            SUM(CASE WHEN m.HomePoints IS NULL THEN 0 ELSE m.HomePoints END) 
            + SUM(CASE WHEN m.AwayPoints IS NULL THEN 0 ELSE m.AwayPoints END)
        FROM Match m 
        WHERE (m.HomeClubName = dsm.away OR m.AwayClubName = dsm.away)
          AND m.IdCompetition = (SELECT IdCompetition FROM Competition c
                                  WHERE c.League = dsm.league AND c.Season = dsm.season)
    ) AS TotalPoints
FROM ds1_match dsm
WHERE NOT EXISTS (
    SELECT 1 FROM CompetitionClub cc 
    WHERE cc.ClubName = dsm.away 
    AND cc.IdCompetition = (SELECT IdCompetition FROM Competition c 
                            WHERE c.League = dsm.league AND c.Season = dsm.season)
);


------------ PlayerMatch ----------- (Mada) glvcyficvotugkjvbvghftrxddcfvjhmnkj jvgb 

INSERT INTO PlayerMatch (IdMatch, IdPlayer, Goals, Shots, ShotsOnTarget, Assists, YellowCards, RedCards, Position)
SELECT DISTINCT
    dsp.match_id,
    (SELECT IdPerson FROM Person p2
        WHERE SUBSTR(dsp.name, 1, INSTR(dsp.name, ' ') - 1) = p2.Name 
        AND SUBSTR(dsp.name, INSTR(dsp.name, ' ') + 1) = p2.Surname
        AND dsp.BirthDate = p2.BirthDate
    ) AS IdPlayer, dsp.goals, dsp.shots, dsp.shots_on_target, dsp.assists, 
    dsp.yellow_cards, dsp.red_cards, dsp.position
    FROM ds1_players dsp
WHERE (SELECT IdPerson FROM Person p2
        WHERE SUBSTR(dsp.name, 1, INSTR(dsp.name, ' ') - 1) = p2.Name 
        AND SUBSTR(dsp.name, INSTR(dsp.name, ' ') + 1) = p2.Surname
        AND dsp.BirthDate = p2.BirthDate
) IS NOT NULL 
AND NOT EXISTS (
    SELECT 1 FROM PlayerMatch pm
    WHERE pm.IdMatch = dsp.match_id
    AND pm.IdPlayer = (SELECT IdPerson FROM Person p2
        WHERE SUBSTR(dsp.name, 1, INSTR(dsp.name, ' ') - 1) = p2.Name 
        AND SUBSTR(dsp.name, INSTR(dsp.name, ' ') + 1) = p2.Surname
        AND dsp.BirthDate = p2.BirthDate
    ) AND pm.Goals = dsp.goals AND pm.Shots = dsp.shots AND pm.ShotsOnTarget = dsp.shots_on_target
    AND pm.Assists = dsp.assists AND pm.YellowCards = dsp.yellow_cards AND pm.RedCards = dsp.red_cards
    AND pm.Position = dsp.position
);


--------- User_db --------- (Marina)

INSERT INTO User_db (Nickname, CreationDate, Verified, IdCity)
SELECT DISTINCT dsp.nickname, dsp.creation_date, dsp.verified,
	(SELECT IdCity FROM City WHERE     
        SUBSTR(dsp.localization, 1, INSTR(dsp.localization, ',') - 1) = CityName
        AND SUBSTR(dsp.localization, INSTR(dsp.localization, ',') + 2) = CountryName
    ) AS IdCity
FROM ds3_posts dsp
WHERE NOT EXISTS (
    SELECT 1 FROM User_db u
    WHERE u.Nickname = dsp.nickname AND u.CreationDate = dsp.creation_date 
    AND u.Verified = dsp.verified 
    AND u.IdCity = (SELECT IdCity FROM City WHERE     
                    SUBSTR(dsp.localization, 1, INSTR(dsp.localization, ',') - 1) = CityName
                    AND SUBSTR(dsp.localization, INSTR(dsp.localization, ',') + 2) = CountryName)
);

INSERT INTO User_db (Nickname)
SELECT DISTINCT Username_lssl
FROM ds3_radios
WHERE Username_lssl NOT IN (SELECT Nickname FROM User_db)
UNION
SELECT DISTINCT Username_lssl
FROM ds3_tvs
WHERE Username_lssl NOT IN (SELECT Nickname FROM User_db);

INSERT INTO User_db (Nickname)
SELECT DISTINCT programme_lssl
FROM ds3_radios
WHERE programme_lssl NOT IN (SELECT Nickname FROM User_db)
UNION
SELECT DISTINCT programme_lssl
FROM ds3_tvs
WHERE programme_lssl NOT IN (SELECT Nickname FROM User_db);


--------- Post --------- (Marina)

INSERT INTO Post (PostId, PostText, PostDate, Likes, Reposts, Nickname, ReplyTo)
SELECT DISTINCT dsp.post_id, dsp.post, dsp.post_date, dsp.likes, dsp.reposts, dsp.nickname, dsp.reply_to
FROM ds3_posts dsp
WHERE dsp.post_id IS NOT NULL AND NOT EXISTS (
    SELECT 1 FROM Post p WHERE p.PostId = dsp.post_id);


INSERT INTO Post (PostId)
SELECT DISTINCT dsp.post
FROM ds4_placement dsp
WHERE dsp.post IS NOT NULL AND NOT EXISTS (
    SELECT 1 FROM Post p WHERE p.PostId = dsp.post);


--------- Hashtag --------- (Marina)

INSERT INTO Hashtag (Hashtag, HashtagDesc, TrendingStatus)
SELECT DISTINCT dsp.hashtag, dsp.hashtag_desc, dsp.trending_status
FROM ds3_posts dsp
WHERE NOT EXISTS (
    SELECT 1 FROM Hashtag h WHERE h.Hashtag = dsp.hashtag
    AND h.HashtagDesc = dsp.hashtag_desc AND h.TrendingStatus = dsp.trending_status);


--------- PostHashtag --------- (Marina)

INSERT INTO PostHashtag (Hashtag, PostId)
SELECT DISTINCT dsp.hashtag, dsp.post_id
FROM ds3_posts dsp
WHERE NOT EXISTS (
    SELECT 1 FROM PostHashtag ph
    WHERE ph.Hashtag = dsp.hashtag AND ph.PostId = dsp.post_id);


--------- Image --------- (Marina)

INSERT INTO Image (ImageTitle, Path, Mime) 
SELECT DISTINCT dsp.image, dsp.path, dsp.mime
FROM ds3_posts dsp
WHERE NOT EXISTS (
    SELECT 1 FROM Image i WHERE i.ImageTitle = dsp.image
    AND i.Path = dsp.path AND i.Mime = dsp.mime);


---------- PostImage -------- (Marina)

INSERT INTO PostImage (PostId, ImageTitle)
SELECT DISTINCT dsp.post_id, dsp.image
FROM ds3_posts dsp
WHERE NOT EXISTS (
    SELECT 1 FROM PostImage pi
    WHERE pi.PostId = dsp.post_id AND pi.ImageTitle = dsp.image); 


--------- Communicator --------- (Marina)

INSERT INTO Communicator (IdCommunicator, Specialisation, Nickname)
SELECT DISTINCT 
    (SELECT IdPerson FROM Person p WHERE dsr.FirstName = p.Name 
    AND dsr.LastName = p.Surname AND dsr.BirthDate = p.BirthDate 
    AND dsr.Gender = p.Gender) AS IdCommunicator, 
    dsr.Specialization AS Specialisation, dsr.Username_lssl AS Nickname
FROM ds3_radios dsr
WHERE NOT EXISTS (
    SELECT 1 FROM Communicator com
    WHERE com.IdCommunicator = (SELECT IdPerson FROM Person p WHERE dsr.FirstName = p.Name 
                                AND dsr.LastName = p.Surname AND dsr.BirthDate = p.BirthDate 
                                AND dsr.Gender = p.Gender)
    AND com.Specialisation = dsr.Specialization AND com.Nickname = dsr.Username_lssl);


INSERT INTO Communicator (IdCommunicator, Specialisation, Nickname)
SELECT DISTINCT 
    (SELECT IdPerson FROM Person p WHERE dst.FirstName = p.Name 
    AND dst.LastName = p.Surname AND dst.BirthDate = p.BirthDate 
    AND dst.Gender = p.Gender) AS IdCommunicator, 
    dst.Specialization AS Specialisation, dst.Username_lssl AS Nickname
FROM ds3_tvs dst
WHERE NOT EXISTS (
    SELECT 1 FROM Communicator com
    WHERE com.IdCommunicator = (SELECT IdPerson FROM Person p WHERE dst.FirstName = p.Name 
                                AND dst.LastName = p.Surname AND dst.BirthDate = p.BirthDate 
                                AND dst.Gender = p.Gender)
    AND com.Specialisation = dst.Specialization AND com.Nickname = dst.Username_lssl);


--------- MediaGroup --------- (Marina)

INSERT INTO MediaGroup (NameOfMediaGroup, DescriptionOfMediaGroup, HeadquartersOfTheMediaGroup) 
SELECT DISTINCT dsr.name_of_media_group, dsr.description_of_media_group, dsr.headquarters_of_the_media_group
FROM ds3_radios dsr
WHERE NOT EXISTS (
    SELECT 1 FROM MediaGroup mg WHERE mg.NameOfMediaGroup = dsr.name_of_media_group
    AND mg.DescriptionOfMediaGroup = dsr.description_of_media_group 
    AND mg.HeadquartersOfTheMediaGroup = dsr.headquarters_of_the_media_group);


INSERT INTO MediaGroup (NameOfMediaGroup, DescriptionOfMediaGroup, HeadquartersOfTheMediaGroup) 
SELECT DISTINCT dst.name_of_media_group, dst.description_of_media_group, dst.headquarters_of_the_media_group
FROM ds3_tvs dst
WHERE NOT EXISTS (
    SELECT 1 FROM MediaGroup mg WHERE mg.NameOfMediaGroup = dst.name_of_media_group
    AND mg.DescriptionOfMediaGroup = dst.description_of_media_group 
    AND mg.HeadquartersOfTheMediaGroup = dst.headquarters_of_the_media_group);


--------- RadioStation --------- (Marina)

INSERT INTO RadioStation (NameOfTheRadioStation, DescriptionOfTheRadioStation, NameOfMediaGroup) 
SELECT DISTINCT dsr.name_of_the_radio_station, dsr.description_of_the_radio_station, dsr.name_of_media_group
FROM ds3_radios dsr
WHERE NOT EXISTS (
    SELECT 1 FROM RadioStation rs WHERE rs.NameOfTheRadioStation = dsr.name_of_the_radio_station
    AND rs.DescriptionOfTheRadioStation = dsr.description_of_the_radio_station 
    AND rs.NameOfMediaGroup = dsr.name_of_media_group);


--------- TelevisionChannel -------- (Marina)

INSERT INTO TelevisionChannel (TitleOfTheTvChannel, VideoQualityOfTheTvChannel, NameOfMediaGroup) 
SELECT DISTINCT dst.title_of_the_tv_channel, dst.video_quality_of_the_tv_channel, dst.name_of_media_group
FROM ds3_tvs dst
WHERE NOT EXISTS (
    SELECT 1 FROM TelevisionChannel tc WHERE tc.TitleOfTheTvChannel = dst.title_of_the_tv_channel
    AND tc.VideoQualityOfTheTvChannel = dst.video_quality_of_the_tv_channel 
    AND tc.NameOfMediaGroup = dst.name_of_media_group);


--------- Programme --------- (Marina)

INSERT INTO Programme (ProgrammeName, Description, Schedule) 
SELECT DISTINCT dsr.programme, dsr.description, dsr.schedule
FROM ds3_radios dsr
WHERE NOT EXISTS (
    SELECT 1 FROM Programme prog WHERE prog.ProgrammeName = dsr.programme
    AND prog.Description = dsr.description AND prog.Schedule = dsr.schedule);

INSERT INTO Programme (ProgrammeName, Description, Schedule)
SELECT DISTINCT dst.programme, dst.description, dst.schedule
FROM ds3_tvs dst
WHERE NOT EXISTS (
    SELECT 1 FROM Programme prog WHERE prog.ProgrammeName = dst.programme
    AND prog.Description = dst.description AND prog.Schedule = dst.schedule);


--------- TelevisionProgramme --------- (Marina)

INSERT INTO TelevisionProgramme (TelevisionProgrammeName, ProductionCompany, TitleOfTheTvChannel, Nickname)
SELECT DISTINCT dst.programme, dst.production_company, dst.title_of_the_tv_channel, dst.programme_lssl
FROM ds3_tvs dst
WHERE NOT EXISTS (
    SELECT 1 FROM TelevisionProgramme tp WHERE tp.TelevisionProgrammeName = dst.programme
    AND tp.ProductionCompany = dst.production_company AND tp.TitleOfTheTvChannel = dst.title_of_the_tv_channel
    AND tp.Nickname = dst.programme_lssl);


--------- RadioProgramme ----------- (Marina)

INSERT INTO RadioProgramme (RadioProgrammeName, Podcast, NameOfTheRadioStation, Nickname)
SELECT DISTINCT dsr.programme, dsr.podcast, dsr.name_of_the_radio_station, dsr.programme_lssl
FROM ds3_radios dsr
WHERE NOT EXISTS (
    SELECT 1 FROM RadioProgramme rp WHERE rp.RadioProgrammeName = dsr.programme AND rp.Podcast = dsr.podcast
    AND rp.NameOfTheRadioStation = dsr.name_of_the_radio_station AND rp.Nickname = dsr.programme_lssl);


---------- ProgrammeCommunicator ----------- (Marina)

INSERT INTO ProgrammeCommunicator (IdCommunicator, ProgrammeName, FirstRole, SecondRole)
SELECT DISTINCT p.IdPerson AS IdCommunicator, dsr.programme AS ProgrammeName,
                MIN(dsr.Role) AS FirstRole, MAX(dsr2.Role) AS SecondRole 
FROM ds3_radios dsr
JOIN Person p ON p.Name = dsr.FirstName AND p.Surname = dsr.LastName 
                AND p.BirthDate = dsr.BirthDate AND p.Gender = dsr.Gender
JOIN ds3_radios dsr2 ON dsr.programme = dsr2.programme AND dsr.FirstName = dsr2.FirstName 
                        AND dsr.LastName = dsr2.LastName AND dsr.BirthDate = dsr2.BirthDate 
                        AND dsr.Role != dsr2.Role
WHERE dsr2.Role IS NOT NULL
AND NOT EXISTS (
    SELECT 1
    FROM ProgrammeCommunicator pc
    WHERE pc.IdCommunicator = p.IdPerson
    AND pc.ProgrammeName = dsr.programme)
GROUP BY p.IdPerson, dsr.programme;



INSERT INTO ProgrammeCommunicator (IdCommunicator, ProgrammeName, FirstRole, SecondRole)
SELECT DISTINCT p.IdPerson AS IdCommunicator, dst.programme AS ProgrammeName,
                MIN(dst.Role) AS FirstRole, MAX(dst2.Role) AS SecondRole 
FROM ds3_tvs dst
JOIN Person p ON p.Name = dst.FirstName AND p.Surname = dst.LastName 
                AND p.BirthDate = dst.BirthDate AND p.Gender = dst.Gender
JOIN ds3_tvs dst2 ON dst.programme = dst2.programme AND dst.FirstName = dst2.FirstName 
                        AND dst.LastName = dst2.LastName AND dst.BirthDate = dst2.BirthDate 
                        AND dst.Role != dst2.Role
WHERE dst2.Role IS NOT NULL
AND NOT EXISTS (
    SELECT 1
    FROM ProgrammeCommunicator pc
    WHERE pc.IdCommunicator = p.IdPerson
    AND pc.ProgrammeName = dst.programme)
GROUP BY p.IdPerson, dst.programme;


























------------ Publicitat Merxandatge
------------------------------------------------------------- 1 ---------------------------------------

--------- TypeProduct ---------**
INSERT INTO TypeProduct (TypeName, TypeDescription)
SELECT DISTINCT p.Type, p.Type_Description
FROM ds2_product_sales p
WHERE NOT EXISTS (
    SELECT 1
    FROM TypeProduct t
    WHERE t.TypeName = p.Type
);

--------- Activity ---------**
INSERT INTO Activity (NameActivity, ActivityDescription)
SELECT DISTINCT p.Activity, p.Activity_description
FROM ds2_product_sales p
WHERE NOT EXISTS (
    SELECT 1
    FROM Activity a
    WHERE a.NameActivity = p.Activity
);

--------- Product ---------
INSERT INTO Product (NameProduct, Cost, Official, Dimensions, SpecialFeature, TypeName, NameActivity, ClubName)
SELECT DISTINCT p.Name, p.Cost, p.Official, p.Dimensions, p.Special_feature, p.Type, p.Activity, p.Team
FROM ds2_product_sales p
WHERE NOT EXISTS (
    SELECT 1
    FROM Product c
    WHERE c.NameProduct = p.Name
);

--------- Accessory -------
INSERT INTO Accessory (NameAccessory, Features)
SELECT DISTINCT p.Name, p.Features
FROM ds2_product_sales p
WHERE p.Features IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM Accessory a
    WHERE a.NameAccessory = p.Name
);

--------- Clothes ---------
INSERT INTO Clothes (NameClothes, Season, Material)
SELECT DISTINCT p.Name, p.Season, p.Material
FROM ds2_product_sales p
WHERE p.Season IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM Clothes c
    WHERE c.NameClothes = p.Name
);

----------- Shoe ----------
INSERT INTO Shoe (NameShoe, Usage, Property, Closure)
SELECT DISTINCT p.Name, p.Usage, p.Property, p.Closure
FROM ds2_product_sales p
WHERE p.Closure IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM Shoe s
    WHERE s.NameShoe = p.Name
);

--------- Shop ---------
INSERT INTO Shop (Name, ShopDescription, ClubName)
SELECT DISTINCT Shop, Shop_description, p.Team
FROM ds2_product_sales p
WHERE NOT EXISTS (
    SELECT 1
    FROM Shop s
    WHERE s.Name = p.Shop AND s.ShopDescription = p.Shop_description AND s.ClubName = p.Team
);

--------- Stores ---------
INSERT INTO Stores(IdShop, NameProduct, Stock)
SELECT h.IdShop, p.Name, SUM(p.Stock) AS Stock
FROM ds2_product_sales p
         JOIN Shop h ON h.Name = p.Shop AND h.ShopDescription = p.Shop_description AND h.ClubName = p.Team
         LEFT JOIN Stores s ON s.IdShop = h.IdShop AND s.NameProduct = p.Name
WHERE s.IdShop IS NULL
GROUP BY h.IdShop, p.Name;

--------- CreditCard ---------
INSERT INTO CreditCard (CreditCardNum, CreditCardExpiry, CreditCardProvider)
SELECT  DISTINCT CreditCard_Num, CreditCard_Expiry, CreditCard_Provider
FROM ds2_product_sales p
WHERE CreditCard_Num IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM CreditCard c
    WHERE c.CreditCardNum = p.CreditCard_Num
);

-------- Purchase ---------
INSERT INTO Purchase (IdShop, PurchaseDate, NameProduct, Units, Discount, TotalCost, IdCard)
SELECT DISTINCT h.IdShop, p.Purchasedate, p.Name, p.Units, p.Discount, p.Total_cost, p.CreditCard_num
FROM ds2_product_sales p
         JOIN Shop h ON h.Name = p.Shop AND h.ShopDescription = p.Shop_description AND h.ClubName = p.Team
WHERE CreditCard_Num IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM Purchase s
    WHERE s.IdShop = h.IdShop AND s.Purchasedate = p.Purchasedate AND s.NameProduct = p.Name AND s.Units = p.Units AND s.Discount = p.Discount AND s.TotalCost = p.Total_cost AND s.IdCard = p.CreditCard_num
);


--------- Person (Shop keepers) ---------- (Pol)

INSERT INTO PERSON (Name, Surname, BirthDate, Gender)
SELECT dsp.FirstName, dsp.LastName, dsp.birthdate, dsp.Gender
FROM ds2_shop_keepers dsp
WHERE NOT EXISTS (
    SELECT 1
    FROM Person s
    WHERE s.Name = dsp.FirstName AND s.Surname = dsp.LastName AND s.BirthDate = dsp.birthdate AND s.Gender = dsp.Gender
);


--------- ShopKeeper --------- (Pol)

INSERT INTO ShopKeeper (VacationDays, IdShopKeeper)
SELECT DISTINCT dssk.vacation_days, p.IdPerson
FROM ds2_shop_keepers dssk
    JOIN Person p ON p.Name = dssk.FirstName AND p.Surname = dssk.LastName AND p.BirthDate = dssk.birthdate AND p.Gender = dssk.Gender
WHERE NOT EXISTS (
    SELECT 1
    FROM ShopKeeper sk
    WHERE p.IdPerson = sk.IdShopKeeper
);


--------- Manages --------- (Pol)
INSERT INTO Manages (IdShop, Role, Shift, IdShopKeeper)
SELECT DISTINCT s.IdShop, dssk.role, dssk.shift, p.IdPerson
FROM ds2_shop_keepers dssk
    JOIN Shop s ON s.Name = dssk.Shop
    JOIN Person p ON p.Name = dssk.FirstName AND p.Surname = dssk.LastName AND p.BirthDate = dssk.birthdate AND p.Gender = dssk.Gender
WHERE NOT EXISTS (
    SELECT 1
    FROM Manages m
    WHERE p.IdPerson = m.IdShopKeeper AND s.IdShop = m.IdShop
);



------------ Publicitat inserts
------------------------------------------------------------- 1 ---------------------------------------
-- Codi Client ----
-- Per nom de la ciutat i id-- !!! este es el bueno!!!!

INSERT INTO City (CityName, CountryName)
SELECT DISTINCT 
       SUBSTR(city, 1, INSTR(city, ',') - 1) AS CityName,
       SUBSTR(city, INSTR(city, ',') + 2) AS CountryName
FROM ds4_ads
WHERE city NOT IN (SELECT CityName || ', ' || CountryName FROM City);



INSERT INTO Client(Client_Name, Client_Budget, Id_City) 
SELECT ads.Client, ads.Client_budget, c.IdCity
FROM (
    SELECT DISTINCT client, client_budget, city
    FROM ds4_ads
) ads
JOIN City c ON ads.city LIKE '%' || c.CityName || '%'
WHERE NOT EXISTS(
      SELECT 1
      FROM Client c
      WHERE c.Client_Name LIKE '%' || ads.Client || '%'
      AND c.Client_Budget = ads.Client_budget
      AND c.Id_City = c.Id_City
);


      ------------------------------------------------------------- 2 ---------------------------------------

-- Codi Campaign sense Product --
INSERT INTO Campaign (Id_Campaign, Campaign_name, objective, budget, Start_Date, End_Date, Audience_Interest, Audience_Segment, client_name) 
SELECT code, campaign, objective, budget, Start_Date, End_Date, Audience_Interest, Audience_Segment, Client 
FROM (
    SELECT DISTINCT code, campaign, objective, budget, Start_Date, End_Date, Audience_Interest, Audience_Segment, Client
    FROM ds4_ads
    ORDER BY campaign ASC
) ads
WHERE NOT EXISTS (
    SELECT 1
    FROM Campaign c
    WHERE c.Id_Campaign LIKE '%' || ads.code || '%'
    AND c.Campaign_name = ads.campaign
    AND c.objective = ads.objective
    AND c.budget = ads.budget
    AND c.Start_Date = ads.Start_Date
    AND c.End_Date = ads.End_Date
    AND c.Audience_Interest = ads.Audience_Interest
    AND c.Audience_Segment = ads.Audience_Segment
    AND c.Client_NAME = ads.client
);

-- ProductCampaign
INSERT INTO ProductCampaign(Id_Campaign, NameProduct)
SELECT code, product
FROM ds4_ADS
WHERE code IS NOT NULL
AND NOT EXISTS(
      SELECT 1
      FROM ProductCampaign p
      WHERE p.Id_Campaign = code
      AND p.NameProduct = product
);

-- Categories
INSERT INTO Categories (Category_name, Description) 
SELECT categories, Description
FROM (
    SELECT Category1 AS categories, Category1_desc AS Description
    FROM ds4_ads
    WHERE Category1 IS NOT NULL
    UNION
    SELECT Category2, Category2_desc
    FROM ds4_ads
    WHERE Category2 IS NOT NULL
    UNION
    SELECT Category3, Category3_desc
    FROM ds4_ads
    WHERE Category3 IS NOT NULL
) sub
WHERE NOT EXISTS(
      SELECT 1
      FROM Categories c
      WHERE c.Category_Name = sub.categories
);

-- PlacementType
INSERT INTO PlacementType(Id_PlacementType, Type_description)
SELECT Placement_Type, Type_description
FROM (SELECT DISTINCT Placement_Type, Type_description
      FROM ds4_placement
      ORDER BY Placement_Type ASC)
WHERE NOT EXISTS(
      SELECT 1
      FROM PlacementType p
      WHERE p.Id_PlacementType = Placement_Type
      AND p.Type_description = Type_description
);

-- Subcategories
INSERT INTO Subcategories(Category1_name, Category2_name, Category3_name)
SELECT DISTINCT Category1, Category2, Category3
FROM ds4_ads
WHERE Category1 IS NOT NULL
AND Category2 IS NOT NULL
AND Category3 IS NOT NULL
AND NOT EXISTS(
      SELECT 1
      FROM Subcategories s
      WHERE s.Category1_name = ds4_ads.Category1
      AND s.Category2_name = ds4_ads.Category2
      AND s.Category3_name = ds4_ads.Category3
);

-- Placement
INSERT INTO placement(IdPlacement, ExclusiveType, IdPlacementType)
SELECT ID, exclusives, placement_type
FROM (SELECT DISTINCT id, exclusives, placement_type
      FROM ds4_placement
      ORDER BY id ASC)
WHERE NOT EXISTS(
      SELECT 1
      FROM placement s
      WHERE s.IdPlacement = ID
      AND s.ExclusiveType = exclusives
      AND s.IdPlacementType = placement_type
);




------------------------------------------------------------- 6 ---------------------------------------

--------- PlacementStadium ---------

INSERT INTO PlacementStadium(StadiumName, IdPlacement)
SELECT DISTINCT dsp.building, dsp.id
FROM ds4_placement dsp
JOIN Stadium st ON dsp.building = st.StadiumName
WHERE dsp.building IS NOT NULL 
AND EXISTS (SELECT 1 FROM Stadium WHERE StadiumName = dsp.building)
AND NOT EXISTS (
    SELECT 1 FROM PlacementStadium ps 
    WHERE ps.StadiumName = dsp.building
    AND ps.IdPlacement = dsp.id);


----PlacementShop------

INSERT INTO PlacementShop(IdShop, IdPlacement)
SELECT DISTINCT s.IdShop, dsp.id
FROM ds4_placement dsp
JOIN Shop s ON s.Name = dsp.building
WHERE dsp.building IS NOT NULL
AND EXISTS (SELECT 1 FROM Shop WHERE Name = dsp.building)
AND NOT EXISTS (
    SELECT 1 FROM PlacementShop ps 
    WHERE ps.IdShop = s.IdShop
    AND ps.IdPlacement = dsp.id);


------------------------------------------------------------- 7 ---------------------------------------

--PlacementProgramme-------
INSERT INTO ProgrammePlacement(IdPlacement, ProgrammeName)
SELECT DISTINCT id, programme
FROM ds4_placement p
WHERE programme IS NOT NULL
AND NOT EXISTS (
    SELECT 1
    FROM ProgrammePlacement s
    WHERE s.IdPlacement = p.id
    AND s.ProgrammeName = p.programme
);




------------------------------------------------------------- 8 ---------------------------------------
--PlacementPost-------

INSERT INTO PlacementPost(IdPlacement, PostId)
SELECT DISTINCT id, post
FROM ds4_placement p
WHERE post IS NOT NULL
AND NOT EXISTS (
    SELECT 1
    FROM PlacementPost s
    WHERE s.IdPlacement = p.id
    AND s.PostId = p.post
);



------------------------------------------------------------- 9 ---------------------------------------
--Codi de Ad--
INSERT INTO Ad (NumAd, Title, Description, Format, Status, AdDate, Id_Campaign) 
SELECT DISTINCT a.num, a.title, a.description, a.format, a.status, a.AdDate, a.CODE
FROM ds4_ads a
WHERE NOT EXISTS (
    SELECT 1
    FROM Ad s
    WHERE s.NumAd = a.num
    AND s.Title = a.title
    AND s.Description = a.description
    AND s.Format = a.format
    AND s.Status = a.status
    AND s.AdDate = a.AdDate
    AND s.Id_Campaign = a.CODE
);

-- AdPlacement
INSERT INTO adPlacement (NumAd, IdPlacement, Cost, PlacementDate)
SELECT DISTINCT p.Ads, p.id, p.cost, p.placementdate
FROM ds4_placement p
WHERE EXISTS (
    SELECT 1
    FROM Ad a
    WHERE a.NumAd = p.Ads
)
AND EXISTS (
    SELECT 1
    FROM Placement pl
    WHERE pl.IdPlacement = p.id
)
AND NOT EXISTS (
    SELECT 1
    FROM adPlacement ap
    WHERE ap.NumAd = p.Ads
    AND ap.IdPlacement = p.id
    AND ap.Cost = p.cost
    AND ap.PlacementDate = p.placementdate
);



-- CategoryAd
INSERT INTO CategoryAd (NumAd, Category_Name)
SELECT DISTINCT a.num, c.category_name
FROM ds4_ads a
JOIN (
    SELECT DISTINCT num, Category1 AS category_name
    FROM ds4_ads
    WHERE Category1 IS NOT NULL
    UNION
    SELECT DISTINCT num, Category2 AS category_name
    FROM ds4_ads
    WHERE Category2 IS NOT NULL
    UNION
    SELECT DISTINCT num, Category3 AS category_name
    FROM ds4_ads
    WHERE Category3 IS NOT NULL
) c ON a.num = c.num
WHERE NOT EXISTS (
    SELECT 1
    FROM CategoryAd ca
    WHERE ca.NumAd = a.num
    AND ca.Category_Name = c.category_name
);




