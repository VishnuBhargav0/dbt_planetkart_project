{{ config(materialized='table') }}

select
    CUSTOMER_ID,
    EMAIL,
    FIRST_NAME,
    LAST_NAME, 
    REGION_ID, 
    SIGNUP_DATE
from {{ source('planetkart_raw', 'customers') }}