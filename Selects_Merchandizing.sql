----------------
-- #Query 1.1#
--

SELECT 
    cl.IdCity,
   	ci.CityName,
    cl.ClubName,
   	m.MatchId,
   	m.MatchDate,
    m.HomeGoals,
    m.AwayGoals
FROM City ci
JOIN Club cl ON ci.IdCity = cl.IdCity
JOIN Match m ON cl.ClubName = m.HomeClubName
WHERE ci.CityName = 'Girona' 
   	 AND m.HomeGoals > m.AwayGoals
ORDER BY  m.MatchDate;

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT 
    m.matchid, 
    homeclubcity.CityName AS homecity, 
    homeclub.ClubName AS homeclubname, 
     awayclubcity.CityName AS awaycity,
    awayclub.ClubName AS awayclubname, 
    m.homegoals, 
    m.awaygoals
FROM Match m
JOIN Club homeclub ON m.HomeClubName = homeclub.ClubName
JOIN Club awayclub ON m.AwayClubName = awayclub.ClubName
JOIN City homeclubcity ON homeclub.IdCity = homeclubcity.IdCity
JOIN City awayclubcity ON awayclub.IdCity = awayclubcity.IdCity
WHERE m.matchid LIKE '1381f502';


----------------
-- #Query 1.2#
--

SELECT 
    p.IdPerson || ' ' || p.Name || ' ' || p.Surname AS PlayerName,
    cl.ClubName,
    pc.EndDate
FROM City ci
JOIN Club cl ON ci.IdCity = cl.IdCity
JOIN PlayerClub pc ON cl.ClubName = pc.ClubName
JOIN Player pl ON pc.IdPlayer = pl.IdPlayer
JOIN Person p ON pl.IdPlayer = p.IdPerson
WHERE ci.CityName = 'Barcelona' 
    AND EXTRACT(YEAR FROM pc.EndDate) = 2022
ORDER BY 
    pc.EndDate, 
    p.Name || ' ' || p.Surname;

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT 
    p.name,
    p.club,
    m.match_date,
    m.home,
    m.away
FROM ds1_players p
JOIN ds1_match m ON p.match_id = m.match_id
WHERE p.name = 'Oier Olazábal'
  AND (m.home = 'Espanyol' OR m.away = 'Espanyol')
ORDER BY  m.match_date DESC;


----------------
-- #Query 1.3#
--

SELECT 
    p.Name || ' ' || p.Surname AS ManagerName,
    q.ClubName,
    q.StartDate,
    q.EndDate
FROM (
    SELECT 
        mc.IdManager,
        mc.ClubName,
        mc.StartDate,
        mc.EndDate,
        (mc.EndDate - mc.StartDate) AS DurationDays
    FROM ManagerClub mc
) q
JOIN (
    SELECT AVG(mc.EndDate - mc.StartDate) AS AvgDuration
    FROM ManagerClub mc
) ad ON q.DurationDays > ad.AvgDuration
JOIN Manager m ON q.IdManager = m.IdManager
JOIN Person p ON m.IdManager = p.IdPerson
WHERE p.Gender = 'Female'
ORDER BY q.DurationDays DESC, p.Name, p.Surname;

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT AVG(EndDate - StartDate) AS AvgDuration
FROM ManagerClub;

SELECT
    p.Name || ' ' || p.Surname AS ManagerName,
    mc.ClubName,
    SUM(mc.EndDate - mc.StartDate) AS TotalDays
FROM ManagerClub mc
JOIN Manager m ON mc.IdManager = m.IdManager
JOIN Person p ON m.IdManager = p.IdPerson
WHERE p.Name = 'Andrea' AND p.Surname = 'Esteban'
GROUP BY
    p.Name || ' ' || p.Surname,
    mc.ClubName;


----------------
-- #Query 1.4#
--

SELECT 
	p.Name || ' ' || p.Surname AS RefereeName
	r.CertRefereeCertification
FROM RefereeMatch rm
JOIN Referee r ON rm.IdReferee = r.IdReferee
JOIN Person p ON r.IdReferee = p.IdPerson
JOIN Match m ON rm.MatchId = m.MatchId
WHERE 
    (SUBSTR(rm.CertRefereeCertification, 1, INSTR(rm.CertRefereeCertification, ' ') - 1) = 'FIFA'
    OR SUBSTR(rm.CertRefereeCertification, 1, INSTR(rm.CertRefereeCertification, ' ') - 1) = 'UEFA')
    AND rm.Role = 'var'
    AND m.HomePossession = m.AwayPossession
ORDER BY 
    p.Name, p.Surname;

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT
    referee AS Arbitre_VAR,
    var_cert AS Certificacio_VAR,
    match_id AS ID_Partit
FROM ds1_match
WHERE match_id = '96b120d1'; 


----------------
-- #Query 1.5#
--

SELECT 
	c.League, 
	p.Gender, 
	COUNT(DISTINCT m.MatchId) AS NumMatches
FROM Match m
	JOIN Competition c ON m.IdCompetition = c.IdCompetition
	JOIN PlayerMatch pm ON m.MatchId = pm.IdMatch
	JOIN Person p ON pm.IdPlayer = p.IdPerson
GROUP BY c.League, p.Gender
HAVING COUNT(DISTINCT m.MatchId) > 500
ORDER BY NumMatches DESC;

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT 
    c.League, 
    c.Season,
    COUNT(*) AS TotalMatches
FROM Competition c
JOIN Match m ON c.IdCompetition = m.IdCompetition
GROUP BY c.League, c.Season;

SELECT 
	c.League, 
	p.Gender
FROM Match m
    JOIN Competition c ON m.IdCompetition = c.IdCompetition
    JOIN PlayerMatch pm ON m.MatchId = pm.IdMatch
    JOIN Person p ON pm.IdPlayer = p.IdPerson
GROUP BY c.League, p.Gender


----------------
-- #Query 1.6#
--

SELECT c.ClubName, COUNT(cc.IdCompetition) AS NumeroCompetitions
FROM Club c
JOIN CompetitionClub cc ON c.ClubName = cc.ClubName
JOIN Competition comp ON cc.IdCompetition = comp.IdCompetition
WHERE comp.League = 'Segunda División'
AND c.ClubName IN (
    SELECT cc2.ClubName
    FROM CompetitionClub cc2
    JOIN Competition comp2 ON cc2.IdCompetition = comp2.IdCompetition
    JOIN (
        SELECT IdCompetition, COUNT(*) AS TotalClubs
        FROM CompetitionClub
        GROUP BY IdCompetition
    ) total_clubs ON cc2.IdCompetition = total_clubs.IdCompetition
    WHERE cc2.TotalPoints >= total_clubs.TotalClubs / 2
)
GROUP BY c.ClubName
ORDER BY NumeroCompetitions DESC, c.ClubName ASC;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT 
	c.League, 
	c.Season
FROM CompetitionClub cc
JOIN Competition c ON cc.IdCompetition = c.IdCompetition
JOIN Club cl ON cc.ClubName = cl.ClubName
WHERE cl.ClubName = 'Burgos';

SELECT 
	cl.ClubName, 
   	c.League AS Competition,
   	c.Season AS Season,
   	cc.TotalPoints, 
   	RANK() OVER (ORDER BY cc.TotalPoints DESC) AS Position
FROM CompetitionClub cc
JOIN Club cl ON cc.ClubName = cl.ClubName
JOIN Competition c ON cc.IdCompetition = c.IdCompetition
WHERE cl.ClubName = 'Burgos';

SELECT c.League AS Competition,
       c.Season AS Season,
       COUNT(cc.ClubName) AS TotalTeams
FROM CompetitionClub cc
JOIN Competition c ON cc.IdCompetition = c.IdCompetition
GROUP BY c.League, c.Season;

----------------
-- #Trigger 1.1#
--

CREATE OR REPLACE TRIGGER CheckPossessionConsistency
AFTER UPDATE OF HomePossession, AwayPossession ON Match
FOR EACH ROW
DECLARE
    TotalPossession NUMBER(38);
BEGIN
    TotalPossession := :NEW.HomePossession + :NEW.AwayPossession;
    IF TotalPossession <> 100 THEN
        INSERT INTO WarningsList (affected_table, error_message, id_reference, date_warning, user_warning)
        VALUES ('Match', 'home_possesion+away_possession is not equal to 100', :NEW.MatchId, SYSDATE, USER);
    END IF;
END;
/

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

UPDATE Match
SET HomePossession = 60, AwayPossession = 60
WHERE MatchId = 'fe1c77a8';

SELECT * FROM WarningsList;




----------------
-- #Query 2.1#
--

SELECT p.Dimensions AS Talla, COUNT(*) AS NombreDeProductes
FROM Product p
    JOIN TypeProduct tp ON p.TypeName = tp.TypeName
WHERE tp.TypeName LIKE '%Short%'
GROUP BY p.Dimensions
ORDER BY NombreDeProductes DESC;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT COUNT(*) AS NombreDeProductes
FROM Product p
         JOIN TypeProduct tp ON p.TypeName = tp.TypeName
WHERE tp.TypeName LIKE '%Short%';

----------------
-- #Query 2.2#
--

SELECT p.NameProduct, p.Cost
FROM Product p
         LEFT JOIN Accessory a ON p.NameProduct = a.NameAccessory
         JOIN Activity act ON p.IdActivity = act.IdActivity
WHERE (p.Dimensions = 'XL' AND p.Cost > 350)
   OR (act.NameActivity = 'Casual Wear' AND p.Cost > 110)
   OR (a.Features = 'UV Protection' AND p.Cost > 55)
ORDER BY p.NameProduct;

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT DISTINCT p.Name, p.Cost
FROM ds2_product_sales p
WHERE (p.Dimensions = 'XL' AND p.Cost > 350);

----------------
-- #Query 2.3#
--

SELECT a.IdActivity AS Identificador, a.NameActivity AS Nom, a.ActivityDescription AS Descripcio, COUNT(p.NameProduct) AS Nombre_de_Cops
FROM Product p
         JOIN Activity a ON p.IdActivity = a.IdActivity
GROUP BY a.IdActivity, a.NameActivity, a.ActivityDescription
ORDER BY Nombre_de_Cops DESC
    FETCH FIRST 5 ROWS ONLY;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT COUNT(*)
FROM Product p
         JOIN Activity a ON p.IdActivity = a.IdActivity
WHERE a.nameactivity LIKE 'Casual Wear';

----------------
-- #Query 2.4#
--

SELECT c.CreditCardNum AS Identificador_Targeta, SUM(p.TotalCost) AS Import_Total
FROM CreditCard c
JOIN Purchase p ON c.CreditCardNum = p.IdCard
WHERE c.CreditCardProvider LIKE '%VISA%'
GROUP BY c.CreditCardNum
ORDER BY Import_Total DESC
FETCH FIRST 10 ROWS ONLY;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT c.CreditCardNum AS Identificador_Targeta, SUM(p.TotalCost) AS Import_Total  
FROM CreditCard c  
JOIN Purchase p ON c.CreditCardNum = p.IdCard  
WHERE c.CreditCardProvider LIKE '%VISA%'  
AND c.creditcardnum = 502047424960  
GROUP BY c.CreditCardNum; 


SELECT * FROM Purchase p 
WHERE p.idcard = 502047424960; 


----------------
-- #Query 2.5#
--

SELECT s.IdShop, s.Name AS Nom, s.ShopDescription AS Descripció, SUM(st.Stock) AS TotalEstoc
FROM Shop s
         JOIN Stores st ON s.IdShop = st.IdShop
         JOIN Club c ON c.ClubName = s.ClubName
         JOIN CITY ci ON ci.IdCity = c.IdCity
WHERE ci.CityName LIKE 'Barcelona'
GROUP BY s.IdShop, s.Name, s.ShopDescription
HAVING SUM(st.Stock) >= 5 * (
    SELECT MIN(TotalStock)
    FROM (
             SELECT IdShop, SUM(Stock) AS TotalStock
             FROM Stores
             GROUP BY IdShop
         )
)
ORDER BY TotalEstoc DESC;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT MIN(TotalStock)
FROM (
SELECT IdShop, SUM(Stock) AS TotalStock             
FROM Stores
GROUP BY IdShop
);


----------------
-- #Query 2.6#
--

SELECT p.NameProduct AS Nom, p.Cost
FROM Product p
         LEFT JOIN Purchase pu ON p.NameProduct = pu.NameProduct
WHERE p.Cost > 350 AND pu.IdPurchase IS NULL
ORDER BY p.NameProduct;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)


SELECT p.NameProduct AS Nom, p.Cost  
FROM Product p  
LEFT JOIN Purchase pu ON p.NameProduct = pu.NameProduct  
WHERE pu.IdPurchase IS NULL  
ORDER BY p.Cost DESC 
FETCH FIRST 5 ROWS ONLY; 


SELECT p.NameProduct, p.Cost 
FROM Product p 
WHERE p.Cost > 350 
AND p.NameProduct NOT IN (SELECT DISTINCT NameProduct FROM Purchase) 
ORDER BY p.NameProduct; 


----------------
-- #Trigger 2.1#
--

CREATE OR REPLACE TRIGGER UpdateStockAfterSale
AFTER INSERT ON Purchase
FOR EACH ROW
DECLARE v_stock_actual NUMBER;
BEGIN
SELECT Stock INTO v_stock_actual
FROM Stores
WHERE IdShop = :NEW.IdShop
  AND NameProduct = :NEW.NameProduct;

IF v_stock_actual >= :NEW.Units THEN
UPDATE Stores
SET Stock = Stock - :NEW.Units
WHERE IdShop = :NEW.IdShop
  AND NameProduct = :NEW.NameProduct;
ELSE
        INSERT INTO WarningsList (affected_table, error_message, id_reference, date_warning, user_warning)
        VALUES ('Purchase', 'Insufficient stock for sale', :NEW.IdPurchase, SYSDATE, 'Insufficient stock for sale');

UPDATE Stores
SET Stock = 0
WHERE IdShop = :NEW.IdShop
  AND NameProduct = :NEW.NameProduct;
END IF;
END;
/


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)


INSERT INTO Purchase (IdShop, PurchaseDate, NameProduct, Units, Discount, TotalCost, IdCard)
VALUES (69, '2020-10-15 14:29:31', 'Alavés Backpack Official 144.65 Multi-Compartment', 10, 0, 40, 4866607364569);

INSERT INTO Purchase (IdShop, PurchaseDate, NameProduct, Units, Discount, TotalCost, IdCard)
VALUES (414, '2020-10-15 14:29:31', 'Alavés Long Pants M Official 123.98  Summer Blend', 44, 0, 40, 4866607364569);

INSERT INTO Purchase (IdShop, PurchaseDate, NameProduct, Units, Discount, TotalCost, IdCard)
VALUES (468, '2020-10-15 14:29:31', 'Alavés Bermuda Shorts L 92.98  All Seasons Polyester', 123, 0, 40, 4866607364569);

SELECT * FROM WarningsList;






----------------
-- #Query 3.1#
--

SELECT h.Hashtag, COUNT(*) AS Total_Times_Used
FROM Hashtag h JOIN PostHashtag ph ON h.Hashtag = ph.Hashtag
JOIN Post p ON ph.PostId = p.PostId
WHERE h.Hashtag like '%CF' AND p.likes > (SELECT AVG(Likes) FROM Post p2)
GROUP BY h.Hashtag
ORDER BY Total_Times_Used DESC;

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT AVG(Likes) FROM Post; 


SELECT COUNT(p.PostId) AS Posts_Over_Average  
FROM Hashtag h JOIN PostHashtag ph ON h.Hashtag = ph.Hashtag  
JOIN Post p ON ph.PostId = p.PostId  
WHERE h.Hashtag like '#GetafeCF' AND p.likes > (SELECT AVG(p2.Likes) FROM Post p2)  
GROUP BY h.Hashtag; 


SELECT h.Hashtag, p.likes 
FROM Hashtag h JOIN PostHashtag ph ON h.Hashtag = ph.Hashtag  
JOIN Post p ON ph.PostId = p.PostId  
WHERE h.Hashtag like '#GetafeCF' AND p.likes > (SELECT AVG(p2.Likes) FROM Post p2); 


----------------
-- #Query 3.2#
--

SELECT mg.HeadquartersOfTheMediaGroup, COUNT(tc.TitleOfTheTvChannel) AS Channel_Count
FROM TelevisionChannel tc 
JOIN MediaGroup mg ON tc.NameOfMediaGroup = mg.NameOfMediaGroup
WHERE mg.HeadquartersOfTheMediaGroup LIKE '%ona'
GROUP BY mg.HeadquartersOfTheMediaGroup
ORDER BY mg.HeadquartersOfTheMediaGroup ASC;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT mg.HeadquartersOfTheMediaGroup,tc.TitleOfTheTvChannel 
FROM TelevisionChannel tc   
JOIN MediaGroup mg ON tc.NameOfMediaGroup = mg.NameOfMediaGroup  
WHERE mg.HeadquartersOfTheMediaGroup LIKE 'Tarragona'; 


SELECT mg.HeadquartersOfTheMediaGroup, COUNT(tc.TitleOfTheTvChannel) AS Channel_Count
FROM TelevisionChannel tc 
JOIN MediaGroup mg ON tc.NameOfMediaGroup = mg.NameOfMediaGroup
GROUP BY mg.HeadquartersOfTheMediaGroup
ORDER BY mg.HeadquartersOfTheMediaGroup ASC;


----------------
-- #Query 3.3#
--

SELECT p.PostText, p.PostDate 
FROM Post p 
WHERE p.PostId = (
    SELECT p2.ReplyTo 
    FROM Post p2 
    GROUP BY p2.ReplyTo 
    ORDER BY COUNT(p2.ReplyTo) DESC 
    FETCH FIRST 1 ROW ONLY
);

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT p.ReplyTo, COUNT(p.ReplyTo) AS Number_Replies  
FROM Post p   
GROUP BY p.ReplyTo   
ORDER BY COUNT(p.ReplyTo) DESC; 


SELECT *  
FROM Post 
WHERE postid like '19642'; 


----------------
-- #Query 3.4#
--

SELECT h.Hashtag
FROM Hashtag h JOIN PostHashtag ph ON h.Hashtag = pH.Hashtag
JOIN (
    SELECT DISTINCT p.PostId
    FROM Post p
    JOIN PostImage pi ON p.PostId = pi.PostId
    JOIN Image i ON i.ImageTitle = pi.ImageTitle
    WHERE SUBSTR(i.mime, INSTR(i.mime, '/') + 1) = 'tiff'
) postUnica ON ph.PostId = postUnica.PostId
JOIN Post p ON p.PostId = ph.PostId
JOIN User_db u ON p.Nickname = u.Nickname
WHERE u.CreationDate > '31-DEC-2023'
GROUP BY h.Hashtag
ORDER BY COUNT(h.Hashtag) DESC
FETCH FIRST 10 ROWS ONLY;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT DISTINCT h.Hashtag, p.PostId, u.CreationDate
FROM Hashtag h 
JOIN PostHashtag ph ON h.Hashtag = ph.Hashtag
JOIN (
    SELECT DISTINCT p.PostId
    FROM Post p
    JOIN PostImage pi ON p.PostId = pi.PostId
    JOIN Image i ON i.ImageTitle = pi.ImageTitle
    WHERE SUBSTR(i.mime, INSTR(i.mime, '/') + 1) = 'tiff'
) postUnica ON ph.PostId = postUnica.PostId
JOIN Post p ON p.PostId = ph.PostId
JOIN User_db u ON p.Nickname = u.Nickname
WHERE u.CreationDate > TO_DATE('31-DEC-2023', 'DD-MON-YYYY')
AND h.Hashtag like '#MatchDay';




----------------
-- #Query 3.5#
--

SELECT DISTINCT u.Nickname, COUNT(p.PostId) AS Total_Posts, EXTRACT(YEAR FROM p.PostDate) AS Year
FROM User_db u JOIN Post p ON u.Nickname = p.Nickname
WHERE p.Nickname IN (SELECT DISTINCT Nickname 
                    FROM Post 
                    WHERE Nickname IS NOT NULL
                    ORDER BY Reposts DESC 
                    FETCH FIRST 500 ROWS ONLY)
GROUP BY u.Nickname, EXTRACT(YEAR FROM p.PostDate)
ORDER BY Year DESC;

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)


SELECT DISTINCT Nickname 
FROM Post 
WHERE Nickname IS NOT NULL
ORDER BY Reposts DESC 
FETCH FIRST 500 ROWS ONLY;


SELECT * 
FROM Post p 
WHERE reposts IS NOT NULL 
ORDER BY p.Reposts DESC 
FETCH FIRST 1 ROW ONLY; 


----------------
-- #Query 3.6#
--

SELECT p.ProgrammeName, 
    CASE 
        WHEN EXISTS (SELECT 1 FROM TelevisionProgramme tv WHERE tv.TelevisionProgrammeName = p.ProgrammeName) THEN 'TV' 
        ELSE 'Ràdio' 
    END AS ProgrammeType, LENGTH(p.ProgrammeName) AS NameLength
FROM Programme p
WHERE LENGTH(p.ProgrammeName) > 
        (SELECT 
            CASE 
                WHEN EXISTS (SELECT 1 FROM TelevisionProgramme tv WHERE tv.TelevisionProgrammeName = p.ProgrammeName) THEN
                    (SELECT AVG(LENGTH(TelevisionProgrammeName)) FROM TelevisionProgramme)
                ELSE
                    (SELECT AVG(LENGTH(RadioProgrammeName)) FROM RadioProgramme)
            END
        FROM dual)
ORDER BY LENGTH(p.ProgrammeName) DESC
FETCH FIRST 10 ROWS ONLY;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT AVG(LENGTH(TelevisionProgrammeName)) AS AVERAGE_TV_LENGTH 
FROM TelevisionProgramme; 


SELECT AVG(LENGTH(RadioProgrammeName)) AS AVERAGE_RADIO_LENGTH 
FROM RadioProgramme; 


SELECT p.ProgrammeName, LENGTH(p.ProgrammeName) AS Radio_Programme_Length
FROM Programme p
WHERE p.ProgrammeName IN (SELECT RadioProgrammeName FROM RadioProgramme) 
    AND LENGTH(p.ProgrammeName) > (SELECT AVG(LENGTH(RadioProgrammeName))FROM RadioProgramme)
ORDER BY Radio_Programme_Length DESC;


SELECT p.ProgrammeName, 
LENGTH(p.ProgrammeName) AS Radio_Programme_Length
FROM Programme p
WHERE p.ProgrammeName IN 
    (SELECT RadioProgrammeName FROM RadioProgramme) 
    AND LENGTH(p.ProgrammeName) > 
    (SELECT AVG(LENGTH(RadioProgrammeName))FROM RadioProgramme)
ORDER BY Radio_Programme_Length DESC;



----------------
-- #Trigger 3.1#
--

CREATE OR REPLACE TRIGGER CheckPostLikes
AFTER INSERT ON Post
FOR EACH ROW
WHEN (NEW.Likes < 100)
BEGIN
    INSERT INTO WarningsList (affected_table, error_message, id_reference, date_warning, user_warning)
    VALUES ('Post', 'Added post with less than 100 likes', TO_CHAR(:NEW.PostId), SYSDATE, :NEW.Nickname);
END;
/

SELECT trigger_name, status
FROM user_triggers
WHERE table_name = 'POST';

-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

INSERT INTO Post (PostId, PostText, PostDate, Likes, Reposts, Nickname, ReplyTo)  
VALUES (32345678, 'New product!', '16-APR-23', 60, 201, 'margarita11', 12767); 

 
INSERT INTO Post (PostId, PostText, PostDate, Likes, Reposts, Nickname, ReplyTo)  
VALUES (3354, 'New product2!', '16-APR-23', 80, 315, 'margarita11', 12767); 

SELECT * FROM WarningsList; 




----------------
-- #Query 4.1#
--

SELECT c.Id_Campaign, 
       c.Campaign_name, 
       COUNT(a.NumAd) AS NumeroAds
FROM Campaign c
JOIN Ad a ON c.Id_Campaign = a.Id_Campaign
JOIN Client cl ON c.Client_name = cl.Client_name
JOIN City ci ON cl.Id_City = ci.IdCity
WHERE (
    (c.Start_date BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD'))
    OR 
    (c.End_date BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD'))
    OR 
    (c.Start_date <= TO_DATE('2023-01-01', 'YYYY-MM-DD') AND c.End_date >= TO_DATE('2023-12-31', 'YYYY-MM-DD'))
  )
  and ci.CityName = 'Madrid'
GROUP BY c.Id_Campaign, c.Campaign_name
ORDER BY NumeroAds ASC;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT c.Id_Campaign, 
       c.Campaign_name, 
       COUNT(a.NumAd) AS NumeroAds
FROM Campaign c
JOIN Ad a ON c.Id_Campaign = a.Id_Campaign
JOIN Client cl ON c.Client_name = cl.Client_name
JOIN City ci ON cl.Id_City = ci.IdCity
WHERE  ci.CityName = 'Madrid'
GROUP BY c.Id_Campaign, c.Campaign_name
ORDER BY NumeroAds ASC;

SELECT c.Id_Campaign, 
       c.Campaign_name, 
       COUNT(a.NumAd) AS NumeroAds
FROM Campaign c
JOIN Ad a ON c.Id_Campaign = a.Id_Campaign
JOIN Client cl ON c.Client_name = cl.Client_name
JOIN City ci ON cl.Id_City = ci.IdCity
WHERE  (
    (c.Start_date BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD'))
    OR 
    (c.End_date BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD'))
    OR 
    (c.Start_date <= TO_DATE('2023-01-01', 'YYYY-MM-DD') AND c.End_date >= TO_DATE('2023-12-31', 'YYYY-MM-DD'))
  )
GROUP BY c.Id_Campaign, c.Campaign_name
ORDER BY NumeroAds ASC;


----------------
-- #Query 4.2#
--

SELECT DISTINCT c.Campaign_name
FROM Campaign c
JOIN Ad a ON c.Id_Campaign = a.Id_Campaign
JOIN categoryAd ca ON a.NumAd = ca.NumAd
WHERE a.Status = 'Active'
AND ca.Category_Name IN (
    SELECT DISTINCT c.Category_Name
    FROM Ad a
    JOIN categoryAd ca ON a.NumAd = ca.NumAd
    JOIN Categories c ON ca.Category_Name = c.Category_Name
);


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT c.Campaign_name, COUNT(DISTINCT a.NumAd) AS NumAds
FROM Campaign c
JOIN Ad a ON c.Id_Campaign = a.Id_Campaign
WHERE a.Status = 'Active'
GROUP BY c.Campaign_name;

----------------
-- #Query 4.3#
--

SELECT c.Id_Campaign, 
       SUM(cl.Client_Budget) AS TotalBudget, 
       COUNT(cl.Client_name) AS NumClients
FROM Campaign c
JOIN Ad a ON c.Id_Campaign = a.Id_Campaign
JOIN Client cl ON c.Client_name = cl.Client_name
WHERE c.Id_Campaign LIKE '4%'
AND cl.Client_Budget >= (
    SELECT AVG(Client_Budget)
    FROM Client
)
GROUP BY c.Id_Campaign
HAVING COUNT(cl.Client_name) > 0;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT AVG(Client_Budget) AS AverageBudget
FROM Client;

----------------
-- #Query 4.4#
--

SELECT pt.Type_description, 
       SUM(ap.Cost) AS TotalCost
FROM AdPlacement ap
JOIN Ad a ON ap.NumAd = a.NumAd
JOIN Campaign c ON a.Id_Campaign = c.Id_Campaign
JOIN Placement p ON ap.IdPlacement = p.IdPlacement
JOIN PlacementType pt ON p.IdPlacementType = pt.Id_PlacementType
WHERE TO_NUMBER(REGEXP_SUBSTR(c.audience_segment, '\d+')) > (
    SELECT AVG(TO_NUMBER(REGEXP_SUBSTR(camp.audience_segment, '\d+')))
    FROM Campaign camp
)
GROUP BY pt.Type_description;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT pt.Type_description, 
       SUM(ap.Cost) AS TotalCost
FROM AdPlacement ap
JOIN Ad a ON ap.NumAd = a.NumAd
JOIN Campaign c ON a.Id_Campaign = c.Id_Campaign
JOIN Placement p ON ap.IdPlacement = p.IdPlacement
JOIN PlacementType pt ON p.IdPlacementType = pt.Id_PlacementType
GROUP BY pt.Type_description;

SELECT AVG(TO_NUMBER(REGEXP_SUBSTR(audience_segment, '\d+'))) AS AvgAudienceSize
FROM Campaign;

----------------
-- #Query 4.5#
--

SELECT a.NumAd, a.Title
FROM Ad a
JOIN Campaign c ON a.Id_campaign = c.Id_Campaign
JOIN Client cl ON c.client_name = cl.Client_Name
JOIN City ci ON cl.Id_City = ci.IdCity
WHERE ci.CityName = 'Girona'
AND a.Title LIKE '%Friday%'
GROUP BY a.NumAd, a.Title
HAVING COUNT(DISTINCT CASE WHEN ci.CityName = 'Girona' THEN cl.Client_Name END) > COUNT(DISTINCT CASE WHEN ci.CityName != 'Girona' THEN cl.Client_Name END);


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT cl.Client_Name, cl.Id_City, ci.CityName
FROM Client cl
JOIN City ci ON cl.Id_City = ci.IdCity
WHERE ci.CityName = 'Girona';

SELECT a.NumAd, a.Title, 
       COUNT(DISTINCT CASE WHEN ci.CityName = 'Girona' THEN cl.Client_Name END) AS ClientsGirona,
       COUNT(DISTINCT CASE WHEN ci.CityName != 'Girona' THEN cl.Client_Name END) AS ClientsNoGirona,
       LISTAGG(DISTINCT CASE WHEN ci.CityName = 'Girona' THEN cl.Client_Name END, ', ') 
           WITHIN GROUP (ORDER BY cl.Client_Name) AS ClientsGironaNames
FROM Ad a
JOIN Campaign c ON a.Id_campaign = c.Id_Campaign
JOIN Client cl ON c.client_name = cl.Client_Name
JOIN City ci ON cl.Id_City = ci.IdCity
WHERE a.Title LIKE '%Friday%'
GROUP BY a.NumAd, a.Title;

----------------
-- #Query 4.6#
--

SELECT a.NumAd, a.Title, COUNT(ap.IdPlacement) AS EmplacementCount
FROM Ad a
JOIN adPlacement ap ON a.NumAd = ap.NumAd
JOIN Placement p ON ap.IdPlacement = p.IdPlacement
GROUP BY a.NumAd, a.Title
HAVING COUNT(ap.IdPlacement) <
    2 * (
        SELECT AVG(EmplacementCount) AS AvgEmplacements
        FROM (
            SELECT a.NumAd AS AdNum, COUNT(ap.IdPlacement) AS EmplacementCount
            FROM Ad a
            JOIN adPlacement ap ON a.NumAd = ap.NumAd
            JOIN Placement p ON ap.IdPlacement = p.IdPlacement
            GROUP BY a.NumAd
        )
    )
ORDER BY EmplacementCount DESC, a.NumAd
FETCH FIRST 5 ROWS ONLY;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT AVG(EmplacementCount) AS AvgEmplacements
FROM (
    SELECT a.NumAd, COUNT(ap.IdPlacement) AS EmplacementCount
    FROM Ad a
    JOIN adPlacement ap ON a.NumAd = ap.NumAd
    JOIN Placement p ON ap.IdPlacement = p.IdPlacement
    GROUP BY a.NumAd
);

SELECT a.NumAd, a.Title, COUNT(ap.IdPlacement) AS EmplacementCount
FROM Ad a
JOIN adPlacement ap ON a.NumAd = ap.NumAd
JOIN Placement p ON ap.IdPlacement = p.IdPlacement
GROUP BY a.NumAd, a.Title
HAVING COUNT(ap.IdPlacement) >= 2 * (
    SELECT AVG(EmplacementCount)
    FROM (
        SELECT a.NumAd, COUNT(ap.IdPlacement) AS EmplacementCount
        FROM Ad a
        JOIN adPlacement ap ON a.NumAd = ap.NumAd
        JOIN Placement p ON ap.IdPlacement = p.IdPlacement
        GROUP BY a.NumAd
    )
);


----------------
-- #Trigger 4.1#
--

CREATE OR REPLACE TRIGGER CampaignClientUpdateWarning
BEFORE UPDATE OF Client_name ON Campaign
FOR EACH ROW
DECLARE
    v_NumAds NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_NumAds
    FROM Ad
    WHERE Id_Campaign = :OLD.Id_Campaign;

    IF v_NumAds > 5 THEN
        INSERT INTO WarningsList (affected_table, error_message, id_reference, date_warning, user_warning)
        VALUES (
            'Campaign', 
            'Updated client name from campaign with more than 5 ads', 
            TO_CHAR(:OLD.Id_Campaign), 
            SYSDATE, 
            USER
        );
    END IF;
END;
/


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

INSERT INTO Client (Client_Name, Client_Budget, Id_City)
VALUES ('Client1', 100000, 1);
 
INSERT INTO Campaign (Id_Campaign, Campaign_name, Objective, Budget, Start_date, End_date, Audience_Interest, Audience_Segment, Client_name)
VALUES ('Campaign1', 'Campaign A', 'Increase Sales', 50000, SYSDATE, SYSDATE + 30, 'Sports', '18-35', 'Client1');

INSERT INTO Ad (NumAd, Title, Description, Format, Status, AdDate, Id_Campaign) VALUES (1, 'Ad1', 'Description1', 'Format1', 'Active', SYSDATE, 'Campaign1');
INSERT INTO Ad (NumAd, Title, Description, Format, Status, AdDate, Id_Campaign) VALUES (2, 'Ad2', 'Description2', 'Format2', 'Active', SYSDATE, 'Campaign1');
INSERT INTO Ad (NumAd, Title, Description, Format, Status, AdDate, Id_Campaign) VALUES (3, 'Ad3', 'Description3', 'Format3', 'Active', SYSDATE, 'Campaign1');
INSERT INTO Ad (NumAd, Title, Description, Format, Status, AdDate, Id_Campaign) VALUES (4, 'Ad4', 'Description4', 'Format4', 'Active', SYSDATE, 'Campaign1');
INSERT INTO Ad (NumAd, Title, Description, Format, Status, AdDate, Id_Campaign) VALUES (5, 'Ad5', 'Description5', 'Format5', 'Active', SYSDATE, 'Campaign1');
INSERT INTO Ad (NumAd, Title, Description, Format, Status, AdDate, Id_Campaign) VALUES (6, 'Ad6', 'Description6', 'Format6', 'Active', SYSDATE, 'Campaign1');


UPDATE Campaign
SET Client_name = 'Client1'
WHERE Id_Campaign = 'Campaign1';

SELECT * FROM WarningsList;

----------------
-- #Query 5.1#
--

SELECT c.Campaign_name, COUNT(pc.NameProduct) AS num_products
FROM Campaign c
JOIN ProductCampaign pc ON c.Id_Campaign = pc.Id_Campaign
GROUP BY c.Campaign_name
ORDER BY num_products DESC;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT c.Campaign_name, pc.NameProduct
FROM Campaign c
JOIN ProductCampaign pc ON c.Id_Campaign = pc.Id_Campaign
WHERE c.Campaign_name = 'SpringSale2024';


----------------
-- #Query 5.2#
--

SELECT 
    pr.Name || ' ' || pr.Surname AS ShopKeeperName, 
    s.Name AS ShopName, 
    sk.VacationDays
FROM ShopKeeper sk
JOIN Manages m ON sk.IdShopKeeper = m.IdShopKeeper
JOIN Person pr ON pr.idperson = sk.idshopkeeper
JOIN Shop s ON m.IdShop = s.IdShop
JOIN Club c ON s.ClubName = c.ClubName
JOIN City ci ON c.IdCity = ci.IdCity
WHERE ci.CityName = 'Girona'
  AND s.Name LIKE 'Girona - G%'
  AND sk.VacationDays > (
    SELECT AVG(VacationDays)
    FROM ShopKeeper
  )
ORDER BY sk.VacationDays DESC;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT s.Name AS ShopName, c.ClubName
FROM Shop s
JOIN Club c ON s.ClubName = c.ClubName
JOIN City ci ON c.IdCity = ci.IdCity
WHERE ci.CityName = 'Girona';


SELECT 
    sk.IdShopKeeper,
    pr.Name || ' ' || pr.Surname AS ShopKeeperName
FROM Shop s
JOIN Manages m ON s.IdShop = m.IdShop
JOIN ShopKeeper sk ON m.IdShopKeeper = sk.IdShopKeeper
JOIN Person pr ON sk.IdShopKeeper = pr.IdPerson
WHERE s.Name = 'Girona - GoalLine Gear';


----------------
-- #Query 5.3#
--

SELECT c.ClubName, ci.CityName, co.CountryName
FROM Club c
JOIN City ci ON c.IdCity = ci.IdCity
JOIN Country co ON ci.CountryName = co.CountryName
WHERE c.ClubName IN (
        SELECT p.ClubName 
        FROM Product p
        JOIN TypeProduct tp ON p.TypeName = tp.TypeName
        WHERE tp.TypeName = 'Polo Shirt' AND p.Official = 'Official'
        GROUP BY p.ClubName
        HAVING COUNT(*) = 1)
        
ORDER BY C.ClubName ASC;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT p.ClubName 
FROM Product p
JOIN TypeProduct tp ON p.TypeName = tp.TypeName
WHERE tp.TypeName = 'Polo Shirt' AND p.Official = 'Official'
GROUP BY p.ClubName
HAVING COUNT(*) = 1;


----------------
-- #Query 5.4#
--

(SELECT Campaign_name, ProductCount
FROM (
    SELECT c.Campaign_name, COUNT(pc.NameProduct) AS ProductCount
    FROM Campaign c
    LEFT JOIN ProductCampaign pc ON c.Id_Campaign = pc.Id_Campaign
    GROUP BY c.Campaign_name
    ORDER BY ProductCount DESC NULLS LAST, c.Campaign_name
    FETCH FIRST 5 ROWS ONLY)
)
UNION
(SELECT Campaign_name, ProductCount
FROM (
    SELECT c.Campaign_name, COUNT(pc.NameProduct) AS ProductCount
    FROM Campaign c
    LEFT JOIN ProductCampaign pc ON c.Id_Campaign = pc.Id_Campaign
    GROUP BY c.Campaign_name
    ORDER BY ProductCount ASC NULLS LAST, c.Campaign_name
    FETCH FIRST 5 ROWS ONLY)
)
           ORDER BY ProductCount DESC NULLS LAST, Campaign_name;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT c.Campaign_name, pc.NameProduct
FROM Campaign c
JOIN ProductCampaign pc ON c.Id_Campaign = pc.Id_Campaign
WHERE c.Campaign_name = 'SpringSale2024';

SELECT c.Campaign_name, pc.NameProduct
FROM Campaign c
JOIN ProductCampaign pc ON c.Id_Campaign = pc.Id_Campaign
WHERE c.Campaign_name = 'YearEndClearance';


SELECT c.Campaign_name, COUNT(pc.NameProduct) AS ProductCount
FROM Campaign c
LEFT JOIN ProductCampaign pc ON c.Id_Campaign = pc.Id_Campaign
GROUP BY c.Campaign_name
ORDER BY COUNT(pc.NameProduct) DESC NULLS LAST, c.Campaign_name
FETCH FIRST 5 ROWS ONLY;

SELECT c.Campaign_name, COUNT(pc.NameProduct) AS ProductCount
FROM Campaign c
LEFT JOIN ProductCampaign pc ON c.Id_Campaign = pc.Id_Campaign
GROUP BY c.Campaign_name
ORDER BY COUNT(pc.NameProduct) ASC NULLS LAST, c.Campaign_name
FETCH FIRST 5 ROWS ONLY;



----------------
-- #Query 5.5#
--

SELECT * 
FROM Placement p
LEFT JOIN PlacementPost pp ON pp.IdPlacement = p.IdPlacement
LEFT JOIN Post pt ON pt.PostId = pp.PostId
WHERE pp.IdPlacement IS NULL
ORDER BY p.IdPlacement DESC;


SELECT *
FROM Placement
WHERE IdPlacement NOT IN (
    SELECT IdPlacement
    FROM PlacementPost
)
ORDER BY IdPlacement DESC;



-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)


SELECT COUNT(p.IdPlacement) AS Total_Ubicacions_Sense_Post
FROM Placement p
LEFT JOIN PlacementPost pp ON pp.IdPlacement = p.IdPlacement
WHERE pp.IdPlacement IS NULL;


----------------
-- #Query 5.6#
--

SELECT 'TotalPlayers' AS Category, COUNT(*) AS Total
FROM Player
UNION ALL
SELECT 'TotalManager' AS Category, COUNT(*) AS Total
FROM Manager
UNION ALL
SELECT 'TotalReferees' AS Category, COUNT(*) AS Total
FROM Referee
UNION ALL
SELECT 'TotalCommunicators' AS Category, COUNT(*) AS Total
FROM Communicator
UNION ALL
SELECT 'TotalShopKeepers' AS Category, COUNT(*) AS Total
FROM ShopKeeper;


-- #Validation#
-- if needed, write the validation queries (select, update, insert, delete)

SELECT COUNT(*) AS TotalPersons
FROM Person;

