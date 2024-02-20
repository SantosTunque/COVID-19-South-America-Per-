##Grouping Continent`s cases and deaths by country/month-year in a temporary table
drop temporary table continent_table_1;
CREATE TEMPORARY TABLE continent_table_1
WITH temp_continent (continent, location,m_y, total_cases,total_deaths, pop )as (
SELECT
continent,
location,
  DATE_FORMAT(d_format, "%M %Y"),
  max(total_cases),
  max(total_deaths),
  population
FROM portfolio_project_1.south_america 
GROUP BY
  location,
  DATE_FORMAT(d_format, "%M %Y"),continent,population
)
select *
from temp_continent;
select * from continent_table_1;

##Rate of Total Deaths vs Total Cases (%) by Country
with cte_location (location, Total_cases, Total_deaths) as (
select location , max(total_cases), max(total_deaths)
from continent_table_1
group by location)
select* , (Total_deaths/Total_cases)*100 Rate
from cte_location 
order by Rate desc
;

##Using the previous temporary table to create a table that shows the Continent's cases and deaths by month-year
drop  table continent_table_final;
Create  table if not exists continent_table_final (Continent_id int not null auto_increment, continent text, m_y text, Continent_cases int,Continent_deaths int, Continent_pop int, primary key(Continent_id))
WITH cte_continent as (
SELECT
continent,
m_y,
sum(total_cases) Continent_cases,
sum(total_deaths) Continent_deaths,
sum(pop) Continent_pop
FROM portfolio_project_1.continent_table_1
GROUP BY
  m_y,continent
)
select *
from cte_continent;
select * from continent_table_final;

##Cases vs population Month by Month
select location, m_y,(c.total_cases/pop)*100 from continent_table_1 c
where not m_y  = "February 2024";





###############
###############
select c1.*,
coalesce(c1.Continent_cases-(select c2.Continent_cases
							from continent_table_final c2
                            where c2.Continent_id=c1.Continent_id-1),0) as Continent_new_cases,
coalesce(c1.Continent_deaths-(select c2.Continent_deaths
							from continent_table_final c2
                            where c2.Continent_id=c1.Continent_id-1),0) as Continent_new_deaths

from continent_table_final c1;


