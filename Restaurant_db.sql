USE restaurant_db;

-- View the menu_items table
SELECT * FROM menu_items;

-- Find the number of items on the menu
SELECT COUNT(*) as num_items
FROM menu_items;

-- Display least and most expensive items on the menu
SELECT * FROM menu_items
ORDER BY price DESC;

-- Display the number of Italian dishes on the menu
SELECT COUNT(*) FROM menu_items
WHERE category = 'Italian';

-- Display least and most expensive Italian dishes on the menu
SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;

-- Count the number of dishes in each category
SELECT category, COUNT(menu_item_id) as num_dishes
FROM menu_items
GROUP BY category;

-- Display the average dish price within each category 
SELECT category, AVG(price) AS avg_price
FROM menu_items
GROUP BY category;



-- View the order_details table
SELECT *
FROM order_details;

-- Show date range of the table
SELECT MIN(order_date), MAX(order_date)
FROM order_details;

-- Display the number of orders made within this date range
SELECT COUNT(DISTINCT order_id) as order_in_range FROM order_details;

-- Display the number of items ordered within this date range
SELECT COUNT(order_id) as items_in_range FROM order_details;

-- Display which orders had the most number of items
SELECT order_id, COUNT(item_id) as items_num
FROM order_details
GROUP BY order_id
ORDER BY items_num DESC;

-- Display the number of orders that had more than 12 items
SELECT COUNT(*) FROM 
(SELECT order_id, COUNT(item_id) as items_num
FROM order_details
GROUP BY order_id
HAVING items_num > 12) AS num_orders;



-- Combine the menu_items and order_details tables into a single table
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT *
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;


-- Display the least and most ordered items and the category they were in
SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases DESC;



-- Display the top 5 orders that spent the most money
SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;


-- View the details of the highest spend order
-- It can be seen from the table that the highest spent order majorily ordered Italian
-- that would explain why it had the highest spending
SELECT category, COUNT(item_id) as num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;


-- View the details of the top 5 highest spend orders
-- Keeping the same trend as above, Italian dishes remained the most purchased dishes 
-- out of any other countries for the top 5 highest spend orders
SELECT order_id, category, COUNT(item_id) as num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id in (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category
ORDER BY num_items DESC;