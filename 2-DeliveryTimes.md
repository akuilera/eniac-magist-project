# What’s the average time between the order being placed and the product being delivered?

12.5035 days

```sql
SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;
```

# How many orders are delivered on time vs orders delivered with a delay?

**Orders delivered on time: 88644**

**Orders with delay: 7826**

```sql
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
```

**Deliveries on time: 89.14%**

**Deliveries with delay: 7.87%**

```sql
# % of orders delivered on time
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

# % of orders with delay
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
```

# Is there any pattern for delayed orders, e.g. big products being delayed more often?

| category_name | num_delays |
| --- | --- |
| bed_bath_table | 811 |
| health_beauty | 776 |
| sports_leisure | 584 |
| furniture_decor | 535 |
| computers_accessories | 503 |
| watches_gifts | 468 |
| housewares | 399 |
| telephony | 349 |
| auto | 328 |
| toys | 286 |
| garden_tools | 274 |
| baby | 258 |
| electronics | 247 |
| cool_stuff | 243 |
| perfumery | 228 |
| stationery | 176 |
| others | 127 |
| fashion_bags_accessories | 121 |
| office_furniture | 115 |
| pet_shop | 106 |
| consoles_games | 83 |
| construction_tools_construction | 67 |
| luggage_accessories | 56 |
| musical_instruments | 54 |
| home_appliances | 50 |
| audio | 45 |
| food | 44 |
| home_confort | 41 |
| home_construction | 39 |
| small_appliances | 38 |
| furniture_living_room | 35 |
| books_general_interest | 34 |
| books_technical | 28 |
| construction_tools_lights | 22 |
| industry_commerce_and_business | 19 |
| drinks | 19 |
| home_appliances_2 | 16 |
| art | 15 |
| fashion_shoes | 15 |
| fashion_underwear_beach | 15 |
| food_drink | 14 |
| costruction_tools_garden | 13 |
| market_place | 13 |
| computers | 13 |
| christmas_supplies | 12 |
| kitchen_dining_laundry_garden_furniture | 11 |
| fixed_telephony | 11 |
| air_conditioning | 10 |
| agro_industry_and_commerce | 9 |
| signaling_and_security | 8 |
| construction_tools_safety | 7 |
| furniture_bedroom | 7 |
| costruction_tools_tools | 6 |
| furniture_mattress_and_upholstery | 5 |
| cine_photo | 5 |
| small_appliances_home_oven_and_coffee | 5 |
| tablets_printing_image | 5 |
| fashion_male_clothing | 5 |
| dvds_blu_ray | 4 |
| home_comfort_2 | 4 |
| music | 3 |
| books_imported | 2 |
| fashion_sport | 2 |
| arts_and_craftmanship | 2 |
| fashio_female_clothing | 2 |
| party_supplies | 1 |
| diapers_and_hygiene | 1 |
| portable_kitchen_food_processors | 1 |
| flowers | 1 |

```sql
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
```

# Standard Delivery Times

## General Deliveries

[https://www.statista.com/statistics/1117196/delivery-time-e-commerce-brazil/](https://www.statista.com/statistics/1117196/delivery-time-e-commerce-brazil/)

The average time for a delivery in Brazil in 2020 is 21 days. The main competitors on that field are Mercado Livre, Magazine Luiza and Amazon.

## Comparison to Amazon

According to Amazon

[International Delivery Rates & Times - Amazon Customer Service](https://www.amazon.de/-/en/gp/help/customer/display.html?asc_source=01H1P39M5ZSG9J6WR6B1HBK9M0&nodeId=GA6MMBQJBJ5QYUDW#GUID-94F272E0-F280-4956-87FB-E99C2528462A__SECTION_98B070F783D3419CBEA052FD6FDDB8EB)

### Rest of Latin America

| **Shipping Option** | **Item** | **Delivery Rates** |
| --- | --- | --- |
| **Standard Delivery**
(7-9 working days) | books, music, DVD, video | €9.00 per delivery  +
€4.00 per kg (proportionally) |
| **AmazonGlobal Eilzustellung***
(9-14 working days) | all items eligible for "AmazonGlobal Eilzustellung"** | €12.00 per delivery  +
€6.00 per kg (proportionally) |
| **AmazonGlobal Express Delivery**
(3-6 working days) | all items eligible for "AmazonGlobal Express Delivery"** | €28.00 per delivery  +
€8.00 per kg (proportionally) |
- "AmazonGlobal Eilzustellung" is only eligible for delivery addresses in Brazil.
- **Important Information**: Items from the following categories are **only eligible for AmazonGlobal Delivery**: Apparel, Baby, Watches, Jewelry, Automotive, Electronics, Home & Kitchen, Sports & Outdoors, Office, Musical Instruments, Toys and Garden. These items are not eligible for Standard Delivery. More information can be found on our help page for [Delivery Restrictions](https://www.amazon.de/-/en/gp/help/customer/display.html/ref=hp_intfee_coun?nodeId=201910400). Please note that AmazonGlobal Delivery requires [advance payment for import fees](https://www.amazon.de/-/en/gp/help/customer/display.html/ref=hp_intfee_imfee?nodeId=202014840#GUID-43440281-0A31-4391-81AA-C7FF2E7FE996__SECTION_201C73D9E2144FE49369DB6AD1A92DA9).
- **Important Information**: For delivery addresses in Argentinia, only "International Express Delivery" is eligible.

## Comparison to MercadoLivre

According to Quatr

[https://quartr.com/insights/company-research/mercado-libre-the-digital-backbone-of-latin-america](https://quartr.com/insights/company-research/mercado-libre-the-digital-backbone-of-latin-america)

For big cities is expected to be one day. 

Seems like Mercado Livre (Meli) has the best delivery times in 2018. They are also familiar to the brazilian market, which would make them a great company to consider joining with.

*"The vast distances and fragmented transport infrastructure across Latin America made 24- or 48-hour deliveries seem unthinkable. We went from 8% of packages delivered by us in Q1 2018, to 95% in Q3 2024. By taking direct control of our logistics operations, we have transformed this landscape, creating a network capable of overcoming these challenges and delivering unprecedented speed and reliability. By accelerating delivery times through our robust logistics network, we have not only enhanced customer satisfaction but also driven higher conversion rates on the marketplace, as faster shipping increases trust and purchase intent."*

*"We have the fastest shipping experience in the region, consistently outperforming competitors. In key markets like Brazil, delivery times in São Paulo and Rio de Janeiro are nearly three times faster than those of the second-largest player.”*

Fine Tech revenues are also exponentially increasing.

## Comparison to Magazine Luiza

They have similar delivery times to those of Mercado Libre but a little longer. More than 30% of all of their deliveries in 48 hours or less

[https://ri.magazineluiza.com.br/Download.aspx?Arquivo=sUgISgqCrYuEXe8TiCnRQA==](https://ri.magazineluiza.com.br/Download.aspx?Arquivo=sUgISgqCrYuEXe8TiCnRQA==)

## Analisys

In the list “AmazonGlobal Eilzustellung”, which only works in Brazil in LatAm, we can find the categories Watches, Electronics, Automotive, which suggest that those are reasonable times for deliveries of tech stuff in Brazil from Amazon. The deliveries usually take 9 to 14 days.

The best options for deliveries seem to be MercadoLivre and Magazine Luiza, with delivery times of 1 to 2 days in big cities, but Mercado Livre has a better response due to mire intensive investment in infrastructure.