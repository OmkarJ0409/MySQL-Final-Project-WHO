Phase 03: Advanced SQL Queries and Reporting
Objective

Generate advanced insights using SQL queries, UDFs, and reporting techniques.

Key SQL Operations

Aliases

Simplify column names or create readable headers.

Example: SELECT Title AS alert_name, Alert_Level AS severity_level FROM Global_Health_Alerts;

Subqueries

Retrieve data based on other query results.

Example: SELECT * FROM Global_Health_Alerts WHERE Disease_ID = (SELECT DiseaseID FROM Diseases WHERE Name='COVID-19');

Built-in Functions

Use MySQL functions like DATEDIFF, CHAR_LENGTH, LEFT, UPPER, CONCAT.

Example: SELECT Title, DATEDIFF(CURDATE(), Date_Issued) AS days_since FROM Global_Health_Alerts;

User-Defined Functions (UDFs)

Custom functions to simplify repetitive logic.

Examples:

alertseveritylevel(Alert_Level) → Convert alert levels to numeric severity.

dayssinceissued(Date_Issued) → Days since alert was issued.

regionprefix(Region_Affected) → First 3 letters of region.

formatname(Source) → Format organization/source names.

Joins

Combine tables to extract related information.

Example:

SELECT g.Title, d.Name AS Disease, c.Name AS Country
FROM Global_Health_Alerts g
JOIN Diseases d ON g.Disease_ID = d.DiseaseID
JOIN Countries c ON d.Country_ID = c.CountryID;

Reporting Examples

Alerts by region and severity.

Organization involvement in specific diseases.

Expired vs. active alerts.

Summarized notes and descriptions using UDFs.

Usage

Execute UDF creation scripts.

Run queries for data analysis and reporting.

Use joins, subqueries, and functions to generate comprehensive reports.
