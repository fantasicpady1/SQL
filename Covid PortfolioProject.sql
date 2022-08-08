Select * 
From PortfolioProject..CovidDeath
Where continent is not null
Order by 3,4

--Select * 
--From PortfolioProject..CovidVaccination
--Order by 3,4

--select data that we are going to be using

Select location, Date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeath
Order by 1,2

--Looking at Toral cases vs Total Deaths
--Show the likelihood of ding if you contract covid in your country
Select location, Date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as InfectionRate
From PortfolioProject..CovidDeath
Where location = 'Vietnam'
Order by 1,2

--Looking at the total cases with population
Select location, Date, Population, total_cases, (total_cases/Population)*100 as PenetrationRate
From PortfolioProject..CovidDeath
Where location = 'Vietnam'
Order by 1,2

--Looking at the country with the highest Infection rate compared to the population
Select location, Population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/Population)*100) as InfectionRate
From PortfolioProject..CovidDeath
Where location = 'Vietnam'
Group by Location, Population 
Order by HighestDeathsCount DESC

Select location, MAX(total_deaths) as HighestDeathCount
From PortfolioProject..CovidDeath
Where location ='Vietnam'
Group by location
Order by 2

--Showing countries with highest death count per population
Select location, Population, MAX(cast(total_deaths as int)) as HighestDeathsCount, MAX((Total_deaths/population)*100) as DeathRate
From PortfolioProject..CovidDeath
--Where location = 'Vietnam'
Where continent is not Null
Group by Location, Population
Order by population desc

--Lets break things down by continent 
Select location, MAX(cast(total_deaths as int)) as HighestDeathsCount, MAX((Total_deaths/population)*100) as DeathRate
From PortfolioProject..CovidDeath
Where continent is null
Group by location
Order by HighestDeathsCount desc

--Global numbers
Select date, Sum(new_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths, (sum(cast(new_deaths as int))/Sum(new_cases))*100 as DeathPercentage
from PortfolioProject..CovidDeath
where continent is not null
group by date
order by 1,2

--Looking at total population vs vaccinations
With PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(Convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeath dea
Join PortfolioProject..CovidVaccination vac
	On dea.location =vac.location and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)

Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

--Creating view to store for later visualizations

create view PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(Convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeath dea
Join PortfolioProject..CovidVaccination vac
	On dea.location =vac.location and dea.date = vac.date
Where dea.continent is not null
--order by 2,3