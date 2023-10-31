select 
a.SQL_TEXT, a.SQL_FULLTEXT,
s.* from (
select 
s.sql_id, s.module,
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
where snap_id between 134114 and 134117
group by s.sql_id, s.module
order by 3 desc
) s,
v$sqlarea a
where rownum <= 100
and a.SQL_ID = s.sql_id
