USE PortfolioProject

--The different tables that will be used for the Data Exploration
SELECT * 
FROM TopGrossingRankings$
WHERE Year = 2021

SELECT *
FROM MonthlyBanners$

SELECT * 
FROM BannerRateUps$

--Creating a temp table to put the Monthly Banners together with their Rate-Up information
--in order to make all the information more quickly accessible

CREATE TABLE #BannerInfo(
Banner varchar(50),
BannerMonth varchar(50),
BannerYear int,
BannerServants varchar(200),
LimitedServants int,
HasNewServant varchar(1),
NewServants int
)

INSERT INTO #BannerInfo
SELECT BannerRateUps$.Banner, MonthlyBanners$.[Month], MonthlyBanners$.[Year], 
BannerRateUps$.RateUpServants, BannerRateUps$.LimitedServants, BannerRateUps$.[NewServant?], BannerRateUps$.NewServants
FROM BannerRateUps$
INNER JOIN MonthlyBanners$
ON BannerRateUps$.Banner = MonthlyBanners$.Banner

SELECT * 
FROM #BannerInfo

--Looking at how many new servants released in 2021
Select SUM(NewServants)
From #BannerInfo

-- Looking at which banners had new servants, and how many they had

Select Banner, NewServants, BannerMonth, BannerYear
FROM #BannerInfo
WHERE HasNewServant = 'Y'

-- Going off of the previous query, looking at how many new servants released each month in 2021. Which had the most, which had the least
Select BannerMonth, SUM(NewServants) AS NewServants
From #BannerInfo
WHERE BannerYear = 2021
GROUP BY BannerMonth
ORDER BY NewServants DESC

--Similarly, looking at how many limited-time servants were featured each month. Which had the most, which had the least
Select BannerMonth, SUM(LimitedServants) AS LimitedServants
From #BannerInfo
WHERE BannerYear = 2021
GROUP BY BannerMonth
ORDER BY LimitedServants DESC

-- Limited Servants vs. New Servants for each month
Select BannerMonth, SUM(LimitedServants) AS LimitedServants, SUM(NewServants) AS NewServants
From #BannerInfo
WHERE BannerYear = 2021
GROUP BY BannerMonth
ORDER BY BannerMonth

-- Looking at which months Fate/Grand Order was within top 15 in Top Grossing charts in 2021
-- Worldwide, across all app stores. Will be exploring the BannerInfo table again based on this information

SELECT [Top Grossing Ranking], Month, Year
FROM TopGrossingRankings$
WHERE [Top Grossing Ranking] <= 15 AND Year = 2021

-- Using the previous query, looking at what banners released within the months where Fate/Grand Order
-- was within top 15 in Top grossing, and creating another temp table based off of that information
-- in order to look into it further

CREATE TABLE #Top15MonthBanners(
Banner varchar(50),
BannerMonth varchar(50),
BannerYear int,
BannerServants varchar(200),
LimitedServants int,
HasNewServant varchar(1),
NewServants int
)

INSERT INTO #Top15MonthBanners
SELECT *
FROM #BannerInfo
WHERE BannerMonth in
(
SELECT Month
FROM TopGrossingRankings$
WHERE [Top Grossing Ranking] <= 15 AND Year = 2021
)

SELECT *
FROM #Top15MonthBanners

-- Each Top 15 Month's Grossing Ranking vs. Number of Limited Servants and New Servants released in those months

SELECT BannerMonth, TopGrossingRankings$.[Top Grossing Ranking], SUM(LimitedServants) AS LimitedServants, SUM(NewServants) AS NewServants
FROM #Top15MonthBanners
INNER JOIN TopGrossingRankings$
ON #Top15MonthBanners.BannerMonth = TopGrossingRankings$.Month AND #Top15MonthBanners.BannerYear = TopGrossingRankings$.Year
GROUP BY BannerMonth, TopGrossingRankings$.[Top Grossing Ranking]
ORDER BY TopGrossingRankings$.[Top Grossing Ranking]















