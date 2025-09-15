use who;

-- Table-1 Countries---------------------------------------------------------------------------------------------------------
-- 1. List country names and their capitals using aliases
select Name as Country_Name, Capital as Capital_City from Countries;

-- 2. Show country names with population in millions using aliases
select Name as Country, Population/1000000 as Population_in_Millions from Countries;

-- 3. List country names along with their region using aliases
select Name, Region as Continent from Countries;

-- 4. Show country names with their currency using aliases
select Name as Country_Name, Currency as Currency_Type from Countries;

-- 5. Display country names with income level using aliases
select Name as Country, Income_Level as Income_Category from Countries;

-- 6. Show country names with area in sq km using aliases
select Name as Country, AreaSqKm as Area_in_SqKm from Countries;

-- 7. List country names with official language using aliases
select Name as Country, Language as Official_Language from Countries;

-- 8. Display country names with UN membership status using aliases
select Name as Country, UN_Member as UN_Status from Countries;

-- 9. Show country names with population and area using aliases
select Name as Country, Population as Total_Population, AreaSqKm as Total_Area from Countries;

-- 10. Display concatenated country name and capital using aliases
select Name as Country, concat(Name,' - ',Capital) as Country_Capital from Countries;

-- 11. Find the country with the largest population using subquery
select Name from Countries where Population = (select max(Population) from Countries);

-- 12. Find the country with the smallest population using subquery
select Name from Countries where Population = (select min(Population) from Countries);

-- 13. List countries with area greater than the average area using subquery
select Name from Countries where AreaSqKm > (select avg(AreaSqKm) from Countries);

-- 14. List countries with population less than the average population using subquery
select Name from Countries where Population < (select avg(Population) from Countries);

-- 15. Find countries with highest income level using subquery
select Name, Region from Countries where Income_Level = (select max(Income_Level) from Countries);

-- 16. List countries using currency of European countries using subquery
select Name from Countries where Currency in (select Currency from Countries where Region='Europe');

-- 17. List countries with population greater than India using subquery
select Name from Countries where Population > (select Population from Countries where Name='India');

-- 18. Find the country with the largest population in Americas using subquery
select Name, Population from Countries where Population = (select max(Population) from Countries where Region='Americas');

-- 19. Find the country with smallest area in Africa using subquery
select Name from Countries where AreaSqKm = (select min(AreaSqKm) from Countries where Region='Africa');

-- 20. List countries that are UN members like the United States using subquery
select Name from Countries where UN_Member = (select UN_Member from Countries where Name='United States');

-- 21. Convert country names to uppercase using built-in function
select upper(Name) as Country_Upper from Countries;

-- 22. Convert country names to lowercase using built-in function
select lower(Name) as Country_Lower from Countries;

-- 23. Get the length of each country name using built-in function
select length(Name) as Name_Length from Countries;

-- 24. Concatenate country name and capital using built-in function
select concat(Name,' - ',Capital) as Country_Info from Countries;

-- 25. Show population in millions rounded to 2 decimal places
select round(Population/1000000,2) as Population_in_Millions from Countries;

-- 26. Round population in millions up to nearest integer
select ceil(Population/1000000) as Rounded_Pop_Million from Countries;

-- 27. Round population in millions down to nearest integer
select floor(Population/1000000) as Floor_Pop_Million from Countries;

-- 28. Replace 'English' with 'ENG' in language column
select replace(Language,'English','ENG') as Language_Code from Countries;

-- 29. Extract first 3 characters of country name
select substring(Name,1,3) as Name_Short from Countries;

-- 30. Concatenate country name and currency in parentheses
select concat(Name,'(',Currency,')') as Country_Currency from Countries;

-- 31. Count total number of countries
select count(*) as Total_Countries from Countries;

-- 32. Calculate average population of all countries
select avg(Population) as Avg_Population from Countries;

-- 33. Calculate total population of all countries
select sum(Population) as Total_Population from Countries;

-- 34. Find the country with the maximum population
select max(Population) as Largest_Population from Countries;

-- 35. Find the country with the minimum population
select min(Population) as Smallest_Population from Countries;

-- 36. Find the country with the largest area
select max(AreaSqKm) as Largest_Area from Countries;

-- 37. Find the country with the smallest area
select min(AreaSqKm) as Smallest_Area from Countries;

-- 38. Count the number of distinct regions
select count(distinct Region) as Total_Regions from Countries;

-- 39. Count countries per region
select Region, count(*) as Countries_Per_Region from Countries group by Region;

-- 40. Calculate average population per income level
select Income_Level, avg(Population) as Avg_Pop_Per_Income from Countries group by Income_Level;

-- 41. count of government organizations partnered before 2005
delimiter //
create function count_gov_pre2005() returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt 
    from collaborating_organizations 
    where partnership_date < '2005-01-01' and type = 'government';
    return cnt;
end//
delimiter ;
select count_gov_pre2005() as total_gov_pre2005;

-- 42. count of ngo organizations partnered after 2015
delimiter //
create function count_ngo_post2015() returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt
    from collaborating_organizations
    where partnership_date > '2015-01-01' and type = 'ngo';
    return cnt;
end//
delimiter ;
select count_ngo_post2015() as total_ngo_post2015;

-- 43. total organizations for a specific country and type
delimiter //
create function total_organizations_bycountrytype(c_id int, org_type varchar(50)) returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt
    from collaborating_organizations
    where country_id = c_id and type = org_type;
    return cnt;
end//
delimiter ;
select total_organizations_bycountrytype(2, 'government') as total_org_country2_gov;

-- 44. count of organizations where notes contain 'supports'
delimiter //
create function count_notes_supports() returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt
    from collaborating_organizations
    where notes like '%supports%';
    return cnt;
end//
delimiter ;
select count_notes_supports() as total_notes_supports;

-- 45. count of organizations where area_of_work contains 'disease control'
delimiter //
create function count_area_diseasecontrol() returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt
    from collaborating_organizations
    where area_of_work like '%disease control%';
    return cnt;
end//
delimiter ;
select count_area_diseasecontrol() as total_area_diseasecontrol;

-- 46. count of organizations with phone starting with '+91'
delimiter //
create function count_phone_91() returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt
    from collaborating_organizations
    where phone like '+91%';
    return cnt;
end//
delimiter ;
select count_phone_91() as total_phone_91;

-- 47. count of organizations with email ending with '.org'
delimiter //
create function count_email_org() returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt
    from collaborating_organizations
    where contact_email like '%.org';
    return cnt;
end//
delimiter ;
select count_email_org() as total_email_org;

-- 48. count of organizations partnered in 2005
delimiter //
create function count_partnership_2005() returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt
    from collaborating_organizations
    where year(partnership_date) = 2005;
    return cnt;
end//
delimiter ;
select count_partnership_2005() as total_partnership_2005;

-- 49. count of organizations where notes contain 'research'
delimiter //
create function count_notes_research() returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt
    from collaborating_organizations
    where notes like '%research%';
    return cnt;
end//
delimiter ;
select count_notes_research() as total_notes_research;

-- 50. count of ngos in country_id 1 or 4
delimiter //
create function count_ngo_country1_4() returns int
deterministic
begin
    declare cnt int;
    select count(*) into cnt
    from collaborating_organizations
    where country_id in (1,4) and type = 'ngo';
    return cnt;
end//
delimiter ;
select count_ngo_country1_4() as total_ngo_country1_4;

-- Table-2 Diseases----------------------------------------------------------------------------------------------------------
-- 1. Display disease name and severity with aliases
select name as disease_name, severity_level as severity from diseases;

-- 2. Show disease id and transmission mode with alias
select diseaseid as id, transmission_mode as spread_type from diseases;

-- 3. Alias for origin country and vaccine status
select origin_country as country, vaccine_available as vaccine_status from diseases;

-- 4. Alias for icd code and first reported year
select icdcode as code, first_reported_year as reported from diseases;

-- 5. Alias multiple columns
select name as disease, type as category, symptome as symptoms from diseases;

-- Joins (self join since single table)
-- 6. Diseases with same transmission mode
select d1.name, d2.name, d1.transmission_mode 
from diseases d1 join diseases d2 
on d1.transmission_mode = d2.transmission_mode 
and d1.diseaseid < d2.diseaseid;

-- 7. Diseases with same severity level
select d1.name as disease1, d2.name as disease2, d1.severity_level 
from diseases d1 join diseases d2 
on d1.severity_level = d2.severity_level 
and d1.diseaseid <> d2.diseaseid;

-- 8. Diseases with same origin country
select d1.name as d1_name, d2.name as d2_name, d1.origin_country 
from diseases d1 join diseases d2 
on d1.origin_country = d2.origin_country 
and d1.diseaseid < d2.diseaseid;

-- 9. Diseases reported in same year
select d1.name, d2.name, d1.first_reported_year 
from diseases d1 join diseases d2 
on d1.first_reported_year = d2.first_reported_year 
and d1.diseaseid < d2.diseaseid;

-- 10. Diseases with same vaccine availability
select d1.name, d2.name, d1.vaccine_available 
from diseases d1 join diseases d2 
on d1.vaccine_available = d2.vaccine_available 
and d1.diseaseid < d2.diseaseid;

-- 11. Diseases with severity higher than 'Medium'
select * from diseases where severity_level = (select severity_level from diseases where name='COVID-19');

-- 12. Disease first reported earliest
select * from diseases where first_reported_year = (select min(first_reported_year) from diseases);

-- 13. Disease first reported latest
select * from diseases where first_reported_year = (select max(first_reported_year) from diseases);

-- 14. Diseases from countries where vaccine available = 'Yes'
select * from diseases where origin_country in (select origin_country from diseases where vaccine_available='Yes');

-- 15. Diseases with same icdcode as 'Malaria'
select * from diseases where icdcode = (select icdcode from diseases where name='Malaria');

-- 16. Diseases with transmission mode same as 'Influenza'
select * from diseases where transmission_mode = (select transmission_mode from diseases where name='Influenza');

-- 17. Diseases discovered before 'Cholera'
select * from diseases where first_reported_year < (select first_reported_year from diseases where name='Cholera');

-- 18. Diseases discovered after 'HIV/AIDS'
select * from diseases where first_reported_year > (select first_reported_year from diseases where name='HIV/AIDS');

-- 19. Diseases with severity equal to 'Tuberculosis'
select * from diseases where severity_level = (select severity_level from diseases where name='Tuberculosis');

-- 20. Diseases with no vaccine like 'HIV/AIDS'
select * from diseases where vaccine_available = (select vaccine_available from diseases where name='HIV/AIDS');

-- 21. Count total diseases
select count(*) as total_diseases from diseases;

-- 22. Find earliest year disease discovered
select min(first_reported_year) as earliest_year from diseases;

-- 23. Find latest year disease discovered
select max(first_reported_year) as latest_year from diseases;

-- 24. Average first reported year
select avg(first_reported_year) as avg_reported_year from diseases;

-- 25. Length of each disease name
select name, length(name) as name_length from diseases;

-- 26. Upper case disease names
select upper(name) as uppercase_name from diseases;

-- 27. Lower case transmission modes
select lower(transmission_mode) as transmission from diseases;

-- 28. Concatenate name and icdcode
select concat(name,' - ',icdcode) as disease_code from diseases;

-- 29. Extract first 4 characters of icdcode
select icdcode, left(icdcode,4) as icd_prefix from diseases;

-- 30. Distinct origin countries
select distinct origin_country from diseases;

-- 31. Replace symptom 'fever' with 'high fever'
select name, replace(symptome,'fever','high fever') as updated_symptom from diseases;

-- 32. Round avg reported year
select round(avg(first_reported_year)) as rounded_avg from diseases;

-- 33. Diseases with instr function
select name from diseases where instr(symptome,'cough')>0;

-- 34. Substring of disease name
select substring(name,1,5) as short_name from diseases;

-- 35. Count diseases per country
select origin_country, count(*) as total from diseases group by origin_country;

-- 36. Max reported year per country
select origin_country, max(first_reported_year) as latest from diseases group by origin_country;

-- 37. Group by severity level
select severity_level, count(*) as total from diseases group by severity_level;

-- 38. Diseases with coalesce on vaccine
select name, coalesce(vaccine_available,'Unknown') as vaccine_status from diseases;

-- 39. IF function to check vaccine availability
select name, if(vaccine_available='Yes','Available','Not Available') as vaccine_status from diseases;

-- 40. Case statement to classify year
select name, case 
 when first_reported_year<1900 then 'Ancient'
 when first_reported_year between 1900 and 2000 then 'Modern'
 else 'Recent' end as period 
from diseases;

-- 41. Function to get disease severity
delimiter //
create function get_disease_severity(did int) 
returns varchar(50)
deterministic
return (select severity_level from diseases where diseaseid=did);
// delimiter ;
select name, get_disease_severity(diseaseid) as severity from diseases;

-- 42. Function to check if vaccine available
delimiter //
create function has_vaccine(did int) 
returns varchar(3)
deterministic
return (select vaccine_available from diseases where diseaseid=did);
// delimiter ;
select name, has_vaccine(diseaseid) as vaccine_status from diseases;

-- 43. Function to get disease origin
delimiter //
create function get_origin(did int) 
returns varchar(50)
deterministic
return (select origin_country from diseases where diseaseid=did);
// delimiter ;
select name, get_origin(diseaseid) as origin from diseases;

-- 44. Function to return icd code
delimiter //
create function get_icd(did int) 
returns varchar(20)
deterministic
return (select icdcode from diseases where diseaseid=did);
// delimiter ;
select name, get_icd(diseaseid) as icd from diseases;

-- 45. Function to return transmission mode
delimiter //
create function get_transmission(did int) 
returns varchar(50)
deterministic
return (select transmission_mode from diseases where diseaseid=did);
// delimiter ;
select name, get_transmission(diseaseid) as spread from diseases;

-- 46. Function to return reported year
delimiter //
create function get_reported_year(did int) 
returns int
deterministic
return (select first_reported_year from diseases where diseaseid=did);
// delimiter ;
select name, get_reported_year(diseaseid) as year from diseases;

-- 47. Function to get symptoms
delimiter //
create function get_symptoms(did int) 
returns varchar(200)
deterministic
return (select symptome from diseases where diseaseid=did);
// delimiter ;
select name, get_symptoms(diseaseid) as symptoms from diseases;

-- 48. Function to return disease type
delimiter //
create function get_disease_type(did int) 
returns varchar(50)
deterministic
return (select type from diseases where diseaseid=did);
// delimiter ;
select name, get_disease_type(diseaseid) as category from diseases;

-- 49. Function to check if disease is severe
delimiter //
create function is_severe(did int) 
returns varchar(10)
deterministic
return (select case when severity_level='High' then 'Yes' else 'No' end from diseases where diseaseid=did);
// delimiter ;
select name, is_severe(diseaseid) as severe_disease from diseases;

-- 50. Function to classify old/new disease
delimiter //
create function classify_disease(did int) 
returns varchar(20)
deterministic
return (select case when first_reported_year<1950 then 'Old' else 'New' end from diseases where diseaseid=did);
// delimiter ;
select name, classify_disease(diseaseid) as classification from diseases;

-- Table-3 Disease_Cases-----------------------------------------------------------------------------------------------------
-- 1. display case id, confirmed and deaths with aliases
select caseid as id, confirmed_cases as cases, deaths as fatal from disease_cases;

-- 2. alias for report date and source
select report_date as reported_on, source as reported_by from disease_cases;

-- 3. alias country and disease with join
select dc.caseid, c.name as country, d.name as disease 
from disease_cases dc 
join countries c on dc.country_id=c.countryid 
join diseases d on dc.disease_id=d.diseaseid;

-- 4. alias for recoveries and active cases
select recoveries as recovered, active_cases as active from disease_cases;

-- 5. alias multiple attributes
select caseid as case_number, confirmed_cases as total_confirmed, deaths as total_deaths, notes as remarks from disease_cases;

-- 6. join disease_cases with countries to get country name
select dc.caseid, c.name as country, dc.confirmed_cases 
from disease_cases dc 
join countries c 
on dc.country_id=c.countryid;

-- 7. join disease_cases with diseases to get disease name
select dc.caseid, d.name as disease, dc.deaths 
from disease_cases dc 
join diseases d 
on dc.disease_id=d.diseaseid;

-- 8. join all three tables
select dc.caseid, c.name as country, d.name as disease, dc.confirmed_cases, dc.deaths 
from disease_cases dc 
join countries c on dc.country_id=c.countryid 
join diseases d on dc.disease_id=d.diseaseid;

-- 9. cases by disease severity
select d.severity_level, sum(dc.confirmed_cases) as total_cases 
from disease_cases dc 
join diseases d on dc.disease_id=d.diseaseid 
group by d.severity_level;

-- 10. cases by country income level
select c.income_level, sum(dc.deaths) as total_deaths 
from disease_cases dc 
join countries c on dc.country_id=c.countryid 
group by c.income_level;

-- 11. cases with deaths higher than average
select * from disease_cases where deaths > (select avg(deaths) from disease_cases);

-- 12. case with maximum confirmed cases
select * from disease_cases where confirmed_cases = (select max(confirmed_cases) from disease_cases);

-- 13. case with minimum deaths
select * from disease_cases where deaths = (select min(deaths) from disease_cases);

-- 14. cases from countries with population > 100 million
select * from disease_cases where country_id in (select countryid from countries where population>100000000);

-- 15. cases of diseases with vaccine available
select * from disease_cases where disease_id in (select diseaseid from diseases where vaccine_available='Yes');

-- 16. cases of diseases first reported before 1900
select * from disease_cases where disease_id in (select diseaseid from diseases where first_reported_year<1900);

-- 17. cases in countries not UN members
select * from disease_cases where country_id in (select countryid from countries where un_member='No');

-- 18. cases of severe diseases
select * from disease_cases where disease_id in (select diseaseid from diseases where severity_level='High');

-- 19. cases in asian countries
select * from disease_cases where country_id in (select countryid from countries where region='Asia');

-- 20. cases with notes mentioning 'outbreak'
select * from disease_cases where caseid in (select caseid from disease_cases where notes like '%outbreak%');

-- 21. total confirmed cases
select sum(confirmed_cases) as total_confirmed from disease_cases;

-- 22. average deaths
select avg(deaths) as avg_deaths from disease_cases;

-- 23. maximum recoveries
select max(recoveries) as max_recovered from disease_cases;

-- 24. minimum active cases
select min(active_cases) as min_active from disease_cases;

-- 25. year of report date
select year(report_date) as report_year, count(*) as total_cases from disease_cases group by year(report_date);

-- 26. month of report date
select month(report_date) as report_month, count(*) as total_cases from disease_cases group by month(report_date);

-- 27. length of notes
select caseid, length(notes) as note_length from disease_cases;

-- 28. uppercase source
select upper(source) as source_name from disease_cases;

-- 29. substring of notes
select substring(notes,1,20) as note_excerpt from disease_cases;

-- 30. distinct sources
select distinct source from disease_cases;

-- 31. concat country and disease name
select concat(c.name,' - ',d.name) as country_disease 
from disease_cases dc 
join countries c on dc.country_id=c.countryid 
join diseases d on dc.disease_id=d.diseaseid;

-- 32. replace 'COVID-19' with 'Coronavirus'
select replace(notes,'COVID-19','Coronavirus') as updated_notes from disease_cases;

-- 33. round average confirmed cases
select round(avg(confirmed_cases)) as rounded_avg from disease_cases;

-- 34. if function for fatal cases
select caseid, if(deaths>10000,'Severe','Mild') as case_severity from disease_cases;

-- 35. case statement for classification
select caseid, case 
 when confirmed_cases>100000 then 'Pandemic'
 when confirmed_cases between 1000 and 100000 then 'Epidemic'
 else 'Isolated' end as case_type 
from disease_cases;

-- 36. group by country for total confirmed
select country_id, sum(confirmed_cases) as total_confirmed from disease_cases group by country_id;

-- 37. group by disease for total deaths
select disease_id, sum(deaths) as total_deaths from disease_cases group by disease_id;

-- 38. cases per source
select source, count(*) as total_cases from disease_cases group by source;

-- 39. max confirmed cases per year
select year(report_date), max(confirmed_cases) as max_cases from disease_cases group by year(report_date);

-- 40. coalesce notes
select caseid, coalesce(notes,'No information') as case_notes from disease_cases;

-- 41. function to get total deaths for case
create function get_case_deaths(cid int) 
returns int
deterministic
return (select deaths from disease_cases where caseid=cid);

select caseid, get_case_deaths(caseid) as deaths from disease_cases;

-- 42. function to get country name from case
create function get_case_country(cid int) 
returns varchar(100)
deterministic
return (select c.name from disease_cases dc join countries c on dc.country_id=c.countryid where dc.caseid=cid);

select caseid, get_case_country(caseid) as country from disease_cases;

-- 43. function to get disease name from case
create function get_case_disease(cid int) 
returns varchar(100)
deterministic
return (select d.name from disease_cases dc join diseases d on dc.disease_id=d.diseaseid where dc.caseid=cid);

select caseid, get_case_disease(caseid) as disease from disease_cases;

-- 44. function to calculate fatality rate
create function fatality_rate(cid int) 
returns decimal(10,2)
deterministic
return (select (deaths/confirmed_cases)*100 from disease_cases where caseid=cid);

select caseid, fatality_rate(caseid) as death_rate from disease_cases;

-- 45. function to calculate recovery rate
create function recovery_rate(cid int) 
returns decimal(10,2)
deterministic
return (select (recoveries/confirmed_cases)*100 from disease_cases where caseid=cid);

select caseid, recovery_rate(caseid) as recovery_percent from disease_cases;

-- 46. function to calculate active rate
create function active_rate(cid int) returns 
decimal(10,2)
deterministic
return (select (active_cases/confirmed_cases)*100 from disease_cases where caseid=cid);

select caseid, active_rate(caseid) as active_percent from disease_cases;

-- 47. function to get report year
create function get_case_year(cid int) 
returns int
deterministic
return (select year(report_date) from disease_cases where caseid=cid);

select caseid, get_case_year(caseid) as report_year from disease_cases;

-- 48. function to classify severity
create function classify_case(cid int) 
returns varchar(20)
deterministic
return (select case 
 when deaths>10000 then 'Severe'
 when deaths between 1000 and 10000 then 'Moderate'
 else 'Mild' end from disease_cases where caseid=cid);

select caseid, classify_case(caseid) as severity from disease_cases;

-- 49. function to return source
create function get_case_source(cid int) 
returns varchar(100)
deterministic
return (select source from disease_cases where caseid=cid);

select caseid, get_case_source(caseid) as source from disease_cases;

-- 50. function to return note summary
create function get_note_summary(cid int) 
returns varchar(100)
deterministic
return (select substring(notes,1,50) from disease_cases where caseid=cid);

select caseid, get_note_summary(caseid) as summary from disease_cases;

-- Table-4 Vaccines----------------------------------------------------------------------------------------------------------
-- 1. alias for vaccine name and manufacturer
select name as vaccine_name, manufacturer as company from vaccines;

-- 2. alias for efficacy and doses
select efficacy as success_rate, doses_required as doses from vaccines;

-- 3. alias for approval date
select name as vaccine, approval_date as approved_on from vaccines;

-- 4. alias for storage temp
select storage_temp as storage_condition, name as vaccine from vaccines;

-- 5. alias for side effects
select name as vaccine, side_effects as adverse_effects from vaccines;

-- 6. alias for status
select name as vaccine, status as approval_status from vaccines;

-- 7. alias combining vaccineid and name
select concat(vaccineid, '-', name) as vaccine_code from vaccines;

-- 8. alias for disease id
select disease_id as related_disease, name as vaccine from vaccines;

-- 9. alias using upper function
select upper(name) as vaccine_name, manufacturer as company from vaccines;

-- 10. alias for efficacy rounded
select round(efficacy) as approx_efficacy, name as vaccine from vaccines;

-- 11. vaccines with efficacy higher than 'Fluzone'
select * from vaccines where efficacy > (select efficacy from vaccines where name='Fluzone');

-- 12. vaccines approved before 'Pfizer-BioNTech'
select * from vaccines where approval_date < (select approval_date from vaccines where name='Pfizer-BioNTech');

-- 13. vaccines with same manufacturer as 'Havrix'
select * from vaccines where manufacturer = (select manufacturer from vaccines where name='Havrix');

-- 14. vaccines requiring more doses than 'Rabipur'
select * from vaccines where doses_required > (select doses_required from vaccines where name='Rabipur');

-- 15. vaccines with efficacy equal to max efficacy
select * from vaccines where efficacy = (select max(efficacy) from vaccines);

-- 16. vaccines that share storage_temp with 'Covishield'
select * from vaccines where storage_temp = (select storage_temp from vaccines where name='Covishield');

-- 17. vaccines targeting same disease as 'MMR Vaccine'
select * from vaccines where disease_id = (select disease_id from vaccines where name='MMR Vaccine');

-- 18. vaccines having side effects like any 'Pfizer-BioNTech'
select * from vaccines where side_effects = (select side_effects from vaccines where name='Pfizer-BioNTech');

-- 19. vaccines with approval date after average approval date
select * from vaccines where approval_date > (select avg(year(approval_date)) from vaccines);

-- 20. vaccines approved in same year as 'BCG Vaccine'
select * from vaccines where year(approval_date) = (select year(approval_date) from vaccines where name='BCG Vaccine');

-- 21. length of vaccine name
select name, length(name) as name_length from vaccines;

-- 22. convert manufacturer to upper case
select upper(manufacturer) as company_name from vaccines;

-- 23. substring of side effects
select name, substring(side_effects,1,15) as short_effects from vaccines;

-- 24. round efficacy
select name, round(efficacy) as rounded_efficiency from vaccines;

-- 25. concat vaccine name and manufacturer
select concat(name, ' by ', manufacturer) as full_info from vaccines;

-- 26. current date with approval status
select name, curdate() as today, status from vaccines;

-- 27. number of years since approval
select name, year(curdate()) - year(approval_date) as years_since_approval from vaccines;

-- 28. replace 'Fever' with 'High Fever' in side effects
select replace(side_effects,'Fever','High Fever') as updated_effects from vaccines;

-- 29. position of 'a' in vaccine name
select name, instr(name,'a') as pos_a from vaccines;

-- 30. max efficacy of all vaccines
select max(efficacy) as highest_efficacy from vaccines;

-- 31. function to check vaccine status
delimiter //
create function check_status(vid int)
returns varchar(20) deterministic
begin
  declare st varchar(20);
  select status into st from vaccines where vaccineid=vid;
  return st;
end
// delimiter ;

select name, check_status(vaccineid) as approval_status from vaccines;

-- 32. function to calculate vaccine age in years
delimiter //
create function vaccine_age(vid int)
returns int deterministic
begin
  declare years int;
  select year(curdate())-year(approval_date) into years from vaccines where vaccineid=vid;
  return years;
end
// delimiter ;

select name, vaccine_age(vaccineid) as years_old from vaccines;

-- 33. function to classify efficacy
delimiter //
create function efficacy_class(vid int)
returns varchar(20) deterministic
begin
  declare eff float;
  select efficacy into eff from vaccines where vaccineid=vid;
  if eff>=90 then return 'Very Effective';
  elseif eff>=70 then return 'Effective';
  else return 'Moderate';
  end if;
end
// delimiter ;

select name, efficacy_class(vaccineid) as class from vaccines;

-- 34. function to return manufacturer short name
delimiter //
create function short_manu(vid int)
returns varchar(10) deterministic
begin
  declare manu varchar(100);
  select manufacturer into manu from vaccines where vaccineid=vid;
  return left(manu,5);
end
// delimiter ;

select name, short_manu(vaccineid) as manufacturer_abbr from vaccines;

-- 35. function to show vaccine full info
delimiter //
create function vaccine_info(vid int)
returns varchar(200) deterministic
begin
  declare info varchar(200);
  select concat(name,'-',manufacturer,'-',efficacy) into info from vaccines where vaccineid=vid;
  return info;
end
// delimiter ;

select vaccine_info(vaccineid) from vaccines;

-- 36. function to check if vaccine needs multiple doses
delimiter //
create function is_multidose(vid int)
returns varchar(10) deterministic
begin
  declare d int;
  select doses_required into d from vaccines where vaccineid=vid;
  if d>1 then return 'Yes'; else return 'No'; end if;
end
// delimiter ;

select name, is_multidose(vaccineid) as multidose from vaccines;

-- 37. function to extract approval year
delimiter //
create function approval_year(vid int)
returns int deterministic
begin
  declare yr int;
  select year(approval_date) into yr from vaccines where vaccineid=vid;
  return yr;
end
// delimiter ;

select name, approval_year(vaccineid) from vaccines;

-- 38. function to get temp requirement
delimiter //
create function storage_condition(vid int)
returns varchar(50) deterministic
begin
  declare t varchar(50);
  select storage_temp into t from vaccines where vaccineid=vid;
  return t;
end
// delimiter ;

select name, storage_condition(vaccineid) from vaccines;

-- 39. function to return efficacy + status
delimiter //
create function eff_status(vid int)
returns varchar(50) deterministic
begin
  declare e float; declare s varchar(20);
  select efficacy, status into e,s from vaccines where vaccineid=vid;
  return concat(e,'-',s);
end
// delimiter ;

select name, eff_status(vaccineid) from vaccines;

-- 40. function to check if vaccine is legacy (<1950 approval)
delimiter //
create function is_legacy(vid int)
returns varchar(10) deterministic
begin
  declare yr int;
  select year(approval_date) into yr from vaccines where vaccineid=vid;
  if yr<1950 then return 'Legacy'; else return 'Modern'; end if;
end
// delimiter ;

select name, is_legacy(vaccineid) from vaccines;

-- 41. join vaccines with diseases to show disease name
select v.name as vaccine, d.name as disease
from vaccines v
join diseases d on v.disease_id=d.diseaseid;

-- 42. join showing vaccine efficacy with disease severity
select v.name as vaccine, v.efficacy, d.severity_level
from vaccines v
join diseases d on v.disease_id=d.diseaseid;

-- 43. join showing vaccine and disease origin country
select v.name as vaccine, d.origin_country
from vaccines v
join diseases d on v.disease_id=d.diseaseid;

-- 44. join showing vaccine manufacturer and disease type
select v.manufacturer, d.type
from vaccines v
join diseases d on v.disease_id=d.diseaseid;

-- 45. join with alias for approval year and first reported year
select v.name as vaccine, year(v.approval_date) as approval_year, d.first_reported_year
from vaccines v
join diseases d on v.disease_id=d.diseaseid;

-- 46. join showing storage condition and transmission mode
select v.name as vaccine, v.storage_temp, d.transmission_mode
from vaccines v
join diseases d on v.disease_id=d.diseaseid;

-- 47. join with concat
select concat(v.name,' - ',d.name) as vaccine_disease_pair
from vaccines v
join diseases d on v.disease_id=d.diseaseid;

-- 48. join filtering vaccines with high severity diseases
select v.name, d.name, d.severity_level
from vaccines v
join diseases d on v.disease_id=d.diseaseid
where d.severity_level='High';

-- 49. join showing vaccine side effects and disease symptoms
select v.name as vaccine, v.side_effects, d.symptome
from vaccines v
join diseases d on v.disease_id=d.diseaseid;

-- 50. left join showing all vaccines with diseases (if exist)
select v.name as vaccine, d.name as disease
from vaccines v
left join diseases d on v.disease_id=d.diseaseid;

-- Table-5 Vaccination_Records-----------------------------------------------------------------------------------------------
-- 1. Alias → rename table vaccination_records as vr
select vr.recordid, vr.campaign_name, vr.total_vaccinated from vaccination_records vr;

-- 2. Alias → country name with vaccinated people
select c.name as country, vr.total_vaccinated as vaccinated_people from vaccination_records vr join countries c on vr.country_id = c.countryid;

-- 3. Alias → vaccine name with booster doses
select v.name as vaccine, vr.booster_doses as boosters from vaccination_records vr join vaccines v on vr.vaccine_id = v.vaccineid;

-- 4. Alias → vaccinated count by gender
select vr.gender as g, sum(vr.total_vaccinated) as total from vaccination_records vr group by g;

-- 5. Alias → campaign name with short alias
select vr.campaign_name as camp, vr.fully_vaccinated as fully from vaccination_records vr;

-- 6. Alias → total and fully vaccinated comparison
select vr.recordid, vr.total_vaccinated as total, vr.fully_vaccinated as full from vaccination_records vr;

-- 7. Alias → vaccine manufacturer with booster counts
select v.manufacturer as m, sum(vr.booster_doses) as boosters
from vaccination_records vr join vaccines v on vr.vaccine_id = v.vaccineid
group by m;

-- 8. Alias → country alias c with total vaccinations
select c.name as ctry, sum(vr.total_vaccinated) as total_vax
from vaccination_records vr join countries c on vr.country_id = c.countryid
group by ctry;

-- 9. Alias → vaccine cost with campaign
select vr.campaign_name as campaign, v.cost as vaccine_cost
from vaccination_records vr join vaccines v on vr.vaccine_id = v.vaccineid;

-- 10. Alias → report date aliasing
select vr.recordid, vr.report_date as report_dt from vaccination_records vr;

-- 11. Subquery → campaigns with above average vaccinated
select campaign_name
from vaccination_records
where total_vaccinated > (select avg(total_vaccinated) from vaccination_records);

-- 12. Subquery → vaccines used in India
select v.name
from vaccines v
where v.vaccineid in (select vaccine_id from vaccination_records where country_id in 
    (select countryid from countries where name = 'India'));

-- 13. Subquery → countries with max booster doses
select name
from countries
where countryid in (select country_id from vaccination_records where booster_doses =
    (select max(booster_doses) from vaccination_records));

-- 14. Subquery → campaigns after first vaccine approval
select campaign_name
from vaccination_records
where report_date > (select min(approval_year) from vaccines);

-- 15. Subquery → find recordids where total vaccinated > country population/2
select recordid
from vaccination_records
where total_vaccinated > (select population/2 from countries where countries.countryid = vaccination_records.country_id);

-- 16. Subquery → top  vaccines by efficacy used in records
select name from vaccines
where vaccineid in (select vaccine_id from vaccination_records order by total_vaccinated desc);

-- 17. Subquery → campaigns in high-income countries
select campaign_name
from vaccination_records
where country_id in (select countryid from countries where income_level = 'High');

-- 18. Subquery → vaccines with more than 2 required doses used in records
select v.name
from vaccines v
where v.vaccineid in (select vaccine_id from vaccination_records)
and v.doses_required > 2;

-- 19. Subquery → records with highest fully vaccinated count
select recordid, campaign_name
from vaccination_records
where fully_vaccinated = (select max(fully_vaccinated) from vaccination_records);

-- 20. Subquery → country names where at least 1 booster dose given
select name
from countries
where countryid in (select distinct country_id from vaccination_records where booster_doses > 0);

-- 21. Function → count total vaccination records
select count(*) as total_records from vaccination_records;

-- 22. Function → maximum vaccinated in a single record
select max(total_vaccinated) as max_vaccinated from vaccination_records;

-- 23. Function → minimum fully vaccinated count
select min(fully_vaccinated) as min_fully from vaccination_records;

-- 24. Function → average booster doses
select avg(booster_doses) as avg_boosters from vaccination_records;

-- 25. Function → sum of vaccinated by gender
select gender, sum(total_vaccinated) as total from vaccination_records group by gender;

-- 26. Function → year of campaign report date
select campaign_name, year(report_date) as report_year from vaccination_records;

-- 27. Function → month of campaign report
select campaign_name, month(report_date) as report_month from vaccination_records;

-- 28. Function → length of campaign name
select campaign_name, length(campaign_name) as name_length from vaccination_records;

-- 29. Function → uppercase campaign name
select upper(campaign_name) as campaign from vaccination_records;

-- 30. Function → difference between total and fully vaccinated
select recordid, (total_vaccinated - fully_vaccinated) as partially_vaccinated
from vaccination_records;

-- 31. UDF → function to calculate vaccination coverage %
create function vaccination_coverage(total int, fully int) 
returns decimal(5,2)
deterministic
return (fully/total)*100;

select recordid, vaccination_coverage(total_vaccinated, fully_vaccinated) as coverage
from vaccination_records;

-- 32. UDF → booster percentage
create function booster_percentage(boosters int, total int) 
returns decimal(5,2)
deterministic
return (boosters/total)*100;

select recordid, booster_percentage(booster_doses, total_vaccinated) as booster_percent
from vaccination_records;

-- 33. UDF → classify age group
create function classify_age_group(agegrp varchar(20)) 
returns varchar(20)
deterministic
return case when agegrp = '18-30' then 'Young Adults'
            when agegrp = '31-50' then 'Middle Age'
            else 'Others' end;

select age_group, classify_age_group(age_group) as category from vaccination_records;

-- 34. UDF → campaign year from report date
create function get_campaign_year(rdate date) 
returns int
deterministic
return year(rdate);

select campaign_name, get_campaign_year(report_date) as year from vaccination_records;

-- 35. UDF → calculate vaccine gap (total - fully)
create function vaccine_gap(total int, fully int) 
returns int
deterministic
return (total - fully);

select recordid, vaccine_gap(total_vaccinated, fully_vaccinated) as gap from vaccination_records;

-- 36. UDF → vaccine efficiency by doses
create function efficiency(doses int, fully int) 
returns decimal(5,2)
deterministic
return (fully/doses);

select vr.recordid, efficiency(v.doses_required, vr.fully_vaccinated) as efficiency_score
from vaccination_records vr join vaccines v on vr.vaccine_id = v.vaccineid;

-- 37. UDF → check high campaign
create function is_high_campaign(total int) 
returns varchar(10)
deterministic
return case when total > 1000000 then 'High' else 'Low' end;

select recordid, is_high_campaign(total_vaccinated) as campaign_level from vaccination_records;

-- 38. UDF → booster needed flag
create function booster_flag(boosters int) 
returns varchar(10)
deterministic
return case when boosters > 0 then 'Yes' else 'No' end;

select recordid, booster_flag(booster_doses) as booster_required from vaccination_records;

-- 39. UDF → function to mask campaign name
create function mask_campaign(camp varchar(100)) 
returns varchar(100)
deterministic
return concat('***', right(camp,5));

select mask_campaign(campaign_name) as masked from vaccination_records;

-- 40. UDF → get continent by country
create function get_continent(cid int) 
returns varchar(50)
deterministic
return (select continent from countries where countryid = cid);

select campaign_name, get_continent(country_id) as continent from vaccination_records;

-- 41. Vaccination records with country name
select vr.recordid, c.name as country, vr.total_vaccinated
from vaccination_records vr
join countries c on vr.country_id = c.countryid;

-- 42. Vaccination records with vaccine name
select vr.recordid, v.name as vaccine, vr.fully_vaccinated
from vaccination_records vr
join vaccines v on vr.vaccine_id = v.vaccineid;

-- 43. Vaccination campaign details with country & vaccine
select vr.campaign_name, c.name as country, v.name as vaccine, vr.report_date
from vaccination_records vr
join countries c on vr.country_id = c.countryid
join vaccines v on vr.vaccine_id = v.vaccineid;

-- 44. Total vaccinated per country
select c.name as country, sum(vr.total_vaccinated) as total_people_vaccinated
from vaccination_records vr
join countries c on vr.country_id = c.countryid
group by c.name;

-- 45. Vaccines used in Asian region countries
select distinct v.name as vaccine, c.region
from vaccination_records vr
join countries c on vr.country_id = c.countryid
join vaccines v on vr.vaccine_id = v.vaccineid
where c.region = 'Asia';

-- 46. Campaigns by gender distribution
select vr.campaign_name, c.name as country, vr.gender, vr.total_vaccinated
from vaccination_records vr
join countries c on vr.country_id = c.countryid;

-- 47. List countries and the number of vaccines they used
select c.name as country, count(distinct vr.vaccine_id) as vaccines_used
from vaccination_records vr
join countries c on vr.country_id = c.countryid
group by c.name;

-- 48. Vaccine manufacturer with total booster doses given
select v.manufacturer, sum(vr.booster_doses) as total_boosters
from vaccination_records vr
join vaccines v on vr.vaccine_id = v.vaccineid
group by v.manufacturer;

-- 49. Vaccination campaigns after 2022 with country & vaccine
select vr.campaign_name, vr.report_date, c.name as country, v.name as vaccine
from vaccination_records vr
join countries c on vr.country_id = c.countryid
join vaccines v on vr.vaccine_id = v.vaccineid
where vr.report_date > '2022-01-01';

-- 50. Highest vaccinated record per country
select c.name as country, max(vr.total_vaccinated) as max_vaccinated
from vaccination_records vr
join countries c on vr.country_id = c.countryid
group by c.name;