Select *
From [WalmartSalesData.csv]

Select Customer_type, Gender,Count(Customer_type) as Customer_Groups
From [WalmartSalesData.csv]
Group By Customer_type, Gender


With GROSSINCOME AS (
Select Product_line,Round(gross_margin_percentage/100 * Total,4) As GrossIncome_Calculated, gross_income,
Case
When Round(gross_margin_percentage/100 * Total,4) = gross_income Then 'Good'
Else 'Bad'
End AS GROSSINCOME_COMPARISON
From [WalmartSalesData.csv]
)

Select Product_line, GrossIncome_Calculated, gross_income,GROSSINCOME_COMPARISON
From GROSSINCOME
Where GROSSINCOME_COMPARISON = 'Good'



Select Customer_type,sum(gross_income) AS CUS_GROUP_HIGHESTINCOME
From [WalmartSalesData.csv]
GROUP BY Customer_type
ORDER BY CUS_GROUP_HIGHESTINCOME DESC

Select Customer_type,Sum(Convert(int,Quantity)) AS HighestQunatity, Product_line
From [WalmartSalesData.csv]
GROUP BY Customer_type,Product_line
ORDER BY HighestQunatity DESC


Select City, Product_line,Count(Quantity) AS QUANTITY_CITY
From [WalmartSalesData.csv]
Group by City, Product_line
ORDER BY QUANTITY_CITY DESC

Select City,Product_line, Count(Quantity) AS QUANTITY_CITY, SUM(gross_income) AS HIGHESTCITYINCOME
From [WalmartSalesData.csv]
Group by City, Product_line
ORDER BY QUANTITY_CITY DESC, HIGHESTCITYINCOME DESC


Select City, Count(Quantity) AS QUANTITY_CITY, SUM(gross_income) AS HIGHESTCITYINCOME
From [WalmartSalesData.csv]
Group by City
ORDER BY QUANTITY_CITY DESC, HIGHESTCITYINCOME DESC

Select City,Product_line, Count(Quantity) AS QUANTITY_CITY, SUM(gross_income) AS HIGHESTCITYINCOME
From [WalmartSalesData.csv]
Where Product_line like '%y%'
Group by City, Product_line
ORDER BY QUANTITY_CITY DESC, HIGHESTCITYINCOME DESC


Select City,Product_line, Count(Quantity) AS QUANTITY_CITY, SUM(gross_income) AS HIGHESTCITYINCOME
From [WalmartSalesData.csv]
Where City like '%Y'
Group by City, Product_line
ORDER BY QUANTITY_CITY DESC, HIGHESTCITYINCOME DESC


Select City,Product_line, Count(Quantity) AS QUANTITY_CITY, SUM(gross_income) AS HIGHESTCITYINCOME
From [WalmartSalesData.csv]
Where City like 'Y%'
Group by City, Product_line
ORDER BY QUANTITY_CITY DESC, HIGHESTCITYINCOME DESC

Select *
From [WalmartSalesData.csv]

Select Payment, Count(Payment) AS TYPE_OF_PAYMENT
From [WalmartSalesData.csv]
Group by Payment
ORDER BY TYPE_OF_PAYMENT DESC

WITH BRANCHINCOME AS (

Select Branch,Product_line ,SUM(Convert(int,gross_income)) AS HIGHEST_BRANCH_INCOME
From [WalmartSalesData.csv]
Group by Branch, Product_line

)

Select Branch, HIGHEST_BRANCH_INCOME,Product_line,
CASE
When HIGHEST_BRANCH_INCOME < 600 Then 'DROP'
When HIGHEST_BRANCH_INCOME BETWEEN 600 AND 800 Then 'Consider'
ELSE 'Perfect'
END AS BRANCH_RATINGS
From BRANCHINCOME
ORDER BY HIGHEST_BRANCH_INCOME DESC


Select *
From [WalmartSalesData.csv]

WITH RATINGSTABLE AS (

Select Product_line,Rating,Customer_type,
CASE
WHEN Rating < 5.0 THEN 'POOR'
WHEN Rating Between 5.0 AND 7.9 THEN 'AVERAGE'
WHEN Rating BETWEEN 8.0 AND 9.9 THEN 'GREAT'
ELSE 'PERFECT'
END AS RATING_CATEGORIES
From [WalmartSalesData.csv]
Group BY Product_line, Rating, Customer_type
)

Select Product_line,Rating, Customer_type
From RATINGSTABLE
WHERE RATING_CATEGORIES = 'PERFECT' AND Customer_type = 'Member'



Select *
FROM [WalmartSalesData.csv]

Update [WalmartSalesData.csv]
Set Date = Convert(date,Date)

ALTER TABLE [WalmartSalesData.csv]
Add DateConverted Date


INSERT INTO [WalmartSalesData.csv] 
DateConverted 

Select Convert(date,Date) 
From [WalmartSalesData.csv]



ALTER TABLE [WalmartSalesData.csv]
Add DateConverted Date

UPDATE [WalmartSalesData.csv]
SET DateConverted = CONVERT(DATE, Date);


ALTER TABLE [WalmartSalesData.csv]
Add MonthConverted int

UPDATE [WalmartSalesData.csv]
SET MonthConverted = Month(DateConverted) 

ALTER TABLE [WalmartSalesData.csv]
Drop column  MonthConverted


Select sum(gross_income) as INCOME_PER_MONTH, MonthConverted
From [WalmartSalesData.csv]
Group by MonthConverted











































































































































































