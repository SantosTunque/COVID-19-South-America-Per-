drop  table peru_table;
create  table peru_table (id int not null auto_increment, location text, m_y text, Peru_cases int,Peru_deaths int, Peru_pop int, primary key(id)) as (
SELECT
location,
  DATE_FORMAT(date_format, "%M %Y") m_y,
  max(total_cases) Peru_cases,
  max(total_deaths) Peru_deaths, population Peru_pop
FROM portfolio_project_1.south_america 
where location = "Peru"
GROUP BY
  MONTH(date_format),
  YEAR(date_format),
  location,
  DATE_FORMAT(date_format, "%M %Y"),
  population)
  ;
  select * from peru_table;

#New_cases and New_deaths  
  SELECT 
  p1.id,p1.location,p1.m_y,
COALESCE(p1.Peru_cases - (SELECT p2.Peru_cases 
                     FROM peru_table p2
                     WHERE p2.id = p1.id-1), 0) AS new_cases,
COALESCE(p1.Peru_deaths - (SELECT p2.Peru_deaths 
                     FROM peru_table p2
                     WHERE p2.id = p1.id-1), 0) AS new_deaths
FROM peru_table p1;

#Total_cases vs New_cases  
  SELECT 
  p1.id,p1.location,p1.m_y,p1.Peru_cases,
COALESCE(p1.Peru_cases - (SELECT p2.Peru_cases 
                     FROM peru_table p2
                     WHERE p2.id = p1.id-1), 0) AS new_cases
FROM peru_table p1;

#Total_deaths vs New_deaths  
  SELECT 
  p1.id,p1.location,p1.m_y,p1.Peru_deaths,
COALESCE(p1.Peru_deaths - (SELECT p2.Peru_deaths 
                     FROM peru_table p2
                     WHERE p2.id = p1.id-1), 0) AS new_deaths
FROM peru_table p1;