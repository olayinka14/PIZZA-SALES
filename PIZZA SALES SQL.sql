-- total revenue
SELECT round(sum(total_price), 2) as total_revenue
FROM pizza_sales;

-- average order value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sales;

-- total pizza sold
SELECT sum(quantity) as total_pizza_sold
FROM pizza_sales;

-- total orders
SELECT count(distinct order_id) as total_orders
FROM pizza_sales;

-- average pizzas per order
SELECT round((sum(quantity) / count(distinct order_id)), 2) as avg_pizza_per_order
FROM pizza_sales;

UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d/%m/%Y');

-- daily trend for total orders
SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DAYNAME(order_date);

-- monthly trend for total orders
SELECT MONTHNAME(order_date) AS month_name, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY MONTHNAME(order_date)
ORDER BY total_orders DESC;

-- percentage of sales by pizza catrgory
SELECT 
	pizza_category, 
    round(sum(total_price), 2) * 100 / (SELECT round(sum(total_price), 2) FROM pizza_sales)  AS percent_sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY pizza_category;

-- percentage of sales by pizza size
SELECT 
	pizza_size, 
    round(round(sum(total_price), 2) * 100 / (SELECT round(sum(total_price), 2) FROM pizza_sales), 2)  AS percent_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- top 5 best selling pizzas by revenue
SELECT pizza_name, round(sum(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

-- bottom 5 best selling pizzas by revenue
SELECT pizza_name, round(sum(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue 
LIMIT 5;

-- top 5 best selling pizzas by quantity
SELECT pizza_name, sum(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 5;

-- bottom 5 best selling pizzas by quantity
SELECT pizza_name, sum(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity 
LIMIT 5;

-- top 5 best selling pizzas by order
SELECT pizza_name, count(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_order DESC
LIMIT 5;

-- bottom 5 best selling pizzas by order
SELECT pizza_name, count(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_order
LIMIT 5;

-- total pizza sold by category
SELECT pizza_category, sum(quantity) as total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizza_sold DESC;