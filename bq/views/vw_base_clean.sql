
CREATE SCHEMA IF NOT EXISTS `<PROJECT_ID>.rides_gold_views` OPTIONS(location='<REGION>');

CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_base_clean` AS
SELECT
  event_date,
  DATETIME(event_ts, 'Asia/Kolkata') AS event_dt_ist,
  LOWER(TRIM(COALESCE(NULLIF(vehicle_type, ''), 'unknown')))     AS vehicle_type,
  LOWER(TRIM(COALESCE(NULLIF(booking_status, ''), 'unknown')))   AS booking_status,
  LOWER(TRIM(COALESCE(NULLIF(payment_method, ''), 'unknown')))   AS payment_method,
  LOWER(TRIM(COALESCE(NULLIF(pickup_location, ''), 'unknown')))  AS pickup_location,
  LOWER(TRIM(COALESCE(NULLIF(drop_location, ''), 'unknown')))    AS drop_location,
  COALESCE(NULLIF(LOWER(TRIM(customer_cancel_reason)), ''), 'unknown') AS customer_cancel_reason,
  COALESCE(NULLIF(LOWER(TRIM(driver_cancel_reason)), ''),   'unknown') AS driver_cancel_reason,
  COALESCE(NULLIF(LOWER(TRIM(incomplete_reason)), ''),      'unknown') AS incomplete_reason,
  SAFE_CAST(NULLIF(REGEXP_REPLACE(LOWER(CAST(booking_value   AS STRING)), r'[^0-9\.\-]', ''), '') AS NUMERIC) AS booking_value,
  SAFE_CAST(NULLIF(REGEXP_REPLACE(LOWER(CAST(ride_distance  AS STRING)), r'[^0-9\.\-]', ''), '') AS FLOAT64) AS ride_distance,
  SAFE_CAST(NULLIF(REGEXP_REPLACE(LOWER(CAST(avg_ctat       AS STRING)), r'[^0-9\.\-]', ''), '') AS FLOAT64) AS avg_ctat,
  SAFE_CAST(NULLIF(REGEXP_REPLACE(LOWER(CAST(avg_vtat       AS STRING)), r'[^0-9\.\-]', ''), '') AS FLOAT64) AS avg_vtat,
  SAFE_CAST(NULLIF(REGEXP_REPLACE(LOWER(CAST(driver_ratings AS STRING)), r'[^0-9\.\-]', ''), '') AS FLOAT64) AS driver_ratings,
  SAFE_CAST(NULLIF(REGEXP_REPLACE(LOWER(CAST(customer_rating AS STRING)), r'[^0-9\.\-]', ''), '') AS FLOAT64) AS customer_rating
FROM `<PROJECT_ID>.rides.silver_rides`
WHERE event_date IS NOT NULL AND event_date >= DATE '2020-01-01';
