{{ config(materialized='view') }}

select CUSTOMER_ID,CUSTOMER_NAME,EMAIL,CITY,STATE,COUNTRY,SIGNUP_DATE
from {{ source('retail_raw', 'CUSTOMERS_RAW') }}