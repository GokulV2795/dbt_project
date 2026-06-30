{{ config(materialized='table') }}

select
    order_item_id,
    order_id,
    order_date,
    customer_id,
    customer_name,
    product_id,
    product_name,
    category,
    brand,
    store_id,
    store_name,
    quantity,
    unit_price,
    discount_percent,
    gross_sales,
    discount_amount,
    net_sales,
    total_cost,
    profit
from {{ ref('int_sales') }}
{% if is_incremental() %}

where order_date >
(
    select max(order_date)
    from {{ this }}
)

{% endif %}