{% snapshot snapshot_customers %}

{{
    config(
        target_schema='PLANETKART_SNAPSHOTS',
      unique_key='CUSTOMER_NATURAL_KEY',
      strategy='check',
      check_cols=['EMAIL', 'FIRST_NAME', 'LAST_NAME', 'REGION_ID', 'SIGNUP_DATE', 'FULL_NAME'],
      invalidate_hard_deletes=True
    )
}}

select
    CUSTOMER_NATURAL_KEY,
    EMAIL,
    FIRST_NAME,
    LAST_NAME,
    FULL_NAME,
    REGION_ID,
    SIGNUP_DATE
from {{ ref('dimensional_customers') }}

{% endsnapshot %}