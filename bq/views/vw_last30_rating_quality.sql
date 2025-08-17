
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_last30_rating_quality` AS
SELECT
  ROUND(100*SAFE_DIVIDE(COUNTIF(customer_rating>=4.5), COUNT(*)),2) AS pct_high_customer_4_5_30d,
  ROUND(100*SAFE_DIVIDE(COUNTIF(driver_ratings<=3),   COUNT(*)),2) AS pct_low_driver_le_3_30d
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean` b
CROSS JOIN `<PROJECT_ID>.rides_gold_views._last_30d` w
WHERE b.event_date BETWEEN w.start_day AND w.end_day;
