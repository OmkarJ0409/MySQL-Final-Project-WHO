use who;

-- Table-16 Research_Projects------------------------------------------------------------------------------------------------
-- 1. alias for project title
select title as project_title from research_projects;

-- 2. alias for lead researcher
select lead_researcher as pi from research_projects;

-- 3. alias for budget with currency
select budget as budget_usd from research_projects;

-- 4. alias for project duration
select start_date as project_start, end_date as project_end from research_projects;

-- 5. alias for sponsors
select sponsors_orgs as sponsors from research_projects;

-- 6. alias with multiple columns
select projectid as id, title as name, status as project_status from research_projects;

-- 7. alias for area of focus
select area_of_focus as focus_area from research_projects;

-- 8. alias with concatenation
select concat(title, ' - ', status) as project_summary from research_projects;

-- 9. alias for date published
select start_date as initiated_on from research_projects;

-- 10. alias for researcher and sponsor
select lead_researcher as pi, sponsors_orgs as funder from research_projects;

-- 11. projects with budget greater than average
select title, budget from research_projects where budget > (select avg(budget) from research_projects);

-- 12. project with maximum budget
select * from research_projects where budget = (select max(budget) from research_projects);

-- 13. project with minimum budget
select * from research_projects where budget = (select min(budget) from research_projects);

-- 14. count projects by comparing with subquery
select count(*) as high_budget_projects from research_projects where budget > (select avg(budget) from research_projects);

-- 15. projects ending after latest completed project
select title from research_projects where end_date > (select max(end_date) from research_projects where status = 'Completed');

-- 16. researchers leading projects with highest budget
select lead_researcher from research_projects where budget = (select max(budget) from research_projects);

-- 17. sponsors funding projects above median budget
select sponsors_orgs from research_projects where budget > (select avg(budget) from research_projects);

-- 18. find ongoing projects started after 2021 using subquery
select title from research_projects where start_date > (select min(start_date) from research_projects where status = 'Ongoing');

-- 19. projects in same focus area as 'Oncology'
select title from research_projects where area_of_focus = (select area_of_focus from research_projects where area_of_focus = 'Oncology' limit 1);

-- 20. projects with budget less than that of 'Cancer Biomarkers Project'
select title from research_projects where budget < (select budget from research_projects where title = 'Cancer Biomarkers Project');

-- 21. length of project title
select title, length(title) as title_length from research_projects;

-- 22. upper case researcher names
select upper(lead_researcher) as researcher from research_projects;

-- 23. lower case sponsors
select lower(sponsors_orgs) as sponsor from research_projects;

-- 24. substring of project title
select substring(title, 1, 15) as short_title from research_projects;

-- 25. round budget to nearest million
select title, round(budget, -6) as rounded_budget from research_projects;

-- 26. extract year from start date
select title, year(start_date) as start_year from research_projects;

-- 27. calculate duration in days
select title, datediff(end_date, start_date) as duration_days from research_projects;

-- 28. concatenate title and researcher
select concat(title, ' by ', lead_researcher) as project_info from research_projects;

-- 29. find month of project start
select title, monthname(start_date) as start_month from research_projects;

-- 30. average budget of all projects
select avg(budget) as avg_budget from research_projects;

-- 31.  project_age(): returns project age in years since start
delimiter //
create function project_age(start_date date)
returns int deterministic
begin
  return timestampdiff(year, start_date, curdate());
end //
delimiter ;
select projectid, title, project_age(start_date) as age_years from research_projects;

-- 32. classify_budget(): returns budget category
delimiter //
create function classify_budgets(budget double)
returns varchar(20) deterministic
begin
  if budget < 3000000 then 
    return 'Low';
  elseif budget between 3000000 and 6000000 then
    return 'Medium';
  else 
    return 'High';
  end if;
end //
delimiter ;
select projectid, title, budget, classify_budgets(budget) as budget_category from research_projects;

-- 33. mask_researcher(): hides researcher name except first 3 chars
delimiter //
create function mask_researcher(name varchar(100))
returns varchar(100) deterministic
begin
  return concat(left(name,3), '***');
end //
delimiter ;
select projectid, mask_researcher(lead_researcher) as masked_researcher from research_projects;

-- 34. status_flag(): converts status to short code
delimiter //
create function status_flags(status varchar(50))
returns varchar(10) deterministic
begin
  case status
    when 'Completed' then return 'C';
    when 'Ongoing' then return 'O';
    when 'Active' then return 'A';
    else return 'X';
  end case;
end //
delimiter ;
select projectid, title, status_flags(status) as status_code from research_projects;

-- 35. short_sponsor(): returns short sponsor code
delimiter //
create function short_sponsor(sponsor varchar(100))
returns varchar(50) deterministic
begin
  return upper(left(sponsor,5));
end //
delimiter ;
select projectid, sponsors_orgs, short_sponsor(sponsors_orgs) as sponsor_code from research_projects;

-- 36. efficiency_score(): budget ÷ duration (per day cost)
delimiter //
create function efficiency_scores(budget double, start_date date, end_date date)
returns double deterministic
begin
  declare days int;
  set days = datediff(end_date, start_date);
  if days = 0 then return budget; 
  else return round(budget/days,2);
  end if;
end //
delimiter ;
select projectid, title, efficiency_scores(budget, start_date, end_date) as efficiency from research_projects;

-- 37. term_tag(): classify as Short/Long term project
delimiter //
create function term_tag(start_date date, end_date date)
returns varchar(20) deterministic
begin
  if timestampdiff(month,start_date,end_date) <= 24 then
    return 'Short-Term';
  else
    return 'Long-Term';
  end if;
end //
delimiter ;
select projectid, title, term_tag(start_date, end_date) as project_term from research_projects;

-- 38. std_researcher(): returns researcher name in Title Case
delimiter //
create function std_researcher(name varchar(100))
returns varchar(100) deterministic
begin
  return concat(upper(left(name,1)), lower(substring(name,2)));
end //
delimiter ;
select projectid, std_researcher(lead_researcher) as formatted_name from research_projects;

-- 39. funding_label(): adds "Grant-" prefix
delimiter //
create function funding_label(sponsor varchar(100))
returns varchar(150) deterministic
begin
  return concat('Grant-', sponsor);
end //
delimiter ;
select projectid, funding_label(sponsors_orgs) as funding_info from research_projects;

-- 40. weighted_score(): budget ÷ (years since start + 1)
delimiter //
create function weighted_score(budget double, start_date date)
returns double deterministic
begin
  declare yrs int;
  set yrs = timestampdiff(year,start_date,curdate()) + 1;
  return round(budget/yrs,2);
end //
delimiter ;
select projectid, title, weighted_score(budget, start_date) as weighted_score from research_projects;

-- 41. join with countries to get project country
select rp.title, c.name as country_name
from research_projects rp
join countries c on rp.country_id = c.countryid;

-- 42. join to get project title and country region
select rp.title, c.region from research_projects rp
join countries c on rp.country_id = c.countryid;

-- 43. join with alias on lead researcher and country
select rp.lead_researcher, c.income_level from research_projects rp
join countries c on rp.country_id = c.countryid;

-- 44. projects with sponsors and their country
select rp.sponsors_orgs, c.name from research_projects rp
join countries c on rp.country_id = c.countryid;

-- 45. join to list project and country code
select rp.title, c.code from research_projects rp
join countries c on rp.country_id = c.countryid;

-- 46. join to get projects by high-income countries
select rp.title, c.name from research_projects rp
join countries c on rp.country_id = c.countryid
where c.income_level = 'High';

-- 47. join to fetch projects from asia
select rp.title, c.name from research_projects rp
join countries c on rp.country_id = c.countryid
where c.region = 'Asia';

-- 48. join to count projects per country
select c.name, count(rp.projectid) as total_projects
from research_projects rp
join countries c on rp.country_id = c.countryid
group by c.name;

-- 49. join to get avg budget by region
select c.region, avg(rp.budget) as avg_budget
from research_projects rp
join countries c on rp.country_id = c.countryid
group by c.region;

-- 50. join to get ongoing projects with country details
select rp.title, rp.status, c.name, c.region
from research_projects rp
join countries c on rp.country_id = c.countryid
where rp.status = 'Ongoing';

-- Table-17 Medicines--------------------------------------------------------------------------------------------------------
-- 1. alias for name and used_for
select name as medicine_name, used_for as treatment from medicines;

-- 2. alias for manufacturer
select manufacturer as pharma_company, name from medicines;

-- 3. alias for approval date
select name, approval_date as approved_on from medicines;

-- 4. alias for side effects
select name, side_effects as adverse_effects from medicines;

-- 5. multiple aliases
select name as med, manufacturer as company, who_approved as approval_status from medicines;

-- 6. alias with condition
select name as med, used_for as treatment from medicines where availability='Yes';

-- 7. alias with sorting
select name as med, approval_date as approved_on from medicines order by approval_date desc;

-- 8. alias for dosage info
select name, dosage_info as dosage from medicines;

-- 9. alias for all columns
select medicineid as id, name as med, manufacturer as company, expiry_years as shelf_life from medicines;

-- 10. alias with concat
select concat(name,' - ',used_for) as med_info from medicines;

-- 11. medicines approved after avg approval year
select name, approval_date from medicines where year(approval_date) > (select avg(year(approval_date)) from medicines);

-- 12. medicines by manufacturers with multiple approvals
select name, manufacturer from medicines where manufacturer in (select manufacturer from medicines group by manufacturer having count(*) > 1);

-- 13. most recent approval
select * from medicines where approval_date = (select max(approval_date) from medicines);

-- 14. earliest approval
select * from medicines where approval_date = (select min(approval_date) from medicines);

-- 15. medicines with same manufacturer as 'Amoxicillin'
select name, manufacturer from medicines where manufacturer = (select manufacturer from medicines where name='Amoxicillin');

-- 16. medicines approved after 2015 and who approved
select name, who_approved from medicines where year(approval_date) > 2015;

-- 17. medicines with max expiry years
select name, expiry_years from medicines where expiry_years = (select max(expiry_years) from medicines);

-- 18. manufacturers with at least 2 medicines
select manufacturer from medicines group by manufacturer having count(*) >= 2;

-- 19. medicines with avg or higher expiry
select name, expiry_years from medicines where expiry_years >= (select avg(expiry_years) from medicines);

-- 20. medicines not WHO approved
select name, who_approved from medicines where who_approved='No';

-- 21. length of medicine name
select name, length(name) as name_length from medicines;

-- 22. upper case manufacturer
select upper(manufacturer) as manufacturer_name from medicines;

-- 23. lower case used_for
select lower(used_for) as treatment from medicines;

-- 24. substring of medicine name
select substring(name,1,10) as short_name from medicines;

-- 25. years since approval
select name, year(curdate())-year(approval_date) as years_since_approval from medicines;

-- 26. average expiry years
select avg(expiry_years) as avg_shelf_life from medicines;

-- 27. total medicines per manufacturer
select manufacturer, count(*) as total_meds from medicines group by manufacturer;

-- 28. replace spaces in medicine name
select replace(name,' ','_') as slug_name from medicines;

-- 29. concat name and dosage
select concat(name,': ',dosage_info) as med_dosage from medicines;

-- 30. coalesce side effects
select name, coalesce(side_effects,'None') as effects from medicines;

-- 31. udf to calculate medicine age
delimiter //
create function med_age(approval_date date)
returns int deterministic
begin
  return year(curdate()) - year(approval_date);
end;
//
delimiter ;
select name, med_age(approval_date) as med_age from medicines;

-- 32. udf to classify expiry years
delimiter //
create function expiry_class(exp_years int)
returns varchar(20) deterministic
begin
  if exp_years >= 5 then
    return 'Long Shelf Life';
  elseif exp_years >= 3 then
    return 'Medium Shelf Life';
  else
    return 'Short Shelf Life';
  end if;
end;
//
delimiter ;
select name, expiry_class(expiry_years) as shelf_category from medicines;

-- 33. udf to mask manufacturer name
delimiter //
create function mask_manufacturer(manu varchar(100))
returns varchar(100) deterministic
begin
  return concat(left(manu,3),'***');
end;
//
delimiter ;
select name, mask_manufacturer(manufacturer) as hidden_manufacturer from medicines;

-- 34. udf to extract approval year
delimiter //
create function get_approval_year(approval_date date)
returns int deterministic
begin
  return year(approval_date);
end;
//
delimiter ;
select name, get_approval_year(approval_date) as approved_year from medicines;

-- 35. udf to standardize WHO approval
delimiter //
create function std_who(who varchar(3))
returns varchar(20) deterministic
begin
  if who='Yes' then
    return 'Approved';
  else
    return 'Not Approved';
  end if;
end;
//
delimiter ;
select name, std_who(who_approved) as approval_status from medicines;

-- 36. udf to generate citation
delimiter //
create function med_citation(name varchar(100), manu varchar(100), approval_date date)
returns varchar(300) deterministic
begin
  return concat(name,' (',year(approval_date),') - ',manu);
end;
//
delimiter ;
select medicineid, med_citation(name,manufacturer,approval_date) as citation from medicines;

-- 37. udf to tag availability
delimiter //
create function availability_tag(avail varchar(3))
returns varchar(20) deterministic
begin
  if avail='Yes' then
    return 'Available';
  else
    return 'Out of Stock';
  end if;
end;
//
delimiter ;
select name, availability_tag(availability) as stock_status from medicines;

-- 38. udf to truncate dosage
delimiter //
create function short_dosage(dosage text)
returns varchar(50) deterministic
begin
  return concat(left(dosage,30),'...');
end;
//
delimiter ;
select name, short_dosage(dosage_info) as dosage_short from medicines;

-- 39. udf to assign importance based on approval year
delimiter //
create function med_importance(app_date date)
returns varchar(20) deterministic
begin
  if year(app_date) >= 2020 then
    return 'High';
  elseif year(app_date) >= 2000 then
    return 'Medium';
  else
    return 'Low';
  end if;
end;
//
delimiter ;
select name, med_importance(approval_date) as importance from medicines;

-- 40. udf to create label with name
delimiter //
create function name_label(med varchar(100))
returns varchar(150) deterministic
begin
  return concat('Medicine: ',med);
end;
//
delimiter ;
select name, name_label(name) as med_label from medicines;

-- 41. medicines joined with manufacturers (example: group by manufacturer)
select manufacturer, group_concat(name) as meds
from medicines group by manufacturer;

-- 42. count medicines per approval year
select year(approval_date) as year, count(*) as total_meds
from medicines group by year(approval_date);

-- 43. medicines with longest expiry years
select manufacturer, max(expiry_years) as max_expiry
from medicines group by manufacturer;

-- 44. medicines per availability
select availability, count(*) as total from medicines group by availability;

-- 45. who approved medicines per manufacturer
select manufacturer, count(*) as approved_meds
from medicines where who_approved='Yes' group by manufacturer;

-- 46. medicines approved after 2010 grouped by manufacturer
select manufacturer, count(*) as new_meds
from medicines where year(approval_date)>2010 group by manufacturer;

-- 47. availability ratio per manufacturer
select manufacturer, sum(case when availability='Yes' then 1 else 0 end) as available_count,
sum(case when availability='No' then 1 else 0 end) as unavailable_count
from medicines group by manufacturer;

-- 48. average expiry by manufacturer
select manufacturer, avg(expiry_years) as avg_expiry from medicines group by manufacturer;

-- 49. rank manufacturers by number of medicines
select manufacturer, count(*) as med_count
from medicines group by manufacturer order by med_count desc;

-- 50. list manufacturers with WHO approved but short expiry medicines
select manufacturer, name, expiry_years
from medicines where who_approved='Yes' and expiry_years<3;

-- Table-18 Health_Indicators------------------------------------------------------------------------------------------------
-- 1. alias for life expectancy
select IndicatorID, Life_Expectancy as avg_life from Health_Indicators;

-- 2. alias for infant mortality
select Country_ID, Infant_Mortality as infant_rate from Health_Indicators;

-- 3. alias for health expenditure
select Country_ID, Health_Expenditure_Per_capita as per_capita_spend from Health_Indicators;

-- 4. alias for doctor patient ratio
select Country_ID, Doctor_Patient_Ratio as doc_patient_ratio from Health_Indicators;

-- 5. multiple aliases
select Year as report_year, Child_Mortality_Rate as child_rate, Smoking_Rate as tobacco_rate from Health_Indicators;

-- 6. alias with condition
select Country_ID, Life_Expectancy as avg_life from Health_Indicators where Life_Expectancy > 80;

-- 7. alias with sorting
select Country_ID, Infant_Mortality as infant_rate from Health_Indicators order by Infant_Mortality desc;

-- 8. alias for sanitation
select Country_ID, Access_To_Sanitation as sanitation_access from Health_Indicators;

-- 9. alias for all columns
select IndicatorID as id, Country_ID as c_id, Year as report_date,
Life_Expectancy as life, Infant_Mortality as infant, Health_Expenditure_Per_capita as spend,
Access_To_Sanitation as sanitation, Doctor_Patient_Ratio as dpr, Child_Mortality_Rate as cmr, Smoking_Rate as smoke
from Health_Indicators;

-- 10. alias with concat
select concat('Country-',Country_ID,': ',Life_Expectancy) as country_life from Health_Indicators;

-- 11. countries with above average life expectancy
select Country_ID, Life_Expectancy from Health_Indicators 
where Life_Expectancy > (select avg(Life_Expectancy) from Health_Indicators);

-- 12. countries with higher than avg infant mortality
select Country_ID, Infant_Mortality from Health_Indicators
where Infant_Mortality > (select avg(Infant_Mortality) from Health_Indicators);

-- 13. highest life expectancy
select * from Health_Indicators
where Life_Expectancy = (select max(Life_Expectancy) from Health_Indicators);

-- 14. lowest life expectancy
select * from Health_Indicators
where Life_Expectancy = (select min(Life_Expectancy) from Health_Indicators);

-- 15. countries with same expenditure as Country 2
select Country_ID, Health_Expenditure_Per_capita from Health_Indicators
where Health_Expenditure_Per_capita = (select Health_Expenditure_Per_capita from Health_Indicators where Country_ID=2);

-- 16. countries after year 2010
select Country_ID, Year from Health_Indicators where Year > '2010-01-01';

-- 17. max health expenditure
select Country_ID, Health_Expenditure_Per_capita from Health_Indicators
where Health_Expenditure_Per_capita = (select max(Health_Expenditure_Per_capita) from Health_Indicators);

-- 18. countries with sanitation > 90
select Country_ID, Access_To_Sanitation from Health_Indicators where Access_To_Sanitation > 90;

-- 19. countries with smoking rate >= avg
select Country_ID, Smoking_Rate from Health_Indicators
where Smoking_Rate >= (select avg(Smoking_Rate) from Health_Indicators);

-- 20. countries with doctor patient ratio < 1
select Country_ID, Doctor_Patient_Ratio from Health_Indicators where Doctor_Patient_Ratio < 1;

-- 21. year difference from current year
select Country_ID, year(curdate()) - year(Year) as years_diff from Health_Indicators;

-- 22. upper case sanitation alias
select upper(Country_ID) as country_code, Access_To_Sanitation from Health_Indicators;

-- 23. round life expectancy
select Country_ID, round(Life_Expectancy,0) as life_round from Health_Indicators;

-- 24. substring on year
select substring(year(Year),1,4) as report_year from Health_Indicators;

-- 25. average infant mortality
select avg(Infant_Mortality) as avg_infant from Health_Indicators;

-- 26. total avg life expectancy by sanitation
select Access_To_Sanitation, avg(Life_Expectancy) as avg_life
from Health_Indicators group by Access_To_Sanitation;

-- 27. total countries per doctor ratio > 2
select count(*) as high_ratio from Health_Indicators where Doctor_Patient_Ratio > 2;

-- 28. replace decimal in smoking rate
select replace(Smoking_Rate,'.','_') as smoke_label from Health_Indicators;

-- 29. concat mortality info
select concat('Infant:',Infant_Mortality,' Child:',Child_Mortality_Rate) as mortality_info from Health_Indicators;

-- 30. coalesce expenditure
select Country_ID, coalesce(Health_Expenditure_Per_capita,0) as spend from Health_Indicators;

-- 31. udf to calculate report age
delimiter //
create function report_ages(report_date date)
returns int deterministic
begin
  return year(curdate()) - year(report_date);
end;
//
delimiter ;
select Country_ID, report_ages(Year) as report_age from Health_Indicators;

-- 32. udf to classify life expectancy
delimiter //
create function life_class(life float)
returns varchar(20) deterministic
begin
  if life >= 80 then
    return 'High';
  elseif life >= 70 then
    return 'Medium';
  else
    return 'Low';
  end if;
end;
//
delimiter ;
select Country_ID, life_class(Life_Expectancy) as category from Health_Indicators;

-- 33. udf to mask country id
delimiter //
create function mask_country(cid int)
returns varchar(20) deterministic
begin
  return concat('C-',cid,'***');
end;
//
delimiter ;
select Country_ID, mask_country(Country_ID) as hidden_id from Health_Indicators;

-- 34. udf to extract report year
delimiter //
create function get_report_year(r_date date)
returns int deterministic
begin
  return year(r_date);
end;
//
delimiter ;
select IndicatorID, get_report_year(Year) as rep_year from Health_Indicators;

-- 35. udf to standardize sanitation
delimiter //
create function sanitation_std(val float)
returns varchar(20) deterministic
begin
  if val>=90 then
    return 'High';
  elseif val>=60 then
    return 'Medium';
  else
    return 'Low';
  end if;
end;
//
delimiter ;
select Country_ID, sanitation_std(Access_To_Sanitation) as sanitation_category from Health_Indicators;

-- 36. udf to generate summary
delimiter //
create function health_summary(life float, infant float)
returns varchar(200) deterministic
begin
  return concat('Life:',life,' Infant:',infant);
end;
//
delimiter ;
select Country_ID, health_summary(Life_Expectancy,Infant_Mortality) as summary from Health_Indicators;

-- 37. udf to tag smoking rate
delimiter //
create function smoking_tag(rate float)
returns varchar(20) deterministic
begin
  if rate > 25 then
    return 'High Risk';
  elseif rate > 10 then
    return 'Moderate Risk';
  else
    return 'Low Risk';
  end if;
end;
//
delimiter ;
select Country_ID, smoking_tag(Smoking_Rate) as smoke_status from Health_Indicators;

-- 38. udf to short doctor ratio
delimiter //
create function short_ratio(ratio float)
returns varchar(50) deterministic
begin
  return concat(left(ratio,3));
end;
//
delimiter ;
select Country_ID, short_ratio(Doctor_Patient_Ratio) as short_dpr from Health_Indicators;

-- 39. udf to assign importance based on expenditure
delimiter //
create function exp_importance(exp float)
returns varchar(20) deterministic
begin
  if exp >= 5000 then
    return 'High Spend';
  elseif exp >= 1000 then
    return 'Medium Spend';
  else
    return 'Low Spend';
  end if;
end;
//
delimiter ;
select Country_ID, exp_importance(Health_Expenditure_Per_capita) as spend_category from Health_Indicators;

-- 40. udf to create label
delimiter //
create function life_label(life float)
returns varchar(100) deterministic
begin
  return concat('Life Expectancy: ',life);
end;
//
delimiter ;
select Country_ID, life_label(Life_Expectancy) as label from Health_Indicators;

-- 41. group by year and avg life expectancy
select year(Year) as yr, avg(Life_Expectancy) as avg_life
from Health_Indicators group by year(Year);

-- 42. count countries per year
select year(Year) as yr, count(*) as total_countries
from Health_Indicators group by year(Year);

-- 43. highest infant mortality by year
select year(Year), max(Infant_Mortality) as max_infant
from Health_Indicators group by year(Year);

-- 44. smoking rate per sanitation level
select Access_To_Sanitation, avg(Smoking_Rate) as avg_smoke
from Health_Indicators group by Access_To_Sanitation;

-- 45. expenditure per year
select year(Year), avg(Health_Expenditure_Per_capita) as avg_exp
from Health_Indicators group by year(Year);

-- 46. mortality grouped by sanitation
select Access_To_Sanitation, avg(Child_Mortality_Rate) as avg_child
from Health_Indicators group by Access_To_Sanitation;

-- 47. availability ratio of life expectancy >75
select sum(case when Life_Expectancy>75 then 1 else 0 end) as high_life,
sum(case when Life_Expectancy<=75 then 1 else 0 end) as low_life
from Health_Indicators;

-- 48. average doctor patient ratio per year
select year(Year), avg(Doctor_Patient_Ratio) as avg_dpr
from Health_Indicators group by year(Year);

-- 49. rank countries by health spend
select Country_ID, Health_Expenditure_Per_capita
from Health_Indicators order by Health_Expenditure_Per_capita desc;

-- 50. countries with high life expectancy but high smoking
select Country_ID, Life_Expectancy, Smoking_Rate
from Health_Indicators where Life_Expectancy>80 and Smoking_Rate>20;

-- Table-19 Funding----------------------------------------------------------------------------------------------------------
-- 1. Show fund source and amount with aliases
select Source as Funding_Source, Amount as Funded_Amount from Funding;

-- 2. Alias for table
select f.FundID, f.Source, f.Type from Funding f;

-- 3. Alias for expressions
select Amount * 1.1 as Adjusted_Amount from Funding;

-- 4. Alias for concatenation
select concat(Source, ' - ', Purpose) as Fund_Details from Funding;

-- 5. Alias for grouping
select Country_ID as CID, sum(Amount) as Total_Funds from Funding group by CID;

-- 6. Alias for sorting
select FundID as ID, Year as Funding_Year from Funding order by Funding_Year desc;

-- 7. Alias with condition
select FundID as ID, Amount as Fund_Value from Funding where Amount > 500000;

-- 8. Alias for calculated column
select Amount, Amount/1000 as Amount_in_K from Funding;

-- 9. Alias for distinct values
select distinct(Source) as Funding_Agency from Funding;

-- 10. Alias with case statement
select FundID, case when Amount > 500000 then 'High' else 'Low' end as Fund_Category from Funding;

-- 11. Funds greater than average amount
select * from Funding 
where Amount > (select avg(Amount) from Funding);

-- 12. Programs funded by WHO
select Program_ID from Funding 
where Source = 'WHO' 
and Program_ID in (select Program_ID from Programs);

-- 13. Countries with highest fund
select Country_ID from Funding 
where Amount = (select max(Amount) from Funding);

-- 14. Funds lower than Gates Foundation
select * from Funding 
where Amount < (select max(Amount) from Funding where Source = 'Bill & Melinda Gates Foundation');

-- 15. Sources funding after 2021
select Source from Funding 
where Year > (select min(Year) from Funding where Year > 2021);

-- 16. Largest WHO fund
select * from Funding 
where FundID in (select FundID from Funding where Source='WHO' order by Amount desc limit 1);

-- 17. Programs with above-average funds
select Program_ID from Funding 
group by Program_ID 
having sum(Amount) > (select avg(Amount) from Funding);

-- 18. Country with lowest aid
select Country_ID from Funding 
where Amount = (select min(Amount) from Funding where Type='Aid');

-- 19. Currency with max funding
select Currency from Funding 
where Amount = (select max(Amount) from Funding);

-- 20. All funds equal to max fund in 2022
select * from Funding 
where Amount = (select max(Amount) from Funding where Year=2022);

-- 21. Find total funds
select sum(Amount) as Total_Funds from Funding;

-- 22. Average funding per year
select Year, avg(Amount) as Avg_Fund from Funding group by Year;

-- 23. Highest and lowest funding
select max(Amount) as Max_Fund, min(Amount) as Min_Fund from Funding;

-- 24. Count distinct sources
select count(distinct(Source)) as Unique_Sources from Funding;

-- 25. Round fund values
select round(Amount,2) as Rounded_Amount from Funding;

-- 26. Get string length of purpose
select Purpose, length(Purpose) as Purpose_Length from Funding;

-- 27. Convert purpose to upper case
select upper(Purpose) as Purpose_Upper from Funding;

-- 28. Extract year
select year as Funding_Year, count(*) as Total from Funding group by year;

-- 29. Replace text in notes
select replace(Notes,'health','HEALTH') as Updated_Notes from Funding;

-- 30. Substring of source
select substring(Source,1,10) as Short_Source from Funding;

-- 31. Create UDF for fund conversion
delimiter //
create function ConvertToMillion(val double) returns double
deterministic
begin
  return val/1000000;
end//
delimiter ;
select FundID, ConvertToMillion(Amount) as Amount_in_Millions from Funding;

-- 32. UDF for fund category
delimiter //
create function FundCategory(val double) returns varchar(20)
deterministic
begin
  if val >= 500000 then
    return 'High';
  else
    return 'Low';
  end if;
end//
delimiter ;
select FundID, FundCategory(Amount) as Category from Funding;

-- 33. UDF for currency normalization (example multiply by 80 if INR)
delimiter //
create function NormalizeCurrency(val double, curr varchar(10)) returns double
deterministic
begin
  if curr='INR' then
    return val/80;
  else
    return val;
  end if;
end//
delimiter ;
select FundID, NormalizeCurrency(Amount,Currency) as Amount_in_USD from Funding;

-- 34. UDF for text shortening
delimiter //
create function ShortText(txt varchar(100)) returns varchar(20)
deterministic
begin
  return substring(txt,1,20);
end//
delimiter ;
select FundID, ShortText(Purpose) as Short_Purpose from Funding;

-- 35. UDF for % share
delimiter //
create function FundShare(val double,total double) returns double
deterministic
begin
  return (val/total)*100;
end//
delimiter ;
select FundID, FundShare(Amount,(select sum(Amount) from Funding)) as Percent_Contribution from Funding;

-- 36. UDF to calculate funding growth between two years
delimiter //
create function FundGrowth(curr double, prev double) returns double
deterministic
begin
  if prev = 0 then
    return null;
  else
    return ((curr - prev) / prev) * 100;
  end if;
end//
delimiter ;
select FundID, Year, FundGrowth(Amount, 300000) as Growth_Percentage from Funding;

-- 37. UDF to mask source names (privacy)
delimiter //
create function MaskSource(src varchar(100)) returns varchar(100)
deterministic
begin
  return concat(left(src,3), '***');
end//
delimiter ;
select FundID, MaskSource(Source) as Hidden_Source from Funding;

-- 38. UDF to check if funding is recent (after 2021)
delimiter //
create function IsRecentFund(yr int) returns varchar(10)
deterministic
begin
  if yr >= 2022 then
    return 'Recent';
  else
    return 'Old';
  end if;
end//
delimiter ;
select FundID, Year, IsRecentFund(Year) as Fund_Status from Funding;

-- 39. UDF to calculate amount in lakhs (for INR)
delimiter //
create function ToLakhs(val double, curr varchar(10)) returns double
deterministic
begin
  if curr = 'INR' then
    return val / 100000;
  else
    return val;
  end if;
end//
delimiter ;
select FundID, Currency, ToLakhs(Amount, Currency) as Amount_in_Lakhs from Funding;

-- 40. UDF to classify funding type
delimiter //
create function TypeCategory(fundType varchar(50)) returns varchar(20)
deterministic
begin
  case 
    when fundType = 'Grant' then return 'Non-Repayable';
    when fundType = 'Aid' then return 'Assistance';
    when fundType = 'Donation' then return 'Philanthropy';
    when fundType = 'Loan' then return 'Repayable';
    else return 'Other';
  end case;
end//
delimiter ;
select FundID, Type, TypeCategory(Type) as Category from Funding;

-- 41. Funding with country details
select f.FundID, f.Source, c.Name 
from Funding f join Countries c on f.Country_ID = c.CountryID;

-- 42. Funding with program details
select f.FundID, f.Source, p.ProgramName 
from Funding f join Programs p on f.Program_ID = p.ProgramID;

-- 43. Inner join with both country and program
select f.FundID, c.Name, p.ProgramName, f.Amount 
from Funding f 
join Countries c on f.Country_ID = c.CountryID
join Programs p on f.Program_ID = p.ProgramID;

-- 44. Left join
select c.Name, f.Source, f.Amount 
from Countries c left join Funding f on c.CountryID=f.Country_ID;

-- 45. Right join
select f.Source, p.ProgramName 
from Funding f right join Programs p on f.Program_ID=p.ProgramID;

-- 46. Find total funding per country
select c.Name, sum(f.Amount) as Total_Funding 
from Countries c join Funding f on c.CountryID=f.Country_ID group by c.Name;

-- 47. Find total funding per program
select p.ProgramName, sum(f.Amount) as Total_Funding 
from Programs p join Funding f on p.ProgramID=f.Program_ID group by p.ProgramName;

-- 48. Countries with WHO funding
select c.Name, f.Amount 
from Funding f join Countries c on f.Country_ID=c.CountryID
where f.Source='WHO';

-- 49. Programs funded by UNICEF
select p.ProgramName, f.Amount 
from Funding f join Programs p on f.Program_ID=p.ProgramID
where f.Source='UNICEF';

-- 50. Countries with highest funding source
select c.Name, max(f.Amount) as Max_Fund 
from Funding f join Countries c on f.Country_ID=c.CountryID group by c.Name;

-- Table-20 Fund_Distribution------------------------------------------------------------------------------------------------
-- 1. Alias for columns
select DistributionID as Dist_ID, Amount as Fund_Amount from Fund_Distribution;

-- 2. Alias for table
select fd.DistributionID, fd.Status from Fund_Distribution fd;

-- 3. Alias for concatenation
select concat(Approved_By, ' - ', Status) as Approval_Status from Fund_Distribution;

-- 4. Alias with case statement
select DistributionID, case when Status='Released' then 'Done' else 'Pending' end as Release_Status from Fund_Distribution;

-- 5. Alias for grouping
select Country_ID as CID, sum(Amount) as Total_Distribution from Fund_Distribution group by CID;

-- 6. Alias for expression
select Amount, Amount*1.05 as Revised_Amount from Fund_Distribution;

-- 7. Alias with substring
select substring(TrackingID,1,5) as Short_Track from Fund_Distribution;

-- 8. Alias with distinct
select distinct(Status) as Distinct_Status from Fund_Distribution;

-- 9. Alias with order by
select DistributionID as DID, Date_Allocated as Allocation_Date from Fund_Distribution order by Allocation_Date desc;

-- 10. Alias with min/max
select Program_ID as PID, max(Amount) as Max_Distribution from Fund_Distribution group by PID;

-- 11. Find distributions with above-average amount
select * from Fund_Distribution where Amount > (select avg(Amount) from Fund_Distribution);

-- 12. Find distributions with min amount
select * from Fund_Distribution where Amount = (select min(Amount) from Fund_Distribution);

-- 13. Get tracking IDs of pending distributions
select TrackingID from Fund_Distribution where Status='Pending'
and DistributionID in (select DistributionID from Fund_Distribution);

-- 14. Countries with more than one distribution
select Country_ID from Fund_Distribution group by Country_ID
having count(*) > (select avg(count(*)) from Fund_Distribution group by Country_ID);

-- 15. Programs funded with more than 1 lakh
select Program_ID from Fund_Distribution where Amount > 100000
and Program_ID in (select Program_ID from Programs);

-- 16. Most recent allocation
select * from Fund_Distribution where Date_Allocated = (select max(Date_Allocated) from Fund_Distribution);

-- 17. Least recent allocation
select * from Fund_Distribution where Date_Allocated = (select min(Date_Allocated) from Fund_Distribution);

-- 18. Find funds released by WHO from Funding table
select * from Fund_Distribution where Fund_ID in (select FundID from Funding where Source='WHO');

-- 19. Find distributions higher than Italy’s allocation
select * from Fund_Distribution 
where Amount > (select Amount from Fund_Distribution where Country_ID=15);

-- 20. Pending distributions after 2022
select * from Fund_Distribution where Status='Pending' 
and Date_Allocated > (select min(Date_Allocated) from Fund_Distribution where Status='Pending');

-- 21. Total distribution amount
select sum(Amount) as Total_Distributed from Fund_Distribution;

-- 22. Average amount per year
select year(Date_Allocated) as Year_Allocated, avg(Amount) as Avg_Amount from Fund_Distribution group by Year_Allocated;

-- 23. Count released vs pending
select Status, count(*) as Count_Status from Fund_Distribution group by Status;

-- 24. Maximum and minimum allocations
select max(Amount) as Max_Amount, min(Amount) as Min_Amount from Fund_Distribution;

-- 25. Round allocation values
select round(Amount,2) as Rounded_Amount from Fund_Distribution;

-- 26. Extract year from allocation date
select DistributionID, year(Date_Allocated) as Allocation_Year from Fund_Distribution;

-- 27. String length of remarks
select Remarks, length(Remarks) as Remark_Length from Fund_Distribution;

-- 28. Uppercase approvers
select upper(Approved_By) as Approver_Upper from Fund_Distribution;

-- 29. Replace text in remarks
select replace(Remarks,'allocation','ALLOC') as Updated_Remarks from Fund_Distribution;

-- 30. Substring from tracking ID
select substring(TrackingID,4,3) as Track_Code from Fund_Distribution;

-- 31. UDF: Convert to thousands
delimiter //
create function ToThousands(val double) returns double
deterministic
begin
  return val/1000;
end//
delimiter ;
select DistributionID, ToThousands(Amount) as Amount_in_Thousands from Fund_Distribution;

-- 32. UDF: Check if distribution is high value
delimiter //
create function HighValue(val double) returns varchar(10)
deterministic
begin
  if val >= 150000 then return 'High'; 
  else return 'Normal'; 
  end if;
end//
delimiter ;
select DistributionID, HighValue(Amount) as Category from Fund_Distribution;

-- 33. UDF: Mask Approver
delimiter //
create function MaskApprover(name varchar(100)) returns varchar(100)
deterministic
begin
  return concat(left(name,4),'***');
end//
delimiter ;
select DistributionID, MaskApprover(Approved_By) as Masked_Approver from Fund_Distribution;

-- 34. UDF: Is Released?
delimiter //
create function IsReleased(stat varchar(50)) returns varchar(10)
deterministic
begin
  if stat='Released' then return 'Yes'; 
  else return 'No'; 
  end if;
end//
delimiter ;
select DistributionID, IsReleased(Status) as Released_Check from Fund_Distribution;

-- 35. UDF: Days since allocation
delimiter //
create function DaysSinceAlloc(alloc date) returns int
deterministic
begin
  return datediff(curdate(), alloc);
end//
delimiter ;
select DistributionID, DaysSinceAlloc(Date_Allocated) as Days_Passed from Fund_Distribution;

-- 36. UDF: Status Category
delimiter //
create function StatusCategory(stat varchar(50)) returns varchar(20)
deterministic
begin
  case 
    when stat='Released' then return 'Completed';
    when stat='Pending' then return 'Awaiting';
    else return 'Unknown';
  end case;
end//
delimiter ;
select DistributionID, StatusCategory(Status) as Status_Category from Fund_Distribution;

-- 37. UDF: Amount with tax (5%)
delimiter //
create function WithTax(val double) returns double
deterministic
begin
  return val*1.05;
end//
delimiter ;
select DistributionID, WithTax(Amount) as Amount_With_Tax from Fund_Distribution;

-- 38. UDF: Short Remarks
delimiter //
create function ShortRemarks(txt varchar(100)) returns varchar(20)
deterministic
begin
  return substring(txt,1,20);
end//
delimiter ;
select DistributionID, ShortRemarks(Remarks) as Short_Remark from Fund_Distribution;

-- 39. UDF: Convert to USD (assume 1 EUR = 1.1 USD)
delimiter //
create function ToUSD(val double, curr varchar(10)) returns double
deterministic
begin
  if curr='EUR' then return val*1.1; 
  else return val; 
  end if;
end//
delimiter ;
select fd.DistributionID, ToUSD(f.Amount,'EUR') as Converted_Amount from Fund_Distribution fd join Funding f on fd.Fund_ID=f.FundID;

-- 40. UDF: Contribution percent
delimiter //
create function Contribution(val double, total double) returns double
deterministic
begin
  return (val/total)*100;
end//
delimiter ;
select DistributionID, Contribution(Amount,(select sum(Amount) from Fund_Distribution)) as Contribution_Percent from Fund_Distribution;

-- 41. Distribution with country details
select fd.DistributionID, c.Name, fd.Amount
from Fund_Distribution fd join Countries c on fd.Country_ID=c.CountryID;

-- 42. Distribution with program details
select fd.DistributionID, p.ProgramName, fd.Amount
from Fund_Distribution fd join Programs p on fd.Program_ID=p.ProgramID;

-- 43. Distribution with funding source
select fd.DistributionID, f.Source, fd.Amount
from Fund_Distribution fd join Funding f on fd.Fund_ID=f.FundID;

-- 44. Join with country and program
select fd.DistributionID, c.Name, p.ProgramName, fd.Amount
from Fund_Distribution fd
join Countries c on fd.Country_ID=c.CountryID
join Programs p on fd.Program_ID=p.ProgramID;

-- 45. Left join with funding
select fd.DistributionID, f.Source, f.Type
from Fund_Distribution fd left join Funding f on fd.Fund_ID=f.FundID;

-- 46. Total distribution per country
select c.Name, sum(fd.Amount) as Total_Distribution
from Fund_Distribution fd join Countries c on fd.Country_ID=c.CountryID
group by c.Name;

-- 47. Total distribution per program
select p.ProgramName, sum(fd.Amount) as Program_Total
from Fund_Distribution fd join Programs p on fd.Program_ID=p.ProgramID
group by p.ProgramName;

-- 48. Countries with pending distributions
select c.Name, fd.Amount
from Fund_Distribution fd join Countries c on fd.Country_ID=c.CountryID
where fd.Status='Pending';

-- 49. Programs with released distributions
select p.ProgramName, fd.Amount
from Fund_Distribution fd join Programs p on fd.Program_ID=p.ProgramID
where fd.Status='Released';

-- 50. Funding sources behind released distributions
select f.Source, count(fd.DistributionID) as Total_Released
from Fund_Distribution fd 
join Funding f on fd.Fund_ID=f.FundID
where fd.Status='Released'
group by f.Source;
