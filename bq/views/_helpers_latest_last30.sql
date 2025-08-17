
CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views._latest_day` AS
SELECT MAX(event_date) AS latest_day FROM `<PROJECT_ID>.rides_gold_views.vw_base_clean`;

CREATE OR REPLACE VIEW `<PROJECT_ID>.rides_gold_views._last_30d` AS
SELECT DATE_SUB((SELECT latest_day FROM `<PROJECT_ID>.rides_gold_views._latest_day`), INTERVAL 29 DAY) AS start_day,
       (SELECT latest_day FROM `<PROJECT_ID>.rides_gold_views._latest_day`) AS end_day;
