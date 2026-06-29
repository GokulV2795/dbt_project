{% snapshot customer_snapshot %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='customer_id',
        strategy='check',
        check_cols=['customer_name','email','city','state']
    )
}}

select *

from {{ ref('stg_customers') }}

{% endsnapshot %}