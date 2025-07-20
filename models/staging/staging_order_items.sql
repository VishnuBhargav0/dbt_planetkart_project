{{ config(materialized='table') }}

select
    ORDER_ID,
    PRODUCT_ID,
    QUANTITY,
    UNIT_PRICE
from {{ source('planetkart_raw', 'order_items') }}