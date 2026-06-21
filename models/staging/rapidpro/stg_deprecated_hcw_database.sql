{{ config(
    materialized='table',
    engine='MergeTree',
    order_by='hcw_id',
    settings={'allow_nullable_key': 1}
) }}

with raw_deprecated_database as (
    select * from {{ source('rp_test', 'HCW_Database') }}
)

select
    -- Identifiers & Keys
    hcw_id,
    facility_code,

    -- System Timestamp to mark when this data was staged
    now() as dbt_staged_at

from raw_deprecated_database