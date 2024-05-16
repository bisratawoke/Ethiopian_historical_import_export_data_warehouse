with time_range as (
    select generate_series(
        date '2009-01-01',
        date '2016-12-30',
        INTERVAL '1 month'
    ) as date
)

select 
    to_char(date,'YYYY') as year,
    to_char(date, 'Month') as month,
    extract(year from date ) as numeric_year,
    extract(month from date ) as numeric_month
from time_range