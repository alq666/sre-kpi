select '-- Pagerduty notifications by month';
select substr(day, 1, 7) month,
       sum(cnt) total
  from monitors
 where user = 'pagerduty'
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7)
 order by substr(day, 1, 7) asc;

select '-- Pagerduty during the day';
select substr(day, 1, 7) month,
       sum(cnt) total
  from monitors
 where user = 'pagerduty'
   and hour between 13 and 23
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7)
 order by substr(day, 1, 7) asc;

select '-- Pagerduty at night';
select substr(day, 1, 7) month,
       sum(cnt) total
  from monitors
 where user = 'pagerduty'
   and hour not between 13 and 23
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7)
 order by substr(day, 1, 7) asc;

select '-- by service and month';
select substr(day, 1, 7) month,
       lower(alert_name),
       sum(cnt) total
  from monitors
 where user = 'pagerduty'
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7), lower(alert_name)
having sum(cnt) > 1
 order by substr(day, 1, 7) asc, sum(cnt) desc;

select '-- by service';
select lower(alert_name),
       sum(cnt) total
  from monitors
 where user = 'pagerduty'
   and alert_type in ('warning', 'error')
 group by lower(alert_name)
 order by sum(cnt) desc limit 10;
