{{ config(materialized='view') }}

select

    promotion_id,

    promotion_code,

    discount_percent,

    start_date,

    end_date

from {{ source('retail_raw','PROMOTIONS_RAW') }}