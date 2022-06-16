/*
 * create xml
 */
  select
  xmlelement( "dueArrear",
  xmlforest( '01.01.2020' as "startDate",
             '1' as "lastPaymentInd" ,
             '9000,20' as "amount" ,
             '9000,00' as "principalAmount" ,
             '0,20' as "interestAmount" ,
             '0,00' as "otherAmount" ,
             '01.06.2022' as "date"            
            )
  )
  "dueArrear"
  from dual;
