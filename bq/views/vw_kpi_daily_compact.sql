
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_kpi_daily_compact` AS
SELECT event_date,
       COUNT(*) AS rides,
       COUNTIF(booking_status='completed') AS completed_rides,
       ROUND(100*SAFE_DIVIDE(COUNTIF(booking_status!='completed'), COUNT(*)),2) AS cancel_pct,
       COALESCE(SUM(booking_value),0) AS revenue,
       AVG(ride_distance) AS avg_km,
       AVG(driver_ratings) AS avg_driver_rating,
       AVG(customer_rating) AS avg_customer_rating
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean`
GROUP BY event_date;
