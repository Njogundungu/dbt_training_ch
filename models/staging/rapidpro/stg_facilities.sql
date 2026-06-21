-- models/staging/rapidpro/stg_facilities.sql
{{ config(materialized='view') }}

SELECT
    id AS facility_id,
    name AS facility_name,
    county,
    sub_county
FROM {{ source('rp_test', 'facilities') }}