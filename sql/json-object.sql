/*
 * create json object
 */
  select
  json_object('eventDate' VALUE case when '' is null then null else to_char(sysdate,'dd.mm.yyyy') end,
              'accountNum' VALUE '999999',
              'applicationNum' VALUE '100001',
              'comment' VALUE 'comment_'
              FORMAT JSON ABSENT ON NULL)
  from dual;
