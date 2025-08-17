
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_latest_hourly_ist` AS
SELECT EXTRACT(HOUR FROM event_dt_ist) AS hour_ist,
       COUNT(*) AS rides,
       ROUND(100*SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER ()),2) AS rides_pct
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean` b
JOIN `<PROJECT_ID>.rides_gold_views._latest_day` d ON b.event_date=d.latest_day
GROUP BY hour_ist
ORDER BY hour_ist;
