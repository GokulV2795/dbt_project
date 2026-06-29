{{ config(
    materialized='incremental',
    unique_key='order_item_id'
) }}

select *

from {{ ref('int_sales') }}

{% if is_incremental() %}

where order_date >
(
    select max(order_date)
    from {{ this }}
)

{% endif %}