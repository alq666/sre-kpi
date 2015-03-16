"""Summarizes the monitor reports from Datadog into key metrics 
"""
import csv
import os
import sqlite3
import sys

# Prepare the sqlite file for queries
# A denormalized version of the csv
try:
    os.remove('pagerduty.sqlite')
except:
    pass

conn = sqlite3.connect('pagerduty.sqlite')
c = conn.cursor()
c.execute("""
create table pagerduty
(
day date,
hour integer,
source_type text,
alert_type text,
priority integer,
service text,
email text,
cnt integer
)
""")

# Consume the csv
reader = csv.reader(sys.stdin)
headers = reader.next()

for l in reader:
    # yyyy-mm-dd hh24
    day, hour  = l[headers.index('hour')].split()
    src  = l[headers.index('source_type_name')]
    alty = l[headers.index('alert_type')]
    prio = int(l[headers.index('priority')])
    svc  = l[headers.index('service')]
    eml  = l[headers.index('email')]
    cnt  = int(l[headers.index('cnt')])

    stmt = """insert into pagerduty
    (day, hour, source_type, alert_type, priority, service, email, cnt) values (?, ?, ?, ?, ?, ?, ?, ?)"""
    c.execute(stmt, [day, hour, src, alty, prio, svc, eml, cnt])

conn.commit()
