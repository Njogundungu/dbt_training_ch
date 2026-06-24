with raw_assignments as (
    select * from {{ source('rp_test', 'hcw_facility_assignments') }}
)

select 
    id,
    code,
    hcw_id,
    facility_id,
    
    toDateTime(valid_from) as valid_from, 
    toDateTime(valid_to) as valid_to

from raw_assignments