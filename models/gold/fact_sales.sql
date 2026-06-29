{{ config(materialized='table') }}

select

    order_item_id,

    order_id,

    order_date,

    customer_id,

    product_id,

    store_id,

    quantity,

    unit_price,

    discount_percent,

    gross_sales,

    discount_amount,

    net_sales,

    total_cost,

    profit

from {{ ref('int_sales') }}