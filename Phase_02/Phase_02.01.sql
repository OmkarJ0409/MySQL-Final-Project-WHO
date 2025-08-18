use who;

-- Table-1 Countries---------------------------------------------------------------------------------------------------------
-- 1. Countries with income_level = 'High'
select * from Countries where Income_Level = 'High';

-- 2. Countries with income_level = 'Low'
select * from Countries where Income_Level = 'Low';

-- 3. Countries in the region 'Europe'
select * from Countries where Region = 'Europe';

-- 4. Countries that are UN members (Yes)
select * from Countries where UN_Member = 'Yes';

-- 5. Countries with population > 500,000,000
select * from Countries where Population > 500000000;

-- 6. Countries with area between 1,000,000 and 5,000,000 sq km
select * from Countries where AreaSqKm between 1000000 and 5000000;

-- 7. Countries whose name starts with 'U'
select * from Countries where Name like 'U%';

-- 8. Countries whose capital ends with 'a'
select * from Countries where Capital like '%a';

-- 9. Countries using currency in ('USD','EUR','GBP')
select * from Countries where Currency in ('USD','EUR','GBP');

-- 10. Countries NOT in region 'Americas'
select * from Countries where Region <> 'Americas';

-- 11. Distinct list of regions
select distinct Region from Countries;

-- 12. Total number of countries
select count(*) as Total_Countries from Countries;

-- 13. Countries ordered by population (descending)
select * from Countries order by Population desc;

-- 14. Top 5 most populous countries
select * from Countries order by Population desc limit 5;

-- 15. Countries ordered by area (ascending)
select * from Countries order by AreaSqKm asc;

-- 16. Number of countries per region
select Region, count(*) as Country_Count from Countries group by Region;

-- 17. Average population by region
select Region, avg(Population) as Avg_Population from Countries group by Region;

-- 18. Total population by region
select Region, sum(Population) as Total_Population from Countries group by Region;

-- 19. Largest area country per region (name + area)
select c.Region, c.Name, c.AreaSqKm
from Countries c
join (
  select Region, max(AreaSqKm) as MaxArea from Countries group by Region
) m on c.Region = m.Region and c.AreaSqKm = m.MaxArea;

-- 20. Countries where language in ('English','French')
select * from Countries where Language in ('English','French');

-- 21. Compute population density (people per sq km)
select Name, round(Population / nullif(AreaSqKm,0), 2) as Pop_Density
from Countries
order by Pop_Density desc;

-- 22. CASE: label income level
select Name,
       case Income_Level
         when 'High' then 'High Income'
         when 'Middle' then 'Middle Income'
         else 'Low Income'
       end as Income_Label
from Countries;

-- 23. CASE: population category
select Name,
       case
         when Population >= 1000000000 then '≥1B'
         when Population >= 100000000  then '100M–999M'
         else '<100M'
       end as Pop_Category
from Countries;

-- 24. CASE: region grouping (South-East Asia vs Others)
select Name, Region,
       case
         when Region = 'South-East Asia' then 'South-East Asia'
         else 'Other Regions'
       end as Region_Group
from Countries;

-- 25. CASE: UN membership description
select Name, UN_Member,
       case UN_Member
         when 'Yes' then 'UN Member State'
         else 'Not a UN Member'
       end as UN_Status_Desc
from Countries;

-- 26. CASE: density classification using computed density
select Name,
       case
         when Population / nullif(AreaSqKm,0) > 300 then 'High Density'
         when Population / nullif(AreaSqKm,0) between 100 and 300 then 'Medium Density'
         else 'Low Density'
       end as Density_Class
from Countries;

-- 27. Countries whose name contains a space (multi-word names)
select * from Countries where Name like '% %';

-- 28. Countries where capital is different from name (most cases)
select * from Countries where Capital <> Name;

-- 29. Countries whose currency is not null
select * from Countries where Currency is not null;

-- 30. Countries in ('Africa','Europe') with High or Middle income
select * from Countries
where Region in ('Africa','Europe') and Income_Level in ('High','Middle');

-- 31. DML: insert a new country (example record)
insert into Countries
(CountryID, Name, Region, Population, AreaSqKm, Capital, Currency, Language, Income_Level, UN_Member)
values (21, 'Nepal', 'South-East Asia', 30000000, 147516, 'Kathmandu', 'NPR', 'Nepali', 'Low', 'Yes');

-- 32. DML: insert multiple new countries (example records)
insert into Countries
(CountryID, Name, Region, Population, AreaSqKm, Capital, Currency, Language, Income_Level, UN_Member)
values
(22, 'Sweden', 'Europe', 10500000, 450295, 'Stockholm', 'SEK', 'Swedish', 'High', 'Yes'),
(23, 'Norway', 'Europe', 5400000, 385207, 'Oslo', 'NOK', 'Norwegian', 'High', 'Yes');

-- 33. DML: update currency to 'EUR' for European countries except UK & Russia
update Countries
set Currency = 'EUR'
where Region = 'Europe' and Name not in ('United Kingdom','Russia');

-- 34. DML: increase population by 1% for India
update Countries
set Population = round(Population * 1.01)
where Name = 'India';

-- 35. DML: set UN_Member = 'No' for a test row (CountryID = 21)
update Countries set UN_Member = 'No' where CountryID = 21;

-- 36. DML: delete the test row (CountryID = 21)
delete from Countries where CountryID = 21;

-- 37. DML: delete countries marked as UN_Member = 'No'
delete from Countries where UN_Member = 'No';

-- 38. DML: upsert (insert or update on duplicate key) example
insert into Countries
(CountryID, Name, Region, Population, AreaSqKm, Capital, Currency, Language, Income_Level, UN_Member)
values (99, 'Testland', 'Europe', 1000000, 50000, 'Test City', 'EUR', 'Testish', 'Middle', 'Yes')
on duplicate key update
  Population = values(Population),
  Capital    = values(Capital);

-- 39. DDL: create index on Name
create index idx_countries_name on Countries(Name);

-- 40. DDL: drop index on Name
drop index idx_countries_name on Countries;

-- 41. DDL: create index on Region
create index idx_countries_region on Countries(Region);

-- 42. DDL: drop index on Region
drop index idx_countries_region on Countries;

-- 43. DDL: add a UNIQUE constraint on Capital
alter table Countries add constraint uq_countries_capital unique (Capital);

-- 44. DDL: drop the UNIQUE constraint on Capital
alter table Countries drop index uq_countries_capital;

-- 45. DDL: add a CHECK constraint to ensure positive AreaSqKm
alter table Countries add constraint chk_area_positive check (AreaSqKm > 0);

-- 46. DDL: drop the CHECK constraint on area
alter table Countries drop check chk_area_positive;

-- 47. DDL: modify Region length to 100 (still NOT NULL)
alter table Countries modify Region varchar(100) not null;

-- 48. DDL: create composite index on (Region, Income_Level)
create index idx_region_income on Countries(Region, Income_Level);

-- 49. DDL: drop composite index on (Region, Income_Level)
drop index idx_region_income on Countries;

-- 50. DQL: custom sort by Income_Level using CASE (High, then Middle, then Low)
select *
from Countries
order by case Income_Level
           when 'High' then 1
           when 'Middle' then 2
           else 3
         end, Name;

-- Table-2 Diseases----------------------------------------------------------------------------------------------------------
-- 1. Diseases with severity = 'Critical'
select * from Diseases where Severity_Level = 'Critical';

-- 2. Diseases with severity = 'High'
select * from Diseases where Severity_Level = 'High';

-- 3. Diseases with Vaccine_Available = TRUE
select * from Diseases where Vaccine_Available = TRUE;

-- 4. Diseases with Vaccine_Available = FALSE
select * from Diseases where Vaccine_Available = FALSE;

-- 5. Diseases of type 'Viral'
select * from Diseases where Type = 'Viral';

-- 6. Diseases of type 'Bacterial'
select * from Diseases where Type = 'Bacterial';

-- 7. Distinct list of disease types
select distinct Type from Diseases;

-- 8. Distinct list of severity levels
select distinct Severity_Level from Diseases;

-- 9. Diseases originating in 'India'
select * from Diseases where Origin_Country = 'India';

-- 10. Diseases first reported before year 1900
select * from Diseases where First_Reported_Year < '1900-01-01';

-- 11. Diseases reported after year 2000
select * from Diseases where First_Reported_Year > '2000-01-01';

-- 12. Diseases with ICDCode starting with 'A'
select * from Diseases where ICDCode like 'A%';

-- 13. Diseases with ICDCode starting with 'B'
select * from Diseases where ICDCode like 'B%';

-- 14. Diseases ordered by First_Reported_Year ascending
select * from Diseases order by First_Reported_Year asc;

-- 15. Diseases ordered by First_Reported_Year descending
select * from Diseases order by First_Reported_Year desc;

-- 16. Diseases where Transmission_Mode contains 'Airborne'
select * from Diseases where Transmission_Mode like '%Airborne%';

-- 17. Diseases where Symptome contains 'Fever'
select * from Diseases where Symptome like '%Fever%';

-- 18. Diseases originating in Africa region
select * from Diseases where Origin_Country like '%Africa%';

-- 19. Count diseases by severity level
select Severity_Level, count(*) as Disease_Count
from Diseases group by Severity_Level;

-- 20. Count diseases by type
select Type, count(*) as Disease_Count
from Diseases group by Type;

-- 21. Count diseases with/without vaccines
select Vaccine_Available, count(*) as Total
from Diseases group by Vaccine_Available;

-- 22. CASE: Vaccine availability description
select Name, Vaccine_Available,
       case Vaccine_Available
         when TRUE then 'Has Vaccine'
         else 'No Vaccine'
       end as Vaccine_Status
from Diseases;

-- 23. CASE: classify severity into risk categories
select Name, Severity_Level,
       case Severity_Level
         when 'Critical' then 'Extreme Risk'
         when 'High' then 'Severe Risk'
         when 'Medium' then 'Moderate Risk'
         else 'Low Risk'
       end as Risk_Category
from Diseases;

-- 24. CASE: classify based on year of discovery
select Name, First_Reported_Year,
       case
         when First_Reported_Year < '1900-01-01' then '19th Century or Earlier'
         when First_Reported_Year < '2000-01-01' then '20th Century'
         else '21st Century'
       end as Era
from Diseases;

-- 25. Diseases with multiple transmission modes
select * from Diseases where Transmission_Mode like '%,%';

-- 26. Diseases with name length > 10
select * from Diseases where length(Name) > 10;

-- 27. Diseases where Origin_Country not in ('USA','India','China')
select * from Diseases where Origin_Country not in ('USA','India','China');

-- 28. Diseases whose name starts with 'H'
select * from Diseases where Name like 'H%';

-- 29. Diseases whose name ends with 'a'
select * from Diseases where Name like '%a';

-- 30. Diseases discovered in the 20th century (1900–1999)
select * from Diseases
where First_Reported_Year between '1900-01-01' and '1999-12-31';

-- 31. Insert a new disease record (example DML)
insert into Diseases
(DiseaseID, Name, Type, ICDCode, Severity_Level, Vaccine_Available, Origin_Country, First_Reported_Year, Transmission_Mode, Symptome)
values (21, 'TestDisease', 'Viral', 'T99', 'Low', FALSE, 'Testland', '2020-01-01', 'Contact', 'Test symptom');

-- 32. Insert multiple diseases (example DML)
insert into Diseases
(DiseaseID, Name, Type, ICDCode, Severity_Level, Vaccine_Available, Origin_Country, First_Reported_Year, Transmission_Mode, Symptome)
values
(22, 'AlphaVirus', 'Viral', 'A99', 'Medium', TRUE, 'Australia', '2005-01-01', 'Airborne', 'Headache, Fatigue'),
(23, 'BetaBacteria', 'Bacterial', 'B99', 'High', FALSE, 'Brazil', '1995-01-01', 'Foodborne', 'Diarrhea, Vomiting');

set sql_safe_updates = 0;
-- 33. Update severity level to 'Critical' for Ebola
update Diseases set Severity_Level = 'Critical' where Name = 'Ebola';

-- 34. Update Origin_Country to 'Worldwide' for Global diseases
update Diseases set Origin_Country = 'Worldwide'
where Origin_Country = 'Global';

-- 35. Update Vaccine_Available = TRUE where severity = 'Medium'
update Diseases set Vaccine_Available = TRUE where Severity_Level = 'Medium';

-- 36. Delete disease with DiseaseID = 21 (test row)
delete from Diseases where DiseaseID = 21;

-- 37. Delete all diseases with Severity_Level = 'Low'
delete from Diseases where Severity_Level = 'Low';

-- 38. Upsert (insert or update if exists) for Diseases
insert into Diseases (DiseaseID, Name, Type, ICDCode, Severity_Level, Vaccine_Available, Origin_Country, First_Reported_Year, Transmission_Mode, Symptome)
values (99, 'OmegaVirus', 'Viral', 'O99', 'Medium', FALSE, 'Nowhere', '2022-01-01', 'Droplets', 'Unknown')
on duplicate key update
  Severity_Level = values(Severity_Level),
  Vaccine_Available = values(Vaccine_Available);

-- 39. DDL: create index on Name
create index idx_diseases_name on Diseases(Name);

-- 40. DDL: drop index on Name
drop index idx_diseases_name on Diseases;

-- 41. DDL: create index on Severity_Level
create index idx_diseases_severity on Diseases(Severity_Level);

-- 42. DDL: drop index on Severity_Level
drop index idx_diseases_severity on Diseases;

-- 43. DDL: add unique constraint on Name
alter table Diseases add constraint uq_disease_name unique (Name);

-- 44. DDL: drop unique constraint on Name
alter table Diseases drop index uq_disease_name;

-- 45. DDL: add check to enforce non-empty Transmission_Mode
alter table Diseases add constraint chk_transmission check (Transmission_Mode <> '');

-- 46. DDL: drop check on transmission
alter table Diseases drop check chk_transmission;

-- 47. DDL: modify column Origin_Country to varchar(150)
alter table Diseases modify Origin_Country varchar(150);

-- 48. Create composite index on (Type, Severity_Level)
create index idx_type_severity on Diseases(Type, Severity_Level);

-- 49. Drop composite index on (Type, Severity_Level)
drop index idx_type_severity on Diseases;

-- 50. DQL: custom sort by Severity_Level order (Critical, High, Medium, Low)
select *
from Diseases
order by case Severity_Level
           when 'Critical' then 1
           when 'High' then 2
           when 'Medium' then 3
           else 4
         end, Name;

-- Table-3 Disease_Cases-----------------------------------------------------------------------------------------------------
-- 1. All cases reported in 2020
select * from Disease_Cases where year(Report_Date) = 2020;

-- 2. Countries with more than 50,000 confirmed cases
select * from Disease_Cases where Confirmed_Cases > 50000;

-- 3. Cases where deaths are greater than recoveries
select * from Disease_Cases where Deaths > Recoveries;

-- 4. Cases with zero deaths
select * from Disease_Cases where Deaths = 0;

-- 5. Cases where Active_Cases is not null
select * from Disease_Cases where Active_Cases is not null;

-- 6. Update source name for a specific record
update Disease_Cases set Source = 'World Health Organization' where CaseID = 2;

-- 7. Delete cases reported before 2005
delete from Disease_Cases where Report_Date < '2005-01-01';

-- 8. Add a new column for Case_Status
alter table Disease_Cases add Case_Status varchar(50);

-- 9. Drop column Notes
alter table Disease_Cases drop column Notes;

-- 10. Count total number of cases reported
select count(*) as Total_Cases from Disease_Cases;

-- 11. Maximum number of confirmed cases
select max(Confirmed_Cases) as Max_Confirmed from Disease_Cases;

-- 12. Minimum number of deaths
select min(Deaths) as Min_Deaths from Disease_Cases;

-- 13. Average recoveries
select avg(Recoveries) as Avg_Recoveries from Disease_Cases;

-- 14. Total deaths by country
select Country_ID, sum(Deaths) as Total_Deaths 
from Disease_Cases group by Country_ID;

-- 15. Highest active cases by disease
select Disease_ID, max(Active_Cases) as Max_Active 
from Disease_Cases group by Disease_ID;

-- 16. Distinct sources reporting
select distinct Source from Disease_Cases;

-- 17. Find cases with Confirmed_Cases between 1000 and 10000
select * from Disease_Cases where Confirmed_Cases between 1000 and 10000;

-- 18. Cases where Source contains 'CDC'
select * from Disease_Cases where Source like '%CDC%';

-- 19. Order cases by Report_Date descending
select * from Disease_Cases order by Report_Date desc;

-- 20. Show top 5 cases with highest deaths
select * from Disease_Cases order by Deaths desc limit 5;

-- 21. Countries with total confirmed > 1 million
select Country_ID, sum(Confirmed_Cases) as TotalConfirmed 
from Disease_Cases group by Country_ID having sum(Confirmed_Cases) > 1000000;

-- 22. Insert a new case
insert into Disease_Cases 
(CaseID, Country_ID, Disease_ID, Report_Date, Confirmed_Cases, Deaths, Recoveries, Active_Cases, Source, Notes)
values (21, 1, 2, '2024-01-01', 2000, 20, 1500, 480, 'India MOH', 'New malaria cases');

-- 23. Change Active_Cases for CaseID=5
update Disease_Cases set Active_Cases = 1000 where CaseID = 5;

-- 24. Delete record with CaseID=21
delete from Disease_Cases where CaseID = 21;

-- 25. Rename table
alter table Disease_Cases rename to Cases_Reports;

-- 26. Rename it back
alter table Cases_Reports rename to Disease_Cases;

-- 27. Find average mortality rate (Deaths/Confirmed_Cases)
select avg(cast(Deaths as float)/Confirmed_Cases)*100 as Avg_MortalityRate
from Disease_Cases where Confirmed_Cases > 0;

-- 28. Case statement to classify case severity
select CaseID, Confirmed_Cases,
case 
    when Confirmed_Cases > 100000 then 'Severe'
    when Confirmed_Cases between 10000 and 100000 then 'Moderate'
    else 'Mild'
end as Case_Severity
from Disease_Cases;

-- 29. Cases where Active_Cases = (Confirmed - Deaths - Recoveries)
select * from Disease_Cases 
where Active_Cases = (Confirmed_Cases - Deaths - Recoveries);

-- 30. Show first reported case per country
select Country_ID, min(Report_Date) as First_Report 
from Disease_Cases group by Country_ID;

-- 31. Count distinct diseases reported
select count(distinct Disease_ID) as DistinctDiseases from Disease_Cases;

-- 32. Cases reported in South-East Asia countries
select * from Disease_Cases 
where Country_ID in (select CountryID from Countries where Region='South-East Asia');

-- 33. Join with Diseases to show disease name
select dc.CaseID, d.Name as DiseaseName, dc.Confirmed_Cases, dc.Deaths
from Disease_Cases dc
join Diseases d on dc.Disease_ID = d.DiseaseID;

-- 34. Join with Countries to show country name
select dc.CaseID, c.Name as Country, dc.Confirmed_Cases, dc.Deaths
from Disease_Cases dc
join Countries c on dc.Country_ID = c.CountryID;

-- 35. CaseID and ratio of recoveries to confirmed
select CaseID, (Recoveries*1.0/Confirmed_Cases)*100 as RecoveryRate 
from Disease_Cases where Confirmed_Cases > 0;

-- 36. Cases reported in last 5 years
select * from Disease_Cases where Report_Date >= date_sub(curdate(), interval 5 year);

-- 37. Countries with no deaths reported
select distinct Country_ID from Disease_Cases where Deaths = 0;

-- 38. Total active cases worldwide
select sum(Active_Cases) as GlobalActive from Disease_Cases;

-- 39. CaseIDs where Notes is not null
select CaseID from Disease_Cases where Notes is not null;

-- 40. Cases reported by ministries (Source contains 'Ministry')
select * from Disease_Cases where Source like '%Ministry%';

-- 41. Group by year and count cases
select year(Report_Date) as Year, count(*) as CaseCount
from Disease_Cases group by year(Report_Date);

-- 42. Show CaseID and formatted report date
select CaseID, date_format(Report_Date, '%d-%m-%Y') as FormattedDate from Disease_Cases;

-- 43. Cases with mortality rate > 10%
select CaseID, (Deaths*1.0/Confirmed_Cases)*100 as MortalityRate
from Disease_Cases where Confirmed_Cases > 0 and (Deaths*1.0/Confirmed_Cases) > 0.1;

-- 44. Countries with max confirmed cases per disease
select Disease_ID, Country_ID, max(Confirmed_Cases) as MaxCases
from Disease_Cases group by Disease_ID, Country_ID;

-- 45. Case classification based on deaths
select CaseID, Deaths,
case 
    when Deaths > 10000 then 'High Fatality'
    when Deaths between 1000 and 10000 then 'Medium Fatality'
    else 'Low Fatality'
end as Fatality_Level
from Disease_Cases;

-- 46. Update notes for all cases with Active_Cases > 10000
update Disease_Cases set Notes = 'High active case load'
where Active_Cases > 10000;

-- 47. Delete cases with Confirmed=0
delete from Disease_Cases where Confirmed_Cases = 0;

-- 48. Number of cases reported per disease
select Disease_ID, count(*) as NumReports from Disease_Cases group by Disease_ID;

-- 49. Most recent case reported
select * from Disease_Cases order by Report_Date desc limit 1;

-- 50. Least recoveries recorded
select * from Disease_Cases order by Recoveries asc limit 1;

-- Table-4 Vaccines----------------------------------------------------------------------------------------------------------
-- 1. Vaccines with efficacy > 90
select * from Vaccines where Efficacy > 90;

-- 2. Vaccines requiring more than 2 doses
select * from Vaccines where Doses_Required > 2;

-- 3. Vaccines manufactured by 'Sanofi Pasteur'
select * from Vaccines where Manufacturer = 'Sanofi Pasteur';

-- 4. Vaccines with status 'Approved'
select * from Vaccines where Status = 'Approved';

-- 5. Vaccines ordered by efficacy descending
select * from Vaccines order by Efficacy desc;

-- 6. Vaccines approved before year 2000
select * from Vaccines where year(Approval_Date) < 2000;

-- 7. Vaccines stored at '-70°C'
select * from Vaccines where Storage_Temp = '-70°C';

-- 8. Count vaccines per manufacturer
select Manufacturer, count(*) as Total from Vaccines group by Manufacturer;

-- 9. Average efficacy of all vaccines
select avg(Efficacy) as Avg_Efficacy from Vaccines;

-- 10. Minimum and maximum efficacy
select min(Efficacy) as Min_Efficacy, max(Efficacy) as Max_Efficacy from Vaccines;

-- 11. Vaccines with efficacy between 80 and 95
select * from Vaccines where Efficacy between 80 and 95;

-- 12. Vaccines starting with 'C'
select * from Vaccines where Name like 'C%';

-- 13. Vaccines approved after 2010
select * from Vaccines where Approval_Date > '2010-01-01';

-- 14. Distinct manufacturers
select distinct Manufacturer from Vaccines;

-- 15. Total vaccines available
select count(*) as Total_Vaccines from Vaccines;

-- 16. Vaccines requiring exactly 1 dose
select * from Vaccines where Doses_Required = 1;

-- 17. Update efficacy of 'Covishield' to 72
update Vaccines set Efficacy = 72 where Name = 'Covishield';

-- 18. Delete vaccines with efficacy < 60
delete from Vaccines where Efficacy < 60;

-- 19. Add a new column 'WHO_Approved'
alter table Vaccines add column WHO_Approved varchar(3) default 'Yes';

-- 20. Drop the WHO_Approved column
alter table Vaccines drop column WHO_Approved;

-- 21. Rename column 'Side_Effects' to 'Adverse_Reactions'
alter table Vaccines rename column Side_Effects to Adverse_Reactions;

-- 22. Vaccines for disease ID = 1
select * from Vaccines where Disease_ID = 1;

-- 23. CASE: categorize vaccines by efficacy
select Name, 
case 
    when Efficacy >= 90 then 'Highly Effective'
    when Efficacy >= 70 then 'Moderately Effective'
    else 'Low Effectiveness'
end as Effectiveness_Category
from Vaccines;

-- 24. Vaccines approved between 1990 and 2000
select * from Vaccines where Approval_Date between '1990-01-01' and '2000-12-31';

-- 25. Count vaccines by storage temperature
select Storage_Temp, count(*) as Vaccine_Count from Vaccines group by Storage_Temp;

-- 26. Top 5 most effective vaccines
select * from Vaccines order by Efficacy desc limit 5;

-- 27. Vaccines with efficacy = 100
select * from Vaccines where Efficacy = 100;

-- 28. Vaccines with 3 doses and efficacy > 90
select * from Vaccines where Doses_Required = 3 and Efficacy > 90;

-- 29. Vaccines with NULL storage temperature
select * from Vaccines where Storage_Temp is null;

-- 30. Vaccines approved in the 20th century
select * from Vaccines where year(Approval_Date) between 1900 and 1999;

-- 31. Add constraint to ensure Efficacy <= 100
alter table Vaccines add constraint chk_efficacy check (Efficacy <= 100);

-- 32. Change column type of Manufacturer to varchar(150)
alter table Vaccines modify column Manufacturer varchar(150);

-- 33. Count vaccines approved after 2000
select count(*) from Vaccines where year(Approval_Date) > 2000;

-- 34. Vaccines with names ending in 'V'
select * from Vaccines where Name like '%V';

-- 35. Vaccines with 'Merck' as manufacturer and efficacy > 90
select * from Vaccines where Manufacturer = 'Merck' and Efficacy > 90;

-- 36. Vaccines for viral diseases (join with Diseases)
select v.Name, d.Name as Disease_Name
from Vaccines v join Diseases d on v.Disease_ID = d.DiseaseID
where d.Type = 'Viral';

-- 37. Vaccines efficacy rounded to nearest integer
select Name, round(Efficacy,0) as Rounded_Efficacy from Vaccines;

-- 38. Vaccines approved in last 10 years
select * from Vaccines where Approval_Date > (current_date - interval 10 year);

-- 39. Vaccines with efficacy not between 70 and 90
select * from Vaccines where Efficacy not between 70 and 90;

-- 40. Vaccines requiring maximum doses
select * from Vaccines where Doses_Required = (select max(Doses_Required) from Vaccines);

-- 41. Total doses required for all vaccines
select sum(Doses_Required) as Total_Doses from Vaccines;

-- 42. Update status of 'Rabipur' to 'Under Review'
update Vaccines set Status = 'Under Review' where Name = 'Rabipur';

-- 43. Vaccines manufactured by 'GSK'
select * from Vaccines where Manufacturer = 'GSK';

-- 44. Vaccines with more than 1 side effect listed (rough check with comma)
select * from Vaccines where Adverse_Reactions like '%,%';

-- 45. Delete vaccine 'Fluzone'
delete from Vaccines where Name = 'Fluzone';

-- 46. CASE: classify doses
select Name, 
case 
    when Doses_Required = 1 then 'Single Dose'
    when Doses_Required = 2 then 'Two Doses'
    else 'Multiple Doses'
end as Dose_Category
from Vaccines;

-- 47. Vaccines approved in month of January
select * from Vaccines where extract(month from Approval_Date) = 1;

-- 48. Count distinct storage conditions
select count(distinct Storage_Temp) from Vaccines;

-- 49. Vaccines with highest efficacy per manufacturer
select v.* from Vaccines v
where Efficacy = (select max(Efficacy) from Vaccines where Manufacturer = v.Manufacturer);

-- 50. Vaccines efficacy grouped by decade
select (extract(year from Approval_Date)/10)*10 as Decade, avg(Efficacy) as Avg_Efficacy
from Vaccines group by Decade order by Decade;

-- Table-5 Vaccination_Records-----------------------------------------------------------------------------------------------
-- 1. Records where Total_Vaccinated > 1,000,000
select * from Vaccination_Records where Total_Vaccinated > 1000000;

-- 2. Records for campaign name like '%COVID%'
select * from Vaccination_Records where Campaign_Name like '%COVID%';

-- 3. Records where Gender = 'Female'
select * from Vaccination_Records where Gender = 'Female';

-- 4. Records for Age_Group = 'All'
select * from Vaccination_Records where Age_Group = 'All';

-- 5. Count vaccination records per Gender
select Gender, count(*) as Records_Count from Vaccination_Records group by Gender;

-- 6. Count total vaccinated by Country
select Country_ID, sum(Total_Vaccinated) as Total_Vaccinations
from Vaccination_Records group by Country_ID;

-- 7. Records where Booster_Doses > 10000
select * from Vaccination_Records where Booster_Doses > 10000;

-- 8. Vaccination records reported in 2022
select * from Vaccination_Records where extract(year from Report_Date) = 2022;

-- 9. Vaccines used in more than one record
select Vaccine_ID, count(*) as Usage_Count 
from Vaccination_Records group by Vaccine_ID having count(*) > 1;

-- 10. Average Fully_Vaccinated across all campaigns
select avg(Fully_Vaccinated) as Avg_Fully_Vaccinated from Vaccination_Records;

-- 11. Minimum and maximum Booster_Doses
select min(Booster_Doses) as Min_Boosters, max(Booster_Doses) as Max_Boosters from Vaccination_Records;

-- 12. Records with Total_Vaccinated = Fully_Vaccinated
select * from Vaccination_Records where Total_Vaccinated = Fully_Vaccinated;

-- 13. Records for campaigns starting with 'Hepatitis'
select * from Vaccination_Records where Campaign_Name like 'Hepatitis%';

-- 14. Records where Report_Date is before 2021
select * from Vaccination_Records where Report_Date < '2021-01-01';

-- 15. Total vaccinated grouped by Age_Group
select Age_Group, sum(Total_Vaccinated) as TotalVaccinated
from Vaccination_Records group by Age_Group;

-- 16. Update Fully_Vaccinated where Booster_Doses > 2000
update Vaccination_Records set Fully_Vaccinated = Fully_Vaccinated + 5000
where Booster_Doses > 2000;

-- 17. Delete records where Total_Vaccinated < 10000
delete from Vaccination_Records where Total_Vaccinated < 10000;

-- 18. Add a new column 'Coverage_Percentage'
alter table Vaccination_Records add column Coverage_Percentage float;

-- 19. Drop the Coverage_Percentage column
alter table Vaccination_Records drop column Coverage_Percentage;

-- 20. Rename column 'Campaign_Name' to 'Program_Name'
alter table Vaccination_Records rename column Campaign_Name to Program_Name;

-- 21. CASE: classify campaigns by vaccination size
select Campaign_Name,
case
    when Total_Vaccinated > 10000000 then 'Large Scale'
    when Total_Vaccinated > 100000 then 'Medium Scale'
    else 'Small Scale'
end as Campaign_Size
from Vaccination_Records;

-- 22. Records where Fully_Vaccinated >= 90% of Total_Vaccinated
select * from Vaccination_Records 
where Fully_Vaccinated >= 0.9 * Total_Vaccinated;

-- 23. Count campaigns per year
select extract(year from Report_Date) as Year, count(*) as Campaigns
from Vaccination_Records group by extract(year from Report_Date);

-- 24. Campaign with highest Total_Vaccinated
select * from Vaccination_Records
where Total_Vaccinated = (select max(Total_Vaccinated) from Vaccination_Records);

-- 25. Distinct Age_Groups covered
select distinct Age_Group from Vaccination_Records;

-- 26. Records with Gender = 'Other'
select * from Vaccination_Records where Gender = 'Other';

-- 27. Records with booster doses between 1000 and 3000
select * from Vaccination_Records where Booster_Doses between 1000 and 3000;

-- 28. Join with Countries: show Country name and campaign
select c.Name as Country, vr.Campaign_Name, vr.Total_Vaccinated
from Vaccination_Records vr
join Countries c on vr.Country_ID = c.CountryID;

-- 29. Join with Vaccines: show Vaccine name and campaign
select v.Name as Vaccine, vr.Campaign_Name, vr.Total_Vaccinated
from Vaccination_Records vr
join Vaccines v on vr.Vaccine_ID = v.VaccineID;

-- 30. Top 3 campaigns with most boosters
select * from Vaccination_Records order by Booster_Doses desc limit 3;

-- 31. Count campaigns by Gender and Age_Group
select Gender, Age_Group, count(*) as Campaign_Count
from Vaccination_Records group by Gender, Age_Group;

-- 32. Records with NULL Booster_Doses
select * from Vaccination_Records where Booster_Doses is null;

-- 33. Add constraint to ensure Fully_Vaccinated <= Total_Vaccinated
alter table Vaccination_Records add constraint chk_fully check (Fully_Vaccinated <= Total_Vaccinated);

-- 34. Change data type of Age_Group to varchar(60)
alter table Vaccination_Records modify column Age_Group varchar(60);

-- 35. Campaigns reported in first quarter of 2021
select * from Vaccination_Records 
where Report_Date between '2021-01-01' and '2021-03-31';

-- 36. Records with highest Fully_Vaccinated per vaccine
select vr.* from Vaccination_Records vr
where Fully_Vaccinated = (select max(Fully_Vaccinated) from Vaccination_Records where Vaccine_ID = vr.Vaccine_ID);

-- 37. Records approved in July
select * from Vaccination_Records where extract(month from Report_Date) = 7;

-- 38. Count records by country and year
select Country_ID, extract(year from Report_Date) as Year, count(*) as Records
from Vaccination_Records group by Country_ID, extract(year from Report_Date);

-- 39. Delete record with Campaign_Name = 'Ebola Frontline Workers'
delete from Vaccination_Records where Campaign_Name = 'Ebola Frontline Workers';

-- 40. Update Booster_Doses = Booster_Doses + 500 where Age_Group = '60+'
update Vaccination_Records set Booster_Doses = Booster_Doses + 500 where Age_Group = '60+';

-- 41. Total vaccinations grouped by Gender
select Gender, sum(Total_Vaccinated) as TotalVaccinated
from Vaccination_Records group by Gender;

-- 42. CASE: categorize by booster presence
select Campaign_Name,
case
    when Booster_Doses = 0 then 'No Boosters'
    when Booster_Doses < 1000 then 'Low Boosters'
    else 'High Boosters'
end as Booster_Category
from Vaccination_Records;

-- 43. Campaigns where more than 90% of vaccinated received boosters
select * from Vaccination_Records 
where Booster_Doses > 0.9 * Total_Vaccinated;

-- 44. Top 5 campaigns with highest vaccination coverage
select * from Vaccination_Records order by Total_Vaccinated desc limit 5;

-- 45. Count campaigns for each vaccine
select Vaccine_ID, count(*) as Campaigns from Vaccination_Records group by Vaccine_ID;

-- 46. Records with Report_Date after 2022 and Age_Group = 'All'
select * from Vaccination_Records where Report_Date > '2022-01-01' and Age_Group = 'All';

-- 47. Distinct years when vaccination campaigns happened
select distinct extract(year from Report_Date) as Year from Vaccination_Records;

-- 48. Total vaccinated, fully vaccinated, boosters by vaccine
select Vaccine_ID, sum(Total_Vaccinated) as Total, sum(Fully_Vaccinated) as Fully, sum(Booster_Doses) as Boosters
from Vaccination_Records group by Vaccine_ID;

-- 49. Campaign with lowest Fully_Vaccinated percentage
select *, 
       (cast(Fully_Vaccinated as decimal(10,2)) / Total_Vaccinated) * 100 as Fully_Percentage
from Vaccination_Records
order by Fully_Percentage asc
limit 1;

-- 50. Average Total_Vaccinated grouped by decade
select (extract(year from Report_Date)/10)*10 as Decade, avg(Total_Vaccinated) as AvgVaccinated
from Vaccination_Records group by Decade order by Decade;

-- Table-6 Hospitals---------------------------------------------------------------------------------------------------------
-- 1. List hospitals with capacity greater than 2000
select * from hospitals where capacity > 2000;

-- 2. Hospitals located in 'Berlin'
select * from hospitals where city = 'Berlin';

-- 3. Hospitals established before 1900
select * from hospitals where established_date < '1900-01-01';

-- 4. Hospitals that are public
select * from hospitals where public = 'Yes';

-- 5. Hospitals that are private
select * from hospitals where public = 'No';

-- 6. Hospitals with accreditation = 'JCI'
select * from hospitals where accreditation = 'JCI';

-- 7. Hospitals with type = 'Teaching'
select * from hospitals where type = 'Teaching';

-- 8. Hospitals in cities starting with 'M'
select * from hospitals where city like 'M%';

-- 9. Hospitals in cities ending with 'a'
select * from hospitals where city like '%a';

-- 10. Hospitals whose name contains 'General'
select * from hospitals where name like '%General%';

-- 11. Hospitals established between 1800 and 1900
select * from hospitals where established_date between '1800-01-01' and '1900-12-31';

-- 12. Sort hospitals by capacity descending
select * from hospitals order by capacity desc;

-- 13. Sort hospitals by established date ascending
select * from hospitals order by established_date asc;

-- 14. Find top 5 largest hospitals by capacity
select * from hospitals order by capacity desc limit 5;

-- 15. Find 3 oldest hospitals
select * from hospitals order by established_date asc limit 3;

-- 16. Count total hospitals
select count(*) from hospitals;

-- 17. Count hospitals by type
select type, count(*) from hospitals group by type;

-- 18. Count hospitals by public/private
select public, count(*) from hospitals group by public;

-- 19. Average hospital capacity
select avg(capacity) as avg_capacity from hospitals;

-- 20. Maximum hospital capacity
select max(capacity) as max_capacity from hospitals;

-- 21. Minimum hospital capacity
select min(capacity) as min_capacity from hospitals;

-- 22. Add a new column website
alter table hospitals add column website varchar(150);

-- 23. Drop column website
alter table hospitals drop column website;

-- 24. Rename column name to hospital_name
alter table hospitals rename column name to hospital_name;

-- 25. Change data type of contact
alter table hospitals modify contact varchar(100);

-- 26. Insert a new hospital
insert into hospitals 
values (21, 'Test Hospital', 1, 'TestCity', 500, '+91-1234567890', 'General', 'Yes', '2000-01-01', 'ISO');

-- 27. Update capacity of 'Test Hospital' to 800
update hospitals set capacity = 800 where hospitalid = 21;

-- 28. Delete hospital 'Test Hospital'
delete from hospitals where hospitalid = 21;

-- 29. Display hospitals with null accreditation
select * from hospitals where accreditation is null;

-- 30. Display hospitals with non-null accreditation
select * from hospitals where accreditation is not null;

-- 31. Increase capacity of all hospitals by 10%
update hospitals set capacity = capacity * 1.1;

-- 32. Reduce capacity of hospitals in 'London' by 20%
update hospitals set capacity = capacity * 0.8 where city = 'London';

-- 33. Hospitals with capacity > 1500 and type = 'General'
select * from hospitals where capacity > 1500 and type = 'General';

-- 34. Hospitals in 'Paris' or accreditation = 'JCI'
select * from hospitals where city = 'Paris' or accreditation = 'JCI';

-- 35. Case statement: categorize hospitals by capacity
select name,
case
  when capacity > 2000 then 'Very Large'
  when capacity between 1000 and 2000 then 'Medium'
  else 'Small'
end as capacity_category
from hospitals;

-- 36. Case statement: mark public/private hospitals
select name,
case public
  when 'Yes' then 'Public Hospital'
  when 'No' then 'Private Hospital'
end as hospital_type
from hospitals;

-- 37. Total capacity by type
select type, sum(capacity) from hospitals group by type;

-- 38. Average capacity by city
select city, avg(capacity) from hospitals group by city;

-- 39. Find city with highest average capacity
select city, avg(capacity) as avg_cap
from hospitals group by city
order by avg_cap desc limit 1;

-- 40. Display distinct types of hospitals
select distinct type from hospitals;

-- 41. Display distinct accreditations
select distinct accreditation from hospitals;

-- 42. Hospitals with accreditation like '%ISO%'
select * from hospitals where accreditation like '%ISO%';

-- 43. Hospitals with name length > 20
select * from hospitals where length(name) > 20;

-- 44. Add a check constraint on capacity
alter table hospitals add constraint chk_capacity check (capacity >= 0);

-- 45. Drop check constraint on capacity
alter table hospitals drop check chk_capacity;

-- 46. Create an index on Name
create index idx_hosp_name on hospitals(name);

-- 47. Drop index on Name
drop index idx_hosp_name on hospitals;

-- 48. Truncate table hospitals
truncate table hospitals;

-- 49. Drop table hospitals
drop table hospitals;

-- 50. Create a copy of hospitals table
create table hospitals_copy as select * from hospitals;

-- Table-7 Doctors-----------------------------------------------------------------------------------------------------------
-- 1. Doctors with more than 15 years of experience
select * from doctors where years_experience > 15;

-- 2. Doctors specialized in 'Neurology'
select * from doctors where speciality = 'Neurology';

-- 3. Female doctors only
select * from doctors where gender = 'Female';

-- 4. Male doctors only
select * from doctors where gender = 'Male';

-- 5. Doctors available = 'Yes'
select * from doctors where available = 'Yes';

-- 6. Doctors not available
select * from doctors where available = 'No';

-- 7. Doctors from nationality 'Indian'
select * from doctors where nationality = 'Indian';

-- 8. Doctors whose name starts with 'Dr. M'
select * from doctors where name like 'Dr. M%';

-- 9. Doctors whose name ends with 'a'
select * from doctors where name like '%a';

-- 10. Doctors whose speciality contains 'Surgery'
select * from doctors where speciality like '%Surgery%';

-- 11. Doctors with experience between 10 and 20 years
select * from doctors where years_experience between 10 and 20;

-- 12. Sort doctors by years of experience descending
select * from doctors order by years_experience desc;

-- 13. Sort doctors by name ascending
select * from doctors order by name asc;

-- 14. Find top 5 most experienced doctors
select * from doctors order by years_experience desc limit 5;

-- 15. Find 3 least experienced doctors
select * from doctors order by years_experience asc limit 3;

-- 16. Count total doctors
select count(*) from doctors;

-- 17. Count doctors by gender
select gender, count(*) from doctors group by gender;

-- 18. Count doctors by speciality
select speciality, count(*) from doctors group by speciality;

-- 19. Average years of experience of doctors
select avg(years_experience) as avg_experience from doctors;

-- 20. Maximum years of experience
select max(years_experience) as max_experience from doctors;

-- 21. Minimum years of experience
select min(years_experience) as min_experience from doctors;

-- 22. Add a new column LinkedIn
alter table doctors add column linkedin varchar(150);

-- 23. Drop column LinkedIn
alter table doctors drop column linkedin;

-- 24. Rename column Name to Doctor_Name
alter table doctors rename column name to doctor_name;

-- 25. Change size of phone column
alter table doctors modify phone varchar(50);

-- 26. Insert a new doctor
insert into doctors
values (21, 'Dr. Test User', 1, 'Dentistry', 5, 'Male', 'test@demo.com', '+91-123456789', 'Yes', 'Indian');

-- 27. Update Dr. Test User’s speciality to 'General Medicine'
update doctors set speciality = 'General Medicine' where doctorid = 21;

-- 28. Delete Dr. Test User
delete from doctors where doctorid = 21;

-- 29. Display doctors with null phone
select * from doctors where phone is null;

-- 30. Display doctors with non-null email
select * from doctors where email is not null;

-- 31. Increase experience of all doctors by 2 years
update doctors set years_experience = years_experience + 2;

-- 32. Reduce experience of female doctors by 1 year
update doctors set years_experience = years_experience - 1 where gender = 'Female';

-- 33. Doctors with speciality = 'Cardiology' and available = 'Yes'
select * from doctors where speciality = 'Cardiology' and available = 'Yes';

-- 34. Doctors who are from 'British' or have > 20 years of experience
select * from doctors where nationality = 'British' or years_experience > 20;

-- 35. Case statement: categorize doctors by experience
select name,
case
  when years_experience >= 20 then 'Expert'
  when years_experience between 10 and 19 then 'Experienced'
  else 'Beginner'
end as experience_category
from doctors;

-- 36. Case statement: mark doctor availability
select name,
case available
  when 'Yes' then 'Currently Available'
  when 'No' then 'Not Available'
end as availability_status
from doctors;

-- 37. Total years of experience by speciality
select speciality, sum(years_experience) from doctors group by speciality;

-- 38. Average experience by gender
select gender, avg(years_experience) from doctors group by gender;

-- 39. Speciality with highest average experience
select speciality, avg(years_experience) as avg_exp
from doctors group by speciality
order by avg_exp desc limit 1;

-- 40. Distinct specialities of doctors
select distinct speciality from doctors;

-- 41. Distinct nationalities of doctors
select distinct nationality from doctors;

-- 42. Doctors with email ending in '.org'
select * from doctors where email like '%.org';

-- 43. Doctors with phone number length > 15
select * from doctors where length(phone) > 15;

-- 44. Add a check constraint on experience
alter table doctors add constraint chk_experience check (years_experience >= 0);

-- 45. Drop check constraint on experience
alter table doctors drop check chk_experience;

-- 46. Create index on speciality
create index idx_doc_speciality on doctors(speciality);

-- 47. Drop index on speciality
drop index idx_doc_speciality on doctors;

-- 48. Truncate table doctors
truncate table doctors;

-- 49. Drop table doctors
drop table doctors;

-- 50. Create a copy of doctors table
create table doctors_copy as select * from doctors;

-- Table-8 Health_Workers----------------------------------------------------------------------------------------------------
-- 1. All Active health workers
select * from health_workers where status = 'Active';

-- 2. All Not-Active health workers
select * from health_workers where status = 'Not-Active';

-- 3. Health workers with more than 10 years of experience
select * from health_workers where years_experience > 10;

-- 4. Nurses only
select * from health_workers where role = 'Nurse';

-- 5. Lab Technicians only
select * from health_workers where role = 'Lab Technician';

-- 6. Male health workers only
select * from health_workers where gender = 'Male';

-- 7. Female health workers only
select * from health_workers where gender = 'Female';

-- 8. Health workers from hospital 1
select * from health_workers where hospital_id = 1;

-- 9. Health workers from country 5
select * from health_workers where country_id = 5;

-- 10. Health workers with email ending in '.in'
select * from health_workers where email like '%.in';

-- 11. Health workers whose name starts with 'A'
select * from health_workers where name like 'A%';

-- 12. Health workers whose name ends with 'z'
select * from health_workers where name like '%z';

-- 13. Workers whose role contains 'Staff'
select * from health_workers where role like '%Staff%';

-- 14. Workers with experience between 5 and 10 years
select * from health_workers where years_experience between 5 and 10;

-- 15. Sort health workers by years of experience descending
select * from health_workers order by years_experience desc;

-- 16. Sort health workers by name ascending
select * from health_workers order by name asc;

-- 17. Top 5 most experienced health workers
select * from health_workers order by years_experience desc limit 5;

-- 18. Least 3 experienced health workers
select * from health_workers order by years_experience asc limit 3;

-- 19. Count total health workers
select count(*) from health_workers;

-- 20. Count health workers by gender
select gender, count(*) from health_workers group by gender;

-- 21. Count health workers by role
select role, count(*) from health_workers group by role;

-- 22. Average years of experience of health workers
select avg(years_experience) as avg_experience from health_workers;

-- 23. Maximum years of experience among health workers
select max(years_experience) from health_workers;

-- 24. Minimum years of experience among health workers
select min(years_experience) from health_workers;

-- 25. Add a new column LinkedIn
alter table health_workers add column linkedin varchar(150);

-- 26. Drop column LinkedIn
alter table health_workers drop column linkedin;

-- 27. Rename column Name to Worker_Name
alter table health_workers rename column name to worker_name;

-- 28. Modify phone column size
alter table health_workers modify phone varchar(50);

-- 29. Insert a new worker
insert into health_workers
values (21, 'Test Worker', 'Nurse', 1, 1, 4, 'Male', 'test@demo.com', '+91-1234567890', 'Active');

-- 30. Update Test Worker’s role to 'Pharmacist'
update health_workers set role = 'Pharmacist' where workerid = 21;

-- 31. Delete Test Worker
delete from health_workers where workerid = 21;

-- 32. Display health workers with null phone
select * from health_workers where phone is null;

-- 33. Display health workers with non-null email
select * from health_workers where email is not null;

-- 34. Increase all workers’ experience by 1 year
update health_workers set years_experience = years_experience + 1;

-- 35. Reduce female workers’ experience by 2 years
update health_workers set years_experience = years_experience - 2 where gender = 'Female';

-- 36. Workers with role = 'Nurse' and status = 'Active'
select * from health_workers where role = 'Nurse' and status = 'Active';

-- 37. Workers who are 'Male' or have more than 12 years experience
select * from health_workers where gender = 'Male' or years_experience > 12;

-- 38. Case: categorize workers by experience
select name,
case
  when years_experience >= 12 then 'Senior'
  when years_experience between 6 and 11 then 'Mid-Level'
  else 'Junior'
end as experience_category
from health_workers;

-- 39. Case: mark worker activity status
select name,
case status
  when 'Active' then 'Currently Working'
  when 'Not-Active' then 'Not Working'
end as work_status
from health_workers;

-- 40. Total years of experience by role
select role, sum(years_experience) from health_workers group by role;

-- 41. Average experience by gender
select gender, avg(years_experience) from health_workers group by gender;

-- 42. Role with highest average experience
select role, avg(years_experience) as avg_exp
from health_workers group by role
order by avg_exp desc limit 1;

-- 43. Distinct roles of health workers
select distinct role from health_workers;

-- 44. Distinct statuses of health workers
select distinct status from health_workers;

-- 45. Health workers with phone number length > 15
select * from health_workers where length(phone) > 15;

-- 46. Add check constraint on years_experience
alter table health_workers add constraint chk_exp check (years_experience >= 0);

-- 47. Drop check constraint on years_experience
alter table health_workers drop check chk_exp;

-- 48. Create index on role
create index idx_role on health_workers(role);

-- 49. Drop index on role
drop index idx_role on health_workers;

-- 50. Create a copy of health_workers
create table health_workers_copy as select * from health_workers;

-- Table-9 Outbreaks---------------------------------------------------------------------------------------------------------
-- 1. All outbreaks with severity = 'Critical'
select * from outbreaks where severity = 'Critical';

-- 2. All outbreaks with severity = 'High'
select * from outbreaks where severity = 'High';

-- 3. Outbreaks not yet controlled
select * from outbreaks where controlled = 'No';

-- 4. Outbreaks that were controlled
select * from outbreaks where controlled = 'Yes';

-- 5. Outbreaks that started after 2015
select * from outbreaks where start_date > '2015-01-01';

-- 6. Outbreaks that ended before 2010
select * from outbreaks where end_date < '2010-01-01';

-- 7. Outbreaks with duration greater than 1 year
select outbreakid, disease_id, country_id, 
datediff(end_date, start_date) as duration_days
from outbreaks
where datediff(end_date, start_date) > 365;

-- 8. Outbreaks in the USA region
select * from outbreaks where region like '%USA%';

-- 9. Outbreaks in South Asia
select * from outbreaks where region = 'South Asia';

-- 10. Outbreaks caused by water contamination
select * from outbreaks where source like '%water%';

-- 11. Outbreaks caused by animals
select * from outbreaks where source like '%animal%';

-- 12. Outbreaks caused by air travel
select * from outbreaks where source like '%air travel%';

-- 13. Outbreaks with notes mentioning 'vaccination'
select * from outbreaks where notes like '%vaccination%';

-- 14. Outbreaks with notes mentioning 'lockdown'
select * from outbreaks where notes like '%lockdown%';

-- 15. Outbreaks with severity either 'High' or 'Critical'
select * from outbreaks where severity in ('High','Critical');

-- 16. Outbreaks with severity = 'Medium' and controlled = 'Yes'
select * from outbreaks where severity = 'Medium' and controlled = 'Yes';

-- 17. Outbreaks with severity = 'Critical' and controlled = 'No'
select * from outbreaks where severity = 'Critical' and controlled = 'No';

-- 18. Outbreak count by severity
select severity, count(*) from outbreaks group by severity;

-- 19. Outbreak count by control status
select controlled, count(*) from outbreaks group by controlled;

-- 20. Earliest outbreak
select * from outbreaks order by start_date asc limit 1;

-- 21. Most recent outbreak
select * from outbreaks order by start_date desc limit 1;

-- 22. Longest outbreak (by duration)
select outbreakid, datediff(end_date, start_date) as duration_days
from outbreaks order by duration_days desc limit 1;

-- 23. Shortest outbreak
select outbreakid, datediff(end_date, start_date) as duration_days
from outbreaks order by duration_days asc limit 1;

-- 24. Average outbreak duration
select avg(datediff(end_date, start_date)) as avg_duration_days from outbreaks;

-- 25. Total controlled vs not controlled outbreaks
select controlled, count(*) from outbreaks group by controlled;

-- 26. Outbreaks per country
select country_id, count(*) from outbreaks group by country_id;

-- 27. Outbreaks per disease
select disease_id, count(*) from outbreaks group by disease_id;

-- 28. Add column Mortality_Rate
alter table outbreaks add column mortality_rate decimal(5,2);

-- 29. Drop column Mortality_Rate
alter table outbreaks drop column mortality_rate;

-- 30. Rename column Notes to Remarks
alter table outbreaks rename column notes to remarks;

-- 31. Insert a new outbreak
insert into outbreaks
values (21, 2, 5, '2022-01-01', '2022-06-01', 'Medium', 'West Africa', 'Mosquito outbreak due to rains.', 'Yes', 'Quick containment done.');

-- 32. Update outbreak 21 severity to 'High'
update outbreaks set severity = 'High' where outbreakid = 21;

-- 33. Delete outbreak 21
delete from outbreaks where outbreakid = 21;

-- 34. Outbreaks without an End_Date (if any future data added)
select * from outbreaks where end_date is null;

-- 35. Outbreaks with Start_Date and End_Date both not null
select * from outbreaks where start_date is not null and end_date is not null;

-- 36. Case: classify outbreaks by severity
select outbreakid, 
case severity
  when 'Low' then 'Minor'
  when 'Medium' then 'Moderate'
  when 'High' then 'Severe'
  when 'Critical' then 'Emergency'
end as severity_category
from outbreaks;

-- 37. Case: classify outbreaks by control status
select outbreakid,
case controlled
  when 'Yes' then 'Contained'
  when 'No' then 'Ongoing'
end as outbreak_status
from outbreaks;

-- 38. Distinct severity values
select distinct severity from outbreaks;

-- 39. Distinct regions
select distinct region from outbreaks;

-- 40. Total outbreaks with notes available
select count(*) from outbreaks where remarks is not null;

-- 41. Total outbreaks with source details available
select count(*) from outbreaks where source is not null;

-- 42. Check constraint validation on severity
alter table outbreaks add constraint chk_severity check (severity in ('Low','Medium','High','Critical'));

-- 43. Drop check constraint on severity
alter table outbreaks drop check chk_severity;

-- 44. Create index on severity
create index idx_severity on outbreaks(severity);

-- 45. Drop index on severity
drop index idx_severity on outbreaks;

-- 46. Outbreaks in regions containing 'Africa'
select * from outbreaks where region like '%Africa%';

-- 47. Outbreaks in regions containing 'Asia'
select * from outbreaks where region like '%Asia%';

-- 48. Outbreaks lasting more than 180 days
select * from outbreaks where datediff(end_date, start_date) > 180;

-- 49. Outbreaks lasting less than 90 days
select * from outbreaks where datediff(end_date, start_date) < 90;

-- 50. Create backup table
create table outbreaks_backup as select * from outbreaks;

-- Table-10 Emergency_Responses----------------------------------------------------------------------------------------------
-- 1. Responses with cost > 1,000,000
select * from emergency_responses where cost > 1000000;

-- 2. Responses with cost < 500,000
select * from emergency_responses where cost < 500000;

-- 3. Responses where teams deployed > 10
select * from emergency_responses where teams_deployed > 10;

-- 4. Responses coordinated by WHO
select * from emergency_responses where partner_orgs like '%WHO%';

-- 5. Responses coordinated by Red Cross
select * from emergency_responses where partner_orgs like '%Red Cross%';

-- 6. Responses coordinated by UNICEF
select * from emergency_responses where partner_orgs like '%UNICEF%';

-- 7. Responses lasting more than 90 days
select responseid, datediff(end_date, start_date) as duration_days
from emergency_responses
where datediff(end_date, start_date) > 90;

-- 8. Responses lasting less than 60 days
select responseid, datediff(end_date, start_date) as duration_days
from emergency_responses
where datediff(end_date, start_date) < 60;

-- 9. Responses in 2020 or later
select * from emergency_responses where start_date >= '2020-01-01';

-- 10. Responses before 2010
select * from emergency_responses where start_date < '2010-01-01';

-- 11. Total number of responses
select count(*) as total_responses from emergency_responses;

-- 12. Average cost of responses
select avg(cost) as avg_cost from emergency_responses;

-- 13. Maximum cost of response
select max(cost) as max_cost from emergency_responses;

-- 14. Minimum cost of response
select min(cost) as min_cost from emergency_responses;

-- 15. Total cost of all responses
select sum(cost) as total_cost from emergency_responses;

-- 16. Response with the highest cost
select * from emergency_responses order by cost desc limit 1;

-- 17. Response with the lowest cost
select * from emergency_responses order by cost asc limit 1;

-- 18. Responses grouped by coordinator
select coordinator, count(*) as total from emergency_responses group by coordinator;

-- 19. Responses grouped by partner orgs
select partner_orgs, count(*) as total from emergency_responses group by partner_orgs;

-- 20. Distinct partner organizations
select distinct partner_orgs from emergency_responses;

-- 21. Distinct coordinators
select distinct coordinator from emergency_responses;

-- 22. Update cost for response 1 (increase by 10%)
update emergency_responses set cost = cost * 1.10 where responseid = 1;

-- 23. Delete response with ID = 20
delete from emergency_responses where responseid = 20;

-- 24. Insert a new response
insert into emergency_responses 
values (21, 1, '2022-01-01', '2022-05-01', 7, 'Emergency shelters, medical kits', 500000, 'Red Cross, WHO', 'Ongoing', 'Dr. John Carter');

-- 25. Rename column Status to Response_Status
alter table emergency_responses rename column status to response_status;

-- 26. Add column Effectiveness_Rating
alter table emergency_responses add column effectiveness_rating varchar(20);

-- 27. Drop column Effectiveness_Rating
alter table emergency_responses drop column effectiveness_rating;

-- 28. Responses with no supplies mentioned
select * from emergency_responses where supplies_sent is null;

-- 29. Responses with supplies containing 'vaccine'
select * from emergency_responses where supplies_sent like '%vaccine%';

-- 30. Responses with supplies containing 'kits'
select * from emergency_responses where supplies_sent like '%kits%';

-- 31. Responses handled by coordinators with 'Dr.' prefix
select * from emergency_responses where coordinator like 'Dr.%';

-- 32. Responses where cost is between 200,000 and 800,000
select * from emergency_responses where cost between 200000 and 800000;

-- 33. Case: classify responses by cost
select responseid, 
case 
  when cost < 300000 then 'Low Budget'
  when cost between 300000 and 1000000 then 'Medium Budget'
  else 'High Budget'
end as budget_category
from emergency_responses;

-- 34. Case: classify responses by teams deployed
select responseid, 
case 
  when teams_deployed <= 3 then 'Small Team'
  when teams_deployed between 4 and 8 then 'Medium Team'
  else 'Large Team'
end as team_category
from emergency_responses;

-- 35. Responses per outbreak
select outbreak_id, count(*) as responses_count from emergency_responses group by outbreak_id;

-- 36. Total teams deployed across all responses
select sum(teams_deployed) as total_teams from emergency_responses;

-- 37. Average teams deployed
select avg(teams_deployed) as avg_teams from emergency_responses;

-- 38. Responses with exactly 5 teams
select * from emergency_responses where teams_deployed = 5;

-- 39. Responses with more than 8 teams
select * from emergency_responses where teams_deployed > 8;

-- 40. Backup table creation
create table emergency_responses_backup as select * from emergency_responses;

-- 41. Index on cost
create index idx_cost on emergency_responses(cost);

-- 42. Drop index on cost
drop index idx_cost on emergency_responses;

-- 43. Responses with partner orgs containing 'CDC'
select * from emergency_responses where partner_orgs like '%CDC%';

-- 44. Responses with partner orgs containing 'MSF'
select * from emergency_responses where partner_orgs like '%MSF%';

-- 45. Responses with partner orgs containing 'PAHO'
select * from emergency_responses where partner_orgs like '%PAHO%';

-- 46. Duration of each response
select responseid, datediff(end_date, start_date) as duration_days from emergency_responses;

-- 47. Average response duration
select avg(datediff(end_date, start_date)) as avg_response_duration from emergency_responses;

-- 48. Response with the longest duration
select responseid, datediff(end_date, start_date) as duration_days 
from emergency_responses order by duration_days desc limit 1;

-- 49. Response with the shortest duration
select responseid, datediff(end_date, start_date) as duration_days 
from emergency_responses order by duration_days asc limit 1;

-- 50. Responses still ongoing (if any future added)
select * from emergency_responses where response_status = 'Ongoing';