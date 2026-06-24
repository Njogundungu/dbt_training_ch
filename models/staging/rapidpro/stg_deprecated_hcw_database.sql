with raw_deprecated_database as (
    select * from {{ source('rp_test', 'HCW_Database') }}
)

select
    hcw_id,
    facility_code,

    -- Generates the exact date and time this row hits ClickHouse
    now() as dbt_staged_at

from raw_deprecated_database