
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_latest_kpi` AS
SELECT b.event_date AS latest_day,
       COUNT(*) AS rides,
       COUNTIF(booking_status='completed') AS completed_rides,
       ROUND(100*SAFE_DIVIDE(COUNTIF(booking_status!='completed'), COUNT(*)),2) AS cancel_pct,
       COALESCE(SUM(booking_value),0) AS revenue,
       AVG(ride_distance) AS avg_km,
       AVG(driver_ratings) AS avg_driver_rating,
       AVG(customer_rating) AS avg_customer_rating
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean` b
JOIN `<PROJECT_ID>.rides_gold_views._latest_day` d ON b.event_date=d.latest_day;
