ALTER FUNCTION GetRandomSeedValue() RETURNS INT
BEGIN
DECLARE @mySeedValue int
-- When seeting a variable as a query, just use select, don't use set =
SELECT @mySeedValue = cast(cast(datepart(DAY, getdate()) as varchar(2)) +
		cast(datepart(HOUR, getdate()) as varchar(2)) +
		cast(datepart(SECOND, getdate()) as varchar(2)) +
		cast(datepart(MONTH, getdate()) as varchar(2)) +
		cast(datepart(MILLISECOND, getdate()) as varchar(3)) as int)
RETURN @mySeedValue
END

SELECT dbo.GetRandomSeedValue()

--A view looks like it's a table but it's just executing code, actually a script
ALTER VIEW GetRandomNumber
AS
	  SELECT CHECKSUM(NEWID()) as RandomNumber
	--SELECT RAND(dbo.GetRandomSeedValue()) as RandomNumber



-- a function that can get a random number from within a user-input range
ALTER FUNCTION dbo.GetRandomNumberBetweenTwoInts(@lowerInt int, @upperInt int)
RETURNS INT
BEGIN
-- If user passes in the wrong order, flip it for them
	IF @lowerInt > @upperInt
	BEGIN
		DECLARE @tempInt int
		SET @tempInt = @lowerInt
		SET @lowerInt = @upperInt
		SET @upperInt = @lowerInt
	END
	--Creating the random number vairable and using the GetRandomNumberView in a math operation to generate the random number 
	DECLARE @Random INT;
	SELECT @Random = ABS((SELECT * FROM GetRandomNumber) % (@upperInt - @lowerInt- 1)) + @lowerInt
	RETURN @Random
END

SELECT dbo.GetRandomNumberBetweenTwoInts(1, 42)

/*select  getdate(),
		datepart(MONTH, getdate()),
		datepart(DAY, getdate()),
		datepart(HOUR, getdate()),
		datepart(SECOND, getdate()),
		datepart(MILLISECOND, getdate()),
		cast(datepart(MONTH, getdate()) as varchar(2)) +
		cast(datepart(DAY, getdate()) as varchar(2)) +
		cast(datepart(HOUR, getdate()) as varchar(2)) +
		cast(datepart(SECOND, getdate()) as varchar(2)) +
		cast(datepart(MILLISECOND, getdate()) as varchar(3)) */
		