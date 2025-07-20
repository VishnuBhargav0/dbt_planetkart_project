{{ config(materialized='table') }}

select
    ORDER_ID,
    CUSTOMER_ID,
    ORDER_DATE,
    STATUS
from {{ source('planetkart_raw', 'orders') }}
