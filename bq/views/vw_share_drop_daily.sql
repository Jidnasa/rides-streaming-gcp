
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_share_drop_daily` AS
SELECT event_date, drop_location, COUNT(*) AS rides,
       ROUND(100*SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER (PARTITION BY event_date)),2) AS rides_pct,
       DENSE_RANK() OVER (PARTITION BY event_date ORDER BY COUNT(*) DESC) AS rank_in_day
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean`
GROUP BY event_date, drop_location;
