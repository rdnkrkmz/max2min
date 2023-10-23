EXTENSION = max2min
DATA = max2min--1.0.sql
REGRESS = max2min-test max2min-test1 max2min-test2 max2min-test3 max2min-test4 max2min-test5 max2min-test6

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
