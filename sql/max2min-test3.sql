-- 3. case: char, varchar, text
select max_to_min(val, ' => ') from (values('a'),('b'),('c'),('d'),('e'),('f'), (null),('g')) t(val);
