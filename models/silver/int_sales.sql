{{ config(materialized='table') }}

select

    oi.order_item_id,
    oi.order_id,

    o.order_date,

    c.customer_id,
    c.customer_name,

    p.product_id,
    p.product_name,
    p.category,
    p.brand,

    s.store_id,
    s.store_name,

    oi.quantity,
    oi.unit_price,
    oi.discount_percent,

    (oi.quantity * oi.unit_price) as gross_sales,

    ((oi.quantity * oi.unit_price) * oi.discount_percent / 100) as discount_amount,

    ((oi.quantity * oi.unit_price)
     - ((oi.quantity * oi.unit_price) * oi.discount_percent / 100)) as net_sales,

    (oi.quantity * p.cost_price) as total_cost,

    (
        ((oi.quantity * oi.unit_price)
        - ((oi.quantity * oi.unit_price) * oi.discount_percent / 100))
        - (oi.quantity * p.cost_price)
    ) as profit

from {{ ref('stg_order_items') }} oi

join {{ ref('stg_orders') }} o
    on oi.order_id = o.order_id

join {{ ref('stg_customers') }} c
    on o.customer_id = c.customer_id

join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id

join {{ ref('stg_stores') }} s
    on o.store_id = s.store_id