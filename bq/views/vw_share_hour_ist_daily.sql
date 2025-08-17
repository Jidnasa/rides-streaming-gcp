
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_share_hour_ist_daily` AS
SELECT event_date, EXTRACT(HOUR FROM event_dt_ist) AS hour_ist, COUNT(*) AS rides,
       ROUND(100*SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER (PARTITION BY event_date)),2) AS rides_pct
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean`
GROUP BY event_date, hour_ist;
