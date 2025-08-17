
# Alerts

- BigQuery DQ tripwires: schedule `bq/ops/dq_tripwires.sql` every 15m, email on failure.
- Pub/Sub backlog: alert when `Num undelivered messages` on `rides-sub` > 1,000 for 10m.
- Dataflow health: alert when job not healthy for 5m.
