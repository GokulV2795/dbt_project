{{ config(materialized='view') }}

select

    order_id,

    customer_id,

    store_id,

    employee_id,

    order_date,

    status,

    payment_mode

from {{ source('retail_raw','ORDERS_RAW') }}