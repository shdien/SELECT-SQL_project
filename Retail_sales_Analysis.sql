CREATE TABLE retail_sales (
			transactions_id	INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,	
			customer_id INT,
			gender VARCHAR(10),
			age	INT,
			category VARCHAR(20),	
			quantiy	INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT
);
SELECT * FROM retail_sales;

-- Find NULL value from data set
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
		OR sale_date IS NULL
		OR customer_id IS NULL
		OR gender IS NULL
		OR age IS NULL
		OR category IS NULL
		OR quantity IS NULL
		OR price_per_unit IS NULL
		OR cogs IS NULL
		OR total_sale IS NULL;

SELECT * FROM retail_sales;

-- Delete the NULL value from tbles (DATA CLEANING)
DELETE FROM retail_sales
WHERE transactions_id IS NULL
		OR sale_date IS NULL
		OR customer_id IS NULL
		OR gender IS NULL
		OR age IS NULL
		OR category IS NULL
		OR quantity IS NULL
		OR price_per_unit IS NULL
		OR cogs IS NULL
		OR total_sale IS NULL;

---------------- DATA EXPLORTATION --------------------------

-- How many sales we have 
SELECT COUNT(*) total_sales FROM retail_sales;

-- How many unique customer we have 
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- How many catagory we have 
SELECT DISTINCT category 
FROM retail_sales;

----------------- DATA ANALYSIS --------------------------

-- show me the data that made sales on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Show me the data where category is Clothing and the quantity sold more than or qual to 3 in the month of november 2022
SELECT * FROM retail_sales
WHERE category = 'Clothing'
	 AND 
	 TO_CHAR (sale_date, 'YYYY-MM') = '2022-11'
	 AND 
	 quantity >= 3;

-- show me the total sales and total orders of each category 
SELECT category,
	  SUM(total_sale) AS sum_of_sale,
	  COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Show me the average age of customer who purchase beauty category product 
SELECT 
 	  ROUND(AVG(age)) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Show me those transactions where the total sales is greater than 1000
SELECT transactions_id, customer_id, age, category, quantity,total_sale
FROM retail_sales 
WHERE total_sale > 1000;

-- Show me the total number of transactions made by each gender in each category 
SELECT category, gender, 
	  COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- Show me the average sale of each month and find out the best selling month in the year 
SELECT year, month, net_sale FROM 
(
		SELECT EXTRACT (YEAR FROM sale_date) AS year, 
		       EXTRACT (MONTH FROM sale_date) AS month,
			   AVG (total_sale) AS net_sale,
			   RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG (total_sale) DESC ) AS ranking
		FROM retail_sales
		GROUP BY 1,2 
) AS t1
WHERE ranking = 1;

-- Show me the top 5 customer based on the highest total_sales
SELECT customer_id, 
	   SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- show me number of unique customers who purchased items from each category
SELECT category,
	   COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sales
GROUP BY 1;

-- write a query to create each shift and numbers of orders (morning<12, afternoon 12-17, evening>17)
WITH new_table
AS
(
SELECT *,
	     CASE 
		     WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
			 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			 ELSE 'Evening'
	     END AS shift_time
FROM retail_sales
)

SELECT shift_time,
	  COUNT (*) AS total_transactions
FROM new_table
GROUP BY shift_time;










