with
    int_order_enriquecida as (
        select *
        from {{ ref('int_order_enriquecida') }}
    )

select *
from int_order_enriquecida