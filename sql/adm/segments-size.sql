select 
segment_name,
sum(bytes/1024/1024) Mb 
from 
dba_extents e
where e.owner = 'DWH'
group by segment_name

