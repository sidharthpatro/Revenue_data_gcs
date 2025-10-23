{{ config(materialized='incremental', unique_key='customer_id') }}

SELECT
    account_id AS customer_id,
    SUM(amount) AS total_revenue_12m,
    MAX(close_date) AS last_purchase_date
FROM {{ source('salesforce', 'opportunity') }}
WHERE close_date >= DATEADD(year, -1, CURRENT_DATE())
{% if is_incremental() %}
  AND last_modified_date > (SELECT MAX(last_modified_date) FROM {{ this }})
{% endif %}
GROUP BY 1;
