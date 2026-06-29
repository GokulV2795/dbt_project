{{ config(materialized='view') }}

select

    store_id,

    store_name,

    city,

    state

from {{ source('retail_raw','STORES_RAW') }}