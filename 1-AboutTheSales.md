# How many months of data are included in the magist database?

**25**

```sql
SELECT COUNT(distinct month(order_purchase_timestamp))
	AS month_year, year(order_purchase_timestamp)
	AS year FROM orders GROUP BY year ORDER BY year;
```

| 3 | 2016 |
| --- | --- |
| 12 | 2017 |
| 10 | 2018 |

# How many sellers are there?

**3095**

```sql
SELECT COUNT(distinct seller_id) FROM sellers;
```

# How many Tech sellers are there?

**526**

```sql
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
```

# What percentage of overall sellers are Tech sellers?

`528/3095*100` = **17%**

# What is the total amount earned by all sellers?

**13.59 Million**

```sql
SELECT SUM(price) FROM order_items;
```

# What is the total amount earned by tech sellers?

**1.88 million,  13%**

```sql
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
```

# What is the average monthly earnings by seller?

**182 EUR**

```sql
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
```

# What is the average monthly earnings by tech sellers?

**162 EUR**

```sql
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
```