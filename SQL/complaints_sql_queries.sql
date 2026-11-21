CREATE DATABASE Customer_Complaints

USE Customer_Complaints

SELECT name AS TableName FROM sys.tables

--select * from cleaned_data$

--Renaming Table Name
EXEC sp_rename 'cleaned_data$', 'complaints';

select * from complaints

--Total Complaints
SELECT COUNT(*) AS Total_Complaints FROM complaints

--Monthly complaint trends.
SELECT
YEAR(date_received) AS Complaint_Year,
MONTH(date_received) AS Complaint_Month,
COUNT(*) AS Total_Complaints
FROM complaints
GROUP BY YEAR(date_received),MONTH(date_received)
ORDER BY Complaint_Year,Complaint_Month

--Complaints by financial product.
SELECT
financial_product, COUNT(*) AS Total_Complaints
FROM complaints
GROUP BY financial_product
ORDER BY Total_Complaints DESC

--Most frequently reported issues.
SELECT TOP 10
issue_category,COUNT(*) AS Total_Complaints
FROM complaints
GROUP BY issue_category
ORDER BY Total_Complaints DESC;

--Complaints by company.
SELECT
company_name,COUNT(*) AS Total_Complaints
FROM complaints
GROUP BY company_name
ORDER BY Total_Complaints DESC

--Complaints by customer state.
SELECT
state,COUNT(*) AS Total_Complaints
FROM complaints
GROUP BY state
ORDER BY Total_Complaints DESC;

--Timely-response percentages.
SELECT
COUNT(*) AS Total_Closed, SUM(CASE WHEN timely_response = 'Yes' THEN 1 ELSE 0 END) AS Timely,
CAST(
SUM(CASE WHEN timely_response = 'Yes' THEN 1.0 ELSE 0 END)* 100 / COUNT(*) AS DECIMAL(10,2)) AS Timely_Percentage
FROM complaints
WHERE response_status = 'Closed';

--Average response time
SELECT
AVG(DATEDIFF(DAY, date_received, date_company_responded)) AS Average_Response_Days
FROM complaints
WHERE response_status = 'Closed';

--Open vs Closed Complaints
SELECT
response_status,COUNT(*) AS Total_Complaints
FROM complaints
GROUP BY response_status ORDER BY response_status

