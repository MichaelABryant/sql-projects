-- Display full table
SELECT *
FROM astronauts$;

-- Averages of year, space flights, and space walks
SELECT ROUND(AVG(Year),0) AS AVG_YEAR, ROUND(AVG([Space Flights]),2) AS AVG_FLIGHTS , ROUND(AVG("Space Flight (hr)"),2) AS AVG_FLIGHT_HRS, ROUND(AVG("Space Walks"),2) AS AVG_WALKS, ROUND(AVG("Space Walks (hr)"),2) AS AVG_WALK_HRS
FROM astronauts$;

-- Minimums of year, space flights, and space walks
SELECT MIN(Year) AS FIRST_YEAR, MIN([Space Flights]) AS LEAST_FLIGHTS , MIN("Space Flight (hr)") AS LEAST_FLIGHT_HRS, MIN("Space Walks") AS LEAST_WALKS, MIN("Space Walks (hr)") AS LEAST_WALK_HRS
FROM astronauts$;

-- Maximums of year, space flights, and space walks
SELECT MAX(Year) AS MOST_RECENT_YEAR, MAX([Space Flights]) AS MOST_FLIGHTS , MAX("Space Flight (hr)") AS MOST_FLIGHT_HRS, MAX("Space Walks") AS MOST_WALKS, MAX("Space Walks (hr)") AS MOST_WALK_HRS
FROM astronauts$;

-- Number of male and female astronauts
SELECT Gender, COUNT(*) AS Count
FROM astronauts$
GROUP BY Gender;

-- Number of astronauts by undergraduate major
SELECT [Undergraduate Major], COUNT(*) AS Count
FROM astronauts$
GROUP BY [Undergraduate Major]
ORDER BY Count DESC;

-- Number of astronauts by graduate major
SELECT [Graduate Major], COUNT(*) AS Count
FROM astronauts$
GROUP BY [Graduate Major]
ORDER BY Count DESC;

-- Number of astronauts by military branch
SELECT [Military Branch], COUNT(*) AS Count
FROM astronauts$
GROUP BY [Military Branch]
ORDER BY Count DESC;

-- Number of astronauts by military rank
SELECT [Military Rank], COUNT(*) AS Count
FROM astronauts$
GROUP BY [Military Rank]
ORDER BY Count DESC;

-- Number of astronauts by death mission
SELECT [Death Mission], COUNT(*) AS Count
FROM astronauts$
GROUP BY [Death Mission]
ORDER BY Count DESC;

-- All astronauts with more than 4 flights
SELECT [Group], ROUND(AVG([Space Flights]),0) AS AVG_FLIGHTS
FROM astronauts$
GROUP BY [Group]
HAVING AVG([Space Flights]) > 4
ORDER BY [Group]

-- All groups with either more than 2 flights and more than 1 walk or more than 3 flights
SELECT [Group], ROUND(AVG([Space Flights]),0) AS AVG_FLIGHTS, ROUND(AVG([Space Walks]),0) AS AVG_WALKS
FROM astronauts$
GROUP BY [Group]
HAVING AVG([Space Flights]) > 2
	AND AVG([Space Walks]) > 1
	OR AVG([Space Flights]) > 3
ORDER BY [Group]

-- Space flights per year
SELECT Year, COUNT([Space Flights])
FROM astronauts$
GROUP BY Year;

-- Check data types of each column
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS;

-- Astronaut status by age
SELECT YEAR([Birth Date]) AS BIRTH_YEAR, Status, COUNT(Status) AS STATUS_COUNT
FROM astronauts$
GROUP BY Year([Birth Date]), Status
ORDER BY Year([Birth Date]);

-- Total space walk hours by group in descending order
SELECT [Group], SUM([Space Walks (hr)]) AS 'TOTAL_WALK_HRS'
FROM astronauts$
WHERE [Group] IS NOT NULL
GROUP BY [Group]
ORDER BY 'TOTAL_WALK_HRS' DESC;

-- Create a view to categorize people into physics and non-physics majors with a count
CREATE VIEW [physics_undergrad] AS
SELECT COUNT([Undergraduate Major]) AS COUNTS,
CASE
	WHEN [Undergraduate Major] = 'Physics' THEN 'Physics'
	WHEN [Undergraduate Major] = 'Mathematics & Physics' THEN 'Physics'
	ELSE 'Non-physics'
END AS 'Physics Undergrad'
FROM astronauts$
GROUP BY [Undergraduate Major];

-- Group the physics majors together and perform a summation on the counts using the view
SELECT [Physics Undergrad], SUM(COUNTS) AS Counts
FROM [physics_undergrad]
GROUP BY [Physics Undergrad]