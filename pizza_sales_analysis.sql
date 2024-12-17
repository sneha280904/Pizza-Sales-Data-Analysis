create database salesanalysis;
use salesanalysis;
show tables;
RENAME TABLE pizza_sales_csv_file TO pizza_sales;

select * from pizza_sales;


-- PART 1 --

-- 1
-- Total Revenue
select sum(total_price) AS total_revenue
from pizza_sales;

-- 2
-- Average Order Value 
select sum(total_price)/count(total_price) 
	as average_order_value
from pizza_sales;

-- 3
-- Total Pizzas Sold
select sum(quantity) as total_pizzas_sold
from pizza_sales;

-- 4
-- Total Orders 
select count(distinct order_id) as total_orders
from pizza_sales;

-- 5
-- Average Pizzas Per Order
select avg(quantity) as average_order
from pizza_sales;


-- PART 2 --

-- 6
-- Daily Trends for Total Orders
select dayname(order_date) as order_day, 
	count(distinct order_id) AS total_orders 
from pizza_sales
where order_date is not null
group by dayname(order_date)
order by total_orders desc;

-- 7
-- Monthly Trend for Total Orders
select DATE_FORMAT(order_date, '%M') as order_month, 
	count(distinct order_id) AS total_orders 
from pizza_sales
where order_date is not null
group by DATE_FORMAT(order_date, '%M')
order by total_orders desc;

-- 8
-- Hourly Trend for Total Orders
select hour(order_time) as order_time, 
	count(distinct order_id) AS total_orders 
from pizza_sales
where order_time is not null
group by hour(order_time)
order by hour(order_time);

-- 9
-- Total Pizzas Sold by Pizza Category
select pizza_category, sum(quantity) as Total_Quantity_Sold
from pizza_sales
where month(order_date) = 2
group by pizza_category;

-- 10
-- Percentage of Sales by Pizza Size
with total_sales as (
    select sum(total_price) as total_revenue
    from pizza_sales
    where total_price is not null
)
select pizza_size, 
    sum(total_price) size_sales,
    (sum(total_price) / ts.total_revenue) * 100 as percentage_sales
from pizza_sales
cross join total_sales ts
where total_price is not null
group by pizza_size, ts.total_revenue
order by percentage_sales desc;


-- PART 3 --

-- 11
-- Top 5 Pizzas by Revenue
select pizza_name, sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc
limit 5;

-- 12
-- Bottom 5 Pizzas by Revenue
select pizza_name, sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue asc
limit 5;

-- 13
-- Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
limit 5;

-- 14
-- Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
limit 5;


-- 15
-- Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
limit 5;

-- 16
-- Borrom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
limit 5;


-- End --