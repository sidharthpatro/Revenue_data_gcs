{{ config(materialized='table') }}

SELECT
    a.id AS customer_id,
    a.name AS customer_name,
    SUM(r.revenue_amount) AS total_revenue_12m,
    MAX(r.close_date) AS last_purchase_date
FROM {{ ref('stg_salesforce_accounts') }} a
JOIN {{ ref('stg_salesforce_revenue') }} r
  ON a.id = r.account_id
WHERE r.close_date >= DATEADD(year, -1, CURRENT_DATE())
GROUP BY 1, 2;
