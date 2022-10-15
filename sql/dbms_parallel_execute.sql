declare
  l_sql_stmt VARCHAR2(32767);
begin
  begin
  dbms_parallel_execute.drop_task (task_name => 'BKI_STEP0');
  exception when others then null;
  end;
  DBMS_PARALLEL_EXECUTE.create_task (task_name => 'BKI_STEP0');
  DBMS_PARALLEL_EXECUTE.create_chunks_by_number_col(task_name    => 'BKI_STEP0',
                                                    table_owner  => 'DW',
                                                    table_name   => 'V_NBKI_TTT_STEP0_SKB',
                                                    table_column => 'N30AGID',
                                                    chunk_size   => 10000);
 

  l_sql_stmt := '
begin
insert into t_nbki_ttt_step0
SELECT *
FROM   TABLE(dw.pkg_nbki.f_table_nbki_ttt_step0(CURSOR
        (select * FROM  dw.v_nbki_ttt_step0_skb t1 WHERE N30AGID BETWEEN :start_id AND :end_id ), 
        to_date(''28.03.2022'',''dd.mm.yyyy''))) t2;
exception when others then null;
end;';

  DBMS_PARALLEL_EXECUTE.run_task(task_name      => 'BKI_STEP0',
                                 sql_stmt       => l_sql_stmt,
                                 language_flag  => DBMS_SQL.NATIVE,
                                 parallel_level => 20); 
END;
