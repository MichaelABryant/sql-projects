-- -- Display all tables

-- Cases information
SELECT *
FROM CovidCases


-- Deaths information
SELECT *
FROM CovidDeaths


-- Country, demographics information
SELECT *
FROM CovidDemo


-- ICU and hospitalization information
SELECT *
FROM CovidMedical


-- Testing information
SELECT *
FROM CovidTests


-- Vaccination information
SELECT *
FROM CovidVacc


-- -- World dashboard

-- Total population by country
SELECT demo.location, MAX(CAST(demo.population AS BIGINT)) AS population
FROM COVID19_Project..CovidDemo demo
WHERE demo.continent IS NOT NULL
GROUP BY demo.location
ORDER BY 2 desc


-- Create view for query of total vaccinated by country
CREATE VIEW [Country population] AS
SELECT demo.location, MAX(CAST(demo.population AS BIGINT)) AS population
FROM COVID19_Project..CovidDemo demo
WHERE demo.continent IS NOT NULL
GROUP BY demo.location


-- Total cases by country
SELECT cases.location, MAX(CAST(cases.total_cases AS BIGINT)) AS total_cases
FROM COVID19_Project..CovidCases cases
WHERE cases.continent IS NOT NULL
GROUP BY cases.location
ORDER BY 2 desc


-- Create view for query of total cases by country
CREATE VIEW [Country total_cases] AS
SELECT cases.location, MAX(CAST(cases.total_cases AS BIGINT)) AS total_cases
FROM COVID19_Project..CovidCases cases
WHERE cases.continent IS NOT NULL
GROUP BY cases.location


-- Total deaths by country
SELECT deaths.location, MAX(CAST(deaths.total_deaths AS BIGINT)) AS total_deaths
FROM COVID19_Project..CovidDeaths deaths
WHERE deaths.continent IS NOT NULL
GROUP BY deaths.location
ORDER BY 2 desc


-- Create view for query of total deaths by country
CREATE VIEW [Country total_deaths] AS
SELECT deaths.location, MAX(CAST(deaths.total_deaths AS BIGINT)) AS total_deaths
FROM COVID19_Project..CovidDeaths deaths
WHERE deaths.continent IS NOT NULL
GROUP BY deaths.location


-- Total people vaccinated by country
SELECT vacc.location, MAX(CAST(vacc.people_vaccinated AS BIGINT)) AS total_vaccinated
FROM COVID19_Project..CovidVacc vacc
WHERE vacc.continent IS NOT NULL
GROUP BY vacc.location
ORDER BY 2 desc


-- Create view for query of total vaccinated by country
CREATE VIEW [Country total_vaccinated] AS
SELECT vacc.location, MAX(CAST(vacc.people_vaccinated AS BIGINT)) AS total_vaccinated
FROM COVID19_Project..CovidVacc vacc
WHERE vacc.continent IS NOT NULL
GROUP BY vacc.location


-- Country-continent key
SELECT DISTINCT cases.location, cases.continent
FROM COVID19_Project..CovidCases cases
WHERE continent IS NOT NULL
ORDER BY cases.location asc


-- Create view for query of total cases by country
CREATE VIEW [Country continent] AS
SELECT DISTINCT cases.location, cases.continent
FROM COVID19_Project..CovidCases cases
WHERE continent IS NOT NULL


-- Join two views for location, continent, total_cases table
SELECT 	[Country continent].continent,
	[Country continent].location,
	[Country population].population,
	[Country total_cases].total_cases,
	[Country total_deaths].total_deaths,
	[Country total_vaccinated].total_vaccinated
FROM [Country continent]
JOIN [Country population]
	ON [Country continent].location = [Country population].location
JOIN [Country total_cases]
	ON [Country population].location = [Country total_cases].location
JOIN [Country total_deaths]
	ON [Country total_cases].location = [Country total_deaths].location
JOIN [Country total_vaccinated]
	ON [Country total_deaths].location = [Country total_vaccinated].location
WHERE total_cases IS NOT NULL
	AND total_deaths IS NOT NULL
	AND total_vaccinated IS NOT NULL


-- Total cases, deaths, and vaccinated people by continent (summary worldwide)
SELECT [Country continent].continent,
	SUM([Country population].population) AS population,
	SUM([Country total_cases].total_cases) AS total_cases,
	SUM([Country total_deaths].total_deaths) AS total_deaths,
	SUM([Country total_vaccinated].total_vaccinated) AS total_vaccinated
FROM [Country continent]
JOIN [Country population]
	ON [Country continent].location = [Country population].location
JOIN [Country total_cases]
	ON [Country population].location = [Country total_cases].location
JOIN [Country total_deaths]
	ON [Country total_cases].location = [Country total_deaths].location
JOIN [Country total_vaccinated]
	ON [Country total_deaths].location = [Country total_vaccinated].location
WHERE total_cases IS NOT NULL
	AND total_deaths IS NOT NULL
	AND total_vaccinated IS NOT NULL
GROUP BY [Country continent].continent
ORDER BY continent asc


-- Top current new_cases_per_million by country (where covid is increasing the most)
SELECT cases.location, CONVERT(float,cases.new_cases_per_million) AS new_cases_per_million
FROM COVID19_Project..CovidCases cases
WHERE cases.continent IS NOT NULL
	AND cases.date = '7/31/2021'
ORDER BY 2 desc


-- Total_deaths_per_million by country (most deaths per capita)
SELECT deaths.location, CONVERT(float,deaths.total_deaths_per_million) AS total_deaths_per_million
FROM COVID19_Project..CovidDeaths deaths
WHERE deaths.continent IS NOT NULL
	AND deaths.date = '7/31/2021'
ORDER BY 2 desc


-- stringency index (measure of response indicators from 0 to 100 of the strictest sub-region of the country)
SELECT vacc.location, CONVERT(float,vacc.people_fully_vaccinated_per_hundred) AS people_fully_vaccinated_per_hundred
FROM COVID19_Project..CovidVacc vacc
WHERE vacc.continent IS NOT NULL
	AND vacc.date = '7/30/2021'
	AND people_fully_vaccinated_per_hundred IS NOT NULL
ORDER BY 2 desc


-- -- US dashboard

-- US population, cases, deaths, and vaccinated
SELECT cases.date, cases.location, demo.population, cases.total_cases, deaths.total_deaths, vacc.people_vaccinated
FROM COVID19_Project..CovidCases cases
JOIN COVID19_Project..CovidDemo demo
	ON cases.location = demo.location
JOIN COVID19_Project..CovidDeaths deaths
	ON demo.location = deaths.location
JOIN COVID19_Project..CovidVacc vacc
	ON deaths.location = vacc.location
WHERE cases.location = 'United States'
	AND cases.date = '7/31/2021'
	AND demo.date = '7/31/2021'
	AND deaths.date = '7/31/2021'
	AND vacc.date = '7/31/2021'
	AND cases.total_cases IS NOT NULL

-- Total vaccinations starting with first date in the US VIEW
CREATE VIEW [USvacc] AS
SELECT vacc.date, vacc.total_vaccinations
FROM COVID19_Project..CovidVacc vacc
WHERE location = 'United States'
	AND vacc.date >= '1/5/2021'

-- US hospitalized (as a function of time) VIEW
CREATE VIEW [USpatients] AS
SELECT med.date, med.hosp_patients, med.icu_patients, CONVERT(int,med.hosp_patients) + CONVERT(int,med.icu_patients) AS total_patients
FROM COVID19_Project..CovidMedical med
WHERE location = 'United States'
	AND med.date >= '1/5/2021'

-- US (number of people hospitalizated + as ICU patients) and number of people_vaccinated as a function of time (time-series graph)
SELECT [USvacc].date, [USvacc].total_vaccinations, [USpatients].total_patients
FROM [USvacc]
JOIN [USpatients]
	ON [USvacc].date = [USpatients].date


-- US positive_rate as a function of time
SELECT tests.date, tests.positive_rate
FROM COVID19_Project..CovidTests tests
WHERE location = 'United States'
	AND positive_rate IS NOT NULL


-- Percent vaccinated in US (pie chart)
SELECT vacc.date, vacc.location, demo.population, vacc.people_vaccinated AS people_with_at_least_one_vaccine, vacc.people_fully_vaccinated,
	((CONVERT(int,vacc.people_vaccinated) - CONVERT(int,vacc.people_fully_vaccinated))/(demo.population))*100 AS percentage_with_one_vaccine_only,
	(CONVERT(int,vacc.people_fully_vaccinated)/(demo.population))*100 AS percentage_fully_vaccinated,
	(1-(CONVERT(int,vacc.people_vaccinated)/(demo.population)))*100 AS percentage_with_no_vaccine
FROM COVID19_Project..CovidVacc vacc
JOIN COVID19_Project..CovidDemo demo
	ON vacc.location = demo.location
WHERE vacc.location = 'United States'
	AND vacc.date = '7/31/2021'
	AND demo.date = '7/31/2021'
