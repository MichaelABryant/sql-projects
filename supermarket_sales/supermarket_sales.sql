-- look at entire table
SELECT *
FROM dbo.supermarket_sales$

-- check for NULL values in every column
SELECT *
FROM dbo.supermarket_sales$
WHERE [Invoice ID] IS NULL
	OR Branch IS NULL
	OR City IS NULL
	OR [Customer type] IS NULL
	OR Gender IS NULL
	OR [Product line] IS NULL
	OR [Unit price] IS NULL
	OR Quantity IS NULL
	OR [Tax 5%] IS NULL
	OR [Total] IS NULL
	OR [Date] IS NULL
	OR [Time] IS NULL
	OR [Payment] IS NULL
	OR [cogs] IS NULL
	OR [gross margin percentage] IS NULL
	OR [gross income] IS NULL
	OR [Rating] IS NULL

-- running total of paid amount over time
SELECT [Date], [Time], SUM(Total) OVER (ORDER BY [Date], [Time]) AS Running_Total_Paid
FROM dbo.supermarket_sales$

-- running total of paid amount over time partioned by branch
SELECT [Date], [Time], Branch, SUM(Total) OVER (PARTITION BY Branch ORDER BY [Date], [Time]) AS Running_Total_Paid
FROM dbo.supermarket_sales$

-- running total of paid amount over time
SELECT [Date], [Time], [Branch], SUM(Total) OVER (PARTITION BY Branch ORDER BY [Date], [Time]) AS Running_Gross_Income
FROM dbo.supermarket_sales$

-- average rating from each branch
SELECT Branch AS BRANCH, AVG(Rating) AS AVG_RATING
FROM dbo.supermarket_sales$
GROUP BY Branch
ORDER BY Branch

-- pivot table to see gender rating differences for each branch
SELECT *
FROM (SELECT [Branch], [Rating], [Gender] FROM dbo.supermarket_sales$) Branch_Rating
PIVOT (
	AVG([Rating])
	FOR [Branch] IN ([A], [B], [C])
	) AS PivotTable;

-- pivot table to see member rating differences for each branch
SELECT *
FROM (SELECT [Branch], [Rating], [Customer type] FROM dbo.supermarket_sales$) Branch_Rating
PIVOT (
	AVG([Rating])
	FOR [Branch] IN ([A], [B], [C])
	) AS PivotTable;

-- pivot table to see payment type rating differences for each branch
SELECT *
FROM (SELECT [Branch], [Rating], [Payment] FROM dbo.supermarket_sales$) Branch_Rating
PIVOT (
	AVG([Rating])
	FOR [Branch] IN ([A], [B], [C])
	) AS PivotTable;

-- pivot table to see customer type and gender rating differences for each branch
SELECT *
FROM (SELECT [Branch], [Rating], [Customer type], [Gender] FROM dbo.supermarket_sales$) Branch_Rating
PIVOT (
	AVG([Rating])
	FOR [Branch] IN ([A], [B], [C])
	) AS PivotTable;

-- pivot table to see monthly average ratings from different branches
SELECT *
FROM (SELECT [Branch], [Rating], MONTH([Date]) AS "Month" FROM dbo.supermarket_sales$) Branch_Rating
PIVOT (
	AVG([Rating])
	FOR [Branch] IN ([A], [B], [C])
	) AS PivotTable
ORDER BY "Month";

-- pivot table to see hourly average ratings from different branches
SELECT *
FROM (SELECT [Branch], [Rating], DATEPART(hh, [Time]) AS "Hour" FROM dbo.supermarket_sales$) Branch_Rating
PIVOT (
	AVG([Rating])
	FOR [Branch] IN ([A], [B], [C])
	) AS PivotTable
ORDER BY "Hour";

-- pivot table to see hourly average ratings from different months
SELECT *
FROM (SELECT MONTH([Date]) AS "Month", [Rating], DATEPART(hh, [Time]) AS "Hour" FROM dbo.supermarket_sales$) Date_Time_Rating
PIVOT (
	AVG([Rating])
	FOR "Month" IN ([1], [2], [3])
	) AS PivotTable
ORDER BY "Hour";

-- total items bought by product line
SELECT [Product line], SUM(Quantity) AS total_bought
FROM dbo.supermarket_sales$
GROUP BY [Product line];

-- pivot table to see number of items bought from product line by genders
SELECT *
FROM (SELECT [Gender], [Product line], [Quantity] FROM dbo.supermarket_sales$) Product_Quantity_Gender
PIVOT (
	COUNT(Quantity)
	FOR [Product line] IN ([Fashion accessories], [Health and beauty], [Electronic accessories], [Food and beverages], [Sports and travel], [Home and lifestyle])
	) AS PivotTable;

