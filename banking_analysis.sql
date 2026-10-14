
-- Banking Customer Analytics
-- SQL Analysis
-- Author: Soukaina Bahou



-- 1. Total number of customers

SELECT COUNT(*) AS total_customers
FROM bank_customers;


-- 2. Customer distribution by segment

SELECT
    customer_segment,
    COUNT(*) AS number_of_customers
FROM bank_customers
GROUP BY customer_segment
ORDER BY number_of_customers DESC;


-- 3. Average monthly income by customer segment

SELECT
    customer_segment,
    ROUND(AVG(monthly_income_mad), 2) AS avg_monthly_income
FROM bank_customers
GROUP BY customer_segment
ORDER BY avg_monthly_income DESC;


-- 4. Average account balance by customer segment

SELECT
    customer_segment,
    ROUND(AVG(balance_mad), 2) AS avg_balance
FROM bank_customers
GROUP BY customer_segment
ORDER BY avg_balance DESC;


-- 5. Customers with a savings product

SELECT COUNT(*) AS savings_customers
FROM bank_customers
WHERE has_savings_product = 1;


-- 6. Potential savings customers
-- Non-savers with an account balance >= 50,000 MAD

SELECT COUNT(*) AS potential_savings_customers
FROM bank_customers
WHERE has_savings_product = 0
  AND balance_mad >= 50000;


-- 7. Customer balance categories

SELECT
    CASE
        WHEN balance_mad < 20000 THEN 'Low Balance'
        WHEN balance_mad < 50000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS balance_category,
    COUNT(*) AS number_of_customers
FROM bank_customers
GROUP BY balance_category
ORDER BY number_of_customers DESC;


-- 8. Churn rate by number of complaints

SELECT
    complaints_last_12m,
    COUNT(*) AS number_of_customers,
    SUM(churn) AS churned_customers,
    ROUND(AVG(churn) * 100, 2) AS churn_rate_pct
FROM bank_customers
GROUP BY complaints_last_12m
ORDER BY complaints_last_12m;


-- 9. At-risk customers
-- Customers with at least 2 complaints and no more than 2 products

SELECT
    customer_id,
    age,
    customer_segment,
    num_products,
    complaints_last_12m,
    balance_mad,
    churn
FROM bank_customers
WHERE complaints_last_12m >= 2
  AND num_products <= 2
ORDER BY complaints_last_12m DESC;


-- 10. High-value customers
-- High income + high balance + at least 4 products

SELECT
    customer_id,
    age,
    customer_segment,
    monthly_income_mad,
    balance_mad,
    num_products,
    has_savings_product,
    complaints_last_12m,
    churn
FROM bank_customers
WHERE monthly_income_mad >= 11597.75
  AND balance_mad >= 51659.75
  AND num_products >= 4
ORDER BY balance_mad DESC;
