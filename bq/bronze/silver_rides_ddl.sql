
-- Silver fact table (typed, deduped on (booking_id, event_date))
CREATE TABLE IF NOT EXISTS `<PROJECT_ID>.rides.silver_rides` (
  event_date DATE,
  event_time TIME,
  event_ts TIMESTAMP,
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
  payment_method STRING,
  ingestion_ts TIMESTAMP,
  src STRING
)
PARTITION BY DATE(event_ts)
OPTIONS (description='Silver rides facts (unique on booking_id,event_date)');
