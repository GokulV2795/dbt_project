{{ config(materialized='view') }}

select
    customer_id,
    customer_name,
    email,
    city,
    state,
    country,
    signup_date
from {{ source('retail_raw', 'CUSTOMERS_RAW') }};