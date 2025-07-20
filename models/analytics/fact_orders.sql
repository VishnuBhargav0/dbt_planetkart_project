{{config(materialized='table')}}

with orders as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status
    from {{ ref('staging_orders') }} o
),
order_items as (
    select
        oi.order_id,
        oi.product_id,
        oi.quantity,
        oi.unit_price
    from {{ ref('staging_order_items') }} oi
),
order_agg as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status,
        sum(oi.quantity) as total_quantity,
        sum(oi.quantity * oi.unit_price) as total_order_value,
        avg(oi.unit_price) as avg_item_price,
        count(distinct oi.product_id) as distinct_products
    from orders o
    join order_items oi on o.order_id = oi.order_id
    group by o.order_id, o.customer_id, o.order_date, o.status
)
select
    oa.order_id,
    oa.order_date,
    oa.status,
    c.CUSTOMER_NATURAL_KEY,
    c.FULL_NAME,
    p.PRODUCT_NATURAL_KEY,
    p.PRODUCT_NAME,
    p.CATEGORY,
    r.REGION_NATURAL_KEY,
    oa.total_quantity,
    oa.total_order_value,
    oa.avg_item_price,
    oa.distinct_products
from order_agg oa
join {{ ref('dimensional_customers') }} c on oa.customer_id = c.CUSTOMER_NATURAL_KEY
join {{ ref('staging_order_items') }} oi on oa.order_id = oi.order_id
join {{ ref('dimensional_products') }} p on oi.product_id = p.PRODUCT_NATURAL_KEY
join {{ ref('dimensional_regions') }} r on c.region_id = r.REGION_NATURAL_KEY