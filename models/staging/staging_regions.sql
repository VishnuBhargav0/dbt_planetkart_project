{{ config(materialized='table') }}

select
    REGION_ID,
    PLANET,
    ZONE
from {{ source('planetkart_raw', 'regions') }}