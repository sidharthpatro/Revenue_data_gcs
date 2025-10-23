{{ config(materialized='table') }}

SELECT
    v.customer_id,
    v.customer_name,
    v.total_revenue_12m,
    ch.churn_date,
    ch.churn_reason,
    ch.churn_reason_category,
    CASE
        WHEN v.total_revenue_12m > 100000 THEN 'High Value'
        WHEN v.total_revenue_12m > 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM {{ ref('int_customer_value') }} v
LEFT JOIN {{ ref('int_customer_churn') }} ch
  ON v.customer_id = ch.customer_id
WHERE ch.churn_date IS NOT NULL;
