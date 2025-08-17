
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_share_status_daily` AS
SELECT event_date, booking_status, COUNT(*) AS rides,
       ROUND(100*SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER (PARTITION BY event_date)),2) AS rides_pct
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean`
GROUP BY event_date, booking_status;
