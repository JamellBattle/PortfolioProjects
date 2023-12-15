--Creating the DBFZ database for the project and use it
CREATE DATABASE Dbfz
USE Dbfz

--Creating a table of players, only poopulating the Player Name column
CREATE TABLE CharacterUsage (
	PlayerID			int IDENTITY (1, 1)   PRIMARY KEY,
	PlayerName			nvarchar(50),
	PlatformType		nvarchar(50),
	Region				nvarchar(50),
	MostUsedCharacter	nvarchar(50),

)



INSERT INTO CharacterUsage (PlayerName)

VALUES  ('2cutech'),
		('Ashlffy'),
		('Buyner'),
		('Crayonme'),
		('GroupRomance'),
		('Martic'),
		('Number1Ash'),
		('Proment'),
		('StargalTrimble'),
		('Tinnysis'),
		('Adoberg'),
		('Banffar'),
		('Clampet'),
		('EverCrossed'),
		('Heavency'),
		('Micropa'),
		('Omronne'),
		('SkateMud'),
		('Steinka'),
		('Welbauer'),
		('Anteper'),
		('BlazeCheese'),
		('Clotos'),
		('Forlifepi'),
		('HopeIssue'),
		('Nonline'),
		('Polynd'),
		('SonWar'),
		('StoneLove'),
		('Zetale'),
		('Bazaard'),
		('FunkyDiddy'),
		('Hearter'),
		('Marsuer'),
		('NateDemon'),
		('Poetso'),
		('Sumoka'),
		('TalentSporty'),
		('TrumpLogic'),
		('Youngan'),
		('Biggen'),
		('Glamourer'),
		('Kixre'),
		('Mewcu'),
		('Oasysro'),
		('Sendbush'),
		('SuperJr'),
		('Terrificag'),
		('Whitere'),
		('Youngwo'),
		('Combohl'),
		('GroupSporks'),
		('Kuehlon'),
		('MoonLive'),
		('Offerspen'),
		('Skaterso'),
		('TalentGal'),
		('Tickort'),
		('WomanFerdy'),
		('Zerpse'),
		('Armappie'),
		('BobMafia'),
		('BytePersonal'),
		('Defiqhte'),
		('Maryleon'),
		('Mobilanit'),
		('Nipterr'),
		('Relayered'),
		('Shovar'),
		('Speciatism'),
		('Bachee'),
		('Bobocape'),
		('Comerican'),
		('DollOne'),
		('Mathymax'),
		('Montentho'),
		('PlanetChampion'),
		('Sakirmec'),
		('SimplyArsenal'),
		('TaraRoses'),
		('Blueyewor'),
		('Booknes'),
		('CommentsTopic'),
		('LogDev'),
		('Mccaua'),
		('Navionum'),
		('Quillient'),
		('Selfgile'),
		('SparkFeatured'),
		('TinNess'),
		('Artsqedli'),
		('BookGuy'),
		('Ceivanix'),
		('Communiquest'),
		('Determed'),
		('GazerSly'),
		('Hockeyha'),
		('Oscorpst'),
		('ReePink'),
		('Surmune'),
		('Axisplai'),
		('Broolzer'),
		('CleverHello'),
		('Cyberie'),
		('EditGurl'),
		('Goas'),
		('Mediumby'),
		('Overcod'),
		('Remlogni'),
		('SweetieUn'),
		('Berganti'),
		('Campyre'),
		('Commulter'),
		('DancerMonkey'),
		('Freeng'),
		('HipurCuroius'),
		('Myhreen'),
		('PeachWithpain'),
		('SunsetYellow'),
		('ThegaBing')

-- Creating a procedure that uses the random generator functions created in the DbfzCharacterGenerator.sql file
-- To populate the other columns of the character usage table
CREATE PROCEDURE usp_populateTable 
AS
BEGIN
	DECLARE @playerCount int
	SET @playerCount = 1
	-- Repeat this process until playerCount reaches the total # of playerIDs (meaning it has reached all of them)
	WHILE @playerCount <= (SELECT COUNT(PlayerID) FROM CharacterUsage)
	BEGIN
		--Create a characterName variable and get the name using the random character function
		DECLARE @characterName nvarchar(50)
		SELECT @characterName = dbo.GenerateRandomCharacter()

		--Create a platformName variable and get the name using the random gaming platform function
		DECLARE @platformName nvarchar(50)
		SELECT @platformName = dbo.GenerateRandomGamingPlatform()

		--Create a regionName variable and get the region using the random character function
		DECLARE @regionName nvarchar(50)
		SELECT @regionName = dbo.GenerateRandomRegion()

		-- Insert the values we just randomly generated into their respective columns 
		-- in the row corresponding with the playerID of our main table
		UPDATE CharacterUsage
		SET PlatformType = @platformName,
			MostUsedCharacter = @characterName,
			Region = @regionName
		WHERE PlayerID = @playerCount

		-- Increment the playerID by 1 and repeat 
		SET @playerCount = @playerCount + 1
	END
END

EXECUTE usp_populateTable

SELECT * FROM CharacterUsage
WHERE PlatformType = 'Pro Player'








