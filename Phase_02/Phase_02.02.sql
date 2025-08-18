use who;

-- Table-11 Programs---------------------------------------------------------------------------------------------------------
-- 1. Programs that are Global
select * from Programs where Global = 'Yes';

-- 2. Programs with Budget greater than 10 million
select * from Programs where Budget > 10000000;

-- 3. Programs focused on 'Immunization'
select * from Programs where Focus_Area = 'Immunization';

-- 4. Count of programs grouped by Status
select Status, count(*) as Program_Count from Programs group by Status;

-- 5. Programs that started after 2015
select * from Programs where Start_Year > '2015-01-01';

-- 6. List distinct Focus Areas
select distinct Focus_Area from Programs;

-- 7. Programs with ‘Active’ or ‘Ongoing’ status
select * from Programs where Status in ('Active','Ongoing');

-- 8. Programs ordered by Budget descending
select * from Programs order by Budget desc;

-- 9. Update Budget for ProgramID = 2
update Programs set Budget = 20000000 where ProgramID = 2;

-- 10. Delete Program with ProgramID = 20
delete from Programs where ProgramID = 20;

-- 11. Add new column 'Duration_Years'
alter table Programs add Duration_Years int;

-- 12. Rename column Manager to Program_Manager
alter table Programs rename column Manager to Program_Manager;

-- 13. Programs whose objective mentions 'vaccine'
select * from Programs where Objective like '%vaccine%';

-- 14. Show programs with Budget between 5M and 15M
select * from Programs where Budget between 5000000 and 15000000;

-- 15. CASE: Label programs by Budget size
select Name, 
       case 
           when Budget > 20000000 then 'Large'
           when Budget between 10000000 and 20000000 then 'Medium'
           else 'Small'
       end as Budget_Category
from Programs;

-- 16. Programs not Global
select * from Programs where Global = 'No';

-- 17. Minimum and Maximum Budget
select min(Budget) as Min_Budget, max(Budget) as Max_Budget from Programs;

-- 18. Average budget per Status
select Status, avg(Budget) as Avg_Budget from Programs group by Status;

-- 19. Top 5 highest budget programs
select * from Programs order by Budget desc limit 5;

-- 20. Programs with Start_Year before 2010
select * from Programs where Start_Year < '2010-01-01';

-- 21. Insert new program
insert into Programs (ProgramID, Name, Focus_Area, Start_Year, Global, Objective, Status, Budget, Partner_Orgs, Program_Manager)
values (21, 'Test Health Project', 'General Health', '2022-01-01', 'No', 'Pilot health program.', 'Planning', 2000000, 'WHO', 'Dr. Test Manager');

-- 22. Drop column Duration_Years
alter table Programs drop column Duration_Years;

-- 23. Change column Budget data type
alter table programs modify column budget bigint;

-- 24. Programs whose Manager name starts with 'Dr. M'
select * from Programs where Program_Manager like 'Dr. M%';

-- 25. Programs where Partner_Orgs include 'WHO'
select * from Programs where Partner_Orgs like '%WHO%';

-- 26. Programs with NULL values in Objective
select * from Programs where Objective is null;

-- 27. Programs grouped by Global field
select Global, count(*) as Total from Programs group by Global;

-- 28. Programs that started in 2019 or later
select * from Programs where extract(year from Start_Year) >= 2019;

-- 29. Program with the lowest budget
select * from Programs order by Budget asc limit 1;

-- 30. Update Status to 'Completed' for ProgramID = 3
update Programs set Status = 'Completed' where ProgramID = 3;

-- 31. Delete programs with Budget < 3M
delete from Programs where Budget < 3000000;

-- 32. Programs that are Active and Global
select * from Programs where Status = 'Active' and Global = 'Yes';

-- 33. Programs sorted by Start Year
select * from Programs order by Start_Year;

-- 34. Display only Name and Budget of all Programs
select Name, Budget from Programs;

-- 35. Programs with word 'Health' in Name
select * from Programs where Name like '%Health%';

-- 36. Programs with Status not equal to 'Completed'
select * from Programs where Status <> 'Completed';

-- 37. Total budget of Global programs
select sum(Budget) as Total_Global_Budget from Programs where Global = 'Yes';

-- 38. Count programs per Focus Area
select Focus_Area, count(*) as Program_Count from Programs group by Focus_Area;

-- 39. Programs started between 2010 and 2020
select * from Programs where Start_Year between '2010-01-01' and '2020-12-31';

-- 40. Program Manager names in uppercase
select upper(Program_Manager) as Manager_Name from Programs;

-- 41. Programs ordered by Focus_Area then Budget
select * from Programs order by Focus_Area, Budget desc;

-- 42. CASE: Classify Status as 'In Progress' or 'Finished'
select Name, 
       case 
           when Status in ('Active','Ongoing','Planning','Pilot') then 'In Progress'
           else 'Finished'
       end as Status_Group
from Programs;

-- 43. Add constraint: Budget must be > 0
alter table Programs add constraint chk_budget check (Budget > 0);

-- 44. Change Status column length
alter table programs modify column status varchar(50);

-- 45. Find all Programs managed by 'Dr. Aisha Khan'
select * from Programs where Program_Manager = 'Dr. Aisha Khan';

-- 46. Show Programs with Objective length > 50 characters
select * from Programs where length(Objective) > 50;

-- 47. Total Programs launched each year
select extract(year from Start_Year) as Launch_Year, count(*) as Total
from Programs group by extract(year from Start_Year);

-- 48. Programs with Budget exactly 7M
select * from Programs where Budget = 7000000;

-- 49. Programs that are Pilot stage
select * from Programs where Status = 'Pilot';

-- 50. Programs where Manager surname is 'Roberts'
select * from Programs where Program_Manager like '%Roberts';

-- Table-12 Program_Participation--------------------------------------------------------------------------------------------
-- To display full table data
select * from Program_Participation;

-- 1. Programs completed successfully
select * from Program_Participation where Status = 'Completed';

-- 2. Programs still Active
select * from Program_Participation where Status = 'Active';

-- 3. Programs with NULL End_Date
select * from Program_Participation where End_Date is null;

-- 4. Countries with high Impact_Rating (>4.5)
select * from Program_Participation where Impact_Rating > 4.5;

-- 5. Funding received greater than 2 million
select * from Program_Participation where Funding_Received > 2000000;

-- 6. Distinct Status types
select distinct Status from Program_Participation;

-- 7. Count of completed programs
select count(*) from Program_Participation where Status = 'Completed';

-- 8. Average Impact_Rating across all programs
select avg(Impact_Rating) from Program_Participation;

-- 9. Maximum Funding Received
select max(Funding_Received) from Program_Participation;

-- 10. Minimum Funding Received
select min(Funding_Received) from Program_Participation;

-- 11. Programs with Impact_Rating between 4 and 5
select * from Program_Participation where Impact_Rating between 4.0 and 5.0;

-- 12. Programs starting after 2015
select * from Program_Participation where Start_Date > '2015-01-01';

-- 13. Programs ending before 2015
select * from Program_Participation where End_Date < '2015-01-01';

-- 14. Coordinators of ongoing programs
select Coordinator from Program_Participation where Status = 'Ongoing';

-- 15. Funding_Received ordered descending
select * from Program_Participation order by Funding_Received desc;

-- 16. Funding_Received ordered ascending
select * from Program_Participation order by Funding_Received asc;

-- 17. Programs per status
select Status, count(*) from Program_Participation group by Status;

-- 18. Total funding per status
select Status, sum(Funding_Received) from Program_Participation group by Status;

-- 19. Update a coordinator name
update Program_Participation set Coordinator = 'Dr. New Name' where ParticipationID = 8;

-- 20. Delete a suspended program
delete from Program_Participation where Status = 'Suspended';

-- 21. Add a new column
alter table Program_Participation add column Evaluation varchar(50);

-- 22. Rename a column
alter table Program_Participation rename column Comments to Remarks;

-- 23. Drop a column
alter table Program_Participation drop column Evaluation;

-- 24. Programs with comments mentioning 'successful'
select * from Program_Participation where Comments like '%successful%';

-- 25. Programs without any comments
select * from Program_Participation where Comments is null;

-- 26. Case statement to classify funding
select ParticipationID, 
case 
   when Funding_Received > 2000000 then 'High Funding'
   when Funding_Received between 1000000 and 2000000 then 'Medium Funding'
   else 'Low Funding'
end as Funding_Level
from Program_Participation;

-- 27. Programs with rating less than 3
select * from Program_Participation where Impact_Rating < 3;

-- 28. Coordinators handling multiple programs
select Coordinator, count(*) 
from Program_Participation 
group by Coordinator 
having count(*) > 1;

-- 29. Earliest program participation
select * from Program_Participation order by Start_Date asc limit 1;

-- 30. Latest program participation
select * from Program_Participation order by Start_Date desc limit 1;

-- 31. Replace null End_Date with '2099-12-31'
update Program_Participation set End_Date = '2099-12-31' where End_Date is null;

-- 32. Programs lasting more than 5 years
select *, (julianday(End_Date) - julianday(Start_Date))/365 as Duration_Years
from Program_Participation
where End_Date is not null and (julianday(End_Date) - julianday(Start_Date))/365 > 5;

-- 33. Status distribution percentage
select Status, 
round( (count(*) * 100.0) / (select count(*) from Program_Participation), 2) as Percentage
from Program_Participation group by Status;

-- 34. Highest rated program details
select * from Program_Participation where Impact_Rating = (select max(Impact_Rating) from Program_Participation);

-- 35. Lowest rated program details
select * from Program_Participation where Impact_Rating = (select min(Impact_Rating) from Program_Participation);

-- 36. Coordinators whose names start with 'Dr. A'
select * from Program_Participation where Coordinator like 'Dr. A%';

-- 37. Funding per coordinator
select Coordinator, sum(Funding_Received) as Total_Funding
from Program_Participation group by Coordinator;

-- 38. Programs with both start and end in the same year
select * from Program_Participation 
where strftime('%Y', Start_Date) = strftime('%Y', End_Date);

-- 39. Add check constraint on Impact_Rating
alter table Program_Participation add constraint chk_rating check (Impact_Rating between 0 and 5);

-- 40. Programs not completed
select * from Program_Participation where Status <> 'Completed';

-- 41. Programs started before 2010
select * from Program_Participation where Start_Date < '2010-01-01';

-- 42. Programs ending in 2022
select * from Program_Participation where strftime('%Y', End_Date) = '2022';

-- 43. Coordinator with max funding handled
select Coordinator from Program_Participation 
group by Coordinator order by sum(Funding_Received) desc limit 1;

-- 44. Top 3 programs by funding
select * from Program_Participation order by Funding_Received desc limit 3;

-- 45. Add primary key if missing
alter table Program_Participation add primary key (ParticipationID);

-- 46. Programs with funding = 1 million
select * from Program_Participation where Funding_Received = 1000000;

-- 47. Programs where End_Date is before Start_Date (data validation)
select * from Program_Participation where End_Date < Start_Date;

-- 48. Programs with mid-level impact (3.5 to 4.5)
select * from Program_Participation where Impact_Rating between 3.5 and 4.5;

-- 49. Coordinators with programs across multiple statuses
select Coordinator, count(distinct Status) as Status_Count
from Program_Participation
group by Coordinator having count(distinct Status) > 1;

-- 50. Delete programs with funding below 200000
delete from Program_Participation where Funding_Received < 200000;

-- Table-13 Labs-------------------------------------------------------------------------------------------------------------
-- 1. Labs with capacity greater than 400
select * from Labs where Capacity > 400;

-- 2. Labs established before 2000
select * from Labs where Established_Year < 2000;

-- 3. Labs accredited = Yes
select * from Labs where Accredited = 'Yes';

-- 4. Labs located in 'Tokyo'
select * from Labs where City = 'Tokyo';

-- 5. Distinct types of labs
select distinct Type from Labs;

-- 6. Count of Virology labs
select count(*) from Labs where Type = 'Virology';

-- 7. Average lab capacity
select avg(Capacity) from Labs;

-- 8. Maximum lab capacity
select max(Capacity) from Labs;

-- 9. Minimum lab capacity
select min(Capacity) from Labs;

-- 10. Labs with ISO certification containing '15189'
select * from Labs where Iso_Certified like '%15189%';

-- 11. Labs with capacity between 300 and 450
select * from Labs where Capacity between 300 and 450;

-- 12. Labs established after 2010
select * from Labs where Established_Year > 2010;

-- 13. Labs established in or before 1995
select * from Labs where Established_Year <= 1995;

-- 14. Labs in Berlin
select * from Labs where City = 'Berlin';

-- 15. Labs ordered by capacity descending
select * from Labs order by Capacity desc;

-- 16. Labs ordered by capacity ascending
select * from Labs order by Capacity asc;

-- 17. Number of labs by type
select Type, count(*) from Labs group by Type;

-- 18. Average capacity by type
select Type, avg(Capacity) from Labs group by Type;

-- 19. Update a lab's contact
update Labs set Contact = '999888777' where LabID = 5;

-- 20. Delete a lab with capacity less than 250
delete from Labs where Capacity < 250;

-- 21. Add a new column
alter table Labs add column Head varchar(100);

-- 22. Rename a column
alter table Labs rename column Contact to Phone;

-- 23. Drop a column
alter table Labs drop column Head;

-- 24. Labs in cities containing 'City'
select * from Labs where City like '%City%';

-- 25. Labs without ISO certification
select * from Labs where Iso_Certified is null;

-- 26. Case classification by capacity
select LabID, 
case 
   when Capacity > 450 then 'High Capacity'
   when Capacity between 300 and 450 then 'Medium Capacity'
   else 'Low Capacity'
end as Capacity_Level
from Labs;

-- 27. Labs with capacity less than 300
select * from Labs where Capacity < 300;

-- 28. Cities with multiple labs
select City, count(*) from Labs group by City having count(*) > 1;

-- 29. Oldest lab
select * from Labs order by Established_Year asc limit 1;

-- 30. Newest lab
select * from Labs order by Established_Year desc limit 1;

-- 31. Replace null accreditation with 'No'
update Labs set Accredited = 'No' where Accredited is null;

-- 32. Labs older than 25 years
select *, (year(curdate()) - Established_Year) as Age_Years
from Labs
where (year(curdate()) - Established_Year) > 25;

-- 33. Percentage of labs by type
select Type, 
round((count(*) * 100.0) / (select count(*) from Labs), 2) as Percentage
from Labs group by Type;

-- 34. Lab with maximum capacity
select * from Labs where Capacity = (select max(Capacity) from Labs);

-- 35. Lab with minimum capacity
select * from Labs where Capacity = (select min(Capacity) from Labs);

-- 36. Labs with names starting with 'National'
select * from Labs where Name like 'National%';

-- 37. Capacity per city
select City, sum(Capacity) as Total_Capacity from Labs group by City;

-- 38. Labs with same start and end year of establishment (dummy validation)
select * from Labs where Established_Year = Established_Year;

-- 39. Add check constraint on capacity
alter table Labs add constraint chk_capacity check (Capacity >= 0);

-- 40. Labs that are not accredited
select * from Labs where Accredited <> 'Yes';

-- 41. Labs established before 1990
select * from Labs where Established_Year < 1990;

-- 42. Labs established in 2010
select * from Labs where Established_Year = 2010;

-- 43. City with maximum total lab capacity
select City from Labs group by City order by sum(Capacity) desc limit 1;

-- 44. Top 3 labs by capacity
select * from Labs order by Capacity desc limit 3;

-- 45. Add primary key if missing
alter table Labs add primary key (LabID);

-- 46. Labs with capacity exactly 500
select * from Labs where Capacity = 500;

-- 47. Labs with invalid data (capacity < 0)
select * from Labs where Capacity < 0;

-- 48. Labs certified ISO 17025
select * from Labs where Iso_Certified = 'ISO 17025';

-- 49. Labs in multiple countries by Type
select Type, count(distinct Country_ID) as Country_Count 
from Labs group by Type having count(distinct Country_ID) > 1;

-- 50. Delete labs established after 2020
delete from Labs where Established_Year > 2020;

-- Table-14 Lab_Tests--------------------------------------------------------------------------------------------------------
-- 1. Tests conducted using PCR
select * from Lab_Tests where Test_Type = 'PCR';

-- 2. Tests with more than 700 samples
select * from Lab_Tests where Samples_Tested > 700;

-- 3. Tests with positivity rate above 20%
select *, (Positives * 100.0 / Samples_Tested) as Positivity_Rate
from Lab_Tests
where (Positives * 100.0 / Samples_Tested) > 20;

-- 4. Tests conducted after July 2023
select * from Lab_Tests where Test_Date > '2023-07-01';

-- 5. Distinct test types
select distinct Test_Type from Lab_Tests;

-- 6. Count of ELISA-based tests
select count(*) from Lab_Tests where Method like '%ELISA%';

-- 7. Average samples tested
select avg(Samples_Tested) from Lab_Tests;

-- 8. Maximum positives detected
select max(Positives) from Lab_Tests;

-- 9. Minimum negatives recorded
select min(Negatives) from Lab_Tests;

-- 10. Tests with notes mentioning 'outbreak'
select * from Lab_Tests where Notes like '%outbreak%';

-- 11. Tests with between 400 and 600 samples
select * from Lab_Tests where Samples_Tested between 400 and 600;

-- 12. Tests conducted in 2024
select * from Lab_Tests where strftime('%Y', Test_Date) = '2024';

-- 13. Tests conducted before 2023
select * from Lab_Tests where Test_Date < '2023-01-01';

-- 14. Tests detecting fewer than 50 positives
select * from Lab_Tests where Positives < 50;

-- 15. Tests ordered by samples descending
select * from Lab_Tests order by Samples_Tested desc;

-- 16. Tests ordered by positives ascending
select * from Lab_Tests order by Positives asc;

-- 17. Number of tests by type
select Test_Type, count(*) from Lab_Tests group by Test_Type;

-- 18. Average positivity rate per test type
select Test_Type, avg(Positives * 1.0 / Samples_Tested) as Avg_Positivity
from Lab_Tests group by Test_Type;

-- 19. Update a note for TestID 5
update Lab_Tests set Notes = 'Updated note: HIV retesting batch' where TestID = 5;

-- 20. Delete a test with less than 300 samples
delete from Lab_Tests where Samples_Tested < 300;

-- 21. Add a new column
alter table Lab_Tests add column Technician varchar(100);

-- 22. Rename a column
alter table Lab_Tests rename column Notes to Remarks;

-- 23. Drop a column
alter table Lab_Tests drop column Technician;

-- 24. Tests performed with method containing 'Microscopy'
select * from Lab_Tests where Method like '%Microscopy%';

-- 25. Tests with no notes recorded
select * from Lab_Tests where Notes is null;

-- 26. Case classification by sample volume
select TestID, 
case 
   when Samples_Tested > 800 then 'Large Batch'
   when Samples_Tested between 500 and 800 then 'Medium Batch'
   else 'Small Batch'
end as Batch_Size
from Lab_Tests;

-- 27. Tests with positivity below 10%
select * from Lab_Tests where (Positives * 100.0 / Samples_Tested) < 10;

-- 28. Labs conducting multiple test types
select Lab_ID, count(distinct Test_Type) as TestType_Count
from Lab_Tests group by Lab_ID having count(distinct Test_Type) > 1;

-- 29. Earliest test conducted
select * from Lab_Tests order by Test_Date asc limit 1;

-- 30. Most recent test conducted
select * from Lab_Tests order by Test_Date desc limit 1;

-- 31. Replace null negatives with 0
update Lab_Tests set Negatives = 0 where Negatives is null;

-- 32. Tests with error in data (Positives + Negatives <> Samples_Tested)
select * from Lab_Tests where (Positives + Negatives) <> Samples_Tested;

-- 33. Percentage of tests by method
select Method, 
round((count(*) * 100.0) / (select count(*) from Lab_Tests), 2) as Percentage
from Lab_Tests group by Method;

-- 34. Test with maximum samples tested
select * from Lab_Tests where Samples_Tested = (select max(Samples_Tested) from Lab_Tests);

-- 35. Test with minimum samples tested
select * from Lab_Tests where Samples_Tested = (select min(Samples_Tested) from Lab_Tests);

-- 36. Tests conducted using RT-PCR
select * from Lab_Tests where Test_Type = 'RT-PCR';

-- 37. Total positives per disease
select Disease_ID, sum(Positives) as Total_Positives
from Lab_Tests group by Disease_ID;

-- 38. Total samples tested per lab
select Lab_ID, sum(Samples_Tested) as Total_Samples
from Lab_Tests group by Lab_ID;

-- 39. Add check constraint on positivity not exceeding samples
alter table Lab_Tests add constraint chk_valid_counts check (Positives + Negatives <= Samples_Tested);

-- 40. Tests without positives (all negative)
select * from Lab_Tests where Positives = 0;

-- 41. Tests with exactly 100 positives
select * from Lab_Tests where Positives = 100;

-- 42. Tests conducted in May
select * from Lab_Tests where strftime('%m', Test_Date) = '05';

-- 43. Lab with maximum total positives
select Lab_ID from Lab_Tests group by Lab_ID order by sum(Positives) desc limit 1;

-- 44. Top 3 tests by positivity count
select * from Lab_Tests order by Positives desc limit 3;

-- 45. Add primary key if missing
alter table Lab_Tests add primary key (TestID);

-- 46. Tests where negatives are greater than 700
select * from Lab_Tests where Negatives > 700;

-- 47. Tests with samples less than positives (data error)
select * from Lab_Tests where Samples_Tested < Positives;

-- 48. Average samples tested per method
select Method, avg(Samples_Tested) as Avg_Samples
from Lab_Tests group by Method;

-- 49. Diseases tested in multiple labs
select Disease_ID, count(distinct Lab_ID) as Lab_Count
from Lab_Tests group by Disease_ID having count(distinct Lab_ID) > 1;

-- 50. Delete tests conducted before 2023
delete from Lab_Tests where Test_Date < '2023-01-01';

-- Table-15 Reports----------------------------------------------------------------------------------------------------------
-- 1. Reports authored in English
select * from Reports where Language = 'English';

-- 2. Reports published after 2022
select * from Reports where Date_Published > '2022-12-31';

-- 3. Reports not yet reviewed
select * from Reports where Reviewed = 'No';

-- 4. Reports grouped by topic
select Topic, count(*) as Report_Count from Reports group by Topic;

-- 5. Reports authored in Africa region
select * from Reports where Region = 'Africa';

-- 6. Earliest published report
select * from Reports order by Date_Published asc limit 1;

-- 7. Most recent report
select * from Reports order by Date_Published desc limit 1;

-- 8. Count reports by language
select Language, count(*) from Reports group by Language;

-- 9. Count reports per region
select Region, count(*) from Reports group by Region;

-- 10. Reports with title containing 'Vaccine'
select * from Reports where Title like '%Vaccine%';

-- 11. Reports authored by Dr. Maria Torres
select * from Reports where Author = 'Dr. Maria Torres';

-- 12. Reports from the Americas region
select * from Reports where Region = 'Americas';

-- 13. Reports reviewed = Yes
select * from Reports where Reviewed = 'Yes';

-- 14. Reports with topic = Malaria
select * from Reports where Topic = 'Malaria';

-- 15. Total number of reports
select count(*) from Reports;

-- 16. Languages used more than once
select Language, count(*) as Lang_Count 
from Reports group by Language having count(*) > 1;

-- 17. Reports published before 2020
select * from Reports where Date_Published < '2020-01-01';

-- 18. Update review status for report 7
update Reports set Reviewed = 'Yes' where ReportID = 7;

-- 19. Delete a report published before 2018
delete from Reports where Date_Published < '2018-01-01';

-- 20. Add a column Citation
alter table Reports add column Citation varchar(200);

-- 21. Rename column Summary to Abstract
alter table Reports rename column Summary to Abstract;

-- 22. Drop column Citation
alter table Reports drop column Citation;

-- 23. Reports authored by Dr. names starting with 'Dr. H'
select * from Reports where Author like 'Dr. H%';

-- 24. Reports with summary mentioning 'statistics'
select * from Reports where Summary like '%statistics%';

-- 25. Count of reviewed vs not reviewed reports
select Reviewed, count(*) from Reports group by Reviewed;

-- 26. Reports by region ordered by most recent first
select Region, Title, Date_Published 
from Reports order by Region, Date_Published desc;

-- 27. Reports with title length more than 30 chars
select * from Reports where length(Title) > 30;

-- 28. Reports authored in Spanish
select * from Reports where Language = 'Spanish';

-- 29. Reports published in 2023
select * from Reports where strftime('%Y', Date_Published) = '2023';

-- 30. Topics with more than one report
select Topic, count(*) from Reports group by Topic having count(*) > 1;

-- 31. Change language of ReportID 16 to English
update Reports set Language = 'English' where ReportID = 16;

-- 32. Find duplicate authors
select Author, count(*) from Reports group by Author having count(*) > 1;

-- 33. Count of reports per year
select strftime('%Y', Date_Published) as Year, count(*) as Report_Count 
from Reports group by Year;

-- 34. Reports where author name contains 'Chen'
select * from Reports where Author like '%Chen%';

-- 35. Add constraint that Title must not be null
alter table Reports add constraint chk_title_notnull check (Title is not null);

-- 36. Reports with topics starting with 'C'
select * from Reports where Topic like 'C%';

-- 37. Reports in Western Pacific region
select * from Reports where Region = 'Western Pacific';

-- 38. Reports on vaccination topics
select * from Reports where Topic = 'Vaccination';

-- 39. Reports ordered by language alphabetically
select * from Reports order by Language asc;

-- 40. Add a new column Pages
alter table Reports add column Pages int;

-- 41. Reports with title containing 'Health'
select * from Reports where Title like '%Health%';

-- 42. Update region for ReportID 20 to 'Global'
update Reports set Region = 'Global' where ReportID = 20;

-- 43. Delete report on topic 'Smoking'
delete from Reports where Topic = 'Smoking';

-- 44. Reports where author name ends with 'Patel'
select * from Reports where Author like '%Patel';

-- 45. Reports reviewed and published after 2021
select * from Reports where Reviewed = 'Yes' and Date_Published > '2021-12-31';

-- 46. Distinct regions covered
select distinct Region from Reports;

-- 47. Reports per topic sorted by count desc
select Topic, count(*) as Report_Count 
from Reports group by Topic order by Report_Count desc;

-- 48. Reports with missing URL
select * from Reports where URL is null;

-- 49. Find reports with publication month = June
select * from Reports where strftime('%m', Date_Published) = '06';

-- 50. Reports not reviewed but in English
select * from Reports where Reviewed = 'No' and Language = 'English';

-- Table-16 Research_Projects------------------------------------------------------------------------------------------------
-- 1. Projects with status = 'Completed'
select * from Research_Projects where Status = 'Completed';

-- 2. Projects that are ongoing
select * from Research_Projects where Status = 'Ongoing';

-- 3. Projects with budget greater than 5 million
select * from Research_Projects where Budget > 5000000;

-- 4. Projects that started after 2021
select * from Research_Projects where Start_Date > '2021-12-31';

-- 5. Projects that ended before 2021
select * from Research_Projects where End_Date < '2021-01-01';

-- 6. Projects grouped by Status
select Status, count(*) as Project_Count from Research_Projects group by Status;

-- 7. Average budget of all projects
select avg(Budget) as Avg_Budget from Research_Projects;

-- 8. Highest budget project
select * from Research_Projects order by Budget desc limit 1;

-- 9. Lowest budget project
select * from Research_Projects order by Budget asc limit 1;

-- 10. Projects with focus area = 'Virology'
select * from Research_Projects where Area_of_Focus = 'Virology';

-- 11. Count of projects by area of focus
select Area_of_Focus, count(*) from Research_Projects group by Area_of_Focus;

-- 12. Projects sponsored by WHO
select * from Research_Projects where Sponsors_Orgs = 'WHO';

-- 13. Projects by Dr. John Lee
select * from Research_Projects where Lead_Researcher = 'Dr. John Lee';

-- 14. Projects with End_Date after 2024
select * from Research_Projects where End_Date > '2024-01-01';

-- 15. Count of active projects
select count(*) from Research_Projects where Status = 'Active';

-- 16. Projects budget between 3M and 6M
select * from Research_Projects where Budget between 3000000 and 6000000;

-- 17. Projects with Title containing 'COVID'
select * from Research_Projects where Title like '%COVID%';

-- 18. Add column Duration_Months
alter table Research_Projects add column Duration_Months int;

-- 19. Update status of ProjectID = 5 to 'Ongoing'
update Research_Projects set Status = 'Ongoing' where ProjectID = 5;

-- 20. Delete projects with budget < 2.5M
delete from Research_Projects where Budget < 2500000;

-- 21. Change sponsor of ProjectID = 3 to 'WHO'
update Research_Projects set Sponsors_Orgs = 'WHO' where ProjectID = 3;

-- 22. Rename column Sponsors_Orgs to Sponsor
alter table Research_Projects rename column Sponsors_Orgs to Sponsor;

-- 23. Drop column Duration_Months
alter table Research_Projects drop column Duration_Months;

-- 24. Projects in the field of Pediatrics
select * from Research_Projects where Area_of_Focus = 'Pediatrics';

-- 25. Count of projects by sponsor organization
select Sponsor, count(*) from Research_Projects group by Sponsor;

-- 26. Total budget allocated per research area
select Area_of_Focus, sum(Budget) as Total_Budget 
from Research_Projects group by Area_of_Focus;

-- 27. Projects started in 2022
select * from Research_Projects where strftime('%Y', Start_Date) = '2022';

-- 28. Projects ending in 2023
select * from Research_Projects where strftime('%Y', End_Date) = '2023';

-- 29. Number of projects per year started
select strftime('%Y', Start_Date) as Year, count(*) as Project_Count 
from Research_Projects group by Year;

-- 30. List distinct statuses
select distinct Status from Research_Projects;

-- 31. Find researchers with more than one project
select Lead_Researcher, count(*) 
from Research_Projects group by Lead_Researcher having count(*) > 1;

-- 32. Projects where title length > 25 characters
select * from Research_Projects where length(Title) > 25;

-- 33. Projects not yet completed (Ongoing or Active)
select * from Research_Projects where Status in ('Ongoing', 'Active');

-- 34. Update budget of ProjectID = 10 to 10 million
update Research_Projects set Budget = 10000000 where ProjectID = 10;

-- 35. Add constraint budget_check > 0
alter table Research_Projects add constraint chk_budget check (Budget > 0);

-- 36. Projects in Environmental Health
select * from Research_Projects where Area_of_Focus = 'Environmental Health';

-- 37. Average budget by status
select Status, avg(Budget) as Avg_Budget 
from Research_Projects group by Status;

-- 38. Completed projects with budget above 5M
select * from Research_Projects where Status = 'Completed' and Budget > 5000000;

-- 39. Projects sponsored by PAHO
select * from Research_Projects where Sponsor = 'PAHO';

-- 40. Projects where researcher name starts with 'Dr. A'
select * from Research_Projects where Lead_Researcher like 'Dr. A%';

-- 41. Active projects ending after 2024
select * from Research_Projects where Status = 'Active' and End_Date > '2024-01-01';

-- 42. Find all unique research areas
select distinct Area_of_Focus from Research_Projects;

-- 43. Projects by budget descending
select * from Research_Projects order by Budget desc;

-- 44. Total budget allocated to Virology
select sum(Budget) as Total_Virology_Budget 
from Research_Projects where Area_of_Focus = 'Virology';

-- 45. Count of completed projects per country
select Country_ID, count(*) from Research_Projects 
where Status = 'Completed' group by Country_ID;

-- 46. Update End_Date of ProjectID = 2 to '2024-06-30'
update Research_Projects set End_Date = '2024-06-30' where ProjectID = 2;

-- 47. Delete project with ID = 18
delete from Research_Projects where ProjectID = 18;

-- 48. Find projects with sponsor containing 'NIH'
select * from Research_Projects where Sponsor like '%NIH%';

-- 49. Projects where End_Date is NULL (if any future inserted rows)
select * from Research_Projects where End_Date is null;

-- 50. Count total number of projects
select count(*) as Total_Projects from Research_Projects;

-- Table-17 Medicines--------------------------------------------------------------------------------------------------------
-- 1. Find all medicines used for Malaria
select * from Medicines where Used_For like '%Malaria%';

-- 2. Medicines manufactured by 'Pfizer'
select * from Medicines where Manufacturer = 'Pfizer';

-- 3. Medicines approved before year 2000
select * from Medicines where Approval_Date < '2000-01-01';

-- 4. Medicines with expiry more than 4 years
select * from Medicines where Expiry_Years > 4;

-- 5. Count medicines that are WHO approved
select count(*) as WHO_Approved_Medicines from Medicines where WHO_Approved = 'Yes';

-- 6. Medicines that are not available
select * from Medicines where Availability = 'No';

-- 7. Distinct manufacturers
select distinct Manufacturer from Medicines;

-- 8. Total number of medicines by each manufacturer
select Manufacturer, count(*) as Total_Medicines from Medicines group by Manufacturer;

-- 9. Find medicine names containing 'vir'
select * from Medicines where Name like '%vir%';

-- 10. Medicines used for HIV/AIDS
select * from Medicines where Used_For like '%HIV%';

-- 11. Maximum expiry years
select max(Expiry_Years) as Max_Expiry from Medicines;

-- 12. Minimum expiry years
select min(Expiry_Years) as Min_Expiry from Medicines;

-- 13. Average expiry years
select avg(Expiry_Years) as Avg_Expiry from Medicines;

-- 14. Medicines with dosage containing 'daily'
select * from Medicines where Dosage_Info like '%daily%';

-- 15. List medicines approved between 1990 and 2000
select * from Medicines where Approval_Date between '1990-01-01' and '2000-12-31';

-- 16. Medicines where side effects mention 'Nausea'
select * from Medicines where Side_Effects like '%Nausea%';

-- 17. Sort medicines by Approval_Date ascending
select * from Medicines order by Approval_Date asc;

-- 18. Sort medicines by Name descending
select * from Medicines order by Name desc;

-- 19. Find WHO approved and available medicines
select * from Medicines where WHO_Approved = 'Yes' and Availability = 'Yes';

-- 20. Medicines with multiple uses (Used_For contains ',')
select * from Medicines where Used_For like '%,%';

-- 21. Medicines whose manufacturer starts with 'G'
select * from Medicines where Manufacturer like 'G%';

-- 22. Count medicines per Used_For category
select Used_For, count(*) as Count from Medicines group by Used_For;

-- 23. Latest approved medicine
select * from Medicines order by Approval_Date desc limit 1;

-- 24. Oldest approved medicine
select * from Medicines order by Approval_Date asc limit 1;

-- 25. Find medicines manufactured by either 'Pfizer' or 'Bayer'
select * from Medicines where Manufacturer in ('Pfizer', 'Bayer');

-- 26. Medicines not WHO approved
select * from Medicines where WHO_Approved = 'No';

-- 27. Count of medicines grouped by WHO approval
select WHO_Approved, count(*) as Total from Medicines group by WHO_Approved;

-- 28. Count of medicines grouped by Availability
select Availability, count(*) as Total from Medicines group by Availability;

-- 29. Medicines whose expiry years = 3
select * from Medicines where Expiry_Years = 3;

-- 30. Find medicines where Approval_Date is null
select * from Medicines where Approval_Date is null;

-- 31. Case statement for medicine risk based on expiry
select Name, Expiry_Years,
case 
   when Expiry_Years <= 2 then 'Short-term'
   when Expiry_Years between 3 and 4 then 'Medium-term'
   else 'Long-term'
end as Expiry_Category
from Medicines;

-- 32. Case statement to classify medicines by WHO approval
select Name, WHO_Approved,
case 
   when WHO_Approved = 'Yes' then 'Globally Accepted'
   else 'Not Global Standard'
end as WHO_Status
from Medicines;

-- 33. Update expiry years of 'Remdesivir' to 3
update Medicines set Expiry_Years = 3 where Name = 'Remdesivir';

-- 34. Delete medicines not WHO approved
delete from Medicines where WHO_Approved = 'No';

-- 35. Insert a new medicine record
insert into Medicines (MedicineID, Name, Used_For, Manufacturer, Approval_Date, Side_Effects, Dosage_Info, Availability, Expiry_Years, WHO_Approved)
values (21, 'Vitamin C', 'Immunity Boost', 'Sun Pharma', '2005-03-01', 'None', '500mg once daily', 'Yes', 2, 'Yes');

-- 36. Rename table Medicines to Drug_Info
alter table Medicines rename to Drug_Info;

-- 37. Add new column Price to Medicines
alter table Medicines add column Price double;

-- 38. Drop column Price
alter table Medicines drop column Price;

-- 39. Change datatype of Name column
alter table Medicines modify column Name varchar(150);

-- 40. Medicines approved after 2015
select * from Medicines where Approval_Date > '2015-01-01';

-- 41. Medicines approved before 1980
select * from Medicines where Approval_Date < '1980-01-01';

-- 42. Medicines approved in 2020
select * from Medicines where year(Approval_Date) = 2020;

-- 43. Count medicines by decade
select floor(year(Approval_Date)/10)*10 as Decade, count(*) as Total
from Medicines
group by floor(year(Approval_Date)/10)*10;

-- 44. Medicines whose name length > 10
select * from Medicines where length(Name) > 10;

-- 45. Get first 5 medicines alphabetically
select * from Medicines order by Name asc limit 5;

-- 46. Get last 5 medicines by approval date
select * from Medicines order by Approval_Date desc limit 5;

-- 47. Count medicines with side effects mentioning 'Headache'
select count(*) as Headache_Medicines from Medicines where Side_Effects like '%Headache%';

-- 48. Medicines where dosage mentions 'mg'
select * from Medicines where Dosage_Info like '%mg%';

-- 49. Medicines manufactured by Cipla
select * from Medicines where Manufacturer = 'Cipla';

-- 50. List WHO approved medicines grouped by Manufacturer
select Manufacturer, count(*) as Total_WHO_Approved
from Medicines
where WHO_Approved = 'Yes'
group by Manufacturer;

-- Table-18 Health_Indicators------------------------------------------------------------------------------------------------
-- 1. Countries with life expectancy above 80
select * from Health_Indicators where Life_Expectancy > 80;

-- 2. Countries with infant mortality less than 5
select * from Health_Indicators where Infant_Mortality < 5;

-- 3. Countries spending more than 5000 per capita on health
select * from Health_Indicators where Health_Expenditure_Per_capita > 5000;

-- 4. Countries with access to sanitation below 50%
select * from Health_Indicators where Access_To_Sanitation < 50;

-- 5. Countries with doctor-patient ratio above 3
select * from Health_Indicators where Doctor_Patient_Ratio > 3;

-- 6. Country with maximum life expectancy
select * from Health_Indicators order by Life_Expectancy desc limit 1;

-- 7. Country with minimum life expectancy
select * from Health_Indicators order by Life_Expectancy asc limit 1;

-- 8. Country with highest infant mortality
select * from Health_Indicators order by Infant_Mortality desc limit 1;

-- 9. Country with lowest infant mortality
select * from Health_Indicators order by Infant_Mortality asc limit 1;

-- 10. Average life expectancy
select avg(Life_Expectancy) as Avg_Life_Expectancy from Health_Indicators;

-- 11. Average infant mortality
select avg(Infant_Mortality) as Avg_Infant_Mortality from Health_Indicators;

-- 12. Count of countries with WHO standard sanitation (>=95%)
select count(*) from Health_Indicators where Access_To_Sanitation >= 95;

-- 13. Countries with smoking rate above 25
select * from Health_Indicators where Smoking_Rate > 25;

-- 14. Countries with child mortality rate less than 5
select * from Health_Indicators where Child_Mortality_Rate < 5;

-- 15. Countries where health expenditure is between 1000 and 5000
select * from Health_Indicators where Health_Expenditure_Per_capita between 1000 and 5000;

-- 16. Countries with doctor-patient ratio less than 1
select * from Health_Indicators where Doctor_Patient_Ratio < 1;

-- 17. List all indicators for 2022
select * from Health_Indicators where year(Year) = 2022;

-- 18. Sort countries by health expenditure descending
select * from Health_Indicators order by Health_Expenditure_Per_capita desc;

-- 19. Sort countries by infant mortality ascending
select * from Health_Indicators order by Infant_Mortality asc;

-- 20. Find top 5 countries with highest life expectancy
select * from Health_Indicators order by Life_Expectancy desc limit 5;

-- 21. Find bottom 5 countries with lowest life expectancy
select * from Health_Indicators order by Life_Expectancy asc limit 5;

-- 22. Count countries with child mortality above 30
select count(*) from Health_Indicators where Child_Mortality_Rate > 30;

-- 23. Countries with both high life expectancy (>75) and low smoking rate (<10)
select * from Health_Indicators where Life_Expectancy > 75 and Smoking_Rate < 10;

-- 24. Countries with both high infant mortality (>50) and low sanitation (<60)
select * from Health_Indicators where Infant_Mortality > 50 and Access_To_Sanitation < 60;

-- 25. Countries where doctor-patient ratio is between 2 and 4
select * from Health_Indicators where Doctor_Patient_Ratio between 2 and 4;

-- 26. Countries where smoking rate is NULL
select * from Health_Indicators where Smoking_Rate is null;

-- 27. Case statement to classify life expectancy
select IndicatorID, Life_Expectancy,
case 
  when Life_Expectancy < 60 then 'Low'
  when Life_Expectancy between 60 and 75 then 'Medium'
  else 'High'
end as Life_Category
from Health_Indicators;

-- 28. Case statement to classify health expenditure
select IndicatorID, Health_Expenditure_Per_capita,
case
  when Health_Expenditure_Per_capita < 500 then 'Low Spender'
  when Health_Expenditure_Per_capita between 500 and 3000 then 'Moderate Spender'
  else 'High Spender'
end as Spending_Category
from Health_Indicators;

-- 29. Case statement to classify sanitation access
select IndicatorID, Access_To_Sanitation,
case
  when Access_To_Sanitation < 50 then 'Poor'
  when Access_To_Sanitation between 50 and 90 then 'Developing'
  else 'Developed'
end as Sanitation_Level
from Health_Indicators;

-- 30. Update smoking rate for IndicatorID = 1
update Health_Indicators set Smoking_Rate = 12.0 where IndicatorID = 1;

-- 31. Delete record where IndicatorID = 20
delete from Health_Indicators where IndicatorID = 20;

-- 32. Insert new record into Health_Indicators
insert into Health_Indicators 
(IndicatorID, Country_ID, Year, Life_Expectancy, Infant_Mortality, Health_Expenditure_Per_capita, Access_To_Sanitation, Doctor_Patient_Ratio, Child_Mortality_Rate, Smoking_Rate)
values (21, 5, '2023-01-01', 68.2, 22.5, 120.8, 65.5, 0.75, 28.1, 9.7);

-- 33. Add new column GDP_Per_Capita
alter table Health_Indicators add column GDP_Per_Capita double;

-- 34. Drop column GDP_Per_Capita
alter table Health_Indicators drop column GDP_Per_Capita;

-- 35. Change datatype of Life_Expectancy
alter table Health_Indicators modify column Life_Expectancy double;

-- 36. Find average smoking rate per country
select Country_ID, avg(Smoking_Rate) as Avg_Smoking from Health_Indicators group by Country_ID;

-- 37. Find max health expenditure per country
select Country_ID, max(Health_Expenditure_Per_capita) as Max_Spending from Health_Indicators group by Country_ID;

-- 38. Find min infant mortality per country
select Country_ID, min(Infant_Mortality) as Min_Infant_Mortality from Health_Indicators group by Country_ID;

-- 39. Find average child mortality per country
select Country_ID, avg(Child_Mortality_Rate) as Avg_Child_Mortality from Health_Indicators group by Country_ID;

-- 40. Countries where infant mortality is greater than child mortality
select * from Health_Indicators where Infant_Mortality > Child_Mortality_Rate;

-- 41. Countries with doctor-patient ratio greater than 2 and smoking rate less than 20
select * from Health_Indicators where Doctor_Patient_Ratio > 2 and Smoking_Rate < 20;

-- 42. Countries with life expectancy greater than 75 OR sanitation access greater than 90
select * from Health_Indicators where Life_Expectancy > 75 or Access_To_Sanitation > 90;

-- 43. Countries with highest smoking rate
select * from Health_Indicators order by Smoking_Rate desc limit 1;

-- 44. Countries with lowest smoking rate
select * from Health_Indicators order by Smoking_Rate asc limit 1;

-- 45. Count countries with sanitation = 100%
select count(*) from Health_Indicators where Access_To_Sanitation = 100;

-- 46. Get first 5 records by year
select * from Health_Indicators order by Year asc limit 5;

-- 47. Get last 5 records by year
select * from Health_Indicators order by Year desc limit 5;

-- 48. Countries where life expectancy between 65 and 70
select * from Health_Indicators where Life_Expectancy between 65 and 70;

-- 49. Countries where child mortality > 40
select * from Health_Indicators where Child_Mortality_Rate > 40;

-- 50. List average indicators grouped by decade
select floor(year(Year)/10)*10 as Decade,
avg(Life_Expectancy) as Avg_Life,
avg(Infant_Mortality) as Avg_Infant,
avg(Health_Expenditure_Per_capita) as Avg_Expenditure
from Health_Indicators
group by floor(year(Year)/10)*10;

-- Table-19 Funding----------------------------------------------------------------------------------------------------------
-- 1. Funding records with amount greater than 500,000
select * from Funding where Amount > 500000;

-- 2. Funding records for the year 2022
select * from Funding where Year = 2022;

-- 3. Funding records in USD currency
select * from Funding where Currency = 'USD';

-- 4. Funding from WHO
select * from Funding where Source = 'WHO';

-- 5. Funding with Type = 'Grant'
select * from Funding where Type = 'Grant';

-- 6. Maximum funding amount
select * from Funding order by Amount desc limit 1;

-- 7. Minimum funding amount
select * from Funding order by Amount asc limit 1;

-- 8. Average funding amount
select avg(Amount) as Avg_Amount from Funding;

-- 9. Count of funding records
select count(*) as Total_Funds from Funding;

-- 10. Total funding per country
select Country_ID, sum(Amount) as Total_Funding from Funding group by Country_ID;

-- 11. Average funding per year
select Year, avg(Amount) as Avg_Funding from Funding group by Year;

-- 12. Count funding records per source
select Source, count(*) as Count_Funding from Funding group by Source;

-- 13. Countries receiving more than 2 funding records
select Country_ID, count(*) as Funding_Count from Funding group by Country_ID having count(*) > 2;

-- 14. Funding for Program_ID = 3
select * from Funding where Program_ID = 3;

-- 15. Funding notes containing 'rural'
select * from Funding where Notes like '%rural%';

-- 16. Funding in EUR currency
select * from Funding where Currency = 'EUR';

-- 17. Funding records less than 300,000
select * from Funding where Amount < 300000;

-- 18. Total funding per currency
select Currency, sum(Amount) as Total_Per_Currency from Funding group by Currency;

-- 19. Funding from multiple sources (WHO or UNICEF)
select * from Funding where Source in ('WHO','UNICEF');

-- 20. Funding records for countries 1 to 5
select * from Funding where Country_ID between 1 and 5;

-- 21. Update funding amount for FundID = 1
update Funding set Amount = 550000 where FundID = 1;

-- 22. Delete funding record with FundID = 20
delete from Funding where FundID = 20;

-- 23. Insert a new funding record
insert into Funding
(FundID, Source, Type, Amount, Currency, Year, Country_ID, Purpose, Program_ID, Notes)
values (21, 'UNICEF', 'Grant', 400000, 'USD', 2023, 2, 'Nutrition Program', 5, 'Phase 2 implementation');

-- 24. Count of grants vs loans
select Type, count(*) as Count_Type from Funding group by Type;

-- 25. Funding for the year between 2021 and 2023
select * from Funding where Year between 2021 and 2023;

-- 26. Top 5 funding amounts
select * from Funding order by Amount desc limit 5;

-- 27. Bottom 5 funding amounts
select * from Funding order by Amount asc limit 5;

-- 28. Average funding per source
select Source, avg(Amount) as Avg_Amount from Funding group by Source;

-- 29. Maximum funding per year
select Year, max(Amount) as Max_Funding from Funding group by Year;

-- 30. Minimum funding per year
select Year, min(Amount) as Min_Funding from Funding group by Year;

-- 31. Case statement for funding size
select FundID, Amount,
case
  when Amount < 300000 then 'Small'
  when Amount between 300000 and 700000 then 'Medium'
  else 'Large'
end as Funding_Size
from Funding;

-- 32. Countries receiving more than 700,000 in total
select Country_ID, sum(Amount) as Total_Funding from Funding group by Country_ID having sum(Amount) > 700000;

-- 33. Sort funding by year descending
select * from Funding order by Year desc;

-- 34. Sort funding by amount ascending
select * from Funding order by Amount asc;

-- 35. Count of funding per program
select Program_ID, count(*) as Count_Per_Program from Funding group by Program_ID;

-- 36. Total funding per country in USD
select Country_ID, sum(Amount) as Total_USD from Funding where Currency='USD' group by Country_ID;

-- 37. Funding from WHO greater than 400,000
select * from Funding where Source='WHO' and Amount > 400000;

-- 38. Funding notes containing 'Phase'
select * from Funding where Notes like '%Phase%';

-- 39. Funding with Purpose containing 'Health'
select * from Funding where Purpose like '%Health%';

-- 40. Countries with average funding above 500,000
select Country_ID, avg(Amount) as Avg_Funding from Funding group by Country_ID having avg(Amount) > 500000;

-- 41. Funding for Program_ID not equal to 1
select * from Funding where Program_ID != 1;

-- 42. Funding sources with multiple funding types
select Source, count(distinct Type) as Type_Count from Funding group by Source having count(distinct Type) > 1;

-- 43. Count of funding per currency
select Currency, count(*) as Count_Per_Currency from Funding group by Currency;

-- 44. Funding for countries 1,3,5 only
select * from Funding where Country_ID in (1,3,5);

-- 45. Maximum funding per source
select Source, max(Amount) as Max_Amount from Funding group by Source;

-- 46. Minimum funding per source
select Source, min(Amount) as Min_Amount from Funding group by Source;

-- 47. Average funding per program
select Program_ID, avg(Amount) as Avg_Funding from Funding group by Program_ID;

-- 48. Funding records with notes containing 'digital'
select * from Funding where Notes like '%digital%';

-- 49. Countries receiving funding in multiple currencies
select Country_ID, count(distinct Currency) as Currency_Count from Funding group by Country_ID having count(distinct Currency) > 1;

-- 50. Total funding per year per currency
select Year, Currency, sum(Amount) as Total_Funding from Funding group by Year, Currency;

-- Table-20 Fund_Distribution------------------------------------------------------------------------------------------------
-- 1. Fund distributions greater than 150,000
select * from Fund_Distribution where Amount > 150000;

-- 2. Distributions allocated in 2022
select * from Fund_Distribution where year(Date_Allocated) = 2022;

-- 3. Distributions with Status = 'Pending'
select * from Fund_Distribution where Status = 'Pending';

-- 4. Distributions approved by 'WHO'
select * from Fund_Distribution where Approved_By like '%WHO%';

-- 5. Distributions for Fund_ID = 1
select * from Fund_Distribution where Fund_ID = 1;

-- 6. Maximum distribution amount
select * from Fund_Distribution order by Amount desc limit 1;

-- 7. Minimum distribution amount
select * from Fund_Distribution order by Amount asc limit 1;

-- 8. Average distribution amount
select avg(Amount) as Avg_Distribution from Fund_Distribution;

-- 9. Count of fund distributions
select count(*) as Total_Distributions from Fund_Distribution;

-- 10. Total amount distributed per country
select Country_ID, sum(Amount) as Total_Distributed from Fund_Distribution group by Country_ID;

-- 11. Total amount distributed per program
select Program_ID, sum(Amount) as Total_Per_Program from Fund_Distribution group by Program_ID;

-- 12. Count distributions per status
select Status, count(*) as Count_Status from Fund_Distribution group by Status;

-- 13. Distributions with remarks containing 'phase'
select * from Fund_Distribution where Remarks like '%phase%';

-- 14. Distributions between 50,000 and 200,000
select * from Fund_Distribution where Amount between 50000 and 200000;

-- 15. Distributions allocated after 2023-01-01
select * from Fund_Distribution where Date_Allocated > '2023-01-01';

-- 16. Top 5 highest distributions
select * from Fund_Distribution order by Amount desc limit 5;

-- 17. Bottom 5 lowest distributions
select * from Fund_Distribution order by Amount asc limit 5;

-- 18. Average distribution per country
select Country_ID, avg(Amount) as Avg_Per_Country from Fund_Distribution group by Country_ID;

-- 19. Maximum distribution per program
select Program_ID, max(Amount) as Max_Per_Program from Fund_Distribution group by Program_ID;

-- 20. Minimum distribution per program
select Program_ID, min(Amount) as Min_Per_Program from Fund_Distribution group by Program_ID;

-- 21. Case statement to classify distribution amount
select DistributionID, Amount,
case 
  when Amount < 50000 then 'Small'
  when Amount between 50000 and 150000 then 'Medium'
  else 'Large'
end as Distribution_Size
from Fund_Distribution;

-- 22. Count distributions per country
select Country_ID, count(*) as Count_Per_Country from Fund_Distribution group by Country_ID;

-- 23. Distributions with TrackingID starting with 'FD-IND'
select * from Fund_Distribution where TrackingID like 'FD-IND%';

-- 24. Distributions with Status = 'Released' and Amount > 100000
select * from Fund_Distribution where Status='Released' and Amount > 100000;

-- 25. Update Status to 'Released' for DistributionID = 3
update Fund_Distribution set Status='Released' where DistributionID = 3;

-- 26. Delete distribution with DistributionID = 20
delete from Fund_Distribution where DistributionID = 20;

-- 27. Insert new distribution record
insert into Fund_Distribution
(DistributionID, Fund_ID, Country_ID, Program_ID, Amount, Date_Allocated, Approved_By, Status, Remarks, TrackingID)
values (21, 5, 2, 6, 120000, '2023-07-01', 'UNICEF', 'Released', 'Additional allocation for rural clinics', 'FD-USA-021');

-- 28. Count distributions per fund
select Fund_ID, count(*) as Count_Per_Fund from Fund_Distribution group by Fund_ID;

-- 29. Total distribution per status
select Status, sum(Amount) as Total_Per_Status from Fund_Distribution group by Status;

-- 30. Distributions allocated in March 2022
select * from Fund_Distribution where month(Date_Allocated) = 3 and year(Date_Allocated) = 2022;

-- 31. Distributions approved by 'Ministry of Health India'
select * from Fund_Distribution where Approved_By = 'Ministry of Health India';

-- 32. Countries receiving more than 2 distributions
select Country_ID, count(*) as Count_Distributions from Fund_Distribution group by Country_ID having count(*) > 2;

-- 33. Programs receiving more than 2 distributions
select Program_ID, count(*) as Count_Distributions from Fund_Distribution group by Program_ID having count(*) > 2;

-- 34. Total amount distributed per country per status
select Country_ID, Status, sum(Amount) as Total_Amount from Fund_Distribution group by Country_ID, Status;

-- 35. Distinct statuses in Fund_Distribution
select distinct Status from Fund_Distribution;

-- 36. Distributions allocated before 2022
select * from Fund_Distribution where Date_Allocated < '2022-01-01';

-- 37. Average distribution per program
select Program_ID, avg(Amount) as Avg_Per_Program from Fund_Distribution group by Program_ID;

-- 38. Count distributions with remarks containing 'clinic'
select count(*) from Fund_Distribution where Remarks like '%clinic%';

-- 39. Sum of all distributions
select sum(Amount) as Total_Distributed from Fund_Distribution;

-- 40. Highest distribution per country
select Country_ID, max(Amount) as Max_Per_Country from Fund_Distribution group by Country_ID;

-- 41. Lowest distribution per country
select Country_ID, min(Amount) as Min_Per_Country from Fund_Distribution group by Country_ID;

-- 42. Distributions with amount > average amount
select * from Fund_Distribution where Amount > (select avg(Amount) from Fund_Distribution);

-- 43. Distributions with Status = 'Pending' for 2023
select * from Fund_Distribution where Status='Pending' and year(Date_Allocated)=2023;

-- 44. Count distributions per fund and status
select Fund_ID, Status, count(*) as Count_Per_Fund_Status from Fund_Distribution group by Fund_ID, Status;

-- 45. Distributions allocated in Q1 2023
select * from Fund_Distribution where Date_Allocated between '2023-01-01' and '2023-03-31';

-- 46. TrackingID ending with '005'
select * from Fund_Distribution where TrackingID like '%005';

-- 47. Total amount allocated per program in 2023
select Program_ID, sum(Amount) as Total_Amount from Fund_Distribution where year(Date_Allocated)=2023 group by Program_ID;

-- 48. Programs with total distribution above 300,000
select Program_ID, sum(Amount) as Total_Per_Program from Fund_Distribution group by Program_ID having sum(Amount) > 300000;

-- 49. Countries with maximum total distribution
select Country_ID, sum(Amount) as Total_Per_Country from Fund_Distribution group by Country_ID order by Total_Per_Country desc limit 1;

-- 50. List distributions with amount between 50,000 and 150,000 and status 'Released'
select * from Fund_Distribution where Amount between 50000 and 150000 and Status='Released';
