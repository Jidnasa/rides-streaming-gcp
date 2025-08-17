
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_latest_top10_pickups` AS
WITH p AS (
  SELECT pickup_location, COUNT(*) AS rides
  FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean` b
  JOIN `<PROJECT_ID>.rides_gold_views._latest_day` d ON b.event_date=d.latest_day
  GROUP BY pickup_location
), r AS (
  SELECT pickup_location, rides, DENSE_RANK() OVER (ORDER BY rides DESC) AS rnk FROM p
)
SELECT pickup_location, rides, ROUND(100*SAFE_DIVIDE(rides, SUM(rides) OVER ()),2) AS rides_pct
FROM r WHERE rnk<=10 ORDER BY rides DESC;
