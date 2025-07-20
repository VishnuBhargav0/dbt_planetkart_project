{{ config(materialized='table') }}

select
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    COST,
    SKU
from {{ source('planetkart_raw', 'products') }}