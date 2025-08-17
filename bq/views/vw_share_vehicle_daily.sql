
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_share_vehicle_daily` AS
SELECT event_date, vehicle_type, COUNT(*) AS rides,
       ROUND(100*SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER (PARTITION BY event_date)),2) AS rides_pct
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean`
GROUP BY event_date, vehicle_type;
