Phase 02: Data Modeling and Schema Design
Objective

Design a normalized relational schema for global health alerts and collaborating organizations, ensuring data integrity and meaningful relationships.

Tables Created

Global_Health_Alerts

Stores health alert data:

AlertID, Title, Date_Issued, Region_Affected, Alert_Level, Disease_ID, Description, Source, Expiry_Date, Notes.

Foreign Key: Disease_ID → Diseases.DiseaseID.

Collaborating_Organizations

Stores information about organizations collaborating on health initiatives:

OrgID, Name, Type, Country_ID, Contact_Email, Phone, Website, Partnership_Date, Area_of_Work, Notes.

Foreign Key: Country_ID → Countries.CountryID.

Key Features

Ensures referential integrity through foreign keys.

Supports tracking of health alerts and organizational collaborations.

Populated with sample data representing real-world scenarios.

Usage

Execute the schema creation scripts to create the tables.

Insert sample data using the provided INSERT scripts.

Query the tables to explore global health alerts and collaborating organizations.
