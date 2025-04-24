USE magist;

# Categories of tech products in Magist
SELECT 
	SUM(order_items.price) / 
	(COUNT(
		DISTINCT DATE_FORMAT(
			orders.order_purchase_timestamp, '%Y-%m'))
		*
		COUNT(DISTINCT order_items.seller_id))
	AS avg_monthly_seller
	FROM order_items
	LEFT JOIN orders
	ON order_items.order_id = orders.order_id
	LEFT JOIN products
	ON products.product_id = order_items.product_id
	WHERE products.product_category_name IN (
		"audio",
		"cine_foto",
		"eletrodomesticos",
		"eletrodomesticos_2",
		"eletronicos",
		"informatica_acessorios",
		"pc_gamer",
		"pcs",
		"tablets_impressao_imagem",
		"telefonia");

# Months of data in the database
SELECT COUNT(distinct month(order_purchase_timestamp))
	AS month_year, year(order_purchase_timestamp)
	AS year FROM orders GROUP BY year ORDER BY year;

# Number of sellers
SELECT COUNT(distinct seller_id) FROM sellers;

# Number of tech sellers
SELECT COUNT(distinct seller_id)
	FROM order_items
	LEFT JOIN products
	ON order_items.product_id = products.product_id
	WHERE products.product_category_name IN (
		"audio",
		"cine_foto",
		"eletrodomesticos",
		"eletrodomesticos_2",
		"eletronicos",
		"informatica_acessorios",
		"pc_gamer",
		"pcs",
		"tablets_impressao_imagem",
		"telefonia");

# Total amount earned by all sellers
SELECT SUM(price) FROM order_items;

# Total amount earned by tech sellers
SELECT SUM(order_items.price) FROM order_items
	LEFT JOIN products
	ON order_items.product_id = products.product_id
	WHERE products.product_category_name IN (
		"audio",
		"cine_foto",
		"eletrodomesticos",
		"eletrodomesticos_2",
		"eletronicos",
		"informatica_acessorios",
		"pc_gamer",
		"pcs",
		"tablets_impressao_imagem",
		"telefonia");

# Average monthly earnings by seller
SELECT
	SUM(order_items.price)
	/
	(COUNT(DISTINCT DATE_FORMAT(
		orders.order_purchase_timestamp, '%Y-%m'))
		*
		COUNT(DISTINCT order_items.seller_id))
	AS avg_monthly_seller
	FROM order_items 
	LEFT JOIN orders
	ON order_items.order_id = orders.order_id;

# Average monthly earnings by tech sellers
SELECT
	SUM(order_items.price)
	/
	(COUNT(
		DISTINCT DATE_FORMAT(
			orders.order_purchase_timestamp, '%Y-%m'))
		*
		COUNT(DISTINCT order_items.seller_id))
	AS avg_monthly_seller
	FROM order_items
	LEFT JOIN orders
	ON order_items.order_id = orders.order_id
	LEFT JOIN products
	ON products.product_id = order_items.product_id
	WHERE products.product_category_name IN (
		"audio",
		"cine_foto",
		"eletrodomesticos",
		"eletrodomesticos_2",
		"eletronicos",
		"informatica_acessorios",
		"pc_gamer",
		"pcs",
		"tablets_impressao_imagem",
		"telefonia");

# Average time between the order being placed and the product being delivered
SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

# Orders delivered on time
SELECT 
	COUNT(DISTINCT order_id)
FROM orders
WHERE
	(order_delivered_customer_date < order_estimated_delivery_date)
AND order_status = 'delivered';

# Orders with delay
SELECT 
	COUNT(DISTINCT order_id)
FROM orders
WHERE
	(order_delivered_customer_date > order_estimated_delivery_date)
AND order_status = 'delivered';

# Percentage of orders delivered on time
SELECT 
		((SELECT
		COUNT(DISTINCT order_id)
	FROM orders
	WHERE
		(order_delivered_customer_date < order_estimated_delivery_date)
	AND order_status = 'delivered')
	/
		(SELECT
	COUNT(*)
	FROM orders))
	* 100
;

# Percentage of orders with delay
SELECT 
		((SELECT
		COUNT(DISTINCT order_id)
	FROM orders
	WHERE
		(order_delivered_customer_date > order_estimated_delivery_date)
	AND order_status = 'delivered')
	/
		(SELECT
	COUNT(*)
	FROM orders))
	* 100
;

# Delayed deliveries by category with category name in english
SELECT
	product_category_name_translation.product_category_name_english
	AS category_name,
	COUNT(DISTINCT orders.order_id)
	AS num_delays
FROM orders
LEFT JOIN order_items
	ON orders.order_id = order_items.order_id
LEFT JOIN products
	ON order_items.product_id = products.product_id
LEFT JOIN product_category_name_translation
	ON products.product_category_name = product_category_name_translation.product_category_name
WHERE orders.order_delivered_customer_date > orders.order_estimated_delivery_date
GROUP BY
	product_category_name_translation.product_category_name_english
ORDER BY num_delays DESC;

# Categories of tech products from Magist
SELECT product_category_name FROM product_category_name_translation  WHERE product_category_name_english IN (
	"audio",
	"cine_photo",
	"computers_accessories",
	"electronics",
	"pc_gamer",
	"home_appliances",
	"home_appliances_2",
	"computers",
	"tablets_printing_image",
	"telephony");

# Quantity of tech products sold and percentage that it represents from the overall number of products sold
SELECT   
	COUNT(*) AS tech_products_sold,
	COUNT(*)*100.0/(SELECT COUNT(*)FROM order_items) AS tech_sales_percentage FROM order_items AS o 
	INNER JOIN products AS p on o.product_id=p.product_id WHERE product_category_name IN (
		"audio",
		"cine_foto",
		"eletrodomesticos",
		"eletrodomesticos_2",
		"eletronicos",
		"informatica_acessorios",
		"pc_gamer",
		"pcs",
		"tablets_impressao_imagem",
		"telefonia");

# Average price of the products being sold
SELECT AVG(price) AS avg_price FROM order_items;

# Popuarity of tech products
SELECT 
	CASE
		WHEN price > 1000 THEN  "expensive"
		WHEN price BETWEEN 500 AND 1000 THEN " mid-range"
		ELSE "low price"
			END AS price_category,
		COUNT(*) AS products_sold FROM order_items AS o 
			INNER JOIN products AS p on o.product_id=p.product_id WHERE product_category_name IN (
			"audio",
			"cine_foto",
			"eletrodomesticos",
			"eletrodomesticos_2",
			"eletronicos",
			"informatica_acessorios",
			"pc_gamer",
			"pcs",
			"tablets_impressao_imagem",
			"telefonia")
	GROUP BY price_category;
