{{ config(materialized='view') }}

select

    product_id,

    product_name,

    category,

    brand,

    cost_price,

    selling_price

from {{ source('retail_raw','PRODUCTS_RAW') }}