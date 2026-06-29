{{ config(materialized='table') }}

select
    customer_id,
    customer_name,
    email,
    city,
    state,
    country,
    signup_date
from {{ ref('stg_customers') }}