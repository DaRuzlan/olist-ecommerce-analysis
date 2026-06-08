# Olist E-Commerce Sales Analysis

## Project Overview
As part of my data analytics learning journey, I analyzed 100,000+ 
real orders from Olist, a Brazilian e-commerce platform, to practice 
MySQL and extract real business insights.

## Dataset
- **Source:** [Brazilian E-Commerce Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Tables used:** customers, orders, order_items, products, sellers, payments
- **Total rows:** 300,000+

## About This Project
This is my first end-to-end SQL portfolio project, built while 
learning data analytics independently. Feedback welcome!

## Tools Used
- MySQL & MySQL Workbench
- GitHub

## Database Schema
The database consists of 6 tables with the following relationships:

- `customers` → `orders` (one customer can have many orders)
- `orders` → `order_items` (one order can have many items)
- `order_items` → `products` (each item references a product)
- `order_items` → `sellers` (each item references a seller)
- `orders` → `payments` (one order can have multiple payments)

## Key Business Insights

### 1. Overall Performance
- **96,476** total orders processed
- **$16,008,872** in total revenue
- **$154.10** average order value

### 2. Revenue by Order Size
| Order Size | Total Orders | Total Revenue |
|------------|-------------|---------------|
| Large (>$200) | 20,107 | $8,541,936 |
| Medium ($50-$200) | 62,701 | $6,772,634 |
| Small (<$50) | 21,078 | $694,300 |

> Large orders represent only 19% of transactions but drive 53% of total revenue.

### 3. Top Product Categories by Revenue
| Category | Revenue |
|----------|---------|
| Beauty & Health | $1,258,681 |
| Watches & Gifts | $1,205,005 |
| Bed, Bath & Table | $1,036,988 |
| Sports & Leisure | $988,048 |
| Computer Accessories | $911,954 |

### 4. Payment Methods
- Credit card dominates with **76,795 transactions** ($12.5M revenue)
- Boleto (Brazilian bank slip) is second with **19,784 transactions**

### 5. Order Growth Trend
- Business started in late 2016 with minimal volume
- Steady growth through 2017
- **November 2017** saw a major spike (7,288 orders) — likely Black Friday
- Stabilized at ~6,000–7,000 orders/month through 2018

## SQL Concepts Demonstrated
- Database design with PRIMARY KEY and FOREIGN KEY constraints
- Aggregate functions: COUNT, SUM, AVG, ROUND
- INNER JOIN across multiple tables
- GROUP BY, ORDER BY, HAVING
- CASE statements for data classification
- Date functions: MONTH(), YEAR()

## Files
- `olist_analysis.sql` — All SQL queries used in this project
