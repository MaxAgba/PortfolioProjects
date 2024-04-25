Select *
From [CovidDeaths 1]

Select *
From CovidVaccinations

Select location, date, total_cases,new_cases,total_deaths, population
From [CovidDeaths 1]
ORDER BY 1,2

Select location, date, total_cases,total_deaths, (total_deaths/total_cases)* 100 AS Deathpercentage 
From [CovidDeaths 1]
Where location like '%states%'
ORDER BY 1,2


Select location, date, total_cases,population, (total_cases/population)* 100 AS percentageOFpopulationinfected 
From [CovidDeaths 1]
Where location like '%states%'
ORDER BY 1,2

ALTER TABLE [CovidDeaths 1]
ALTER COLUMN total_cases float;

Select location, MAX(total_cases) AS HIGHESTINFECTIONCOUNT,population, MAX((total_cases/population))* 100 AS percentageOFpopulationinfected  
From [CovidDeaths 1]
--Where location like '%states%'
GROUP BY location, population
ORDER BY percentageOFpopulationinfected DESC




Select location, MAX(total_deaths) AS TotaldeathCOUNT
From [CovidDeaths 1]
--Where location like '%states%'
Where continent IS NOT NULL
GROUP BY location
ORDER BY TotaldeathCOUNT DESC



Select location, MAX(total_deaths) AS TotaldeathCOUNT
From [CovidDeaths 1]
--Where location like '%states%'
Where continent IS  NULL
GROUP BY location
ORDER BY TotaldeathCOUNT DESC



Select continent, MAX(total_deaths) AS TotaldeathCOUNT
From [CovidDeaths 1]
--Where location like '%states%'
Where continent IS NOT  NULL
GROUP BY continent
ORDER BY TotaldeathCOUNT DESC


Select  sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)/sum(new_cases) * 100 AS DEATHPERCENTAGE
From [CovidDeaths 1]
--Where location like '%states%' 
WHERE continent IS NOT NULL
--Group by date
ORDER BY 1,2

Select dea.continent, dea.location, dea.date, population, vac.new_vaccinations
, sum(vac.new_vaccinations) OVER (PARTITION BY dea.location order by dea.location,dea.date) AS ROLLINGPEOPLEVACCINATED
, 
From [CovidDeaths 1] dea
INNER JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac. date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3 

WITH PopsvsVac( continent, Location, date, Population, new_vaccinations,ROLLINGPEOPLEVACCINATED)
as
(
Select dea.continent, dea.location, dea.date, population, vac.new_vaccinations
,sum(vac.new_vaccinations) OVER (PARTITION BY dea.location order by dea.location,dea.date) AS ROLLINGPEOPLEVACCINATED
 -- ,(ROLLINGPEOPLEVACCINATED/population) * 100
From [CovidDeaths 1] dea
INNER JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac. date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3 
)

Select *, (ROLLINGPEOPLEVACCINATED/Population) * 100
From PopsvsVac


--TEMP TABLE
Drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, population, vac.new_vaccinations
,sum(vac.new_vaccinations) OVER (PARTITION BY dea.location order by dea.location,dea.date) AS ROLLINGPEOPLEVACCINATED
 -- ,(ROLLINGPEOPLEVACCINATED/population) * 100
From [CovidDeaths 1] dea
INNER JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac. date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3 

Select *, (ROLLINGPEOPLEVACCINATED/Population) * 100
From #PercentPopulationVaccinated


--Creating view to store data for later visualisations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, population, vac.new_vaccinations
,sum(vac.new_vaccinations) OVER (PARTITION BY dea.location order by dea.location,dea.date) AS ROLLINGPEOPLEVACCINATED
 -- ,(ROLLINGPEOPLEVACCINATED/population) * 100
From [CovidDeaths 1] dea
INNER JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac. date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3 

