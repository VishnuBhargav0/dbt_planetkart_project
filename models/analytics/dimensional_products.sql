{{ config(materialized='table') }}

select
    {{ dbt_utils.generate_surrogate_key(['PRODUCT_ID']) }} as product_key,
    PRODUCT_ID as PRODUCT_NATURAL_KEY,
    PRODUCT_NAME,
    CATEGORY,
    COST,
    SKU
from {{ ref('staging_products') }}