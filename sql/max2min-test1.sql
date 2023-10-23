-- 1. case: task's required case, without explicit delimiter
select max_to_min(val) from (values(5),(3),(6),(7),(9),(10),(7)) t(val);

-- 1.1. case: task's required case, with explicit delimiter
select max_to_min(val, ' =8> ') from (values(5),(3),(6),(7),(9),(10),(7)) t(val);
