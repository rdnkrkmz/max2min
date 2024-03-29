# PostgreSQL Custom Aggregate
This is a custom aggregate extension for PostgreSQL <br><br>
![example workflow](https://github.com/rdnkrkmz/max2min/actions/workflows/makefile.yml/badge.svg)

## 
The aggregate function returns a text formatted like: **max -> min** for an integer column, where min and max are minimum and maximum values of that column. 
Extension handles ```null``` values in rowset.

## Installation
```
git clone https://github.com/rdnkrkmz/max2min.git
cd max2min
make install
make installcheck
```
## Supported data types
```
numeric, integer, float
char, varchar, text
date, time, timestamp
```

## Examples
#### without delimiter
```
select max_to_min(val) from (values(5),(3),(6),(7),(9),(10),(7)) t(val);
 max_to_min 
------------
 10 => 3
```
#### custom delimiter
```
select max_to_min(val, ' ==>> ') from (values(5),(3),(6),(7),(9),(10),(7)) t(val);
 max_to_min 
------------
 10 ==>> 3
```
#### numeric, integer, float
```
select max_to_min(val, ' => ') from (values(5.0),(-6.9),(6),(7),(99.9),(11), (null),(7)) t(val);
  max_to_min  
--------------
 99.9 => -6.9
```
#### char, varchar, text
```
select max_to_min(val, ' => ') from (values('a'),('b'),('c'),('d'),('e'),('f'), (null),('g')) t(val);
 max_to_min 
------------
 g => a
```
#### timestamp with time zone
```
select max_to_min(val, ' => ') from (
    values
    (to_timestamp('2023-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp with time zone),
    (to_timestamp('2022-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp with time zone),
    (to_timestamp('2021-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp with time zone),
    (to_timestamp('2020-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp with time zone),
    (to_timestamp('2019-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp with time zone),
    (to_timestamp('2018-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp with time zone),
    (null),
    (to_timestamp('2017-10-20 10:11:00', 'yyyy-mm-dd hh24:mi:ss')::timestamp with time zone)
) t(val);
                          max_to_min                          
--------------------------------------------------------------
 Fri Oct 20 10:11:00 2023 PDT => Fri Oct 20 10:11:00 2017 PDT
```
#### timestamp without time zone
```
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
                      max_to_min                      
------------------------------------------------------
 Fri Oct 20 10:11:00 2023 => Fri Oct 20 10:11:00 2017
```
#### date
```
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
                          max_to_min                          
--------------------------------------------------------------
 Fri Oct 20 00:00:00 2023 PDT => Fri Oct 20 00:00:00 2017 PDT
```
