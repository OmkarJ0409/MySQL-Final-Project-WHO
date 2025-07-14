-- ----------------------------------------- Database Queries ---------------------------------------------------------------
-- create a database first
create database who;

-- to work on this database, you need to use it first
use who;

-- --------------------------------------- Database Analysis ----------------------------------------------------------------
/*
T1  : Countries(CountryID, Name, Region, Population, AreaSqKm, Capital, Currency, Language, IncomeLevel, UNMember)

T2  : Diseases(DiseaseID, Name, Type, ICDCode, SeverityLevel, VaccineAvailable, OriginCountry, FirstReportedYear, TransmissionMode, Symptoms)

T3  : Disease_Cases(CaseID, CountryID, DiseaseID, ReportDate, ConfirmedCases, Deaths, Recoveries, ActiveCases, Source, Notes)

T4  : Vaccines(VaccineID, Name, Manufacturer, DiseaseID, ApprovalDate, DosesRequired, StorageTemp, Efficacy, SideEffects, Status)

T5  : Vaccination_Records(RecordID, CountryID, VaccineID, ReportDate, TotalVaccinated, FullyVaccinated, BoosterDoses, AgeGroup, Gender, CampaignName)

T6  : Hospitals(HospitalID, Name, CountryID, City, Capacity, Contact, Type, Public, EstablishedYear, Accreditation)

T7  : Doctors(DoctorID, Name, HospitalID, Specialty, YearsExperience, Gender, Email, Phone, Available, Nationality)

T8  : Health_Workers(WorkerID, Name, Role, HospitalID, CountryID, YearsExperience, Gender, Email, Phone, Status)

T9  : Outbreaks(OutbreakID, DiseaseID, CountryID, StartDate, EndDate, Severity, Region, Source, Controlled, Notes)

T10 : Emergency_Responses(ResponseID, OutbreakID, StartDate, EndDate, TeamsDeployed, SuppliesSent, Cost, PartnerOrgs, Status, Coordinator)

T11 : Programs(ProgramID, Name, FocusArea, StartYear, Global, Objective, Status, Budget, PartnerOrgs, Manager)

T12 : Program_Participation(ParticipationID, ProgramID, CountryID, StartDate, EndDate, Status, Coordinator, FundingReceived, ImpactRating, Comments)

T13 : Labs(LabID, Name, CountryID, City, Type, Capacity, Accredited, ISO_Certified, Contact, EstablishedYear)

T14 : Lab_Tests(TestID, LabID, DiseaseID, TestDate, SamplesTested, Positives, Negatives, TestType, Method, Notes)

T15 : Reports(ReportID, Title, Topic, Author, DatePublished, Summary, Language, Region, Reviewed, URL)

T16 : Research_Projects(ProjectID, Title, CountryID, LeadResearcher, StartDate, EndDate, Status, Budget, AreaOfFocus, SponsorOrg)

T17 : Medicines(MedicineID, Name, UsedFor, Manufacturer, ApprovalDate, SideEffects, DosageInfo, Availability, ExpiryYears, WHOApproved)

T18 : Health_Indicators(IndicatorID, CountryID, Year, LifeExpectancy, InfantMortality, HealthExpenditurePerCapita, AccessToSanitation, DoctorPatientRatio, ChildMortalityRate, SmokingRate)

T19 : Funding(FundID, Source, Type, Amount, Currency, Year, CountryID, Purpose, ProgramID, Notes)

T20 : Fund_Distribution(DistributionID, FundID, CountryID, ProgramID, Amount, DateAllocated, ApprovedBy, Status, Remarks, TrackingID)

T21 : Health_Campaigns(CampaignID, Name, DiseaseID, CountryID, StartDate, EndDate, TargetGroup, Medium, ReachEstimate, Feedback)

T22 : Policy_Guidelines(GuidelineID, Title, DiseaseID, DateIssued, DocumentURL, Language, Region, ApprovedBy, Description, RevisionHistory)

T23 : Countries_Health_Policies(PolicyID, CountryID, Title, ImplementedDate, PolicyText, Status, LastReviewed, Ministry, UpdatedBy, Notes)

T24 : Global_Health_Alerts(AlertID, Title, DateIssued, RegionAffected, AlertLevel, DiseaseID, Description, Source, ExpiryDate, Notes)

T25 : Collaborating_Organizations(OrgID, Name, Type, CountryID, ContactEmail, Phone, Website, PartnershipDate, AreaOfWork, Notes)
*/

-- Table-1 Countries---------------------------------------------------------------------------------------------------------
create table Countries(
CountryID int primary key,
Name varchar(100) not null unique,
Region varchar(50) not null,
Population bigint check( Population >= 0),
AreaSqKm double,
Capital varchar(100) not null,
Currency varchar(50),
Language varchar(50),
Income_Level varchar(50) check (Income_level in ('Low','Middle','High')),
UN_Member varchar(3) default 'Yes' check (UN_Member in ('Yes', 'No'))
);

-- Data for Countries
insert into Countries 
(CountryID, Name, Region, Population, AreaSqKm, Capital, Currency, Language, Income_Level, UN_Member)
values
(1, 'India', 'South-East Asia', 1400000000, 3287263, 'New Delhi', 'INR', 'Hindi', 'Middle', 'Yes'),
(2, 'United States', 'Americas', 331000000, 9833517, 'Washington D.C.', 'USD', 'English', 'High', 'Yes'),
(3, 'Brazil', 'Americas', 213000000, 8515767, 'Brasília', 'BRL', 'Portuguese', 'Middle', 'Yes'),
(4, 'China', 'Western Pacific', 1440000000, 9596961, 'Beijing', 'CNY', 'Mandarin', 'Middle', 'Yes'),
(5, 'Nigeria', 'Africa', 206000000, 923768, 'Abuja', 'NGN', 'English', 'Low', 'Yes'),
(6, 'Germany', 'Europe', 83000000, 357386, 'Berlin', 'EUR', 'German', 'High', 'Yes'),
(7, 'France', 'Europe', 67000000, 551695, 'Paris', 'EUR', 'French', 'High', 'Yes'),
(8, 'Japan', 'Western Pacific', 126000000, 377975, 'Tokyo', 'JPY', 'Japanese', 'High', 'Yes'),
(9, 'South Africa', 'Africa', 60000000, 1219090, 'Pretoria', 'ZAR', 'English', 'Middle', 'Yes'),
(10, 'Russia', 'Europe', 146000000, 17098242, 'Moscow', 'RUB', 'Russian', 'Middle', 'Yes'),
(11, 'Australia', 'Western Pacific', 25000000, 7692024, 'Canberra', 'AUD', 'English', 'High', 'Yes'),
(12, 'Bangladesh', 'South-East Asia', 165000000, 147570, 'Dhaka', 'BDT', 'Bengali', 'Low', 'Yes'),
(13, 'Mexico', 'Americas', 128000000, 1964375, 'Mexico City', 'MXN', 'Spanish', 'Middle', 'Yes'),
(14, 'Canada', 'Americas', 38000000, 9984670, 'Ottawa', 'CAD', 'English/French', 'High', 'Yes'),
(15, 'Italy', 'Europe', 60000000, 301340, 'Rome', 'EUR', 'Italian', 'High', 'Yes'),
(16, 'Pakistan', 'South-East Asia', 220000000, 881913, 'Islamabad', 'PKR', 'Urdu', 'Low', 'Yes'),
(17, 'Indonesia', 'South-East Asia', 273000000, 1904569, 'Jakarta', 'IDR', 'Indonesian', 'Middle', 'Yes'),
(18, 'Argentina', 'Americas', 45000000, 2780400, 'Buenos Aires', 'ARS', 'Spanish', 'Middle', 'Yes'),
(19, 'United Kingdom', 'Europe', 67000000, 243610, 'London', 'GBP', 'English', 'High', 'Yes'),
(20, 'Ethiopia', 'Africa', 118000000, 1104300, 'Addis Ababa', 'ETB', 'Amharic', 'Low', 'Yes');

-- to display table data
select * from Countries;
-- to remove complete records from table
truncate table Countries;
-- to remove complete records and attributes from table
drop table if exists Countries;


-- Table-2 Diseases----------------------------------------------------------------------------------------------------------
create table Diseases(
DiseaseID int primary key,
Name varchar(100) not null,
Type varchar(50),
ICDCode varchar(20) unique,
Severity_Level varchar(20) check (Severity_Level in ('Low','Medium','High','Critical')),
Vaccine_Available boolean,
Origin_Country varchar(100),
First_Reported_Year date check (First_Reported_Year >= '1700-01-01'),
Transmission_Mode varchar(100),
Symptome text
);

-- Data for Diseases
insert into Diseases 
(DiseaseID, Name, Type, ICDCode, Severity_Level, Vaccine_Available, Origin_Country, First_Reported_Year, Transmission_Mode, Symptome) 
values
(1, 'COVID-19', 'Viral', 'U07.1', 'Critical', TRUE, 'China', '2019-12-01', 'Airborne, Droplets', 'Fever, Cough, Fatigue, Loss of taste'),
(2, 'Malaria', 'Parasitic', 'B50', 'High', FALSE, 'Africa', '1880-01-01', 'Mosquito bite', 'Fever, Chills, Sweating'),
(3, 'Tuberculosis', 'Bacterial', 'A15', 'High', TRUE, 'Germany', '1882-03-24', 'Airborne', 'Coughing, Chest pain, Weight loss'),
(4, 'Influenza', 'Viral', 'J10', 'Medium', TRUE, 'Italy', '1933-01-01', 'Airborne, Droplets', 'Fever, Sore throat, Body aches'),
(5, 'HIV/AIDS', 'Viral', 'B20', 'Critical', FALSE, 'USA', '1981-06-05', 'Blood, Sexual contact', 'Fatigue, Weight loss, Infections'),
(6, 'Cholera', 'Bacterial', 'A00', 'High', TRUE, 'India', '1817-01-01', 'Contaminated water', 'Severe diarrhea, Dehydration'),
(7, 'Dengue', 'Viral', 'A90', 'High', FALSE, 'Philippines', '1953-01-01', 'Mosquito bite', 'Fever, Rash, Joint pain'),
(8, 'Ebola', 'Viral', 'A98.4', 'Critical', FALSE, 'Democratic Republic of Congo', '1976-01-01', 'Contact with body fluids', 'Fever, Bleeding, Weakness'),
(9, 'Zika Virus', 'Viral', 'A92.5', 'Medium', FALSE, 'Uganda', '1947-01-01', 'Mosquito bite', 'Fever, Rash, Headache'),
(10, 'MERS', 'Viral', 'U04.9', 'Critical', FALSE, 'Saudi Arabia', '2012-09-01', 'Airborne, Droplets', 'Fever, Cough, Shortness of breath'),
(11, 'Measles', 'Viral', 'B05', 'High', TRUE, 'France', '1765-01-01', 'Airborne', 'Rash, Fever, Cough'),
(12, 'Polio', 'Viral', 'A80', 'High', TRUE, 'USA', '1908-01-01', 'Fecal-oral', 'Paralysis, Muscle weakness'),
(13, 'Tetanus', 'Bacterial', 'A35', 'High', TRUE, 'Global', '1809-01-01', 'Contaminated wounds', 'Muscle stiffness, Lockjaw'),
(14, 'Hepatitis B', 'Viral', 'B16', 'High', TRUE, 'USA', '1965-01-01', 'Blood, Sexual contact', 'Fatigue, Jaundice, Nausea'),
(15, 'Yellow Fever', 'Viral', 'A95', 'High', TRUE, 'Africa', '1800-01-01', 'Mosquito bite', 'Fever, Jaundice, Muscle pain'),
(16, 'Leprosy', 'Bacterial', 'A30', 'Medium', FALSE, 'India', '1873-01-01', 'Prolonged contact', 'Skin lesions, Nerve damage'),
(17, 'Mumps', 'Viral', 'B26', 'Medium', TRUE, 'UK', '1934-01-01', 'Droplets', 'Swollen glands, Fever, Headache'),
(18, 'Rabies', 'Viral', 'A82', 'Critical', TRUE, 'USA', '1885-01-01', 'Animal bite', 'Fever, Anxiety, Hydrophobia'),
(19, 'Typhoid Fever', 'Bacterial', 'A01.0', 'High', TRUE, 'India', '1880-01-01', 'Contaminated food/water', 'Fever, Abdominal pain, Rash'),
(20, 'Hepatitis C', 'Viral', 'B17.1', 'High', FALSE, 'USA', '1989-01-01', 'Blood contact', 'Fatigue, Dark urine, Abdominal pain');

-- to display table data
select * from Diseases;
-- to remove complete records from table
truncate table Diseases;
-- to remove complete records and attributes from table
drop table if exists Diseases;

-- Table-3 Disease_Cases-----------------------------------------------------------------------------------------------------
create table Disease_Cases(
CaseID int primary key,
Country_ID int not null,
Disease_ID int not null,
Report_Date date,
Confirmed_Cases int check (Confirmed_Cases >= 0),
Deaths int default 0,
Recoveries int default 0,
Active_Cases int,
Source varchar(100),
Notes text,
foreign key (Country_ID) references Countries(CountryID),
foreign key (Disease_ID) references Diseases(DiseaseID)
);

-- Data for Disease_Cases
insert into Disease_Cases 
(CaseID, Country_ID, Disease_ID, Report_Date, Confirmed_Cases, Deaths, Recoveries, Active_Cases, Source, Notes)
values
(1, 1, 1, '2020-03-15', 100000, 2000, 80000, 18000, 'Ministry of Health India', 'Initial surge of COVID-19 cases'),
(2, 2, 1, '2020-04-10', 500000, 25000, 300000, 175000, 'CDC USA', 'COVID-19 second wave begins'),
(3, 3, 2, '2021-06-01', 12000, 500, 10000, 1500, 'Brazil Health Dept', 'Rise in malaria in Amazon region'),
(4, 4, 4, '2022-01-05', 30000, 120, 29500, 380, 'China CDC', 'Winter influenza cases reported'),
(5, 5, 6, '2019-07-20', 8000, 100, 7000, 900, 'Nigeria MOH', 'Cholera outbreak in Lagos'),
(6, 6, 3, '2018-09-10', 15000, 300, 14000, 700, 'Robert Koch Institute', 'Tuberculosis resurgence in Berlin'),
(7, 7, 11, '2021-05-02', 1000, 5, 990, 5, 'France WHO Office', 'Measles spike due to vaccine hesitancy'),
(8, 8, 8, '2014-10-15', 300, 250, 30, 20, 'South Africa Press', 'Ebola imported case managed'),
(9, 9, 7, '2023-03-17', 10000, 20, 9000, 980, 'SA Health Dept', 'Dengue outbreak in urban areas'),
(10, 10, 5, '2000-12-25', 50000, 30000, 10000, 10000, 'Russia MOH', 'HIV/AIDS pandemic era report'),
(11, 11, 9, '2021-09-01', 400, 0, 390, 10, 'Australia CDC', 'Zika virus case tracked from travel'),
(12, 12, 12, '2010-06-15', 700, 10, 600, 90, 'Bangladesh Govt', 'Polio vaccination efforts tracked'),
(13, 13, 19, '2019-04-10', 600, 20, 500, 80, 'Mexico Health Watch', 'Typhoid fever from water crisis'),
(14, 14, 14, '2022-08-20', 1500, 5, 1450, 45, 'Canada Health Services', 'Hepatitis B reported in community spread'),
(15, 15, 13, '2023-11-11', 90, 2, 70, 18, 'Italy Health Dept', 'Tetanus exposure through injuries'),
(16, 16, 16, '2021-01-19', 250, 1, 220, 29, 'Pakistan Disease Control', 'Leprosy tracking in tribal zones'),
(17, 17, 10, '2020-06-01', 60, 10, 30, 20, 'Indonesia Health Agency', 'MERS-CoV case imported from Middle East'),
(18, 18, 20, '2023-02-23', 500, 5, 450, 45, 'Argentina National Lab', 'Hepatitis C patient data recorded'),
(19, 19, 17, '2015-03-05', 1200, 2, 1190, 8, 'UK NHS', 'Mumps outbreak in university students'),
(20, 20, 18, '2022-10-10', 10, 9, 0, 1, 'Ethiopia Health Bureau', 'Rabies from animal bite cases tracked');

-- to display table data
select * from Disease_Cases;
-- to remove complete records from table
truncate table Disease_Cases;
-- to remove complete records and attributes from table
drop table if exists Disease_Cases;


-- Table-4 Vaccines----------------------------------------------------------------------------------------------------------
create table Vaccines(
VaccineID int primary key,
Name varchar(100) not null,
Manufacturer varchar(100),
Disease_ID int not null,
Approval_Date date,
Doses_Required int check (Doses_Required >= 1),
Storage_Temp varchar(50),
Efficacy float check (Efficacy between 0 and 100),
Side_Effects text,
Status varchar(50) default 'Approved',
foreign key (Disease_ID) references Diseases(DiseaseID)
);

-- Data for Vaccines
insert into Vaccines 
(VaccineID, Name, Manufacturer, Disease_ID, Approval_Date, Doses_Required, Storage_Temp, Efficacy, Side_Effects, Status) 
values 
(1, 'Covishield', 'Serum Institute of India', 1, '2021-01-16', 2, '2-8°C', 70.0, 'Fatigue, Fever, Headache', 'Approved'),
(2, 'Pfizer-BioNTech', 'Pfizer', 1, '2020-12-11', 2, '-70°C', 95.0, 'Chills, Muscle pain', 'Approved'),
(3, 'BCG Vaccine', 'SSI Denmark', 3, '1921-07-01', 1, '2-8°C', 78.0, 'Redness, Fever', 'Approved'),
(4, 'Fluzone', 'Sanofi Pasteur', 4, '2009-09-01', 1, '2-8°C', 60.0, 'Mild fever, Injection site pain', 'Approved'),
(5, 'Havrix', 'GlaxoSmithKline', 14, '1995-06-01', 2, '2-8°C', 92.0, 'Fatigue, Nausea', 'Approved'),
(6, 'Dukoral', 'Valneva', 6, '1991-10-01', 2, 'Room temp (reconstituted)', 85.0, 'Stomach upset', 'Approved'),
(7, 'CYD-TDV', 'Sanofi Pasteur', 7, '2015-12-01', 3, '2-8°C', 65.0, 'Headache, Fever', 'Approved'),
(8, 'VSV-EBOV', 'Merck', 8, '2019-11-01', 1, '-60°C', 97.0, 'Fever, Joint pain', 'Approved'),
(9, 'YF-VAX', 'Sanofi', 15, '1937-01-01', 1, '2-8°C', 99.0, 'Mild allergic reaction', 'Approved'),
(10, 'MMR Vaccine', 'Merck', 11, '1971-01-01', 2, '2-8°C', 93.0, 'Fever, Rash', 'Approved'),
(11, 'IPV', 'GSK', 12, '1987-06-01', 3, '2-8°C', 90.0, 'Injection site pain', 'Approved'),
(12, 'Tetanus Toxoid', 'Bio Farma', 13, '1927-05-01', 3, '2-8°C', 99.0, 'Swelling, Headache', 'Approved'),
(13, 'Engerix-B', 'GlaxoSmithKline', 14, '1986-12-01', 3, '2-8°C', 95.0, 'Tiredness, Soreness', 'Approved'),
(14, 'Zostavax', 'Merck', 17, '2006-05-25', 1, '2-8°C', 88.0, 'Rash, Headache', 'Approved'),
(15, 'Verorab', 'Sanofi', 18, '1985-01-01', 5, '2-8°C', 100.0, 'Injection site reaction', 'Approved'),
(16, 'Typhim Vi', 'Sanofi', 19, '1994-02-01', 1, '2-8°C', 80.0, 'Muscle aches', 'Approved'),
(17, 'Zoster Vaccine', 'GSK', 17, '2017-10-01', 2, '2-8°C', 90.0, 'Headache, Injection site pain', 'Approved'),
(18, 'Comvax', 'Merck', 11, '1996-03-01', 3, '2-8°C', 94.0, 'Fever, Irritability', 'Approved'),
(19, 'Havrix Junior', 'GSK', 14, '2001-01-01', 2, '2-8°C', 88.0, 'Mild pain, Redness', 'Approved'),
(20, 'Rabipur', 'Bharat Biotech', 18, '1990-07-01', 5, '2-8°C', 98.0, 'Fever, Swelling', 'Approved');

-- to display table data
select * from Vaccines;
-- to remove complete records from table
truncate table Vaccines;
-- to remove complete records and attributes from table
drop table if exists Vaccines;


-- Table-5 Vaccination_Records-----------------------------------------------------------------------------------------------
create table Vaccination_Records(
RecordID int primary key,
Country_ID int not null,
Vaccine_ID int not null,
Report_Date date,
Total_Vaccinated int default 0 check (Total_Vaccinated >= 0),
Fully_Vaccinated int default 0,
Booster_Doses int default 0,
Age_Group varchar(50),
Gender varchar(10) check (Gender in ('Male','Female','Other')),
Campaign_Name varchar(100),
foreign key (Country_ID) references Countries(CountryID),
foreign key (Vaccine_ID) references Vaccines(VaccineID)
);

-- Data for Vaccination_Records
insert into Vaccination_Records 
(RecordID, Country_ID, Vaccine_ID, Report_Date, Total_Vaccinated, Fully_Vaccinated, Booster_Doses, Age_Group, Gender, Campaign_Name) 
values
(1, 1, 1, '2021-03-01', 20000000, 18000000, 2000000, '18-45', 'Male', 'India COVID-19 Drive Phase 1'),
(2, 1, 2, '2021-04-01', 15000000, 13000000, 1000000, '45+', 'Female', 'Covax National Program'),
(3, 2, 2, '2021-05-15', 25000000, 22000000, 3000000, 'All', 'Other', 'USA Mass Vaccination'),
(4, 3, 7, '2022-01-10', 500000, 480000, 20000, '0-17', 'Male', 'Dengue Protection Campaign'),
(5, 4, 4, '2022-11-20', 8000000, 7600000, 400000, 'All', 'Female', 'Winter Flu Shield'),
(6, 5, 6, '2020-08-01', 300000, 280000, 5000, '18+', 'Male', 'Cholera Emergency Response'),
(7, 6, 3, '2019-02-01', 100000, 95000, 2000, '18-45', 'Female', 'Tuberculosis Prevention Week'),
(8, 7, 10, '2022-06-01', 150000, 145000, 3000, '0-17', 'Male', 'Measles Eradication Campaign'),
(9, 8, 8, '2021-12-01', 20000, 19000, 1000, '18+', 'Female', 'Ebola Frontline Workers'),
(10, 9, 7, '2022-03-15', 450000, 400000, 25000, '18-60', 'Other', 'Dengue Awareness Week'),
(11, 10, 5, '2023-07-01', 75000, 70000, 5000, 'All', 'Male', 'Hepatitis Immunization Drive'),
(12, 11, 9, '2023-05-20', 120000, 110000, 5000, '0-45', 'Female', 'Yellow Fever Travel Program'),
(13, 12, 11, '2022-04-11', 60000, 58000, 1000, '0-17', 'Male', 'Polio Day Bangladesh'),
(14, 13, 13, '2023-01-05', 55000, 50000, 2000, 'All', 'Female', 'Hepatitis Awareness Month'),
(15, 14, 14, '2022-02-22', 98000, 95000, 3000, '60+', 'Other', 'Mumps Vaccine Coverage'),
(16, 15, 12, '2021-06-10', 72000, 70000, 1500, '18-45', 'Male', 'Tetanus Safety Initiative'),
(17, 16, 16, '2020-03-25', 33000, 31000, 1000, '18+', 'Female', 'Typhoid Prevention Drive'),
(18, 17, 17, '2023-09-01', 88000, 85000, 3000, '45+', 'Other', 'Mumps Senior Citizens Drive'),
(19, 18, 18, '2021-11-15', 62000, 60000, 1000, 'All', 'Male', 'MMR Booster Program'),
(20, 19, 15, '2022-07-07', 45000, 42000, 2500, 'All', 'Female', 'Rabies Vaccination Outreach');

-- to display table data
select * from Vaccination_Records;
-- to remove complete records from table
truncate table Vaccination_Records;
-- to remove complete records and attributes from table
drop table if exists Vaccination_Records;


-- Table-6 Hospitals---------------------------------------------------------------------------------------------------------
create table Hospitals(
HospitalID int primary key,
Name varchar(100) not null,
Country_ID int not null,
City varchar(100),
Capacity int check (Capacity >= 0),
Contact varchar(50),
Type varchar(50),
Public varchar(3) default 'Yes' check (Public in ('Yes', 'No')),
Established_Date date,
accreditation varchar(100),
foreign key (Country_ID) references Countries(CountryID)
);

-- Data for Hospitals
insert into Hospitals 
(HospitalID, Name, Country_ID, City, Capacity, Contact, Type, Public, Established_Date, Accreditation) 
values
(1, 'All India Institute of Medical Sciences', 1, 'New Delhi', 2500, '+91-11-26588500', 'Tertiary', 'Yes', '1956-09-25', 'NABH'),
(2, 'Mayo Clinic', 2, 'Rochester', 2000, '+1-507-284-2511', 'Multispecialty', 'No', '1889-01-01', 'JCI'),
(3, 'Hospital das Clínicas', 3, 'São Paulo', 2200, '+55-11-2661-0000', 'Teaching', 'Yes', '1944-05-19', 'ONA'),
(4, 'Peking Union Medical College Hospital', 4, 'Beijing', 1800, '+86-10-6915-1234', 'General', 'Yes', '1921-10-16', 'JCI'),
(5, 'University College Hospital', 5, 'Ibadan', 1000, '+234-2-231-5830', 'General', 'Yes', '1957-11-20', 'WACS'),
(6, 'Charité – Universitätsmedizin', 6, 'Berlin', 3000, '+49-30-45050', 'Research', 'Yes', '1800-01-01', 'ISO 9001'),
(7, 'Hôpital Necker-Enfants Malades', 7, 'Paris', 1200, '+33-1-44-49-40-00', 'Pediatric', 'Yes', '1802-05-01', 'HAS'),
(8, 'Groote Schuur Hospital', 8, 'Cape Town', 850, '+27-21-404-9111', 'Teaching', 'Yes', '1938-12-03', 'COHSASA'),
(9, 'Santo Tomas Hospital', 9, 'Manila', 950, '+63-2-8558-0888', 'Referral', 'Yes', '1879-09-01', 'PhilHealth'),
(10, 'Botkin Hospital', 10, 'Moscow', 1700, '+7-495-123-4567', 'Infectious Disease', 'Yes', '1910-06-01', 'Roszdravnadzor'),
(11, 'Royal Children’s Hospital', 11, 'Melbourne', 400, '+61-3-9345-5522', 'Pediatric', 'Yes', '1870-08-01', 'ACHS'),
(12, 'Dhaka Medical College Hospital', 12, 'Dhaka', 2300, '+880-2-8626812', 'Teaching', 'Yes', '1946-07-10', 'BMDC'),
(13, 'Instituto Nacional de Ciencias Médicas', 13, 'Mexico City', 1600, '+52-55-5487-0900', 'Specialty', 'Yes', '1943-01-12', 'CENETEC'),
(14, 'Toronto General Hospital', 14, 'Toronto', 1300, '+1-416-340-3111', 'Multispecialty', 'Yes', '1819-09-01', 'Accreditation Canada'),
(15, 'Ospedale Maggiore', 15, 'Milan', 1450, '+39-02-1234-5678', 'Surgical', 'Yes', '1856-03-15', 'JCI'),
(16, 'Aga Khan University Hospital', 16, 'Karachi', 700, '+92-21-34930051', 'Private', 'No', '1985-01-01', 'JCI'),
(17, 'Dr. Sardjito Hospital', 17, 'Yogyakarta', 800, '+62-274-123456', 'Referral', 'Yes', '1982-02-09', 'KARS'),
(18, 'Hospital Italiano de Buenos Aires', 18, 'Buenos Aires', 1100, '+54-11-4959-0200', 'General', 'Yes', '1853-01-01', 'ISO 9001'),
(19, 'St Thomas’ Hospital', 19, 'London', 1200, '+44-20-7188-7188', 'Teaching', 'Yes', '1106-01-01', 'CQC'),
(20, 'Black Lion Hospital', 20, 'Addis Ababa', 900, '+251-11-1234567', 'Referral', 'Yes', '1974-09-01', 'Ethiopian MOH');

-- to display table data
select * from Hospitals;
-- to remove complete records from table
truncate table Hospitals;
-- to remove complete records and attributes from table
drop table if exists Hospitals;


-- Table-7 Doctors-----------------------------------------------------------------------------------------------------------
create table Doctors(
DoctorID int primary key,
Name varchar(100) not  null,
Hospital_ID int not null,
Speciality varchar(100),
Years_Experience int check (Years_Experience >= 0),
Gender varchar(10) check (Gender in ('Male','Female')),
Email varchar(100) unique,
Phone varchar(20),
Available varchar(3) default 'Yes' check (Available in ('Yes', 'No')), 
Nationality varchar(50),
foreign key (Hospital_ID) references Hospitals(HospitalID)
);

-- Data for Doctors
insert into Doctors 
(DoctorID, Name, Hospital_ID, Speciality, Years_Experience, Gender, Email, Phone, Available, Nationality)
values
(1, 'Dr. Anjali Sharma', 1, 'Cardiology', 15, 'Female', 'anjali.sharma@aiims.in', '+91-9810000001', 'Yes', 'Indian'),
(2, 'Dr. Michael Ross', 2, 'Neurology', 22, 'Male', 'm.ross@mayo.org', '+1-507-555-0002', 'No', 'American'),
(3, 'Dr. Luisa Ribeiro', 3, 'Orthopedics', 12, 'Female', 'luisa.r@hcsp.br', '+55-11-5555-0003', 'Yes', 'Brazilian'),
(4, 'Dr. Wang Wei', 4, 'Internal Medicine', 18, 'Male', 'w.wei@pumch.cn', '+86-10-1234-5678', 'Yes', 'Chinese'),
(5, 'Dr. Chinedu Okafor', 5, 'Pediatrics', 9, 'Male', 'c.okafor@uch.edu.ng', '+234-802-123-0005', 'No', 'Nigerian'),
(6, 'Dr. Lisa Schneider', 6, 'Dermatology', 11, 'Female', 'l.schneider@charite.de', '+49-30-9876-0006', 'Yes', 'German'),
(7, 'Dr. Claire Moreau', 7, 'Oncology', 14, 'Female', 'c.moreau@necker.fr', '+33-1-2345-0007', 'Yes', 'French'),
(8, 'Dr. Sipho Mthembu', 8, 'Emergency Medicine', 10, 'Male', 's.mthembu@gsh.co.za', '+27-21-6789-0008', 'Yes', 'South African'),
(9, 'Dr. Maria Santos', 9, 'Pathology', 16, 'Female', 'm.santos@stthomas.ph', '+63-2-9999-0009', 'No', 'Filipino'),
(10, 'Dr. Ivan Petrov', 10, 'Infectious Diseases', 20, 'Male', 'i.petrov@botkin.ru', '+7-495-321-0010', 'Yes', 'Russian'),
(11, 'Dr. Sarah Wilson', 11, 'Neonatology', 8, 'Female', 's.wilson@rch.org.au', '+61-3-1234-0011', 'Yes', 'Australian'),
(12, 'Dr. Zahir Rahman', 12, 'Surgery', 13, 'Male', 'z.rahman@dmch.gov.bd', '+880-2-123-0012', 'No', 'Bangladeshi'),
(13, 'Dr. Miguel García', 13, 'Psychiatry', 17, 'Male', 'm.garcia@incmnsz.mx', '+52-55-0000-0013', 'Yes', 'Mexican'),
(14, 'Dr. Emily Chen', 14, 'Gastroenterology', 6, 'Female', 'e.chen@tgh.ca', '+1-416-111-0014', 'Yes', 'Canadian'),
(15, 'Dr. Giulia Romano', 15, 'Radiology', 10, 'Female', 'g.romano@ospedalemag.it', '+39-02-7777-0015', 'No', 'Italian'),
(16, 'Dr. Faheem Ali', 16, 'Urology', 7, 'Male', 'f.ali@aku.edu.pk', '+92-21-3333-0016', 'Yes', 'Pakistani'),
(17, 'Dr. Siti Nurhaliza', 17, 'Gynecology', 19, 'Female', 's.nurhaliza@rsds.id', '+62-274-4444-0017', 'Yes', 'Indonesian'),
(18, 'Dr. Juan Lopez', 18, 'Neurology', 15, 'Male', 'j.lopez@hospitalitaliano.ar', '+54-11-7777-0018', 'Yes', 'Argentinian'),
(19, 'Dr. Henry Smith', 19, 'Cardiothoracic Surgery', 25, 'Male', 'h.smith@stthomas.uk', '+44-20-2222-0019', 'No', 'British'),
(20, 'Dr. Mekdes Tadesse', 20, 'Ophthalmology', 7, 'Female', 'm.tadesse@blacklion.et', '+251-11-5678-0020', 'Yes', 'Ethiopian');

-- to display table data
select * from Doctors;
-- to remove complete records from table
truncate table Doctors;
-- to remove complete records and attributes from table
drop table if exists Doctors;


-- Table-8 Health_Workers----------------------------------------------------------------------------------------------------
create table Health_Workers(
WorkerID int primary key,
Name varchar(100),
Role varchar(50),
Hospital_ID int not null,
Country_ID int not null,
Years_Experience int,
Gender varchar(10) check (Gender in ('Male','Female')),
Email varchar(100) unique,
Phone varchar(20),
Status varchar(30) default 'Active' check (Status in ('Active', 'Not-Active')),
foreign key (Hospital_ID) references Hospitals(HospitalID),
foreign key (Country_ID) references Countries(CountryID) 
);

-- Data for Health_Workers
insert into Health_Workers 
(WorkerID, Name, Role, Hospital_ID, Country_ID, Years_Experience, Gender, Email, Phone, Status) 
values
(1, 'Rajesh Patil', 'Nurse', 1, 1, 10, 'Male', 'rajesh.patil@aiims.in', '+91-9876543210', 'Active'),
(2, 'Linda White', 'Lab Technician', 2, 2, 6, 'Female', 'linda.white@mayo.org', '+1-507-111-1111', 'Active'),
(3, 'Carlos Silva', 'Ward Assistant', 3, 3, 4, 'Male', 'carlos.silva@hcsp.br', '+55-11-9876-5432', 'Not-Active'),
(4, 'Chen Mei', 'Pharmacist', 4, 4, 8, 'Female', 'chen.mei@pumch.cn', '+86-10-2222-3333', 'Active'),
(5, 'Grace Olabisi', 'Midwife', 5, 5, 12, 'Female', 'grace.olabisi@uch.edu.ng', '+234-802-1234567', 'Active'),
(6, 'Stefan Weber', 'Admin Staff', 6, 6, 9, 'Male', 's.weber@charite.de', '+49-30-1234-5678', 'Active'),
(7, 'Camille Dubois', 'Nurse', 7, 7, 7, 'Female', 'c.dubois@necker.fr', '+33-1-4444-5555', 'Not-Active'),
(8, 'Thabo Ndlovu', 'Paramedic', 8, 8, 5, 'Male', 't.ndlovu@gsh.co.za', '+27-21-7777-8888', 'Active'),
(9, 'Jasmin Cruz', 'Ward Assistant', 9, 9, 6, 'Female', 'jasmin.cruz@sthomas.ph', '+63-2-9999-1111', 'Active'),
(10, 'Nikita Smirnova', 'Nurse', 10, 10, 15, 'Female', 'n.smirnova@botkin.ru', '+7-495-999-8888', 'Active'),
(11, 'Amit Patel', 'Lab Technician', 1, 1, 5, 'Male', 'amit.patel@aiims.in', '+91-9988776655', 'Active'),
(12, 'Darren Lee', 'Pharmacist', 11, 11, 4, 'Male', 'darren.lee@rch.org.au', '+61-3-1234-5678', 'Not-Active'),
(13, 'Nasreen Akhtar', 'Nurse', 12, 12, 10, 'Female', 'nasreen.akhtar@dmch.gov.bd', '+880-2-5555-1212', 'Active'),
(14, 'Luis Gomez', 'X-ray Tech', 13, 13, 6, 'Male', 'l.gomez@incmnsz.mx', '+52-55-8888-0000', 'Active'),
(15, 'Alicia Brown', 'Midwife', 14, 14, 11, 'Female', 'alicia.brown@tgh.ca', '+1-416-7777-1212', 'Active'),
(16, 'Marco Rossi', 'Admin Staff', 15, 15, 9, 'Male', 'marco.rossi@ospedalemag.it', '+39-02-3333-4444', 'Active'),
(17, 'Sana Khan', 'Ward Assistant', 16, 16, 3, 'Female', 'sana.khan@aku.edu.pk', '+92-21-6666-7777', 'Not-Active'),
(18, 'Putri Ayu', 'Nurse', 17, 17, 8, 'Female', 'putri.ayu@rsds.id', '+62-274-1212-3434', 'Active'),
(19, 'Daniel Perez', 'Paramedic', 18, 18, 5, 'Male', 'daniel.perez@hospitalitaliano.ar', '+54-11-4567-8910', 'Active'),
(20, 'Abebe Mekonnen', 'Lab Technician', 20, 20, 7, 'Male', 'abebe.mekonnen@blacklion.et', '+251-11-2345-6789', 'Active');

-- to display table data
select * from Health_Workers;
-- to remove complete records from table
truncate table Health_Workers;
-- to remove complete records and attributes from table
drop table if exists Health_Workers;


-- Table-9 Outbreaks---------------------------------------------------------------------------------------------------------
create table Outbreaks(
OutbreakID int primary key,
Disease_ID int not null,
Country_ID int not null,
Start_Date date,
End_Date date,
Severity varchar(20) check (Severity in ('Low','Medium','High','Critical')),
Region varchar(100),
Source text,
Controlled varchar(3) default 'Yes' check (Controlled in ('Yes', 'No')),
Notes text,
foreign key (Disease_ID) references Diseases(DiseaseID),
foreign key (Country_ID) references Countries(CountryID)
);

-- Data for Outbreaks
insert into Outbreaks 
(OutbreakID, Disease_ID, Country_ID, Start_Date, End_Date, Severity, Region, Source, Controlled, Notes) 
values
(1, 1, 1, '2020-03-01', '2021-12-31', 'Critical', 'South Asia', 'Wuhan-origin COVID-19 variant spread via air travel.', 'No', 'Nationwide lockdowns implemented.'),
(2, 2, 3, '2015-06-15', '2015-11-30', 'High', 'Amazon Basin', 'Malaria outbreak after monsoon floods.', 'Yes', 'High mosquito density recorded.'),
(3, 4, 2, '2018-12-01', '2019-03-01', 'Medium', 'Midwest USA', 'Seasonal Influenza Type B outbreak.', 'Yes', 'Mild hospital overload.'),
(4, 8, 5, '2014-08-10', '2015-02-25', 'Critical', 'West Africa', 'Ebola virus spread through rural contact.', 'No', 'WHO declared international emergency.'),
(5, 7, 4, '2019-04-15', '2019-09-10', 'High', 'Southeast Asia', 'Dengue outbreak after heavy rains.', 'Yes', 'Mass fumigation programs launched.'),
(6, 6, 6, '2020-07-01', '2020-09-30', 'High', 'Berlin', 'Cholera from water contamination.', 'Yes', 'Old water pipelines replaced.'),
(7, 11, 7, '2011-02-20', '2011-06-01', 'High', 'Northern France', 'Measles in unvaccinated children.', 'Yes', 'Vaccination awareness increased.'),
(8, 9, 8, '2016-03-05', '2016-08-18', 'Medium', 'Cape Coast', 'Zika virus confirmed in 50+ cases.', 'Yes', 'Travel restrictions imposed.'),
(9, 13, 9, '2017-01-10', '2017-04-12', 'High', 'Metro Manila', 'Tetanus spread after urban flooding.', 'Yes', 'Free vaccination drives.'),
(10, 3, 10, '2013-11-11', '2014-05-30', 'High', 'Central Russia', 'TB resurgence in prisons.', 'No', 'Healthcare access improved.'),
(11, 5, 12, '2008-06-10', '2009-01-01', 'Critical', 'Dhaka Region', 'HIV/AIDS cases doubled.', 'No', 'UN intervention with NGOs.'),
(12, 10, 14, '2012-09-01', '2013-03-01', 'Critical', 'Ontario', 'MERS-CoV import from Middle East.', 'Yes', 'Quarantine protocol successful.'),
(13, 12, 11, '2010-05-05', '2010-09-20', 'High', 'Victoria', 'Polio cases in children.', 'Yes', 'Eradication campaign renewed.'),
(14, 19, 1, '2018-07-12', '2018-10-20', 'High', 'Maharashtra', 'Typhoid Fever via poor sanitation.', 'Yes', 'School awareness programs launched.'),
(15, 15, 13, '2005-04-01', '2005-07-30', 'High', 'Central Mexico', 'Yellow Fever spread via jungle zone.', 'Yes', 'Rural healthcare units deployed.'),
(16, 18, 2, '2003-02-15', '2003-04-30', 'Critical', 'California', 'Rabies from wild animal contact.', 'No', 'Public urged to vaccinate pets.'),
(17, 20, 16, '2017-06-10', '2018-01-01', 'High', 'Karachi', 'Hepatitis C outbreak via blood banks.', 'Yes', 'Inspection and shutdowns done.'),
(18, 17, 15, '2014-09-10', '2015-01-10', 'Medium', 'Rome', 'Mumps cluster in school children.', 'Yes', 'Vaccination compliance enforced.'),
(19, 14, 18, '2019-02-01', '2019-05-10', 'High', 'Buenos Aires', 'Hepatitis B via unregulated tattoo shops.', 'Yes', 'Licensing made strict.'),
(20, 16, 20, '2016-08-01', '2016-12-31', 'Medium', 'Addis Ababa', 'Leprosy cases resurfaced.', 'No', 'Ongoing contact tracing and education.');

-- to display table data
select * from Outbreaks;
-- to remove complete records from table
truncate table Outbreaks;
-- to remove complete records and attributes from table
drop table if exists Outbreaks;


-- Table-10 Emergency_Responses----------------------------------------------------------------------------------------------
create table Emergency_Responses(
ResponseID int primary key,
Outbreak_ID int not null,
Start_Date date,
End_Date date,
Teams_Deployed int,
Supplies_Sent text,
Cost double,
Partner_Orgs text,
Status varchar(30),
Coordinator varchar(100),
foreign key (Outbreak_ID) references Outbreaks(OutbreakID)
);

-- Data for Emergency_Responses
insert into Emergency_Responses 
(ResponseID, Outbreak_ID, Start_Date, End_Date, Teams_Deployed, Supplies_Sent, Cost, Partner_Orgs, Status, Coordinator) 
values
(1, 1, '2020-03-15', '2021-01-30', 10, 'PPE kits, ventilators, test kits', 12000000, 'WHO, UNICEF, Red Cross', 'Completed', 'Dr. Shalini Singh'),
(2, 2, '2015-06-20', '2015-10-15', 6, 'Anti-malarial meds, mosquito nets', 350000, 'MSF, WHO', 'Completed', 'Dr. Bruno Costa'),
(3, 3, '2019-01-10', '2019-02-20', 3, 'Tamiflu, masks', 180000, 'CDC', 'Completed', 'Dr. Alice Morgan'),
(4, 4, '2014-08-15', '2015-01-30', 15, 'Hazmat suits, mobile labs', 8000000, 'WHO, CDC, UNHCR', 'Completed', 'Dr. Kwame Mensah'),
(5, 5, '2019-05-01', '2019-08-15', 8, 'Insecticides, IV fluids', 600000, 'UNICEF', 'Completed', 'Dr. Nora Tan'),
(6, 6, '2020-07-05', '2020-09-10', 5, 'Water purifiers, antibiotics', 250000, 'Red Cross', 'Completed', 'Dr. Hans Becker'),
(7, 7, '2011-03-01', '2011-05-30', 4, 'MMR vaccines, awareness kits', 300000, 'WHO', 'Completed', 'Dr. Louise Bernard'),
(8, 8, '2016-04-01', '2016-07-20', 7, 'Insect repellents, PPE', 400000, 'CDC', 'Completed', 'Dr. Sipho Ndlovu'),
(9, 9, '2017-01-15', '2017-03-30', 2, 'Vaccines, oral rehydration', 150000, 'UNICEF', 'Completed', 'Dr. Maria Cruz'),
(10, 10, '2013-12-01', '2014-03-01', 6, 'TB meds, isolation tents', 500000, 'Doctors Without Borders', 'Completed', 'Dr. Ivan Morozov'),
(11, 11, '2008-07-01', '2008-12-31', 9, 'ARVs, mobile clinics', 1200000, 'UNAIDS, WHO', 'Completed', 'Dr. Farhana Siddiqui'),
(12, 12, '2012-09-15', '2012-11-15', 4, 'Quarantine units, respirators', 700000, 'Health Canada, WHO', 'Completed', 'Dr. Thomas Hill'),
(13, 13, '2010-05-10', '2010-08-10', 3, 'Polio drops, transport vans', 220000, 'Rotary International', 'Completed', 'Dr. Hannah Lee'),
(14, 14, '2018-07-15', '2018-10-10', 5, 'Water tanks, antibiotics', 300000, 'UNICEF, Red Cross', 'Completed', 'Dr. Kiran Bhosale'),
(15, 15, '2005-04-10', '2005-07-15', 6, 'Yellow fever vaccines, logistics', 280000, 'WHO, PAHO', 'Completed', 'Dr. Miguel Navarro'),
(16, 16, '2003-02-20', '2003-04-15', 3, 'Animal control, rabies shots', 150000, 'CDC, SPCA', 'Completed', 'Dr. Anna Roberts'),
(17, 17, '2017-06-15', '2017-12-15', 5, 'Sterile kits, antivirals', 420000, 'Red Crescent, WHO', 'Completed', 'Dr. Faisal Riaz'),
(18, 18, '2014-09-15', '2015-01-15', 2, 'Measles-mumps vaccine boosters', 130000, 'Ministry of Health, Italy', 'Completed', 'Dr. Lucia Romano'),
(19, 19, '2019-02-10', '2019-05-01', 3, 'Hep B vaccines, sterile needles', 180000, 'PAHO, WHO', 'Completed', 'Dr. Daniel Ayala'),
(20, 20, '2016-08-10', '2016-12-01', 4, 'Skin treatment kits, mobile vans', 210000, 'UNHCR, WHO', 'Completed', 'Dr. Abeba Tesfaye');

-- to display table data
select * from Emergency_Responses;
-- to remove complete records from table
truncate table Emergency_Responses;
-- to remove complete records and attributes from table
drop table if exists Emergency_Responses;


-- Table-11 Programs---------------------------------------------------------------------------------------------------------
create table Programs(
ProgramID int primary key,
Name varchar(100) not null,
Focus_Area varchar(100),
Start_Year date check (Start_Year >= '1700-01-01'),
Global varchar(3) check (Global in ('Yes','No')),
Objective text,
Status varchar(30),
Budget double,
Partner_Orgs text,
Manager varchar(100)
);

-- Data for Programs
insert into Programs 
(ProgramID, Name, Focus_Area, Start_Year, Global, Objective, Status, Budget, Partner_Orgs, Manager) 
values
(1, 'Global Vaccination Drive', 'Immunization', '2005-01-01', 'Yes', 'To ensure global vaccine access for preventable diseases.', 'Active', 25000000, 'WHO, UNICEF, GAVI', 'Dr. Maria Svensson'),
(2, 'Malaria Elimination Campaign', 'Vector Control', '2010-04-01', 'No', 'To eliminate malaria in Sub-Saharan Africa.', 'Ongoing', 18000000, 'Gates Foundation, WHO', 'Dr. Elijah Bako'),
(3, 'Child Health Initiative', 'Child Health', '2000-01-01', 'Yes', 'Improve child nutrition and decrease infant mortality.', 'Active', 15000000, 'UNICEF, Save the Children', 'Dr. Aisha Khan'),
(4, 'TB-Free India', 'Tuberculosis', '2013-07-01', 'No', 'Eradicate TB cases through early diagnosis and treatment.', 'Active', 7000000, 'WHO, India Health Ministry', 'Dr. Sameer Kulkarni'),
(5, 'Polio Eradication Program', 'Polio', '1995-01-01', 'Yes', 'Global eradication of poliovirus.', 'Completed', 30000000, 'Rotary International, WHO', 'Dr. Robert Liu'),
(6, 'HIV/AIDS Response Plan', 'HIV/AIDS', '2008-03-01', 'Yes', 'Prevention and treatment of HIV/AIDS in high-risk regions.', 'Active', 22000000, 'UNAIDS, WHO, Red Cross', 'Dr. Nia Roberts'),
(7, 'Sanitation for All', 'Sanitation & Hygiene', '2011-06-15', 'No', 'To improve access to sanitation in rural communities.', 'Ongoing', 12000000, 'UNDP, WaterAid', 'Dr. Linh Tran'),
(8, 'Mental Health Outreach', 'Mental Health', '2019-01-01', 'No', 'Community outreach and treatment for mental illnesses.', 'Pilot', 3000000, 'WHO, National Institutes', 'Dr. Pierre Lambert'),
(9, 'Women’s Health Equity', 'Reproductive Health', '2016-10-01', 'Yes', 'Address health disparities among women.', 'Active', 14000000, 'UN Women, WHO', 'Dr. Fiona Castillo'),
(10, 'Emergency Medical Teams', 'Disaster Response', '2012-02-01', 'Yes', 'Rapid medical support during natural disasters.', 'Active', 17000000, 'WHO, Red Crescent, UNHCR', 'Dr. Mahmoud Zahid'),
(11, 'Hepatitis Control Program', 'Hepatitis B & C', '2015-05-01', 'No', 'Reduce hepatitis transmission via vaccines and testing.', 'Ongoing', 6500000, 'GAVI, WHO', 'Dr. Mikhail Ivanov'),
(12, 'Nutrition First', 'Malnutrition', '2003-09-01', 'Yes', 'Combat malnutrition in conflict-affected regions.', 'Suspended', 10000000, 'UNICEF, WFP', 'Dr. Sara Abdi'),
(13, 'Health for Refugees', 'Refugee Health', '2007-11-01', 'Yes', 'Ensure access to healthcare for displaced populations.', 'Completed', 8500000, 'UNHCR, MSF', 'Dr. Tadesse Alemu'),
(14, 'Smoke-Free Future', 'Anti-Tobacco', '2018-01-01', 'No', 'Public awareness and policies for reducing tobacco use.', 'Active', 4500000, 'WHO, Cancer Societies', 'Dr. Keiko Tanaka'),
(15, 'Clean Water Initiative', 'Water Access', '2014-04-01', 'Yes', 'Deliver clean drinking water to underserved regions.', 'Ongoing', 16000000, 'UNDP, World Bank', 'Dr. Jorge Mendes'),
(16, 'Rural Clinics Project', 'Infrastructure', '2021-06-01', 'No', 'Construct basic health units in remote areas.', 'Planning', 5000000, 'Govt. of Kenya, WHO', 'Dr. Esther Kimani'),
(17, 'Digital Health Innovation', 'e-Health', '2020-03-01', 'Yes', 'Promote digital tools for health monitoring.', 'Pilot', 4300000, 'Bill & Melinda Gates Foundation', 'Dr. Alan Wu'),
(18, 'End Dengue Mission', 'Mosquito-Borne Diseases', '2017-08-01', 'No', 'Vector control and community education to curb dengue.', 'Ongoing', 7800000, 'WHO, Local Govts', 'Dr. Maria Luisa Perez'),
(19, 'Zoonotic Disease Surveillance', 'One Health', '2016-01-15', 'Yes', 'Monitor zoonotic spillovers in wildlife-human interfaces.', 'Active', 9500000, 'FAO, WHO, OIE', 'Dr. Samuel Ofori'),
(20, 'Vaccine Logistics Support', 'Supply Chain', '2019-12-01', 'Yes', 'Improve vaccine distribution logistics globally.', 'Ongoing', 10500000, 'UNICEF, GAVI', 'Dr. Erica Johnson');

-- to display table data
select * from Programs;
-- to remove complete records from table
truncate table Programs;
-- to remove complete records and attributes from table
drop table if exists Programs;


-- Table-12 Program_Participation--------------------------------------------------------------------------------------------
create table Program_Participation(
ParticipationID int primary key,
Program_ID int not null,
Country_ID int not null,
Start_Date date,
End_Date date,
Status varchar(30),
Coordinator varchar(100),
Funding_Received double,
Impact_Rating float,
Comments text,
foreign key (Program_ID) references Programs(ProgramID),
foreign key (Country_ID) references Countries(CountryID)
);

-- Data for Program_Participation
insert into Program_Participation 
(ParticipationID, Program_ID, Country_ID, Start_Date, End_Date, Status, Coordinator, Funding_Received, Impact_Rating, Comments) 
values
(1, 1, 1, '2020-01-01', '2022-12-31', 'Completed', 'Dr. Suresh Iyer', 2000000, 4.7, 'Successful national vaccine drive'),
(2, 2, 3, '2015-06-01', '2018-12-01', 'Completed', 'Dr. Angela Okoro', 1250000, 4.2, 'Malaria rates decreased by 60%'),
(3, 3, 5, '2010-01-01', '2015-01-01', 'Completed', 'Dr. Faiza Rehman', 1800000, 4.5, 'Major reduction in infant mortality'),
(4, 4, 2, '2013-08-01', '2020-12-01', 'Ongoing', 'Dr. Nishant Rao', 1000000, 4.0, 'TB eradication program scaling up'),
(5, 5, 7, '1996-01-01', '2018-12-01', 'Completed', 'Dr. Lina Stewart', 3200000, 5.0, 'Polio eliminated completely'),
(6, 6, 6, '2011-05-01', '2023-12-01', 'Active', 'Dr. Sandra Mbatha', 2400000, 4.3, 'Ongoing ARV supply and testing'),
(7, 7, 9, '2012-06-01', '2017-06-01', 'Completed', 'Dr. Rohit Mehta', 750000, 3.9, 'Toilets built in rural villages'),
(8, 8, 4, '2021-01-01', NULL, 'Pilot', 'Dr. Mary Okafor', 250000, 3.5, 'Mental health tele-consultation trial'),
(9, 9, 10, '2017-09-01', '2022-01-01', 'Active', 'Dr. Eleanor Diaz', 1300000, 4.6, 'Women’s clinics expanded'),
(10, 10, 13, '2014-02-01', '2016-12-01', 'Completed', 'Dr. Khalid Saleem', 1000000, 4.1, 'Fast response teams trained'),
(11, 11, 15, '2016-07-01', '2021-12-01', 'Completed', 'Dr. Sayali Deshmukh', 800000, 4.0, 'Hepatitis B screening improved'),
(12, 12, 16, '2005-01-01', '2009-01-01', 'Suspended', 'Dr. Esther Nyarko', 400000, 2.8, 'Funding issues disrupted program'),
(13, 13, 12, '2009-10-01', '2013-10-01', 'Completed', 'Dr. Hassan Yusuf', 900000, 4.4, 'Refugees received access to care'),
(14, 14, 8, '2018-02-01', '2020-01-01', 'Completed', 'Dr. Alfredo Moretti', 600000, 3.7, 'Drop in smoking among teens'),
(15, 15, 17, '2014-07-01', '2019-07-01', 'Ongoing', 'Dr. Marcus Chen', 1800000, 4.2, 'Water quality improved significantly'),
(16, 16, 11, '2022-01-01', NULL, 'Planning', 'Dr. Clara Fernandes', 700000, 3.0, 'Sites selected for rural clinics'),
(17, 17, 18, '2021-03-01', '2023-03-01', 'Pilot', 'Dr. Alan Wong', 850000, 3.8, 'Smart devices used in trials'),
(18, 18, 14, '2017-09-01', '2020-06-01', 'Completed', 'Dr. Rajeev Pillai', 980000, 4.1, 'Dengue vector control successful'),
(19, 19, 19, '2016-01-01', '2022-01-01', 'Active', 'Dr. Miriam Bekele', 1000000, 4.3, 'Real-time animal disease tracking'),
(20, 20, 20, '2019-12-01', '2023-01-01', 'Ongoing', 'Dr. Fiona Howard', 950000, 4.0, 'Improved vaccine cold-chain logistics');

-- to display table data
select * from Program_Participation;
-- to remove complete records from table
truncate table Program_Participation;
-- to remove complete records and attributes from table
drop table if exists Program_Participation;


-- Table-13 Labs-------------------------------------------------------------------------------------------------------------
create table Labs(
LabID int primary key,
Name varchar(100),
Country_ID int not null,
City varchar(100),
Type varchar(50),
Capacity int,
Accredited varchar(3) default 'Yes',
Iso_Certified varchar(50),
Contact varchar(20),
Established_Year year,
Foreign key (Country_ID) references Countries(CountryID)
);

-- Data for Labs
insert into Labs 
(LabID, Name, Country_ID, City, Type, Capacity, Accredited, Iso_Certified, Contact, Established_Year) 
values
(1, 'National Virology Institute', 1, 'New Delhi', 'Virology', 500, 'Yes', 'ISO 15189', '01123456789', 1985),
(2, 'Pathogen Surveillance Lab', 2, 'Washington D.C.', 'Pathology', 450, 'Yes', 'ISO 17025', '12025551234', 1990),
(3, 'Brazilian Health Lab', 3, 'Brasília', 'Infectious Diseases', 380, 'Yes', 'ISO 9001', '556112345678', 2005),
(4, 'Beijing Pathogen Center', 4, 'Beijing', 'Microbiology', 520, 'Yes', 'ISO 15190', '861012345678', 2001),
(5, 'Abuja Tropical Disease Unit', 5, 'Abuja', 'Tropical Diseases', 300, 'Yes', 'ISO 17025', '2348123456789', 2010),
(6, 'Berlin Immuno Lab', 6, 'Berlin', 'Immunology', 410, 'Yes', 'ISO 15189', '49301234567', 1998),
(7, 'Paris Clinical Research Center', 7, 'Paris', 'Clinical Research', 360, 'Yes', 'ISO 9001', '33145678901', 2012),
(8, 'Tokyo Genetic Research Institute', 8, 'Tokyo', 'Genetics', 420, 'Yes', 'ISO 17025', '81312345678', 2007),
(9, 'Pretoria Viral Response Lab', 9, 'Pretoria', 'Virology', 275, 'Yes', 'ISO 15190', '271198765432', 2015),
(10, 'Moscow Biotech Center', 10, 'Moscow', 'Biotechnology', 500, 'Yes', 'ISO 9001', '74951234567', 2000),
(11, 'Canberra Public Health Lab', 11, 'Canberra', 'Public Health', 350, 'Yes', 'ISO 15189', '61234567890', 2004),
(12, 'Dhaka Diagnostic Research Unit', 12, 'Dhaka', 'Diagnostics', 390, 'Yes', 'ISO 17025', '880112345678', 2013),
(13, 'Mexico City National Lab', 13, 'Mexico City', 'Infectious Diseases', 310, 'Yes', 'ISO 9001', '525512345678', 2002),
(14, 'Ottawa Biomedical Center', 14, 'Ottawa', 'Biomedical', 430, 'Yes', 'ISO 15190', '16135551234', 1995),
(15, 'Rome Vaccine Lab', 15, 'Rome', 'Vaccinology', 280, 'Yes', 'ISO 15189', '39061234567', 2011),
(16, 'Islamabad Viral Research Center', 16, 'Islamabad', 'Virology', 260, 'Yes', 'ISO 17025', '923321234567', 2008),
(17, 'Jakarta Health Systems Lab', 17, 'Jakarta', 'Health Systems', 320, 'Yes', 'ISO 9001', '62212345678', 2017),
(18, 'Buenos Aires Epidemiology Unit', 18, 'Buenos Aires', 'Epidemiology', 300, 'Yes', 'ISO 15189', '54112345678', 2009),
(19, 'London Global Disease Lab', 19, 'London', 'Global Health', 450, 'Yes', 'ISO 17025', '442087654321', 2006),
(20, 'Addis Ababa Pathogen Control Lab', 20, 'Addis Ababa', 'Pathogen Control', 295, 'Yes', 'ISO 15190', '251912345678', 2014);

-- to display table data
select * from Labs;
-- to remove complete records from table
truncate table Labs;
-- to remove complete records and attributes from table
drop table if exists Labs;


-- Table-14 Lab_Tests--------------------------------------------------------------------------------------------------------
create table Lab_Tests(
TestID int primary key,
Lab_ID int not null,
Disease_ID int not null,
Test_Date date,
Samples_Tested int,
Positives int,
Negatives int,
Test_Type varchar(50),
Method varchar(100),
Notes text,
foreign key (Lab_ID) references Labs(LabID),
foreign key (Disease_ID) references Diseases(DiseaseID)
);

-- Data for Lab_Tests
insert into Lab_Tests 
(TestID, Lab_ID, Disease_ID, Test_Date, Samples_Tested, Positives, Negatives, Test_Type, Method, Notes) 
values
(1, 1, 1, '2023-01-15', 1000, 150, 850, 'PCR', 'Reverse Transcription PCR', 'COVID-19 community testing batch'),
(2, 2, 2, '2023-02-20', 700, 90, 610, 'Rapid Test', 'Microscopy', 'Malaria screening in rural areas'),
(3, 3, 3, '2023-03-10', 500, 70, 430, 'Tuberculin Skin Test', 'Mantoux method', 'Suspected TB patient survey'),
(4, 4, 4, '2023-04-05', 800, 120, 680, 'RT-PCR', 'Reverse Transcription PCR', 'Influenza season analysis'),
(5, 5, 5, '2023-05-15', 600, 80, 520, 'ELISA', 'HIV Antibody Detection', 'NGO sponsored HIV screening'),
(6, 6, 6, '2023-06-20', 400, 60, 340, 'Rapid Test', 'Dipstick Method', 'Cholera outbreak area'),
(7, 7, 7, '2023-07-12', 550, 75, 475, 'NS1 Antigen', 'ELISA', 'Dengue seasonal surveillance'),
(8, 8, 8, '2023-08-01', 300, 55, 245, 'RT-PCR', 'Genetic Sequencing', 'Ebola contact tracing batch'),
(9, 9, 9, '2023-09-14', 450, 50, 400, 'Antibody Test', 'ELISA', 'Zika virus study'),
(10, 10, 10, '2023-10-05', 480, 65, 415, 'PCR', 'Genomic Identification', 'MERS-CoV tracking'),
(11, 11, 11, '2023-10-18', 900, 130, 770, 'Measles IgM', 'ELISA', 'Measles resurgence testing'),
(12, 12, 12, '2023-11-02', 850, 95, 755, 'Polio Lab Test', 'Virus Isolation', 'Routine Polio surveillance'),
(13, 13, 13, '2023-11-20', 300, 40, 260, 'Tetanus Toxoid Detection', 'Antitoxin Assay', 'Post-injury hospital tests'),
(14, 14, 14, '2023-12-05', 770, 100, 670, 'Hepatitis B Antigen', 'ELISA', 'Blood donor screening'),
(15, 15, 15, '2024-01-10', 550, 85, 465, 'Yellow Fever Test', 'PCR', 'Pre-travel vaccine testing'),
(16, 16, 16, '2024-02-04', 500, 45, 455, 'Skin Smear Test', 'Microscopy', 'Leprosy field test'),
(17, 17, 17, '2024-02-25', 600, 70, 530, 'Mumps IgM', 'ELISA', 'School outbreak testing'),
(18, 18, 18, '2024-03-18', 450, 60, 390, 'Rabies Antigen Test', 'DFA Method', 'Post-animal bite testing'),
(19, 19, 19, '2024-04-12', 520, 65, 455, 'Typhoid Rapid Test', 'Widal Test', 'Contaminated water investigation'),
(20, 20, 20, '2024-05-06', 480, 90, 390, 'Hepatitis C Antibody', 'ELISA', 'Chronic Hep C monitoring');

-- to display table data
select * from Lab_Tests;
-- to remove complete records from table
truncate table Lab_Tests;
-- to remove complete records and attributes from table
drop table if exists Lab_Tests;


-- Table-15 Reports----------------------------------------------------------------------------------------------------------
create table Reports(
ReportID int primary key,
Title varchar(200) not null,
Topic varchar(100),
Author varchar(100),
Date_Published date,
Summary text,
Language varchar(50),
Region varchar(50),
Reviewed varchar(50),
URL text
);

-- Data for Reports
insert into Reports 
(ReportID, Title, Topic, Author, Date_Published, Summary, Language, Region, Reviewed, URL) 
values
(1, 'COVID-19 Pandemic Global Review', 'COVID-19', 'Dr. Anita Mehra', '2022-01-15', 'A detailed analysis of global response to COVID-19.', 'English', 'South-East Asia', 'Yes', 'https://who.int/reports/covid-review'),
(2, 'Malaria Control Progress 2023', 'Malaria', 'Dr. Samuel Otieno', '2023-04-10', 'Progress made in malaria elimination across Africa.', 'English', 'Africa', 'Yes', 'https://who.int/reports/malaria-progress'),
(3, 'Influenza Vaccine Development', 'Influenza', 'Dr. Helena Schmidt', '2021-11-20', 'Current developments in flu vaccine strategies.', 'German', 'Europe', 'Yes', 'https://who.int/reports/flu-vaccine'),
(4, 'HIV/AIDS in the Americas', 'HIV/AIDS', 'Dr. Maria Torres', '2020-09-12', 'Trends and strategies for managing HIV/AIDS.', 'Spanish', 'Americas', 'Yes', 'https://who.int/reports/hiv-americas'),
(5, 'Ebola Outbreak Summary', 'Ebola', 'Dr. John Kamara', '2019-07-05', 'Comprehensive overview of recent Ebola outbreaks.', 'English', 'Africa', 'Yes', 'https://who.int/reports/ebola-outbreak'),
(6, 'Zika Virus Monitoring Report', 'Zika Virus', 'Dr. Laura Costa', '2018-03-15', 'Analysis of Zika virus spread and response.', 'Portuguese', 'Americas', 'Yes', 'https://who.int/reports/zika-monitor'),
(7, 'Tuberculosis Control Plans', 'Tuberculosis', 'Dr. Markus Weber', '2023-02-25', 'Revised TB control strategies in Europe.', 'English', 'Europe', 'No', 'https://who.int/reports/tb-europe'),
(8, 'Dengue Fever Trends 2022', 'Dengue', 'Dr. Indira Rathi', '2022-06-10', 'Statistical insights into dengue outbreaks.', 'Hindi', 'South-East Asia', 'Yes', 'https://who.int/reports/dengue-trends'),
(9, 'Cholera in Conflict Zones', 'Cholera', 'Dr. Amina Yusuf', '2021-08-01', 'Impact of conflict on cholera response.', 'English', 'Africa', 'No', 'https://who.int/reports/cholera-response'),
(10, 'Measles Resurgence in Europe', 'Measles', 'Dr. Franz Müller', '2020-10-28', 'Reasons behind the resurgence of measles.', 'French', 'Europe', 'Yes', 'https://who.int/reports/measles-return'),
(11, 'Vaccination Statistics 2023', 'Vaccination', 'Dr. Sofia Matsumoto', '2023-01-05', 'Global statistics on immunization rates.', 'Japanese', 'Western Pacific', 'Yes', 'https://who.int/reports/vaccine-stats'),
(12, 'Mental Health & Pandemics', 'Mental Health', 'Dr. Leah Chen', '2023-03-18', 'Mental health trends due to global crises.', 'English', 'Western Pacific', 'No', 'https://who.int/reports/mentalhealth-pandemics'),
(13, 'Yellow Fever Alert', 'Yellow Fever', 'Dr. Carlos Lima', '2017-05-12', 'Outbreak risk analysis for yellow fever.', 'Spanish', 'Americas', 'Yes', 'https://who.int/reports/yellow-fever'),
(14, 'Global Smoking Report 2022', 'Smoking', 'Dr. Henry Owen', '2022-09-22', 'Smoking patterns and policies worldwide.', 'English', 'Europe', 'Yes', 'https://who.int/reports/smoking-2022'),
(15, 'Nutrition Status in Children', 'Nutrition', 'Dr. Latha Menon', '2021-02-14', 'Malnutrition stats among children.', 'English', 'South-East Asia', 'Yes', 'https://who.int/reports/child-nutrition'),
(16, 'Antibiotic Resistance Threat', 'Antibiotic Resistance', 'Dr. Igor Petrov', '2020-11-30', 'Global threat from antibiotic misuse.', 'Russian', 'Europe', 'Yes', 'https://who.int/reports/antibiotic-threat'),
(17, 'Leprosy Elimination Programs', 'Leprosy', 'Dr. Ravi Patel', '2023-05-09', 'Progress in eliminating leprosy in Asia.', 'English', 'South-East Asia', 'Yes', 'https://who.int/reports/leprosy-asia'),
(18, 'Vaccine Hesitancy Report', 'Vaccination', 'Dr. Emily Roberts', '2023-06-12', 'Trends in vaccine hesitancy and trust.', 'English', 'Americas', 'Yes', 'https://who.int/reports/vaccine-hesitancy'),
(19, 'Maternal Mortality Update', 'Maternal Health', 'Dr. Grace Njeri', '2022-12-20', 'Statistics on maternal health in Africa.', 'Swahili', 'Africa', 'Yes', 'https://who.int/reports/maternal-mortality'),
(20, 'Air Pollution & Health', 'Environment', 'Dr. Kenji Watanabe', '2021-08-30', 'Impact of air quality on public health.', 'Japanese', 'Western Pacific', 'No', 'https://who.int/reports/air-pollution-health');

-- to display table data
select * from Reports;
-- to remove complete records from table
truncate table Reports;
-- to remove complete records and attributes from table
drop table if exists Reports;


-- Table-16 Research_Projects------------------------------------------------------------------------------------------------
create table Research_Projects(
ProjectID int primary key,
Title varchar(200) not null,
Country_ID int not null,
Lead_Researcher varchar(100),
Start_Date date,
End_Date date,
Status varchar(50),
Budget double,
Area_of_Focus varchar(100),
Sponsors_Orgs varchar(100),
foreign key (Country_ID) references Countries(CountryID)
);

-- Data for Research_Projects
insert into Research_Projects 
(ProjectID, Title, Country_ID, Lead_Researcher, Start_Date, End_Date, Status, Budget, Area_of_Focus, Sponsors_Orgs) 
values
(1, 'COVID-19 Vaccine Development', 1, 'Dr. Renu Sharma', '2020-03-01', '2021-12-15', 'Completed', 5000000, 'Vaccinology', 'ICMR'),
(2, 'AI for Disease Surveillance', 2, 'Dr. John Lee', '2021-05-10', '2023-04-20', 'Ongoing', 7500000, 'Epidemiology', 'CDC'),
(3, 'Malaria Eradication Trials', 3, 'Dr. Fernanda Souza', '2022-01-15', '2024-07-30', 'Ongoing', 4000000, 'Parasitology', 'PAHO'),
(4, 'TB Genome Research', 4, 'Dr. Liu Wei', '2019-06-01', '2022-12-31', 'Completed', 6200000, 'Microbiology', 'China CDC'),
(5, 'HIV Transmission Study', 5, 'Dr. Ayo Okafor', '2023-02-10', '2025-06-01', 'Active', 3500000, 'Virology', 'WHO'),
(6, 'Antibiotic Resistance Mapping', 6, 'Dr. Claudia Weber', '2020-09-01', '2023-08-31', 'Completed', 8000000, 'Public Health', 'Robert Koch Institute'),
(7, 'Mental Health Post-COVID', 7, 'Dr. Pierre Moreau', '2022-03-20', '2024-09-10', 'Ongoing', 2900000, 'Psychology', 'INSERM'),
(8, 'Autism in Youth', 8, 'Dr. Kenji Yamada', '2021-07-15', '2023-12-31', 'Ongoing', 2700000, 'Neuroscience', 'MHLW Japan'),
(9, 'Maternal Health Study', 9, 'Dr. Nandi Nkosi', '2020-01-01', '2022-05-01', 'Completed', 3100000, 'Obstetrics', 'South Africa Medical Council'),
(10, 'Cancer Biomarkers Project', 10, 'Dr. Olga Petrovna', '2022-02-15', '2024-11-15', 'Active', 9600000, 'Oncology', 'Russian Academy of Sciences'),
(11, 'Remote Care Models', 11, 'Dr. Michael Grant', '2021-03-10', '2023-03-09', 'Completed', 4500000, 'Telemedicine', 'Australian NIH'),
(12, 'Hepatitis B Vaccine Study', 12, 'Dr. Arif Rahman', '2022-05-05', '2025-01-01', 'Ongoing', 3200000, 'Virology', 'BRAC'),
(13, 'Nutrition and Anemia in Children', 13, 'Dr. Sofia Jiménez', '2021-08-01', '2023-08-01', 'Completed', 2800000, 'Nutrition', 'UNICEF'),
(14, 'Alzheimer’s Biomarker Discovery', 14, 'Dr. Anne Tremblay', '2020-10-15', '2023-10-14', 'Completed', 6900000, 'Neurology', 'CIHR'),
(15, 'Obesity Trends in Teens', 15, 'Dr. Luca Romano', '2021-09-01', '2024-02-15', 'Ongoing', 3100000, 'Pediatrics', 'EIT Health'),
(16, 'Diabetes Prevention Program', 16, 'Dr. Saima Malik', '2020-06-10', '2023-06-09', 'Completed', 4000000, 'Endocrinology', 'Pakistan NIH'),
(17, 'Air Pollution and Asthma', 17, 'Dr. Adi Wibowo', '2022-04-01', '2024-10-01', 'Active', 3600000, 'Environmental Health', 'WHO'),
(18, 'Zika Birth Defect Study', 18, 'Dr. Carla Fernández', '2018-02-15', '2021-09-30', 'Completed', 2300000, 'Pediatrics', 'PAHO'),
(19, 'COVID Variant Genomics', 19, 'Dr. Olivia Clarke', '2021-01-01', '2023-06-15', 'Completed', 7200000, 'Genomics', 'UKHSA'),
(20, 'Waterborne Disease Tracking', 20, 'Dr. Mesfin Bekele', '2022-07-10', '2024-12-01', 'Ongoing', 2500000, 'Epidemiology', 'Ethiopian PHI');

-- to display table data
select * from Research_Projects;
-- to remove complete records from table
truncate table Research_Projects;
-- to remove complete records and attributes from table
drop table if exists Research_Projects;


-- Table-17 Medicines--------------------------------------------------------------------------------------------------------
create table Medicines(
MedicineID int primary key,
Name varchar(100) not null,
Used_For varchar(100),
Manufacturer varchar(100),
Approval_date date,
Side_Effects text,
Dosage_Info text,
Availability varchar(3) default 'Yes' check (Availability in ('Yes','No')),
Expiry_Years int check (Expiry_Years > 0),
WHO_Approved varchar(3) default 'Yes' check (WHO_Approved in ('Yes','No'))
);

-- Data for Medicines
insert into Medicines 
(MedicineID, Name, Used_For, Manufacturer, Approval_Date, Side_Effects, Dosage_Info, Availability, Expiry_Years, WHO_Approved) 
values
(1, 'Paracetamol', 'Fever and Pain', 'GSK', '1995-03-10', 'Nausea, Rash', '500mg every 6 hours', 'Yes', 3, 'Yes'),
(2, 'Remdesivir', 'COVID-19', 'Gilead Sciences', '2020-05-01', 'Liver inflammation, Nausea', '200mg IV on day 1, then 100mg IV daily', 'Yes', 2, 'Yes'),
(3, 'Ivermectin', 'Parasitic Infections', 'Merck', '1987-07-15', 'Dizziness, Nausea', '200mcg/kg once', 'Yes', 4, 'Yes'),
(4, 'Azithromycin', 'Bacterial Infections', 'Pfizer', '1991-06-01', 'Diarrhea, Vomiting', '500mg on day 1, then 250mg for 4 days', 'Yes', 3, 'Yes'),
(5, 'Hydroxychloroquine', 'Malaria, Autoimmune', 'Sanofi', '1955-10-20', 'Vision changes, Nausea', '400mg daily', 'Yes', 5, 'Yes'),
(6, 'Oseltamivir', 'Influenza', 'Roche', '1999-10-01', 'Vomiting, Headache', '75mg twice daily for 5 days', 'Yes', 3, 'Yes'),
(7, 'Metformin', 'Type 2 Diabetes', 'Merck', '1994-01-05', 'Nausea, Metallic taste', '500-1000mg twice daily', 'Yes', 5, 'Yes'),
(8, 'Rifampicin', 'Tuberculosis', 'Sanofi Aventis', '1971-11-25', 'Liver issues, Red urine', '600mg once daily', 'Yes', 3, 'Yes'),
(9, 'Lopinavir/Ritonavir', 'HIV/AIDS', 'AbbVie', '2000-04-12', 'Diarrhea, Fatigue', '400mg/100mg twice daily', 'Yes', 3, 'Yes'),
(10, 'Zinc Sulphate', 'Diarrhea, Immunity', 'Cipla', '2004-02-20', 'Stomach upset', '20mg once daily for 10 days', 'Yes', 2, 'Yes'),
(11, 'Amoxicillin', 'Bacterial Infections', 'GSK', '1972-03-15', 'Rash, Diarrhea', '500mg every 8 hours', 'Yes', 4, 'Yes'),
(12, 'Dexamethasone', 'Inflammation, COVID-19', 'Bayer', '1980-06-30', 'Insomnia, Mood changes', '6mg once daily for 10 days', 'Yes', 4, 'Yes'),
(13, 'Tenofovir', 'HIV/AIDS, Hepatitis B', 'Gilead', '2001-10-05', 'Nausea, Kidney issues', '300mg once daily', 'Yes', 5, 'Yes'),
(14, 'Chloroquine', 'Malaria', 'Bayer', '1945-04-15', 'Vision issues, Nausea', '500mg weekly', 'Yes', 3, 'Yes'),
(15, 'Albendazole', 'Worm Infections', 'Cipla', '1990-08-01', 'Dizziness, Nausea', '400mg single dose', 'Yes', 3, 'Yes'),
(16, 'Ciprofloxacin', 'UTI, Respiratory Infection', 'Bayer', '1987-05-20', 'Nausea, Dizziness', '500mg twice daily for 5 days', 'Yes', 4, 'Yes'),
(17, 'Artemether-Lumefantrine', 'Malaria', 'Novartis', '2001-11-14', 'Headache, Fatigue', '4 tablets twice daily for 3 days', 'Yes', 2, 'Yes'),
(18, 'Prednisone', 'Autoimmune disorders', 'Pfizer', '1955-12-01', 'Weight gain, Mood swings', '5-60mg daily', 'Yes', 4, 'Yes'),
(19, 'Fluconazole', 'Fungal Infections', 'Pfizer', '1990-02-20', 'Headache, Nausea', '150mg once weekly', 'Yes', 3, 'Yes'),
(20, 'Enalapril', 'Hypertension', 'Merck', '1985-09-12', 'Cough, Dizziness', '5-20mg daily', 'Yes', 4, 'Yes');

-- to display table data
select * from Medicines;
-- to remove complete records from table
truncate table Medicines;
-- to remove complete records and attributes from table
drop table if exists Medicines;


-- Table-18 Health_Indicators------------------------------------------------------------------------------------------------
create table Health_Indicators(
IndicatorID int primary key,
Country_ID int not null,
Year date check (year >= '2000-01-01'),
Life_Expectancy float,
Infant_Mortality float,
Health_Expenditure_Per_capita double,
Access_To_Sanitation float,
Doctor_Patient_Ratio float,
Child_Mortality_Rate float,
Smoking_Rate float,
foreign key (Country_ID) references Countries(CountryID)
);

-- Data for Health_Indicators
insert into Health_Indicators 
(IndicatorID, Country_ID, Year, Life_Expectancy, Infant_Mortality, Health_Expenditure_Per_capita, Access_To_Sanitation, Doctor_Patient_Ratio, Child_Mortality_Rate, Smoking_Rate)
values
(1, 1, '2022-01-01', 70.8, 28.3, 63.2, 60.5, 0.65, 32.1, 11.2),
(2, 2, '2022-01-01', 79.1, 5.6, 11208.3, 99.2, 2.6, 6.1, 15.5),
(3, 3, '2022-01-01', 75.4, 12.1, 948.5, 83.7, 1.2, 14.4, 14.0),
(4, 4, '2022-01-01', 76.9, 7.4, 5012.6, 95.6, 2.0, 8.1, 26.4),
(5, 5, '2022-01-01', 54.3, 67.1, 84.2, 34.6, 0.25, 88.4, 3.7),
(6, 6, '2022-01-01', 81.0, 3.1, 5387.9, 99.7, 4.3, 3.9, 22.5),
(7, 7, '2022-01-01', 82.7, 3.5, 4503.3, 98.1, 3.9, 4.1, 27.1),
(8, 8, '2022-01-01', 84.5, 1.9, 4821.2, 100.0, 2.6, 2.0, 18.8),
(9, 9, '2022-01-01', 63.2, 27.0, 526.3, 75.5, 0.55, 42.6, 20.2),
(10, 10, '2022-01-01', 73.4, 7.9, 1536.7, 92.4, 4.2, 11.0, 30.5),
(11, 11, '2022-01-01', 83.1, 3.6, 5462.5, 99.6, 3.8, 4.3, 14.6),
(12, 12, '2022-01-01', 72.1, 27.3, 100.5, 60.2, 0.6, 35.4, 8.2),
(13, 13, '2022-01-01', 75.2, 11.0, 561.7, 79.8, 1.4, 16.8, 15.7),
(14, 14, '2022-01-01', 82.3, 4.5, 4963.3, 98.9, 2.9, 5.5, 16.1),
(15, 15, '2022-01-01', 83.5, 3.2, 3842.6, 99.1, 3.4, 4.8, 23.0),
(16, 16, '2022-01-01', 66.4, 55.3, 37.8, 54.1, 0.35, 67.0, 9.0),
(17, 17, '2022-01-01', 72.6, 24.7, 118.2, 68.4, 0.4, 36.2, 35.4),
(18, 18, '2022-01-01', 76.8, 9.7, 947.3, 86.2, 2.2, 12.1, 22.2),
(19, 19, '2022-01-01', 81.2, 3.9, 3921.0, 99.7, 3.2, 5.0, 17.6),
(20, 20, '2022-01-01', 65.0, 39.4, 28.5, 28.1, 0.23, 53.2, 4.3);

-- to display table data
select * from Health_Indicators;
-- to remove complete records from table
truncate table Health_Indicators;
-- to remove complete records and attributes from table
drop table if exists Health_Indicators;


-- Table-19 Funding----------------------------------------------------------------------------------------------------------
create table Funding(
FundID int primary key,
Source varchar(100),
Type varchar(50),
Amount double check (Amount >= 0),
Currency varchar(10),
Year int check (year >= 2000),
Country_ID int not null,
Purpose varchar(100),
Program_ID int not null,
Notes text,
foreign key (Country_ID) references Countries(CountryID),
foreign key (Program_ID) references Programs(ProgramID)
);

-- Data for Funding
insert into Funding 
(FundID, Source, Type, Amount, Currency, Year, Country_ID, Purpose, Program_ID, Notes)
values
(1, 'WHO', 'Grant', 500000.00, 'USD', 2022, 1, 'COVID-19 Vaccination Program', 1, 'Allocated for Phase 1 rollout'),
(2, 'UNICEF', 'Aid', 300000.00, 'USD', 2021, 2, 'Child Health Program', 2, 'Used for mobile health clinics'),
(3, 'Bill & Melinda Gates Foundation', 'Donation', 750000.00, 'USD', 2023, 3, 'Malaria Eradication', 3, 'Focused on remote rural areas'),
(4, 'USAID', 'Grant', 200000.00, 'USD', 2020, 4, 'HIV Prevention Initiative', 4, 'Awareness and testing'),
(5, 'Global Fund', 'Loan', 400000.00, 'EUR', 2021, 5, 'Tuberculosis Control', 5, 'Drugs and diagnostics'),
(6, 'World Bank', 'Loan', 900000.00, 'USD', 2022, 6, 'Hospital Infrastructure Upgrade', 6, 'Phase 2 expansion'),
(7, 'GAVI', 'Aid', 650000.00, 'USD', 2023, 7, 'Measles Immunization Campaign', 7, 'National coverage'),
(8, 'WHO', 'Grant', 250000.00, 'INR', 2022, 8, 'Health Worker Training', 8, 'Targeting rural regions'),
(9, 'CDC', 'Donation', 180000.00, 'USD', 2021, 9, 'Disease Surveillance Systems', 9, 'Integrated digital monitoring'),
(10, 'UNDP', 'Aid', 300000.00, 'ZAR', 2022, 10, 'Primary Care Strengthening', 10, 'Urban slum health'),
(11, 'USAID', 'Loan', 420000.00, 'AUD', 2023, 11, 'Water and Sanitation', 11, 'Focus on indigenous populations'),
(12, 'World Bank', 'Grant', 600000.00, 'BDT', 2021, 12, 'Maternal Health Initiative', 12, 'Implemented in 4 districts'),
(13, 'UNICEF', 'Aid', 320000.00, 'MXN', 2020, 13, 'School Health Program', 13, 'Vaccination and nutrition'),
(14, 'WHO', 'Donation', 480000.00, 'CAD', 2023, 14, 'Digital Health Systems', 14, 'Pilot project'),
(15, 'GAVI', 'Grant', 150000.00, 'EUR', 2022, 15, 'Vaccine Logistics', 15, 'Cold chain management'),
(16, 'Global Fund', 'Loan', 820000.00, 'PKR', 2021, 16, 'Polio Eradication Campaign', 16, 'Door-to-door campaigns'),
(17, 'Bill & Melinda Gates Foundation', 'Donation', 910000.00, 'IDR', 2022, 17, 'Family Planning Services', 17, 'Rural community outreach'),
(18, 'CDC', 'Aid', 340000.00, 'ARS', 2020, 18, 'Zoonotic Disease Control', 18, 'Training veterinarians'),
(19, 'UNDP', 'Grant', 275000.00, 'GBP', 2023, 19, 'Emergency Response Planning', 19, 'Simulation exercises'),
(20, 'WHO', 'Loan', 530000.00, 'ETB', 2021, 20, 'Hospital Equipment Upgrade', 20, 'Diagnostic and imaging devices');

-- to display table data
select * from Funding;
-- to remove complete records from table
truncate table Funding;
-- to remove complete records and attributes from table
drop table if exists Funding;


-- Table-20 Fund_Distribution------------------------------------------------------------------------------------------------
create table Fund_Distribution(
DistributionID int primary key,
Fund_ID int not null,
Country_ID int not null,
Program_ID int not null,
Amount double check (Amount >= 0),
Date_Allocated date,
Approved_By varchar(100),
Status varchar(50) default 'Released' check (Status in ('Released','Pending')),
Remarks text,
TrackingID varchar(50) unique,
foreign key (Fund_ID) references Funding(FundID),
foreign key (Country_ID) references Countries(CountryID),
foreign key (Program_ID) references Programs(ProgramID)
);

-- Data for Fund_Distribution
insert into Fund_Distribution 
(DistributionID, Fund_ID, Country_ID, Program_ID, Amount, Date_Allocated, Approved_By, Status, Remarks, TrackingID) 
values
(1, 1, 1, 1, 300000.00, '2022-03-15', 'Ministry of Health India', 'Released', 'First phase allocation', 'FD-IND-001'),
(2, 2, 2, 2, 250000.00, '2021-07-10', 'CDC USA', 'Released', 'Allocated to Southern regions', 'FD-USA-002'),
(3, 3, 3, 3, 200000.00, '2022-01-20', 'Brazil Health Dept.', 'Pending', 'Awaiting release approval', 'FD-BRA-003'),
(4, 4, 4, 4, 180000.00, '2022-06-01', 'China CDC', 'Released', 'Focus on high-risk zones', 'FD-CHN-004'),
(5, 5, 5, 5, 100000.00, '2023-02-12', 'Nigeria MoH', 'Released', 'Final disbursement for program', 'FD-NIG-005'),
(6, 6, 6, 6, 220000.00, '2021-11-30', 'German Health Agency', 'Released', 'Jointly monitored by WHO', 'FD-GER-006'),
(7, 7, 7, 7, 150000.00, '2022-09-18', 'French Ministry of Health', 'Released', 'Used for rural sanitation', 'FD-FRA-007'),
(8, 8, 8, 8, 70000.00, '2023-04-10', 'Japan Disaster Office', 'Released', 'Mental health support post-disaster', 'FD-JPN-008'),
(9, 9, 9, 9, 135000.00, '2023-05-05', 'South Africa CDC', 'Released', 'Focus on maternal care', 'FD-RSA-009'),
(10, 10, 10, 10, 170000.00, '2022-10-20', 'Russia Health Council', 'Pending', 'Stalled due to sanctions', 'FD-RUS-010'),
(11, 11, 11, 11, 90000.00, '2021-08-01', 'Australia DoH', 'Released', 'Vaccine cold chain support', 'FD-AUS-011'),
(12, 12, 12, 12, 80000.00, '2022-12-15', 'Bangladesh Health Bureau', 'Released', 'Used for nutrition kits', 'FD-BAN-012'),
(13, 13, 13, 13, 95000.00, '2023-01-10', 'Mexico MoH', 'Released', 'Refugee clinics setup', 'FD-MEX-013'),
(14, 14, 14, 14, 43000.00, '2022-11-25', 'Health Canada', 'Released', 'Tobacco awareness campaign', 'FD-CAN-014'),
(15, 15, 15, 15, 160000.00, '2023-03-20', 'Italy MoPH', 'Released', 'Installation of clean water units', 'FD-ITA-015'),
(16, 16, 16, 16, 50000.00, '2023-05-30', 'Pakistan Disaster Unit', 'Pending', 'Clinic equipment pending clearance', 'FD-PAK-016'),
(17, 17, 17, 17, 43000.00, '2023-06-01', 'Indonesia eHealth Cell', 'Released', 'Digital health kiosks in villages', 'FD-INDO-017'),
(18, 18, 18, 18, 78000.00, '2022-04-12', 'Argentina MoH', 'Released', 'Insecticide distribution phase 2', 'FD-ARG-018'),
(19, 19, 19, 19, 95000.00, '2023-02-28', 'UK Zoonotic Research Office', 'Released', 'Wildlife surveillance program', 'FD-UK-019'),
(20, 20, 20, 20, 105000.00, '2023-06-15', 'Ethiopia Vaccine Agency', 'Released', 'Cold chain logistics implemented', 'FD-ETH-020');

-- to display table data
select * from Fund_Distribution;
-- to remove complete records from table
truncate table Fund_Distribution;
-- to remove complete records and attributes from table
drop table if exists Fund_Distribution;


-- Table-21 Health_Campaigns-------------------------------------------------------------------------------------------------
create table Health_Campaigns(
CamapignID int primary key,
Name varchar(100) ,
Disease_ID int not null,
Country_ID int not null,
Start_Date date,
End_Date date,
Target_Group varchar(50) check (Target_Group in ('Children','Adults','Elders')),
Medium varchar(50),
Reach_Estimate int,
Feedback text,
foreign key (Disease_ID) references Diseases(DiseaseID),
foreign key (Country_ID) references Countries(CountryID)
);

-- Data for Health_Campaigns
insert into Health_Campaigns
( CamapignID, Name, Disease_ID, Country_ID, Start_Date, End_Date, Target_Group, Medium, Reach_Estimate, Feedback)
values
(1, 'Stop the Spread: COVID-19 Awareness', 1, 1, '2020-03-01', '2021-03-01', 'Adults', 'TV, Social Media', 10000000, 'Effective in urban areas'),
(2, 'End Malaria Now', 2, 5, '2019-05-01', '2020-12-31', 'Children', 'Radio, Posters', 5000000, 'Improved prevention behaviors'),
(3, 'TB-Free India Drive', 3, 1, '2021-01-01', '2022-06-01', 'Adults', 'Mobile Vans, Print', 3000000, 'Good response in rural zones'),
(4, 'Flu Shot Promotion', 4, 2, '2020-10-01', '2021-01-31', 'Elders', 'TV, Clinics', 1200000, 'Moderate vaccination uptake'),
(5, 'HIV Safe Practices Campaign', 5, 6, '2018-07-01', '2019-06-01', 'Adults', 'Social Media, Clinics', 2200000, 'Effective among youth'),
(6, 'Clean Water = No Cholera', 6, 12, '2022-01-01', '2022-12-31', 'Children', 'Schools, NGOs', 1500000, 'Improved sanitation habits'),
(7, 'Dengue Alert Week', 7, 17, '2021-08-01', '2021-08-15', 'Adults', 'Text SMS, Flyers', 700000, 'Helped reduce local cases'),
(8, 'Ebola Awareness Tour', 8, 5, '2015-03-01', '2015-06-01', 'Adults', 'Community Centers', 900000, 'Critical early containment'),
(9, 'Zika Virus Information Series', 9, 13, '2016-04-01', '2016-07-01', 'Children', 'Radio, Print', 800000, 'Moderate reach'),
(10, 'Mask Up: MERS Awareness', 10, 4, '2014-12-01', '2015-03-01', 'Elders', 'TV, Social Media', 2000000, 'Strong engagement'),
(11, 'Measles Vaccine Rally', 11, 7, '2020-01-01', '2020-03-01', 'Children', 'Schools, Clinics', 1800000, 'Good turnout'),
(12, 'Polio Eradication Walkathon', 12, 1, '2019-11-01', '2019-11-15', 'Children', 'Community Drives', 2500000, 'High impact in metros'),
(13, 'Tetanus Awareness Day', 13, 19, '2021-09-01', '2021-09-02', 'Adults', 'Health Centers', 350000, 'Low awareness observed'),
(14, 'Hepatitis B Prevention Month', 14, 3, '2020-07-01', '2020-07-31', 'Elders', 'Hospitals, News Ads', 400000, 'High-risk group reached'),
(15, 'Yellow Fever Vaccine Awareness', 15, 5, '2018-01-01', '2018-02-15', 'Adults', 'NGO Volunteers', 800000, 'Needed booster round'),
(16, 'Leprosy Education Drive', 16, 1, '2022-05-01', '2022-06-01', 'Adults', 'Panchayats, Print', 950000, 'Stigma reduction noticed'),
(17, 'Mumps Alert Campaign', 17, 14, '2019-02-01', '2019-04-01', 'Children', 'Schools, Clinics', 600000, 'High vaccine response'),
(18, 'Rabies Prevention Week', 18, 8, '2021-09-28', '2021-10-04', 'Children', 'Vet Centers, Flyers', 300000, 'Local vaccination up'),
(19, 'Typhoid Vaccine Awareness', 19, 11, '2023-01-01', '2023-03-01', 'Adults', 'Digital Boards, Radio', 500000, 'Boosted preventive testing'),
(20, 'Hepatitis C Testing Camp', 20, 2, '2022-07-01', '2022-09-01', 'Elders', 'Clinics, Social Media', 450000, 'Good urban feedback');

-- to display table data
select * from Health_Campaigns;
-- to remove complete records from table
truncate table Health_Campaigns;
-- to remove complete records and attributes from table
drop table if exists Health_Campaigns;


-- Table-22 Policy_Guidelines------------------------------------------------------------------------------------------------
create table Policy_Guidelines(
GuidelineID int primary key,
Title varchar(200) not null,
Disease_ID int not null,
Date_Issued date,
Document_URL text,
Language varchar(50),
Region varchar(50),
Approved_By varchar(100),
Description text,
Revision_History text,
foreign key (Disease_ID) references Diseases(DiseaseID)
);

-- Data for Policy_Guidelines
insert into Policy_Guidelines
(GuidelineID, Title, Disease_ID, Date_Issued, Document_URL, Language, Region, Approved_By, Description, Revision_History)
values
(1, 'COVID-19 Containment Measures', 1, '2020-03-15', 'https://healthgov.org/covid19-guidelines', 'English', 'South-East Asia', 'Ministry of Health India', 'Guidelines on COVID-19 prevention and lockdown protocols.', 'Rev 2 – Updated social distancing norms'),
(2, 'Malaria Treatment Protocol', 2, '2018-06-10', 'https://africacdc.org/malaria-guide', 'English', 'Africa', 'Africa CDC', 'Diagnosis and treatment of malaria including drug combinations.', 'Rev 1 – Added resistance management'),
(3, 'Tuberculosis Case Management', 3, '2019-01-20', 'https://indiahealth.gov/tb-care', 'Hindi', 'South-East Asia', 'Govt. of India TB Program', 'TB case detection, drug regimen, and DOTS guidelines.', 'Rev 3 – Pediatric protocol added'),
(4, 'Influenza Seasonal Preparedness', 4, '2017-10-01', 'https://cdc.gov/flu-seasonal', 'English', 'Americas', 'US CDC', 'Preparedness for flu outbreaks including vaccination drive.', 'Rev 4 – Coverage for children expanded'),
(5, 'HIV/AIDS Response Strategy', 5, '2021-07-01', 'https://who.int/hiv-response', 'English', 'Africa', 'UNAIDS', 'Testing, ART access, and awareness programs for HIV.', 'Rev 5 – PrEP rollout strategy'),
(6, 'Cholera Emergency Response Plan', 6, '2016-04-05', 'https://who.int/cholera-emergency', 'French', 'Africa', 'WHO Africa Region', 'Cholera outbreak handling and water safety protocol.', 'Rev 2 – Rapid testing included'),
(7, 'Dengue Prevention Framework', 7, '2019-11-12', 'https://indonesiagov.id/dengue-policy', 'Indonesian', 'South-East Asia', 'Indonesia MoH', 'Community-based dengue vector control measures.', 'Rev 1 – Larvicide use guidelines'),
(8, 'Ebola Virus Outbreak Response', 8, '2014-10-25', 'https://who.int/ebola-guidance', 'English', 'Africa', 'WHO Emergency Committee', 'Outbreak containment and PPE guidelines.', 'Rev 6 – Treatment center protocols updated'),
(9, 'Zika Virus Guidelines', 9, '2016-02-01', 'https://panamericancdc.org/zika', 'Spanish', 'Americas', 'PAHO', 'Zika screening and pregnancy risk mitigation.', 'Rev 3 – Added new transmission cases'),
(10, 'MERS-CoV Hospital Guidelines', 10, '2015-08-18', 'https://saudigov.sa/mers-control', 'Arabic', 'Western Pacific', 'Saudi MoH', 'Hospital triage and isolation for MERS-CoV.', 'Rev 2 – Travel screening protocol'),
(11, 'Measles Vaccination Policy', 11, '2018-03-30', 'https://euro.who.int/measles-vaccine', 'English', 'Europe', 'WHO Europe', 'Routine immunization strategy for measles prevention.', 'Rev 1 – Cold chain logistics updated'),
(12, 'Polio Eradication Guidelines', 12, '2017-01-01', 'https://globalpolio.org/eradication-policy', 'English', 'South-East Asia', 'Global Polio Eradication Initiative', 'Polio surveillance and mass immunization.', 'Rev 4 – IPV transition plan'),
(13, 'Tetanus Vaccination Strategy', 13, '2019-05-15', 'https://who.org/tetanus-policy', 'English', 'Africa', 'WHO-Africa', 'Maternal and neonatal tetanus elimination strategies.', 'Rev 2 – Boost dose recommendations'),
(14, 'Hepatitis B Prevention Policy', 14, '2020-02-10', 'https://usahealth.gov/hepb-guidelines', 'English', 'Americas', 'US Health Dept.', 'Screening, vaccination, and counseling for Hep B.', 'Rev 1 – Added pregnant mother coverage'),
(15, 'Yellow Fever Vaccination Rules', 15, '2015-06-01', 'https://africacdc.org/yellow-fever-policy', 'French', 'Africa', 'Africa CDC', 'Travel-related yellow fever immunization guidelines.', 'Rev 3 – Travel pass coordination'),
(16, 'Leprosy Treatment Guidance', 16, '2018-07-20', 'https://india.gov/leprosy-management', 'Hindi', 'South-East Asia', 'National Leprosy Elimination Program', 'Treatment guidelines using MDT.', 'Rev 2 – Awareness materials added'),
(17, 'Mumps Containment Policy', 17, '2021-09-05', 'https://ukhealth.gov.uk/mumps', 'English', 'Europe', 'UK Health Agency', 'Mumps outbreak management in schools.', 'Rev 1 – School vaccination clarified'),
(18, 'Rabies Post-Bite Protocol', 18, '2020-11-11', 'https://japan.gov/rabies-protocol', 'Japanese', 'Western Pacific', 'Japan Health Agency', 'Animal bite response and rabies vaccine protocol.', 'Rev 2 – Quarantine procedures added'),
(19, 'Typhoid Prevention Guidelines', 19, '2023-01-01', 'https://ausgov.au/typhoid-control', 'English', 'Western Pacific', 'Australia MoH', 'Public hygiene and typhoid vaccination plan.', 'Rev 1 – School screening added'),
(20, 'Hepatitis C Testing & Care', 20, '2022-03-21', 'https://canada.ca/hepC-policy', 'English/French', 'Americas', 'Canada Health Board', 'Screening of high-risk groups and drug therapy access.', 'Rev 2 – Testing guidelines updated');

-- to display table data
select * from Policy_Guidelines;
-- to remove complete records from table
truncate table Policy_Guidelines;
-- to remove complete records and attributes from table
drop table if exists Policy_Guidelines;


-- Table-23 Countries_Health_Policies----------------------------------------------------------------------------------------
create table Countries_Health_Policies(
PolicyID int primary key,
Country_ID int not null,
Title varchar(200),
Implemented_Date date,
Policy_Text text,
Status varchar(50),
Last_Reviewed date,
Ministry varchar(100),
Updated_By varchar(100),
Notes text,
foreign key (Country_ID) references Countries(CountryID)
);

-- Data for Countries_Health_Policies
insert into Countries_Health_Policies
(PolicyID, Country_ID, Title, Implemented_Date, Policy_Text, Status, Last_Reviewed, Ministry, Updated_By, Notes)
values
(1, 1, 'National Health Mission', '2005-04-01', 'Improving rural and urban health services across India.', 'Active', '2024-02-01', 'Ministry of Health and Family Welfare', 'Dr. Neha Sharma', 'Includes AYUSH integration.'),
(2, 2, 'Affordable Care Act', '2010-03-23', 'Expand health coverage and reduce costs for Americans.', 'Active', '2023-12-10', 'Department of Health and Human Services', 'Dr. James Coleman', 'Covers Medicaid expansion.'),
(3, 3, 'Unified Health System Reform', '2003-07-15', 'Reform for equitable healthcare across Brazil.', 'Active', '2024-01-15', 'Ministry of Health Brazil', 'Dr. Ana Souza', 'Decentralized model.'),
(4, 4, 'Healthy China 2030', '2016-10-25', 'Strategic framework for improving national health.', 'Active', '2024-06-30', 'National Health Commission', 'Dr. Wei Zhang', 'Focus on non-communicable diseases.'),
(5, 5, 'National Health Development Plan', '2012-05-01', 'Enhancing primary care access and public health.', 'Ongoing', '2023-11-20', 'Federal Ministry of Health Nigeria', 'Dr. Bako Musa', 'Supported by WHO.'),
(6, 6, 'Healthcare Digitalization Policy', '2018-01-01', 'Modernizing healthcare records and e-services.', 'Active', '2024-03-05', 'Federal Ministry of Health Germany', 'Dr. Jonas Becker', 'EHR implementation.'),
(7, 7, 'Public Health Strategy 2030', '2020-06-01', 'Preventive and curative care improvements.', 'Active', '2024-04-18', 'Ministry of Health France', 'Dr. Léa Dubois', 'Mental health added in 2023.'),
(8, 8, 'Universal Health Insurance Act', '2012-04-10', 'Achieving 100% coverage through mandatory insurance.', 'Active', '2023-12-12', 'Ministry of Health Japan', 'Dr. Haruki Tanaka', 'Cost control emphasis.'),
(9, 9, 'South Africa Health Revamp', '2015-09-20', 'Improving rural and urban health infrastructure.', 'Ongoing', '2024-01-08', 'South African Dept. of Health', 'Dr. Thabo Nkosi', 'Includes mobile clinics.'),
(10, 10, 'National Healthcare Policy', '2001-03-30', 'Strengthen emergency and preventive care.', 'Revised', '2023-08-25', 'Russian Ministry of Health', 'Dr. Olga Ivanova', 'Post-COVID revision included.'),
(11, 11, 'MyHealth Record Policy', '2017-07-01', 'Electronic health record access for all Australians.', 'Active', '2024-02-15', 'Australian Dept. of Health', 'Dr. Ethan Campbell', 'Data privacy updated.'),
(12, 12, 'Community Clinic Program', '2010-05-10', 'Healthcare access for low-income rural families.', 'Active', '2024-03-12', 'Bangladesh Ministry of Health', 'Dr. Farhana Rahman', 'Scaled up in 2022.'),
(13, 13, 'Seguro Popular Reform', '2016-01-20', 'Overhaul of public health insurance in Mexico.', 'Revised', '2023-09-05', 'Mexico Health Secretariat', 'Dr. Carlos Jimenez', 'Expanded access in 2019.'),
(14, 14, 'Canada Health Transfer Plan', '2004-04-01', 'Financial transfers for provincial healthcare.', 'Active', '2023-10-01', 'Health Canada', 'Dr. Sophia Tremblay', 'Supports Medicare sustainability.'),
(15, 15, 'Healthcare for All Initiative', '2011-08-30', 'National health access through public hospitals.', 'Active', '2024-01-25', 'Italian Ministry of Health', 'Dr. Marco Bianchi', 'Extended maternity care.'),
(16, 16, 'Health Vision 2025', '2018-12-01', 'Integrated disease surveillance and care network.', 'Active', '2024-03-20', 'Pakistan Ministry of Health', 'Dr. Ayesha Malik', 'Post-polio integration added.'),
(17, 17, 'Indonesia Sehat Program', '2015-06-15', 'National health card and universal coverage.', 'Ongoing', '2024-05-10', 'Ministry of Health Indonesia', 'Dr. Agus Widodo', 'Mobile unit expansion in 2023.'),
(18, 18, 'Universal Medical Coverage Bill', '2013-10-01', 'Ensure affordable care for all Argentinians.', 'Active', '2024-02-01', 'Ministry of Health Argentina', 'Dr. Lucia Romero', 'Cancer care module added.'),
(19, 19, 'UK National Health Plan 2040', '2021-01-01', 'Future-proofing NHS and preventive services.', 'Planning', '2024-04-01', 'UK Dept. of Health and Social Care', 'Dr. Henry Moore', 'Climate impact chapter added.'),
(20, 20, 'Ethiopia Essential Health Services', '2008-03-01', 'Expand access to maternal and child care.', 'Active', '2023-12-20', 'Ethiopia Ministry of Health', 'Dr. Tadesse Mekonnen', 'Midwives training added.');

-- to display table data
select * from Countries_Health_Policies;
-- to remove complete records from table
truncate table Countries_Health_Policies;
-- to remove complete records and attributes from table
drop table if exists Countries_Health_Policies;


-- Table-24 Global_Health_Alerts---------------------------------------------------------------------------------------------
create table Global_Health_Alerts(
AlertID int primary key,
Title varchar(200),
Date_Issued date,
Region_Affected varchar(100),
Alert_Level varchar(50) check (Alert_Level in ('Low', 'Moderate', 'High', 'Critical')),
Disease_ID int not null,
Description text,
Source varchar(100),
Expiry_Date date,
Notes text,
foreign key (Disease_ID) references Diseases(DiseaseID)
);

-- Data for Global_Health_Alerts
insert into Global_Health_Alerts
(AlertID, Title, Date_Issued, Region_Affected, Alert_Level, Disease_ID, Description, Source, Expiry_Date, Notes)
values
(1, 'COVID-19 Global Surge', '2020-03-15', 'Western Pacific', 'Critical', 1, 'Rapid spread of COVID-19 across Asia-Pacific.', 'WHO', '2021-12-31', 'Follow WHO guidelines.'),
(2, 'Malaria Spike in Africa', '2021-06-01', 'Africa', 'High', 2, 'Rising malaria cases in Sub-Saharan region.', 'UNICEF', '2021-12-01', 'Mosquito nets distribution planned.'),
(3, 'TB Resistance Alert', '2022-04-10', 'Europe', 'Moderate', 3, 'Increased multi-drug resistant TB cases.', 'CDC Europe', '2022-12-31', 'Need rapid diagnostics.'),
(4, 'Seasonal Flu Outbreak', '2023-01-01', 'Europe', 'Low', 4, 'Flu season started early this year.', 'ECDC', '2023-03-31', 'Vaccination recommended.'),
(5, 'HIV/AIDS Awareness Push', '2021-12-01', 'Americas', 'Moderate', 5, 'Awareness campaigns in high-risk groups.', 'UNAIDS', '2022-05-31', 'Part of World AIDS Day initiative.'),
(6, 'Cholera Epidemic Risk', '2020-08-20', 'South-East Asia', 'High', 6, 'Cholera outbreak in low-sanitation zones.', 'WHO SEARO', '2021-02-28', 'Water purification support needed.'),
(7, 'Dengue Risk Rising', '2022-06-01', 'Western Pacific', 'Moderate', 7, 'Dengue fever spreading after monsoons.', 'Ministry of Health Japan', '2022-09-30', 'Public urged to avoid stagnant water.'),
(8, 'Ebola Containment Alert', '2019-12-15', 'Africa', 'Critical', 8, 'Ebola cases in DRC and surrounding areas.', 'WHO Africa', '2020-06-30', 'Emergency response teams activated.'),
(9, 'Zika Virus Watch', '2021-05-01', 'Americas', 'Low', 9, 'Mild reemergence of Zika in northern Brazil.', 'PAHO', '2021-08-01', 'Targeted mosquito control underway.'),
(10, 'MERS Watch in Middle East', '2023-04-20', 'Western Pacific', 'High', 10, 'MERS-CoV detection in travelers.', 'WHO EMRO', '2023-10-20', 'Enhanced screening at airports.'),
(11, 'Measles Alert in Schools', '2022-10-10', 'Europe', 'Moderate', 11, 'Measles outbreak linked to low immunization.', 'UNICEF Europe', '2023-01-31', 'Mass immunization drive planned.'),
(12, 'Polio Surveillance Intensified', '2021-07-15', 'South-East Asia', 'Moderate', 12, 'Polio virus detected in environmental samples.', 'WHO India', '2022-01-15', 'Door-to-door campaigns ongoing.'),
(13, 'Tetanus Threat in Disaster Zone', '2020-11-10', 'Africa', 'High', 13, 'Increased tetanus cases post-earthquake.', 'IFRC', '2021-03-01', 'Tetanus vaccines dispatched.'),
(14, 'Hepatitis B Screening Alert', '2022-03-12', 'Americas', 'Low', 14, 'Awareness week for HBV testing.', 'CDC USA', '2022-04-30', 'Free camps in low-income areas.'),
(15, 'Yellow Fever Travel Advisory', '2023-02-01', 'Africa', 'High', 15, 'Yellow fever detected in travelers from West Africa.', 'WHO', '2023-07-01', 'Vaccination required for entry.'),
(16, 'Leprosy Re-emergence Notice', '2020-05-01', 'South-East Asia', 'Low', 16, 'Localized cluster of leprosy cases.', 'Indian Medical Board', '2020-12-01', 'Routine monitoring advised.'),
(17, 'Mumps Clusters in Schools', '2023-08-01', 'Europe', 'Moderate', 17, 'Several outbreaks reported in UK schools.', 'UKHSA', '2023-10-15', 'Vaccination campaign underway.'),
(18, 'Rabies Control Alert', '2021-09-10', 'Americas', 'Low', 18, 'Dog bite cases increasing in rural zones.', 'PAHO', '2022-01-10', 'Community awareness campaigns started.'),
(19, 'Typhoid Multidrug Resistance', '2022-02-20', 'South-East Asia', 'High', 19, 'Drug-resistant strains in urban centers.', 'WHO SEARO', '2022-09-01', 'Guidelines for treatment updated.'),
(20, 'Hepatitis C Screening Drive', '2021-11-15', 'Europe', 'Moderate', 20, 'HCV detection increasing among older adults.', 'ECDC', '2022-04-01', 'Voluntary testing launched.');

-- to display table data
select * from Global_Health_Alerts;
-- to remove complete records from table
truncate table Global_Health_Alerts;
-- to remove complete records and attributes from table
drop table if exists Global_Health_Alerts;

-- Table-25 Collaborating_Organizations--------------------------------------------------------------------------------------
create table Collaborating_Organizations(
OrgID int primary key,
Name varchar(100) not null,
Type varchar(50),
Country_ID int not null,
Contact_Email varchar(100),
Phone varchar(20),
Website text,
Partnership_Date date,
Area_of_Work varchar(100),
Notes text,
foreign key (Country_ID) references Countries(CountryID)
);

-- Data for Collaborating_Organizations
insert into Collaborating_Organizations
(OrgID, Name, Type, Country_ID, Contact_Email, Phone, Website, Partnership_Date, Area_of_Work, Notes)
values
(1, 'Indian Red Cross Society', 'NGO', 1, 'contact@redcross.in', '+91-1123456789', 'https://www.indianredcross.org', '2010-05-15', 'Disaster Relief, Health', 'Active across all Indian states.'),
(2, 'CDC USA', 'Government', 2, 'info@cdc.gov', '+1-8002324636', 'https://www.cdc.gov', '2000-01-01', 'Disease Control', 'Leads national health responses.'),
(3, 'Oswaldo Cruz Foundation', 'Research', 3, 'contact@fiocruz.br', '+55-2139242200', 'https://portal.fiocruz.br', '2005-06-01', 'Biomedical Research', 'Supports Zika and Dengue research.'),
(4, 'China CDC', 'Government', 4, 'info@chinacdc.cn', '+86-1062175000', 'http://www.chinacdc.cn', '2003-01-01', 'Public Health Surveillance', 'Involved in COVID-19 response.'),
(5, 'Nigerian Centre for Disease Control', 'Government', 5, 'info@ncdc.gov.ng', '+234-8029876341', 'https://ncdc.gov.ng', '2011-07-01', 'Epidemiology', 'Frontline agency during Ebola outbreak.'),
(6, 'Robert Koch Institute', 'Research', 6, 'info@rki.de', '+49-30187540', 'https://www.rki.de', '1998-03-15', 'Infectious Diseases', 'Key German public health body.'),
(7, 'Institut Pasteur', 'Research', 7, 'contact@pasteur.fr', '+33-145688000', 'https://www.pasteur.fr', '2001-04-25', 'Virology, Vaccines', 'WHO collaborating center.'),
(8, 'National Institute of Infectious Diseases Japan', 'Research', 8, 'admin@niid.go.jp', '+81-3-52852311', 'https://www.niid.go.jp', '2007-10-01', 'Infectious Diseases', 'Focus on viral surveillance.'),
(9, 'National Institute for Communicable Diseases', 'Government', 9, 'info@nicd.ac.za', '+27-113860600', 'https://www.nicd.ac.za', '2005-02-01', 'Pathology, Outbreaks', 'Based in South Africa.'),
(10, 'Russian Academy of Medical Sciences', 'Research', 10, 'info@ramn.ru', '+7-4956272315', 'https://www.ramn.ru', '2000-11-01', 'Medical Research', 'Supports Russian health policies.'),
(11, 'Australian Department of Health', 'Government', 11, 'enquiries@health.gov.au', '+61-262272000', 'https://www.health.gov.au', '2009-08-01', 'Health Regulation', 'Coordinates national health campaigns.'),
(12, 'icddr,b', 'Research', 12, 'info@icddrb.org', '+880-2-9827001', 'https://www.icddrb.org', '2004-01-01', 'Public Health, Research', 'Based in Dhaka, Bangladesh.'),
(13, 'Instituto Nacional de Salud Pública', 'Government', 13, 'info@insp.mx', '+52-7773293000', 'https://www.insp.mx', '2006-09-15', 'Public Health', 'Supports vaccination programs.'),
(14, 'Public Health Agency of Canada', 'Government', 14, 'phac.info.aspc@canada.ca', '+1-8006226232', 'https://www.canada.ca/phac', '2010-05-01', 'Infectious Disease, Policy', 'Manages emergency responses.'),
(15, 'Istituto Superiore di Sanità', 'Research', 15, 'info@iss.it', '+39-0649901', 'https://www.iss.it', '2002-06-01', 'Biomedical Research', 'Supports pandemic planning.'),
(16, 'National Institute of Health Pakistan', 'Government', 16, 'contact@nih.org.pk', '+92-512255414', 'https://www.nih.org.pk', '2001-10-01', 'Epidemiology', 'Based in Islamabad.'),
(17, 'Indonesian Ministry of Health', 'Government', 17, 'info@kemkes.go.id', '+62-2138490021', 'https://www.kemkes.go.id', '2008-03-01', 'Public Health', 'Coordinates dengue programs.'),
(18, 'Instituto Nacional de Enfermedades Infecciosas', 'Research', 18, 'contact@inei.gob.ar', '+54-1149492000', 'https://www.argentinagov.ar/salud', '2005-01-01', 'Infectious Diseases', 'Located in Buenos Aires.'),
(19, 'Public Health England', 'Government', 19, 'phe.enquiries@phe.gov.uk', '+44-2082004400', 'https://www.gov.uk/phe', '2000-12-01', 'Health Surveillance', 'Leads disease monitoring in UK.'),
(20, 'Ethiopian Public Health Institute', 'Government', 20, 'info@ephi.gov.et', '+251-112758650', 'https://www.ephi.gov.et', '2013-04-01', 'Public Health Research', 'Works with WHO Africa.');

-- to display table data
select * from Collaborating_Organizations;
-- to remove complete records from table
truncate table Collaborating_Organizations;
-- to remove complete records and attributes from table
drop table if exists Collaborating_Organizations;