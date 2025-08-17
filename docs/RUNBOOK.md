
# Runbook

- Replay a file: Drop NDJSON → confirm Bronze (last 30m) → wait MERGE or run backfill MERGE.
- Fix duplicates: check dup keys in Silver; tighten MERGE if needed.
- DLQ: check `rides_ops.vw_dlq_24h` and `rides_ops.vw_dlq_latest`.
- Freshness & NULLs: check `rides_ops.dq_status_latest` (scheduled).

Backfill MERGE: edit dates in `bq/silver/merge_incremental.sql` and run manually.
