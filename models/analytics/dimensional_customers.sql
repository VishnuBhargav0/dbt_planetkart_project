{{ config(materialized='table') }}

select
    {{ dbt_utils.generate_surrogate_key(['CUSTOMER_ID']) }} as customer_key,
    CUSTOMER_ID as CUSTOMER_NATURAL_KEY,
    EMAIL,
    FIRST_NAME,
    LAST_NAME,
    FIRST_NAME || ' ' || LAST_NAME as FULL_NAME,
    REGION_ID,
    SIGNUP_DATE,
    current_timestamp() as created_at,
    current_timestamp() as updated_at

from {{ ref('staging_customers') }}