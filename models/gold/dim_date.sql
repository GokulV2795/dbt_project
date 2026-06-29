{{ config(materialized='table') }}

select distinct

    order_date as date_key,

    year(order_date) as year,

    quarter(order_date) as quarter,

    month(order_date) as month,

    monthname(order_date) as month_name,

    week(order_date) as week,

    day(order_date) as day,

    dayname(order_date) as day_name

from {{ ref('stg_orders') }}