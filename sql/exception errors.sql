declare 
v number;
l_error varchar2(1000);
begin
  select 1 into v from dual where 1=0;
  EXCEPTION
  WHEN OTHERS THEN
      l_error := '[' || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace || ']';
      dbms_output.put_line('ERROR :: ' || l_error);
      raise_application_error(-20001, l_error);
end;
