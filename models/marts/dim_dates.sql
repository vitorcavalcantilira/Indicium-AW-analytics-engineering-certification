with
    int_dates as (
        select *
        from {{ ref('int_dates_preparacao') }}
    )

select *
from int_dates