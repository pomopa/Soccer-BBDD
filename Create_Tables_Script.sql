DROP TABLE Country CASCADE CONSTRAINTS;
DROP TABLE City CASCADE CONSTRAINTS;
DROP TABLE Club CASCADE CONSTRAINTS;
DROP TABLE TypeProduct CASCADE CONSTRAINTS;
DROP TABLE Activity CASCADE CONSTRAINTS;
DROP TABLE Stadium CASCADE CONSTRAINTS;
DROP TABLE Competition CASCADE CONSTRAINTS;
DROP TABLE Match CASCADE CONSTRAINTS;
DROP TABLE Person CASCADE CONSTRAINTS;
DROP TABLE Manager CASCADE CONSTRAINTS;
DROP TABLE Referee CASCADE CONSTRAINTS;
DROP TABLE Player CASCADE CONSTRAINTS;
DROP TABLE ManagerMatch CASCADE CONSTRAINTS;
DROP TABLE RefereeMatch CASCADE CONSTRAINTS;
DROP TABLE PlayerMatch CASCADE CONSTRAINTS;
DROP TABLE User_db CASCADE CONSTRAINTS;
DROP TABLE Post CASCADE CONSTRAINTS;
DROP TABLE Hashtag CASCADE CONSTRAINTS;
DROP TABLE PostHashtag CASCADE CONSTRAINTS;
DROP TABLE Communicator CASCADE CONSTRAINTS;
DROP TABLE Image CASCADE CONSTRAINTS;
DROP TABLE PostImage CASCADE CONSTRAINTS;
DROP TABLE MediaGroup CASCADE CONSTRAINTS;
DROP TABLE RadioStation CASCADE CONSTRAINTS;
DROP TABLE TelevisionChannel CASCADE CONSTRAINTS;
DROP TABLE ProgrammeCommunicator CASCADE CONSTRAINTS;
DROP TABLE TelevisionProgramme CASCADE CONSTRAINTS;
DROP TABLE RadioProgramme CASCADE CONSTRAINTS;
DROP TABLE Accessory CASCADE CONSTRAINTS;
DROP TABLE Clothes CASCADE CONSTRAINTS;
DROP TABLE Shoe CASCADE CONSTRAINTS;
DROP TABLE Stores CASCADE CONSTRAINTS;
DROP TABLE CreditCard CASCADE CONSTRAINTS;
DROP TABLE Shop CASCADE CONSTRAINTS;
DROP TABLE Manages CASCADE CONSTRAINTS;
DROP TABLE Affiliates CASCADE CONSTRAINTS;
DROP TABLE ClubStadium CASCADE CONSTRAINTS;
DROP TABLE ManagerClub CASCADE CONSTRAINTS;
DROP TABLE PlayerClub CASCADE CONSTRAINTS;
DROP TABLE CompetitionClub CASCADE CONSTRAINTS;
DROP TABLE Programme CASCADE CONSTRAINTS;
DROP TABLE Product CASCADE CONSTRAINTS;
DROP TABLE AD CASCADE CONSTRAINTS;
DROP TABLE Purchase CASCADE CONSTRAINTS;
DROP TABLE ShopKeeper CASCADE CONSTRAINTS;
DROP TABLE PlacementType CASCADE CONSTRAINTS;
DROP TABLE Categories CASCADE CONSTRAINTS;
DROP TABLE Client CASCADE CONSTRAINTS;
DROP TABLE Campaign CASCADE CONSTRAINTS;
DROP TABLE Placement CASCADE CONSTRAINTS;
DROP TABLE ProductCampaign CASCADE CONSTRAINTS;
DROP TABLE Subcategories CASCADE CONSTRAINTS;
DROP TABLE adPlacement CASCADE CONSTRAINTS;
DROP TABLE categoryAd CASCADE CONSTRAINTS;
DROP TABLE ProgrammePlacement CASCADE CONSTRAINTS;
DROP TABLE PlacementPost CASCADE CONSTRAINTS;
DROP TABLE PlacementStadium CASCADE CONSTRAINTS;
DROP TABLE PlacementShop CASCADE CONSTRAINTS;

DROP SEQUENCE CitySeq;
DROP SEQUENCE CompetitionSeq;
DROP SEQUENCE PersonSeq;
DROP SEQUENCE PlacementSeq;
DROP SEQUENCE PurchaseSeq;
DROP SEQUENCE ShopSeq;
DROP SEQUENCE StoresSeq;
DROP SEQUENCE ManagesSeq;


--------- Country ---------

CREATE TABLE Country (
    --IdCountry NUMBER PRIMARY KEY,
    CountryName VARCHAR2(255) PRIMARY KEY
);

--------- City ---------

CREATE SEQUENCE CitySeq
  START WITH 1
  INCREMENT BY 1;


CREATE TABLE City (
    IdCity NUMBER PRIMARY KEY,
    CityName VARCHAR2(255),
    CountryName VARCHAR2(255),
    FOREIGN KEY (CountryName) REFERENCES Country(CountryName)
);

CREATE OR REPLACE TRIGGER City_BI
BEFORE INSERT ON City
FOR EACH ROW
BEGIN
  SELECT CitySeq.NEXTVAL INTO :NEW.IdCity FROM DUAL;
END;
/


--------- Club ---------

CREATE TABLE Club (
    ClubName VARCHAR2(26) PRIMARY KEY,
    IdCity NUMBER,
    --Gender VARCHAR2(26),
    FOREIGN KEY (IdCity) REFERENCES City(IdCity)
);


--------- Stadium ---------

CREATE TABLE Stadium (
    StadiumName VARCHAR2(128) PRIMARY KEY,
    IdCity NUMBER,
    FOREIGN KEY (IdCity) REFERENCES City(IdCity)
);

---------ClubStadium----------

CREATE TABLE ClubStadium (
    ClubName VARCHAR2(26),
    StadiumName VARCHAR2(128),
    PRIMARY KEY (ClubName, StadiumName),
    FOREIGN KEY (ClubName) REFERENCES Club(ClubName),
    FOREIGN KEY (StadiumName) REFERENCES Stadium(StadiumName)
);

--------- Competition --------- 

CREATE SEQUENCE CompetitionSeq
  START WITH 1
  INCREMENT BY 1;

CREATE TABLE Competition (
    IdCompetition NUMBER PRIMARY KEY,
    League VARCHAR2(26),
    Season VARCHAR2(26)
);

CREATE OR REPLACE TRIGGER Competition_BI
BEFORE INSERT ON Competition
FOR EACH ROW
BEGIN
  SELECT CompetitionSeq.NEXTVAL INTO :NEW.IdCompetition FROM DUAL;
END;
/

--------- Match --------

CREATE TABLE Match (
    MatchId VARCHAR2(26) PRIMARY KEY,
    MatchDate DATE,
    MatchHour DATE,
    Attendance NUMBER(38),
    StadiumName VARCHAR2(255),
    IdCompetition NUMBER,
    HomeClubName VARCHAR2(26),
    AwayClubName VARCHAR2(26),
    HomePossession NUMBER(38),
    AwayPossession NUMBER(38),
    HomeGoals NUMBER(38),
    AwayGoals NUMBER(38),
    HomePoints NUMBER(38),
    AwayPoints NUMBER(38),
    IdCity NUMBER,
    FOREIGN KEY (HomeClubName) REFERENCES Club(ClubName),
    FOREIGN KEY (AwayClubName) REFERENCES Club(ClubName),
    FOREIGN KEY (StadiumName) REFERENCES Stadium(StadiumName),
    FOREIGN KEY (IdCompetition) REFERENCES Competition(IdCompetition),
    FOREIGN KEY (IdCity) REFERENCES City (IdCity)
);

-------- Person ---------

CREATE SEQUENCE PersonSeq
  START WITH 1
  INCREMENT BY 1;

CREATE TABLE Person (
    IdPerson NUMBER PRIMARY KEY,
    Name VARCHAR2(255),
    Surname VARCHAR2(255),
    BirthDate DATE,
    Gender VARCHAR2(10),
    IdCity NUMBER,
    FOREIGN KEY (IdCity) REFERENCES City(IdCity)
);

CREATE OR REPLACE TRIGGER Person_BI
BEFORE INSERT ON Person
FOR EACH ROW
BEGIN
  SELECT PersonSeq.NEXTVAL INTO :NEW.IdPerson FROM DUAL;
END;
/


--------- Referee ---------
 
CREATE TABLE Referee (
    IdReferee NUMBER PRIMARY KEY,
    FOREIGN KEY (IdReferee) REFERENCES Person(IdPerson)
);

--------- Manager ---------

CREATE TABLE Manager (
    IdManager NUMBER PRIMARY KEY,
    Tactics VARCHAR2(26),
    Style VARCHAR2(26),
    FOREIGN KEY (IdManager) REFERENCES Person(IdPerson)
);


--------- Player ---------

CREATE TABLE Player (
    IdPlayer NUMBER PRIMARY KEY,
    PreferredPosition VARCHAR2(26),
    Height NUMBER(38),
    Weight NUMBER(38),
    Footed VARCHAR2(26),
    FOREIGN KEY (IdPlayer) REFERENCES Person(IdPerson)
);


--------- ManagerClub ---------

CREATE TABLE ManagerClub (
    ClubName VARCHAR2(26),
    IdManager NUMBER,
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (ClubName, IdManager),
    FOREIGN KEY (ClubName) REFERENCES Club(ClubName),
    FOREIGN KEY (IdManager) REFERENCES Manager(IdManager)
);


--------- ManagerMatch ---------

CREATE TABLE ManagerMatch (
    MatchId VARCHAR2(26),
    IdManager NUMBER,
    PRIMARY KEY (MatchId, IdManager),
    FOREIGN KEY (MatchId) REFERENCES Match(MatchId),
    FOREIGN KEY (IdManager) REFERENCES Manager(IdManager)
);


--------- RefereeMatch ---------

CREATE TABLE RefereeMatch (
    MatchId VARCHAR2(26),
    IdReferee NUMBER,
    Role VARCHAR2(26),
    CertRefereeCertification VARCHAR2(128),
    PRIMARY KEY (IdReferee, MatchId),
    FOREIGN KEY (MatchId) REFERENCES Match(MatchId),
    FOREIGN KEY (IdReferee) REFERENCES Referee(IdReferee)
    
);

--------- PlayerClub ---------

CREATE TABLE PlayerClub (
    ClubName VARCHAR2(26),
    IdPlayer NUMBER,
    Dorsal NUMBER(38),
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (ClubName, IdPlayer),
    FOREIGN KEY (ClubName) REFERENCES Club(ClubName),
    FOREIGN KEY (IdPlayer) REFERENCES Player(IdPlayer)
);


--------- Affiliates ---------

CREATE TABLE Affiliates (
    ClubName1 VARCHAR2(26),
    ClubName2 VARCHAR2(26),
    PRIMARY KEY (ClubName1, ClubName2),
    FOREIGN KEY (ClubName1) REFERENCES Club(ClubName),
    FOREIGN KEY (ClubName2) REFERENCES Club(ClubName)
);

--------- CompetitionClub ---------

CREATE TABLE CompetitionClub (
    ClubName VARCHAR2(26),
    IdCompetition NUMBER,
    TotalPoints NUMBER(38),
    PRIMARY KEY (ClubName, IdCompetition),
    FOREIGN KEY (ClubName) REFERENCES Club(ClubName),
    FOREIGN KEY (IdCompetition) REFERENCES Competition(IdCompetition)
);

--------- PlayerMatch ---------
 
CREATE TABLE PlayerMatch (
    IdMatch VARCHAR2(26),
    IdPlayer NUMBER,
    Goals NUMBER(38),
    Shots NUMBER(38),
    ShotsOnTarget NUMBER(38),
    Assists NUMBER(38),
    YellowCards NUMBER(38),
    RedCards NUMBER(38),
    InitialMinute NUMBER(38),
    FinalMinute NUMBER(38),
    Position VARCHAR2(26),
    PRIMARY KEY (IdMatch, IdPlayer),
    FOREIGN KEY (IdMatch) REFERENCES Match(MatchId),
    FOREIGN KEY (IdPlayer) REFERENCES Player(IdPlayer)
);


--------- User_db ---------

CREATE TABLE User_db (
    Nickname VARCHAR2(128) PRIMARY KEY,
    CreationDate DATE,
    Verified NUMBER(38),
    IdCity NUMBER,    
    FOREIGN KEY (IdCity) REFERENCES City(IdCity)
);


--------- Post ---------

CREATE TABLE Post (
    PostId NUMBER(38) PRIMARY KEY,
    PostText VARCHAR2(1024),
    PostDate DATE,
    Likes NUMBER(38),
    Reposts NUMBER(38),
    Nickname VARCHAR2(128),
    ReplyTo NUMBER(38),
    FOREIGN KEY (Nickname) REFERENCES User_db(Nickname)
);

--------- Hashtag ---------

CREATE TABLE Hashtag (
    Hashtag VARCHAR2(26) PRIMARY KEY,
    HashtagDesc VARCHAR2(128),
    TrendingStatus VARCHAR2(26)
);

--------- PostHashtag ---------

CREATE TABLE PostHashtag (
    Hashtag VARCHAR2(26),
    PostId NUMBER(38),
    PRIMARY KEY (Hashtag, PostId),
    FOREIGN KEY (Hashtag) REFERENCES Hashtag(Hashtag),
    FOREIGN KEY (PostId) REFERENCES Post(PostId)
);

--------- Communicator ---------

CREATE TABLE Communicator (
    IdCommunicator NUMBER PRIMARY KEY,
    Specialisation VARCHAR2(128),
    Nickname VARCHAR2(26),
    FOREIGN KEY (IdCommunicator) REFERENCES Person(IdPerson),
    FOREIGN KEY (Nickname) REFERENCES User_db(Nickname)
);

--------- Image ---------

CREATE TABLE Image (
    ImageTitle VARCHAR2(128) PRIMARY KEY,
    Path VARCHAR2(128),
    Mime VARCHAR2(26)
);

---------- PostImage --------

CREATE TABLE PostImage (
    PostId NUMBER(38),
    ImageTitle VARCHAR2(128),
    PRIMARY KEY (PostId, ImageTitle),
    FOREIGN KEY (PostId) REFERENCES Post(PostId),
    FOREIGN KEY (ImageTitle) REFERENCES Image(ImageTitle)
);

--------- MediaGroup ---------

CREATE TABLE MediaGroup (
    NameOfMediaGroup VARCHAR2(26) PRIMARY KEY,
    DescriptionOfMediaGroup VARCHAR2(128),
    HeadquartersOfTheMediaGroup VARCHAR2(26)
);

--------- RadioStation ---------

CREATE TABLE RadioStation (
    NameOfTheRadioStation VARCHAR2(26) PRIMARY KEY,
    DescriptionOfTheRadioStation VARCHAR2(128),
    NameOfMediaGroup VARCHAR2(26),
    FOREIGN KEY (NameOfMediaGroup) REFERENCES MediaGroup(NameOfMediaGroup)
);

--------- TelevisionChannel --------

CREATE TABLE TelevisionChannel (
    TitleOfTheTvChannel VARCHAR2(26) PRIMARY KEY,
    VideoQualityOfTheTvChannel VARCHAR2(26),
    NameOfMediaGroup VARCHAR2(26),
    FOREIGN KEY (NameOfMediaGroup) REFERENCES MediaGroup(NameOfMediaGroup)
);

--------- Programme ---------

CREATE TABLE Programme (
    ProgrammeName VARCHAR2(128) PRIMARY KEY,
    Description VARCHAR2(128),
    Schedule VARCHAR2(26)    
);

--------- ProgrammeCommunicator ---------

CREATE TABLE ProgrammeCommunicator (
    IdCommunicator NUMBER,
    ProgrammeName VARCHAR2(128),
    FirstRole VARCHAR2(26),
    SecondRole VARCHAR2(26),
    PRIMARY KEY (IdCommunicator, ProgrammeName),
    FOREIGN KEY (IdCommunicator) REFERENCES Communicator(IdCommunicator),
    FOREIGN KEY (ProgrammeName) REFERENCES Programme(ProgrammeName)
);

--------- TelevisionProgramme ---------

CREATE TABLE TelevisionProgramme (
    TelevisionProgrammeName VARCHAR2(128) PRIMARY KEY,
    ProductionCompany VARCHAR2(128),
    TitleOfTheTvChannel VARCHAR2(26),
    Nickname VARCHAR2(128),
    FOREIGN KEY (TelevisionProgrammeName) REFERENCES Programme(ProgrammeName),
    FOREIGN KEY (TitleOfTheTvChannel) REFERENCES TelevisionChannel(TitleOfTheTvChannel),
    FOREIGN KEY (Nickname) REFERENCES User_db(Nickname)
);

--------- RadioProgramme ---------

CREATE TABLE RadioProgramme (
    RadioProgrammeName VARCHAR2(128) PRIMARY KEY,
    Podcast NUMBER(38),
    NameOfTheRadioStation VARCHAR2(26),
    Nickname VARCHAR2(128),
    FOREIGN KEY (RadioProgrammeName) REFERENCES Programme(ProgrammeName),
    FOREIGN KEY (NameOfTheRadioStation) REFERENCES RadioStation(NameOfTheRadioStation),
    FOREIGN KEY (Nickname) REFERENCES User_db(Nickname)
);




------------------------------
--   MERCHANDISING TABLES   --
------------------------------

--------- TypeProduct ---------

CREATE TABLE TypeProduct (
    TypeName VARCHAR2(128) PRIMARY KEY,
    TypeDescription VARCHAR2(128)
);

--------- Activity ---------

CREATE TABLE Activity (
    NameActivity VARCHAR2(128) PRIMARY KEY,
    ActivityDescription VARCHAR2(128)
);

--------- Product ---------

CREATE TABLE Product (
    NameProduct VARCHAR2(128) PRIMARY KEY,
    Cost NUMBER(38),
    Official VARCHAR2(26),
    Dimensions VARCHAR2(26),
    SpecialFeature VARCHAR2(26),
    TypeName VARCHAR2(128),
    NameActivity VARCHAR2(128),
    ClubName VARCHAR2(26),
    FOREIGN KEY (ClubName) REFERENCES Club(ClubName),
    FOREIGN KEY (TypeName) REFERENCES TypeProduct(TypeName),
    FOREIGN KEY (NameActivity) REFERENCES Activity(NameActivity)
);

--------- Accessory ---------

CREATE TABLE Accessory (
    NameAccessory VARCHAR2(128) PRIMARY KEY,
    Features VARCHAR2(128),
    FOREIGN KEY (NameAccessory) REFERENCES Product(NameProduct)
);


--------- Clothes ---------

CREATE TABLE Clothes (
    NameClothes VARCHAR2(128) PRIMARY KEY,
    Season VARCHAR2(26),
    Material VARCHAR2(26),
    FOREIGN KEY (NameClothes) REFERENCES Product(NameProduct)
);


--------- Shoe ---------

CREATE TABLE Shoe (
    NameShoe VARCHAR2(128) PRIMARY KEY,
    Usage VARCHAR2(26),
    Property VARCHAR2(26),
    Closure VARCHAR2(26),
    FOREIGN KEY (NameShoe) REFERENCES Product(NameProduct)
);


--------- Shop ---------
CREATE SEQUENCE ShopSeq
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE Shop (
    IdShop NUMBER(38) PRIMARY KEY,
    Name VARCHAR2(128),
    ShopDescription VARCHAR2(256),
    ClubName VARCHAR2(26),
    FOREIGN KEY (ClubName) REFERENCES Club(ClubName)
);

CREATE OR REPLACE TRIGGER Shop_BI
    BEFORE INSERT ON Shop
    FOR EACH ROW
BEGIN
    SELECT ShopSeq.NEXTVAL INTO :NEW.IdShop FROM DUAL;
END;
/
--------- Stores ---------
CREATE SEQUENCE StoresSeq
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE Stores (
    IdStores NUMBER(38) PRIMARY KEY,
    IdShop NUMBER(38),
    NameProduct VARCHAR2(128),
    Stock NUMBER(38),
    FOREIGN KEY (IdShop) REFERENCES Shop(IdShop),
    FOREIGN KEY (NameProduct) REFERENCES Product(NameProduct)
);

CREATE OR REPLACE TRIGGER Stores_BI
    BEFORE INSERT ON Stores
    FOR EACH ROW
BEGIN
    SELECT StoresSeq.NEXTVAL INTO :NEW.IdStores FROM DUAL;
END;
/

--------- CreditCard ---------

CREATE TABLE CreditCard (
    CreditCardNum VARCHAR2(128) PRIMARY KEY,
    CreditCardExpiry VARCHAR2(26),
    CreditCardProvider VARCHAR2(128)
);


--------- ShopKeeper ---------
CREATE TABLE ShopKeeper (
    IdShopKeeper NUMBER(38) PRIMARY KEY,
    VacationDays NUMBER(38),
    FOREIGN KEY (IdShopKeeper) REFERENCES Person(IdPerson)
);

--------- Manages ---------
CREATE SEQUENCE ManagesSeq
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE Manages (
     IdManages NUMBER (38) PRIMARY KEY,
     IdShop NUMBER(38),
     IdShopKeeper NUMBER(38),
     Role VARCHAR2(128),
     Shift VARCHAR2(26),
     FOREIGN KEY (IdShop) REFERENCES Shop(IdShop),
     FOREIGN KEY (IdShopKeeper) REFERENCES ShopKeeper(IdShopKeeper)
);

CREATE OR REPLACE TRIGGER Manages_BI
    BEFORE INSERT ON Manages
    FOR EACH ROW
BEGIN
    SELECT ManagesSeq.NEXTVAL INTO :NEW.IdManages FROM DUAL;
END;
/

--------- Purchase ---------
CREATE SEQUENCE PurchaseSeq
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE Purchase (
    IdPurchase NUMBER(38) PRIMARY KEY,
    IdShop NUMBER(38),
    PurchaseDate VARCHAR2(26),
    NameProduct VARCHAR2(128),
    Units NUMBER(38),
    Discount VARCHAR2(26),
    TotalCost NUMBER(38,2),
    IdCard VARCHAR2(128),
    FOREIGN KEY (IdShop) REFERENCES Shop(IdShop),
    FOREIGN KEY (IdCard) REFERENCES CreditCard(CreditCardNum),
    FOREIGN KEY (NameProduct) REFERENCES Product(NameProduct)
);

CREATE OR REPLACE TRIGGER Purchase_BI
    BEFORE INSERT ON Purchase
    FOR EACH ROW
BEGIN
    SELECT PurchaseSeq.NEXTVAL INTO :NEW.IdPurchase FROM DUAL;
END;
/

------------------------------------------------------------------------


--------------------------
--   PUBLICITY TABLES   --
--------------------------

--------- Categories ---------

CREATE TABLE Categories (
    Category_Name VARCHAR2(128) PRIMARY KEY,
    Description CLOB
);

--------- Subcategories ---------

CREATE TABLE Subcategories (
    Category1_name VARCHAR2(128),
    Category2_name VARCHAR2(128),
    Category3_name VARCHAR2(128),
    PRIMARY KEY (Category1_name, Category2_name, Category3_name),
    FOREIGN KEY (Category1_name) REFERENCES Categories(Category_Name),
    FOREIGN KEY (Category2_name) REFERENCES Categories(Category_Name),
    FOREIGN KEY (Category3_name) REFERENCES Categories(Category_Name)
);


--------- Client ---------

CREATE TABLE Client (
    Client_Name VARCHAR2(128) PRIMARY KEY,
    Client_Budget NUMBER,
    Id_City NUMBER,
    FOREIGN KEY (Id_City) REFERENCES City(IdCity)
);

--------- Campaign ---------

CREATE TABLE Campaign (
    Id_Campaign VARCHAR2(126) PRIMARY KEY,
    Campaign_name VARCHAR2(128),
    Objective VARCHAR2(255),
    Budget DECIMAL(10, 2),
    Start_date DATE,
    End_date DATE,
    Audience_Interest VARCHAR2(255),
    Audience_Segment VARCHAR2(255),
    Client_name VARCHAR2(128),
    FOREIGN KEY (Client_name) REFERENCES Client(Client_name)
);

------- ProductCampaign -------
CREATE TABLE ProductCampaign(
    Id_Campaign VARCHAR2(128),
    NameProduct VARCHAR2(128),
    PRIMARY KEY (Id_Campaign, NameProduct),
    FOREIGN KEY (Id_Campaign) REFERENCES Campaign(Id_Campaign),
    FOREIGN KEY (NameProduct) REFERENCES Product(NameProduct)
);

--------- PlacementType ---------

CREATE TABLE PlacementType (
    Id_PlacementType VARCHAR2(50) PRIMARY KEY,
    Type_description VARCHAR2(255)
);

--------- Placement ---------

CREATE SEQUENCE PlacementSeq
  START WITH 1
  INCREMENT BY 1;

CREATE TABLE Placement (
    IdPlacement NUMBER PRIMARY KEY,
    ExclusiveType NUMBER(1),
    IdPlacementType VARCHAR2(50),
    IdPost NUMBER,
    FOREIGN KEY (IdPlacementType) REFERENCES PlacementType(Id_PlacementType),
    FOREIGN KEY (IdPost) REFERENCES post(postId)
);

CREATE OR REPLACE TRIGGER Placement_BI
BEFORE INSERT ON Placement
FOR EACH ROW
BEGIN
  SELECT PlacementSeq.NEXTVAL INTO :NEW.IdPlacement FROM DUAL;
END;
/


--------- Ad ---------

CREATE TABLE Ad (
    NumAd NUMBER PRIMARY KEY,
    Title VARCHAR2(255),
    Description VARCHAR2(256),
    Format VARCHAR2(50),
    Status VARCHAR2(50),
    AdDate DATE,
    Id_Campaign VARCHAR2(128),
    IdPlacement NUMBER,
    cost NUMBER,
    FOREIGN KEY (Id_Campaign) REFERENCES Campaign(Id_Campaign),
    FOREIGN KEY (IdPlacement) REFERENCES placement(IdPlacement)
    
);

--------- adPlacement ---------

CREATE TABLE adPlacement (
    NumAd NUMBER,
    IdPlacement NUMBER,
    Cost DECIMAL(10, 2),
    PlacementDate DATE,
    PRIMARY KEY (NumAd, IdPlacement),
    FOREIGN KEY (NumAd) REFERENCES Ad(NumAd),
    FOREIGN KEY (IdPlacement) REFERENCES Placement(IdPlacement)
);

--------- categoryAd ---------

CREATE TABLE categoryAd (
    NumAd NUMBER,
    Category_Name VARCHAR2(128),
    PRIMARY KEY (NumAd, Category_Name),
    FOREIGN KEY (NumAd) REFERENCES Ad(NumAd),
    FOREIGN KEY (Category_Name) REFERENCES Categories(Category_Name)
);


--------- PlacementProgramme ---------

CREATE TABLE ProgrammePlacement (
    ProgrammeName VARCHAR2(50),
    IdPlacement NUMBER,
    PRIMARY KEY (ProgrammeName, IdPlacement),
    FOREIGN KEY (ProgrammeName) REFERENCES Programme(ProgrammeName),
    FOREIGN KEY (IdPlacement) REFERENCES Placement(IdPlacement)
);

--------- PlacementPost ---------

CREATE TABLE PlacementPost (
    PostId NUMBER,
    IdPlacement NUMBER,
    PRIMARY KEY (PostId, IdPlacement),
    FOREIGN KEY (PostId) REFERENCES Post(PostId),
    FOREIGN KEY (IdPlacement) REFERENCES Placement(IdPlacement)
); 


--------- PlacementStadium ---------

CREATE TABLE PlacementStadium (
    StadiumName VARCHAR2(128),
    IdPlacement NUMBER,
    PRIMARY KEY (StadiumName, IdPlacement),
    FOREIGN KEY (StadiumName) REFERENCES Stadium(StadiumName),
    FOREIGN KEY (IdPlacement) REFERENCES Placement(IdPlacement)
); 


--------- PlacementShop ---------

CREATE TABLE PlacementShop (
    IdShop NUMBER(38),
    IdPlacement NUMBER,
    PRIMARY KEY (IdShop, IdPlacement),
    FOREIGN KEY (IdShop) REFERENCES Shop(IdShop),
    FOREIGN KEY (IdPlacement) REFERENCES Placement(IdPlacement)
);
