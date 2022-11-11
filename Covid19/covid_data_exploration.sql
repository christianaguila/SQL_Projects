-- See data
SELECT TOP(20) *
FROM CovidDeaths

SELECT continent, location, date, total_cases
FROM CovidDeaths

-- Number of total cases per continent
WITH total_cases_data(continent, location, total_cases) AS (
	SELECT continent, location, MAX(total_cases) AS total_cases
	FROM CovidDeaths
	WHERE continent IS NOT NULL
	GROUP BY continent, location
)
SELECT continent,SUM(total_cases) AS total_cases
FROM total_cases_data
GROUP BY continent


-- Total Cases globally
WITH total_cases_data(continent, location, total_cases) AS (
	SELECT continent, location, MAX(total_cases) AS total_cases
	FROM CovidDeaths
	WHERE continent IS NOT NULL
	GROUP BY continent, location
)
SELECT SUM(total_cases) AS total_cases_globally
FROM total_cases_data



-- Checking if the total_cases presented in NULL continent is the same as the total_cases from summation of total_cases of all continents
SELECT continent, MAX(total_cases) AS total_cases
FROM CovidDeaths
WHERE continent IS NULL
GROUP BY continent

-- They are roughly equal. Hence, NULL continent will not be included in future queries



-- See rolling cases in order
SELECT continent, location, date, new_cases, total_cases 
FROM CovidDeaths
WHERE location = 'philippines'
ORDER BY 2, 3

-- See rolling deaths in Philippines
SELECT location, date, new_deaths, total_deaths
FROM CovidDeaths
WHERE location = 'philippines'
ORDER BY 2



SELECT d.location, d.date, v.new_vaccinations, v.total_vaccinations, v.people_vaccinated
FROM CovidDeaths AS d 
	JOIN CovidVaccinations AS v 
	ON d.location = v.location AND
	d.date = v.date
ORDER BY 1, 2


SELECT *
FROM CovidDeaths AS d 
	JOIN CovidVaccinations AS v 
	ON d.location = v.location 
	AND d.date = v.date 
WHERE d.continent IS NOT NULL
ORDER BY d.continent, d.location, d.date


SELECT d.continent, d.location, d.date, d.population, v.total_vaccinations, v.people_vaccinated, v.new_tests, v.total_tests, v.new_vaccinations,
	d.new_cases, d.total_cases, d.new_deaths, d.total_deaths
FROM CovidDeaths AS d 
	JOIN CovidVaccinations AS v 
	ON d.date = v.date AND
	d.location = v.location
WHERE d.continent IS NOT NULL AND d.location = 'United States'
ORDER BY 2, 3
