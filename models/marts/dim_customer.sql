with
    int_customer as (
        select *
        from {{ ref('int_customer_enriquecida') }}
    )

select *
from int_customer