-- Runners and Customers 
-- 1.How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

SELECT week(registration_date) AS "week_no." , COUNT(runner_id) AS "num_uer_signed" FROM runners
GROUP BY week(registration_date);


-- 2.What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT t3.runner_id,
MIN(EXTRACT(MINUTE FROM pickup_time) - EXTRACT(MINUTE FROM order_time)) AS "avg_minutes"
FROM customer_orders t1 
JOIN runner_orders t2 ON t1.order_id = t2.order_id
JOIN runners t3 ON t3.runner_id = t2.runner_id
WHERE cancellation IS NULL
GROUP BY T3.runner_id;



-- 3.Is there any relationship between the number of pizzas and how long the order takes to prepare?
SELECT COUNT(t1.order_id) AS 'num_pizzas' , t1.order_id,
TIMESTAMPDIFF(MINUTE , order_time , pickup_time)
FROM customer_orders t1
JOIN runner_orders t2 ON T1.order_id = t2.order_id
GROUP BY t1.order_id ,  TIMESTAMPDIFF(MINUTE , order_time , pickup_time);



-- 4.What was the average distance travelled for each customer?
SELECT c.customer_id,AVG(distance) FROM runner_orders AS r
JOIN customer_orders AS c ON c.order_id = r.order_id 
WHERE cancellation IS NULL 
GROUP BY c.customer_id;


-- 5.What was the difference between the longest and shortest delivery times for all orders?
SELECT MAX(duration) - MIN(duration) FROM runner_orders;

-- 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT ROUND(AVG(distance/duration * 60)) FROM runner_orders;


-- 7. What is the successful delivery percentage for each runner?
SELECT runner_id , (COUNT(pickup_time)/COUNT(order_id)*100)
FROM runner_orders
GROUP BY runner_id;