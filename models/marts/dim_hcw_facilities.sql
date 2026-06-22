{{ config(materialized='table') }}

with active_assignments as (
    select 
        assignment_id,
        hcw_id,
        hcw_name,
        hcw_role,
        phone_number,
        facility_code,
        assigned_at_dt
    from {{ ref('int_hcw_assignments_joined') }}
),

facilities_master as (
    select 
        facility_id,  -- Matches the alias from your staging file perfectly
        facility_name, -- Matches the alias from your staging file perfectly
        county,
        sub_county
    from {{ ref('stg_facilities') }}
)

select 
    a.assignment_id,
    a.hcw_id,
    a.hcw_name,
    a.hcw_role,
    a.phone_number,
    f.facility_id as facility_code,
    f.facility_name,
    f.county,
    f.sub_county,
    a.assigned_at_dt
from active_assignments a
left join facilities_master f on toString(a.facility_code) = toString(f.facility_id)