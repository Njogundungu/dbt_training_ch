SELECT *
FROM default.hcw_facility_assignments
WHERE toDateTime(valid_from) < now() - INTERVAL 10 YEAR