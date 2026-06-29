{{ config(materialized='table') }}

select

    customer_id,

    customer_name,

    count(distinct order_id) as total_orders,

    sum(net_sales) as total_sales,

    avg(net_sales) as average_order_value,

    sum(profit) as total_profit

from {{ ref('int_sales') }}

group by

customer_id,

customer_name