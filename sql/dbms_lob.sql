declare
    l_clob clob;
    --  4000 characters is the limit for RPAD in SQL 
    l_str  varchar2 (32767);
    n number;
begin
    l_str := rpad ('string chunk to be inserted (maximum 32767) characters at a time',32767,'+');
    dbms_lob.createtemporary ( lob_loc => l_clob, cache => true );
    dbms_lob.open(l_clob, dbms_lob.lob_readwrite);    
    
    << recordz >>
    for i in 1..2 loop 
        << appendz >>
        for j in 1..10 loop 
            dbms_lob.append (l_clob, l_str);
            -- dbms_lob.writeappend(l_clob, length(cur_lob), cur_lob);
        end loop appendz; 
        insert into qon  
            values (i, l_clob, dbms_lob.getlength(l_clob))
            returning qon.len into n;
        dbms_output.put_line('#'||i||' length of clob = '||n);
     end loop recordz; 
     dbms_lob.close(l_clob);
     dbms_lob.freetemporary (l_clob);
end;
