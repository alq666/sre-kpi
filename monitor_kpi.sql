-- Pagerduty notifications by month
select substr(day, 1, 7) month,
       sum(cnt) total
  from monitors
 where user = 'pagerduty'
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7)
 order by substr(day, 1, 7) asc;

-- Pagerduty during the day
select substr(day, 1, 7) month,
       sum(cnt) total
  from monitors
 where user = 'pagerduty'
   and hour between 13 and 23
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7)
 order by substr(day, 1, 7) asc;

-- Pagerduty at night
select substr(day, 1, 7) month,
       sum(cnt) total
  from monitors
 where user = 'pagerduty'
   and hour not between 13 and 23
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7)
 order by substr(day, 1, 7) asc;
