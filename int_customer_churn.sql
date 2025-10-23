{{ config(materialized='table') }}

SELECT
    c.customer_id,
    c.churn_date,
    c.churn_reason,
    c.churn_reason_category
FROM {{ ref('stg_churn_api') }} c
WHERE c.churn_date >= DATEADD(year, -1, CURRENT_DATE());
