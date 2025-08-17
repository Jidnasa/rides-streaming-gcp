
-- Ingestion-time partitioned Bronze landing table
CREATE SCHEMA IF NOT EXISTS `<PROJECT_ID>.rides` OPTIONS(location='<REGION>');

CREATE TABLE IF NOT EXISTS `<PROJECT_ID>.rides.bronze_flat_v2` (
  date STRING,
  time STRING,
  booking_id STRING,
  booking_status STRING,
  customer_id STRING,
  vehicle_type STRING,
  pickup_location STRING,
  drop_location STRING,
  avg_vtat FLOAT64,
  avg_ctat FLOAT64,
  cancelled_by_customer INT64,
  customer_cancel_reason STRING,
  cancelled_by_driver INT64,
  driver_cancel_reason STRING,
  incomplete_rides INT64,
  incomplete_reason STRING,
  booking_value NUMERIC,
  ride_distance FLOAT64,
  driver_ratings FLOAT64,
  customer_rating FLOAT64,
  payment_method STRING
)
PARTITION BY _PARTITIONTIME
OPTIONS (
  description = 'Raw flattened streaming records',
  partition_expiration_days = 90
);
