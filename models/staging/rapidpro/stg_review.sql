{{ config(
    materialized='incremental',
    unique_key='assignment_id',
    engine='MergeTree',
    order_by='assignment_id',
    settings={'allow_nullable_key': 1}
) }}

select
    assignment_id,
    chw_id,
    facility_id,
    chw_name,
    facility_name,
    county,
    sub_county,
    now() as dbt_updated_at
from {{ source('rp_test', 'review') }}

{% if is_incremental() %}
  where dbt_updated_at > (select max(dbt_updated_at) from {{ this }})
{% endif %}