-- 6. case: date
select max_to_min(val, ' => ') from (
    values
    (to_timestamp('2023-10-20', 'yyyy-mm-dd')),
    (to_timestamp('2022-10-20', 'yyyy-mm-dd')),
    (to_timestamp('2021-10-20', 'yyyy-mm-dd')),
    (to_timestamp('2020-10-20', 'yyyy-mm-dd')),
    (to_timestamp('2019-10-20', 'yyyy-mm-dd')),
    (to_timestamp('2018-10-20', 'yyyy-mm-dd')),
    (null),
    (to_timestamp('2017-10-20', 'yyyy-mm-dd'))
) t(val);
