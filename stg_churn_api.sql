{{ config(materialized='view') }}

SELECT
    customer_id,
    churn_date,
    churn_reason,
    churn_reason_category
FROM {{ source('product_api', 'churn_reasons') }};
