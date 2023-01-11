-- создаем таблицу со сжатыми разделами
create table stage.tmp_part (
tmp varchar2(1000),
as_of_date date
)
PARTITION BY RANGE (as_of_date)
 ( PARTITION sales_q1_2019 VALUES LESS THAN (TO_DATE('01-01-2019','dd-MM-yyyy')) compress FOR DIRECT_LOAD OPERATIONS
 , PARTITION sales_q2_2019 VALUES LESS THAN (TO_DATE('01-04-2019','dd-MM-yyyy')) compress FOR DIRECT_LOAD OPERATIONS
 , PARTITION sales_q3_2019 VALUES LESS THAN (TO_DATE('01-10-2019','dd-MM-yyyy')) compress FOR DIRECT_LOAD OPERATIONS
 )
compress FOR DIRECT_LOAD OPERATIONS
 ;

-- дополнительно пробуем наложить compress на таблицу
alter table stage.tmp_part compress FOR DIRECT_LOAD OPERATIONS;

-- видим что на таблице флажков нет
select 
table_name,
COMPRESSION, 
COMPRESS_FOR
from dba_tables
where table_name = 'TMP_PART'
;

-- добавляем раздел с компрессией
alter table stage.tmp_part add partition sales_q4_2019 VALUES LESS THAN (TO_DATE('01-01-2020','dd-MM-yyyy')) compress FOR ALL OPERATIONS;

-- видим на всех разделах сжатие
select 
TABLE_NAME,
PARTITION_NAME,
COMPRESSION, 
COMPRESS_FOR
from dba_tab_partitions
where table_name = 'TMP_PART'
;
-- добавляем раздел без указания компрессии
alter table stage.tmp_part add partition sales_q4_2020 VALUES LESS THAN (TO_DATE('01-01-2021','dd-MM-yyyy')) ;

-- видим на всех разделах сжатие
select 
TABLE_NAME,
PARTITION_NAME,
COMPRESSION, 
COMPRESS_FOR
from dba_tab_partitions
where table_name = 'TMP_PART'
;

drop table stage.tmp_part;

