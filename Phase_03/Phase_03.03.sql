use who;

-- Table-11 Programs---------------------------------------------------------------------------------------------------------
-- 1. A: Display program name and budget with alias
select name as program_name, budget as total_budget from programs;

-- 2. A: Show manager and status with new aliases
select manager as head, status as current_status from programs;

-- 3. A: Alias for focus_area and objective
select focus_area as area, objective as goal from programs;

-- 4. A: Rename start_year and global
select start_year as launched, global as worldwide from programs;

-- 5. A: Combine name and manager with alias
select concat(name, ' - ', manager) as program_manager from programs;

-- 6. A: Alias to count programs per status
select status as prog_status, count(*) as total from programs group by status;

-- 7. A: Alias for expensive programs
select name as project, budget as funds from programs where budget > 20000000;

-- 8. A: Alias with ordering by year
select name as prog, start_year as launch_year from programs order by start_year;

-- 9. A: Alias on focus area grouping
select focus_area as category, count(*) as total_programs from programs group by focus_area;

-- 10. A: Alias for global programs only
select name as global_prog, manager as lead_manager from programs where global='Yes';

-- 11. SQ: Find programs with budget greater than avg budget
select * from programs 
where budget > (select avg(budget) from programs);

-- 12. SQ: Programs with the earliest start year
select * from programs 
where start_year = (select min(start_year) from programs);

-- 13. SQ: Managers leading more than one program
select * from programs 
where manager in (select manager from programs group by manager having count(*)>1);

-- 14. SQ: Programs in focus areas having active programs
select * from programs 
where focus_area in (select distinct focus_area from programs where status='Active');

-- 15. SQ: Programs with budget equal to max
select * from programs 
where budget = (select max(budget) from programs);

-- 16. SQ: Programs launched after 2015
select * from programs 
where start_year > (select min(start_year) from programs where global='Yes');

-- 17. SQ: Completed programs with same budget as any ongoing
select * from programs 
where budget in (select budget from programs where status='Ongoing');

-- 18. SQ: Programs managed by managers of global programs
select * from programs 
where manager in (select manager from programs where global='Yes');

-- 19. SQ: Programs with budget below average of active programs
select * from programs 
where budget < (select avg(budget) from programs where status='Active');

-- 20. SQ: Programs started before the earliest ongoing program
select * from programs 
where start_year < (select min(start_year) from programs where status='Ongoing');

-- 21. BIF: Uppercase program name
select upper(name) as prog_name from programs;

-- 22. BIF: Extract year from start_year
select year(start_year) as year_launched, name from programs;

-- 23. BIF: Round budget in millions
select name, round(budget/1000000,2) as budget_million from programs;

-- 24. BIF: Length of objective
select name, length(objective) as objective_length from programs;

-- 25. BIF: Programs started in month January
select name, month(start_year) as start_month from programs where month(start_year)=1;

-- 26. BIF: Concatenate name and status
select concat(name,' - ',status) as prog_status from programs;

-- 27. BIF: Replace spaces in manager with underscores
select replace(manager,' ','_') as manager_code from programs;

-- 28. BIF: Programs with budget ceiling
select name, ceiling(budget/1000000) as budget_million_ceil from programs;

-- 29. BIF: Substring first 10 chars of objective
select name, substring(objective,1,10) as obj_short from programs;

-- 30. BIF: Find day of start_year
select name, day(start_year) as launch_day from programs;

-- 31. get_program_duration_years: returns program duration in years from Start_Year till current year
delimiter //
create function get_program_duration_years(start_year date)
returns int deterministic
begin
  return year(curdate()) - year(start_year);
end //
delimiter ;
select ProgramID, Name, get_program_duration_years(Start_Year) as duration_years from Programs;

-- 32. is_global_program: checks if program is global
delimiter //
create function is_global_program(global_flag varchar(3))
returns varchar(20) deterministic
begin
  if global_flag = 'Yes' then
    return 'Global Program';
  else
    return 'Regional Program';
  end if;
end //
delimiter ;
select ProgramID, Name, is_global_program(Global) from Programs;

-- 33. classify_budget: classifies program budget
delimiter //
create function classify_budget(budget double)
returns varchar(30) deterministic
begin
  if budget >= 20000000 then
    return 'High Budget';
  elseif budget >= 10000000 then
    return 'Medium Budget';
  else
    return 'Low Budget';
  end if;
end //
delimiter ;
select ProgramID, Name, classify_budget(Budget) from Programs;

-- 34. is_program_active: returns 1 if status is Active else 0
delimiter //
create function is_program_active(status varchar(30))
returns int deterministic
begin
  if status = 'Active' then
    return 1;
  else
    return 0;
  end if;
end //
delimiter ;
select ProgramID, Name, is_program_active(Status) from Programs;

-- 35. years_since_start: calculates how many years passed since start
delimiter //
create function years_since_start(start_year date)
returns int deterministic
begin
  return timestampdiff(year, start_year, curdate());
end //
delimiter ;
select ProgramID, Name, years_since_start(Start_Year) as years_passed from Programs;

-- 36. program_short_code: generates short code from name
delimiter //
create function program_short_code(name varchar(100))
returns varchar(10) deterministic
begin
  return upper(left(name,3));
end //
delimiter ;
select ProgramID, Name, program_short_code(Name) as short_code from Programs;

-- 37. program_manager_lastname: extracts last name of manager
delimiter //
create function program_manager_lastname(manager varchar(100))
returns varchar(50) deterministic
begin
  return substring_index(manager,' ',-1);
end //
delimiter ;
select ProgramID, Name, program_manager_lastname(Manager) as manager_lastname from Programs;

-- 38. program_age_category: returns program type by age
delimiter //
create function program_age_category(start_year date)
returns varchar(30) deterministic
begin
  declare yrs int;
  set yrs = year(curdate()) - year(start_year);
  if yrs > 15 then
    return 'Legacy Program';
  elseif yrs >= 5 then
    return 'Established Program';
  else
    return 'New Program';
  end if;
end //
delimiter ;
select ProgramID, Name, program_age_category(Start_Year) from Programs;

-- 39. program_status_label: makes status more descriptive
delimiter //
create function program_status_label(status varchar(30))
returns varchar(50) deterministic
begin
  case status
    when 'Active' then return 'Currently Running';
    when 'Ongoing' then return 'In Progress';
    when 'Completed' then return 'Successfully Completed';
    when 'Pilot' then return 'Pilot Phase';
    when 'Planning' then return 'In Planning Stage';
    else return 'Unknown Status';
  end case;
end //
delimiter ;
select ProgramID, Name, program_status_label(Status) from Programs;

-- 40. partner_count: counts number of partner organizations
delimiter //
create function partner_count(partner_orgs text)
returns int deterministic
begin
  return length(partner_orgs) - length(replace(partner_orgs, ',', '')) + 1;
end //
delimiter ;
select ProgramID, Name, partner_count(Partner_Orgs) as partners from Programs;

-- 41. J: Join programs and emergency_responses by partner orgs
select p.name, e.responseid, p.partner_orgs
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%');

-- 42. J: Show program names and emergency status
select p.name, e.status as response_status
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%');

-- 43. J: Programs with coordinator names from responses
select p.name, e.coordinator
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%');

-- 44. J: Join to count total responses per program
select p.name, count(e.responseid) as total_responses
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%')
group by p.name;

-- 45. J: Programs with response costs
select p.name, e.cost
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%');

-- 46. J: Programs with start year vs response start date
select p.name, p.start_year, e.start_date
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%');

-- 47. J: Active programs with completed responses
select p.name, p.status, e.status
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%')
where p.status='Active' and e.status='Completed';

-- 48. J: Programs with total teams deployed in linked responses
select p.name, sum(e.teams_deployed) as teams
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%')
group by p.name;

-- 49. J: Programs and coordinators for global programs
select p.name, e.coordinator
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%')
where p.global='Yes';

-- 50. J: Program budgets and response costs together
select p.name, p.budget, e.cost
from programs p
join emergency_responses e
on p.partner_orgs like concat('%', e.partner_orgs, '%');

-- Table-12 Program_Participation--------------------------------------------------------------------------------------------
-- 1. display all data with alias for table
select p.* from Program_Participation p;

-- 2. alias for funding_received as total_funding
select ParticipationID, Funding_Received as total_funding from Program_Participation;

-- 3. alias for impact_rating as performance
select ParticipationID, Impact_Rating as performance from Program_Participation;

-- 4. alias for coordinator as lead
select ParticipationID, Coordinator as lead_person from Program_Participation;

-- 5. alias for status as project_status
select ParticipationID, Status as project_status from Program_Participation;

-- 6. alias for start_date and end_date
select Start_Date as start_dt, End_Date as end_dt from Program_Participation;

-- 7. alias with multiple columns
select ParticipationID as pid, Program_ID as progid, Country_ID as cid from Program_Participation;

-- 8. alias table with shorter name
select pp.ParticipationID, pp.Status from Program_Participation pp;

-- 9. alias funding calculation
select Funding_Received * 1.1 as adjusted_funding from Program_Participation;

-- 10. alias impact score
select Impact_Rating + 1 as adjusted_rating from Program_Participation;

-- 11. programs with funding above average
select * from Program_Participation
where Funding_Received > (select avg(Funding_Received) from Program_Participation);

-- 12. coordinators with highest impact rating
select Coordinator from Program_Participation
where Impact_Rating = (select max(Impact_Rating) from Program_Participation);

-- 13. participations linked to program with max funding
select * from Program_Participation
where Program_ID in (select Program_ID from Program_Participation order by Funding_Received desc);

-- 14. participations linked to completed programs only
select * from Program_Participation
where Status = (select distinct Status from Program_Participation where Status='Completed');

-- 15. participation with min funding
select * from Program_Participation
where Funding_Received = (select min(Funding_Received) from Program_Participation);

-- 16. participations from coordinators handling more than 1 project
select * from Program_Participation
where Coordinator in (
  select Coordinator from Program_Participation group by Coordinator having count(*)>1
);

-- 17. participations with rating above overall average
select * from Program_Participation
where Impact_Rating > (select avg(Impact_Rating) from Program_Participation);

-- 18. participations ending after the latest start date
select * from Program_Participation
where End_Date > (select max(Start_Date) from Program_Participation);

-- 19. participations with funding greater than program 1
select * from Program_Participation
where Funding_Received > (select Funding_Received from Program_Participation where Program_ID=1);

-- 20. participations with earliest start date
select * from Program_Participation
where Start_Date = (select min(Start_Date) from Program_Participation);

-- 21. length of comments
select ParticipationID, length(Comments) as comment_length from Program_Participation;

-- 22. upper case coordinator name
select upper(Coordinator) as coord_upper from Program_Participation;

-- 23. lower case status
select lower(Status) as status_lower from Program_Participation;

-- 24. round impact rating
select round(Impact_Rating,1) as rounded_rating from Program_Participation;

-- 25. year from start date
select year(Start_Date) as start_year from Program_Participation;

-- 26. month from end date
select month(End_Date) as end_month from Program_Participation;

-- 27. substring of coordinator name
select substring(Coordinator,1,5) as coord_short from Program_Participation;

-- 28. coalesce for null end_date
select coalesce(End_Date, curdate()) as end_final from Program_Participation;

-- 29. concat coordinator and status
select concat(Coordinator,' - ',Status) as coord_status from Program_Participation;

-- 30. ifnull on comments
select ifnull(Comments,'No remarks') as remarks from Program_Participation;

-- 31. years_between_start_end
delimiter //
create function years_between_start_end(start_date date, end_date date)
returns int deterministic
begin
  if end_date is null then
    return timestampdiff(year,start_date,curdate());
  else
    return timestampdiff(year,start_date,end_date);
  end if;
end //
delimiter ;
select ParticipationID, years_between_start_end(Start_Date,End_Date) as years_spanned from Program_Participation;

-- 32. classify_impact
delimiter //
create function classify_impact(rating float)
returns varchar(20) deterministic
begin
  if rating >= 4.5 then
    return 'Excellent';
  elseif rating >= 3.5 then
    return 'Good';
  else
    return 'Average';
  end if;
end //
delimiter ;
select ParticipationID, classify_impact(Impact_Rating) as rating_class from Program_Participation;

-- 33. funding_level
delimiter //
create function funding_level(funding double)
returns varchar(20) deterministic
begin
  if funding > 2000000 then
    return 'High';
  elseif funding > 1000000 then
    return 'Medium';
  else
    return 'Low';
  end if;
end //
delimiter ;
select ParticipationID, funding_level(Funding_Received) from Program_Participation;

-- 34. status_flag
delimiter //
create function status_flag(status varchar(30))
returns int deterministic
begin
  if status='Completed' then
    return 1;
  else
    return 0;
  end if;
end //
delimiter ;
select ParticipationID, status_flag(Status) from Program_Participation;

-- 35. coordinator_lastname
delimiter //
create function coordinator_lastname(name varchar(100))
returns varchar(50) deterministic
begin
  return substring_index(name,' ',-1);
end //
delimiter ;
select ParticipationID, coordinator_lastname(Coordinator) from Program_Participation;

-- 36. participation_status_label
delimiter //
create function participation_status_label(status varchar(30))
returns varchar(50) deterministic
begin
  case status
    when 'Active' then return 'Currently Active';
    when 'Ongoing' then return 'In Progress';
    when 'Completed' then return 'Finished';
    when 'Pilot' then return 'Trial Stage';
    else return 'Other';
  end case;
end //
delimiter ;
select ParticipationID, participation_status_label(Status) from Program_Participation;

-- 37. funding_per_year
delimiter //
create function funding_per_year(funding double, start_date date, end_date date)
returns double deterministic
begin
  declare yrs int;
  if end_date is null then
    set yrs = timestampdiff(year, start_date, curdate());
  else
    set yrs = timestampdiff(year, start_date, end_date);
  end if;
  if yrs=0 then
    return funding;
  else
    return funding/yrs;
  end if;
end //
delimiter ;
select ParticipationID, funding_per_year(Funding_Received,Start_Date,End_Date) from Program_Participation;

-- 38. program_term
delimiter //
create function program_term(start_date date, end_date date)
returns varchar(30) deterministic
begin
  if end_date is null then
    return 'Ongoing';
  elseif year(end_date)-year(start_date) > 5 then
    return 'Long-term';
  else
    return 'Short-term';
  end if;
end //
delimiter ;
select ParticipationID, program_term(Start_Date,End_Date) from Program_Participation;

-- 39. comment_length_category
delimiter //
create function comment_length_category(c text)
returns varchar(20) deterministic
begin
  if length(c) > 50 then
    return 'Detailed';
  else
    return 'Brief';
  end if;
end //
delimiter ;
select ParticipationID, comment_length_category(Comments) from Program_Participation;

-- U40. is_high_impact_completed
delimiter //
create function is_high_impact_completed(status varchar(30), rating float)
returns varchar(20) deterministic
begin
  if status='Completed' and rating >=4.5 then
    return 'High Impact Success';
  else
    return 'Other';
  end if;
end //
delimiter ;
select ParticipationID, is_high_impact_completed(Status,Impact_Rating) from Program_Participation;

-- 41. join with programs to get program name
select pp.ParticipationID, pr.Name, pp.Status
from Program_Participation pp
join Programs pr on pp.Program_ID = pr.ProgramID;

-- 42. join with countries to get country name
select pp.ParticipationID, c.Name as country, pp.Status
from Program_Participation pp
join Countries c on pp.Country_ID = c.CountryID;

-- 43. join with programs and countries together
select pp.ParticipationID, pr.Name as program, c.Name as country, pp.Status
from Program_Participation pp
join Programs pr on pp.Program_ID=pr.ProgramID
join Countries c on pp.Country_ID=c.CountryID;

-- 44. list participations with program manager
select pp.ParticipationID, pr.Manager, pp.Coordinator
from Program_Participation pp
join Programs pr on pp.Program_ID=pr.ProgramID;

-- 45. country and funding received
select c.Name, sum(pp.Funding_Received) as total_funding
from Program_Participation pp
join Countries c on pp.Country_ID=c.CountryID
group by c.Name;

-- 46. program vs impact rating
select pr.Name, avg(pp.Impact_Rating) as avg_rating
from Program_Participation pp
join Programs pr on pp.Program_ID=pr.ProgramID
group by pr.Name;

-- 47. active programs by country
select c.Name, count(*) as active_projects
from Program_Participation pp
join Countries c on pp.Country_ID=c.CountryID
where pp.Status='Active'
group by c.Name;

-- 48. join with alias
select pp.ParticipationID, pr.Name as prog, c.Name as cntry
from Program_Participation pp
join Programs pr on pp.Program_ID=pr.ProgramID
join Countries c on pp.Country_ID=c.CountryID;

-- 49. coordinators by program and country
select pr.Name, c.Name, pp.Coordinator
from Program_Participation pp
join Programs pr on pp.Program_ID=pr.ProgramID
join Countries c on pp.Country_ID=c.CountryID;

-- 50. completed participations with program details
select pp.ParticipationID, pr.Name, c.Name, pp.Status
from Program_Participation pp
join Programs pr on pp.Program_ID=pr.ProgramID
join Countries c on pp.Country_ID=c.CountryID
where pp.Status='Completed';

-- Table-13 Labs-------------------------------------------------------------------------------------------------------------
-- 1. list lab names with alias for labid and name
select l.labid as id, l.name as lab_name from labs l;

-- 2. show labs with capacity aliased as total_capacity
select name, capacity as total_capacity from labs;

-- 3. get lab city with alias
select city as lab_city, country_id as country from labs;

-- 4. alias established_year as year_established
select name, established_year as year_established from labs;

-- 5. alias iso_certified for clarity
select name as lab_name, iso_certified as certification from labs;

-- 6. list labs with type alias
select name, type as lab_type from labs;

-- 7. alias accredited as status
select name, accredited as accreditation_status from labs;

-- 8. alias contact number
select name, contact as phone_number from labs;

-- 9. alias combined city-country
select concat(city, '-', country_id) as location from labs;

-- 10. alias everything clearly
select labid as id, name as lab_name, capacity as lab_capacity from labs;

-- 11. labs with capacity above average
select name, capacity 
from labs 
where capacity > (select avg(capacity) from labs);

-- 12. labs established after the oldest lab
select name, established_year
from labs
where established_year > (select min(established_year) from labs);

-- 13. labs with max capacity
select name 
from labs 
where capacity = (select max(capacity) from labs);

-- 14. labs in the same city as 'Tokyo Genetic Research Institute'
select name 
from labs
where city = (select city from labs where name = 'Tokyo Genetic Research Institute');

-- 15. labs certified same as 'ISO 15189'
select name 
from labs
where iso_certified = (select iso_certified from labs where labid = 1);

-- 16. labs established before avg year
select name, established_year
from labs
where established_year < (select avg(established_year) from labs);

-- 17. labs with capacity greater than 'Abuja Tropical Disease Unit'
select name
from labs
where capacity > (select capacity from labs where name = 'Abuja Tropical Disease Unit');

-- 18. labs not accredited like the majority
select name
from labs
where accredited <> (select accredited from labs group by accredited order by count(*) desc limit 1);

-- 19. labs in country with min labid
select name
from labs
where country_id = (select min(country_id) from labs);

-- 20. labs with later year than ‘Berlin Immuno Lab’
select name
from labs
where established_year > (select established_year from labs where name = 'Berlin Immuno Lab');

-- 21. uppercase lab names
select upper(name) from labs;

-- 22. lowercase cities
select lower(city) from labs;

-- 23. substring of contact number
select name, substring(contact,1,5) as short_contact from labs;

-- 24. length of lab names
select name, length(name) as name_length from labs;

-- 25. labs capacity squared
select name, power(capacity,2) as capacity_squared from labs;

-- 26. labs with rounded capacity/100
select name, round(capacity/100,2) as rounded_capacity from labs;

-- 27. get current year difference with established year
select name, year(curdate()) - established_year as lab_age from labs;

-- 28. left 3 letters of city
select left(city,3) as short_city from labs;

-- 29. concatenate name and type
select concat(name,' - ',type) as lab_info from labs;

-- 30. replace ISO in certification with CERT
select replace(iso_certified,'ISO','CERT') from labs;

-- 31. udf to get lab age
delimiter //
create function get_lab_age(established_year int)
returns int deterministic
begin
  return year(curdate()) - established_year;
end;
//
delimiter ;
select name, get_lab_age(established_year) from labs;

-- 32. udf to classify lab capacity
delimiter //
create function classify_capacity(capacity int)
returns varchar(20) deterministic
begin
  if capacity >= 500 then
    return 'High';
  elseif capacity >= 200 then
    return 'Medium';
  else
    return 'Low';
  end if;
end;
//
delimiter ;
select name, classify_capacity(capacity) from labs;

-- 33. udf to mask contact
delimiter //
create function mask_contact(contact varchar(50))
returns varchar(50) deterministic
begin
  return concat(left(contact, 3), '****', right(contact, 3));
end;
//
delimiter ;
select name, mask_contact(contact) from labs;

-- 34. udf to check iso compliance
delimiter //
create function check_iso(iso_certified varchar(5))
returns varchar(20) deterministic
begin
  if iso_certified = 'Yes' then
    return 'ISO Certified';
  else
    return 'Not Certified';
  end if;
end;
//
delimiter ;
select name, check_iso(iso_certified) from labs;

-- 35. udf to get short name
delimiter //
create function short_labname(lab_name varchar(100))
returns varchar(20) deterministic
begin
  return left(lab_name, 10);
end;
//
delimiter ;
select name, short_labname(name) from labs;

-- 36. udf to calculate efficiency score
delimiter //
create function efficiency_score(capacity int, established_year int)
returns int deterministic
begin
  return capacity / (year(curdate()) - established_year + 1);
end;
//
delimiter ;
select name, efficiency_score(capacity, established_year) from labs;

-- 37. udf to tag labs as old/new
delimiter //
create function tag_lab(established_year int)
returns varchar(20) deterministic
begin
  if established_year < 2000 then
    return 'Old Lab';
  else
    return 'New Lab';
  end if;
end;
//
delimiter ;
select name, tag_lab(established_year) from labs;

-- 38. udf to standardize phone
delimiter //
create function standard_phone(contact varchar(50))
returns varchar(50) deterministic
begin
  return concat('+91-', contact);
end;
//
delimiter ;
select name, standard_phone(contact) from labs;

-- 39. udf to append accreditation label
delimiter //
create function accreditation_label(accredited varchar(5))
returns varchar(30) deterministic
begin
  if accredited = 'Yes' then
    return 'Accredited Lab';
  else
    return 'Unaccredited Lab';
  end if;
end;
//
delimiter ;
select name, accreditation_label(accredited) from labs;

-- 40. udf to compute weighted capacity
delimiter //
create function weighted_capacity(capacity int, established_year int)
returns double deterministic
begin
  return capacity * (year(curdate()) - established_year + 1);
end;
//
delimiter ;
select name, weighted_capacity(capacity, established_year) from labs;

-- 41. list lab with its country name
select l.name, c.name as country
from labs l
join countries c on l.country_id = c.countryid;

-- 42. labs in asia continent
select l.name, c.region
from labs l
join countries c on l.country_id = c.countryid
where c.region like '%Asia%';

-- 43. labs with country population
select l.name, c.population
from labs l
join countries c on l.country_id = c.countryid;

-- 44. labs in countries per AreaSqKm
select l.name, c.areasqkm
from labs l
join countries c on l.country_id = c.countryid
where c.areasqkm in (select areasqkm from countries order by areasqkm desc );

-- 45. labs accredited 'Yes' with country
select l.name, c.name as country
from labs l
join countries c on l.country_id = c.countryid
where l.accredited='Yes';

-- 46. labs established before 2000 with country
select l.name, l.established_year, c.name as country
from labs l
join countries c on l.country_id = c.countryid
where l.established_year<2000;

-- 47. labs capacity above avg of their country
select l.name, l.capacity, c.name as country
from labs l
join countries c on l.country_id=c.countryid
where l.capacity>(select avg(capacity) from labs l2 where l2.country_id=l.country_id);

-- 48. labs with continent alias
select l.name, c.region as region
from labs l
join countries c on l.country_id=c.countryid;

-- 49. labs with combined iso and country name
select concat(l.iso_certified,'-',c.name) as lab_country_iso
from labs l
join countries c on l.country_id=c.countryid;

-- 50. labs with manager country capital
select l.name, c.capital
from labs l
join countries c on l.country_id=c.countryid;

-- Table-14 Lab_Tests--------------------------------------------------------------------------------------------------------
-- 1. list labs with alias for name
select name as lab_name, city as location from labs;

-- 2. alias for established_year
select name, established_year as founded_in from labs;

-- 3. alias for capacity
select name, capacity as lab_capacity from labs;

-- 4. alias for contact number
select name, contact as phone_number from labs;

-- 5. multiple aliases
select name as lab, iso_certified as iso_status, accredited as accred_status from labs;

-- 6. alias with condition
select name as lab_name, city as located_in from labs where capacity > 100;

-- 7. alias with sorting
select name as lab, capacity as cap from labs order by cap desc;

-- 8. alias for accreditation
select name as lab, accredited as accred_label from labs;

-- 9. alias for Test types
select name as lab, test_type as types from labs;

-- 10. alias for all columns
select name as lab, city as location, contact as phone, capacity as strength from labs;

-- 11. labs with max capacity
select name from labs where capacity = (select max(capacity) from labs);

-- 12. labs older than avg year
select name, established_year from labs 
where established_year < (select avg(established_year) from labs);

-- 13. labs in cities with multiple labs
select name, city from labs 
where city in (select city from labs group by city having count(*) > 1);

-- 14. labs with capacity above avg
select name, capacity from labs 
where capacity > (select avg(capacity) from labs);

-- 15. labs with earliest establishment
select name from labs 
where established_year = (select min(established_year) from labs);

-- 16. labs not accredited but capacity higher than avg
select name from labs 
where accredited = 'No' and capacity > (select avg(capacity) from labs);

-- 17. labs with iso certified matching min capacity
select name from labs 
where iso_certified = 'Yes' and capacity = (select min(capacity) from labs);

-- 18. labs from same city as lab with highest capacity
select name, city from labs 
where city in (select city from labs where capacity = (select max(capacity) from labs));

-- 19. labs capacity less than all iso-certified labs
select name, capacity from labs 
where capacity < all(select capacity from labs where iso_certified='Yes');

-- 20. labs with capacity greater than any non-certified lab
select name, capacity from labs 
where capacity > any(select capacity from labs where iso_certified='No');

-- 21. length of lab names
select name, length(name) as name_length from labs;

-- 22. upper case lab names
select upper(name) as upper_name from labs;

-- 23. lower case city names
select lower(city) as lower_city from labs;

-- 24. substring lab name
select substring(name,1,5) as short_name from labs;

-- 25. year difference since establishment
select name, year(curdate())-established_year as age from labs;

-- 26. average capacity of labs
select avg(capacity) as avg_capacity from labs;

-- 27. total labs per city
select city, count(*) as lab_count from labs group by city;

-- 28. replace in contact number
select name, replace(contact,'-','') as clean_contact from labs;

-- 29. round cost (dummy for double column)
select name, round(capacity/3,2) as cap_score from labs;

-- 30. concat city and contact
select concat(city,'-',contact) as city_contact from labs;

-- 31. udf to calculate positivity rate
delimiter //
create function positivity_rate(positives int, samples_tested int)
returns double deterministic
begin
  if samples_tested = 0 then
    return 0;
  end if;
  return (positives * 100.0) / samples_tested;
end;
//
delimiter ;
select testid, positivity_rate(positives, samples_tested) as positivity_pct from lab_tests;

-- 32. udf to calculate negativity rate
delimiter //
create function negativity_rate(negatives int, samples_tested int)
returns double deterministic
begin
  if samples_tested = 0 then
    return 0;
  end if;
  return (negatives * 100.0) / samples_tested;
end;
//
delimiter ;
select testid, negativity_rate(negatives, samples_tested) as negativity_pct from lab_tests;

-- 33. udf to classify positivity severity
delimiter //
create function classify_result(positives int, samples_tested int)
returns varchar(20) deterministic
begin
  declare rate double;
  if samples_tested = 0 then
    return 'No Data';
  end if;
  set rate = (positives * 100.0) / samples_tested;
  if rate >= 30 then
    return 'High Risk';
  elseif rate >= 10 then
    return 'Moderate Risk';
  else
    return 'Low Risk';
  end if;
end;
//
delimiter ;
select testid, classify_result(positives, samples_tested) as severity from lab_tests;

-- 34. udf to get year of test
delimiter //
create function get_test_year(test_date date)
returns int deterministic
begin
  return year(test_date);
end;
//
delimiter ;
select testid, get_test_year(test_date) as test_year from lab_tests;

-- 35. udf to mask notes
delimiter //
create function mask_notes(notes text)
returns varchar(100) deterministic
begin
  return concat(left(notes, 20), '...');
end;
//
delimiter ;
select testid, mask_notes(notes) as masked_notes from lab_tests;

-- 36. udf to compute efficiency ratio (positives/negatives)
delimiter //
create function efficiency_ratio(positives int, negatives int)
returns double deterministic
begin
  if negatives = 0 then
    return positives;
  end if;
  return positives / negatives;
end;
//
delimiter ;
select testid, efficiency_ratio(positives, negatives) as efficiency from lab_tests;

-- 37. udf to tag method type
delimiter //
create function tag_method(method varchar(100))
returns varchar(30) deterministic
begin
  if method like '%PCR%' then
    return 'Molecular';
  elseif method like '%Microscopy%' then
    return 'Microscopy';
  elseif method like '%ELISA%' then
    return 'Immunoassay';
  else
    return 'Other';
  end if;
end;
//
delimiter ;
select testid, tag_method(method) as method_category from lab_tests;

-- 38. udf to compute pending samples
delimiter //
create function pending_samples(samples_tested int, positives int, negatives int)
returns int deterministic
begin
  return samples_tested - (positives + negatives);
end;
//
delimiter ;
select testid, pending_samples(samples_tested, positives, negatives) as pending from lab_tests;

-- 39. udf to standardize test type name
delimiter //
create function standard_test_type(test_type varchar(50))
returns varchar(50) deterministic
begin
  return upper(test_type);
end;
//
delimiter ;
select testid, standard_test_type(test_type) as std_test_type from lab_tests;

-- 40. udf to assign batch label
delimiter //
create function batch_label(test_date date, lab_id int)
returns varchar(50) deterministic
begin
  return concat('BATCH-', year(test_date), '-', lab_id);
end;
//
delimiter ;
select testid, batch_label(test_date, lab_id) as batch_id from lab_tests;

-- 41. join lab_tests with diseases to get disease name
select lt.testid, d.name as disease_name, lt.positives
from lab_tests lt
join diseases d on lt.disease_id = d.diseaseid;

-- 42. join lab_tests with labs to get lab name
select lt.testid, l.name as lab_name, lt.samples_tested
from lab_tests lt
join labs l on lt.lab_id = l.labid;

-- 43. join with both labs and diseases
select lt.testid, l.name as lab, d.name as disease, lt.test_type
from lab_tests lt
join labs l on lt.lab_id = l.labid
join diseases d on lt.disease_id = d.diseaseid;

-- 44. join with labs to fetch lab country
select lt.testid, l.name as lab, l.name as country
from lab_tests lt
join labs l on lt.lab_id = l.labid;

-- 45. join with diseases to fetch severity
select lt.testid, d.name as disease, d.severity_level
from lab_tests lt
join diseases d on lt.disease_id = d.diseaseid;

-- 46. join and alias columns
select lt.testid as tid, l.name as lab_name, d.name as disease_name
from lab_tests lt
join labs l on lt.lab_id = l.labid
join diseases d on lt.disease_id = d.diseaseid;

-- 47. join with labs for established year
select lt.testid, l.name as lab, l.established_year
from lab_tests lt
join labs l on lt.lab_id = l.labid;

-- 48. join to get iso certified labs
select lt.testid, l.name as lab, l.iso_certified
from lab_tests lt
join labs l on lt.lab_id = l.labid
where l.iso_certified='Yes';

-- 49. join to fetch disease transmission
select lt.testid, d.name as disease, d.transmission_mode
from lab_tests lt
join diseases d on lt.disease_id = d.diseaseid;

-- 50. join labs and diseases, fetch combined info
select lt.testid, l.name as lab, d.name as disease, lt.method
from lab_tests lt
join labs l on lt.lab_id = l.labid
join diseases d on lt.disease_id = d.diseaseid;

-- Table-15 Reports----------------------------------------------------------------------------------------------------------
-- 1. alias for title and topic
select title as report_title, topic as subject from reports;

-- 2. alias for author and region
select author as writer, region as area from reports;

-- 3. alias for date published
select title, date_published as published_on from reports;

-- 4. alias for summary
select title, summary as report_summary from reports;

-- 5. multiple aliases
select title as report, language as lang, reviewed as status from reports;

-- 6. alias with condition
select title as report_title, region as coverage from reports where reviewed='Yes';

-- 7. alias with sorting
select title as report, author as writer from reports order by date_published desc;

-- 8. alias for url
select title as report, url as source_link from reports;

-- 9. alias for all columns
select reportid as id, title as report, author as writer, region as zone from reports;

-- 10. alias with concat
select concat(title,' - ',topic) as report_info from reports;

-- 11. reports published after average year
select title, date_published from reports
where year(date_published) > (select avg(year(date_published)) from reports);

-- 12. reports authored by those with multiple publications
select title, author from reports
where author in (select author from reports group by author having count(*) > 1);

-- 13. most recent report
select * from reports
where date_published = (select max(date_published) from reports);

-- 14. earliest report
select * from reports
where date_published = (select min(date_published) from reports);

-- 15. reports in the same region as 'COVID-19 Pandemic Global Review'
select title, region from reports
where region = (select region from reports where title='COVID-19 Pandemic Global Review');

-- 16. reports with topics also in Diseases table
select title, topic from reports
where topic in (select name from diseases);

-- 17. reports reviewed = Yes with oldest publish year
select title from reports
where reviewed='Yes' and year(date_published) = (select min(year(date_published)) from reports where reviewed='Yes');

-- 18. authors who have at least 2 reports
select author from reports
where author in (select author from reports group by author having count(*) >= 2);

-- 19. reports in regions with more than 2 reports
select title, region from reports
where region in (select region from reports group by region having count(*) > 2);

-- 20. reports not reviewed but newer than avg year
select title, reviewed from reports
where reviewed='No' and year(date_published) > (select avg(year(date_published)) from reports);

-- 21. length of title
select title, length(title) as title_length from reports;

-- 22. upper case author names
select upper(author) as author_name from reports;

-- 23. lower case topic
select lower(topic) as topic_lower from reports;

-- 24. substring of title
select substring(title,1,15) as short_title from reports;

-- 25. year difference since publication
select title, year(curdate())-year(date_published) as years_old from reports;

-- 26. average report length (summary length)
select avg(length(summary)) as avg_summary_length from reports;

-- 27. total reports per language
select language, count(*) as count_reports from reports group by language;

-- 28. replace spaces in title with underscores
select replace(title,' ','_') as slug_title from reports;

-- 29. concat topic and region
select concat(topic,'-',region) as topic_region from reports;

-- 30. coalesce reviewed column
select title, coalesce(reviewed,'Unknown') as review_status from reports;

-- 31. udf to get report age in years
delimiter //
create function report_age(pub_date date)
returns int deterministic
begin
  return year(curdate()) - year(pub_date);
end;
//
delimiter ;
select reportid, report_age(date_published) as age_years from reports;

-- 32. udf to classify review status
delimiter //
create function review_status_flag(reviewed varchar(50))
returns varchar(20) deterministic
begin
  if reviewed='Yes' then
    return 'Reviewed';
  elseif reviewed='No' then
    return 'Pending';
  else
    return 'Unknown';
  end if;
end;
//
delimiter ;
select reportid, review_status_flag(reviewed) as review_flag from reports;

-- 33. udf to mask author name
delimiter //
create function mask_author(author varchar(100))
returns varchar(100) deterministic
begin
  return concat(left(author,3),'***');
end;
//
delimiter ;
select reportid, mask_author(author) as masked_author from reports;

-- 34. udf to extract publish year
delimiter //
create function get_publish_year(pub_date date)
returns int deterministic
begin
  return year(pub_date);
end;
//
delimiter ;
select reportid, get_publish_year(date_published) as pub_year from reports;

-- 35. udf to standardize language
delimiter //
create function std_language(lang varchar(50))
returns varchar(50) deterministic
begin
  return upper(lang);
end;
//
delimiter ;
select reportid, std_language(language) as standardized_language from reports;

-- 36. udf to create citation string
delimiter //
create function citation(author varchar(100), title varchar(200), pub_date date)
returns varchar(300) deterministic
begin
  return concat(author,' (',year(pub_date),'). ',title);
end;
//
delimiter ;
select reportid, citation(author,title,date_published) as citation_text from reports;

-- 37. udf to tag region type
delimiter //
create function region_tag(region varchar(50))
returns varchar(50) deterministic
begin
  if region like '%Asia%' then
    return 'Asian Region';
  elseif region like '%Europe%' then
    return 'European Region';
  elseif region like '%Africa%' then
    return 'African Region';
  else
    return 'Other Region';
  end if;
end;
//
delimiter ;
select reportid, region_tag(region) as region_category from reports;

-- 38. udf to truncate summary
delimiter //
create function truncate_summary(summary text)
returns varchar(100) deterministic
begin
  return concat(left(summary,50),'...');
end;
//
delimiter ;
select reportid, truncate_summary(summary) as short_summary from reports;

-- 39. udf to assign importance based on year
delimiter //
create function importance(pub_date date)
returns varchar(20) deterministic
begin
  if year(pub_date) >= 2023 then
    return 'High';
  elseif year(pub_date) >= 2020 then
    return 'Medium';
  else
    return 'Low';
  end if;
end;
//
delimiter ;
select reportid, importance(date_published) as importance_level from reports;

-- 40. udf to create url tag
delimiter //
create function url_tag(url text)
returns varchar(50) deterministic
begin
  return concat('Source: ', left(url,30),'...');
end;
//
delimiter ;
select reportid, url_tag(url) as url_label from reports;

-- 41. reports matched with diseases
select r.title, r.topic, d.severity_level
from reports r
join diseases d on r.topic = d.name;

-- 42. reports with disease transmission info
select r.title, d.transmission_mode
from reports r
join diseases d on r.topic = d.name;

-- 43. reports with disease origin
select r.title, d.origin_country
from reports r
join diseases d on r.topic = d.name;

-- 44. list reports with labs in the same region
select r.title, l.name as lab, c.name as country
from reports r
join countries c on r.region like concat('%', c.name, '%')
join labs l on l.country_id = c.countryid;

-- 45. count labs per report region
select r.region, count(l.labid) as lab_count
from reports r
join countries c on r.region like concat('%', c.name, '%')
join labs l on l.country_id = c.countryid
group by r.region;

-- 46. reports mentioning countries that have iso-certified labs
select distinct r.title, c.name as country
from reports r
join countries c on r.region like concat('%', c.name, '%')
join labs l on l.country_id = c.countryid
where l.iso_certified = 'ISO 9001';

-- 47. list labs and the reports available for their countries
select l.name as lab, c.name as country, group_concat(r.title) as reports
from labs l
join countries c on l.country_id = c.countryid
join reports r on r.region like concat('%', c.name, '%')
group by l.labid, c.name;

-- 48. find countries with reports but no labs
select distinct r.region
from reports r
left join countries c on r.region like concat('%', c.name, '%')
left join labs l on l.country_id = c.countryid
where l.labid is null;

-- 49. get latest report for each country with labs
select r.title, r.date_published, c.name as country, l.name as lab
from reports r
join countries c on r.region like concat('%', c.name, '%')
join labs l on l.country_id = c.countryid
where r.date_published = (
    select max(r2.date_published)
    from reports r2
    where r2.region like concat('%', c.name, '%')
);

-- 50. rank countries by number of reports and labs
select c.name as country, count(distinct r.reportid) as report_count, count(distinct l.labid) as lab_count
from countries c
left join reports r on r.region like concat('%', c.name, '%')
left join labs l on l.country_id = c.countryid
group by c.name
order by report_count desc, lab_count desc;
