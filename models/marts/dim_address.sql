with
    int_address as (
        select *
        from {{ ref('int_address_enriquecida') }}
    )

select *
from int_address