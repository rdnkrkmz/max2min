-- 5. case: timestamp without time zone
select max_to_min(val, ' => ') from (
    values
    (to_timestamp('2023-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp without time zone),
    (to_timestamp('2022-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp without time zone),
    (to_timestamp('2021-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp without time zone),
    (to_timestamp('2020-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp without time zone),
    (to_timestamp('2019-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp without time zone),
    (to_timestamp('2018-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp without time zone),
    (null),
    (to_timestamp('2017-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp without time zone)
) t(val);
