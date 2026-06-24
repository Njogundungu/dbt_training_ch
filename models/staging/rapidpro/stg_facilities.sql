{{ config(materialized='view') }}

with raw_facilities as (
    select * from {{ source('rp_test', 'facilities') }}
)

select
    id as facility_id,
    name as facility_name,
    county,
    sub_county
from raw_facilities