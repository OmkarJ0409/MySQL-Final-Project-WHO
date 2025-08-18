use who;

-- Table-21 Health_Campaigns-------------------------------------------------------------------------------------------------
-- 1. Campaigns targeting Children
select * from Health_Campaigns where Target_Group = 'Children';

-- 2. Campaigns targeting Adults
select * from Health_Campaigns where Target_Group = 'Adults';

-- 3. Campaigns targeting Elders
select * from Health_Campaigns where Target_Group = 'Elders';

-- 4. Campaigns with reach estimate greater than 1,000,000
select * from Health_Campaigns where Reach_Estimate > 1000000;

-- 5. Campaigns in Country_ID = 1
select * from Health_Campaigns where Country_ID = 1;

-- 6. Campaigns for Disease_ID = 5
select * from Health_Campaigns where Disease_ID = 5;

-- 7. Campaigns starting after 2020-01-01
select * from Health_Campaigns where Start_Date > '2020-01-01';

-- 8. Campaigns ending before 2021-01-01
select * from Health_Campaigns where End_Date < '2021-01-01';

-- 9. Campaigns using TV as medium
select * from Health_Campaigns where Medium like '%TV%';

-- 10. Campaigns using Social Media
select * from Health_Campaigns where Medium like '%Social Media%';

-- 11. Campaigns with feedback containing 'effective'
select * from Health_Campaigns where Feedback like '%effective%';

-- 12. Maximum reach estimate
select * from Health_Campaigns order by Reach_Estimate desc limit 1;

-- 13. Minimum reach estimate
select * from Health_Campaigns order by Reach_Estimate asc limit 1;

-- 14. Average reach estimate
select avg(Reach_Estimate) as Avg_Reach from Health_Campaigns;

-- 15. Count campaigns per country
select Country_ID, count(*) as Campaign_Count from Health_Campaigns group by Country_ID;

-- 16. Count campaigns per disease
select Disease_ID, count(*) as Campaign_Count from Health_Campaigns group by Disease_ID;

-- 17. Campaigns with duration more than 6 months
select *, datediff(End_Date, Start_Date) as Duration_Days from Health_Campaigns
where datediff(End_Date, Start_Date) > 180;

-- 18. Campaigns with duration less than 30 days
select *, datediff(End_Date, Start_Date) as Duration_Days from Health_Campaigns
where datediff(End_Date, Start_Date) < 30;

-- 19. Campaigns starting in 2022
select * from Health_Campaigns where year(Start_Date) = 2022;

-- 20. Campaigns ending in 2021
select * from Health_Campaigns where year(End_Date) = 2021;

-- 21. Campaigns with reach between 500,000 and 2,000,000
select * from Health_Campaigns where Reach_Estimate between 500000 and 2000000;

-- 22. Campaigns sorted by reach descending
select * from Health_Campaigns order by Reach_Estimate desc;

-- 23. Campaigns sorted by reach ascending
select * from Health_Campaigns order by Reach_Estimate asc;

-- 24. Top 5 campaigns by reach
select * from Health_Campaigns order by Reach_Estimate desc limit 5;

-- 25. Bottom 5 campaigns by reach
select * from Health_Campaigns order by Reach_Estimate asc limit 5;

-- 26. Campaigns with feedback containing 'urban'
select * from Health_Campaigns where Feedback like '%urban%';

-- 27. Campaigns with feedback containing 'rural'
select * from Health_Campaigns where Feedback like '%rural%';

-- 28. Update reach estimate for CamapignID = 1
update Health_Campaigns set Reach_Estimate = 10500000 where CamapignID = 1;

-- 29. Delete campaign with CamapignID = 20
delete from Health_Campaigns where CamapignID = 20;

-- 30. Insert new campaign
insert into Health_Campaigns
(CamapignID, Name, Disease_ID, Country_ID, Start_Date, End_Date, Target_Group, Medium, Reach_Estimate, Feedback)
values
(21, 'Nutrition Awareness Drive', 6, 2, '2023-07-01', '2023-08-01', 'Children', 'Schools, Radio', 750000, 'Positive feedback from schools');

-- 31. Campaigns for Children in 2022
select * from Health_Campaigns where Target_Group='Children' and year(Start_Date)=2022;

-- 32. Campaigns for Adults with reach > 1,000,000
select * from Health_Campaigns where Target_Group='Adults' and Reach_Estimate > 1000000;

-- 33. Count campaigns per target group
select Target_Group, count(*) as Total_Campaigns from Health_Campaigns group by Target_Group;

-- 34. Campaigns using multiple media (comma-separated)
select * from Health_Campaigns where Medium like '%,%';

-- 35. Campaigns started in Q1 2020
select * from Health_Campaigns where Start_Date between '2020-01-01' and '2020-03-31';

-- 36. Campaigns ended in Q4 2021
select * from Health_Campaigns where End_Date between '2021-10-01' and '2021-12-31';

-- 37. Campaigns with reach estimate greater than average
select * from Health_Campaigns where Reach_Estimate > (select avg(Reach_Estimate) from Health_Campaigns);

-- 38. Campaigns for Disease_ID 1 or 2
select * from Health_Campaigns where Disease_ID in (1,2);

-- 39. Campaigns excluding Disease_ID 5
select * from Health_Campaigns where Disease_ID <> 5;

-- 40. Case statement to classify campaigns by reach
select CamapignID, Reach_Estimate,
case
  when Reach_Estimate < 500000 then 'Small'
  when Reach_Estimate between 500000 and 2000000 then 'Medium'
  else 'Large'
end as Campaign_Size
from Health_Campaigns;

-- 41. Campaigns with duration more than 1 year
select *, datediff(End_Date, Start_Date)/365 as Duration_Years from Health_Campaigns
where datediff(End_Date, Start_Date)/365 > 1;

-- 42. Campaigns with duration less than 2 weeks
select *, datediff(End_Date, Start_Date) as Duration_Days from Health_Campaigns
where datediff(End_Date, Start_Date) < 14;

-- 43. Campaigns sorted by Start_Date ascending
select * from Health_Campaigns order by Start_Date asc;

-- 44. Campaigns sorted by End_Date descending
select * from Health_Campaigns order by End_Date desc;

-- 45. Campaigns with feedback containing 'low'
select * from Health_Campaigns where Feedback like '%low%';

-- 46. Campaigns with feedback containing 'high'
select * from Health_Campaigns where Feedback like '%high%';

-- 47. Count campaigns per medium
select Medium, count(*) as Campaign_Count from Health_Campaigns group by Medium;

-- 48. Campaigns where Target_Group is Children and Medium contains 'Schools'
select * from Health_Campaigns where Target_Group='Children' and Medium like '%Schools%';

-- 49. Campaigns with start date before 2019
select * from Health_Campaigns where Start_Date < '2019-01-01';

-- 50. List campaigns grouped by target group with average reach
select Target_Group, avg(Reach_Estimate) as Avg_Reach from Health_Campaigns group by Target_Group;

-- Table-22 Policy_Guidelines------------------------------------------------------------------------------------------------
-- 1. Policies issued after 2020-01-01
select * from Policy_Guidelines where Date_Issued > '2020-01-01';

-- 2. Policies issued before 2019
select * from Policy_Guidelines where Date_Issued < '2019-01-01';

-- 3. Policies for Disease_ID = 1
select * from Policy_Guidelines where Disease_ID = 1;

-- 4. Policies for Disease_ID in (1,2,3)
select * from Policy_Guidelines where Disease_ID in (1,2,3);

-- 5. Policies approved by WHO
select * from Policy_Guidelines where Approved_By like '%WHO%';

-- 6. Policies in English language
select * from Policy_Guidelines where Language = 'English';

-- 7. Policies in French language
select * from Policy_Guidelines where Language = 'French';

-- 8. Policies for Africa region
select * from Policy_Guidelines where Region = 'Africa';

-- 9. Policies for South-East Asia region
select * from Policy_Guidelines where Region = 'South-East Asia';

-- 10. Policies where Title contains 'Vaccination'
select * from Policy_Guidelines where Title like '%Vaccination%';

-- 11. Policies where Description contains 'screening'
select * from Policy_Guidelines where Description like '%screening%';

-- 12. Policies sorted by Date_Issued ascending
select * from Policy_Guidelines order by Date_Issued asc;

-- 13. Policies sorted by Date_Issued descending
select * from Policy_Guidelines order by Date_Issued desc;

-- 14. Latest policy issued
select * from Policy_Guidelines order by Date_Issued desc limit 1;

-- 15. Oldest policy issued
select * from Policy_Guidelines order by Date_Issued asc limit 1;

-- 16. Count policies per Disease_ID
select Disease_ID, count(*) as Policy_Count from Policy_Guidelines group by Disease_ID;

-- 17. Count policies per Region
select Region, count(*) as Policy_Count from Policy_Guidelines group by Region;

-- 18. Policies issued in 2020
select * from Policy_Guidelines where year(Date_Issued) = 2020;

-- 19. Policies issued in 2018
select * from Policy_Guidelines where year(Date_Issued) = 2018;

-- 20. Policies where Revision_History contains 'Rev 1'
select * from Policy_Guidelines where Revision_History like '%Rev 1%';

-- 21. Policies where Revision_History contains 'Rev 2'
select * from Policy_Guidelines where Revision_History like '%Rev 2%';

-- 22. Policies with URL containing 'gov'
select * from Policy_Guidelines where Document_URL like '%gov%';

-- 23. Policies with URL containing 'who'
select * from Policy_Guidelines where Document_URL like '%who%';

-- 24. Count of policies per language
select Language, count(*) as Total_Policies from Policy_Guidelines group by Language;

-- 25. Count of policies per Approved_By
select Approved_By, count(*) as Total_Policies from Policy_Guidelines group by Approved_By;

-- 26. Policies with Title starting with 'Hepatitis'
select * from Policy_Guidelines where Title like 'Hepatitis%';

-- 27. Policies with Description containing 'guidelines'
select * from Policy_Guidelines where Description like '%guidelines%';

-- 28. Policies issued between 2018-01-01 and 2020-12-31
select * from Policy_Guidelines where Date_Issued between '2018-01-01' and '2020-12-31';

-- 29. Policies for Western Pacific region
select * from Policy_Guidelines where Region = 'Western Pacific';

-- 30. Policies in multiple languages (like 'English/French')
select * from Policy_Guidelines where Language like '%/%';

-- 31. Update Approved_By for GuidelineID = 1
update Policy_Guidelines set Approved_By = 'WHO India' where GuidelineID = 1;

-- 32. Delete policy with GuidelineID = 20
delete from Policy_Guidelines where GuidelineID = 20;

-- 33. Insert new policy
insert into Policy_Guidelines
(GuidelineID, Title, Disease_ID, Date_Issued, Document_URL, Language, Region, Approved_By, Description, Revision_History)
values
(21, 'COVID-19 Booster Recommendations', 1, '2023-05-01', 'https://healthgov.org/covid19-booster', 'English', 'Europe', 'European Health Agency', 'Guidelines on COVID-19 booster shots.', 'Rev 1 – Initial release');

-- 34. Policies with Revision_History containing 'Pediatric'
select * from Policy_Guidelines where Revision_History like '%Pediatric%';

-- 35. Policies with Revision_History containing 'Updated'
select * from Policy_Guidelines where Revision_History like '%Updated%';

-- 36. Policies grouped by Region with count
select Region, count(*) as Total_Policies from Policy_Guidelines group by Region;

-- 37. Policies grouped by Disease_ID with count
select Disease_ID, count(*) as Total_Policies from Policy_Guidelines group by Disease_ID;

-- 38. Policies issued in the first quarter
select * from Policy_Guidelines where month(Date_Issued) between 1 and 3;

-- 39. Policies issued in the last quarter
select * from Policy_Guidelines where month(Date_Issued) between 10 and 12;

-- 40. Policies sorted by Title
select * from Policy_Guidelines order by Title asc;

-- 41. Policies with Document_URL containing 'cdc'
select * from Policy_Guidelines where Document_URL like '%cdc%';

-- 42. Policies where Description contains 'outbreak'
select * from Policy_Guidelines where Description like '%outbreak%';

-- 43. Policies with Revision_History containing 'Travel'
select * from Policy_Guidelines where Revision_History like '%Travel%';

-- 44. Policies issued in 2015
select * from Policy_Guidelines where year(Date_Issued) = 2015;

-- 45. Count policies per year
select year(Date_Issued) as Year_Issued, count(*) as Total_Policies from Policy_Guidelines group by year(Date_Issued);

-- 46. Policies issued for Disease_ID = 10 or 11
select * from Policy_Guidelines where Disease_ID in (10,11);

-- 47. Policies with Title containing 'Guidelines'
select * from Policy_Guidelines where Title like '%Guidelines%';

-- 48. Policies for Europe region
select * from Policy_Guidelines where Region = 'Europe';

-- 49. Policies where Approved_By contains 'CDC'
select * from Policy_Guidelines where Approved_By like '%CDC%';

-- 50. Average policies issued per year
select avg(PolicyCount) as Avg_Policies_Per_Year
from (select year(Date_Issued) as Year_Issued, count(*) as PolicyCount from Policy_Guidelines group by year(Date_Issued)) as SubQuery;

-- Table-23 Countries_Health_Policies----------------------------------------------------------------------------------------
-- 1. Policies implemented after 2015-01-01
select * from Countries_Health_Policies where Implemented_Date > '2015-01-01';

-- 2. Policies implemented before 2010
select * from Countries_Health_Policies where Implemented_Date < '2010-01-01';

-- 3. Policies with Status 'Active'
select * from Countries_Health_Policies where Status = 'Active';

-- 4. Policies with Status 'Ongoing'
select * from Countries_Health_Policies where Status = 'Ongoing';

-- 5. Policies with Status 'Revised'
select * from Countries_Health_Policies where Status = 'Revised';

-- 6. Policies for Country_ID = 1
select * from Countries_Health_Policies where Country_ID = 1;

-- 7. Policies for Country_ID in (1,2,3)
select * from Countries_Health_Policies where Country_ID in (1,2,3);

-- 8. Policies where Ministry contains 'Health'
select * from Countries_Health_Policies where Ministry like '%Health%';

-- 9. Policies where Updated_By contains 'Dr.'
select * from Countries_Health_Policies where Updated_By like 'Dr.%';

-- 10. Policies where Notes contains 'WHO'
select * from Countries_Health_Policies where Notes like '%WHO%';

-- 11. Policies sorted by Implemented_Date ascending
select * from Countries_Health_Policies order by Implemented_Date asc;

-- 12. Policies sorted by Implemented_Date descending
select * from Countries_Health_Policies order by Implemented_Date desc;

-- 13. Latest implemented policy
select * from Countries_Health_Policies order by Implemented_Date desc limit 1;

-- 14. Oldest implemented policy
select * from Countries_Health_Policies order by Implemented_Date asc limit 1;

-- 15. Count of policies per Status
select Status, count(*) as Total_Policies from Countries_Health_Policies group by Status;

-- 16. Count of policies per Country_ID
select Country_ID, count(*) as Total_Policies from Countries_Health_Policies group by Country_ID;

-- 17. Policies implemented in 2024
select * from Countries_Health_Policies where year(Implemented_Date) = 2024;

-- 18. Policies implemented in 2018
select * from Countries_Health_Policies where year(Implemented_Date) = 2018;

-- 19. Policies with Title containing 'Health'
select * from Countries_Health_Policies where Title like '%Health%';

-- 20. Policies with Policy_Text containing 'access'
select * from Countries_Health_Policies where Policy_Text like '%access%';

-- 21. Policies with Notes containing 'training'
select * from Countries_Health_Policies where Notes like '%training%';

-- 22. Policies reviewed after 2024-01-01
select * from Countries_Health_Policies where Last_Reviewed > '2024-01-01';

-- 23. Policies reviewed before 2024-01-01
select * from Countries_Health_Policies where Last_Reviewed < '2024-01-01';

-- 24. Policies where Status is 'Planning'
select * from Countries_Health_Policies where Status = 'Planning';

-- 25. Policies where Status is 'Revised' and Last_Reviewed > '2023-01-01'
select * from Countries_Health_Policies where Status='Revised' and Last_Reviewed > '2023-01-01';

-- 26. Update Status to 'Revised' for PolicyID=5
update Countries_Health_Policies set Status='Revised' where PolicyID=5;

-- 27. Delete policy with PolicyID=20
delete from Countries_Health_Policies where PolicyID=20;

-- 28. Insert new policy
insert into Countries_Health_Policies
(PolicyID, Country_ID, Title, Implemented_Date, Policy_Text, Status, Last_Reviewed, Ministry, Updated_By, Notes)
values
(21, 1, 'Digital Health Expansion', '2025-01-01', 'Expand telemedicine and e-health services.', 'Active', '2025-03-01', 'Ministry of Health and Family Welfare', 'Dr. Rohit Singh', 'Telemedicine pilot programs started.');

-- 29. Policies implemented between 2015-01-01 and 2020-12-31
select * from Countries_Health_Policies where Implemented_Date between '2015-01-01' and '2020-12-31';

-- 30. Policies reviewed between 2024-01-01 and 2024-06-30
select * from Countries_Health_Policies where Last_Reviewed between '2024-01-01' and '2024-06-30';

-- 31. Count of policies per Ministry
select Ministry, count(*) as Total_Policies from Countries_Health_Policies group by Ministry;

-- 32. Count of policies per Updated_By
select Updated_By, count(*) as Total_Policies from Countries_Health_Policies group by Updated_By;

-- 33. Policies with Notes containing 'mobile'
select * from Countries_Health_Policies where Notes like '%mobile%';

-- 34. Policies implemented in first quarter
select * from Countries_Health_Policies where month(Implemented_Date) between 1 and 3;

-- 35. Policies implemented in last quarter
select * from Countries_Health_Policies where month(Implemented_Date) between 10 and 12;

-- 36. Policies sorted by Title
select * from Countries_Health_Policies order by Title asc;

-- 37. Policies with Title containing 'National'
select * from Countries_Health_Policies where Title like '%National%';

-- 38. Policies with Status 'Active' and Notes containing 'care'
select * from Countries_Health_Policies where Status='Active' and Notes like '%care%';

-- 39. Policies where Policy_Text contains 'insurance'
select * from Countries_Health_Policies where Policy_Text like '%insurance%';

-- 40. Policies with Implemented_Date before 2010 and Status 'Active'
select * from Countries_Health_Policies where Implemented_Date < '2010-01-01' and Status='Active';

-- 41. Policies updated by Dr. Ana Souza
select * from Countries_Health_Policies where Updated_By='Dr. Ana Souza';

-- 42. Policies where Notes contain 'integration'
select * from Countries_Health_Policies where Notes like '%integration%';

-- 43. Count of policies per year implemented
select year(Implemented_Date) as Year_Implemented, count(*) as Total_Policies
from Countries_Health_Policies group by year(Implemented_Date);

-- 44. Policies implemented for Country_ID=10 or 15
select * from Countries_Health_Policies where Country_ID in (10,15);

-- 45. Policies with Title containing 'Vision'
select * from Countries_Health_Policies where Title like '%Vision%';

-- 46. Policies with Status 'Ongoing' and Last_Reviewed after '2024-01-01'
select * from Countries_Health_Policies where Status='Ongoing' and Last_Reviewed > '2024-01-01';

-- 47. Policies with Policy_Text containing 'maternal'
select * from Countries_Health_Policies where Policy_Text like '%maternal%';

-- 48. Policies implemented in 2012
select * from Countries_Health_Policies where year(Implemented_Date)=2012;

-- 49. Average number of policies implemented per year
select avg(PolicyCount) as Avg_Policies_Per_Year
from (select year(Implemented_Date) as Year_Implemented, count(*) as PolicyCount
      from Countries_Health_Policies group by year(Implemented_Date)) as SubQuery;

-- 50. Policies with Notes containing 'scaled'
select * from Countries_Health_Policies where Notes like '%scaled%';

-- Table-24 Global_Health_Alerts---------------------------------------------------------------------------------------------
-- 1. Alerts issued after 2022-01-01
select * from Global_Health_Alerts where Date_Issued > '2022-01-01';

-- 2. Alerts issued before 2021-01-01
select * from Global_Health_Alerts where Date_Issued < '2021-01-01';

-- 3. Alerts with Alert_Level 'Critical'
select * from Global_Health_Alerts where Alert_Level='Critical';

-- 4. Alerts with Alert_Level 'High'
select * from Global_Health_Alerts where Alert_Level='High';

-- 5. Alerts with Alert_Level 'Moderate'
select * from Global_Health_Alerts where Alert_Level='Moderate';

-- 6. Alerts with Alert_Level 'Low'
select * from Global_Health_Alerts where Alert_Level='Low';

-- 7. Alerts affecting region 'Africa'
select * from Global_Health_Alerts where Region_Affected='Africa';

-- 8. Alerts affecting region 'Europe'
select * from Global_Health_Alerts where Region_Affected='Europe';

-- 9. Alerts for Disease_ID=1 (COVID-19)
select * from Global_Health_Alerts where Disease_ID=1;

-- 10. Alerts for Disease_ID in (1,2,3)
select * from Global_Health_Alerts where Disease_ID in (1,2,3);

-- 11. Alerts sorted by Date_Issued ascending
select * from Global_Health_Alerts order by Date_Issued asc;

-- 12. Alerts sorted by Date_Issued descending
select * from Global_Health_Alerts order by Date_Issued desc;

-- 13. Latest alert issued
select * from Global_Health_Alerts order by Date_Issued desc limit 1;

-- 14. Oldest alert issued
select * from Global_Health_Alerts order by Date_Issued asc limit 1;

-- 15. Count of alerts per Alert_Level
select Alert_Level, count(*) as Total_Alerts from Global_Health_Alerts group by Alert_Level;

-- 16. Count of alerts per Region_Affected
select Region_Affected, count(*) as Total_Alerts from Global_Health_Alerts group by Region_Affected;

-- 17. Alerts with Expiry_Date before 2022-01-01
select * from Global_Health_Alerts where Expiry_Date < '2022-01-01';

-- 18. Alerts with Expiry_Date after 2023-01-01
select * from Global_Health_Alerts where Expiry_Date > '2023-01-01';

-- 19. Alerts where Source contains 'WHO'
select * from Global_Health_Alerts where Source like '%WHO%';

-- 20. Alerts where Notes contain 'guidelines'
select * from Global_Health_Alerts where Notes like '%guidelines%';

-- 21. Alerts where Notes contain 'vaccination'
select * from Global_Health_Alerts where Notes like '%vaccination%';

-- 22. Alerts issued in 2021
select * from Global_Health_Alerts where year(Date_Issued)=2021;

-- 23. Alerts issued in 2022
select * from Global_Health_Alerts where year(Date_Issued)=2022;

-- 24. Alerts with Alert_Level 'High' or 'Critical'
select * from Global_Health_Alerts where Alert_Level in ('High','Critical');

-- 25. Alerts affecting 'Western Pacific' with Alert_Level 'Critical'
select * from Global_Health_Alerts where Region_Affected='Western Pacific' and Alert_Level='Critical';

-- 26. Update Notes for AlertID=2
update Global_Health_Alerts set Notes='Distribution of mosquito nets and public awareness.' where AlertID=2;

-- 27. Delete alert with AlertID=20
delete from Global_Health_Alerts where AlertID=20;

-- 28. Insert new alert
insert into Global_Health_Alerts
(AlertID, Title, Date_Issued, Region_Affected, Alert_Level, Disease_ID, Description, Source, Expiry_Date, Notes)
values
(21, 'New COVID-19 Variant Alert', '2025-05-01', 'Europe', 'High', 1, 'Emergence of new variant with higher transmission.', 'WHO', '2025-12-31', 'Enhanced surveillance required.');

-- 29. Alerts issued between 2021-01-01 and 2022-12-31
select * from Global_Health_Alerts where Date_Issued between '2021-01-01' and '2022-12-31';

-- 30. Alerts expiring between 2022-01-01 and 2023-06-30
select * from Global_Health_Alerts where Expiry_Date between '2022-01-01' and '2023-06-30';

-- 31. Count of alerts per Disease_ID
select Disease_ID, count(*) as Total_Alerts from Global_Health_Alerts group by Disease_ID;

-- 32. Alerts with Title containing 'Flu'
select * from Global_Health_Alerts where Title like '%Flu%';

-- 33. Alerts with Title containing 'COVID'
select * from Global_Health_Alerts where Title like '%COVID%';

-- 34. Alerts with Description containing 'cases'
select * from Global_Health_Alerts where Description like '%cases%';

-- 35. Alerts with Description containing 'detection'
select * from Global_Health_Alerts where Description like '%detection%';

-- 36. Alerts with Alert_Level 'Moderate' and Region_Affected 'Europe'
select * from Global_Health_Alerts where Alert_Level='Moderate' and Region_Affected='Europe';

-- 37. Alerts sorted by Alert_Level descending
select * from Global_Health_Alerts order by
case Alert_Level
    when 'Critical' then 4
    when 'High' then 3
    when 'Moderate' then 2
    when 'Low' then 1
end desc;

-- 38. Alerts with Notes containing 'campaign'
select * from Global_Health_Alerts where Notes like '%campaign%';

-- 39. Alerts affecting 'Americas' with Alert_Level 'Low'
select * from Global_Health_Alerts where Region_Affected='Americas' and Alert_Level='Low';

-- 40. Alerts issued in first quarter
select * from Global_Health_Alerts where month(Date_Issued) between 1 and 3;

-- 41. Alerts issued in last quarter
select * from Global_Health_Alerts where month(Date_Issued) between 10 and 12;

-- 42. Alerts for Disease_ID=5 with Alert_Level 'Moderate'
select * from Global_Health_Alerts where Disease_ID=5 and Alert_Level='Moderate';

-- 43. Alerts expiring before 2022-06-30
select * from Global_Health_Alerts where Expiry_Date<'2022-06-30';

-- 44. Alerts where Source contains 'CDC'
select * from Global_Health_Alerts where Source like '%CDC%';

-- 45. Alerts where Notes contain 'monitoring'
select * from Global_Health_Alerts where Notes like '%monitoring%';

-- 46. Count of alerts per year issued
select year(Date_Issued) as Year_Issued, count(*) as Total_Alerts
from Global_Health_Alerts group by year(Date_Issued);

-- 47. Alerts issued for Disease_ID=7 or 8
select * from Global_Health_Alerts where Disease_ID in (7,8);

-- 48. Alerts where Notes contain 'emergency'
select * from Global_Health_Alerts where Notes like '%emergency%';

-- 49. Average expiry duration in days
select avg(datediff(Expiry_Date, Date_Issued)) as Avg_Expiry_Days from Global_Health_Alerts;

-- 50. Alerts with Alert_Level 'High' and Notes containing 'treatment'
select * from Global_Health_Alerts where Alert_Level='High' and Notes like '%treatment%';

-- Table-25 Collaborating_Organizations--------------------------------------------------------------------------------------
-- 1. Organizations in India (Country_ID=1)
select * from Collaborating_Organizations where Country_ID=1;

-- 2. Organizations in USA (Country_ID=2)
select * from Collaborating_Organizations where Country_ID=2;

-- 3. Organizations of type 'NGO'
select * from Collaborating_Organizations where Type='NGO';

-- 4. Organizations of type 'Government'
select * from Collaborating_Organizations where Type='Government';

-- 5. Organizations of type 'Research'
select * from Collaborating_Organizations where Type='Research';

-- 6. Organizations partnered after 2010-01-01
select * from Collaborating_Organizations where Partnership_Date > '2010-01-01';

-- 7. Organizations partnered before 2005-01-01
select * from Collaborating_Organizations where Partnership_Date < '2005-01-01';

-- 8. Organizations with Name containing 'Health'
select * from Collaborating_Organizations where Name like '%Health%';

-- 9. Organizations with Area_of_Work containing 'Infectious Diseases'
select * from Collaborating_Organizations where Area_of_Work like '%Infectious Diseases%';

-- 10. Organizations with Area_of_Work containing 'Research'
select * from Collaborating_Organizations where Area_of_Work like '%Research%';

-- 11. Organizations sorted by Partnership_Date ascending
select * from Collaborating_Organizations order by Partnership_Date asc;

-- 12. Organizations sorted by Partnership_Date descending
select * from Collaborating_Organizations order by Partnership_Date desc;

-- 13. Latest partnered organization
select * from Collaborating_Organizations order by Partnership_Date desc limit 1;

-- 14. Earliest partnered organization
select * from Collaborating_Organizations order by Partnership_Date asc limit 1;

-- 15. Count of organizations per Type
select Type, count(*) as Total_Organizations from Collaborating_Organizations group by Type;

-- 16. Count of organizations per Country_ID
select Country_ID, count(*) as Total_Organizations from Collaborating_Organizations group by Country_ID;

-- 17. Update Notes for OrgID=3
update Collaborating_Organizations set Notes='Supports Zika, Dengue, and COVID research.' where OrgID=3;

-- 18. Delete organization with OrgID=20
delete from Collaborating_Organizations where OrgID=20;

-- 19. Insert new organization
insert into Collaborating_Organizations
(OrgID, Name, Type, Country_ID, Contact_Email, Phone, Website, Partnership_Date, Area_of_Work, Notes)
values
(21, 'Global Health Alliance', 'NGO', 1, 'info@gha.org', '+91-9988776655', 'https://www.gha.org', '2023-01-15', 'Public Health, Vaccination', 'Active in India and South-East Asia.');

-- 20. Organizations in Europe (Country_ID in 6,7,14,15,19)
select * from Collaborating_Organizations where Country_ID in (6,7,14,15,19);

-- 21. Organizations partnered in 2000
select * from Collaborating_Organizations where year(Partnership_Date)=2000;

-- 22. Organizations partnered in 2010
select * from Collaborating_Organizations where year(Partnership_Date)=2010;

-- 23. Organizations with Contact_Email containing 'gov'
select * from Collaborating_Organizations where Contact_Email like '%gov%';

-- 24. Organizations with Phone starting with '+1'
select * from Collaborating_Organizations where Phone like '+1%';

-- 25. Organizations in Asia (Country_ID in 1,4,8,16,17)
select * from Collaborating_Organizations where Country_ID in (1,4,8,16,17);

-- 26. Count of organizations partnered each year
select year(Partnership_Date) as Year_Partnered, count(*) as Total_Organizations
from Collaborating_Organizations group by year(Partnership_Date);

-- 27. Organizations where Notes contain 'WHO'
select * from Collaborating_Organizations where Notes like '%WHO%';

-- 28. Organizations where Notes contain 'pandemic'
select * from Collaborating_Organizations where Notes like '%pandemic%';

-- 29. Organizations where Area_of_Work contains 'Vaccines'
select * from Collaborating_Organizations where Area_of_Work like '%Vaccines%';

-- 30. Organizations where Area_of_Work contains 'Public Health'
select * from Collaborating_Organizations where Area_of_Work like '%Public Health%';

-- 31. Organizations with Website containing 'gov'
select * from Collaborating_Organizations where Website like '%gov%';

-- 32. Organizations sorted by Name ascending
select * from Collaborating_Organizations order by Name asc;

-- 33. Organizations sorted by Name descending
select * from Collaborating_Organizations order by Name desc;

-- 34. Count of organizations per Area_of_Work
select Area_of_Work, count(*) as Total_Organizations from Collaborating_Organizations group by Area_of_Work;

-- 35. Organizations with Partnership_Date in first half of year
select * from Collaborating_Organizations where month(Partnership_Date) between 1 and 6;

-- 36. Organizations with Partnership_Date in second half of year
select * from Collaborating_Organizations where month(Partnership_Date) between 7 and 12;

-- 37. Organizations with Type='Research' and Area_of_Work containing 'Infectious Diseases'
select * from Collaborating_Organizations where Type='Research' and Area_of_Work like '%Infectious Diseases%';

-- 38. Organizations with Type='Government' and Country_ID=2
select * from Collaborating_Organizations where Type='Government' and Country_ID=2;

-- 39. Organizations where Notes contain 'coordination'
select * from Collaborating_Organizations where Notes like '%coordination%';

-- 40. Organizations where Name contains 'Institute'
select * from Collaborating_Organizations where Name like '%Institute%';

-- 41. Organizations partnered before 2005 and of Type='Government'
select * from Collaborating_Organizations where Partnership_Date<'2005-01-01' and Type='Government';

-- 42. Organizations partnered after 2015 and of Type='NGO'
select * from Collaborating_Organizations where Partnership_Date>'2015-01-01' and Type='NGO';

-- 43. Count of organizations per country and type
select Country_ID, Type, count(*) as Total_Organizations
from Collaborating_Organizations group by Country_ID, Type;

-- 44. Organizations where Notes contain 'supports'
select * from Collaborating_Organizations where Notes like '%supports%';

-- 45. Organizations where Area_of_Work contains 'Disease Control'
select * from Collaborating_Organizations where Area_of_Work like '%Disease Control%';

-- 46. Organizations with Phone starting with '+91'
select * from Collaborating_Organizations where Phone like '+91%';

-- 47. Organizations with Email ending with '.org'
select * from Collaborating_Organizations where Contact_Email like '%.org';

-- 48. Organizations partnered in 2005
select * from Collaborating_Organizations where year(Partnership_Date)=2005;

-- 49. Organizations where Notes contain 'research'
select * from Collaborating_Organizations where Notes like '%research%';

-- 50. Organizations in Country_ID=1 or 4 with Type='NGO'
select * from Collaborating_Organizations where Country_ID in (1,4) and Type='NGO';
