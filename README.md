# Simple metrics from Datadog monitor and PagerDuty reports

For the purpose of improving our operations

## Quickstart

1. Save `pagerduty.csv` and `monitor.csv` from Datadog
1. `cat monitor.csv | python monitors.py`
1. `cat monitor_kpi.sql | sqlite3 monitors.sqlite`
