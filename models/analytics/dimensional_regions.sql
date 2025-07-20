{{config(materialized='table')}}

select
    {{ dbt_utils.generate_surrogate_key(['REGION_ID']) }} as region_key,
    REGION_ID as REGION_NATURAL_KEY,
    PLANET,
    ZONE
from {{ ref('staging_regions') }}