DECLARE
    TYPE t_tab IS TABLE OF date;
    l_tab1 t_tab := t_tab('01.01.2022', '01.02.2022', '02.01.2022', '01.01.2022', '01.01.2022', '01.01.2022');
  BEGIN
    l_tab1 := l_tab1 MULTISET INTERSECT DISTINCT l_tab1;
    FOR i IN l_tab1.first .. l_tab1.last
    loop
      l_tab1.extend;
      DBMS_OUTPUT.put_line('Distinct values are '||l_tab1(i));
    END LOOP;
    FOR i IN l_tab1.first .. l_tab1.last
    loop
      l_tab1.extend;
      DBMS_OUTPUT.put_line('Distinct values are '||l_tab1(i));
    END LOOP;
  END;
  
  
  select CREDIT_ID from dw.t_nbki_ttt_individual_credits
