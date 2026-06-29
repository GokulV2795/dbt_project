{{ config(materialized='view') }}

select return_id,order_item_id,return_date,reason from {{ source('retail_raw','RETURNS_RAW') }}