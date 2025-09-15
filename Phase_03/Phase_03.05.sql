use who;

-- Table-21 Health_Campaigns-------------------------------------------------------------------------------------------------
-- 1. Alias for columns
select Name as Campaign_Name, Reach_Estimate as Reach from Health_Campaigns;

-- 2. Alias for table
select hc.CamapignID, hc.Target_Group from Health_Campaigns hc;

-- 3. Alias with concatenation
select concat(Name, ' (', Target_Group, ')') as Campaign_Info from Health_Campaigns;

-- 4. Alias with case
select Name, case when Reach_Estimate > 1000000 then 'High Reach' else 'Low Reach' end as Reach_Category from Health_Campaigns;

-- 5. Alias with grouping
select Country_ID as CID, count(*) as Total_Campaigns from Health_Campaigns group by CID;

-- 6. Alias with date difference
select Name, datediff(End_Date, Start_Date) as Duration_Days from Health_Campaigns;

-- 7. Alias with substring
select substring(Name,1,15) as Short_Name from Health_Campaigns;

-- 8. Alias with distinct
select distinct(Target_Group) as Groups_Targeted from Health_Campaigns;

-- 9. Alias with order by
select Name as Campaign, Start_Date as Begin_Date from Health_Campaigns order by Start_Date desc;

-- 10. Alias with min/max
select Disease_ID as DID, max(Reach_Estimate) as Max_Reach from Health_Campaigns group by DID;

-- 11. Campaigns with above-average reach
select * from Health_Campaigns where Reach_Estimate > (select avg(Reach_Estimate) from Health_Campaigns);

-- 12. Campaign with minimum reach
select * from Health_Campaigns where Reach_Estimate = (select min(Reach_Estimate) from Health_Campaigns);

-- 13. Campaigns targeting 'Children'
select * from Health_Campaigns where Target_Group='Children'
and CamapignID in (select CamapignID from Health_Campaigns);

-- 14. Countries with more than 2 campaigns
select Country_ID from Health_Campaigns group by Country_ID
having count(*) > (select avg(count(*)) from Health_Campaigns group by Country_ID);

-- 15. Campaigns for disease 1 after 2020
select * from Health_Campaigns where Disease_ID=1
and Start_Date > (select max(Start_Date) from Health_Campaigns where Disease_ID=1);

-- 16. Most recent campaign
select * from Health_Campaigns where Start_Date = (select max(Start_Date) from Health_Campaigns);

-- 17. Earliest campaign
select * from Health_Campaigns where Start_Date = (select min(Start_Date) from Health_Campaigns);

-- 18. Campaigns in countries with ID > 10
select * from Health_Campaigns where Country_ID in (select CountryID from Countries where CountryID>10);

-- 19. Campaigns longer than 'Flu Shot Promotion'
select * from Health_Campaigns
where datediff(End_Date, Start_Date) > (select datediff(End_Date, Start_Date) from Health_Campaigns where Name='Flu Shot Promotion');

-- 20. Children campaigns after 2019
select * from Health_Campaigns where Target_Group='Children' 
and Start_Date > (select min(Start_Date) from Health_Campaigns where Target_Group='Children');

-- 21. Total estimated reach
select sum(Reach_Estimate) as Total_Reach from Health_Campaigns;

-- 22. Average reach per target group
select Target_Group, avg(Reach_Estimate) as Avg_Reach from Health_Campaigns group by Target_Group;

-- 23. Count campaigns per medium
select Medium, count(*) as Total_Campaigns from Health_Campaigns group by Medium;

-- 24. Maximum and minimum reach
select max(Reach_Estimate) as Max_Reach, min(Reach_Estimate) as Min_Reach from Health_Campaigns;

-- 25. Round reach estimate
select Name, round(Reach_Estimate,0) as Rounded_Reach from Health_Campaigns;

-- 26. Year of campaign start
select Name, year(Start_Date) as Start_Year from Health_Campaigns;

-- 27. Length of feedback
select Name, length(Feedback) as Feedback_Length from Health_Campaigns;

-- 28. Upper case campaign name
select upper(Name) as Campaign_Upper from Health_Campaigns;

-- 29. Replace text in feedback
select replace(Feedback,'urban','city') as Updated_Feedback from Health_Campaigns;

-- 30. Substring campaign name
select substring(Name,1,10) as Short_Campaign_Name from Health_Campaigns;

-- 31. UDF: Convert reach to millions
delimiter //
create function ReachMillions(val int) returns double
deterministic
begin
  return val/1000000;
end//
delimiter ;
select Name, ReachMillions(Reach_Estimate) as Reach_in_Millions from Health_Campaigns;

-- 32. UDF: High or Low reach
delimiter //
create function ReachCategory(val int) returns varchar(10)
deterministic
begin
  if val > 2000000 then return 'High'; else return 'Low'; end if;
end//
delimiter ;
select Name, ReachCategory(Reach_Estimate) as Reach_Level from Health_Campaigns;

-- 33. UDF: Campaign duration in days
delimiter //
create function CampaignDuration(startd date, endd date) returns int
deterministic
begin
  return datediff(endd, startd);
end//
delimiter ;
select Name, CampaignDuration(Start_Date, End_Date) as Duration from Health_Campaigns;

-- 34. UDF: Mask campaign name
delimiter //
create function MaskCampaign(name varchar(100)) returns varchar(100)
deterministic
begin
  return concat(left(name,5),'***');
end//
delimiter ;
select Name, MaskCampaign(Name) as Masked_Name from Health_Campaigns;

-- 35. UDF: Feedback short snippet
delimiter //
create function ShortFeedback(txt varchar(200)) returns varchar(50)
deterministic
begin
  return substring(txt,1,30);
end//
delimiter ;
select Name, ShortFeedback(Feedback) as Feedback_Short from Health_Campaigns;

-- 36. UDF: Check if adults campaign
delimiter //
create function IsAdults(target varchar(50)) returns varchar(10)
deterministic
begin
  if target='Adults' then return 'Yes'; else return 'No'; end if;
end//
delimiter ;
select Name, IsAdults(Target_Group) as Adults_Campaign from Health_Campaigns;

-- 37. UDF: Feedback length category
delimiter //
create function FeedbackLengthCat(txt varchar(200)) returns varchar(20)
deterministic
begin
  if length(txt) > 20 then return 'Long'; else return 'Short'; end if;
end//
delimiter ;
select Name, FeedbackLengthCat(Feedback) as Feedback_Type from Health_Campaigns;

-- 38. UDF: Convert to thousands
delimiter //
create function ToThousands(val int) returns double
deterministic
begin
  return val/1000;
end//
delimiter ;
select Name, ToThousands(Reach_Estimate) as Reach_in_Thousands from Health_Campaigns;

-- 39. UDF: Campaign active duration check
delimiter //
create function IsActive(endd date) returns varchar(10)
deterministic
begin
  if endd > curdate() then return 'Active'; else return 'Completed'; end if;
end//
delimiter ;
select Name, IsActive(End_Date) as Status_Check from Health_Campaigns;

-- 40. UDF: Feedback word count (approx)
delimiter //
create function FeedbackWords(txt text) returns int
deterministic
begin
  return length(txt)-length(replace(txt,' ','')+1);
end//
delimiter ;
select Name, FeedbackWords(Feedback) as Word_Count from Health_Campaigns;

-- 41. Campaign with country name
select hc.CamapignID, c.Name as Country_Name, hc.Name as Campaign_Name
from Health_Campaigns hc join Countries c on hc.Country_ID=c.CountryID;

-- 42. Campaign with disease name
select hc.CamapignID, d.Name as Disease_Name, hc.Name as Campaign_Name
from Health_Campaigns hc join Diseases d on hc.Disease_ID=d.DiseaseID;

-- 43. Campaign with country and disease
select hc.CamapignID, hc.Name as Campaign, c.Name as Country, d.Name as Disease
from Health_Campaigns hc
join Countries c on hc.Country_ID=c.CountryID
join Diseases d on hc.Disease_ID=d.DiseaseID;

-- 44. Campaigns in countries with ID > 10
select hc.Name, c.Name as Country
from Health_Campaigns hc join Countries c on hc.Country_ID=c.CountryID
where hc.Country_ID>10;

-- 45. Campaigns with diseases in category 'Viral' (example)
select hc.Name, d.Name as Disease_Name
from Health_Campaigns hc join Diseases d on hc.Disease_ID=d.DiseaseID
where d.Type='Viral';

-- 46. Total reach per country
select c.Name as Country, sum(hc.Reach_Estimate) as Total_Reach
from Health_Campaigns hc join Countries c on hc.Country_ID=c.CountryID
group by c.Name;

-- 47. Total campaigns per disease
select d.Name as Disease, count(*) as Total_Campaigns
from Health_Campaigns hc join Diseases d on hc.Disease_ID=d.DiseaseID
group by d.Name;

-- 48. Campaigns targeting children with country
select hc.Name, c.Name as Country
from Health_Campaigns hc join Countries c on hc.Country_ID=c.CountryID
where hc.Target_Group='Children';

-- 49. Campaigns with duration > 100 days
select hc.Name, datediff(hc.End_Date,hc.Start_Date) as Duration, c.Name as Country
from Health_Campaigns hc join Countries c on hc.Country_ID=c.CountryID
where datediff(hc.End_Date,hc.Start_Date)>100;

-- 50. Campaigns with feedback containing 'urban'
select hc.Name, hc.Feedback, c.Name as Country
from Health_Campaigns hc join Countries c on hc.Country_ID=c.CountryID
where hc.Feedback like '%urban%';

-- Table-22 Policy_Guidelines------------------------------------------------------------------------------------------------
-- 1. alias for title and approved_by
select Title as guideline_title, Approved_By as authority from Policy_Guidelines;

-- 2. alias for disease_id
select Disease_ID as disease, Title from Policy_Guidelines;

-- 3. alias for date_issued
select Title, Date_Issued as issued_on from Policy_Guidelines;

-- 4. alias for region
select Title, Region as guideline_region from Policy_Guidelines;

-- 5. multiple aliases
select Title as guideline, Language as lang, Approved_By as authority from Policy_Guidelines;

-- 6. alias with condition
select Title as guideline, Region as guideline_region from Policy_Guidelines where Language='English';

-- 7. alias with sorting
select Title as guideline, Date_Issued as issued_on from Policy_Guidelines order by Date_Issued desc;

-- 8. alias for document URL
select Title, Document_URL as doc_link from Policy_Guidelines;

-- 9. alias for all columns
select GuidelineID as id, Title as guideline, Disease_ID as disease, Date_Issued as issued_on, Language as lang, Region as region, Approved_By as approved_by from Policy_Guidelines;

-- 10. alias with concat
select concat(Title,' - ',Region) as guideline_info from Policy_Guidelines;

-- 11. guidelines issued after avg year
select Title, Date_Issued from Policy_Guidelines 
where year(Date_Issued) > (select avg(year(Date_Issued)) from Policy_Guidelines);

-- 12. guidelines for regions with multiple entries
select Title, Region from Policy_Guidelines where Region in (select Region from Policy_Guidelines group by Region having count(*)>1);

-- 13. most recent guideline
select * from Policy_Guidelines where Date_Issued = (select max(Date_Issued) from Policy_Guidelines);

-- 14. earliest guideline
select * from Policy_Guidelines where Date_Issued = (select min(Date_Issued) from Policy_Guidelines);

-- 15. guidelines approved by same authority as 'Ministry of Health India'
select Title, Approved_By from Policy_Guidelines where Approved_By = (select Approved_By from Policy_Guidelines where Title='COVID-19 Containment Measures');

-- 16. guidelines issued after 2020
select Title, Date_Issued from Policy_Guidelines where year(Date_Issued)>2020;

-- 17. guidelines with longest title
select Title, length(Title) as title_length from Policy_Guidelines where length(Title) = (select max(length(Title)) from Policy_Guidelines);

-- 18. authorities with more than 1 guideline
select Approved_By from Policy_Guidelines group by Approved_By having count(*)>=2;

-- 19. guidelines issued in earliest year per region
select * from Policy_Guidelines pg1 where Date_Issued = (select min(Date_Issued) from Policy_Guidelines pg2 where pg1.Region=pg2.Region);

-- 20. guidelines for diseases with ID less than avg
select * from Policy_Guidelines where Disease_ID < (select avg(Disease_ID) from Policy_Guidelines);

-- 21. length of guideline title
select Title, length(Title) as title_length from Policy_Guidelines;

-- 22. upper case language
select upper(Language) as lang_upper from Policy_Guidelines;

-- 23. lower case region
select lower(Region) as region_lower from Policy_Guidelines;

-- 24. substring of title
select substring(Title,1,15) as short_title from Policy_Guidelines;

-- 25. years since issued
select Title, year(curdate())-year(Date_Issued) as years_since_issue from Policy_Guidelines;

-- 26. concatenate title and region
select concat(Title,' (',Region,')') as guideline_info from Policy_Guidelines;

-- 27. replace spaces in title
select replace(Title,' ','_') as slug_title from Policy_Guidelines;

-- 28. count guidelines per language
select Language, count(*) as total_guidelines from Policy_Guidelines group by Language;

-- 29. max reach estimate per disease
select Disease_ID, max(Reach_Estimate) as max_reach from Policy_Guidelines group by Disease_ID;

-- 30. format date issued
select Title, date_format(Date_Issued,'%d-%b-%Y') as formatted_date from Policy_Guidelines;

-- 31. UDF to calculate guideline age
delimiter //
create function guideline_age(issue_date date) returns int deterministic
begin
  return year(curdate())-year(issue_date);
end;
//
delimiter ;
select Title, guideline_age(Date_Issued) as age from Policy_Guidelines;

-- 32. UDF to classify regions
delimiter //
create function region_class(region varchar(50)) returns varchar(20) deterministic
begin
  if region in ('Africa','South-East Asia') then
    return 'High Priority';
  else
    return 'Standard';
  end if;
end;
//
delimiter ;
select Title, region_class(Region) as priority from Policy_Guidelines;

-- 33. UDF to mask approved_by
delimiter //
create function mask_approved(approved varchar(100)) returns varchar(100) deterministic
begin
  return concat(left(approved,3),'***');
end;
//
delimiter ;
select Title, mask_approved(Approved_By) as masked_approved from Policy_Guidelines;

-- 34. UDF to get year of issue
delimiter //
create function get_issue_year(issue_date date) returns int deterministic
begin
  return year(issue_date);
end;
//
delimiter ;
select Title, get_issue_year(Date_Issued) as issue_year from Policy_Guidelines;

-- 35. UDF to create short title
delimiter //
create function short_title(title varchar(200)) returns varchar(50) deterministic
begin
  return concat(left(title,20),'...');
end;
//
delimiter ;
select Title, short_title(Title) as brief_title from Policy_Guidelines;

-- 36. UDF to check if English guideline
delimiter //
create function is_english(lang varchar(50)) returns varchar(20) deterministic
begin
  if lang='English' then return 'Yes'; else return 'No'; end if;
end;
//
delimiter ;
select Title, is_english(Language) as english_flag from Policy_Guidelines;

-- 37. UDF to summarize guideline
delimiter //
create function guideline_summary(title varchar(200), region varchar(50)) returns varchar(250) deterministic
begin
  return concat(left(title,30),' - Region: ',region);
end;
//
delimiter ;
select Title, guideline_summary(Title,Region) as summary from Policy_Guidelines;

-- 38. UDF to check revision count
delimiter //
create function rev_count(rev text) returns int deterministic
begin
  return length(rev)-length(replace(rev,'Rev',''));
end;
//
delimiter ;
select Title, rev_count(Revision_History) as revisions from Policy_Guidelines;

-- 39. UDF to create document label
delimiter //
create function doc_label(title varchar(200)) returns varchar(250) deterministic
begin
  return concat('Policy: ',title);
end;
//
delimiter ;
select Title, doc_label(Title) as label from Policy_Guidelines;

-- 40. UDF to check old guideline
delimiter //
create function is_old(issue_date date) returns varchar(20) deterministic
begin
  if year(issue_date)<2018 then return 'Old'; else return 'Recent'; end if;
end;
//
delimiter ;
select Title, is_old(Date_Issued) as guideline_age_type from Policy_Guidelines;

-- 41. join with Diseases to get disease name
select pg.Title, d.Name as disease_name
from Policy_Guidelines pg
join Diseases d on pg.Disease_ID=d.DiseaseID;

-- 42. join with Health_Campaigns to find related campaigns
select pg.Title, hc.Name as campaign_name
from Policy_Guidelines pg
join Health_Campaigns hc on pg.Disease_ID=hc.Disease_ID;

-- 43. join with Health_Campaigns and Countries
select pg.Title, hc.Name as campaign_name, c.Name as country
from Policy_Guidelines pg
join Health_Campaigns hc on pg.Disease_ID=hc.Disease_ID
join Countries c on hc.Country_ID=c.CountryID;

-- 44. guidelines with campaigns started after 2020
select pg.Title, hc.Name as campaign_name
from Policy_Guidelines pg
join Health_Campaigns hc on pg.Disease_ID=hc.Disease_ID
where year(hc.Start_Date)>2020;

-- 45. guidelines with same region campaigns
select pg.Title, hc.Name as campaign_name, pg.Region
from Policy_Guidelines pg
join Health_Campaigns hc on pg.Disease_ID=hc.Disease_ID
where pg.Region='Africa';

-- 46. left join to include guidelines without campaigns
select pg.Title, hc.Name as campaign_name
from Policy_Guidelines pg
left join Health_Campaigns hc on pg.Disease_ID=hc.Disease_ID;

-- 47. right join to include campaigns without guidelines
select pg.Title, hc.Name as campaign_name
from Policy_Guidelines pg
right join Health_Campaigns hc on pg.Disease_ID=hc.Disease_ID;

-- 48. join to count campaigns per guideline
select pg.Title, count(hc.CamapignID) as total_campaigns
from Policy_Guidelines pg
left join Health_Campaigns hc on pg.Disease_ID=hc.Disease_ID
group by pg.Title;

-- 49. join with subquery to get guidelines with most campaigns
select pg.Title, (select count(*) from Health_Campaigns hc where hc.Disease_ID=pg.Disease_ID) as campaign_count
from Policy_Guidelines pg;

-- 50. join with filters for English guidelines and children campaigns
select pg.Title, hc.Name as campaign_name
from Policy_Guidelines pg
join Health_Campaigns hc on pg.Disease_ID=hc.Disease_ID
where pg.Language='English' and hc.Target_Group='Children';

-- Table-23 Countries_Health_Policies----------------------------------------------------------------------------------------
-- 1. Show policy titles with alias
select Title as Policy_Name from Countries_Health_Policies;

-- 2. Show country id and ministry name with alias
select Country_ID as Country, Ministry as Responsible_Ministry from Countries_Health_Policies;

-- 3. Show policy status as Current_Status
select Title, Status as Current_Status from Countries_Health_Policies;

-- 4. Show last reviewed date as Review_Date
select Title, Last_Reviewed as Review_Date from Countries_Health_Policies;

-- 5. Show implemented date and title with aliases
select Implemented_Date as Start_Date, Title as Policy_Title from Countries_Health_Policies;

-- 6. Alias for policy updater
select Updated_By as Editor, Title from Countries_Health_Policies;

-- 7. Notes with alias
select Title, Notes as Remarks from Countries_Health_Policies;

-- 8. Display title and status with alias
select Title as Policy, Status as Current_State from Countries_Health_Policies;

-- 9. Show policy id with alias
select PolicyID as ID, Title from Countries_Health_Policies;

-- 10. Show country and status with alias
select Country_ID as Country_Code, Status as Policy_Status from Countries_Health_Policies;

-- 11. Policies updated most recently
select * from Countries_Health_Policies
where Last_Reviewed = (select max(Last_Reviewed) from Countries_Health_Policies);

-- 12. Policies implemented before 2010
select * from Countries_Health_Policies
where Implemented_Date < (select min(Implemented_Date) from Countries_Health_Policies where Status='Active');

-- 13. Policies in countries with ID > 10
select * from Countries_Health_Policies
where Country_ID in (select CountryID from Countries where CountryID > 10);

-- 14. Policies reviewed after 2024-01-01
select * from Countries_Health_Policies
where Last_Reviewed > (select date('2024-01-01'));

-- 15. Active policies with earliest implementation date
select * from Countries_Health_Policies
where Implemented_Date = (select min(Implemented_Date) from Countries_Health_Policies where Status='Active');

-- 16. Policies updated by Dr. Neha Sharma
select * from Countries_Health_Policies
where Updated_By in (select Updated_By from Countries_Health_Policies where Updated_By='Dr. Neha Sharma');

-- 17. Policies of countries having at least one 'Ongoing' policy
select * from Countries_Health_Policies
where Country_ID in (select Country_ID from Countries_Health_Policies where Status='Ongoing');

-- 18. Policies reviewed before the earliest active policy
select * from Countries_Health_Policies
where Last_Reviewed < (select min(Last_Reviewed) from Countries_Health_Policies where Status='Active');

-- 19. Policies containing 'Health' in title using subquery
select * from Countries_Health_Policies
where PolicyID in (select PolicyID from Countries_Health_Policies where Title like '%Health%');

-- 20. Policies in top 5 countries by ID
select * from Countries_Health_Policies
where Country_ID <= (select max(Country_ID) from Countries_Health_Policies where Country_ID <=5);

-- 21. Length of policy title
select Title, length(Title) as Title_Length from Countries_Health_Policies;

-- 22. Uppercase ministry names
select Title, upper(Ministry) as Ministry_Upper from Countries_Health_Policies;

-- 23. Lowercase updated_by names
select Title, lower(Updated_By) as Updated_By_Lower from Countries_Health_Policies;

-- 24. Concatenate title and status
select concat(Title, ' - ', Status) as Title_Status from Countries_Health_Policies;

-- 25. Extract year from implemented date
select Title, year(Implemented_Date) as Year_Implemented from Countries_Health_Policies;

-- 26. Current date vs last reviewed
select Title, datediff(current_date, Last_Reviewed) as Days_Since_Review from Countries_Health_Policies;

-- 27. Find first 10 characters of policy text
select Title, left(Policy_Text, 10) as Preview from Countries_Health_Policies;

-- 28. Find last 10 characters of policy text
select Title, right(Policy_Text, 10) as Policy_End from Countries_Health_Policies;

-- 29. Count characters in notes
select Title, char_length(Notes) as Notes_Length from Countries_Health_Policies;

-- 30. Format implemented date
select Title, date_format(Implemented_Date, '%M %d, %Y') as Formatted_Date from Countries_Health_Policies;

-- 31. Returns the length of the policy title
delimiter //
create function policy_length(p_title varchar(200))
returns int
deterministic
begin
    return char_length(p_title);
end //
delimiter ;
select title, policy_length(title) as title_length from countries_health_policies;

-- 32. Checks if policy status is 'Active' and returns 'Yes' or 'No'
delimiter //
create function isactive(p_status varchar(50))
returns varchar(10)
deterministic
begin
    if p_status = 'Active' then
        return 'Yes';
    else
        return 'No';
    end if;
end //
delimiter ;
select title, isactive(status) as active_status from countries_health_policies;

-- 33. Returns the first 50 characters of the policy text
delimiter //
create function shorttext(p_text text)
returns varchar(100)
deterministic
begin
    return left(p_text, 50);
end //
delimiter ;
select title, shorttext(policy_text) as preview from countries_health_policies;

-- 34. Checks if the policy was implemented before a given date and returns 'Yes' or 'No'
delimiter //
create function implementedbefore(p_date date, p_compare date)
returns varchar(5)
deterministic
begin
    if p_date < p_compare then
        return 'Yes';
    else
        return 'No';
    end if;
end //
delimiter ;
select title, implementedbefore(implemented_date, '2015-01-01') as before_2015 from countries_health_policies;

-- 35. Calculates the number of days since the policy was last reviewed
delimiter //
create function dayssincereview(p_last_review date)
returns int
deterministic
begin
    return datediff(current_date, p_last_review);
end //
delimiter ;
select title, dayssincereview(last_reviewed) as days_since from countries_health_policies;

-- 36. Returns the initials of the ministry in uppercase
delimiter //
create function ministryinitials(p_ministry varchar(100))
returns varchar(20)
deterministic
begin
    declare result varchar(20) default '';
    declare word varchar(50);
    declare pos int default 1;
    while pos <= char_length(p_ministry) do
        set word = substring_index(substring_index(p_ministry, ' ', pos), ' ', -1);
        if word != '' then
            set result = concat(result, left(word, 1));
        end if;
        set pos = pos + 1;
    end while;
    return upper(result);
end //
delimiter ;
select title, ministryinitials(ministry) as abbrev from countries_health_policies;

-- 37. Categorizes policy age as 'Old', 'Moderate', or 'New' based on implemented date
delimiter //
create function policyagecategory(p_date date)
returns varchar(20)
deterministic
begin
    declare age int;
    set age = timestampdiff(year, p_date, current_date);
    if age >= 15 then
        return 'Old';
    elseif age >= 5 then
        return 'Moderate';
    else
        return 'New';
    end if;
end //
delimiter ;
select title, policyagecategory(implemented_date) as age_group from countries_health_policies;

-- 38. Returns the first 30 characters of the notes column
delimiter //
create function notessummary(p_notes text)
returns varchar(50)
deterministic
begin
    return left(p_notes, 30);
end //
delimiter ;
select title, notessummary(notes) as short_notes from countries_health_policies;

-- 39. Checks if the policy needs review (more than 365 days since last review) and returns 'Yes' or 'No'
delimiter //
create function needsreview(p_last_review date)
returns varchar(5)
deterministic
begin
    if datediff(current_date, p_last_review) > 365 then
        return 'Yes';
    else
        return 'No';
    end if;
end //
delimiter ;
select title, needsreview(last_reviewed) as review_need from countries_health_policies;

-- 40. Formats updated_by name as 'LastName, FirstName'
delimiter //
create function formatname(p_name varchar(100))
returns varchar(100)
deterministic
begin
    declare first_name varchar(50);
    declare last_name varchar(50);
    set first_name = substring_index(p_name, ' ', 1);
    set last_name = substring_index(p_name, ' ', -1);
    return concat(last_name, ', ', first_name);
end //
delimiter ;
select title, formatname(updated_by) as formatted_editor from countries_health_policies;

-- 41. Join with Countries to get country name
select CHP.Title, C.Name as Country_Name
from Countries_Health_Policies CHP
join Countries C on CHP.Country_ID = C.CountryID;

-- 42. Join with Diseases (via Disease_ID) if applicable
select CHP.Title, D.Name as Disease_Name
from Countries_Health_Policies CHP
join Diseases D on CHP.Disease_ID = D.DiseaseID;

-- 43. Left join with Countries to show all policies even if country missing
select CHP.Title, C.Name as Country_Name
from Countries_Health_Policies CHP
left join Countries C on CHP.Country_ID = C.CountryID;

-- 44. Join to show policy title and country region
select CHP.Title, C.Region
from Countries_Health_Policies CHP
join Countries C on CHP.Country_ID = C.CountryID;

-- 45. Inner join to show ministry and country name
select CHP.Ministry, C.Name as Country_Name
from Countries_Health_Policies CHP
join Countries C on CHP.Country_ID = C.CountryID;

-- 46. Join to count policies per country
select C.Name, count(CHP.PolicyID) as Policies_Count
from Countries C
join Countries_Health_Policies CHP on C.CountryID = CHP.Country_ID
group by C.Name;

-- 47. Join to get status along with country name
select CHP.Title, CHP.Status, C.Name as Country_Name
from Countries_Health_Policies CHP
join Countries C on CHP.Country_ID = C.CountryID;

-- 48. Join with Health_Campaigns via Country_ID
select CHP.Title, HC.Name as Campaign_Name
from Countries_Health_Policies CHP
join Health_Campaigns HC on CHP.Country_ID = HC.Country_ID;

-- 49. Join with Funding table to see funding for policy country
select CHP.Title, F.Amount, F.Currency
from Countries_Health_Policies CHP
join Funding F on CHP.Country_ID = F.Country_ID;

-- 50. Join with Fund_Distribution
select CHP.Title, FD.Amount, FD.Date_Allocated
from Countries_Health_Policies CHP
join Fund_Distribution FD on CHP.Country_ID = FD.Country_ID;

-- Table-24 Global_Health_Alerts---------------------------------------------------------------------------------------------
-- 1. Show alert title with shortened alias
select title as alert_title, alert_level as level from global_health_alerts;

-- 2. Show region affected with alias
select region_affected as affected_region, date_issued as issued_on from global_health_alerts;

-- 3. Alias for expiry date
select title, expiry_date as valid_until from global_health_alerts;

-- 4. Alias for disease id
select title, disease_id as disease_code from global_health_alerts;

-- 5. Combine title and level with alias
select concat(title, ' - ', alert_level) as alert_info from global_health_alerts;

-- 6. Alias for description
select title, description as alert_description from global_health_alerts;

-- 7. Alias for notes
select title, notes as remarks from global_health_alerts;

-- 8. Alias for source
select title, source as alert_source from global_health_alerts;

-- 9. Alias for region and level combined
select region_affected as region, alert_level as level from global_health_alerts;

-- 10. Alias with formatted date
select title, date_issued as issued_date, expiry_date as ends_on from global_health_alerts;

-- 11. Alerts with highest alert level (critical)
select title, alert_level from global_health_alerts 
where alert_level = (select max(alert_level) from global_health_alerts);

-- 12. Alerts issued after earliest date
select title, date_issued from global_health_alerts 
where date_issued > (select min(date_issued) from global_health_alerts);

-- 13. Alerts with expiry after latest expiry
select title, expiry_date from global_health_alerts 
where expiry_date = (select max(expiry_date) from global_health_alerts);

-- 14. Count of alerts per disease using subquery
select disease_id, (select count(*) from global_health_alerts g2 where g2.disease_id = g1.disease_id) as alert_count
from global_health_alerts g1 group by disease_id;

-- 15. Alerts in regions with more than 2 alerts
select title, region_affected from global_health_alerts 
where region_affected in (select region_affected from global_health_alerts group by region_affected having count(*) > 2);

-- 16. Alerts issued in last 2 years
select title, date_issued from global_health_alerts 
where date_issued > (select date_sub(max(date_issued), interval 2 year) from global_health_alerts);

-- 17. Alerts with description longer than average
select title, description from global_health_alerts
where char_length(description) > (select avg(char_length(description)) from global_health_alerts);

-- 18. Alerts with level equal to second highest level
select title, alert_level from global_health_alerts 
where alert_level = (select distinct alert_level from global_health_alerts order by alert_level desc limit 1,1);

-- 19. Alerts from sources with multiple alerts
select title, source from global_health_alerts 
where source in (select source from global_health_alerts group by source having count(*)>1);

-- 20. Alerts issued before median date
select title, date_issued from global_health_alerts
where date_issued < (select date_issued from global_health_alerts order by date_issued limit 1 offset 1);

-- 21. Length of alert title
select title, char_length(title) as title_length from global_health_alerts;

-- 22. Uppercase alert level
select title, upper(alert_level) as level_upper from global_health_alerts;

-- 23. Lowercase region
select title, lower(region_affected) as region_lower from global_health_alerts;

-- 24. Days until expiry
select title, datediff(expiry_date, current_date) as days_remaining from global_health_alerts;

-- 25. Concatenate title and source
select concat(title, ' [', source, ']') as full_alert_info from global_health_alerts;

-- 26. Extract year from date issued
select title, year(date_issued) as issued_year from global_health_alerts;

-- 27. Extract month from expiry date
select title, month(expiry_date) as expiry_month from global_health_alerts;

-- 28. Left function on description
select title, left(description, 50) as short_description from global_health_alerts;

-- 29. Right function on notes
select title, right(notes, 20) as notes_end from global_health_alerts;

-- 30. Find position of word 'risk' in description
select title, instr(description, 'risk') as risk_pos from global_health_alerts;

-- 31. Convert alert level to numeric severity
delimiter //
create function alertseveritylevel(p_level varchar(50))
returns int
deterministic
begin
    if p_level = 'Low' then
        return 1;
    elseif p_level = 'Moderate' then
        return 2;
    elseif p_level = 'High' then
        return 3;
    elseif p_level = 'Critical' then
        return 4;
    else
        return 0;
    end if;
end //
delimiter ;
select title, alertseveritylevel(alert_level) as severity from global_health_alerts;

-- 32. Short preview of description
delimiter //
create function shortdesc(p_text text)
returns varchar(50)
deterministic
begin
    return left(p_text, 50);
end //
delimiter ;
select title, shortdesc(description) as preview from global_health_alerts;

-- 33. Days since alert issued
delimiter //
create function dayssinceissued(p_date date)
returns int
deterministic
begin
    return datediff(current_date, p_date);
end //
delimiter ;
select title, dayssinceissued(date_issued) as days_since from global_health_alerts;

-- 34. Check if alert is expired
delimiter //
create function isexpired(p_expiry date)
returns varchar(5)
deterministic
begin
    if p_expiry < current_date then
        return 'Yes';
    else
        return 'No';
    end if;
end //
delimiter ;
select title, isexpired(expiry_date) as expired from global_health_alerts;

-- 35. First 3 letters of region
delimiter //
create function regionprefix(p_region varchar(100))
returns varchar(3)
deterministic
begin
    return left(p_region, 3);
end //
delimiter ;
select title, regionprefix(region_affected) as region_code from global_health_alerts;

-- 36. Notes summary
delimiter //
create function notessummary(p_notes text)
returns varchar(50)
deterministic
begin
    return left(p_notes, 30);
end //
delimiter ;
select title, notessummary(notes) as short_notes from global_health_alerts;

-- 37. Classify alert as immediate or normal
delimiter //
create function alertpriority(p_start date, p_end date)
returns varchar(10)
deterministic
begin
    if datediff(p_end, current_date) <= 7 then
        return 'Immediate';
    else
        return 'Normal';
    end if;
end //
delimiter ;
select title, alertpriority(date_issued, expiry_date) as priority from global_health_alerts;

-- 38. Format source name
delimiter //
create function formatname(p_source varchar(100))
returns varchar(100)
deterministic
begin
    declare first_word varchar(50);
    declare last_word varchar(50);
    set first_word = substring_index(p_source, ' ', 1);
    set last_word = substring_index(p_source, ' ', -1);
    return concat(last_word, ', ', first_word);
end //
delimiter ;
select title, formatname(source) as source_formatted from global_health_alerts;

-- 39. Alert age category
delimiter //
create function alertagecategory(p_date date)
returns varchar(20)
deterministic
begin
    declare age int;
    set age = timestampdiff(year, p_date, current_date);
    if age >= 3 then
        return 'Old';
    elseif age >= 1 then
        return 'Moderate';
    else
        return 'New';
    end if;
end //
delimiter ;
select title, alertagecategory(date_issued) as age_group from global_health_alerts;

-- 40. Combine title and region using udf
delimiter //
create function titlewithregion(p_title varchar(200), p_region varchar(100))
returns varchar(300)
deterministic
begin
    return concat(p_title, ' [', p_region, ']');
end //
delimiter ;
select title, titlewithregion(title, region_affected) as full_info from global_health_alerts;

-- 41. Join with Diseases to get disease name
select g.title, d.name as disease_name 
from global_health_alerts g join diseases d on g.disease_id = d.diseaseid;

-- 42. Alerts with programs (assuming programs table)
select g.title, p.program_name 
from global_health_alerts g join programs p on g.disease_id = p.disease_id;

-- 43. Alerts with country policies
select g.title, c.title as policy_title 
from global_health_alerts g 
join countries_health_policies c on g.disease_id = c.disease_id;

-- 44. Alerts with funding info
select g.title, f.amount, f.currency 
from global_health_alerts g 
join funding f on g.disease_id = f.program_id;

-- 45. Alerts with campaign info
select g.title, h.name as campaign_name 
from global_health_alerts g 
join health_campaigns h on g.disease_id = h.disease_id;

-- 46. Alerts with policy guidelines
select g.title, p.title as guideline_title 
from global_health_alerts g 
join policy_guidelines p on g.disease_id = p.disease_id;

-- 47. Alerts with distribution info
select g.title, fd.amount as distributed_amount 
from global_health_alerts g 
join fund_distribution fd on g.disease_id = fd.program_id;

-- 48. Alerts with countries' health policies
select g.title, chp.title as country_policy 
from global_health_alerts g 
join countries_health_policies chp on g.disease_id = chp.disease_id;

-- 49. Alerts with alerts from same region
select g1.title, g2.title as other_alerts_same_region 
from global_health_alerts g1 
join global_health_alerts g2 on g1.region_affected = g2.region_affected and g1.alertid <> g2.alertid;

-- 50. Alerts with disease name and alert level
select g.title, d.name as disease_name, g.alert_level 
from global_health_alerts g join diseases d on g.disease_id = d.diseaseid;

-- Table-25 Collaborating_Organizations--------------------------------------------------------------------------------------
-- 1. Show org name as organization
select name as organization from collaborating_organizations;

-- 2. Show type as org_type
select name, type as org_type from collaborating_organizations;

-- 3. Country id with alias
select name, country_id as country_ref from collaborating_organizations;

-- 4. Partnership date with alias
select name, partnership_date as joined_on from collaborating_organizations;

-- 5. Area_of_Work with alias
select name, area_of_work as focus_area from collaborating_organizations;

-- 6. Notes with alias
select name, notes as remarks from collaborating_organizations;

-- 7. Email and phone with aliases
select contact_email as email, phone as contact_number from collaborating_organizations;

-- 8. Website alias
select name, website as web_link from collaborating_organizations;

-- 9. Combine name and type using alias
select name as organization, type as organization_type from collaborating_organizations;

-- 10. OrgID alias
select orgid as organization_id, name from collaborating_organizations;

-- 11. Latest partnership date
select name, partnership_date from collaborating_organizations
where partnership_date = (select max(partnership_date) from collaborating_organizations);

-- 12. Earliest partnership
select name, partnership_date from collaborating_organizations
where partnership_date = (select min(partnership_date) from collaborating_organizations);

-- 13. Org in country with max orgs
select name, country_id from collaborating_organizations
where country_id = (select country_id from collaborating_organizations group by country_id order by count(*) desc limit 1);

-- 14. Organizations with type 'Research'
select name from collaborating_organizations
where type = (select type from collaborating_organizations where orgid = 3);

-- 15. Org with longest area_of_work string
select name, area_of_work from collaborating_organizations
where char_length(area_of_work) = (select max(char_length(area_of_work)) from collaborating_organizations);

-- 16. Org with latest notes entry
select name, notes from collaborating_organizations
where length(notes) = (select max(length(notes)) from collaborating_organizations);

-- 17. Organizations after year 2010
select name, partnership_date from collaborating_organizations
where year(partnership_date) > (select 2010);

-- 18. Count of orgs per country using subquery
select country_id, (select count(*) from collaborating_organizations c2 where c2.country_id = c1.country_id) as org_count
from collaborating_organizations c1
group by country_id;

-- 19. Org with specific email pattern
select name from collaborating_organizations
where contact_email = (select contact_email from collaborating_organizations where name like '%CDC%');

-- 20. Organization with earliest phone number in alphanumeric order
select name, phone from collaborating_organizations
where phone = (select min(phone) from collaborating_organizations);

-- 21. Length of organization name
select name, char_length(name) as name_length from collaborating_organizations;

-- 22. Uppercase names
select name, upper(name) as name_upper from collaborating_organizations;

-- 23. Lowercase emails
select contact_email, lower(contact_email) as email_lower from collaborating_organizations;

-- 24. Date formatted
select name, date_format(partnership_date, '%d-%m-%Y') as formatted_date from collaborating_organizations;

-- 25. Year of partnership
select name, year(partnership_date) as year_joined from collaborating_organizations;

-- 26. Month of partnership
select name, month(partnership_date) as month_joined from collaborating_organizations;

-- 27. Reverse org name
select name, reverse(name) as reversed_name from collaborating_organizations;

-- 28. Concatenate name and area_of_work
select name, concat(name, ' - ', area_of_work) as name_area from collaborating_organizations;

-- 29. Substring of website
select name, substring(website, 1, 20) as short_website from collaborating_organizations;

-- 30. Replace in notes
select name, replace(notes, 'WHO', 'World Health Organization') as updated_notes from collaborating_organizations;

-- 31. Get initials of organization name
delimiter //
create function org_initials(p_name varchar(100))
returns varchar(20)
deterministic
begin
    declare result varchar(20) default '';
    declare word varchar(50);
    declare pos int default 1;
    while pos <= char_length(p_name) do
        set word = substring_index(substring_index(p_name, ' ', pos), ' ', -1);
        if word != '' then
            set result = concat(result, left(word, 1));
        end if;
        set pos = pos + 1;
    end while;
    return upper(result);
end //
delimiter ;
select name, org_initials(name) as initials from collaborating_organizations;

-- 32. Check if organization is active (based on 'Active' in notes)
delimiter //
create function isactiveorg(p_notes text)
returns varchar(5)
deterministic
begin
    if p_notes like '%Active%' then
        return 'Yes';
    else
        return 'No';
    end if;
end //
delimiter ;
select name, isactiveorg(notes) as active_status from collaborating_organizations;

-- 33. Short preview of notes
delimiter //
create function notes_preview(p_notes text)
returns varchar(50)
deterministic
begin
    return left(p_notes, 30);
end //
delimiter ;
select name, notes_preview(notes) as preview from collaborating_organizations;

-- 34. Years since partnership
delimiter //
create function years_since_partnership(p_date date)
returns int
deterministic
begin
    return timestampdiff(year, p_date, current_date);
end //
delimiter ;
select name, years_since_partnership(partnership_date) as years_active from collaborating_organizations;

-- 35. Email domain
delimiter //
create function email_domain(p_email varchar(100))
returns varchar(50)
deterministic
begin
    return substring_index(p_email, '@', -1);
end //
delimiter ;
select name, email_domain(contact_email) as domain from collaborating_organizations;

-- 36. Format phone number (remove non-digit characters)
delimiter //
create function format_phone(p_phone varchar(20))
returns varchar(20)
deterministic
begin
    declare result varchar(20) default '';
    declare i int default 1;
    while i <= char_length(p_phone) do
        if substring(p_phone,i,1) between '0' and '9' then
            set result = concat(result, substring(p_phone,i,1));
        end if;
        set i = i + 1;
    end while;
    return result;
end //
delimiter ;
select name, format_phone(phone) as formatted_phone from collaborating_organizations;

-- 37. Area word count
delimiter //
create function area_word_count(p_area varchar(100))
returns int
deterministic
begin
    return length(trim(p_area)) - length(replace(trim(p_area),' ','') ) + 1;
end //
delimiter ;
select name, area_word_count(area_of_work) as area_count from collaborating_organizations;

-- 38. Partnership decade
delimiter //
create function partnership_decade(p_date date)
returns varchar(10)
deterministic
begin
    return concat(floor(year(p_date)/10)*10,'s');
end //
delimiter ;
select name, partnership_decade(partnership_date) as decade from collaborating_organizations;

-- 39. Notes length
delimiter //
create function notes_length(p_notes text)
returns int
deterministic
begin
    return char_length(p_notes);
end //
delimiter ;
select name, notes_length(notes) as note_chars from collaborating_organizations;

-- 40. Combine name and country id
delimiter //
create function name_with_country(p_name varchar(100), p_country int)
returns varchar(150)
deterministic
begin
    return concat(p_name, ' (Country ID: ', p_country, ')');
end //
delimiter ;
select name, name_with_country(name, country_id) as full_info from collaborating_organizations;

-- 41. Join with Countries to get country name
select c.name as org_name, co.country_name from collaborating_organizations c
join countries co on c.country_id = co.countryid;

-- 42. Join to find orgs in specific country
select c.name, co.country_name from collaborating_organizations c
join countries co on c.country_id = co.countryid
where co.country_name = 'India';

-- 43. Join to get org name and region from Countries
select c.name as org_name, co.region from collaborating_organizations c
join countries co on c.country_id = co.countryid;

-- 44. Count orgs per country using join
select co.country_name, count(c.orgid) as total_orgs from collaborating_organizations c
join countries co on c.country_id = co.countryid
group by co.country_name;

-- 45. Join to filter NGOs
select c.name, co.country_name from collaborating_organizations c
join countries co on c.country_id = co.countryid
where c.type = 'NGO';

-- 46. Join with disease alerts (example)
select c.name, g.title as alert_title from collaborating_organizations c
join global_health_alerts g on c.country_id = g.disease_id;

-- 47. Join to get org and income level of country
select c.name, co.income_level from collaborating_organizations c
join countries co on c.country_id = co.countryid;

-- 48. Join with policy table (example)
select c.name, p.title as policy_title from collaborating_organizations c
join countries_health_policies p on c.country_id = p.country_id;

-- 49. Join to get org name and continent
select c.name, co.continent from collaborating_organizations c
join countries co on c.country_id = co.countryid;

-- 50. Join multiple tables (country + policies)
select c.name, co.country_name, p.title as policy_title from collaborating_organizations c
join countries co on c.country_id = co.countryid
join countries_health_policies p on c.country_id = p.country_id;