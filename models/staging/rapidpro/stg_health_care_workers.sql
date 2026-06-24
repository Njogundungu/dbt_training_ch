with raw_hcw as (
    select * from {{ source('rp_test', 'health_care_workers') }}
)

select
    id,
    name as hcw_name,
    role,
    registration_county,

    {{ clean_phone_number('phone_number') }} as phone_number

from raw_hcw