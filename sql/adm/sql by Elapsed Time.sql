select 
dbms_lob.substr(a.SQL_TEXT, 1000) sql_begin, a.SQL_TEXT,
u.username,
s.* from (
select 
s.sql_id, s.module, s.PARSING_USER_ID,
sum(ELAPSED_TIME_DELTA)/1000000 "Elapsed Time(s)",
sum(CPU_TIME_DELTA)/1000000 "CPU Time(s)",
sum(executions_delta) "Executions",
sum(ROWS_PROCESSED_DELTA) rows1,
sum(BUFFER_GETS_DELTA) "Buffer Gets",
sum(DISK_READS_DELTA) "Physical reads",
sum(iowait_delta)/1000000 "IO wait",
sum(ccwait_delta)/1000000 cc_wait,
sum(apwait_delta)/1000000 ap_wait,
sum(clwait_delta)/1000000 cl_wait,
sum(BUFFER_GETS_DELTA)/decode(sum(ROWS_PROCESSED_DELTA), 0, 1, sum(ROWS_PROCESSED_DELTA)) gets_per_row,
sum(DISK_READS_DELTA)/decode(sum(ROWS_PROCESSED_DELTA), 0, 1, sum(ROWS_PROCESSED_DELTA)) prds_per_row,
sum(BUFFER_GETS_DELTA)/decode(sum(executions_delta), 0, 1, sum(executions_delta)) gets_per_exec
from dba_hist_sqlstat s
where snap_id >= 134231
group by s.sql_id, s.module, s.PARSING_USER_ID
) s,
dba_hist_sqltext a, dba_users u
where a.SQL_ID(+) = s.sql_id
and u.user_id(+) = s.PARSING_USER_ID
order by 7 desc
