
create or replace  function f_get_CLIENT_SURNAME_HISTORY(client_h_hid in raw, bank_id number) return client_s_typeset PIPELINED is
    v_attr_code varchar2(100) := 'CLIENT_SURNAME';
    cursor cur (v_client_h_hid raw, v_attr_code varchar2, v_bank_id number) is 

            select 
            distinct 
            CLIENT_H.HID client_h_hid,
            sysdate create_date,
            trunc(min(M10CHDT) over(partition by m10obid,N31NAMF order by M10HTID), 'DD') write_date,
            v_attr_code attr_code,
            N31NAMF attr_value
            from
            h_n31@card_rez
            join m10@card_rez
              on m10htid = h_n31.n31htid
              and m10obtp = 8
            join BCH_DATA.CLIENT_H
              on m10obid = CLIENT_H.client_id
              and CLIENT_H.HID = v_client_h_hid
              and bank_id = v_bank_id
              and v_bank_id = 0
            union all  
            select 
            distinct 
            CLIENT_H.HID client_h_hid,
            sysdate createdate,
            trunc(min(M10CHDT) over(partition by m10obid,N31NAMF order by M10HTID), 'DD') write_date,
            v_attr_code attr_code,
            N31NAMF attr_value
            from
            h_n31@card_rez
            join m10@gcard_rez
              on m10htid = h_n31.n31htid
              and m10obtp = 8
            join BCH_DATA.CLIENT_H
              on m10obid = CLIENT_H.client_id
              and CLIENT_H.HID = v_client_h_hid
              and bank_id = v_bank_id
              and v_bank_id = 1;

    retval client_s_type := client_s_type(NULL, NULL, NULL, NULL, NULL);
    l_row_from_query cur%ROWTYPE;
  begin    
    open cur(client_h_hid, v_attr_code, bank_id);
    loop
      FETCH cur into l_row_from_query;
      EXIT WHEN cur%NOTFOUND;
      retval := client_s_type(l_row_from_query.client_h_hid, l_row_from_query.create_date, l_row_from_query.write_date,
                              l_row_from_query.attr_code, l_row_from_query.attr_value
                             );
      PIPE ROW (retval);
    end loop;
    close cur;

  end f_get_CLIENT_SURNAME_HISTORY;
