
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_nulls_share_daily` AS
SELECT event_date,
       ROUND(100*SAFE_DIVIDE(COUNTIF(vehicle_type='unknown'), COUNT(*)),2) AS pct_unknown_vehicle_type,
       ROUND(100*SAFE_DIVIDE(COUNTIF(payment_method='unknown'), COUNT(*)),2) AS pct_unknown_payment_method,
       ROUND(100*SAFE_DIVIDE(COUNTIF(booking_status='unknown'), COUNT(*)),2) AS pct_unknown_booking_status,
       ROUND(100*SAFE_DIVIDE(COUNTIF(pickup_location='unknown'), COUNT(*)),2) AS pct_unknown_pickup_location,
       ROUND(100*SAFE_DIVIDE(COUNTIF(drop_location='unknown'), COUNT(*)),2) AS pct_unknown_drop_location
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean`
GROUP BY event_date;
