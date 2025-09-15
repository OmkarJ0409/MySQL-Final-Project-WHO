use who;

-- Table-6 Hospitals---------------------------------------------------------------------------------------------------------
-- 1. Show all hospital names with alias h
select h.name as hospital_name from hospitals h;

-- 2. Show HospitalID and Capacity with short aliases
select h.hospitalid as hid, h.capacity as cap from hospitals h;

-- 3. Show City and Country_ID with alias
select h.city as hospital_city, h.country_id as cid from hospitals h;

-- 4. Show Type and Accreditation with alias
select h.type as hospital_type, h.accreditation as accred from hospitals h;

-- 5. Show Public hospitals with alias status
select h.public as status from hospitals h;

-- 6. Show Established_Date with alias founded
select h.established_date as founded from hospitals h;

-- 7. Show Contact with alias phone
select h.contact as phone from hospitals h;

-- 8. Show all hospital details with alias h
select h.* from hospitals h;

-- 9. Show name and city with short alias
select h.name as n, h.city as c from hospitals h;

-- 10. Combine hospital name and accreditation
select h.name as hospital, h.accreditation as accred_body from hospitals h;

-- 11. Hospitals with maximum capacity
select * from hospitals where capacity = (select max(capacity) from hospitals);

-- 12. Hospitals older than the average establishment year
select * from hospitals where year(established_date) < (select avg(year(established_date)) from hospitals);

-- 13. Hospitals in the same city as 'Mayo Clinic'
select * from hospitals where city = (select city from hospitals where name='Mayo Clinic');

-- 14. Hospitals accredited with same body as 'AIIMS'
select * from hospitals where accreditation = (select accreditation from hospitals where name='All India Institute of Medical Sciences');

-- 15. Hospitals with capacity greater than 'Royal Children’s Hospital'
select * from hospitals where capacity > (select capacity from hospitals where name='Royal Children’s Hospital');

-- 16. Hospitals not public
select * from hospitals where public = (select distinct public from hospitals where public='No');

-- 17. Hospitals established earliest
select * from hospitals where established_date = (select min(established_date) from hospitals);

-- 18. Hospitals in countries same as 'Toronto General Hospital'
select * from hospitals where country_id = (select country_id from hospitals where name='Toronto General Hospital');

-- 19. Hospitals with same type as 'Charité – Universitätsmedizin'
select * from hospitals where type = (select type from hospitals where name='Charité – Universitätsmedizin');

-- 20. Hospitals newer than 'St Thomas’ Hospital'
select * from hospitals where established_date > (select established_date from hospitals where name='St Thomas’ Hospital');

-- 21. Count total hospitals
select count(*) as total_hospitals from hospitals;

-- 22. Maximum capacity
select max(capacity) as largest_capacity from hospitals;

-- 23. Minimum capacity
select min(capacity) as smallest_capacity from hospitals;

-- 24. Average capacity
select avg(capacity) as avg_capacity from hospitals;

-- 25. Convert all hospital names to upper case
select upper(name) from hospitals;

-- 26. Convert city names to lower case
select lower(city) from hospitals;

-- 27. Get length of hospital name
select name, length(name) as name_length from hospitals;

-- 28. Concatenate hospital name and city
select concat(name,' (',city,')') as hospital_location from hospitals;

-- 29. Extract year from Established_Date
select name, year(established_date) as est_year from hospitals;

-- 30. Replace 'Hospital' with 'Med Center' in names
select replace(name,'Hospital','Med Center') from hospitals;

-- 31. UDF to check if hospital is public
delimiter //
create function is_public(hid int)
returns varchar(5)
deterministic
begin
  declare p varchar(5);
  select public into p from hospitals where hospitalid=hid;
  return p;
end //
delimiter ;
select name, is_public(hospitalid) as public_status from hospitals;

-- 32. UDF to categorize capacity
delimiter //
create function capacity_category(hid int)
returns varchar(20)
deterministic
begin
  declare c int;
  select capacity into c from hospitals where hospitalid=hid;
  if c < 500 then return 'Small';
  elseif c between 500 and 1500 then return 'Medium';
  else return 'Large';
  end if;
end //
delimiter ;
select name, capacity_category(hospitalid) from hospitals;

-- 33. UDF to return hospital age
delimiter //
create function hospital_age(hid int)
returns int
deterministic
begin
  declare y int;
  select year(established_date) into y from hospitals where hospitalid=hid;
  return year(curdate()) - y;
end //
delimiter ;
select name, hospital_age(hospitalid) as age_in_years from hospitals;

-- 34. UDF to return accreditation
delimiter //
create function accred_body(hid int)
returns varchar(100)
deterministic
begin
  declare a varchar(100);
  select accreditation into a from hospitals where hospitalid=hid;
  return a;
end //
delimiter ;
select name, accred_body(hospitalid) from hospitals;

-- 35. UDF to return formatted contact number
delimiter //
create function format_contact(hid int)
returns varchar(100)
deterministic
begin
  declare c varchar(50);
  select contact into c from hospitals where hospitalid=hid;
  return concat('Contact: ',c);
end //
delimiter ;
select format_contact(hospitalid) from hospitals;

-- 36. UDF to check if established before 1900
delimiter //
create function pre_1900(hid int)
returns varchar(5)
deterministic
begin
  declare y int;
  select year(established_date) into y from hospitals where hospitalid=hid;
  if y < 1900 then return 'Yes';
  else return 'No';
  end if;
end //
delimiter ;
select name, pre_1900(hospitalid) as old_hospital from hospitals;

-- 37. UDF to return city name
delimiter //
create function city_name(hid int)
returns varchar(100)
deterministic
begin
  declare c varchar(100);
  select city into c from hospitals where hospitalid=hid;
  return c;
end //
delimiter ;
select city_name(hospitalid) from hospitals;

-- 38. UDF to return full hospital info
delimiter //
create function hospital_info(hid int)
returns varchar(200)
deterministic
begin
  declare n varchar(100);
  declare c varchar(100);
  select name, city into n, c from hospitals where hospitalid=hid;
  return concat(n,' located in ',c);
end //
delimiter ;
select hospital_info(hospitalid) from hospitals;

-- 39. UDF to check if accreditation is JCI
delimiter //
create function is_jci(hid int)
returns varchar(5)
deterministic
begin
  declare a varchar(100);
  select accreditation into a from hospitals where hospitalid=hid;
  if a='JCI' then return 'Yes';
  else return 'No';
  end if;
end //
delimiter ;
select name, is_jci(hospitalid) as jci_accredited from hospitals;

-- 40. UDF to return short detail
delimiter //
create function short_detail(hid int)
returns varchar(200)
deterministic
begin
  declare n varchar(100);
  declare y int;
  select name, year(established_date) into n, y from hospitals where hospitalid=hid;
  return concat(n,' founded in ',y);
end //
delimiter ;
select short_detail(hospitalid) from hospitals;

-- 41. List hospitals with their country name
select h.name as hospital, c.name as country
from hospitals h
join countries c on h.country_id = c.countryid;

-- 42. Hospitals with capacity and their country's region
select h.name as hospital, h.capacity, c.region
from hospitals h
join countries c on h.country_id = c.countryid;

-- 43. Hospitals in 'Asia' region
select h.name, h.city, c.region
from hospitals h
join countries c on h.country_id = c.countryid
where c.region = 'Asia';

-- 44. Hospitals with their country population
select h.name as hospital, c.name as country, c.population
from hospitals h
join countries c on h.country_id = c.countryid;

-- 45. Hospitals and their capitals
select h.name as hospital, c.capital as country_capital
from hospitals h
join countries c on h.country_id = c.countryid;

-- 46. Count hospitals per country
select c.name as country, count(h.hospitalid) as hospital_count
from countries c
join hospitals h on h.country_id = c.countryid
group by c.name;

-- 47. Hospitals with income level of their country
select h.name as hospital, c.name as country, c.income_level
from hospitals h
join countries c on h.country_id = c.countryid;

-- 48. Hospitals and languages spoken in their country
select h.name as hospital, c.language
from hospitals h
join countries c on h.country_id = c.countryid;

-- 49. Hospitals with UN member status of their country
select h.name as hospital, c.name as country, c.un_member
from hospitals h
join countries c on h.country_id = c.countryid;

-- 50. List hospitals established before 1900 with their country
select h.name as hospital, h.established_date, c.name as country
from hospitals h
join countries c on h.country_id = c.countryid
where h.established_date < '1900-01-01';

-- Table-7 Doctors-----------------------------------------------------------------------------------------------------------
-- 1. Alias → doctors table as d
select d.doctorid, d.name, d.speciality from doctors d;

-- 2. Alias → hospital name with doctor
select d.name as doctor, h.name as hospital from doctors d join hospitals h on d.hospital_id = h.hospitalid;

-- 3. Alias → years of experience with alias
select d.name as doc, d.years_experience as experience from doctors d;

-- 4. Alias → gender counts
select d.gender as g, count(*) as total from doctors d group by g;

-- 5. Alias → speciality renamed
select d.speciality as dept, d.name as doctor from doctors d;

-- 6. Alias → available doctors with short alias
select d.name as doc, d.available as avail from doctors d;

-- 7. Alias → nationality with alias
select d.nationality as nat, count(*) as total from doctors d group by nat;

-- 8. Alias → phone and email with alias
select d.name as doctor, d.phone as ph, d.email as mail from doctors d;

-- 9. Alias → doctor id and hospital id alias
select d.doctorid as doc_id, d.hospital_id as hosp_id from doctors d;

-- 10. Alias → doctors with hospital alias
select d.name as doctor, h.city as hosp_location from doctors d join hospitals h on d.hospital_id = h.hospitalid;

-- 11. Subquery → doctors with above average experience
select name from doctors
where years_experience > (select avg(years_experience) from doctors);

-- 12. Subquery → doctors in hospitals with more than 1000 beds
select name from doctors
where hospital_id in (select hospitalid from hospitals where capacity > 1000);

-- 13. Subquery → doctors in Indian hospitals
select name from doctors
where hospital_id in (select hospitalid from hospitals where country_id in 
    (select countryid from countries where name = 'India'));

-- 14. Subquery → doctors with speciality matching hospital specialization
select name from doctors
where speciality in (select speciality from hospitals);

-- 15. Subquery → doctors from hospitals established before 1950
select name from doctors
where hospital_id in (select hospitalid from hospitals where established_date > year(1980));

-- 16. Subquery → doctors with longest experience
select name from doctors
where years_experience = (select max(years_experience) from doctors);

-- 17. Subquery → female doctors in hospitals in USA
select name from doctors
where gender = 'Female' and hospital_id in 
    (select hospitalid from hospitals where country_id in 
        (select countryid from countries where name = 'USA'));

-- 18. Subquery → doctors from hospitals with ICU availability
select name from doctors
where hospital_id in (select hospitalid from hospitals where icu_beds > 0);

-- 19. Subquery → doctors not available
select name from doctors
where available = 'No' and hospital_id in 
    (select hospitalid from hospitals where capacity > 500);

-- 20. Subquery → doctors working in capital city hospitals
select name from doctors
where hospital_id in (select hospitalid from hospitals where city like '%Capital%');

-- 21. Function → count doctors
select count(*) as total_doctors from doctors;

-- 22. Function → maximum years of experience
select max(years_experience) as max_exp from doctors;

-- 23. Function → minimum years of experience
select min(years_experience) as min_exp from doctors;

-- 24. Function → average years of experience
select avg(years_experience) as avg_exp from doctors;

-- 25. Function → group by gender with counts
select gender, count(*) as total from doctors group by gender;

-- 26. Function → length of doctor name
select name, length(name) as name_length from doctors;

-- 27. Function → upper-case doctor speciality
select upper(speciality) as speciality_upper from doctors;

-- 28. Function → lower-case nationality
select lower(nationality) as nationality_lower from doctors;

-- 29. Function → substring email domain
select name, substring_index(email, '@', -1) as domain from doctors;

-- 30. Function → difference between max and min experience
select (max(years_experience) - min(years_experience)) as exp_gap from doctors;

-- 31. UDF → classify doctor experience level
create function exp_level(exp int) 
returns varchar(20)
deterministic
return case when exp >= 20 then 'Senior'
            when exp between 10 and 19 then 'Mid-Level'
            else 'Junior' end;

select name, exp_level(years_experience) as level from doctors;

-- 32. UDF → check doctor availability
create function is_available(avail varchar(3)) 
returns varchar(10)
deterministic
return case when avail = 'Yes' then 'Available' else 'Unavailable' end;

select name, is_available(available) as status from doctors;

-- 33. UDF → mask phone number
create function mask_phone(ph varchar(20)) 
returns varchar(20)
deterministic
return concat('XXX-', right(ph,4));

select name, mask_phone(phone) as masked from doctors;

-- 34. UDF → extract email username
create function email_user(mail varchar(100)) 
returns varchar(50)
deterministic
return substring_index(mail, '@', 1);

select name, email_user(email) as username from doctors;

-- 35. UDF → get hospital country
create function doctor_country(hid int) 
returns varchar(100)
deterministic
return (select name from countries where countryid = 
        (select country_id from hospitals where hospitalid = hid));

select name, doctor_country(hospital_id) as country from doctors;

-- 36. UDF → format doctor label
create function doctor_label(dname varchar(100), spec varchar(100)) 
returns varchar(200)
deterministic
return concat(dname, ' (', spec, ')');

select doctor_label(name, speciality) as doc_label from doctors;

-- 37. UDF → experience difference from avg
create function exp_diff(exp int) 
returns int
deterministic
return exp - (select avg(years_experience) from doctors);

select name, exp_diff(years_experience) as diff_from_avg from doctors;

-- 38. UDF → gender title
create function gender_title(g varchar(10)) 
returns varchar(10)
deterministic
return case when g = 'Male' then 'Mr.' else 'Ms.' end;

select gender_title(gender) as title, name from doctors;

-- 39. UDF → hospital name by id
create function get_hospital(hid int) 
returns varchar(100)
deterministic
return (select name from hospitals where hospitalid = hid);

select name, get_hospital(hospital_id) as hospital from doctors;

-- 40. UDF → nationality continent
create function get_continent_by_nat(nat varchar(50)) 
returns varchar(50)
deterministic
return case when nat in ('Indian','Chinese','Pakistani','Bangladeshi','Indonesian') then 'Asia'
            when nat in ('American','Canadian','Mexican') then 'North America'
            when nat in ('Brazilian','Argentinian') then 'South America'
            when nat in ('German','French','Italian','British','Russian') then 'Europe'
            when nat in ('Nigerian','Ethiopian','South African') then 'Africa'
            else 'Other' end;

select name, get_continent_by_nat(nationality) as continent from doctors;

-- 41. Join doctors with hospitals
select d.name as doctor, h.name as hospital
from doctors d join hospitals h on d.hospital_id = h.hospitalid;

-- 42. Doctors with hospital location
select d.name, h.city
from doctors d 
join hospitals h 
on d.hospital_id = h.hospitalid;

-- 43. Doctors with hospital capacity
select d.name, h.capacity
from doctors d 
join hospitals h 
on d.hospital_id = h.hospitalid;

-- 44. Doctors with hospital specialization
select d.name, d.speciality
from doctors d 
join hospitals h 
on d.hospital_id = h.hospitalid;

-- 45. Female doctors with their hospital
select d.name, h.name as hospital
from doctors d 
join hospitals h 
on d.hospital_id = h.hospitalid
where d.gender = 'Female';

-- 46. Doctors with hospital established year
select d.name, h.established_date
from doctors d 
join hospitals h 
on d.hospital_id = h.hospitalid;

-- 47. Doctors in hospitals with capacity beds
select d.name, h.name as hospital, h.capacity
from doctors d 
join hospitals h 
on d.hospital_id = h.hospitalid
where h.capacity > 1500;

-- 48. Doctors in hospitals in Asia
select d.name, h.name as hospital
from doctors d 
join hospitals h 
on d.hospital_id = h.hospitalid
where h.country_id in (select countryid from countries where region like '%Asia%');

-- 49. Doctors grouped by hospital
select h.name as hospital, count(d.doctorid) as total_doctors
from doctors d 
join hospitals h 
on d.hospital_id = h.hospitalid
group by h.name;

-- 50. Doctors with country name
select d.name as doctor, c.name as country
from doctors d
join hospitals h 
on d.hospital_id = h.hospitalid
join countries c 
on h.country_id = c.countryid;

-- Table-8 Health_Workers----------------------------------------------------------------------------------------------------
-- 1. Display worker names with alias for Name
select name as worker_name from health_workers;

-- 2. Show worker roles with alias
select role as worker_role from health_workers;

-- 3. Show email and phone with aliases
select email as worker_email, phone as contact_number from health_workers;

-- 4. Display hospital_id as hospital_code
select hospital_id as hospital_code, name from health_workers;

-- 5. Show worker nationality using alias (from country join)
select hw.name as worker, c.name as country_name from health_workers hw
join countries c on hw.country_id = c.countryid;

-- 6. Display gender alias
select name, gender as worker_gender from health_workers;

-- 7. Show status as employment_status
select name, status as employment_status from health_workers;

-- 8. Show worker id with alias
select workerid as staff_id, name from health_workers;

-- 9. Show years of experience as exp_years
select name, years_experience as exp_years from health_workers;

-- 10. Combine hospital and worker alias
select hw.name as worker_name, h.name as hospital_name
from health_workers hw
join hospitals h on hw.hospital_id = h.hospitalid;

-- 11. Workers with experience more than avg experience
select name from health_workers
where years_experience > (select avg(years_experience) from health_workers);

-- 12. Workers belonging to hospitals in country 'India'
select name from health_workers where country_id in (select countryid from countries where name = 'India');

-- 13. Workers with same role as 'Rajesh Patil'
select name from health_workers where role = (select role from health_workers where name = 'Rajesh Patil');

-- 14. Workers working in hospitals that have 'AIIMS'
select name from health_workers where hospital_id in (select hospitalid from hospitals where name like '%AIIMS%');

-- 15. Worker(s) with max years_experience
select name from health_workers where years_experience = (select max(years_experience) from health_workers);

-- 16. Worker(s) with min years_experience
select name from health_workers where years_experience = (select min(years_experience) from health_workers);

-- 17. Active workers only
select name from health_workers where status = (select status from health_workers where workerid = 1);

-- 18. Workers in same country as 'Linda White'
select name from health_workers where country_id = (select country_id from health_workers where name = 'Linda White');

-- 19. Get workers whose hospital has doctors
select name from health_workers where hospital_id in (select hospital_id from doctors);

-- 20. Workers with role same as any inactive worker
select name from health_workers where role in (select role from health_workers where status = 'Not-Active');

-- 21. Count total workers
select count(*) as total_workers from health_workers;

-- 22. Average experience
select avg(years_experience) as avg_experience from health_workers;

-- 23. Maximum experience
select max(years_experience) as max_experience from health_workers;

-- 24. Minimum experience
select min(years_experience) as min_experience from health_workers;

-- 25. Group by role count
select role, count(*) as role_count from health_workers group by role;

-- 26. UPPER function on worker names
select upper(name) as worker_name_upper from health_workers;

-- 27. LOWER function on emails
select lower(email) as worker_email_lower from health_workers;

-- 28. LENGTH of phone numbers
select name, length(phone) as phone_length from health_workers;

-- 29. SUBSTRING email domain
select name, substring(email from position('@' in email)+1) as email_domain
from health_workers;

-- 30. Current date display with worker
select name, current_date as today from health_workers;

-- 31. Function: get_worker_experience
create function get_worker_experience(wid int)
returns int
deterministic
return (select years_experience from health_workers where workerid = wid);

select get_worker_experience(1);

-- 32. Function: get_worker_role
create function get_worker_role(wid int)
returns varchar(50)
deterministic
return (select role from health_workers where workerid = wid);

select get_worker_role(2);

-- 33. Function: get_worker_status
create function get_worker_status(wid int)
returns varchar(30)
deterministic
return (select status from health_workers where workerid = wid);

select get_worker_status(3);

-- 34. Function: get_worker_email
create function get_worker_email(wid int)
returns varchar(100)
deterministic
return (select email from health_workers where workerid = wid);

select get_worker_email(4);

-- 35. Function: get_worker_phone
create function get_worker_phone(wid int)
returns varchar(20)
deterministic
return (select phone from health_workers where workerid = wid);

select get_worker_phone(5);

-- 36. Function: get_worker_country
create function get_worker_country(wid int)
returns varchar(100)
deterministic
return (select c.name from health_workers hw join countries c on hw.country_id=c.countryid where hw.workerid=wid);

select get_worker_country(6);

-- 37. Function: get_worker_hospital
create function get_worker_hospital(wid int)
returns varchar(100)
deterministic
return (select h.name from health_workers hw join hospitals h on hw.hospital_id=h.hospitalid where hw.workerid=wid);

select get_worker_hospital(7);

-- 38. Function: get_worker_gender
create function get_worker_gender(wid int)
returns varchar(10)
deterministic
return (select gender from health_workers where workerid=wid);

select get_worker_gender(8);

-- 39. Function: get_worker_name
create function get_worker_name(wid int)
returns varchar(100)
deterministic
return (select name from health_workers where workerid=wid);

select get_worker_name(9);

-- 40. Function: get_worker_info
create function get_worker_info(wid int)
returns varchar(255)
deterministic
return (select concat(name, ' - ', role, ' - ', status) from health_workers where workerid=wid);

select get_worker_info(10);

-- 41. Join workers with hospitals
select hw.name as worker, h.name as hospital
from health_workers hw
join hospitals h 
on hw.hospital_id=h.hospitalid;

-- 42. Join workers with countries
select hw.name, c.name as country
from health_workers hw
join countries c 
on hw.country_id=c.countryid;

-- 43. Join workers with hospitals and countries
select hw.name, h.name as hospital, c.name as country
from health_workers hw
join hospitals h 
on hw.hospital_id=h.hospitalid
join countries c 
on hw.country_id=c.countryid;

-- 44. Workers with hospital 'AIIMS'
select hw.name, h.name as hospital
from health_workers hw
join hospitals h 
on hw.hospital_id=h.hospitalid
where h.name like '%AIIMS%';

-- 45. Workers grouped by country
select c.name as country, count(hw.workerid) as total_workers
from health_workers hw
join countries c 
on hw.country_id=c.countryid
group by c.name;

-- 46. Active workers per hospital
select h.name as hospital, count(hw.workerid) as active_workers
from health_workers hw
join hospitals h 
on hw.hospital_id=h.hospitalid
where hw.status='Active'
group by h.name;

-- 47. Workers with doctor hospital link
select distinct hw.name as worker, d.name as doctor, h.name as hospital
from health_workers hw
join hospitals h 
on hw.hospital_id=h.hospitalid
join doctors d 
on d.hospital_id=h.hospitalid;

-- 48. Workers in same hospital as 'Dr. Michael Ross'
select hw.name
from health_workers hw
where hospital_id = (select hospital_id from doctors where name='Dr. Michael Ross');

-- 49. Workers in hospitals with more than 2 doctors
select hw.name
from health_workers hw
where hospital_id in (select hospital_id from doctors group by hospital_id having count(*)>2);

-- 50. Worker details with hospital & country info
select hw.workerid, hw.name as worker, hw.role, h.name as hospital, c.name as country
from health_workers hw
join hospitals h 
on hw.hospital_id=h.hospitalid
join countries c 
on hw.country_id=c.countryid;

-- Table-9 Outbreaks---------------------------------------------------------------------------------------------------------
-- 1. Outbreak id and severity
select outbreakid as outbreak_code, severity as outbreak_severity from outbreaks;

-- 2. Renaming start and end dates
select start_date as beginning, end_date as closure from outbreaks;

-- 3. Alias for region and source
select region as outbreak_region, source as infection_source from outbreaks;

-- 4. Alias multiple columns
select outbreakid as id, disease_id as disease, country_id as nation from outbreaks;

-- 5. Alias for boolean-like controlled column
select controlled as is_controlled, notes as remarks from outbreaks;

-- 6. Alias with calculation (duration in days)
select outbreakid as id, (end_date - start_date) as duration_days from outbreaks;

-- 7. Alias with upper() function
select upper(severity) as severity_upper from outbreaks;

-- 8. Alias to display only outbreak summary
select outbreakid as code, region as area, severity as level from outbreaks;

-- 9. Alias for concatenating columns
select outbreakid || ' - ' || severity as outbreak_summary from outbreaks;

-- 10. Alias with conditional (case)
select outbreakid, case when controlled = 'Yes' then 'Handled' else 'Ongoing' end as status_report from outbreaks;

-- 11. Outbreaks with highest severity
select * from outbreaks where severity = (select max(severity) from outbreaks);

-- 12. Outbreaks from countries with high population
select * from outbreaks where country_id in (select countryid from countries where population > 100000000);

-- 13. Outbreaks of diseases first reported before 2000
select * from outbreaks where disease_id in (select diseaseid from diseases where first_reported_year < 2000);

-- 14. Outbreaks with no control
select * from outbreaks where outbreakid in (select outbreakid from outbreaks where controlled = 'No');

-- 15. Earliest outbreak per country
select * from outbreaks where start_date in (select min(start_date) from outbreaks group by country_id);

-- 16. Countries having more than 1 outbreak
select * from outbreaks where country_id in (select country_id from outbreaks group by country_id having count(*) > 1);

-- 17. Longest outbreak
select * from outbreaks where (end_date - start_date) = (select max(end_date - start_date) from outbreaks);

-- 18. Outbreaks of diseases with vaccine available
select * from outbreaks where disease_id in (select diseaseid from diseases where vaccine_available = 'Yes');

-- 19. Outbreaks in asian region countries
select * from outbreaks where country_id in (select countryid from countries where region = 'Asia');

-- 20. Outbreaks in countries that are UN members
select * from outbreaks where country_id in (select countryid from countries where un_member = 'Yes');

-- 21. Total outbreaks
select count(*) as total_outbreaks from outbreaks;

-- 22. Earliest start date
select min(start_date) as first_outbreak from outbreaks;

-- 23. Latest end date
select max(end_date) as last_outbreak from outbreaks;

-- 24. Average duration
select avg(end_date - start_date) as avg_duration from outbreaks;

-- 25. Length of notes
select length(notes) as note_length from outbreaks;

-- 26. Upper() severity
select upper(severity) from outbreaks;

-- 27. Lower() region
select lower(region) from outbreaks;

-- 28. Substring of source
select substr(source, 1, 15) as short_source from outbreaks;

-- 29. Coalesce (notes or ‘No Notes’)
select coalesce(notes, 'No Notes') as safe_notes from outbreaks;

-- 30. Distinct severity
select distinct severity from outbreaks;

-- 31. return disease severity category in words
delimiter //
create function get_severity_category(severity_level varchar(50))
returns varchar(50)
deterministic
begin
    declare result varchar(50);
    if severity_level = 'High' then
        set result = 'Severe Disease';
    elseif severity_level = 'Medium' then
        set result = 'Moderate Disease';
    else
        set result = 'Mild Disease';
    end if;
    return result;
end //
delimiter ;
select name, get_severity_category(severity_level) from diseases;

-- 32. return year difference since first reported
delimiter //
create function years_since_reported(first_year int)
returns int
deterministic
begin
    return year(curdate()) - first_year;
end //
delimiter ;
select name, years_since_reported(first_reported_year) as years_known from diseases;

-- 33. check if vaccine available (Yes/No)
delimiter //
create function is_vaccine_available(vaccine varchar(200))
returns varchar(200)
deterministic
begin
    if lower(vaccine) = 'yes' then
        return 'Available';
    else
        return 'Not Available';
    end if;
end //
delimiter ;
select name, is_vaccine_available(vaccine_available) from diseases;

-- 34. return short disease code (concat Name and ICDCode)
delimiter //
create function disease_code(name varchar(100), icd varchar(20))
returns varchar(150)
deterministic
begin
    return concat(left(name,3), '-', icd);
end //
delimiter ;
select disease_code(name, icdcode) as short_code from diseases;

select * from outbreaks;
-- 35. return disease risk score (based on severity)
delimiter //
create function risk_score(severity varchar(50))
returns int
deterministic
begin
    declare score int;
    set score = case 
        when severity='High' then 100
        when severity='Medium' then 70
        else 40 
        end;
    return score;
end //
delimiter ;
select name, risk_score(severity_level) as risk_score from diseases;

-- 36. return disease origin message
delimiter //
create function disease_origin(origin_country varchar(100))
returns varchar(200)
deterministic
begin
    return concat('Disease originated from ', origin_country);
end //
delimiter ;
select disease_origin(origin_country) from diseases;

-- 37. return transmission description
delimiter //
create function transmission_desc(mode varchar(100))
returns varchar(200)
deterministic
begin
    return concat('Transmission occurs via ', mode);
end //
delimiter ;
select transmission_desc(transmission_mode) from diseases;

-- 38. return formatted disease name (uppercase with ICDCode)
delimiter //
create function formatted_disease(name varchar(100), icd varchar(20))
returns varchar(150)
deterministic
begin
    return upper(concat(name, ' [', icd, ']'));
end //
delimiter ;
select formatted_disease(name, icdcode) from diseases;

-- 39. check if disease is modern or historic (based on first_year)
delimiter //
create function disease_era(first_year date)
returns varchar(20)
deterministic
begin
    if first_year >= '2000-01-01' then
        return 'Modern';
    else
        return 'Historic';
    end if;
end //
delimiter ;
select name, disease_era(first_reported_year) from diseases;

-- 40. calculate severity weight (numeric for analytics)
delimiter //
create function severity_weight(severity varchar(50))
returns int
deterministic
begin
    case 
        when severity='High' then return 3;
        when severity='Medium' then return 2;
        else return 1;
    end case;
end //
delimiter ;
select name, severity_weight(severity_level) from diseases;

-- 41. Outbreak with disease name
select o.outbreakid, d.name as disease_name, o.severity 
from outbreaks o join diseases d on o.disease_id = d.diseaseid;

-- 42. Outbreak with country name
select o.outbreakid, c.name as country_name, o.region 
from outbreaks o join countries c on o.country_id = c.countryid;

-- 43. Outbreak with disease and country
select o.outbreakid, d.name as disease, c.name as country, o.severity 
from outbreaks o 
join diseases d on o.disease_id = d.diseaseid
join countries c on o.country_id = c.countryid;

-- 44. Critical outbreaks with country info
select o.outbreakid, c.name, o.severity 
from outbreaks o join countries c on o.country_id = c.countryid
where o.severity = 'Critical';

-- 45. Outbreaks and disease transmission mode
select o.outbreakid, d.transmission_mode 
from outbreaks o join diseases d on o.disease_id = d.diseaseid;

-- 46. Outbreaks with region and income level
select o.outbreakid, o.region, c.income_level 
from outbreaks o join countries c on o.country_id = c.countryid;

-- 47. Uncontrolled outbreaks with country + disease
select o.outbreakid, d.name as disease, c.name as country, o.controlled 
from outbreaks o 
join diseases d on o.disease_id = d.diseaseid
join countries c on o.country_id = c.countryid
where o.controlled = 'No';

-- 48. Outbreaks with disease severity and vaccine availability
select o.outbreakid, d.name, d.vaccine_available, o.severity 
from outbreaks o join diseases d on o.disease_id = d.diseaseid;

-- 49. Outbreaks grouped by region with country names
select o.region, c.name as country 
from outbreaks o join countries c on o.country_id = c.countryid;

-- 50. Outbreaks with disease ICD code and severity
select o.outbreakid, d.icdcode, o.severity 
from outbreaks o join diseases d on o.disease_id = d.diseaseid;

-- Table-10 Emergency_Responses----------------------------------------------------------------------------------------------
-- 1. alias for cost
select e.responseid as resp_id, e.cost as total_cost from emergency_responses e;

-- 2. alias for teams deployed and coordinator
select e.teams_deployed as teams, e.coordinator as leader from emergency_responses e;

-- 3. alias for outbreak id
select e.outbreak_id as outbreak_ref, e.status as resp_status from emergency_responses e;

-- 4. alias for response duration
select e.responseid, datediff(e.end_date, e.start_date) as duration_days from emergency_responses e;

-- 5. alias for supplies
select e.supplies_sent as supplies, e.partner_orgs as partners from emergency_responses e;

-- 6. alias for high-cost responses
select e.responseid as id, e.cost as expenditure from emergency_responses e where e.cost > 1000000;

-- 7. alias for response leader
select e.coordinator as lead_name, e.status as completion_status from emergency_responses e;

-- 8. alias for partner organizations
select e.partner_orgs as organizations, e.responseid as resp_code from emergency_responses e;

-- 9. alias for combined cost and teams
select e.responseid, (e.cost / e.teams_deployed) as cost_per_team from emergency_responses e;

-- 10. alias for start and end date
select e.responseid, e.start_date as start_dt, e.end_date as end_dt from emergency_responses e;

-- 11. responses with above average cost
select * from emergency_responses where cost > (select avg(cost) from emergency_responses);

-- 12. coordinator with max cost response
select coordinator from emergency_responses where cost = (select max(cost) from emergency_responses);

-- 13. responses with min teams deployed
select * from emergency_responses where teams_deployed = (select min(teams_deployed) from emergency_responses);

-- 14. find all responses matching outbreak with critical severity
select * from emergency_responses where outbreak_id in (select outbreakid from outbreaks where severity='Critical');

-- 15. responses before 2010
select * from emergency_responses where responseid in (select responseid from emergency_responses where year(start_date) < 2010);

-- 16. costlier than responseid=5
select * from emergency_responses where cost > (select cost from emergency_responses where responseid=5);

-- 17. coordinators with more than one response
select coordinator from emergency_responses
where coordinator in (select coordinator from emergency_responses group by coordinator having count(*) > 1);

-- 18. responses using same partners as responseid=1
select * from emergency_responses where partner_orgs = (select partner_orgs from emergency_responses where responseid=1);

-- 19. responses shorter than average duration
select * from emergency_responses
where datediff(end_date,start_date) < (select avg(datediff(end_date,start_date)) from emergency_responses);

-- 20. max cost response per outbreak
select * from emergency_responses er where cost = (select max(cost) from emergency_responses where outbreak_id=er.outbreak_id);

-- 21. response duration in days
select responseid, datediff(end_date,start_date) as days_duration from emergency_responses;

-- 22. extract year from start date
select responseid, year(start_date) as start_year from emergency_responses;

-- 23. upper case coordinator names
select upper(coordinator) as coordinator_name from emergency_responses;

-- 24. lower case partner orgs
select lower(partner_orgs) as orgs from emergency_responses;

-- 25. length of supplies text
select responseid, length(supplies_sent) as supply_length from emergency_responses;

-- 26. round cost to nearest million
select responseid, round(cost/1000000,2) as cost_million from emergency_responses;

-- 27. substring of coordinator names
select responseid, substring(coordinator,1,5) as coord_short from emergency_responses;

-- 28. replace commas in supplies with '|'
select replace(supplies_sent, ',', '|') as formatted_supplies from emergency_responses;

-- 29. concat coordinator and status
select concat(coordinator,' - ',status) as coord_status from emergency_responses;

-- 30. average teams deployed
select avg(teams_deployed) as avg_teams from emergency_responses;

-- 31. calculate duration of response in days
create function response_duration(start_date date, end_date date)
returns int 
deterministic
return datediff(end_date, start_date);
select responseid, response_duration(start_date, end_date) as duration_days from emergency_responses;

-- 32. check if response is ongoing
create function is_ongoing(status varchar(30))
returns varchar(5) 
deterministic
return if(status='Ongoing','Yes','No');
select responseid, is_ongoing(status) as ongoing from emergency_responses;

-- 33. cost per team deployed
create function cost_per_team(cost double, teams int)
returns double 
deterministic
return if(teams=0,null, cost/teams);
select responseid, cost_per_team(cost, teams_deployed) as per_team_cost from emergency_responses;

-- 34. short coordinator code (first 4 chars uppercase)
create function coord_code(name varchar(100))
returns varchar(10) 
deterministic
return upper(left(name,4));
select coordinator, coord_code(coordinator) as code from emergency_responses;

-- 35. label response as low or high cost
create function cost_label(cost double)
returns varchar(20) 
deterministic
return case 
  when cost < 50000 then 'Low'
  when cost between 50000 and 200000 then 'Medium'
  else 'High'
end;
select responseid, cost_label(cost) as cost_category from emergency_responses;

-- 36. count number of partner organizations
create function partner_count(orgs text)
returns int 
deterministic
return length(orgs) - length(replace(orgs, ',', '')) + 1;
select responseid, partner_count(partner_orgs) as total_partners from emergency_responses;

-- 37. detect if supplies include vaccines
create function have_vaccine(supplies text)
returns varchar(5) 
deterministic
return if(supplies like '%vaccine%', 'Yes','No');
select responseid, have_vaccine(supplies_sent) as vaccine_included from emergency_responses;

-- 38. check if response lasted more than 30 days
create function long_response(start_date date, end_date date)
returns varchar(5) 
deterministic
return if(datediff(end_date, start_date) > 30, 'Yes','No');
select responseid, long_response(start_date,end_date) as over_30_days from emergency_responses;

-- 39. generate unique response tag
create function response_tag(id int, status varchar(30))
returns varchar(50) 
deterministic
return concat('RESP-',id,'-',upper(left(status,3)));
select responseid, response_tag(responseid,status) as tag from emergency_responses;

-- 40. categorize deployment size
create function team_scale(teams int)
returns varchar(20) 
deterministic
return case
  when teams = 0 then 'None'
  when teams between 1 and 5 then 'Small'
  when teams between 6 and 20 then 'Medium'
  else 'Large'
end;
select responseid, team_scale(teams_deployed) as team_category from emergency_responses;

-- 41. Join with outbreaks to get disease severity
select e.responseid, o.severity from emergency_responses e
join outbreaks o on e.outbreak_id=o.outbreakid;

-- 42. Response cost and outbreak region
select e.responseid, e.cost, o.region from emergency_responses e
join outbreaks o on e.outbreak_id=o.outbreakid;

-- 43. Coordinator and disease id
select e.coordinator, o.disease_id from emergency_responses e
join outbreaks o on e.outbreak_id=o.outbreakid;

-- 44. Duration of response with outbreak start date
select e.responseid, datediff(e.end_date,e.start_date) as resp_days, o.start_date as outbreak_start
from emergency_responses e join outbreaks o on e.outbreak_id=o.outbreakid;

-- 45. Responses for outbreaks of type 'Critical'
select e.* from emergency_responses e
join outbreaks o on e.outbreak_id=o.outbreakid
where o.severity='Critical';

-- 46. Responses with outbreak country_id
select e.responseid, o.country_id from emergency_responses e
join outbreaks o on e.outbreak_id=o.outbreakid;

-- 47. Completed responses with outbreak notes
select e.responseid, o.notes from emergency_responses e
join outbreaks o on e.outbreak_id=o.outbreakid
where e.status='Completed';

-- 48. Total cost per country
select o.country_id, sum(e.cost) as total_cost from emergency_responses e
join outbreaks o on e.outbreak_id=o.outbreakid
group by o.country_id;

-- 49. Average teams per outbreak severity
select o.severity, avg(e.teams_deployed) as avg_teams from emergency_responses e
join outbreaks o on e.outbreak_id=o.outbreakid
group by o.severity;

-- 50. Response coordinator and outbreak disease_id
select e.coordinator, o.disease_id from emergency_responses e
join outbreaks o on e.outbreak_id=o.outbreakid;