SELECT * FROM portfolio_project_1.continent_table_final;
drop temporary table Peru_vs_cont;
create temporary table Peru_vs_cont (place text, rate_cases_pop float, rate_deaths_cases float) 
with cte_temp(place, rate1,rate2,pop) as 
(SELECT continent, max(Continent_cases),max(Continent_deaths), Continent_pop 
FROM portfolio_project_1.continent_table_final
Group by continent,Continent_pop)
select cte_temp.place, (cte_temp.rate1/cte_temp.pop)*100 rate_cases_pop,(cte_temp.rate2/cte_temp.rate1)*100 rate_deaths_cases from cte_temp
;
SELECT * FROM portfolio_project_1.Peru_vs_cont;
  select * from peru_table;

 insert into Peru_vs_cont(place,rate_cases_pop,rate_deaths_cases)
 with cte_temp(place, rate1,rate2,pop) as 
(SELECT location, max(Peru_cases),max(Peru_deaths), Peru_pop 
FROM portfolio_project_1.peru_table
Group by location,Peru_pop)
select cte_temp.place, (cte_temp.rate1/cte_temp.pop)*100 rate_cases_pop,(cte_temp.rate2/cte_temp.rate1)*100 rate_deaths_cases from cte_temp
;