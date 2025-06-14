---EXPLORING THE MENU_ITEMS TABLE

--1. view the menu_items table

SELECT *FROM menu_items;

--2.Find the number of items on the menu
SELECT COUNT(*) FROM menu_items;

---3. what are the least and most expensive items on the menu?
SELECT * FROM menu_items
ORDER BY price;

SELECT * FROM menu_items
ORDER BY price DESC;

--4.How many italian dishes are on the menu?
SELECT COUNT(*) FROM menu_items
WHERE category = 'Italian';

--5. WHat are the least and most expensive Italian dishes on the menu?
SELECT*
FROM menu_items
WHERE category = 'Italian'
ORDER BY price;

SELECT*
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;

---6. How many dishes are in each category?
SELECT category, COUNT(menu_item_id) AS num_dishes 
FROM menu_items
GROUP BY category;

--7. What is the average dish proce within each category?
SELECT category, AVG(price) AS avg_price
FROM menu_items
GROUP BY category;


---EXPLORING THE ORDER_DETAILS TABLE
--1. View the order_details table
SELECT *
FROM order_details;

--2.What is the date range of the table?
SELECT *
FROM order_details
ORDER BY order_date;

--OR
SELECT MIN(order_date), MAX(order_date)
FROM order_details;

--3.How many orders were made within this date range?
SELECT COUNT(DISTINCT order_id)
from order_details;

--4. How many items were ordered within this date range?
SELECT COUNT(*)
FROM order_details;

--5. Which orders had the most number of items?
SELECT order_id, COUNT(item_id) AS tot_item_id
FROM order_details
GROUP BY order_id
ORDER BY tot_item_id DESC;

--6.How many orders had more than 12 items?

SELECT COUNT(*) FROM
(SELECT order_id, COUNT(item_id) AS tot_item_id
FROM order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12) AS num_orders;


----ANALYZE CUSTOMER BEHAVIOUR
--1. Combine the menu_items and order_details into a single table
SELECT * 
FROM menu_items
SELECT*
FROM order_details

--combine
SELECT *
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id

---2. What were the least and most ordered items? What category were they in?
SELECT mi.item_name, category, COUNT(od.order_details_id) AS num_purchases
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY mi.item_name, category
ORDER BY num_purchases DESC;

--3. What were the top 5 orders that spent the most money?
SELECT order_id, 
	SUM(price) AS total_spend
FROM order_details od
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE mi.price IS NOT NULL
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

--4. View the details of the highest spend order. What insights can you gather from the
SELECT category, COUNT(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id =440
GROUP BY category
;

--5. View the details of te top 5 highest spend orders. What insights can you gather from them?
SELECT order_id,category, COUNT(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN(440,2075,1957,330,2675)
GROUP BY order_id,category
;
