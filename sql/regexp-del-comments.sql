/*
 * to replace comments from sql
 */
select regexp_replace(str, '(\/\*[^\*\/]*\*\/)') from (
select 'select /*+ parallel (4)*/ a from dw.table a /* dDdrdfdfd */ sdsdsdsdsd /* sssss fdgdfgfdgfdg fdgdfgdfgdfg */ ddfdf  dfd' str from dual
);
