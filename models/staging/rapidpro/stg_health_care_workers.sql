{{ config(
    materialized='incremental',
    unique_key='id',
    engine='MergeTree',
    order_by='id',
    settings={'allow_nullable_key': 1}
) }}

with raw_hcw as (
    select * from {{ source('rp_test', 'health_care_workers') }}
)

select
    
    id,
    

    name as hcw_name,
    role,
    registration_county,

    -- Normalized Phone Number (Ensures consistent 254 prefix)
    case 
        when startsWith(toString(phone_number), '254') then toString(phone_number)
        when startsWith(toString(phone_number), '0') then concat('254', substring(toString(phone_number), 2))
        when startsWith(toString(phone_number), '+254') then substring(toString(phone_number), 2)
        else concat('254', toString(phone_number))
    end as phone_number,

    -- System Timestamp for ClickHouse Incremental Tracking
    now() as dbt_updated_at

from raw_hcw

{% if is_incremental() %}
  -- Only fetch records updated since our last run
  where dbt_updated_at > (select max(dbt_updated_at) from {{ this }})
{% endif %}