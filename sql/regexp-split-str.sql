/*
 * to split string at delimiter
 */
SELECT regexp_substr(str, '[^;]+', 1, level) str
  FROM (
        SELECT ' 1; 2; test1.' str FROM dual     ) t
  CONNECT BY regexp_substr(str, '[^;]+', 1, level) is not null
