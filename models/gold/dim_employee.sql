{{ config(materialized='table') }}

select
    employee_id,
    employee_name,
    store_id,
    designation
from {{ ref('stg_employees') }}