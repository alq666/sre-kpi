select '-- Pagerduty notifications by month';
select substr(day, 1, 7) month,
       sum(cnt) total
  from pagerduty
 where service = 'Datadog-prod'
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7)
 order by substr(day, 1, 7) asc;

select '-- Pagerduty during the day';
select substr(day, 1, 7) month,
       sum(cnt) total
  from pagerduty
 where service = 'Datadog-prod'
   and hour between 13 and 23
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7)
 order by substr(day, 1, 7) asc;

select '-- Pagerduty at night';
select substr(day, 1, 7) month,
       sum(cnt) total
  from pagerduty
 where service = 'Datadog-prod'
   and hour not between 13 and 23
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7)
 order by substr(day, 1, 7) asc;

select '-- Pagerduty by user';
select email,
       sum(cnt) total
  from pagerduty
 where service = 'Datadog-prod'
   and email not like '[Unassigned]'
   and alert_type in ('warning', 'error')
 group by email
 order by sum(cnt) desc;

select '-- Pagerduty by user at night';
select email,
       sum(cnt) total
  from pagerduty
 where service = 'Datadog-prod'
   and email not like '[Unassigned]'
   and alert_type in ('warning', 'error')
   and hour not between 13 and 23
   and email not like 'bartek@datadoghq.com'
 group by email
 order by sum(cnt) desc;

select '-- Pagerduty by month and user';
select substr(day, 1, 7) month,
       email,
       sum(cnt) total
  from pagerduty
 where service = 'Datadog-prod'
   and email not like '[Unassigned]'
   and alert_type in ('warning', 'error')
 group by substr(day, 1, 7), email
 order by substr(day, 1, 7), sum(cnt) desc;
