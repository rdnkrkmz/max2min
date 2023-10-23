-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION max2min" to load this file. \quit

-- defining 4 type we can support aggregation of 
	-- numeric, integer, float
	-- char, varchar, text
	-- date, time, timestamp
---------------------------------- supported types ----------------------------------
-- hold max, min and delimiter for range of data types	
create type max_min_numeric as (nmax numeric, nmin numeric, delim text);
create type max_min_numeric_def_delim as (nmax numeric, nmin numeric);
create type max_min_varchar as (nmax text, nmin text, delim text);
create type max_min_varchar_def_delim as (nmax text, nmin text);
create type max_min_timestampwtz as (nmax timestamp with time zone, nmin timestamp with time zone, delim text);
create type max_min_timestampwtz_def_delim as (nmax timestamp with time zone, nmin timestamp with time zone);
create type max_min_timestampwotz as (nmax timestamp without time zone, nmin timestamp without time zone, delim text);
create type max_min_timestampwotz_def_delim as (nmax timestamp without time zone, nmin timestamp without time zone);



---------------------------------- state functions ----------------------------------

create or replace function agg_max_min_accum(s max_min_numeric, val numeric, delim text) returns max_min_numeric as 
$$
/*********************************************************************

   20/10/2023   ridonekorkmaz   it is used for max_to_min aggregate 
                                for types of numeric, integer, float
   
**********************************************************************/
select (
	case
		when val is null then (s).nmax -- we cant set initcond, and we cant make function strict, we handle nulls by ourselves.
		when (s).nmax > val then (s).nmax -- if next value is greater, so then we return this else, value itself
	else val end,
	case
		when val is null then (s).nmin -- same for max
		when (s).nmin < val then (s).nmin -- same for max
	else val
	end, delim) ::max_min_numeric;

$$ language sql immutable;

create or replace function agg_max_min_accum(s max_min_numeric_def_delim, val numeric) returns max_min_numeric_def_delim as 
$$
/*********************************************************************

   20/10/2023   ridonekorkmaz   it is used for max_to_min aggregate 
                                for types of numeric, integer, float
   
**********************************************************************/
select (
	case
		when val is null then (s).nmax -- we cant set initcond, and we cant make function strict, we handle nulls by ourselves.
		when (s).nmax > val then (s).nmax -- if next value is greater, so then we return this else, value itself
	else val end,
	case
		when val is null then (s).nmin -- same for max
		when (s).nmin < val then (s).nmin -- same for max
	else val
	end) ::max_min_numeric_def_delim;

$$ language sql immutable;

----------------

create or replace function agg_max_min_accum(s max_min_varchar, val text, delim text) returns max_min_varchar as 
$$
/*********************************************************************

   20/10/2023   ridonekorkmaz   it is used for max_to_min aggregate 
                                for types of char, varchar, text
   
**********************************************************************/
select (
	case
		when val is null then (s).nmax -- we cant set initcond, and we cant make function strict, we handle nulls by ourselves.
		when (s).nmax > val then (s).nmax -- if next value is greater, so then we return this else, value itself
	else val end,
	case
		when val is null then (s).nmin -- same for max
		when (s).nmin < val then (s).nmin -- same for max
	else val
	end, delim) ::max_min_varchar;

$$ language sql immutable;


create or replace function agg_max_min_accum(s max_min_varchar_def_delim, val text) returns max_min_varchar_def_delim as 
$$
/*********************************************************************

   20/10/2023   ridonekorkmaz   it is used for max_to_min aggregate 
                                for types of char, varchar, text
   
**********************************************************************/
select (
	case
		when val is null then (s).nmax -- we cant set initcond, and we cant make function strict, we handle nulls by ourselves.
		when (s).nmax > val then (s).nmax -- if next value is greater, so then we return this else, value itself
	else val end,
	case
		when val is null then (s).nmin -- same for max
		when (s).nmin < val then (s).nmin -- same for max
	else val
	end) ::max_min_varchar_def_delim;

$$ language sql immutable;

---------------- 


create or replace function agg_max_min_accum(s max_min_timestampwtz, val  timestamp with time zone, delim text) returns max_min_timestampwtz as 
$$
/*********************************************************************

   20/10/2023   ridonekorkmaz   it is used for max_to_min aggregate 
                                for types of date, time, timestamp with time zone
   
**********************************************************************/
select (
	case
		when val is null then (s).nmax -- we cant set initcond, and we cant make function strict, we handle nulls by ourselves.
		when (s).nmax > val then (s).nmax -- if next value is greater, so then we return this else, value itself
	else val end,
	case
		when val is null then (s).nmin -- same for max
		when (s).nmin < val then (s).nmin -- same for max
	else val
	end, delim) ::max_min_timestampwtz;

$$ language sql immutable;


create or replace function agg_max_min_accum(s max_min_timestampwtz_def_delim, val  timestamp with time zone) returns max_min_timestampwtz_def_delim as 
$$
/*********************************************************************

   20/10/2023   ridonekorkmaz   it is used for max_to_min aggregate 
                                for types of date, time, timestamp with time zone
   
**********************************************************************/
select (
	case
		when val is null then (s).nmax -- we cant set initcond, and we cant make function strict, we handle nulls by ourselves.
		when (s).nmax > val then (s).nmax -- if next value is greater, so then we return this else, value itself
	else val end,
	case
		when val is null then (s).nmin -- same for max
		when (s).nmin < val then (s).nmin -- same for max
	else val
	end) ::max_min_timestampwtz_def_delim;

$$ language sql immutable;

---------------- 


create or replace function agg_max_min_accum(s max_min_timestampwotz, val  timestamp without time zone, delim text) returns max_min_timestampwotz as 
$$
/**************************************************************************************

   20/10/2023   ridonekorkmaz   it is used for max_to_min aggregate 
                                for types of date, time, timestamp without time zone
   
**************************************************************************************/
select (
	case
		when val is null then (s).nmax -- we cant set initcond, and we cant make function strict, we handle nulls by ourselves.
		when (s).nmax > val then (s).nmax -- if next value is greater, so then we return this else, value itself
	else val end,
	case
		when val is null then (s).nmin -- same for max
		when (s).nmin < val then (s).nmin -- same for max
	else val
	end, delim) ::max_min_timestampwotz;

$$ language sql immutable;

create or replace function agg_max_min_accum(s max_min_timestampwotz_def_delim, val  timestamp without time zone) returns max_min_timestampwotz_def_delim as 
$$
/**************************************************************************************

   20/10/2023   ridonekorkmaz   it is used for max_to_min aggregate 
                                for types of date, time, timestamp without time zone
   
**************************************************************************************/
select (
	case
		when val is null then (s).nmax -- we cant set initcond, and we cant make function strict, we handle nulls by ourselves.
		when (s).nmax > val then (s).nmax -- if next value is greater, so then we return this else, value itself
	else val end,
	case
		when val is null then (s).nmin -- same for max
		when (s).nmin < val then (s).nmin -- same for max
	else val
	end) ::max_min_timestampwotz_def_delim;

$$ language sql immutable;



---------------------------------- final state functions ----------------------------------

create or replace function agg_max_min_final(s max_min_numeric) returns text as
/**************************************************************************************************

   20/10/2023   ridonekorkmaz   this is used to format output. for types of numeric, integer, float
   
***************************************************************************************************/
$$
   select (s).nmax || (s).delim || (s).nmin;
$$ language sql immutable;

create or replace function agg_max_min_final(s max_min_numeric_def_delim) returns text as
/**************************************************************************************************

   20/10/2023   ridonekorkmaz   this is used to format output. for types of numeric, integer, float
   
***************************************************************************************************/
$$
   select (s).nmax || ' => ' || (s).nmin;
$$ language sql immutable;

----------------

create or replace function agg_max_min_final(s max_min_varchar) returns text as
/************************************************************************************************

   20/10/2023   ridonekorkmaz   this is used to format output. for types of char, varchar, text
   
*************************************************************************************************/
$$
   select (s).nmax || (s).delim || (s).nmin;
$$ language sql immutable;

create or replace function agg_max_min_final(s max_min_varchar_def_delim) returns text as
/************************************************************************************************

   20/10/2023   ridonekorkmaz   this is used to format output. for types of char, varchar, text
   
*************************************************************************************************/
$$
   select (s).nmax || ' => ' || (s).nmin;
$$ language sql immutable;

----------------

create or replace function agg_max_min_final(s max_min_timestampwtz) returns text as
/*****************************************************************************************************************

   20/10/2023   ridonekorkmaz   this is used to format output. for types of date, time, timestamp with time zone
   
******************************************************************************************************************/
$$
   select (s).nmax || (s).delim || (s).nmin;
$$ language sql immutable;

create or replace function agg_max_min_final(s max_min_timestampwtz_def_delim) returns text as
/*****************************************************************************************************************

   20/10/2023   ridonekorkmaz   this is used to format output. for types of date, time, timestamp with time zone
   
******************************************************************************************************************/
$$
   select (s).nmax || ' => ' || (s).nmin;
$$ language sql immutable;

----------------

create or replace function agg_max_min_final(s max_min_timestampwotz) returns text as
/********************************************************************************************************************

   20/10/2023   ridonekorkmaz   this is used to format output. for types of date, time, timestamp without time zone
   
********************************************************************************************************************/
$$
   select (s).nmax || (s).delim || (s).nmin;
$$ language sql immutable;

create or replace function agg_max_min_final(s max_min_timestampwotz_def_delim) returns text as
/********************************************************************************************************************

   20/10/2023   ridonekorkmaz   this is used to format output. for types of date, time, timestamp without time zone
   
********************************************************************************************************************/
$$
   select (s).nmax || ' => ' || (s).nmin;
$$ language sql immutable;




---------------------------------- create aggregate ----------------------------------
-- note: nature of min-max, we can not set initcond for aggregate

create aggregate max_to_min (numeric, text)
(
    sfunc = agg_max_min_accum,
    stype = max_min_numeric,
    finalfunc = agg_max_min_final
);

create aggregate max_to_min (numeric)
(
    sfunc = agg_max_min_accum,
    stype = max_min_numeric_def_delim,
    finalfunc = agg_max_min_final
);

----------------

create aggregate max_to_min (text, text)
(
    sfunc = agg_max_min_accum,
    stype = max_min_varchar,
    finalfunc = agg_max_min_final
);

create aggregate max_to_min (text)
(
    sfunc = agg_max_min_accum,
    stype = max_min_varchar_def_delim,
    finalfunc = agg_max_min_final
);

----------------

create aggregate max_to_min (timestamp with time zone, text)
(
    sfunc = agg_max_min_accum,
    stype = max_min_timestampwtz,
    finalfunc = agg_max_min_final
);


create aggregate max_to_min (timestamp with time zone)
(
    sfunc = agg_max_min_accum,
    stype = max_min_timestampwtz_def_delim,
    finalfunc = agg_max_min_final
);

----------------

create aggregate max_to_min (timestamp without time zone, text)
(
    sfunc = agg_max_min_accum,
    stype = max_min_timestampwotz,
    finalfunc = agg_max_min_final
);

create aggregate max_to_min (timestamp without time zone)
(
    sfunc = agg_max_min_accum,
    stype = max_min_timestampwotz_def_delim,
    finalfunc = agg_max_min_final
);

