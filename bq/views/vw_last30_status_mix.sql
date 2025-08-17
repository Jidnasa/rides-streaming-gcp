
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_last30_status_mix` AS
SELECT booking_status, COUNT(*) AS rides_30d,
       ROUND(100*SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER ()),2) AS rides_pct_30d
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean` b
CROSS JOIN `<PROJECT_ID>.rides_gold_views._last_30d` w
WHERE b.event_date BETWEEN w.start_day AND w.end_day
GROUP BY booking_status;
