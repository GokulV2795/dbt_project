{{ config(materialized='view') }}

select *
from {{ source('retail_raw', 'CUSTOMERS_RAW') }}