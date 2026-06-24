with raw_reviews as (
    select * from {{ source('rp_test', 'review') }}
)

select
    assignment_id,
    chw_id,
    facility_id,
    chw_name,
    facility_name,
    county,
    sub_county,
    
    -- Keeps track of exactly when this row was processed
    now() as dbt_updated_at

from raw_reviews