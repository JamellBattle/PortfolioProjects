

CREATE FUNCTION dbo.GenerateRandomCharacter() RETURNS NVARCHAR(50)
BEGIN
-- Create table variable to hold a list of character names
DECLARE @characterNames TABLE (
		characterName nvarchar(50)
)
INSERT INTO @characterNames
VALUES 
	('Goku (Ultra Instinct)'),
	('Kefla'),
	('Master Roshi'),
	('Gogeta (SSGSS)'),
	('Goku'),
	('Tien'),
	('Yamcha'),
	('Krillin'),
	('Goku (Super Saiyan)'),
	('Frieza'),
	('Kid Buu'),
	('Captain Ginyu'),
	('Nappa'),
	('Vegeta'),
	('Broly (DBS)'),
	('Goku (GT)'),
	('Android 17'),
	('Bardock'),
	('Goku (SSGSS)'),
	('Gohan'),
	('Trunks'),
	('Vegeta (Super Saiyan)'),
	('Cell'),
	('Android 18'),
	('Android 16'),
	('Android 21'),
	('Broly'),
	('Cooler'),
	('Janemba'),
	('Videl'),
	('Vegito (SSGSS)'),
	('Vegeta (SSGSS)'),
	('Gotenks'),
	('Piccolo'),
	('Gohan (Teen)'),
	('Majin Buu'),
	('Beerus'),
	('Hit'),
	('Goku Black'),
	('Fused Zamasu'),
	('Jiren'),
	('Super Baby 2'),
	('Gogeta (SS4)')

	DECLARE @returnName nvarchar(50)
	-- Generating a random number to be used with the table
	-- using the function I created
	DECLARE @randomValue int
	SELECT @randomValue = dbo.getrandomnumberbetweentwoints(1, 42)
	-- To get a random character, go through the characterName Table  
	-- and get the row whose rowNumber matches our random number, 
	-- then take whatever name is in that row
	SELECT @returnName = characterName
	FROM	
		(SELECT *, ROW_NUMBER() OVER (ORDER BY characterName) RowNum
		 FROM @characterNames) randomName
	WHERE randomName.RowNum = @randomValue
	RETURN @returnName
END

SELECT dbo.GenerateRandomCharacter()

-- This function returns a random gaming platform. it works the same
-- as the random character function, just using a different table
CREATE FUNCTION dbo.GenerateRandomGamingPlatform() RETURNS NVARCHAR(50)
BEGIN
DECLARE @gamingPlatforms TABLE (
		gamingPlatform nvarchar(50)
)
INSERT INTO @gamingPlatforms
VALUES 
	('PlayStation'),
	('Xbox'),
	('Nintendo Switch'),
	('PC'),
	('Pro Player')

	DECLARE @returnPlatform nvarchar(50)
	DECLARE @randomValue int
	SELECT @randomValue = dbo.getrandomnumberbetweentwoints(1, 5)
	SELECT @returnPlatform = gamingPlatform
	FROM	
		(SELECT *, ROW_NUMBER() OVER (ORDER BY gamingPlatform) RowNum
		 FROM @gamingPlatforms) randomPlatform
	WHERE randomPlatform.RowNum = @randomValue
	RETURN @returnPlatform
END

-- This function returns a random region. It works the same
-- as the random character function, just using a different table
ALTER FUNCTION GenerateRandomRegion() RETURNS NVARCHAR(50)
BEGIN

DECLARE @playerRegions TABLE (
		playerRegion nvarchar(50)
)
INSERT INTO @playerRegions
VALUES 
	('North America'),
	('South America'),
	('Europe'),
	('Australia and Oceania'),
	('Asia')

	DECLARE @returnRegion nvarchar(50)
	DECLARE @randomValue int
	SELECT @randomValue = dbo.getrandomnumberbetweentwoints(1, 5)
	SELECT @returnRegion = playerRegion
	FROM	
		(SELECT *, ROW_NUMBER() OVER (ORDER BY playerRegion) RowNum
		 FROM @playerRegions) randomRegion
	WHERE randomRegion.RowNum = @randomValue
-- Randomly pick a first name from the table
-- Generate a random number
	RETURN @returnRegion
END

SELECT dbo.GenerateRandomCharacter(), 
	dbo.GenerateRandomGamingPlatform(),
	dbo.generateRandomRegion()

