{{ config(materialized='view') }}

select

    order_item_id,

    order_id,

    product_id,

    quantity,

    unit_price,

    discount_percent,

    promotion_id

from {{ source('retail_raw','ORDER_ITEMS_RAW') }}