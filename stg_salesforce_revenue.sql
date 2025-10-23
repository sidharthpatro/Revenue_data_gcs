{{ config(materialized='view') }}

SELECT
    account_id,
    opportunity_id,
    amount AS revenue_amount,
    close_date,
    stage_name,
    created_date,
    last_modified_date
FROM {{ source('salesforce', 'opportunity') }}
WHERE is_deleted = FALSE;
