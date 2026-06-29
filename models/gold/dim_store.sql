{{ config(materialized='table') }}

select
    store_id,
    store_name,
    city,
    state
from {{ ref('stg_stores') }}