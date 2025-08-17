
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_latest_top10_routes_revenue` AS
WITH r AS (
  SELECT CONCAT(pickup_location,' → ',drop_location) AS route, COALESCE(SUM(booking_value),0) AS revenue
  FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean` b
  JOIN `<PROJECT_ID>.rides_gold_views._latest_day` d ON b.event_date=d.latest_day
  GROUP BY route
), rk AS (
  SELECT route, revenue, DENSE_RANK() OVER (ORDER BY revenue DESC) AS rnk FROM r
)
SELECT route, revenue, ROUND(100*SAFE_DIVIDE(revenue, SUM(revenue) OVER ()),2) AS revenue_pct
FROM rk WHERE rnk<=10 ORDER BY revenue DESC;
