
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_latest_payment_mix` AS
SELECT payment_method, COUNT(*) AS rides,
       ROUND(100*SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER ()),2) AS rides_pct,
       COALESCE(SUM(booking_value),0) AS revenue,
       ROUND(100*SAFE_DIVIDE(SUM(booking_value), SUM(SUM(booking_value)) OVER ()),2) AS revenue_pct
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean` b
JOIN `<PROJECT_ID>.rides_gold_views._latest_day` d ON b.event_date=d.latest_day
GROUP BY payment_method;
