{{ config(materialized='view') }}

with assignments as (
    select 
        id as assignment_id,
        hcw_id,
        facility_id as facility_code,
        toDateTime(valid_from) as assigned_at_dt
    from {{ ref('stg_hcw_assignments') }}
),

workers as (
    select 
        id,
        hcw_name,
        role,           
        phone_number
    from {{ ref('stg_health_care_workers') }}
)

select 
    a.assignment_id,
    a.hcw_id,
    w.hcw_name,
    w.role as hcw_role,
    w.phone_number,
    a.facility_code,
    a.assigned_at_dt
from assignments a
left join workers w on a.hcw_id = w.id