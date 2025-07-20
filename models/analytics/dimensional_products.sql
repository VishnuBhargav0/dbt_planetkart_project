{{ config(materialized='table') }}

select
    {{ dbt_utils.generate_surrogate_key(['PRODUCT_ID']) }} as product_key,
    PRODUCT_ID as PRODUCT_NATURAL_KEY,
    PRODUCT_NAME,
    CATEGORY,
    COST,
    SKU,
    current_timestamp() as created_at,
    current_timestamp() as updated_at
from {{ ref('staging_products') }}