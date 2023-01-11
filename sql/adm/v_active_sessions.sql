create or replace view v_active_sessions as
select
distinct
--t.session_id,
s.OSUSER,
s.SID,
min(t.sample_time) over (partition by s.SQL_ID, t.SQL_PLAN_LINE_ID, t.SQL_EXEC_START, s.OSUSER) min_sample_time,
max(t.sample_time) over (partition by s.SQL_ID, t.SQL_PLAN_LINE_ID, t.SQL_EXEC_START, s.OSUSER) max_sample_time,
round((cast(max(t.sample_time) over (partition by s.SQL_ID, t.SQL_PLAN_LINE_ID, t.SQL_EXEC_START, s.OSUSER) as date) -
cast(min(t.sample_time) over (partition by s.SQL_ID, t.SQL_PLAN_LINE_ID, t.SQL_EXEC_START, s.OSUSER) as date)
) * 24 * 60, 2) mi_sample_time,
t.SQL_PLAN_LINE_ID,
t.SQL_PLAN_OPERATION,
t.SQL_PLAN_OPTIONS,
t.session_state, t.event,
t.SQL_EXEC_START,
p.STATUS,
s.SQL_ID,
p.PLAN_OBJECT_NAME
from
V$ACTIVE_SESSION_HISTORY t,
V$SQL_PLAN_MONITOR p,
v$session s
where t.session_id = s.SID
and s.STATUS = 'ACTIVE'
and p.SID(+) = t.session_id
and p.PLAN_LINE_ID(+) = t.SQL_PLAN_LINE_ID
and t.SQL_EXEC_ID = p.SQL_EXEC_ID(+)
and p.SQL_ID(+) = t.SQL_ID
and t.SQL_EXEC_START <= t.sample_time
order by
max(t.sample_time) over (partition by s.SQL_ID, t.SQL_PLAN_LINE_ID, t.SQL_EXEC_START, s.OSUSER) desc
;
