
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_routes_revenue_daily` AS
SELECT event_date, CONCAT(pickup_location,' → ',drop_location) AS route,
       COUNT(*) AS rides, COALESCE(SUM(booking_value),0) AS revenue,
       ROUND(100*SAFE_DIVIDE(SUM(booking_value), SUM(SUM(booking_value)) OVER (PARTITION BY event_date)),2) AS revenue_pct,
       DENSE_RANK() OVER (PARTITION BY event_date ORDER BY SUM(booking_value) DESC) AS rank_revenue_day
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean`
GROUP BY event_date, route;
