{{config(materialized='table')}}

select
    {{ dbt_utils.generate_surrogate_key(['REGION_ID']) }} as region_key,
    REGION_ID as REGION_NATURAL_KEY,
    PLANET,
    ZONE,
    current_timestamp() as created_at,
    current_timestamp() as updated_at
from {{ ref('staging_regions') }}