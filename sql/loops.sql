/*
 * loops
 */
 
-- 1 row fetch 
declare
    cursor cur_dum is 
        select name,class,enroll_id from table_student;
    rec_dum cur_dum%rowtype;
begin
    open cur_dum;
    loop
        fetch cur_dum into rec_dum;
        exit when cur_dum%notfound;
        update table_log 
        set statement = rec_dum.name || '-'||'-'||to_char(rec_dum.enroll_id)
        where roll_id = rec_dum.enroll_id;
    end loop;
    close cur_dum;
end; 

-- without cursor definition
begin
    for rec_dum in (select name,class,enroll_id from table_student)
    loop
        update table_log 
        set statement = rec_dum.name || '-'||'-'||to_char(rec_dum.enroll_id)
        where roll_id = rec_dum.enroll_id;
    end loop;
end;

-- bulk collect

<< batch_loop >>
loop
    fetch dum_cur bulk collect into dum_recs limit 1000;
    exit when dum_recs.count() = 0;
    << row_loop >>
    for idx in dum_recs.first()..dum_recs.last() 
    loop
        do_something(dum_recs(idx));
    end loop row_loop;
end loop batch_loop;


