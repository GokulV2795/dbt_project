{{ config(materialized='view') }}

select

    employee_id,

    employee_name,

    store_id,

    designation

from {{ source('retail_raw','EMPLOYEES_RAW') }}