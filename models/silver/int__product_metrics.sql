{{ config(materialized='table') }}

select

    product_id,

    product_name,

    category,

    sum(quantity) as total_quantity,

    sum(net_sales) as revenue,

    sum(profit) as profit

from {{ ref('int_sales') }}

group by

product_id,

product_name,

category