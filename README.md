# WBS Data Science Bootcamp Project: Eniac's Strategic Analysis of Magist Partnership for Brazilian Market Entry

## Project Overview

Eniac, a Spain-based online marketplace specializing in premium Apple-compatible accessories, sought to evaluate a strategic partnership with Magist – a Brazilian Software as a Service (SaaS) platform connecting retailers to major marketplaces – as part of its Latin American expansion strategy. This analysis focused on two core operational concerns:

1. **Product-Market Compatibility**: Assessment of whether Magist’s platform caters to buyers of high-end tech accessories, given its predominantly price-sensitive user base.
2. **Logistical Viability**: Evaluation of delivery performance through Magist’s partnership with Brazil’s national postal service compared to regional benchmarks.

The study utilized Magist’s 2016-2018 transactional dataset to analyze sales trends, product distribution, and delivery metrics across Brazil’s diverse regions.

## Methodology & Tools

### Data Analysis Stack

**MySQL (DBeaver CE)**: Conducted granular analysis of 99,441 orders and 32,951 products.

**Tableau Public**: Dashboards development for delivery times, product types and sales analysis.

**Canva**: Synthesized findings into executive presentations highlighting key risk factors in Magist’s operational model.

## Repository Architecture

### Core Deliverables

- Strategic Documentation
    * `0-MagistAnalysis-Presentation.pdf`: Board-level recommendations with cost-benefit analysis
    * `0-Report.md`: Executive summary of technical findings
- Analytical Deep Dives
    * `1-AboutTheSales.md`: Time series analysis
    * `2-DeliveryTimes.md`: Regional performance metrics
    * `3-AboutTheProducts.md`: Price tier analysis
- Technical Assets
    * `Queries.sql`: SQL scripts for data extraction

## Key Insights

### Marketplace Compatibility Challenges

Magist’s platform demonstrates limited alignment with premium product strategies:

- **Category Distribution**: Only 14% of sold products (16,021 units) classified as technology accessories
- **Price Segmentation**: 94% of transactions below €100 vs Eniac’s €150+ average selling price
- **Seller Economics**: 17% tech sellers (528 stores) generating declining per-seller revenue

### Logistics Performance Analysis

While outperforming national averages, Magist’s delivery network shows structural constraints:

- **Delivery Times**: 12.5-day average (89% on-time) vs Mercado Livre’s 1-day premium service
- **Cost Efficiency**: €20 average shipping cost (16% of product value) creating pricing pressure

## Strategic Recommendations

### Partnership Advisory

1. **Primary Recommendation**: Delay Magist integration due to fundamental platform mismatch

- **Rationale**: Core incompatibility in price positioning and category focus
- **Risk Mitigation**: Proposed segmentation of Eniac's catalog, selling only Magist's star technological product: Phones

2. **Alternative Pathways**

- **Platform Partnership**: Evaluate Mercado Livre’s and Magazine Luiza fulfillment network

## How to Navigate This Repository

1. **Executive Review**
    - Begin with `0-MagistAnalysis-Presentation.pdf` for strategic context.
    - Reference `0-Report.md` for technical validation of recommendations.
2. **Operational Analysis**
    - Execute `Queries.sql` in DBeaver to replicate analytical workflows.
3. **Market Expansion Planning**
    - Reference `1-AboutTheSales.md` for the analysis of the development of Magist's sales.
    - Use delivery time matrices in `2-DeliveryTimes.md` for logistics modeling.
    - Cross-reference `3-AboutTheProducts.md` with current catalog for compatibility assessment.

This repository serves as both project documentation and strategic toolkit for Eniac’s Latin American market entry planning.