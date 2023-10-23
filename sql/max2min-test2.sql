-- 2. case: numeric, integer, float types and some rows are null
select max_to_min(val, ' => ') from (values(5.0),(-6.9),(6),(7),(99.9),(11), (null),(7)) t(val);
