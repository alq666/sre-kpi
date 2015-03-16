"""Summarizes the monitor reports from Datadog into key metrics 
"""
import csv
import os
import sqlite3
import sys

# Prepare the sqlite file for queries
# A denormalized version of the csv
try:
    os.remove('monitors.sqlite')
except:
    pass

conn = sqlite3.connect('monitors.sqlite')
c = conn.cursor()
c.execute("""
create table monitors
(
day date,
source_type text,
alert_type text,
priority integer,
hostname text,
device text,
alert_name text,
user text,
cnt integer
)
""")

# Consume the csv
reader = csv.reader(sys.stdin)
headers = reader.next()

for l in reader:
    # yyyy-mm-dd hh24
    day  = l[headers.index('hour')].split()[0]
    src  = l[headers.index('source_type_name')]
    alty = l[headers.index('alert_type')]
    prio = int(l[headers.index('priority')])
    host = l[headers.index('host_name')]
    dev  = l[headers.index('device_name')]
    alnm = l[headers.index('alert_name')]
    usrs = l[headers.index('user')].split()
    cnt  = int(l[headers.index('cnt')])

    # In the case of multiple users, denormalize
    for usr in usrs:
        stmt = """insert into monitors
        (day, source_type, alert_type, priority, hostname, device, alert_name, user, cnt) values (?, ?, ?, ?, ?, ?, ?, ?, ?)"""
        c.execute(stmt, [day, src, alty, prio, host, dev, alnm, usr, cnt])

conn.commit()
