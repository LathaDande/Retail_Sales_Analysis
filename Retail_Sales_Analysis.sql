create database Retail_Sales_Analysis;
use Retail_Sales_Analysis;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

select * from retail_sales;

select count(*) from retail_sales;
-- Data Cleaning
select* from retail_sales
where transaction_id is null
or sale_date is null 
or sale_time is null
or gender is null
or category is null
or quantity is null
or cogs is null
or total_sale is null;

-- Data Exploration
-- How many sales we have?
select count(*) from retail_sales;

-- How many uniuque customers we have ?
select count(distinct customer_id) as total_sale from retail_sales;
select distinct category from retail_sales;
select * from retail_sales where category="Beauty";
select * from retail_sales where category != "Beauty";

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select* from retail_sales where sale_date='2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- select * from retail_sales where category='Clothing' ;
-- select * from retail_sales where quantity>10;

select * from retail_sales 
where category='Clothing' 
and quantity>3 and  sale_date between '2022-11-01' and '2022-11-30';

-- Write a SQL query to count  all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select count(*) from retail_sales where category='Clothing' and quantity>3 and  sale_date between '2022-11-01' and '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) from retail_sales
group by category;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) as Age from retail_sales where category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale>1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,count(*) as total_number_of_transactions from retail_sales group by category,gender;

-- Q.7 Write a SQL query to calculate the average sale for each month.
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    AVG(total_sale) AS average_sale
FROM retail_sales
GROUP BY sale_month
order by sale_month;
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,sum(total_sale) as total_sales from retail_sales 
group by customer_id
order by total_sales desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select count(distinct customer_id),category from retail_sales group by category order by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE 
        WHEN HOUR(sale_time) <= 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS order_count
FROM retail_sales
GROUP BY shift
ORDER BY FIELD(shift, 'Morning', 'Afternoon', 'Evening');


