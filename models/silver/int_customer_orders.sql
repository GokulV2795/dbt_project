{{ config(materialized='table') }}

select

    o.order_id,
    o.order_date,
    o.status,
    o.payment_mode,

    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.state,
    c.country

from {{ ref('stg_orders') }} o

inner join {{ ref('stg_customers') }} c
    on o.customer_id = c.customer_id