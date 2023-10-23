# PostgreSQL Custom Aggregate
This is a custom aggregate extension for PostgreSQL

### 
This is an aggregate that returns a text formatted like: max -> min for an integer column, where min and max are minimum and maximum values of tha
t column.

### Installation
git clone https://github.com/rdnkrkmz/postgres_aggregate.git
cd postgres_aggregate
make installcheck


### Supported data types
- numeric, integer, float
- char, varchar, text
- date, time, timestamp
