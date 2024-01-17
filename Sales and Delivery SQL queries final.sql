-- Question 1: Find the top 3 customers who have the maximum number of orders
SELECT
    c.Customer_Name,
    COUNT(DISTINCT m.Ord_id) AS order_count
FROM
    cust_dimen_m c
JOIN
    market_fact_m m ON c.Cust_id = m.Cust_id
GROUP BY
    c.Customer_Name
ORDER BY
    order_count DESC
LIMIT 3;

-- Question 2: Create a new column DaysTakenForDelivery that contains the date difference between Order_Date and Ship_Date.
ALTER TABLE orders_dimen_m
ADD DaysTakenForDelivery INT; -- You can use a different data type if needed

UPDATE orders_dimen_m AS o
JOIN shipping_dimen_m AS s ON o.Order_ID = s.Order_ID
SET o.DaysTakenForDelivery = DATEDIFF(s.STR_TO_DATE(Ship_Date,'%d-%m-%Y'), o.STR_TO_DATE(Order_Date,'%d-%m-%Y'));

-- Question 3: Find the customer whose order took the maximum time to get delivered.

SELECT Customer_name, MAX(DaysTakenForDelivery) AS MaxDaysTakenForDelivery
FROM Cust_dimen CD
JOIN Market_Fact MF ON CD.Cust_id = MF.Cust_id
JOIN Orders_Dimen OD ON MF.Ord_id = OD.Order_id
GROUP BY Customer_name
ORDER BY MaxDaysTakenForDelivery DESC
LIMIT 1;

-- Question 4: Retrieve total sales made by each product from the data (use Windows function)

SELECT
    DISTINCT pd.Prod_id,
    pd.Product_Category,
    pd.Product_Sub_Category,
    SUM(m.Sales) OVER(PARTITION BY pd.Prod_id) AS Total_Sales
FROM
    prod_dimen AS pd
JOIN
    market_fact AS m
ON
    pd.Prod_id = m.Prod_id
ORDER BY CAST(substring(pd.Prod_id,6,2) as unsigned) asc;

-- Question 5: Retrieve the total profit made from each product from the data (use Windows function)

SELECT
	DISTINCT pd.Prod_id,
    pd.Product_Category,
    pd.Product_Sub_Category,
    SUM(m.Profit) OVER(PARTITION BY pd.Prod_id) AS Total_Profit
FROM
    prod_dimen AS pd
JOIN
    market_fact AS m
ON
    pd.Prod_id = m.Prod_id
ORDER BY CAST(substring(pd.Prod_id,6,2) as unsigned) asc;

-- Question 6: Count the total number of unique customers in January and how many of them came back every month 
-- over the entire year in 2011

-- To count the total number of unique customers in January:

SELECT COUNT(DISTINCT CD.Cust_id) AS UniqueCustomersInJanuary
FROM Cust_dimen CD
JOIN Market_Fact MF ON CD.Cust_id = MF.Cust_id
JOIN Orders_Dimen OD ON MF.Order_id = OD.Order_id
WHERE DATEPART(YEAR, OD.Order_Date) = 2011 AND DATEPART(MONTH, OD.Order_Date) = 1;

-- To count how many of them came back every month over the entire year in 2011, you will need a more complex query 
-- that checks each month. Below is an example for January to December:

SELECT COUNT(*) AS CustomersCameBackEveryMonth
FROM (
    SELECT CD.Cust_id, COUNT(DISTINCT DATEPART(MONTH, OD.Order_Date)) AS DistinctMonths
    FROM Cust_dimen CD
    JOIN Market_Fact MF ON CD.Cust_id = MF.Cust_id
    JOIN Orders_Dimen OD ON MF.Order_id = OD.Order_id
    WHERE DATEPART(YEAR, OD.Order_Date) = 2011
    GROUP BY CD.Cust_id
    HAVING DistinctMonths = 12
) AS Subquery;

-- This query counts customers who placed orders in all 12 months of 2011.