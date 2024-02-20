###Creating a table specific for Peru
drop  table peru_table;
create  table peru_table (id int not null auto_increment, location text, m_y text, Peru_cases int,Peru_deaths int, Peru_pop int, primary key(id)) as (
SELECT
location,
  DATE_FORMAT(d_format, "%M %Y") m_y,
  max(total_cases) Peru_cases,
  max(total_deaths) Peru_deaths, population Peru_pop
FROM south_america 
where location = "Peru"
GROUP BY
  location,
  DATE_FORMAT(d_format, "%M %Y"),
  population)
  ;
  select * from peru_table;


###Total_cases vs New_cases:Monthly
SELECT 
p1.id,
p1.location,
p1.m_y,
p1.Peru_cases,
COALESCE(p1.Peru_cases - (SELECT p2.Peru_cases 
                          FROM peru_table p2
                          WHERE p2.id = p1.id-1), 0) AS new_cases
FROM peru_table p1;

###Total_deaths vs New_deaths: Monthly
SELECT 
p1.id,
p1.location,
p1.m_y,
p1.Peru_deaths,
COALESCE(p1.Peru_deaths - (SELECT p2.Peru_deaths 
                           FROM peru_table p2
                           WHERE p2.id = p1.id-1), 0) AS new_deaths
FROM peru_table p1;
