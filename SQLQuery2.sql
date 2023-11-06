use master

select *
from [ProjectPortfolio-1]..CovidDeaths$
order by 3,4

select location, total_cases, new_cases, total_deaths, population
from [ProjectPortfolio-1]..CovidDeaths$
order by 1,2

--Death Percentage in Nigeria
select location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as DeathPercentage
from [ProjectPortfolio-1]..CovidDeaths$
where location like '%Nigeria%'
order by 1,2

--Percent of population infected
select location, date, total_cases, population, (total_cases/population)*100 as InfectedPercentage
from [ProjectPortfolio-1]..CovidDeaths$
where location like '%Nigeria%'
order by 1,2

--Countries with highest infection rate compared to population
select location, max(total_cases) as HighestInfectionCount, population, max(total_cases/population)*100 as HighestInfectedPercentage
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
group  by location, population
order by HighestInfectedPercentage desc

--countries with highest number of deaths
select location, max(cast(total_deaths as int)) as TotalDeathsCount
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
where continent is not null
group  by location, population
order by TotalDeathsCount desc

--Continents with highest deaths
select location, max(cast(total_deaths as int)) as TotalDeathsCount
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
where continent is null
group  by location
order by TotalDeathsCount desc

-- Countries with highest deaths in Africa
select location, max(cast(total_deaths as int)) as TotalDeathsCount
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
where continent = 'Africa'
group  by location
order by TotalDeathsCount desc


--Total death per continent
select continent, max(cast(total_deaths as int)) as TotalDeathsCount
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
where continent is not null
group  by continent
order by TotalDeathsCount desc


select CVD.continent, CVD.location, CVD.date, CVD.population, CVV.new_vaccinations
from [ProjectPortfolio-1]..CovidDeaths$ CVD
join [ProjectPortfolio-1]..CovidVaccinations$ CVV
	on CVD.location = CVV.location
	and CVD.date = CVV.date
where CVD.continent is not null
order by 2,3

create view DeathRateinNigeria as
select location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as DeathPercentage
from [ProjectPortfolio-1]..CovidDeaths$
where location like '%Nigeria%'
--order by 1,2

create view PercentageofPopulationInfected as
select location, date, total_cases, population, (total_cases/population)*100 as InfectedPercentage
from [ProjectPortfolio-1]..CovidDeaths$
where location like '%Nigeria%'

create view CountrieswithHighestInfectionRate as
select location, max(total_cases) as HighestInfectionCount, population, max(total_cases/population)*100 as HighestInfectedPercentage
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
group  by location, population

create view CountrieswithHighestnumberofDeaths as
select location, max(cast(total_deaths as int)) as TotalDeathsCount
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
where continent is not null
group  by location, population

create view ContinentswithHighestDeaths as
select location, max(cast(total_deaths as int)) as TotalDeathsCount
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
where continent is null
group  by location

create view CountrieswithHighestDeathsinAfrica as
select location, max(cast(total_deaths as int)) as TotalDeathsCount
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
where continent = 'Africa'
group  by location

create view TotalDeathsPerContinent as
select continent, max(cast(total_deaths as int)) as TotalDeathsCount
from [ProjectPortfolio-1]..CovidDeaths$
--where location like '%Nigeria%'
where continent is not null
group  by continent