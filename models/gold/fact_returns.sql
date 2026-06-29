{{ config(materialized='table') }}

select

    return_id,

    order_id,

    product_id,

    quantity,

    unit_price,

    return_date,

    reason

from {{ ref('int_returns') }}