# What categories of tech products does Magist have?

audio, cine_foto, eletrodomesticos, eletrodomesticos_2, eletronicos, informatica_acessorios, pc_gamer, pcs, tablets_impressao_imagem, telefonia

```sql
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
```

# How many products of these tech categories have been sold (within the time window of the database snapshot)? What percentage does that represent from the overall number of products sold?**

```sql
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
```

| tech_products_sold | tech_sales_percentage |
| --- | --- |
| 16879 | 14.98358 |

# What’s the average price of the products being sold?

```sql
SELECT AVG(price) AS avg_price FROM order_items;
```

avg_price

120.65373902991884

# Are expensive tech products popular?

```sql
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
```

| low price | 16300 |
| --- | --- |
| mid-range | 363 |
| expensive | 216 |

# CONCLUSION

## Is Magist a good fit for high-end tech products?
**NO**

- Tech products sold - 16879 (15%)
- tech sellers - 526 → 17%
- tech total earnings - 1.88 million → 13%

**Tech products sold, tech sellers, and tech total earnings contribute very low percentages compared to non-tech, which concludes that Magist is not a tech-focused platform**

Low-price products: 16,300
Mid-range products: 363
Expensive products: 216

**Magist focuses more on low-price  products, as Eniac is based on apple related products which are expensive this may not be the ideal marketplace.**

## Are deliveries fast enough?
**NO**

- **Average time of Delivery: 12.5 days**. Seems to be not fast enough. For Eniac’s efforts to have happy customers, fast deliveries are key
- **Deliveries on time: 89.14%**
- **Average shipping cost: 20 EUR**
- **Average shipping to item cost ratio - 16%**. Very high for expensive products like Apple