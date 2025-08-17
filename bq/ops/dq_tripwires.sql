
DECLARE STALE_HOURS INT64    DEFAULT 2;
DECLARE NULL_THRESH FLOAT64  DEFAULT 0.005;
DECLARE MAX_DUP_KEYS INT64   DEFAULT 0;

DECLARE silver_last_update TIMESTAMP DEFAULT (SELECT MAX(ingestion_ts) FROM `<PROJECT_ID>.rides.silver_rides`);
IF silver_last_update < TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL STALE_HOURS HOUR) THEN
  SELECT ERROR(CONCAT('Silver stale: last_update=', CAST(silver_last_update AS STRING)));
END IF;

DECLARE dup_keys INT64 DEFAULT (
  SELECT COUNT(*) FROM (
    SELECT booking_id, event_date, COUNT(*) c
    FROM `<PROJECT_ID>.rides.silver_rides`
    GROUP BY 1,2 HAVING c > 1
  )
);
IF dup_keys > MAX_DUP_KEYS THEN
  SELECT ERROR(CONCAT('Duplicate keys detected: ', CAST(dup_keys AS STRING)));
END IF;

DECLARE latest_day DATE DEFAULT (SELECT MAX(event_date) FROM `<PROJECT_ID>.rides.silver_rides`);
DECLARE rate_null_booking_value FLOAT64 DEFAULT (
  SELECT SAFE_DIVIDE(COUNTIF(booking_value IS NULL), COUNT(*))
  FROM `<PROJECT_ID>.rides.silver_rides` WHERE event_date = latest_day);
DECLARE rate_null_ride_distance FLOAT64 DEFAULT (
  SELECT SAFE_DIVIDE(COUNTIF(ride_distance IS NULL), COUNT(*))
  FROM `<PROJECT_ID>.rides.silver_rides` WHERE event_date = latest_day);

IF rate_null_booking_value > NULL_THRESH THEN
  SELECT ERROR(CONCAT(' High NULL booking_value on ', CAST(latest_day AS STRING),
                      ' rate=', CAST(ROUND(100*rate_null_booking_value,2) AS STRING),'%'));
END IF;
IF rate_null_ride_distance > NULL_THRESH THEN
  SELECT ERROR(CONCAT(' High NULL ride_distance on ', CAST(latest_day AS STRING),
                      ' rate=', CAST(ROUND(100*rate_null_ride_distance,2) AS STRING),'%'));
END IF;

SELECT 'OK' AS status, latest_day AS check_day, silver_last_update AS silver_last_update_utc,
       ROUND(100*rate_null_booking_value,2) AS pct_null_booking_value_latest,
       ROUND(100*rate_null_ride_distance,2) AS pct_null_ride_distance_latest,
       dup_keys AS dup_key_count;
