{{ config(
    materialized='incremental',
    unique_key='id',
    engine='MergeTree',
    order_by='id',
    settings={'allow_nullable_key': 1}
) }}

select 
    id,
    code,
    hcw_id,
    facility_id,
    toDateTime(valid_from) as valid_from, 
    toDateTime(valid_to) as valid_to
from {{ source('rp_test', 'hcw_facility_assignments') }}

{% if is_incremental() %}
  where toDateTime(valid_from) > (select max(valid_from) from {{ this }})
{% endif %}