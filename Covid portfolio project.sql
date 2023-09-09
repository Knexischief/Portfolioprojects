SELECT 
    *
FROM
    portfolioproject.coviddeaths
    ##WHERE location like '%europe%'
ORDER BY 3, 4;

##Select data that I am going to use.

SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM
    coviddeaths
    ###where location like '%france%'
ORDER BY 1,2;

##Looking at total_cases vs total_deaths
##This shows the likelihood of dying when you contract covid in your country
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS death_percentage
FROM
    coviddeaths
WHERE
    location LIKE '%ghana%'
ORDER BY 1 , 2;

##Looking at total_cases vs population
##Shows the percentage of population who got covid

SELECT 
    location,
    date,
    population,
    total_cases,
    (total_cases / population ) * 100 AS percentage_population_infection
FROM
    coviddeaths
##WHERE
    ##location LIKE '%ghana%'
ORDER BY 1, 2;

##Looking at country with highest infection rate compared to population 

SELECT 
    location,
    population,
    MAX(total_cases) AS Highestinfectioncount,
    MAX(total_cases / population) * 100 AS percentage_population_infection
FROM
    coviddeaths
    ##WHERE location like '%ghana%'
GROUP BY location, population
ORDER BY 4 DESC;

##Showing Countries with highest death count per population

SELECT 
    location,
    MAX(cast(total_deaths AS SIGNED)) AS HighestDeathCount
FROM
    coviddeaths
WHERE continent != ''
GROUP BY location 
ORDER BY 2 DESC;

##Let's break it down by continent 

SELECT 
    continent,
    MAX(cast(total_deaths AS SIGNED)) AS HighestDeathCount
FROM
    coviddeaths
WHERE continent != ''
GROUP BY continent 
ORDER BY 2 DESC;

##Global breakings

SELECT 
    SUM(new_cases) AS total_cases, SUM(cast(new_deaths AS SIGNED)) AS total_deaths, 
    SUM(cast(new_deaths AS SIGNED)) / SUM(new_cases) * 100 AS death_percentage
FROM
    coviddeaths
WHERE
    continent != ''
##GROUP BY date
ORDER BY 1,2 DESC;
-- Looking at total population vs Vaccinations
SELECT 
    co.continent,
    co.location,
    co.date,
    co.population,
    vc.new_vaccinations,
    sum(cast(new_vaccinations AS SIGNED)) over (partition by co.location order by co.location, co.date) as rollingpeoplevaccinated
FROM
    coviddeaths co
        JOIN
    covidvacinnations vc ON co.location = vc.location
        AND co.date = vc.date
        where co.continent is not null
        order by 2,3 desc;













