
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views.vw_cancellations_customer_daily` AS
SELECT event_date, customer_cancel_reason AS reason, COUNT(*) AS cancels,
       ROUND(100*SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER (PARTITION BY event_date)),2) AS cancels_pct
FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean`
WHERE booking_status!='completed' AND customer_cancel_reason!='unknown'
GROUP BY event_date, reason;
