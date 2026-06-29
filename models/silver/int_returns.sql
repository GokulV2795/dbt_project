{{ config(materialized='table') }}

select

    r.return_id,
    r.return_date,
    r.reason,

    oi.order_id,
    oi.product_id,
    oi.quantity,
    oi.unit_price

from {{ ref('stg_returns') }} as r

inner join {{ ref('stg_order_items') }} as oi
    on r.order_item_id = oi.order_item_id