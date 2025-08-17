
-- Merge Bronze into Silver every 15 min
MERGE `<PROJECT_ID>.rides.silver_rides` T
USING (
  SELECT
    SAFE.PARSE_DATE('%Y-%m-%d', TRIM(date)) AS event_date,
    COALESCE(SAFE.PARSE_TIME('%H:%M:%S', TRIM(time)), SAFE.PARSE_TIME('%H:%M', TRIM(time))) AS event_time,
    TIMESTAMP(DATETIME(SAFE.PARSE_DATE('%Y-%m-%d', TRIM(date)),
           COALESCE(SAFE.PARSE_TIME('%H:%M:%S', TRIM(time)), SAFE.PARSE_TIME('%H:%M', TRIM(time)))), 'Asia/Kolkata') AS event_ts,
    TRIM(booking_id) AS booking_id, TRIM(booking_status) AS booking_status, TRIM(customer_id) AS customer_id,
    TRIM(vehicle_type) AS vehicle_type, TRIM(pickup_location) AS pickup_location, TRIM(drop_location) AS drop_location,
    SAFE_CAST(avg_vtat AS FLOAT64) AS avg_vtat, SAFE_CAST(avg_ctat AS FLOAT64) AS avg_ctat,
    SAFE_CAST(cancelled_by_customer AS INT64) AS cancelled_by_customer, TRIM(customer_cancel_reason) AS customer_cancel_reason,
    SAFE_CAST(cancelled_by_driver AS INT64) AS cancelled_by_driver, TRIM(driver_cancel_reason) AS driver_cancel_reason,
    SAFE_CAST(incomplete_rides AS INT64) AS incomplete_rides, TRIM(incomplete_reason) AS incomplete_reason,
    SAFE_CAST(booking_value AS NUMERIC) AS booking_value, SAFE_CAST(ride_distance AS FLOAT64) AS ride_distance,
    SAFE_CAST(driver_ratings AS FLOAT64) AS driver_ratings, SAFE_CAST(customer_rating AS FLOAT64) AS customer_rating,
    TRIM(payment_method) AS payment_method,
    CURRENT_TIMESTAMP() AS ingestion_ts, '_sched_merge' AS src
  FROM `<PROJECT_ID>.rides.bronze_flat_v2`
  WHERE _PARTITIONTIME >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 2 HOUR)
) S
ON T.booking_id = S.booking_id AND T.event_date = S.event_date
WHEN MATCHED THEN UPDATE SET
  booking_status = S.booking_status, customer_id = S.customer_id, vehicle_type = S.vehicle_type,
  pickup_location = S.pickup_location, drop_location = S.drop_location,
  avg_vtat = S.avg_vtat, avg_ctat = S.avg_ctat,
  cancelled_by_customer = S.cancelled_by_customer, customer_cancel_reason = S.customer_cancel_reason,
  cancelled_by_driver = S.cancelled_by_driver, driver_cancel_reason = S.driver_cancel_reason,
  incomplete_rides = S.incomplete_rides, incomplete_reason = S.incomplete_reason,
  booking_value = S.booking_value, ride_distance = S.ride_distance,
  driver_ratings = S.driver_ratings, customer_rating = S.customer_rating,
  payment_method = S.payment_method, ingestion_ts = CURRENT_TIMESTAMP(), src = S.src
WHEN NOT MATCHED AND S.booking_id IS NOT NULL AND S.event_date IS NOT NULL THEN INSERT ROW;
