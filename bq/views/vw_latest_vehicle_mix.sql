
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_latest_vehicle_mix` AS
SELECT vehicle_type, COUNT(*) AS rides,
       ROUND(100*SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER ()),2) AS rides_pct
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean` b
JOIN `<PROJECT_ID>.rides_gold_views._latest_day` d ON b.event_date=d.latest_day
GROUP BY vehicle_type;
