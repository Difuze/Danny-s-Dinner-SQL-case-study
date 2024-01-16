USE pizza_runner;

-- 1.total number of pizzas ordered
SELECT COUNT(order_id) FROM customer_orders;



-- 2.How many unique customer orders were made?
SELECT COUNT(DISTINCT(order_id)) FROM customer_orders;


-- 3.How many successful orders were delivered by each runner?
SELECT COUNT(*) FROM runner_orders t1 
JOIN customer_orders t2 ON t1.order_id = t2.order_id 
WHERE cancellation IS null;



-- 4.How many of each type of pizza was delivered?
SELECT pizza_id,count(*) AS "num_of_times" FROM customer_orders
GROUP BY pizza_id ;


-- 5.How many Vegetarian and Meatlovers were ordered by each customer?
SELECT customer_id,pizza_name,COUNT(pizza_name) FROM customer_orders t1 
JOIN pizza_names t2 ON t1.pizza_id = t2.pizza_id
GROUP BY pizza_name, customer_id;



-- 6.What was the maximum number of pizzas delivered in a single order?

SELECT order_id,count(*) FROM customer_orders
GROUP BY order_id
ORDER BY count(*) DESC LIMIT 1;

-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT count(*) FROM customer_orders
WHERE exclusions IS NOT NULL AND extras IS NOT NULL;


SELECT customer_id ,
SUM(CASE 
    WHEN (extras IS NOT NULL OR exclusions IS NOT NULL) THEN 1 ELSE 0 END)
    AS change_in_pizaa,
SUM(CASE 
	WHEN (extras IS NULL AND exclusions IS NULL) THEN 1 ELSE 0 END)
    AS no_changes
FROM customer_orders AS t1 
INNER JOIN runner_orders as t2 ON t1.order_id = t2.order_id
GROUP BY customer_id;

-- 8. How many pizzas were delivered that had both exclusions and extras?
SELECT * FROM customer_orders t1
JOIN runner_orders t2 ON t1.order_id = t2.order_id
WHERE (exclusions IS NOT NULL AND extras IS NOT NULL)
AND cancellation IS NULL;


-- 9. What was the total volume of pizzas ordered for each hour of the day?
SELECT COUNT(*), HOUR(order_time) FROM customer_orders
GROUP BY HOUR(order_time);

-- 10. What was the volume of orders for each day of the week?
SELECT COUNT(*), DATE(order_time) FROM customer_orders
GROUP BY DATE(order_time);