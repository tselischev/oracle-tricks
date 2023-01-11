SELECT osuser,
       --opname,
       --target,
       rpad('*',round((sl.SOFAR/CASE sl.TOTALWORK WHEN 0 THEN decode(sl.SOFAR, 0, 1, sl.SOFAR) ELSE sl.TOTALWORK END) * 10), '*') prc,
       --round((sl.SOFAR/sl.TOTALWORK) * 100) pc,
       time_remaining,
       elapsed_seconds,                
       sl.MESSAGE,
       sl.START_TIME,
       sl.SID
       ,sl.TARGET,sl.SQL_PLAN_OPERATION, sl.SQL_PLAN_LINE_ID
  FROM v$session_longops sl
inner join v$session s ON sl.SID = s.SID AND sl.SERIAL# = s.SERIAL#
order by osuser, sl.START_TIME desc

