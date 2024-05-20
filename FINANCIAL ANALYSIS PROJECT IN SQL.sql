Select *
From [financial data sp500 companies]

ALTER TABLE [financial data sp500 companies]
DROP COLUMN column1

WITH CTE AS (
    SELECT date,firm, Ticker,
           ROW_NUMBER() OVER(PARTITION BY date, firm, Ticker ORDER BY date) AS RowNumber
    FROM [financial data sp500 companies]
)
DELETE FROM CTE WHERE RowNumber > 1;


Select *
From [financial data sp500 companies]


Select date,firm,Ticker,Net_Income
From [financial data sp500 companies]
Where Net_Income >= 100000



Select date,firm,Ticker,Net_Income, Research_Development + Selling_General_Administrative -Income_Tax_Expense as Total_Expense,
Total_Revenue-(Research_Development + Selling_General_Administrative -Income_Tax_Expense)
From [financial data sp500 companies]

Select date,firm, MAX(Net_Income) as Net_Income
From [financial data sp500 companies]
Where date = '2021-09-30' 
GROUP BY date,firm
Order By Net_Income Desc


Select date,firm, MAX(Net_Income) as Net_Income
From [financial data sp500 companies]
Where date = '2020-12-31' 
GROUP BY date,firm
Order By Net_Income Desc



Select date,firm, MAX(Net_Income) as Net_Income,Max(Net_Income_Applicable_To_Common_Shares) As Profit_For_Shareholders
From [financial data sp500 companies]
Where date = '2020-12-31' 
GROUP BY date,firm
Order By Net_Income Desc,Profit_For_Shareholders DESC


WITH RevenueRD AS (

Select date,firm,Ebit,(Total_Revenue + Research_Development) as Revenue_RD
From [financial data sp500 companies]
Where date = '2021-09-30'
Group By date,firm,Ebit,Total_Revenue,Research_Development
)

Select *
From RevenueRD
Where Revenue_RD IS NOT NULL
ORDER BY Revenue_RD DESC


WITH GROSSPROFITCOMPARE AS (

Select date,firm,Gross_Profit,(Total_Revenue-Cost_Of_Revenue) AS GROSSPROFITCALCULATED
From [financial data sp500 companies]
Where date = '2021-09-30'

)


Select date,firm,Gross_Profit,GROSSPROFITCALCULATED,
Case
When Gross_Profit = GROSSPROFITCALCULATED THEN 'GOOD'
ELSE 'BAD' 
END AS COMMENT
From GROSSPROFITCOMPARE
Where firm like '%A'




Select firm, (Income_Tax_Expense/Income_Before_Tax) *100 AS TAXPERCENT,(Ebit-interest_expense) AS EBTCALCULATED
From [financial data sp500 companies]
ORDER BY TAXPERCENT DESC

WITH EBTCOMPARISON AS (

Select firm,Income_Before_Tax,(Ebit-Interest_Expense) AS EBTCALCULATED
From [financial data sp500 companies]
)

Select firm,Income_Before_Tax, EBTCALCULATED,(EBTCALCULATED-Income_Before_Tax) AS DIFFERENCE
From EBTCOMPARISON



WITH  REVNET AS (

Select firm,sum(Operating_Income) AS TOTAL_NET_INCOME ,sum(Total_Revenue) AS TOTAL_REVENUE
From [financial data sp500 companies]
Group By firm
)

Select firm, (TOTAL_NET_INCOME/TOTAL_REVENUE) * 100 AS PERCENTOFNETINCOME
From REVNET
ORDER BY PERCENTOFNETINCOME DESC


Select *
From [financial data sp500 companies]













